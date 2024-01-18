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
  default     = "cypik"
  description = "ManagedBy, eg 'cypik'."
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

variable "gcp_zone" {
  type        = string
  default     = ""
  description = "The GCP zone to create resources in"
}

variable "subnetwork" {
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

variable "service_account_email" {
  type        = string
  default     = ""
  description = "The service account e-mail address. "
}

variable "service_account_scopes" {
  type        = list(string)
  default     = []
  description = "A list of service scopes."
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
