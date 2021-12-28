# Overview of terraform script

 - Created VPC with 3 public and 3 private subnet with ING and NGW.
 - Created SSH key par for autoscaling.
 - Autoscaling will lunche  EC2 into private subnet.
 - Also, have defined userdata which will install nginx and homepage will print hostname ec2.
 - Create s3 Bucket.
 - Create AWS IAM role with s3 GetObject and PutObject policy and have attached role to Launch Configuration.
 - Created Load balancer with target group.


 # Instruction to run terraform scipt 

 - Please configure AWS CLI in your terraform machine
 - I have used us-west-2 region for AWS resources
 - clone code from : https://github.com/vnitun/nitun.git
 - run `terraform plan` to validate 
 - run `terraform apply`

 # ---------------------------------------------------------------- #
