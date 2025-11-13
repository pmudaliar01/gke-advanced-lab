output "region" { value = var.region }
output "zone"   { value = var.zone }
output "cluster_name" { value = google_container_cluster.gke.name }
