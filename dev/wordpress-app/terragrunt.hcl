include "root" {
    path = find_in_parent_folders("common.hcl")
}

include "envcommon" {
    path = "../../_envcommon/wordpress.hcl"
}