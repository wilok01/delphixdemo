#############################--Test Launch Template--##############################

resource "aws_launch_template" "test" {
  name = "${var.environment}-lt"

  iam_instance_profile {
    name = data.aws_iam_instance_profile.base_role.name
  }

  image_id                             = data.aws_ami.ubuntu_20.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  key_name                             = var.key_pair
  vpc_security_group_ids               = [aws_security_group.private_sg.id, aws_security_group.public_sg.id, aws_security_group.ssh_access_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.environment}-lt"
    }
  }

  user_data = filebase64("${path.module}/nginx.sh")
}
