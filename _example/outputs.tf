output "name" {
  value       = module.compute_instance.name
  description = "The ID of the VPC."
}

output "self_link" {
  value       = module.compute_instance.self_link
  description = "The self_link of the instance."
}

output "instance_id" {
  value       = module.compute_instance.instance_id
  description = "The server-assigned unique identifier of this instance."
}

output "metadata_fingerprint" {
  value       = module.compute_instance.metadata_fingerprint
  description = "The unique fingerprint of the metadata."
}

output "tags_fingerprint" {
  value       = module.compute_instance.tags_fingerprint
  description = "The unique fingerprint of the tags."
}

output "label_fingerprint" {
  value       = module.compute_instance.label_fingerprint
  description = "The unique fingerprint of the labels."
}

output "cpu_platform" {
  value       = module.compute_instance.cpu_platform
  description = "The CPU platform used by this instance."
}

output "current_status" {
  value       = module.compute_instance.current_status
  description = "The current status of the instance. "
}

output "instance_count" {
  value       = module.compute_instance.instance_count
  description = "The value of the instance_count variable."
}