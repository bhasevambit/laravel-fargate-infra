# /// コストインパクト低のため、削除不要 ///
data "aws_route53_zone" "this" {
  name = "mbit-cloud-system-test-for-self-studying.com"
}

# /// コストインパクト低のため、削除不要 ///
// --- DNS Validation with Route53 ---
// (Click here for details: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation.html#dns-validation-with-route-53>)
resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.root.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.this.id
}

# /// コストインパクト「有」のため、不使用時は削除する事 ("terrafomrs apply -var='enable_alb=false'"によるオプション指定でも作成回避可能) ///
resource "aws_route53_record" "root_a" {
  count = var.enable_alb ? 1 : 0

  name    = data.aws_route53_zone.this.name
  type    = "A"
  zone_id = data.aws_route53_zone.this.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_lb.this[0].dns_name
    zone_id                = aws_lb.this[0].zone_id
  }
}
