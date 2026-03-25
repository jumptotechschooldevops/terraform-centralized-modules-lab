output "repository_urls" {
  description = "Map of repository URLs"
  value = {
    for k, v in aws_ecr_repository.this : k => v.repository_url
  }
}

output "repository_names" {
  description = "Map of repository names"
  value = {
    for k, v in aws_ecr_repository.this : k => v.name
  }
}
