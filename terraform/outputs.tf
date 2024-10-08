output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

/*
output "kic_nlb_arn" {
  value = data.aws_lb.kic_nlb.arn
}

output "kic_nlb_dns_name" {
  value = data.aws_lb.kic_nlb.dns_name
}

output "zone_id" {
  value = data.aws_route53_zone.aayan.zone_id
}*/

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}