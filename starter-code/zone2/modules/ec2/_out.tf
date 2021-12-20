output "aws_autoscaling_group" {
   value = aws_autoscaling_group.ubuntu
 }

 output "ec2_sg" {
     value = aws_security_group.ec2_sg.id
 }