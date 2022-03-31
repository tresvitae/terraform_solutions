## Learn Terraform State Management

This is a companion repository to the Terraform State Management tutorial. Follow along on [Learn](https://learn.hashicorp.com/tutorials/terraform/state-cli?in=terraform/state)


`terraform apply -replace="aws_security_group.sg_8080"` (outdated `terraform taint`)

cp terraform.tfvars new_state/


## Enable Terraform logging

export TF_LOG_CORE=TRACE

TRACE provides the highest level of logging and contains all the information the development teams need. There are other logging levels, but are typically reserved for developers looking for specific information.

export TF_LOG_PROVIDER=TRACE

TF_LOG_PROVIDER set, the provider development team can reproduce and debug provider specific errors

export TF_LOG_PATH=logs.txt
terraform refresh


To remove a log stream, unset the environment variable you do not need.
export TF_LOG_CORE=



## Learn Terraform Import

Learn what Terraform import is and how to use it.

Follow along with the [Learn Guide](https://learn.hashicorp.com/terraform/state/import) at
HashiCorp Learn.


docker inspect --format="{{.ID}}" hashicorp-learn returns the full SHA256 container ID
terraform import docker_container.web $(docker inspect --format="{{.ID}}" hashicorp-learn)

terraform show

This state contains everything that Terraform knows about the docker container you just imported. However, Terraform import does not create the configuration for the resource.

terraform plan

2 approaches to update the configuration:
* Using the `current state` is often faster, but can result in an overly verbose configuration since every attribute is included in the state, whether it is necessary to include in your configuration or not.
```bash
terraform show -no-color > docker.tf
# do changes until update in-place the resources 
terraform plan
```

* `Cherry-picking` the required attributes can lead to more manageable configuration, but requires you to understand which attributes need to be set in the configuration.
```bash

```