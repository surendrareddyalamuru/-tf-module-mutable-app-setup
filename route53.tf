resource "aws_route53_record" "private" {
  count = var.type == "backend" ? 1 : 0
  zone_id = var.private_zone_id
  name    = "${var.name}-${var.env}"
  type    = "CNAME"
  ttl     = 300
  records = [var.alb["private"].lb_dns_name]
}

resource "aws_route53_record" "public" {
  count = var.type == "frontend" ? 1 : 0
  zone_id = var.public_zone_id
  name    = var.public_dns_name
  type    = "CNAME"
  ttl     = 300
  records = [var.alb["public"].lb_dns_name]
}