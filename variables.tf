variable terraform_state_name {
  type = "string"
  description = "The name of the S3 bucket and DynamoDB table used for Terraform state, state locking and consistency checking"
}

variable noncurrent_version_expiration {
  type = "number"
  description = "Days to expire non-current state versions"
  default = 30
}
