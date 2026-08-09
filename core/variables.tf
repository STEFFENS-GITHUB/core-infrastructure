variable "env" {
  description = "Environment (development, staging, production)"
  type        = string
}

variable "domain_name" {
  description = "Root domain name for the app"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet configurations"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "List of private subnet configurations"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "create_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = false
}