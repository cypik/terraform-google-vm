module "labels" {
  source      = "git::https://github.com/cypik/terraform-gcp-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
}

data "google_client_config" "current" {
}

#####==============================================================================
##### Manages a VM instance resource within GCE.
#####==============================================================================
#tfsec:ignore:google-compute-no-default-service-account
#tfsec:ignore:google-compute-no-public-ip
#tfsec:ignore:google-compute-no-project-wide-ssh-keys
#tfsec:ignore:google-compute-enable-shielded-vm-vtpm
#tfsec:ignore:google-compute-enable-shielded-vm-im
#tfsec:ignore:google-compute-vm-disk-encryption-customer-key
resource "google_compute_instance" "default" {
  name         = format("%s-vm", module.labels.id)
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = var.instance_tags
  project      = data.google_client_config.current.project
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

    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : []
      content {
        # Add access_config settings here if needed
      }
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
