######################## AWS Auto Scalling Group #############################

resource "aws_autoscaling_group" "test" {
  name                      = var.environment
  max_size                  = 2 ## Adjust for Maximum Number of desired instance
  min_size                  = 1 # Minimum Number of desired instance
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2 ## Adjust for Number of desired instance
  force_delete              = true

  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  target_group_arns   = [aws_lb_target_group.test_443.arn, aws_lb_target_group.test_80.arn]
  launch_template {
    id      = aws_launch_template.test.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.environment}-web"
    propagate_at_launch = true
  }

  tag {
    key                 = "Env"
    value               = var.environment
    propagate_at_launch = false
  }
}
