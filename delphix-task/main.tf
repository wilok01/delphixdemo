
######################## AWS VPC #############################

resource "aws_vpc" "test" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true" #Added for test
  enable_dns_hostnames = "true" #Added for test
  tags                 = var.vpc_tags
}

######################## AWS IGW #############################

resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name        = "${var.environment}-${var.igw_name}"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}

resource "aws_eip" "test" {
  domain = "vpc"
}

######################## AWS NAT GW #############################
resource "aws_nat_gateway" "test" {
  allocation_id = aws_eip.test.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name        = "${var.environment}-ngw"
    Env         = var.environment
    Provisioner = var.provisioner
  }

  depends_on = [aws_internet_gateway.test]
}
