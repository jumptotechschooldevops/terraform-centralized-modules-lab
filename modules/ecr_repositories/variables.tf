variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region for repository creation"
  type        = string
}

variable "teams" {
  description = "Teams and their repository configuration for this region"
  type = map(object({
    repositories = list(string)
    scan_on_push = bool
    mutable_tags = bool
    max_images   = number
    team_owner   = string
  }))
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}
