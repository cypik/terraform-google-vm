variable "name" {
  type        = string
  default     = "test"
  description = "Name of the resource. Provided by the client when the resource is created. "
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = "info@cypik.com"
  description = "ManagedBy, e.g. 'info@cypik.com'."
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for the resource."
}

variable "repository" {
  type        = string
  default     = "https://github.com/cypik/terraform-google-vm"
  description = "Terraform current module repo"
}

variable "image" {
  type        = string
  default     = "ubuntu-2204-jammy-v20230908"
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
}

variable "machine_type" {
  type        = string
  default     = ""
  description = "Machine type to create, e.g. n1-standard-1"
}

variable "zone" {
  type        = string
  default     = ""
  description = "The GCP zone to create resources in"
}

variable "subnetwork" {
  type        = string
  default     = ""
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
}

variable "network" {
  type        = string
  default     = ""
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
}

variable "instance_tags" {
  type        = list(string)
  default     = []
  description = "Network tags, provided as a list"
}

variable "metadata_startup_script" {
  type        = string
  default     = ""
  description = "User startup script to run when instances spin up"
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "Metadata, provided as a map"
}

variable "allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "must be set to true or your instance must have a desired_status of TERMINATED in order to update this field."
}

variable "enable_public_ip" {
  description = "Predefined enable_public_ip  address for the instance."
  type        = bool
  default     = false
}

variable "create_instances" {
  type        = bool
  default     = true
  description = "Toggle to determine whether instances should be created or not. Set to 'true' to create instances, 'false' to skip instance creation."
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "The number of instances to create."
}

output "instance_count_output" {
  description = "The value of the instance_count variable."
  value       = var.instance_count
}


#variable "disk_encryption_key_raw" {
#  description = "Raw disk encryption key for the instance."
#  type        = string
#  default     = "your_raw_encryption_key_here"
#}

#variable "kms_key_self_link" {
#  description = "Self link of the KMS key."
#  type        = string
#  default     = "projects/my-project/locations/us-central1/keyRings/my-key-ring/cryptoKeys/my-key"
#}



#variable "data_disk_size" {
#  description = "Size of the data disk in GB."
#  type        = number
#  default     = 50
#}
#
#variable "region" {
#  description = "Region for the VM IP."
#  type        = string
#  default     = "us-central1"
#}



variable "enable_service_account" {
  description = "Enable or disable the service account for the instance"
  type        = bool
  default     = false
}



#variable "vm_machine_type" {
#  description = "Machine type for the VM instance"
#  type        = string
#  default     = "e2-medium"
#}

#variable "vm_zone" {
#  description = "Zone for the VM instance"
#  type        = string
#  default     = "us-central1-a"
#}


variable "boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-standard"
}

#variable "enable_partner_metadata" {
#  description = "Enable partner metadata"
#  type        = bool
#  default     = false
#}

#variable "partner_metadata_key" {
#  description = "Partner metadata key"
#  type        = string
#  default     = ""
#}

#variable "partner_metadata_value" {
#  description = "Partner metadata value"
#  type        = any
#  default     = {}
#}

variable "enable_shielded_instance_config" {
  description = "Enable shielded instance config"
  type        = bool
  default     = false
}

variable "shielded_instance_config" {
  description = "Shielded instance configuration options"
  type        = map(bool)
  default = {
    enable_secure_boot          = false
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

#variable "data_disk_name" {
#  description = "Name of the attached data disk"
#  type        = string
#  default     = "data-disk"
#}

variable "enable_network_performance_config" {
  description = "Enable network performance configuration"
  type        = bool
  default     = false
}

variable "total_egress_bandwidth_tier" {
  description = "Egress bandwidth tier"
  type        = string
  default     = "STANDARD"
}





variable "nat_ip" {
  description = "NAT IP address for public access"
  type        = string
  default     = ""
}

variable "network_tier" {
  description = "Network tier for the public IP"
  type        = string
  default     = "STANDARD"
}

variable "public_ptr_domain_name" {
  description = "Public PTR domain name for the instance"
  type        = string
  default     = ""
}



variable "enable_ipv6" {
  description = "Enable IPv6 access configuration"
  type        = bool
  default     = false
}

variable "external_ipv6" {
  description = "External IPv6 address"
  type        = string
  default     = ""
}

variable "enable_alias_ip_range" {
  description = "Enable alias IP range"
  type        = bool
  default     = false
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
  default     = ""
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "enable_display" {
  description = "Enable display for the instance"
  type        = bool
  default     = false
}

variable "can_ip_forward" {
  description = "Allow IP forwarding"
  type        = bool
  default     = false
}

variable "description" {
  description = "Description for the instance"
  type        = string
  default     = "VM instance created with Terraform"
}

variable "custom_hostname" {
  description = "Custom hostname for the VM instance (RFC-1035 compliant)"
  type        = string
  default     = ""
}

variable "enable_accelerator" {
  description = "Enable GPU accelerator"
  type        = bool
  default     = false
}

variable "accelerator_type" {
  description = "Type of GPU accelerator"
  type        = string
  default     = "nvidia-tesla-k80"
}

variable "accelerator_count" {
  description = "Count of GPU accelerators"
  type        = number
  default     = 1
}

variable "desired_status" {
  type    = string
  default = "RUNNING"
}

variable "local_disks" {
  description = "Flag to determine if scratch disk should be created"
  type        = bool
  default     = false // Set the default value as per your requirement
}
