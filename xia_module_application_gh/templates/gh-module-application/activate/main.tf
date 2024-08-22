terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}

locals {
  module_name = coalesce(var.module_name, substr(basename(path.module), 9, length(basename(path.module)) - 9))
}

resource "github_team" "foundation_admin" {
  for_each = var.foundations
  name        = "${each.value["name"]}-adm"
  description = "Foundation ${each.value["name"]} Administrator Team"
  privacy     = "closed"
}