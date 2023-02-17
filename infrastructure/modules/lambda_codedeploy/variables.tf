variable "app_name" {
  description = "Name of the app being deployed"
  type        = string
  default     = ""
}

variable "service_role_arn" {
  description = "Name of the service role code deploy uses"
  type        = string
  default     = ""
}

variable "deployment_group_name" {
  description = "Name of deployment group to use"
  type        = string
  default     = ""
}

variable "deployment_config_name" {
  description = "Name of deployment config to use"
  type        = string
  default     = "CodeDeployDefault.LambdaAllAtOnce"
}

variable "auto_rollback_enabled" {
  description = "Whether a rollback configuration is enabled for the deployment group"
  type        = bool
  default     = true
}

variable "auto_rollback_events" {
  description = "List of events that trigger a rollback, supported types are DEPLOYMENT_FAILURE and DEPLOYMENT_STOP_ON_ALARM"
  type        = list(string)
  default     = ["DEPLOYMENT_FAILURE"]
}

variable "alarm_enabled" {
  description = "Whether alarm configuration is enabled"
  type        = bool
  default     = false
}

variable "alarms" {
  description = "List of alarms configured for the deployment group"
  type        = list(string)
  default     = []
}

variable "alarm_ignore_poll_alarm_failure" {
  description = "If a deployment should continue if information about the current state of alarms cannot be retrieved from Clouwatch"
  type        = bool
  default     = false
}

variable "triggers" {
  description = "Map of triggers to notify when events occur, valid event types: DeploymentSuccess, DeploymentStart etc."
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "map of tags to assign"
  type        = map(string)
  default     = {}
}
