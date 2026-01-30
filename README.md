# Terraform GKE Autopilot with Fleet and Config Sync

This Terraform code provisions a GKE Autopilot cluster, registers it as a member of a Google Cloud Fleet, and configures Config Sync to synchronize the cluster's configuration with a Git repository.

## Features

-   Creates a GKE Autopilot cluster.
-   Registers the cluster to a fleet.
-   Enables and configures Config Sync on the cluster.
-   Manages required Google Cloud APIs.

## Usage

1.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

2.  **Review the plan:**
    ```bash
    terraform plan
    ```

3.  **Apply the configuration:**
    You will need to provide values for the variables, for example:
    ```bash
    terraform apply \
      -var="project_id=your-gcp-project-id" \
      -var="region=your-gcp-region" \
      -var="cluster_name=my-autopilot-cluster" \
      -var="git_repo=https://github.com/your-user/your-repo" \
      -var="git_branch=main" \
      -var="policy_dir=config"
    ```