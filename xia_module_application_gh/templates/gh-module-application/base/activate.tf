module "activate_gh_module_application" {
  source = "../../modules/activate-gh-module-application"

  landscape = local.landscape
  foundations = local.foundations

}
