module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "${var.env}-vpc"
  cidr = var.vpc_cidr_block

  # Subnets are matched to AZs by position, so each list is given in AZ order
  azs             = [for subnet in var.public_subnets : subnet.availability_zone]
  public_subnets  = [for subnet in var.public_subnets : subnet.cidr_block]
  private_subnets = [for subnet in var.private_subnets : subnet.cidr_block]

  # Instances launched into the public subnets get a public IP automatically
  map_public_ip_on_launch = true

  enable_nat_gateway = var.create_nat_gateway
  single_nat_gateway = true # One shared NAT gateway rather than one per AZ

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Leave the VPC's AWS-created defaults out of state
  manage_default_security_group = false
  manage_default_network_acl    = false
  manage_default_route_table    = false

  tags = {
    Environment = var.env
  }
}
