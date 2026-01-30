output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = google_container_cluster.primary.endpoint
}

output "fleet_membership" {
  description = "The full name of the fleet membership."
  value       = google_gke_hub_membership.membership.id
}
