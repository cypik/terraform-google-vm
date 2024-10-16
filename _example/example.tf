provider "google" {
  project = "soy-smile-435017-c5"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### vpc module call.
#####==============================================================================
module "vpc" {
  source                                    = "cypik/vpc/google"
  version                                   = "1.0.2"
  name                                      = "apps"
  environment                               = "test"
  routing_mode                              = "REGIONAL"
  mtu                                       = 1500
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}

#####==============================================================================
##### subnet module call.
#####==============================================================================
module "subnet" {
  source        = "cypik/subnet/google"
  version       = "1.0.2"
  name          = "app"
  environment   = "test"
  subnet_names  = ["subnet-a"]
  region        = "asia-northeast1"
  network       = module.vpc.vpc_id
  ip_cidr_range = ["10.10.1.0/24"]
}

#####==============================================================================
##### firewall module call.
#####==============================================================================
module "firewall" {
  source      = "cypik/firewall/google"
  version     = "1.0.2"
  name        = "app"
  environment = "test"
  network     = module.vpc.vpc_id
  ingress_rules = [
    {
      name          = "allow-tcp-http-ingress"
      description   = "Allow TCP, HTTP ingress traffic"
      disabled      = false
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22", "80"]
        }
      ]
    }
  ]
}

#####==============================================================================
##### compute_instance module call.
#####==============================================================================
module "compute_instance" {
  source                 = "../"
  name                   = "app"
  environment            = "test"
  instance_count         = 1
  zone                   = "asia-northeast1-a"
  instance_tags          = ["foo", "bar"]
  machine_type           = "n1-standard-2"
  image                  = "ubuntu-2204-jammy-v20230908"
  service_account_scopes = ["cloud-platform"]
  subnetwork             = module.subnet.subnet_id
  network                = module.vpc.vpc_id

  enable_public_ip = true # Enable public IP only if enable_public_ip is true
  metadata = {
    ssh-keys = <<EOF
      ssh-rsa AAAAB3NzaCph/FXUAHBaekf+hzL58= suresh@suresh
    EOF
  }
}