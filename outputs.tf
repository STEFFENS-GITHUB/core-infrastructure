output "delegate_zone_id" {
    description = "ID of the environment's delegated hosted zone"
    value       = aws_route53_zone.delegate.zone_id
}

output "delegate_zone_name" {
    description = "Name of the environment's delegated hosted zone"
    value       = aws_route53_zone.delegate.name
}
