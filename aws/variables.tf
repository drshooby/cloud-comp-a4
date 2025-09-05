variable "my_ip" {
  type = list(string)
}

variable "ec2_ami" {
  type    = string
  default = "ami-0360c520857e3138f" // ubuntu x86
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Default region."
}

variable "vpc_name" {
  type        = string
  default     = "a4-vpc"
  description = "VPC name."
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR block."
}

variable "aws_azs" {
  description = "List of az in the specified region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "Public subnet CIDR blocks."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  description = "Private subnet CIDR blocks."
}

variable "ssh_key_name" {
  type        = string
  default     = "cloud-computing-kp"
  description = "SSH key name."
}
