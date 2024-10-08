# creating this manually as it nlb requires and EIP to create A record.
/*
resource "aws_route53_record" "aayan_root" {
  zone_id = data.aws_route53_zone.aayan.zone_id
  name    = "aayan.link"  # Replace with your desired record name
  type    = "A"
  ttl     = 300
  records = [data.aws_lb.kic_nlb.dns_name]
}*/