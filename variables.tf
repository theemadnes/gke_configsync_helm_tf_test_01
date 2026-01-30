variable "project_id" {
  description = "The GCP project ID to host the GKE cluster."
  type        = string
}

variable "region" {
  description = "The GCP region for the GKE cluster."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "git_repo" {
  description = "The URL of the Git repository for Config Sync."
  type        = string
}

variable "git_branch" {
  description = "The branch in the Git repository to sync from."
  type        = string
  default     = "main"
}

variable "policy_dir" {
  description = "The directory in the Git repository to sync from."
  type        = string
  default     = "."
}
