provider "google" {
  project = var.project_id
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_service" "container" {
  project                    = var.project_id
  service                    = "container.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "gkehub" {
  project                    = var.project_id
  service                    = "gkehub.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "anthos" {
  project                    = var.project_id
  service                    = "anthos.googleapis.com"
  disable_dependent_services = true
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # Fleet registration is handled by the gke_hub_membership resource
  fleet {
    project = data.google_project.project.project_id
  }

  # Enable Autopilot
  enable_autopilot = true

  # Dependencies
  depends_on = [
    google_project_service.container,
  ]
}

resource "google_gke_hub_membership" "membership" {
  project       = data.google_project.project.project_id
  membership_id = var.cluster_name
  location      = "global"

  endpoint {
    gke_cluster {
      resource_link = google_container_cluster.primary.id
    }
  }

  # Dependencies
  depends_on = [
    google_project_service.gkehub,
    google_container_cluster.primary,
  ]
}

resource "google_gke_hub_feature" "configmanagement" {
  name     = "configmanagement"
  project  = data.google_project.project.project_id
  location = "global"

  depends_on = [
    google_project_service.anthos,
  ]
}

resource "google_gke_hub_feature_membership" "config_sync_membership" {
  project    = data.google_project.project.project_id
  location   = "global"
  feature    = google_gke_hub_feature.configmanagement.name
  membership = google_gke_hub_membership.membership.membership_id

  configmanagement {
    version = "1.15.1" # Specify a Config Management version
    config_sync {
      git {
        sync_repo   = var.git_repo
        sync_branch = var.git_branch
        policy_dir  = var.policy_dir
        secret_type = "none" # Assumes a public repository
      }
    }
  }

  depends_on = [
    google_gke_hub_membership.membership,
  ]
}
