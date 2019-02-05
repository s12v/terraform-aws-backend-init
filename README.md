# terraform-aws-backend-init

Creats the following resources for Terraform S3 backend:

 - S3 bucket - Used to store Terraform state. Encrypted and versioned. Non-current versions expire after 30 days.
 - DynamoDB table - Used for Terraform state locking and consistency checking. Uses `PAY_PER_REQUEST` billing. Encrypted.

## Usage:

```
git clone https://github.com/s12v/terraform-aws-backend-init.git
cd terraform-aws-backend-init
terraform init
terraform apply
```

It will ask you for the AWS region and the state name:
```
var.terraform_state_name
  The name of the S3 bucket and DynamoDB table used for Terraform state, state locking and consistency checking

  Enter a value: tfstate-myproject
...
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

dynamodb_table = tfstate-myproject
terraform_bucket = tfstate-myproject
```

Use that name and the region in your backend configuration:
```
terraform {
  backend "s3" {
    bucket = "tfstate-myproject"
    dynamodb_table = "tfstate-myproject"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```
