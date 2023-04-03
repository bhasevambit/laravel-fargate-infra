variable "enable_alb" {
  type    = bool
  default = false #コスト低減のために、defaultで、「false」とし、ALB関連Resourceを作成しない形とする
}
