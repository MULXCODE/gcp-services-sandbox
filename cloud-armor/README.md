# Cloud Armor

Google Cloud Armor delivers defense at scale against infrastructure and application distributed denial of service (DDoS) attacks by using Google's global infrastructure and security systems.

## Getting Started

```bash
kubectl aapply -f deployment.yaml
kubectl aapply -f service.yaml
kubectl aapply -f backend-config.yaml

./create_security_policy.sh
```

## References

* [References](https://cloud.google.com/armor/docs)