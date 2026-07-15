resource "aws_vpc" "jenkins_vpc" {

  cidr_block = var.vpc_cidr
  tags = {

    Name = "${var.project_name}-VPC"

  }

}