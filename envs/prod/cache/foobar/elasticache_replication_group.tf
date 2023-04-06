# /// コストインパクト「有」のため、不使用時は削除する事 ("terrafomrs apply -var='enable_cache=false'"によるオプション指定でも作成回避可能) ///
resource "aws_elasticache_replication_group" "this" {
  count  = var.enable_cache ? 1 : 0 #ElastiCacheは稼働コスト高いため、不使用時は削除するためにcount変数での条件分岐を追加
  engine = "redis"

  // Redis settings
  replication_group_id          = "${local.system_name}-${local.env_name}-${local.service_name}"
  replication_group_description = "Session storage for Laravel"
  engine_version                = "6.x"
  port                          = 6379
  parameter_group_name          = aws_elasticache_parameter_group.this.name
  node_type                     = "cache.m6g.large" #作成処理をはやめるために「cache.t3.micro」から「cache.m6g.large」(汎用ファミリー(m)の最新世代(6)の最小サイズ)に変更とした
  number_cache_clusters         = 2
  multi_az_enabled              = true

  // Advanced Redis settings
  subnet_group_name = data.terraform_remote_state.network_main.outputs.elasticache_subnet_group_this_name

  // Security
  security_group_ids = [
    data.terraform_remote_state.network_main.outputs.security_group_cache_foobar_id
  ]
  at_rest_encryption_enabled = true
  transit_encryption_enabled = false

  // Backup
  snapshot_retention_limit = 1
  snapshot_window          = "17:00-18:00"

  // Maintenance
  maintenance_window     = "fri:18:00-fri:19:00"
  notification_topic_arn = ""

  // Others
  automatic_failover_enabled = true
  auto_minor_version_upgrade = false

  tags = {
    Name = "${local.system_name}-${local.env_name}-${local.service_name}"
  }
}
