# /// コストインパクト低のため、削除不要 ///
resource "aws_ecs_cluster" "this" {
  name = "${local.name_prefix}-${local.service_name}"

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  tags = {
    Name = "${local.name_prefix}-${local.service_name}"
  }
}

# --- 本リソースはecspressoで管理するため、Terraform管理外とする(常時コメントアウト) ---
# resource "aws_ecs_task_definition" "this" {
#   family = "${local.name_prefix}-${local.service_name}"

#   task_role_arn = aws_iam_role.ecs_task.arn

#   network_mode = "awsvpc"

#   requires_compatibilities = [
#     "FARGATE",
#   ]

#   execution_role_arn = aws_iam_role.ecs_task_execution.arn

#   memory = "512"
#   cpu    = "256"

#   container_definitions = jsonencode(
#     [
#       {
#         name  = "nginx"
#         image = "${module.nginx.ecr_repository_this_repository_url}:latest"

#         portMappings = [
#           {
#             containerPort = 80
#             protocol      = "tcp"
#           }
#         ]

#         environment = []
#         secrets     = []

#         dependsOn = [
#           {
#             containerName = "php"
#             condition     = "START"
#           }
#         ]

#         mountPoints = [
#           {
#             containerPath = "/var/run/php-fpm"
#             sourceVolume  = "php-fpm-socket"
#           }
#         ]

#         logConfiguration = {
#           logDriver = "awslogs"
#           options = {
#             awslogs-group         = "/ecs/${local.name_prefix}-${(local.service_name)}/nginx"
#             awslogs-region        = data.aws_region.current.id
#             awslogs-stream-prefix = "ecs"
#           }
#         }
#       },
#       {
#         name  = "php"
#         image = "${module.php.ecr_repository_this_repository_url}:latest"

#         portMappings = []

#         environment = []
#         secrets = [
#           {
#             name      = "APP_KEY"
#             valueFrom = "/${local.system_name}/${local.env_name}/${local.service_name}/APP_KEY"
#           }
#         ]

#         mountPoints = [
#           {
#             containerPath = "/var/run/php-fpm"
#             sourceVolume  = "php-fpm-socket"
#           }
#         ]

#         logConfiguration = {
#           logDriver = "awslogs"
#           options = {
#             awslogs-group         = "/ecs/${local.name_prefix}-${(local.service_name)}/php"
#             awslogs-region        = data.aws_region.current.id
#             awslogs-stream-prefix = "ecs"
#           }
#         }
#       }
#     ]
#   )

#   volume {
#     name = "php-fpm-socket"
#   }

#   tags = {
#     Name = "${local.name_prefix}-${local.service_name}"
#   }
# }

# --- 本リソースはecspressoで管理するため、Terraform管理外とする(常時コメントアウト) ---
# resource "aws_ecs_service" "this" {
#   name = "${local.name_prefix}-${local.service_name}"

#   cluster = aws_ecs_cluster.this.arn

#   capacity_provider_strategy {
#     capacity_provider = "FARGATE_SPOT"  #「"FARGET"」も指定可能であるが、本ハンズオンでは、可用性よりもコストを重視して「"FARGATE_SPOT"」を指定する
#     base              = 0 #タスク最小数
#     weight            = 1 #起動済タスクの総数に対する当該キャパシティプロバイダー使用タスクの比率 (本ハンズオンでは「"FARGATE_SPOT"」のみを使用するため、本値は効果無し)
#   }

#   platform_version = "1.4.0"

#   task_definition = aws_ecs_task_definition.this.arn

#   desired_count                      = var.desired_count  #起動タスク数 (「var.desired_count」変数にて、任意の値を指定可能)
#   deployment_minimum_healthy_percent = 100
#   deployment_maximum_percent         = 200

#   load_balancer {
#     container_name   = "nginx"
#     container_port   = 80
#     target_group_arn = data.terraform_remote_state.routing_appfoobar_link.outputs.lb_target_group_foobar_arn
#   }

#   health_check_grace_period_seconds = 60

#   network_configuration {
#     assign_public_ip = false
#     security_groups = [
#       data.terraform_remote_state.network_main.outputs.security_group_vpc_id
#     ]
#     subnets = [
#       for s in data.terraform_remote_state.network_main.outputs.subnet_private : s.id
#     ]
#   }

#   enable_execute_command = true

#   tags = {
#     Name = "${local.name_prefix}-${local.service_name}"
#   }
# }
