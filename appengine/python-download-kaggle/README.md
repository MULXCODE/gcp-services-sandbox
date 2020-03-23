# Python Download Kaggle

This solution contains guidance for syncing data from the kaggle COVID-19 public dataset into BigQuery.

This solution has 3 parallel deployment pipelines:

1. Local
2. Docker
3. App Engine Flex

## Prerequisites

* python (tested on v3.7.4)
* gcloud sdk (tested on v280.0.0)
* docker (tested on v19.03.8)

## Getting Started

1. Set environment variable configurations

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

2. Create App Engine Flex Config

```bash
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

## Local Build & Docker

```bash
pip install virtualenv
virtualenv env
source env/bin/activate ### deactivate when finished
pip install -r requirements.txt

gunicorn -b :8080 --keep-alive=600 main:app

# test via HTTP get to localhost:8080/download-kaggle
open localhost:8080/download-kaggle
````

## Docker - Build

```bash
docker build . -t gcr.io/elevated-watch-270607/download-kaggle
docker run -d -p 8081:8080 --env-file env.list gcr.io/elevated-watch-270607/download-kaggle

# test via HTTP get to localhost:8080/download-kaggle
open localhost:8080/download-kaggle
```

## App Engine Flex

```bash
# one time only; you need to run `gcloud app create`
gcloud app deploy --quiet
```

## Developing and Lint

* PyLint (.pylintrc defines rules)

    ```bash
    pylint --load-plugins pylint_quotes *.py
    ```

## Admin Commands and References

* Docker - exec into container

```bash
docker exec -it $CONTAINER_ID /bin/bash
```

* Kaggle Flow (which is captured in code)

```bash
kaggle datasets download -d sudalairajkumar/novel-corona-virus-2019-dataset --force

unzip -o -q novel*.zip -d data/
```

