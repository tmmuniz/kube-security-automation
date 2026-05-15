locals {
  oidc_ansible_role_name = element(
    split("/", var.arn_oidc_ansible_role),
    length(split("/", var.arn_oidc_ansible_role)) - 1
  )
}

resource "aws_iam_role_policy" "github_ansible_trivy_reports_s3" {
  name = "github-ansible-trivy-reports-s3"
  role = local.oidc_ansible_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowWriteTrivyReports"
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${var.adm_bucket_name}/trivy-reports/*"
      },
      {
        Sid    = "AllowReadTrivyReportsForPresign"
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::${var.adm_bucket_name}/trivy-reports/*"
      }
    ]
  })
}