Follow along on the [HashiCorp Learn platform](https://learn.hashicorp.com/tutorials/terraform/cloud-init?in=terraform/provision)

ssh-keygen -t rsa -C "your_email@example.com" -f tf-cloud-init

paste output of tf-cloud-init.pub to scripts/add-ssh-web-app.yaml > ssh_authorized_keys