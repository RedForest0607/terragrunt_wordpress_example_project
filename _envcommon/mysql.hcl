locals {
    app_name_vars = read_terragrunt_config(find_in_parent_folders("app.hcl"))
    app_name = local.app_name_vars.locals.app_name
}

terraform {
    source = "../../modules/mysql"
}

inputs = {
    name = "${local.app_name}-mysql"
    app_name = local.app_name
}