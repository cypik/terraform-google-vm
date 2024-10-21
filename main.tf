module "labels" {
  source      = "cypik/labels/google"
  version     = "1.0.2"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
  extra_tags  = var.extra_tags
}

data "google_client_config" "current" {}

#####==============================================================================
##### Manages a VM instance resource within GCE.
#####==============================================================================
#tfsec:ignore:google-compute-no-default-service-account
#tfsec:ignore:google-compute-no-public-ip
#tfsec:ignore:google-compute-no-project-wide-ssh-keys
#tfsec:ignore:google-compute-enable-shielded-vm-vtpm
#tfsec:ignore:google-compute-enable-shielded-vm-im
#tfsec:ignore:google-compute-vm-disk-encryption-customer-key
resource "google_compute_instance" "vm_instance" {
  count                     = var.create_instances && var.instance_count > 0 ? var.instance_count : 0
  name                      = format("%s-vm-%02d", module.labels.id, count.index + 1)
  machine_type              = var.machine_type
  zone                      = var.zone
  tags                      = var.instance_tags
  project                   = data.google_client_config.current.project
  metadata                  = var.metadata
  metadata_startup_script   = var.metadata_startup_script
  allow_stopping_for_update = var.allow_stopping_for_update
  can_ip_forward            = var.can_ip_forward
  description               = var.description
  desired_status            = var.desired_status
  enable_display            = var.enable_display
  hostname                  = var.custom_hostname

  boot_disk {
    auto_delete = var.auto_delete
    device_name = var.device_name
    mode        = var.mode

    initialize_params {
      size                        = var.boot_disk_size
      type                        = var.boot_disk_type
      image                       = var.image
      labels                      = var.labels
      enable_confidential_compute = var.enable_confidential_compute
    }
  }

  dynamic "scratch_disk" {
    for_each = var.local_disks ? [1] : [] // Create scratch disk if local_disks is true

    content {
      interface = var.interface
    }
  }
  dynamic "shielded_instance_config" {
    for_each = var.enable_shielded_instance_config ? [1] : []
    content {
      enable_secure_boot          = lookup(var.shielded_instance_config, "enable_secure_boot", false)
      enable_vtpm                 = lookup(var.shielded_instance_config, "enable_vtpm", true)
      enable_integrity_monitoring = lookup(var.shielded_instance_config, "enable_integrity_monitoring", true)
    }
  }

  dynamic "network_performance_config" {
    for_each = var.enable_network_performance_config ? [1] : []
    content {
      total_egress_bandwidth_tier = var.total_egress_bandwidth_tier
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : []
      content {
        nat_ip                 = var.nat_ip
        network_tier           = var.network_tier
        public_ptr_domain_name = var.public_ptr_domain_name
      }
    }

    dynamic "ipv6_access_config" {
      for_each = var.enable_ipv6 ? [1] : []
      content {
        external_ipv6 = var.external_ipv6
        name          = var.name_IPv6
        network_tier  = var.network_tier_IPv6
      }
    }

    dynamic "alias_ip_range" {
      for_each = var.enable_alias_ip_range ? [1] : []
      content {
        ip_cidr_range         = var.ip_cidr_range
        subnetwork_range_name = var.subnetwork_range_name
      }
    }
    nic_type    = var.nic_type
    stack_type  = var.stack_type
    queue_count = var.queue_count
  }

  dynamic "service_account" {
    for_each = var.enable_service_account ? [1] : []
    content {
      email  = var.service_account_email
      scopes = var.service_account_scopes
    }
  }

  dynamic "guest_accelerator" {
    for_each = var.enable_accelerator ? [1] : []
    content {
      type  = var.accelerator_type  #  "nvidia-tesla-k80"
      count = var.accelerator_count # 2
    }
  }

}
