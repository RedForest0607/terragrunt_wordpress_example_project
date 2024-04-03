locals {
    app_name_vars = read_terragrunt_config(find_in_parent_folders("app.hcl"))
    environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

    app_name = local.app_name_vars.locals.app_name
    env = local.environment_vars.locals.env
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
    required_providers {
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "2.27.0"
        }
    }
}

provider "kubernetes" {
    config_path = "~/.kube/config"
    config_context = "orbstack"
}
EOF
}

inputs = merge (
    local.app_name_vars.locals,
    local.environment_vars.locals,
)