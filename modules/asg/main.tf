resource "aws_launch_template" "lt" {
  name_prefix   = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    security_groups = [var.alb_sg_id]
  }
}

resource "aws_autoscaling_group" "asg" {
  name               = var.name
  min_size           = var.min_size
  max_size           = var.max_size
  desired_capacity   = var.desired_capacity

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.lt.id   
    version = "$Latest"
  }
}