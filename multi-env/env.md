# Multi envinronment without terraform workspace

* [Development](dev/dev.tf)
* [Production](prod/prod.tf)


State separation signals more mature usage of Terraform; with additional maturity comes additional complexity. There are two primary methods to separate state between environments: directories and workspaces.

* By creating separate directories for each environment, you can shrink the blast radius of your Terraform operations and ensure you will only modify intended infrastructure. Terraform stores your state files on disk in their corresponding configuration directories. Terraform operates only on the state and configuration in the working directory by default.

* Workspace-separated environments use the same Terraform code but have different state files, which is useful if you want your environments to stay as similar to each other as possible, for example if you are providing development infrastructure to a team that wants to simulate running in production.

More here [S3 Website](../s3-website/s3web.md)