# ECS with ELB using community modules.
### Docker image is from own repository.

1. Create AWS Certificate Maanager with Route53 Hosted Zones in, wiat until its will be created.
2. Then set values for 'application_name' 'application_port' 'application_version' from you ECR.
3. Then apply the infrastructure with changed values of 'domain' and 'condition_values'.
` terraform apply -auto-approve `