variable "region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_name" {
  type = string
}