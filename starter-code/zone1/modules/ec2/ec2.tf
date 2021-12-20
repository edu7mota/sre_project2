resource "aws_launch_configuration" "ubuntu" {
  name          = "ubuntu_web_config"
  image_id      = var.aws_ami
  instance_type = "t3.micro"
  security_groups = [aws_security_group.ec2_sg.id]
}

resource "aws_placement_group" "ubuntu" {
  name     = "ubuntu"
  strategy = "cluster"
}

resource "aws_alb_target_group" "app_target_group" {
  name     = "application-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_group" "ubuntu" {
  name                      = "ubuntu"
  max_size                  = var.instance_count
  min_size                  = var.instance_count
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.instance_count
  force_delete              = true
  placement_group           = aws_placement_group.ubuntu.id
  launch_configuration      = aws_launch_configuration.ubuntu.name
  vpc_zone_identifier       = var.public_subnet_ids

  target_group_arns = [aws_alb_target_group.app_target_group.arn]
}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  vpc_id      = var.vpc_id

  ingress {    
    description = "web port"
    from_port   = 80    
    to_port     = 80
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh port"
    from_port   = 22    
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "monitoring"
    from_port   = 9100    
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "nginx monitoring"
    from_port   = 9113    
    to_port     = 9113
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}