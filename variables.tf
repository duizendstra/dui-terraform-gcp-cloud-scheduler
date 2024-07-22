variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
  default     = "europe-west1"
}

variable "service_account_email" {
  description = "The email of the service account to use for the scheduler"
  type        = string
}

variable "schedules" {
  description = "List of scheduler jobs"
  type = list(object({
    name             = string
    description      = string
    schedule         = string
    time_zone        = string
    attempt_deadline = string
    retry_count      = number
    uri              = string
  }))
}
