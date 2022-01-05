# AWS Codepipeline on ECS Fargate with network load balancer
## Codepipeline contains:

### Steps
1. Deploy configuration ` terraform apply -auto-approve `
2. Configure SSH keys for AWS CodeCommit in your IAM User account
` ssh-keygen -f mykey `
3. Copy&paste mykey.pub to SSH public key IAM AWS
4. Add code&configuration files to the repository

```bash
# Create repo file
mkdir ../myapp
cp app/docker-image/* ../myapp
cp app/config/* ../myapp
cp app/scripts/create-new-task-def.sh ../myapp
# Push to CodeCommit
git init
git add . && git commit -m "Deploy the Code"
git remote add origin ssh://SSH_key_ID@git-codecommit.eu-west-1.amazonaws.com/v1/repos/myapp
git push -u origin master
```