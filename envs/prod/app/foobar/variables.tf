variable "desired_count" {
  type    = number
  default = 0 #稼働させるECSサービス数 目標値となるため、コスト低減する場合は、「0」とする事 (defaultで「0」としている)
}
