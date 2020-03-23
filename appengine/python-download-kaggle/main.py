import os
import subprocess
from flask import Flask, render_template
from bq_service import upload_to_bq

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/graph')
def graph():
    return render_template('embed.html')


@app.route('/download-kaggle')
def download_kaggle():
    # kaggle datasets download -d sudalairajkumar/novel-corona-virus-2019-dataset
    proc1 = subprocess.Popen(['kaggle', 'datasets', 'download', '-d',
                              'sudalairajkumar/novel-corona-virus-2019-dataset', '--force'])
    proc1.wait()
    proc2 = subprocess.Popen(
        ['unzip', '-o', '-q', 'novel-corona-virus-2019-dataset.zip', '-d', 'data'])
    proc2.wait()

    upload_to_bq()

    proc3 = subprocess.Popen(['rm', '-rf', 'data/'])
    proc3.wait()
    proc4 = subprocess.Popen(['rm', 'novel-corona-virus-2019-dataset.zip'])
    proc4.wait()

    print('Successful ETL')

    return 'Success'


@app.route('/env')
def get_env():
    return str(os.environ)


if __name__ == '__main__':
    print('Starting')
    print(os.environ['PORT'])
    app.run(host='0.0.0.0')
