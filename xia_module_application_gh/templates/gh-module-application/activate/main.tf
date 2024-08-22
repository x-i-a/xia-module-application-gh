terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}


data "github_user" "current" {
  username = ""
}

locals {
  module_name = coalesce(var.module_name, substr(basename(path.module), 9, length(basename(path.module)) - 9))

  github_config = yamldecode(file(var.config_file))
  _foundation_admins = lookup(local.github_config, "foundation_admins", {})

  foundation_admins = {
    for foundation_name, foundation_detail in var.foundations : foundation_name => lookup(local._foundation_admins, foundation_name, "not-found")
  }
}

resource "github_team" "foundation_admin_team" {
  for_each = var.foundations
  name        = "${each.value["name"]}-adm"
  description = "Foundation ${each.value["name"]} Administrator Team"
  privacy     = "closed"
}

resource "github_team_membership" "foundation_admin_member" {
  for_each = var.foundations
  team_id  = github_team.foundation_admin_team[each.key].id
  username = local.foundation_admins[each.key]
  role     = "maintainer"
}
