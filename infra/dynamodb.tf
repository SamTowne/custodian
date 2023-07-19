<<<<<<< HEAD
# resource "aws_dynamodb_table" "cloud_custodian_policy_config" {
#     name = "cloud_custodian_policy_config"
#     hash_key = "rule_id"
#     billing_mode = "PAY_PER_REQUEST"
# resource "aws_dynamodb_table" "cloud_custodian_policy_config" {
#     name = "cloud_custodian_policy_config_${var.env}"
#     hash_key = "rule_id"
#     billing_mode = "PAY_PER_REQUEST"

#     attribute {
#       name = "rule_id"
#       type = "N"
#     }
    
#     attribute {
#       name = "is_active"
#       type = "S"
#     }

#     global_secondary_index {
#       name = "is_active_index"
#       hash_key = "is_active"
#       projection_type = "ALL"
#     }

#     point_in_time_recovery {
#       enabled = true
#     }
# }