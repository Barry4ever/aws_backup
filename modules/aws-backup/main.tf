resource "aws_backup_vault" "this" {
  name = var.backup_vault.vault_name
  tags = var.tags
}

resource "aws_backup_plan" "this" {
  name = var.plan_name
  rule {
    rule_name         = var.rule_name
    target_vault_name = var.target_vault_name
    schedule          = var.schedule
    lifecycle {
      cold_storage_after = var.cold_storage_after
      delete_after       = var.delete_after
    }
  }
}

resource "awsbackup_selection" "this" {
  iam-role-arn = var.iam_role_arn
  name         = var.selection_name
  plan-id      = var.plan_id
  resources    = var.resources
}


variable "vault_name" {
  description = "The name of the backup vault"
  type        = string
}

variable "tags" {
  description = "Tags for the backup vault"
  type        = map(string)
  default     = {}
}

variable "plan_name" {
  description = "The name of the backup plan"
  type        = string
}

variable "rule_name" {
  description = "The name of the backup rule"
  type        = string
}

variable "target_vault_name" {
  description = "The name of the target backup vault"
  type        = string
}

variable "schedule" {
  description = "The schedule for the backup rule"
  type        = string
}

variable "cold_storage_after" {
  description = "Days after creation to move to cold storage"
  type        = number
  default     = 0
}

variable "delete_after" {
  description = "Days after creation to delete the backup"
  type        = number
  default     = 0
}

variable "selection_name" {
  description = "The name of the backup selection"
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role that AWS Backup uses"
  type        = string
}

variable "plan_id" {
  description = "The ID of the backup plan"
  type        = string
}

variable "resources" {
  description = "The resources to be backed up"
  type        = list(string)
}
