# /// コストインパクト低のため、削除不要 ///
resource "aws_route53_zone" "this" {
  name = "foobar.internal"

  vpc {
    vpc_id = data.terraform_remote_state.network_main.outputs.vpc_this_id
  }
}

# /// コストインパクト低ではあるが、CNAMEでの名前解決先となるRDS DB Instanceの作成とタイミングを合わせての自動作成/削除とする ///
resource "aws_route53_record" "db_cname" {
  count   = var.enable_rds ? 1 : 0 #RDS DB Instanceの稼働状況に合わせるために、count変数での条件分岐を追加
  zone_id = aws_route53_zone.this.zone_id
  name    = "db.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    data.terraform_remote_state.db_foobar.outputs.db_instance_this_address #tfstateに登録されているRDS MySQL DBインスタンスのエンドポイントを設定(これにより、RDS DBインスタンスを再作成しても常にDBエンドポイントを追うことができる)
  ]
}

# /// コストインパクト低のため、削除不要 ///
# resource "aws_route53_record" "cache_cname" {
#   zone_id = aws_route53_zone.this.zone_id
#   name    = "cache.${aws_route53_zone.this.name}"
#   type    = "CNAME"
#   ttl     = 300

#   records = [
#     data.terraform_remote_state.cache_foobar.outputs.elasticache_replication_group_this_primary_endpoint_address
#   ]
# }
