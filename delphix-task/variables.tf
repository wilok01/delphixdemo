#############################--Variables--##############################

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_tags" {
  type = map(string)
  default = {
    "Name"        = "test-web"
    "Env"         = "test"
    "Provisioner" = "Terraform"
  }
}

variable "environment" {
  type    = string
  default = "test"
}

variable "provisioner" {
  type    = string
  default = "Terraform"
}

variable "instance_name" {
  type    = string
  default = "bastion"
}

variable "public_subnet_name" {
  type    = string
  default = "public-subnet"
}

variable "public_subnet_cidr_1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_name" {
  type    = string
  default = "private-subnet"
}

variable "private_subnet_cidr_1" {
  type    = string
  default = "10.0.10.0/24"
}

variable "private_subnet_cidr_2" {
  type    = string
  default = "10.0.11.0/24"
}

variable "public_rt_name" {
  type    = string
  default = "public-rt"
}

variable "private_rt_name" {
  type    = string
  default = "private-rt"
}

variable "igw_name" {
  type    = string
  default = "igw"
}

variable "use2a" {
  type    = string
  default = "us-east-2a"
}

variable "use2b" {
  type    = string
  default = "us-east-2b"
}

####################  Target Group Variables ####################33333

variable "port_80" {
  type    = number
  default = 80
}

variable "port_443" {
  type    = number
  default = 443
}

variable "proto_80" {
  type    = string
  default = "HTTP"
}

variable "proto_443" {
  type    = string
  default = "HTTPS"
}

variable "health_path" {
  type    = string
  default = "/"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair" {
  type    = string
  default = "main-us-east-2"
}


