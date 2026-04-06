variable "github_org" {
  type        = string
  description = "GitHub organization or username"
  default     = "your-github-username"
}

variable "s3_bucket_name" {
  type        = string
  description = "name for s3 state bucket"
  default     = "rock-of-ages-terraform-state-your-initials"
}