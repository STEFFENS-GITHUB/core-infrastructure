variable "domain_name" {
  description = "Root domain name for the app"
  type        = string
}

variable "env" {
  description = "Environment (development, staging, production)"
  type        = string
}