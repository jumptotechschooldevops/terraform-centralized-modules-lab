locals {
  repo_matrix = merge([
    for team_name, team_data in var.teams : {
      for repo_name in team_data.repositories :
      "${team_name}-${repo_name}" => {
        team_name    = team_name
        repo_name    = repo_name
        scan_on_push = team_data.scan_on_push
        mutable_tags = team_data.mutable_tags
        max_images   = team_data.max_images
        team_owner   = team_data.team_owner
      }
    }
  ]...)
}

resource "aws_ecr_repository" "this" {
  for_each = local.repo_matrix

  name                 = "${var.environment}/${each.value.team_name}/${each.value.repo_name}"
  image_tag_mutability = each.value.mutable_tags ? "MUTABLE" : "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  force_delete = false

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-${each.value.team_name}-${each.value.repo_name}"
      Team        = each.value.team_name
      TeamOwner   = each.value.team_owner
      Repository  = each.value.repo_name
      Region      = var.region
      Environment = var.environment
    }
  )

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = local.repo_matrix

  repository = aws_ecr_repository.this[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only last ${each.value.max_images} images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = each.value.max_images
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
