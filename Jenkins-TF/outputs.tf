output "instance_id" {
  description = "Jenkins EC2 Instance ID"
  value       = aws_instance.jenkins.id
}

output "public_ip" {
  description = "Jenkins Public IP"
  value       = aws_instance.jenkins.public_ip
}

output "public_dns" {
  description = "Jenkins Public DNS"
  value       = aws_instance.jenkins.public_dns
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}