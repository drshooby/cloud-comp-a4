module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.0"

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = var.aws_azs
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs
}
