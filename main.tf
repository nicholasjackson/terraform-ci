terraform {
  backend "s3" {
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    endpoint                    = "https://tfremotestate.ams3.digitaloceanspaces.com"
    region                      = "us-east-1"                                         # Requires any valid AWS region
    bucket                      = ""                                                  # Space name
    key                         = "demo/terraform.tfstate"
  }
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1-${terraform.workspace}-dfdfd"
  region = "ams3"
  size   = "s-1vcpu-1gb"
}

resource "digitalocean_firewall" "web" {
  name = "only-22-80-${terraform.workspace}"

  droplet_ids = ["${digitalocean_droplet.web.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["192.168.1.0/24", "2002:1:2::/48"]
    },
  ]
}
