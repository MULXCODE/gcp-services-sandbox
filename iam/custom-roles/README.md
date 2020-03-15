# Custom Roles

[Reference](https://cloud.google.com/iam/docs/creating-custom-roles#listing_the_roles)

```bash
title: "Custom IAM Role Viewer"
description: "View IAM roles."
stage: "ALPHA"
includedPermissions:
- iam.roles.get
- iam.roles.list
```

```bash
#!/bin/sh

PROJECT=$(gcloud config get-value project)
gcloud iam roles create custom.iamViewer --file custom-role-binding.yaml --project $PROJECT 
```

## Recommended Naming Convention

custom.[camelCasedRoleName]

The role will then be in the form of `projects/$PROJECT_ID/roles/custom.[camelCasedRoleName]


