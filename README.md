# Terraform Centralized Modules Lab (Multi-Team, Multi-Region)

## Overview

This project demonstrates a **production-grade Terraform design** for:

- Multi-team infrastructure
- Multi-region deployment
- Centralized reusable modules
- Safe resource creation (no accidental destroy)

The goal is to simulate how **platform teams manage infrastructure for many application teams**.

---

## Key Concepts

- Root module vs child module
- Reusable centralized modules
- Multi-region using provider aliases
- Multi-team using maps + for_each
- Stable resource creation (no reindexing issues)
- Lifecycle protection (prevent_destroy)

---

## Project Structure

---

## Architecture

- One centralized module manages ECR repositories
- Multiple teams are defined via configuration
- Multiple regions are handled using provider aliases
- Each team can have multiple repositories

---

## Multi-Team Design

Teams are defined in:

`envs/prod/terraform.tfvars`

Example:

```hcl
teams_by_region = {
  us-east-2 = {
    team-alpha = {
      repositories = ["frontend", "backend"]
    }

    team-beta = {
      repositories = ["api"]
    }
  }
}
# terraform-centralized-modules-lab
# terraform-centralized-modules-lab
# terraform-centralized-modules-lab
