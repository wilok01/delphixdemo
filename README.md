# wiloklab
Terraform demo to deploy an EC2 instance with a security group on it that allows incoming traffic on ports 22 and 443 only and sits behind a load balancer

This Repo has in it multiple Terraform files, for

Variables: (variables.tf)
This file contains my declared and referenced variables, which i have used in most of the other files.

Provider: (provider.tf)
This contains my terraform cloud organization, my created workspace the aws source and version which i have used and also provider / region i have used.

Main: (main.tf)
The main file, contains my aws vpc resource, my Internet gateway resource and my Nat Gateway resource, which have referenced by their ".id" or arn  

Alb : Application Load Balancer (alb.tf)
This file has the Application Load balancer (ALB), Target group and has the ALB listeners to redirect/ forward 80 (http) to 443 (https) traffic.

ASG : Auto Scalling group (asg.tf)
This file has the auto scalling group resource to determine or specify how many instance is desired to run a web or application.

Bastion: Jump Server (bastion.tf)
This contains a seperate ec2 instance using same launch template to allow creation of a jump server, which is used to ssh into other servers.
It also has the Security group to be used for this Bastion host, 

Data : data.tf
This contains data and references other resources created outside of this terraform code, it contains data about certificates and 

Launch Template : (lt.tf)
Launch template, this contains the template (ami) used to launch or create a new instance.

Routes: (routes.tf)
This file contains my Private and Public route/ resource, it also my route association resource for the association of the public and private routes.

Security Group: (sg.tf)
This file contains security group resources, which are applied to the different web instances, in here the different ports (80, 443, 22) is specified and these are applied to the different boundaries.

Subnet: (subnet.tf)
This file contains my desired private and public subnets/ prefix which i would be using for the VPC's

Output: (output.tf)
Although i have not created any output block, but this file is to allow for an output of a desired resource after the terraform apply (--auto-approve)

Nginx: (nginx.sh)
This file is a little bash script to create/ run the Nginx web server whenever an instance is created on the launch instance, which i have used to test my webserver/ application load balancer and created DNS. But this does not run on the bastion (jump server).