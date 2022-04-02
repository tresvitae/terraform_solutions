
### Dependencies
`depends_on` argument.

Implicit Dependency - Terraform knows that the resources must be created before the other, like first EC2, then EIP.

Manage explicit dependencies
```sh
resource "aws_instance" "example" {
    depends_on = [aws_s3_bucket.example]
}
```
First S3, then EC2