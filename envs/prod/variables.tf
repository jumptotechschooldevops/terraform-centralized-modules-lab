variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "teams_by_region" {
  description = "Team configuration organized by region"
  type = map(map(object({
    repositories = list(string)
    scan_on_push = bool
    mutable_tags = bool
    max_images   = number
    team_owner   = string
  })))
}
