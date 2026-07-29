resource "aws_instance" "jenkins" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  associate_public_ip_address = true

  root_block_device {

    volume_size = 30
    volume_type = "gp3"
  }

  user_data = file("userdata.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}