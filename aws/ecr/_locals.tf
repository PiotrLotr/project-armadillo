locals {
  ecr_spec = {
    app = {
      ecr_name = "armadillo-app"
    }
    db = {
      ecr_name = "armadillo-db"
    }
  }

}
