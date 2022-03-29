# Learn Terraform - HashiCups Provider

This is the companion repo for [Perform CRUD Operations with Providers](https://learn.hashicorp.com/tutorials/terraform/provider-use?in=terraform/providers) tutorial on Learn.

The API has a number of unprotected and protected endpoints. You can list all coffees and ingredients for a particular coffee without authentication. Once authenticated, you can create, read, update and delete (CRUD) orders.

The Terraform HashiCups provider interfaces with the product's REST API through a GoLang client library. This allows you to manage HashiCups orders through Terraform.

```sh
dpkg --print-architecture

make install 

mv ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3.1/darwin_amd64/ ~/.terraform.d/plugins/hashicorp.com/edu/hashicups/0.3.1/linux_amd64

```