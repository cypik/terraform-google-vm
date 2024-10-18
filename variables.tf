variable "name" {
  type        = string
  default     = ""
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
  type        = bool
  default     = false
  description = "Predefined enable_public_ip  address for the instance."
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
  value       = var.instance_count
  description = "The value of the instance_count variable."
}

variable "enable_service_account" {
  type        = bool
  default     = false
  description = "Enable or disable the service account for the instance"
}

variable "boot_disk_size" {
  type        = number
  default     = 20
  description = "Boot disk size in GB"
}

variable "boot_disk_type" {
  type        = string
  default     = ""
  description = "Boot disk type"
}

variable "enable_shielded_instance_config" {
  type        = bool
  default     = false
  description = "Enable shielded instance config"
}

variable "shielded_instance_config" {
  type = map(bool)
  default = {
    enable_secure_boot          = false
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  description = "Shielded instance configuration options"
}

variable "enable_network_performance_config" {
  type        = bool
  default     = false
  description = "Enable network performance configuration"
}

variable "total_egress_bandwidth_tier" {
  type        = string
  default     = "STANDARD"
  description = "Egress bandwidth tier"
}

variable "nat_ip" {
  type        = string
  default     = ""
  description = "NAT IP address for public access"
}

variable "network_tier" {
  type        = string
  default     = "STANDARD"
  description = "Network tier for the public IP"
}

variable "public_ptr_domain_name" {
  type        = string
  default     = ""
  description = "Public PTR domain name for the instance"
}

variable "enable_ipv6" {
  type        = bool
  default     = false
  description = "Enable IPv6 access configuration"
}

variable "external_ipv6" {
  type        = string
  default     = ""
  description = "External IPv6 address"
}

variable "enable_alias_ip_range" {
  type        = bool
  default     = false
  description = "Enable alias IP range"
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "Service account email"
}

variable "service_account_scopes" {
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
  description = "Service account scopes"
}

variable "enable_display" {
  type        = bool
  default     = false
  description = "Enable display for the instance"
}

variable "can_ip_forward" {
  type        = bool
  default     = false
  description = "Allow IP forwarding"
}

variable "description" {
  type        = string
  default     = "VM instance created with Terraform"
  description = "Description for the instance"
}

variable "custom_hostname" {
  type        = string
  default     = ""
  description = "Custom hostname for the VM instance (RFC-1035 compliant)"
}

variable "enable_accelerator" {
  type        = bool
  default     = false
  description = "Enable GPU accelerator"
}

variable "accelerator_type" {
  type        = string
  default     = "nvidia-tesla-k80"
  description = "Type of GPU accelerator"
}

variable "accelerator_count" {
  type        = number
  default     = 1
  description = "Count of GPU accelerators"
}

variable "desired_status" {
  type        = string
  default     = "RUNNING"
  description = "Specifies the desired status for the resource. Default is RUNNING."
}

variable "local_disks" {
  type        = bool
  default     = false // Set the default value as per your requirement
  description = "Flag to determine if scratch disk should be created"
}

variable "auto_delete" {
  type        = bool
  default     = true
  description = "Determines whether the disk should be auto-deleted when the instance is deleted."
}

variable "device_name" {
  type        = string
  default     = "boot-disk"
  description = "Specifies the name of the device, typically for the boot disk."
}

variable "mode" {
  type        = string
  default     = "READ_WRITE"
  description = "Specifies the access mode for the device. Options are READ_WRITE or READ_ONLY."
}

variable "labels" {
  type = map(string)
  default = {
    environment = "production"
  }
  description = "A map of labels to assign to the resource, such as environment or other metadata."
}

variable "enable_confidential_compute" {
  type        = bool
  default     = false
  description = "Determines whether confidential compute should be enabled for the resource. Default is false."
}

variable "interface" {
  type        = string
  default     = "NVME"
  description = "Specifies the type of interface for the disk, such as NVME or SCSI."
}

variable "name_IPv6" {
  type        = string
  default     = "External IPv6"
  description = "Specifies the name for the network interface or IP configuration."
}

variable "network_tier_IPv6" {
  type        = string
  default     = "STANDARD"
  description = "Specifies the network tier for the interface. Options are PREMIUM or STANDARD."
}

variable "ip_cidr_range" {
  type        = string
  default     = ""
  description = "The primary IP CIDR range for the subnetwork."
}

variable "subnetwork_range_name" {
  type        = string
  default     = ""
  description = "The name of the secondary IP range for the subnetwork."
}

variable "nic_type" {
  type        = string
  default     = "GVNIC"
  description = "Specifies the network interface card (NIC) type, such as GVNIC or VIRTIO."
}

variable "stack_type" {
  type        = string
  default     = "IPV4_ONLY"
  description = "Specifies the IP stack type for the instance, such as IPV4_ONLY or IPV4_IPV6."
}

variable "queue_count" {
  type        = number
  default     = 1
  description = "Specifies the number of queues for the NIC. Default is 1."
}