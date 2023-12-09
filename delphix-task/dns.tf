
resource "aws_route53_record" "www_test" {
  zone_id = data.aws_route53_zone.wilsondemo_labs_zone.zone_id
  name    = "www.test.wiloklab.com"
  type    = "A"

  alias {
    name                   = aws_lb.test.dns_name
    zone_id                = aws_lb.test.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "test" {
  zone_id = data.aws_route53_zone.wilsondemo_labs_zone.zone_id
  name    = "test.wiloklab.com"
  type    = "A"

  alias {
    name                   = aws_lb.test.dns_name
    zone_id                = aws_lb.test.zone_id
    evaluate_target_health = true
  }
}

