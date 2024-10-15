provider "aws" {
  region = "us-east-2"
}

module "backup_vault" {
  source     = "./modules/aws-backup"
  vault_name = "dev0-source"
  tags = {
    Environment = "dev0"
  }
}

module "backup_plan" {
  source             = "./modules/aws-backup"
  plan_name          = "dev-p1"
  rule_name          = "daily-backup"
  target_vault_name  = module.backup_vault.this.name
  schedule           = "cron(0 12 * * ? *)"
  cold_storage_after = 30
  delete_after       = 365
}

module "backup_selection" {
  source         = "./modules/aws-backup"
  selection_name = "my-backup-selection"
  iam_role_arn   = "arn:aws:iam::123456789012:role/AWSBackupDefaultServiceRole"
  plan_id        = module.backup_plan.this.id
  resources = [
    # Resources to protect
    "arn:aws:ec2:us-west-2:123456789012:volume/vol-0abcd1234efgh5678"
  ]
}
