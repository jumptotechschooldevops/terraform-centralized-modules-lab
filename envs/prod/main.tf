module "ecr_use2" {
  source = "../../modules/ecr_repositories"

  providers = {
    aws = aws.use2
  }

  environment = var.environment
  region      = "us-east-2"

  # Get teams only for this region
  teams = lookup(var.teams_by_region, "us-east-2", {})

  common_tags = var.common_tags
}

module "ecr_usw1" {
  source = "../../modules/ecr_repositories"

  providers = {
    aws = aws.usw1
  }

  environment = var.environment
  region      = "us-west-1"

  # Get teams only for this region
  teams = lookup(var.teams_by_region, "us-west-1", {})

  common_tags = var.common_tags
}
