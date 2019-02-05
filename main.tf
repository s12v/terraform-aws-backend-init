provider "aws" {}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.terraform_state_name}"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    expiration {
      expired_object_delete_marker = true
    }
    noncurrent_version_expiration {
      days = 1
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "${var.terraform_state_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "terraform_bucket" {
  value = "${var.terraform_state_name}"
}

output "dynamodb_table" {
  value = "${var.terraform_state_name}"
}

