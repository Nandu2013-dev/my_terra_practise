output "publicip" {
    value = aws_instance.mygan.public_ip
  
}
output "private_ip" {
    value = aws_instance.mygan.private_ip
  
}

output "vpc" {
    value = aws_instance.mygan.vpc_security_group_ids
  
}