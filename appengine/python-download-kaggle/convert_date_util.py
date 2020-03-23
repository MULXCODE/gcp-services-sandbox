import datetime
from dateutil.parser import parse

# convert a isoformat date to MM/DD/YYYY HH:MM:SS
def convert_to_mmddyyyy_hhmmss(isoformat_date_string):
    datetime_object = parse(isoformat_date_string)
    result = datetime_object.strftime("%-m/%-d/%Y %H:%M:%S")
    return result
