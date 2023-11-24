# terraform-gcp-vm
# Google Cloud Infrastructure Provisioning with Terraform
## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [License](#license)

## Introduction
This project deploys a Google Cloud infrastructure using Terraform to create a VPC, subnets, firewall rules, and compute instances.

## Usage
This section configures a compute instance. It specifies the name, environment, project, instance tags, machine type, GCP zone, service account scopes, subnetwork (retrieved from the subnet module), and SSH keys for access.

```hcl
module "compute_instance" {
  source                 = "git::https://github.com/cypik/terraform-gcp-vm.git?ref=v1.0.0"
  name                   = "app"
  environment            = "test"
  instance_tags          = ["foo", "bar"]
  machine_type           = "e2-small"
  gcp_zone               = "asia-northeast1-a"
  service_account_scopes = ["cloud-platform"]
  subnetwork             = module.subnet.subnet_id

  ######### public IP if enable_public_ip is true
  enable_public_ip = true
  metadata = {
    ssh-keys = <<EOF
      test:ssh-rsa AAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxbLLNM= suresh@suresh
    EOF
  }
}
```
You can customize the input variables according to your specific requirements.

## Module Inputs

- 'name' The name of the compute instance.
- 'environment': The environment type.
- 'project_id' The GCP project ID.
- 'instance_tags': List of instance tags.
- 'machine_type': The GCP machine type.
- 'gcp_zone': The GCP zone.
- 'service_account_scopes': List of service account scopes.
- 'subnetwork': The subnet ID.
- 'metadata': Metadata, including SSH keys.
- 'public_ip' : public IP if enable_public_ip is true.

## Module Outputs
Each module may have specific outputs. You can retrieve these outputs by referencing the module in your Terraform configuration.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/cypik/terraform-gcp-vm/tree/master/_example) directory within this repository.

## Author
Your Name Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/cypik/terraform-gcp-vm/blob/master/LICENSE) file for details.
