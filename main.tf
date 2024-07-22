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

resource "google_cloud_scheduler_job" "job" {
  for_each = { for schedule in var.schedules : schedule.name => schedule }

  project          = var.project_id
  region           = var.region
  name             = each.value.name
  description      = each.value.description
  schedule         = each.value.schedule
  time_zone        = each.value.time_zone
  attempt_deadline = each.value.attempt_deadline

  retry_config {
    retry_count = each.value.retry_count
  }

  http_target {
    http_method = "POST"
    uri         = each.value.uri
    oauth_token {
      service_account_email = var.service_account_email
    }
  }
}