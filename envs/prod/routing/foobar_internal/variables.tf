variable "enable_rds" {
  type    = bool
  default = false #コスト低減のために、defaultで、「false」とし、RDS関連Resourceを作成しない形とする
}

variable "enable_cache" {
  type    = bool
  default = false #コスト低減のために、defaultで、「false」とし、ElastiCache関連Resourceを作成しない形とする
}