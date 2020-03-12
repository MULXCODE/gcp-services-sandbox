# Simple-ETL Solution: 

* Cloud Scheduler --> PubSub <--> (python sub.py) --> output.txt/.csv <--> ./test.py --> (example.avro) <--> ./bq_read.sh --> BigQuery

This solution uses Cloud Scheduler which can trigger an event based on a cron interval.  

The limitation with Cloud Scheduler is that it only can trigger an HTTP, AppEngine or PubSub Event, which is suitable for the majority of cases.  

For this solution, I have opted to use Cloud Scheduler to write data to a PubSub topic.  A subscriber written in Python is configured to process that data and append .CSV lines to a file - 
output.txt/.csv.  

Test.py is then used to convert the output.txt (.csv.) file to an .avro file (example.avro).  The .avro file is that leveraged in the bq_read.sh bash script, which creates the big query dataset, table, gcs bucket, copies the avro file to the GCS bucket and then loads the data into bigquery.  

## Getting Started

This ETL solution is a quick POC for getting started.  

## References

Python listen to Pubsub Topic:
* https://cloud.google.com/pubsub/docs/pull#pubsub-pull-messages-async-python

Python write to Cloud Storage:
* 

## Tests

Python Create BigQuery DataSet:
* python test.py output.txt example.avro --dialect excel


