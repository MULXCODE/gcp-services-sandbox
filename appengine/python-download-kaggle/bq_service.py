from os import listdir
from os.path import isfile, join
from google.cloud import bigquery
import string
import random
import time


def get_datestr_yyyymmdd():
    return time.strftime('%Y%m%d')


def generate_random_char(len):
    lst = [random.choice(string.ascii_letters + string.digits)
           for n in xrange(30)]
    str = "".join(lst)
    return str


def upload_to_bq():
    client = bigquery.Client()

    folder = 'data'
    # filename = 'data/time_series_covid_19_confirmed.csv'
    dataset_id = 'coronavirus_dataset_' + get_datestr_yyyymmdd() + '_' + generate_random_char(2)
    full_dataset_id = '{}.{}'.format('elevated-watch-270607', dataset_id)
    dataset = bigquery.Dataset(full_dataset_id)
    dataset.location = 'US'
    try:
        dataset = client.create_dataset(dataset)
    except Exception as e:
        print(e)

    files = [f for f in listdir(folder) if isfile(join(folder, f))]
    for file in files:
        print(file)

    dataset_ref = client.dataset(dataset_id)
    job_config = bigquery.LoadJobConfig()
    job_config.source_format = bigquery.SourceFormat.CSV
    job_config.skip_leading_rows = 1
    job_config.autodetect = True

    for file in files:
        file_path = folder + '/' + file

        table_id = file.replace('.csv', '').lower()
        table_ref = dataset_ref.table(table_id)

        print('pre-results : ' + file_path)
        try:
            with open(file_path, 'rb') as source_file:
                job = client.load_table_from_file(
                    source_file, table_ref, job_config=job_config)

            job.result()  # Waits for table load to complete.

            print('Loaded {} rows into {}:{}.'.format(
                job.output_rows, dataset_id, table_id))
        except Exception as e:
            print('An exception occurred')
            print(e)
