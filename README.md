# GCP Services Sandbox

A set of various GCP examples.  

## Getting Started

Create a source.env file from source-sample.env.  `source.env` is git ignored.  At a minimum replace `my-project-id` with your PROJECT_ID and replace any other necessary export variables.

```bash
sed 's/my-project-id/[YOUR-PROJECT-ID-HERE]/g' source-sample.env > source.env

source source.env

echo $PROJECT_ID # testing to ensure the sourced var is set
```

