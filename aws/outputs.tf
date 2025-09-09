output "public_ip" {
  value = aws_instance.my_super_cool_ec2.public_ip
}

output "instance_id" {
  value = aws_instance.my_super_cool_ec2.id
}
