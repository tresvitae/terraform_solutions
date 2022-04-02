# Base Infrastructure

## Attach additional EBS Volume
```bash
# Attach
sudo -s
df -h

mkfs.ext4 /dev/xvdh
mkdir /data
mount /dev/xvdh data
df -h

vim /etc/fstab
/dev/xvdh /data ext4 defaults 0 0
# Verify
df -h
umount data
mount data
```

## Check Route 53
host -t MX tresvitae.tk ns-....awsdns-...org


### Variables

- bool
- string
- number
- List: A sequence of values of the same type.
list(string) list(number) list(map)
`public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)`
- Map: A lookup table, matching keys to values, all of the same type.
`var.resource_tags.project`
- Set: An unordered collection of unique values, all of the same type. Sets are useful when a unique collection of values is needed, and the order of the items in the collection does not matter.

Assign values with a `terraform.tfvars` file. Terraform automatically loads all files in the current directory with the exact name terraform.tfvars or matching *.auto.tfvars. You can also use the -var-file flag to specify other files by name.

### Outputs
Terraform output values allow you to export data about your resources. You can use this data to configure other parts of your infrastructure with automation tools, or as a data source for another Terraform workspace. Outputs are also necessary to share data from a child module to your root module.

create output from `terraform show`:
```sh
value = "http://${module.elb_http.this_elb_dns_name}/"
value       = module.vpc.vpc_id

```
`terraform output`
`terraform output -raw lb_url`
`curl $(terraform output -raw lb_url)`

Terraform output can be `sensitive = true` but only for `terraform apply` command. Not work for `terraform output db_password` or `grep --after-context=10 outputs terraform.tfstate`
