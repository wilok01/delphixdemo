#############################--AWS LB Target-Grp--##############################

resource "aws_lb_target_group" "test_80" {
  name     = "${var.environment}-tg-80"
  port     = var.port_80
  protocol = var.proto_80
  vpc_id   = aws_vpc.test.id
  health_check {
    path                = var.health_path
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "test_443" {
  name     = "${var.environment}-tg-443"
  port     = var.port_443
  protocol = var.proto_443
  vpc_id   = aws_vpc.test.id
  health_check {
    path                = var.health_path
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

######################## ALB #############################

resource "aws_lb" "test" {
  name               = "${var.environment}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  tags = {
    Environment = var.environment
  }
}

######################## ALB Listerners #############################

resource "aws_lb_listener" "test_443" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.port_443
  protocol          = var.proto_443
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.wilsondemo_labs_ssl_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_80.arn
  }
}

#################### AWS listener to have http redirect to https ########################
resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.port_80
  protocol          = var.proto_80

  default_action {
    type = "redirect"

    redirect {
      port        = var.port_443
      protocol    = var.proto_443
      status_code = "HTTP_301"
    }
  }
}


resource "aws_lb_listener_rule" "test" {
  listener_arn = aws_lb_listener.test_443.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_80.arn
  }

  condition {
    host_header {
      values = ["www.test.wiloklab.com", "test.wiloklab.com"]
    }
  }
}
