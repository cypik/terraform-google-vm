module "labels" {
  source      = "git::git@github.com:opz0/terraform-gcp-labels.git?ref=master"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
}
#####==============================================================================
##### Manages a VM instance resource within GCE.
#####==============================================================================
resource "google_compute_instance" "default" {
  name         =format("%s-vm" , module.labels.id)
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = var.instance_tags
  project      = var.project_id
  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    subnetwork = var.subnetwork

    access_config {
      // Ephemeral public IP
      nat_ip = var.nat_ip
    }
  }
  metadata                = var.metadata
  metadata_startup_script = var.metadata_startup_script

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
  allow_stopping_for_update = var.allow_stopping_for_update
}