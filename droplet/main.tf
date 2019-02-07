resource "digitalocean_droplet" "web" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1-${terraform.workspace}"
  region = "ams3"
  size   = "s-1vcpu-1gb"
}

output "id" {
  value = "${digitalocean_droplet.web.id}"
}
