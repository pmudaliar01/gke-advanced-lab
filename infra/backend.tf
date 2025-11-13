terraform {
  backend "gcs" {
    bucket = "gke-lab-project-477915-tf-state"
    prefix = "tfstate/infra"
  }
}
