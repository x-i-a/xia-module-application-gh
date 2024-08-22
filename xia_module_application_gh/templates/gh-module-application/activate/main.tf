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

data "github_user" "current" {
  username = ""
}

resource "github_team" "foundation_admin" {
  for_each = var.foundations
  name        = "${each.value["name"]}-adm"
  description = "Foundation ${each.value["name"]} Administrator Team"
  privacy     = "closed"
}

resource "github_team_membership" "current_user_admin" {
  for_each = var.foundations
  team_id  = github_team.foundation_admin[each.key].id
  username = data.github_user.current.login
  role     = "maintainer"
}
