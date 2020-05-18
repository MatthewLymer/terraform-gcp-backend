locals {
  region = "northamerica-northeast1"
  billing_account = "017629-BB9381-1C2281"
  
  project = {
	id = "matthewlymer-terraform-states"
	name = "Terraform States"
  }
}

provider "google" {
  region  = local.region
  project = local.project.id
}

resource "google_project" "default" {
  project_id = local.project.id
  name = local.project.name
  billing_account = local.billing_account
}

resource "google_storage_bucket" "tfstate_bucket" {
  name = "${google_project.default.number}-tfstate"
  location = local.region
  storage_class = "STANDARD"
}

terraform {
  # NOTE:
  #   When first running this project, the tfstate_bucket won't exist
  #   so comment out the backend lines, do a terraform init & apply
  #   then uncomment out the backend lines, do another terraform init & apply
  #   to start using the backend

  backend "gcs" {
    bucket = "490635812867-tfstate"
    prefix  = "matthewlymer-terraform-states"
  }
}