# /// コストインパクト低のため、削除不要 ///
resource "aws_cloudwatch_log_group" "nginx" {
  name = "/ecs/${local.name_prefix}-${local.service_name}/nginx"

  retention_in_days = 90
}

# /// コストインパクト低のため、削除不要 ///
resource "aws_cloudwatch_log_group" "php" {
  name = "/ecs/${local.name_prefix}-${local.service_name}/php"

  retention_in_days = 90
}
