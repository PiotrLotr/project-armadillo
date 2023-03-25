data "aws_caller_identity" "current" {}

module "ecr" {
  for_each = {for spec in local.ecr_spec : spec.ecr_name => spec}
  source = "terraform-aws-modules/ecr/aws"

  repository_name = each.value.ecr_name

  repository_read_write_access_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
