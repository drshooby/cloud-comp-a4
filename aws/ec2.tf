resource "aws_security_group" "ssh_my_ip" {
  name        = "ssh from my ip"
  description = "security group that only allows ssh access through my ip"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.my_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {

  instance_type               = "t2.micro"
  ami                         = var.ec2_ami
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [aws_security_group.ssh_my_ip.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 24 # GB
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "a4-machine"
  }
}
