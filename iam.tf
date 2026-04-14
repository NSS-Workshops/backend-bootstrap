#############################
# GitHub OIDC Provider
#############################
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1" # GitHub's OIDC thumbprint
  ]
}

#############################
# Trust Policy for GitHub OIDC
#############################
data "aws_iam_policy_document" "github_oidc_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/*"]
    }
  }
}

#############################
# IAM Role
#############################
resource "aws_iam_role" "github_oidc" {
  name               = "github_oidc"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_trust.json
  description        = "GitHub OIDC role"
}


resource "aws_iam_role_policy" oidc_inline_policy" {
  name = "oidc-inline-policy"
  role = aws_iam_role.github_oidc.id

  policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "FullAccessForWorkshopServices",
			"Effect": "Allow",
			"Action": [
				"dynamodb:*",
				"ec2:*",
				"ecr:*",
				"ecs:*",
				"rds:*",
				"s3:*",
				"lambda:*",
				"cloudfront:*",
				"elasticloadbalancing:*",
				"logs:*",
				"tag:*"
			],
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": [
				"iam:CreateRole",
				"iam:DeleteRole",
				"iam:GetRole",
				"iam:GetRolePolicy",
				"iam:UpdateRole",
				"iam:TagRole",
				"iam:UntagRole",
				"iam:AttachRolePolicy",
				"iam:DetachRolePolicy",
				"iam:PutRolePolicy",
				"iam:DeleteRolePolicy",
				"iam:ListRoles",
				"iam:ListAttachedRolePolicies",
				"iam:ListRolePolicies",
				"iam:PassRole",
				"iam:ListPolicies",
				"iam:GetPolicy",
				"iam:GetPolicyVersion",
				"iam:ListInstanceProfilesForRole"
			],
			"Resource": "*"
		}
	]
})
}