# Docker Python

## Getting Started

1. Create a BQ Dataset

    ```bash
    LOCATION="US"
    TABLE_EXPIRATION=360000
    PROJECT_ID="elevated-watch-270607"
    DATASET_NAME="coronavirus_dataset2"
    TABLE_NAME="my_table"

    # create a BQ Dataset
    bq --location=$LOCATION mk -d \
        --default_table_expiration $TABLE_EXPIRATION \
        --description "Example Dataset" \
        $PROJECT_ID:$DATASET_NAME
    ```

2. Set environment variable configurations

    ```bash
    gcloud iam service-accounts keys create sa-key.json --iam-account="$PROJECT_ID@appspot.gserviceaccount.com"

    # for testing locally.  user accounts will likely hit big query limits
    export GOOGLE_APPLICATION_CREDENTIALS="sa-key.json"

    # get your kaggle_username and kaggle_key
    cat > env.list << EOF
    KAGGLE_USERNAME=yourusername
    KAGGLE_KEY=2323232yourkey232323232
    EOF
    ```

3. Create App Engine Flex Config

````bash
# create your app eng config
cat > app.yaml << EOF
runtime: custom
env: flex
service: [SERVICE_NAME]
env_variables:
  KAGGLE_USERNAME: [KAGGLE_USER]
  KAGGLE_KEY: [KAGGLE_KEY]
network:
  name: projects/[NETWORK_PROJECT_ID]/global/networks/[NETWORK_NAME]
  subnetwork_name: [SUBNET_NAME]
    EOF
    ```

## Local - Build

```bash
pip install virtualenv
virtualenv env
source env/bin/activate
env/bin/pip install google-cloud-bigquery

gunicorn -b :8080 --keep-alive=600 main:app
````

## Docker - Build

```bash
docker build . -t gcr.io/elevated-watch-270607/download-kaggle
docker run -d -p 8081:8080 --env-file env.list gcr.io/elevated-watch-270607/download-kaggle
```

## Commands

-   Docker into container

```bash
docker exec -it $CONTAINER_ID /bin/bash
```

```bash
kaggle datasets download -d sudalairajkumar/novel-corona-virus-2019-dataset --force

unzip -o -q novel*.zip -d data/
```

## PyLint

```bash
pylint --load-plugins pylint_quotes *.py
```
