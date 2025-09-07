terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

// https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "cloud-computing-a4-471403"
  region  = "us-west1"
  zone    = "us-west1-a"
}
