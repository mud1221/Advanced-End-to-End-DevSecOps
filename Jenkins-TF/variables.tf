variable "region" {
  description = "AWS Region"
  type        = string
}
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}
variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
}
variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}
variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}
variable "key_name" {
  description = "AWS Key Pair Name"
  type        = string
}