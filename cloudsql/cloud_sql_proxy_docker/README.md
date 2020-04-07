# README: cloud_sql_proxy_docker

## Getting Started

Run cloud_sql_proxy in a docker container.  

Prerequisite:
* Cloud SQL deployed with Public IP and you're running on a system with Internet Access
* OR Cloud SQL deployed with Private IP and you're running on a system with access to the Private Network

```bash
./setup.sh

./run.sh

USER="root"
mysql -u $USER -p --host 127.0.0.1
```
