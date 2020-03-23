# convert a isoformat date to MM/DD/YYYY HH:MM:SS

import csv
from date_utils import convert_to_mmddyyyy_hhmmss

isoformat_date_string = '2020-02-02T23:43:02'
result = convert_to_mmddyyyy_hhmmss(isoformat_date_string)

print(result)

with open('data/covid_19_data.csv', 'r', newline='') as file:
    csv_row = csv.reader(file, delimiter=',')
    print(csv_row)
    for row in csv_row:
        # print(type(row))
        # print(row)

        DATE_INDEX = 4
        try:
            # print(row[DATE_INDEX])
            # print('     ' + convert_to_mmddyyyy_hhmmss(row[DATE_INDEX]))
            row[DATE_INDEX] = convert_to_mmddyyyy_hhmmss(row[DATE_INDEX])
            print(','.join(row))
        except Exception as e:
            print('Exception has occurred: ' + str(e))
            