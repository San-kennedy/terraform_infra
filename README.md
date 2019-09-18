# terraform_infra
Sample Infrastructure setup (AWS) through terraform

To execute, please create a file with name <strong>deploy_creds</strong> in root of the repo

```
[default]
aws_access_key_id = <access key>
aws_secret_access_key = <secret key>
```
## Terraform modules in repo

Compute       : Responsible for setting up EC2 instances
NetworkPlane  : Sets up the public and private networks in a region
Securitygroup : Responsible for setting up security group as required

## Deployment key

Running terraform apply should prompt you for public key, to setup key pair used to deploy the instances. 
Pasting the public key as is should do the trick
