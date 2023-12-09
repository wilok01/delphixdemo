#######3 Public Subnets #########
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = var.public_subnet_cidr_1
  availability_zone = var.use2a

  tags = {
    Name        = "${var.environment}-${var.public_subnet_name}-1"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = var.public_subnet_cidr_2
  availability_zone = var.use2b


  tags = {
    Name        = "${var.environment}-${var.public_subnet_name}-2"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}

#######3 private Subnets #########
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = var.use2a

  tags = {
    Name        = "${var.environment}-${var.private_subnet_name}-1"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = var.use2b

  tags = {
    Name        = "${var.environment}-${var.private_subnet_name}-2"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}
