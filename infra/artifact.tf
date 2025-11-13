resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "apps"
  description   = "Docker images for lab"
  format        = "DOCKER"
}
