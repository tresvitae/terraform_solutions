## ECS with ELB using community modules.
### Docker image is from own repository.

1. Create AWS Certificate Maanager with Route53 Hosted Zones in, wiat until its will be created.
2. Then set values for 'application_name' 'application_port' 'application_version' from you ECR.
3. Then apply the infrastructure with changed values of 'domain' and 'condition_values'.
` terraform apply -auto-approve `


Type of modules:
- Terraform modules from the Terraform Registry
```sh
source  = "terraform-aws-modules/vpc/aws"
version = "2.21.0
```
- Local Module
`mkdir -p modules/aws-s3-static-website-bucket`
`touch main.tf variables.tf outputs.tf`
in root main.tf:
```sh
module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"
}
variables...
```
outputs.tf (in child module) are read-only attributes.
module.<MODULE NAME>.<OUTPUT NAME>
outputs.tf (in root module) do main function.
value       = module.website_s3_bucket.name

- the Private Module Registry in GitHub
In order to publish modules to the module registry, module names must have the format terraform-<PROVIDER>-<NAME>, where <NAME> can contain extra hyphens. Modules should be versioned.
`source = "app.terraform.io/<ORGANIZATION-NAME>/terraform/<NAME>/<PROVIDER>"`
