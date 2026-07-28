# AWS Region
region = "ap-south-1"

# EC2 Configuration
instance_type = "t3.small"
key_name      = "devOpskey"

# Ubuntu 22.04 LTS AMI (Update if required)
ami_id = "ami-01a00762f46d584a1"

# Networking
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
availability_zone  = "ap-south-1a"

# EC2 Root Volume
volume_size = 30
volume_type = "gp3"

# Tags
project_name = "Advanced-End-to-End-DevSecOps"
environment  = "dev"

instance_name = "Jenkins-Server"