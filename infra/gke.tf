resource "google_container_cluster" "gke" {
  name     = "gke-adv"
  location = var.zone
  network  = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet.name

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  release_channel { channel = "REGULAR" }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  gateway_api_config { channel = "CHANNEL_STANDARD" }
}

resource "google_container_node_pool" "np" {
  cluster  = google_container_cluster.gke.name
  location = var.zone
  name     = "default-pool"
  node_count = 2

  node_config {
    machine_type = "e2-standard-4"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    workload_metadata_config { mode = "GKE_METADATA" }
    labels = { role = "general" }
  }

  autoscaling {
    min_node_count = 2
    max_node_count = 6
  }
}
