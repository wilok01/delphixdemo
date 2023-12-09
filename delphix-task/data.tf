#############################--test page--##############################

data "aws_route53_zone" "wilsondemo_labs_zone" {
  name = "wiloklab.com."
}

/*
data "aws_ami" "web_stage_ami" {
  most_recent = false
  filter {
    name = "tag:Name"
    #values = [data.aws_ami.ubuntu_20.id]
    values = [aws_launch_template.test.id]
  }

}
*/
#############################--Test Cert--##############################

data "aws_acm_certificate" "wilsondemo_labs_ssl_cert" {
  domain      = "www.dev.wiloklab.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

/*
output "test_ami" {
  value = data.aws_ami.web_stage_ami.id
}
*/

###### Ubuntu Default Image Lookup #######

data "aws_ami" "ubuntu_20" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_iam_instance_profile" "base_role" {
  name = "base-ec2-role"
}
