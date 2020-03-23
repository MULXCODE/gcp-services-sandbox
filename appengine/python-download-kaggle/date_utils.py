import time
from dateutil.parser import parse

# convert a isoformat date to MM/DD/YYYY HH:MM:SS
def convert_to_mmddyyyy_hhmmss(isoformat_date_string):
    """Converts an isoformat date string to a mm/dd/yyyy hh:mm:ss string

    Needed so that we can convert the kaggle data isoformat 8601 date strings
    to an acceptable BigQuery timestamp format.
    An ISO8601 date string is in a format similar to 2011-10-05T14:48:00.000Z.
    Args:
        isoformat_date_string: string, 2011-10-05T14:48:00.000Z
    Returns:
        string in the format of 'mm/dd/yyyy hh:mm:ss'
    """
    datetime_object = parse(isoformat_date_string)
    result = datetime_object.strftime('%-m/%-d/%Y %H:%M:%S')
    return result

def get_datestr_yyyymmdd():
    """Gets the current date, formatted as a single string 'yyyymmdd'

    Args:
        None
    Returns:
        string in the format of 'yyyymmdd'
    """
    return time.strftime('%Y%m%d')
