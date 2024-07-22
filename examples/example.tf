terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.38.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.38.0"
    }
  }
}

module "scheduler" {
  source                = "./.."
  project_id            = "your-project-id"
  service_account_email = "your-service-account@your-project-id.iam.gserviceaccount.com"
  schedules = [
    {
      name             = "daily-data-sync"
      description      = "Daily job to sync data"
      schedule         = "0 2 * * *"
      time_zone        = "America/Los_Angeles"
      attempt_deadline = "20s"
      retry_count      = 3
      uri              = "https://workflowexecutions.googleapis.com/v1/projects/your-project-id/locations/your-region/workflows/your-workflow/executions"
    }
  ]
}
