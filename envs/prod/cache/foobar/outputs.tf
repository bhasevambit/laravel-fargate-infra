output "elasticache_replication_group_this_primary_endpoint_address" {
  value = one(aws_elasticache_replication_group.this[*].primary_endpoint_address)
}
