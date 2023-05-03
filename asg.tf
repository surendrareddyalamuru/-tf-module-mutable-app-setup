resource "aws_launch_template" "launch-template" {
  name          = "${var.env}-${var.name}-lt"
  image_id      = data.aws_ami.centos-8-ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]


  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }

  instance_market_options {
    market_type = "spot"
  }

  user_data = base64encode(templatefile("${path.module}/ansible-pull.sh", {
    COMPONENT = var.name
    ENV       = var.env
  }))
}

resource "aws_autoscaling_group" "asg" {
  name                = "${var.env}-${var.name}-asg"
  desired_capacity    = var.min_size
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
  target_group_arns   = [aws_lb_target_group.main.arn]



  launch_template {
    id      = aws_launch_template.launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-${var.name}"
    propagate_at_launch = true
  }
}
