output "env_hosted_zone_id" {
    value = aws_route53_zone.env_hosted_zone.zone_id
}

output "env_hosted_zone_name" {
    value = aws_route53_zone.env_hosted_zone.name
}