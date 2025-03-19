terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.19"
    }
  }
}

provider "spacelift" {}


resource "spacelift_stack" "this" {
  name              = "Test stack"
  repository        = "simple-module" # https://github.com/Apollorion/simple-module
  branch            = "main"
  terraform_version = var.terraform_version
}

resource "spacelift_run" "this" {
  stack_id = spacelift_stack.this.id

  keepers = {
    branch = spacelift_stack.this.branch # remove for different error message
    terraform_version = spacelift_stack.this.terraform_version
  }
}


variable "terraform_version" {
  type    = string
  default = null
}
