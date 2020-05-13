# Ansible

Ansible Examples

## Getting Started

```bash

sudo apt-get install -y ansible

```

## Getting Started: Terraform and Ansible

```bash

cd terraform/
terraform init
terraform apply --auto-approve
cd ../
# may need to ssh $EXT_IP to the deployed nodes, in case ssh-copy-id was not successful.

./ansible-ping.sh
```

## Getting Started: Ansible

```bash
./ansible-copy.sh
```
