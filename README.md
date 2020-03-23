# GCP Services Sandbox

A set of various GCP examples that can be used as reference.

## Getting Started

Create a source.env file from source-sample.env.  `source.env` is git ignored.  At a minimum replace `my-project-id` with your PROJECT_ID and replace any other necessary export variables.

```bash
sed 's/my-project-id/[YOUR-PROJECT-ID-HERE]/g' source-sample.env > source.env

source source.env

echo $PROJECT_ID # testing to ensure the sourced var is set
```

## Git Secrets

* [Reference](https://github.com/awslabs/git-secrets#installing-git-secrets)

```bash
brew install git-secrets
git secrets --install

git secrets --add 'private_ke' #y
git secrets --add 'private_key_i' #d
```

## Contributing

* Naming Convention of Sub Folders: [prog_language?]-[function|feature]

