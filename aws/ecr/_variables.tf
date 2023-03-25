locals {
  name            = "armadillo-${replace(basename(path.cwd), "_", "-")}"
  cluster_version = "1.22"
  region          = "eu-west-1"

  tags = {
    Project    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}