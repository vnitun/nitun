# Overview of terraform script

 - Create VPC with 3 public and 3 private subnet with IGW and NGW.
 - Create SSH key par for autoscaling.
 - Autoscaling will lunche  EC2 into private subnet.
 - Also, have defined userdata which will install nginx and homepage will print hostname of ec2 instance.
 - Create s3 Bucket.
 - Create AWS IAM role with s3 GetObject and PutObject policy and have attached role to Launch Configuration.
 - Create Load balancer with target group.


 # Instruction to run terraform scipt 

 - Please configure AWS CLI in your terraform machine
 - I have used us-west-2 region for AWS resources
 - Clone code from : https://github.com/vnitun/terraform-task.git
 - Run `terraform init` to installed required plugins of aws provider
 - Run `terraform plan` to validate 
 - Run `terraform apply`
 - Keep `var.keyname`  default by typing `enter`

 # ---------------------------------------------------------------- #
