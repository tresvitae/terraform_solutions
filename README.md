# Terraform Web App

* [EC2 Linux Ubuntu](ec2-linux/instance.tf)
* [EC2 Windows](ec2-windows/instance.tf)
* [Base Infrastructure](base-infrastructure/instance.tf)
* [Database Infrastructure](rds/rds.md)
* [IAM](iam/iam.md)
* [S3](s3/s3.md)


terraform:
apply/destroy
fmt - rewrite terraform configuration files to a canonical format and style
get - download and update modules
graph - visual representation ` terraform graph | dot -Tsvg > graph.svg `
import [options] ADDRESS ID - try and find the infrastructure resource identified with ID and import the state into terraform.tfstate with resource id ADDRESS. Or recreate terraform.tfstate if deleted.
plan
refresh - refresh the remote state.  Can identify differences between state file and remote state
state - advanced state management, e.g. Rename a resource with terraform state mv aws_instance.example aws_instance.production
taint/untaint - manually mark a resource as tainted, meaning it will be destructed and recreated at the next apply
validate
remote - configure remote state storage
show - show human readable output from a state or a plan