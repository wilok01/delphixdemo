##################### Public Security Group #################################
resource "aws_security_group" "public_sg" {
  name        = "${var.environment}-public-sg"
  description = "Allow HTTP and HTTPS from Public"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "HTTP from Public IPv4"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from Public IPv4"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /*
  ingress {
    description      = "HTTP from Public IPv6"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from Public IPv6"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
*/
  egress {
    description = "HTTP to anywhere IPv4"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS to anywhere IPv4"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /*
  egress {
    description      = "HTTP from Public IPv6"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "HTTPS from Public IPv6"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
*/
  tags = {
    Name        = "${var.environment}-public-sg"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}


##################### private Security Group #################################
resource "aws_security_group" "private_sg" {
  name        = "${var.environment}-private-sg"
  description = "Allow HTTP and HTTPS from private"
  vpc_id      = aws_vpc.test.id

  ingress {
    description     = "HTTP from private IPv4"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  ingress {
    description     = "HTTPs from private IPv4"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /*
  egress {
    description      = "HTTPS from private IPv6"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
*/
  tags = {
    Name        = "${var.environment}-private-sg"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}


################################## Internal SSH SG from Baston to other hosts ###############################

resource "aws_security_group" "ssh_access_sg" {
  name        = "${var.environment}-ssh_access-sg"
  description = "Allow SSH from Bastion"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "SSH from Anywhere IPv4"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  /*
  ingress {
    description      = "SSH from Anywhere IPv4"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
*/
  egress {
    description = "SSH to Anywhere IPv4"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  /*
  egress {
    description      = "SSH to Anywhere IPv4"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
*/
  tags = {
    Name        = "${var.environment}-ssh_access-sg"
    Env         = var.environment
    Provisioner = var.provisioner
  }
}
