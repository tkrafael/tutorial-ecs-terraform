terraform {
    # extra_arguments "no_lock" {
    #     commands = ["init", "plan", "apply"]
    #     arguments = ["-lock=false", "-lock-timeout=1s"]
    # }
}
locals {
    empty_file = find_in_parent_folders("empty.yml")
    root_config = merge(
        yamldecode(file(find_in_parent_folders("config.yml"))),
        yamldecode(file(find_in_parent_folders("config-overrides.yml", local.empty_file)))
    )
    shared_credentials_location = find_in_parent_folders("credentials.tfvars")
    state_bucket = can(local.root_config.state_bucket) ? local.root_config.state_bucket : "terraform-bucket"
    state_bucket_key = "${can(local.root_config.bucket_state_prefix) ? "${local.root_config.bucket_state_prefix}/" : ""}${path_relative_to_include()}.tfstate"
    state_region = can(local.root_config.state_region) ? local.root_config.state_region : local.root_config.aws_region
    aws_credential_profile = can(local.root_config.aws_credential_profile) ? local.root_config.aws_credential_profile : "${local.root_config.account}-${local.root_config.env}"
}

remote_state {
    backend = "s3"
    generate = {
        path = "${get_terragrunt_dir()}/backend.tf"
        if_exists = "overwrite"
    }
    config = {
        encrypt = true
        bucket = local.state_bucket
        key = local.state_bucket_key
        region = local.state_region
        dynamodb_table = local.state_bucket
        shared_credentials_file = local.shared_credentials_location
        profile                 = local.aws_credential_profile
    }
}

generate "provider" {
    path = "${get_terragrunt_dir()}/provider.tf"
    if_exists = "skip"
    contents = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= ${can(local.root_config.aws_provider_version) ? local.root_config.aws_provider_version : "4.38.0"}"
     }
  }
}
provider aws {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
  shared_credentials_file = "${find_in_parent_folders("credentials.tfvars")}"
  profile                 = "${local.aws_credential_profile}"

}
variable default_tags {
    type = map(string)
}
variable aws_region {
    type = string
}
variable env {
    type = string
}

EOF
}
inputs = local.root_config