
#############################--Bastion-Host--##############################

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.ubuntu_20.id
  instance_type          = var.instance_type
  iam_instance_profile   = data.aws_iam_instance_profile.base_role.name
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.jump_serv_ssh_sg.id, aws_security_group.ssh_access_sg.id]
  subnet_id              = aws_subnet.private_subnet_1.id
  tags = {
    Name        = "${var.environment}-${var.instance_name}-jump_server"
    Env         = var.environment
    Provisioner = var.provisioner
  }

}
#############################--Elastic-IP-Association--##############################

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = aws_eip.jump_serv_ip.id
}

#############################--Bastion SG ##############################
resource "aws_security_group" "jump_serv_ssh_sg" {
  name        = "allow_ssh_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.test.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "from my ip range"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    description = "ICMP Allowed"
    protocol    = "icmp"
    to_port     = -1
    from_port   = -1
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name = "external_ssh_sg"
  }
}

###############################--Elastic-IP--########################################

resource "aws_eip" "jump_serv_ip" {
  domain   = "vpc"
  instance = aws_instance.bastion_host.id
  # network_interface = aws_network_interface.net_nic.id
  tags = {
    Name = "jump_serv_ip"
  }
}
