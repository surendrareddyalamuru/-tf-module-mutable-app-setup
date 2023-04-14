resource "aws_lb_target_group" "main" {
  name     = "${var.env}-${var.name}-tg"
  port     = var.app_port_no
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 6
    path                = "/health"
  }
}