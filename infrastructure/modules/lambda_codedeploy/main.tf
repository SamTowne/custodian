resource "aws_codedeploy_app" "this" {
  name             = var.app_name
  compute_platform = "Lambda"
  tags             = var.tags
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = var.app_name
  deployment_group_name  = var.deployment_group_name
  service_role_arn       = var.service_role_arn
  deployment_config_name = var.deployment_config_name

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  auto_rollback_configuration {
    enabled = var.auto_rollback_enabled
    events  = var.auto_rollback_events
  }

  dynamic "alarm_configuration" {
    for_each = var.alarm_enabled ? [true] : []

    content {
      enabled                   = var.alarm_enabled
      alarms                    = var.alarms
      ignore_poll_alarm_failure = var.alarm_ignore_poll_alarm_failure
    }
  }

  dynamic "trigger_configuration" {
    for_each = var.triggers

    content {
      trigger_events     = trigger_configuration.value.events
      trigger_name       = trigger_configuration.value.name
      trigger_target_arn = trigger_configuration.value.target_arn
    }
  }

  lifecycle {
    ignore_changes = [
      blue_green_deployment_config
    ]
  }

  tags = var.tags
}