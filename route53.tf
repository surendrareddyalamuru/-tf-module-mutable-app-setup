resource "aws_route53_record" "private" {
  zone_id = var.private_zone_id
  name    = "${var.name}-${var.env}"
  type    = "CNAME"
  ttl     = 300
  records = [var.alb["private"].lb_dns_name]
}