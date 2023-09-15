provider "google" {
  project = "opz0-397319"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}
#####==============================================================================
##### vpc module call.
#####==============================================================================

module "vpc" {
  source                                    = "git::git@github.com:opz0/terraform-gcp-vpc.git?ref=master"
  name                                      = "app"
  environment                               = "test"
  label_order                               = ["name", "environment"]
  project_id                                = "opz0-397319"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

#####==============================================================================
##### subnet module call.
#####==============================================================================
module "subnet" {
  source                   = "git::git@github.com:opz0/terraform-gcp-subnet.git?ref=master"
  name                     = "subnet"
  environment              = "test"
  gcp_region               = "asia-northeast1"
  network                  = module.vpc.vpc_id
  project_id               = "opz0-397319"
  source_ranges            = ["10.10.0.0/16"]
}

#####==============================================================================
##### firewall module call.
#####==============================================================================
module "firewall" {
  source        = "git::git@github.com:opz0/terraform-gcp-firewall.git?ref=master"
  name          = "app"
  environment   = "test"
  project_id    = "opz0-397319"
  network       = module.vpc.vpc_id
  source_ranges = ["0.0.0.0/0"]

  allow = [
    { protocol = "tcp"
      ports    = ["22", "80"]
    }
  ]
}

#####==============================================================================
##### compute_instance module call.
#####==============================================================================
module "compute_instance" {
  source                    = "../"
  name                      = "app"
  environment               = "test"
  project_id                = "opz0-397319"
  instance_tags             = ["foo", "bar"]
  machine_type              = "e2-small"
  gcp_zone                  = "asia-northeast1-a"
  service_account_scopes    = ["cloud-platform"]
  subnetwork                = module.subnet.subnet_id

  metadata = {
    ssh-keys = <<EOF
      test:ssh-rsa AAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxbLLNM= suresh@suresh
    EOF
  }
}
