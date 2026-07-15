output "instance_id" {
  description = "Jenkins EC2 Instance ID"
  value       = aws_instance.jenkins.id
}

output "public_ip" {
  description = "Jenkins Public IP"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}