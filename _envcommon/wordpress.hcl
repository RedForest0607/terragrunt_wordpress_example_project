locals {
    app_name_vars = read_terragrunt_config(find_in_parent_folders("app.hcl"))
    app_name = local.app_name_vars.locals.app_name
}

terraform {
    source = "../../modules/wordpress"
}

inputs = {
    name = "wordpress"
    app_name = local.app_name
}