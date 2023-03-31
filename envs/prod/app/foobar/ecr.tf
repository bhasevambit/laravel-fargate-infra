# /// コストインパクト低のため、削除不要 ///
module "nginx" {
  source = "../../../../modules/ecr"

  name = "${local.name_prefix}-${local.service_name}-nginx"
}

# /// コストインパクト低のため、削除不要 ///
module "php" {
  source = "../../../../modules/ecr"

  name = "${local.name_prefix}-${local.service_name}-php"
}
