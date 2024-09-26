terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~> 17.4.0"
    }
  }
}

variable "gitlab_token" {}

provider "gitlab" {
  token = var.gitlab_token
}

resource "gitlab_user" "test_user" {
  name             = "Test User"
  username         = "test"
  password         = file("${path.module}/../secrets/gitlab-user-password")
  email            = "test@example.com"
  is_admin         = false
  can_create_group = false
  is_external      = false
  reset_password   = false
}

resource "gitlab_project" "candidate_mgr" {
  name        = "candidate-mgr"
  description = "Simple candidate manager"

  namespace_id = gitlab_user.test_user.namespace_id
  visibility_level = "public"
  initialize_with_readme = false
  default_branch = "master"
}

resource "gitlab_user_runner" "candidate_mgr_runner" {
  runner_type = "project_type"
  project_id  = gitlab_project.candidate_mgr.id

  description = "candidate-mgr default runner"
  tag_list     = ["docker", "linux"]
  untagged    = true
}

output "runner_token" {
  value = gitlab_user_runner.candidate_mgr_runner.token
  sensitive = true
}
