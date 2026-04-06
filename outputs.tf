output "github_oidc_role_arn" {
  description = "ARN of the IAM role used by GitHub OIDC"
  value       = aws_iam_role.github_oidc.arn
}