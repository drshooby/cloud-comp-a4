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
}

resource "aws_security_group" "server_access_my_ip" {
  name        = "https from my ip"
  description = "security group that only allows https access through my ip"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from my IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.my_ip
  }

  ingress {
    description = "Go server from my IP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.my_ip
  }
}

resource "aws_security_group" "outbound_all" {
  name        = "outbound rule"
  description = "security group that allows all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
