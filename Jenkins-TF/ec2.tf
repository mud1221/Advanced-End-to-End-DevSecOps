resource "aws_instance" "jenkins" {

  ami                    = var.ami_id
  instance_type          = var.instance_type

  subnet_id              = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  user_data = file("userdata.sh")

  tags = {
    Name = "${var.project_name}-Jenkins"
  }
}