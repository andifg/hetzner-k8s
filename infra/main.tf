
# Network
resource "hcloud_network" "mynet" {
  name     = "my-net"
  ip_range = "10.0.0.0/8"
}
# Subnet 1
resource "hcloud_network_subnet" "master-subnet" {
  network_id   = hcloud_network.mynet.id
  type         = "cloud"
  network_zone = var.default_network_zone
  ip_range     = "10.0.1.0/24"
}

# Load Balancer
resource "hcloud_load_balancer" "load_balancer" {
  name               = "my-load-balancer"
  load_balancer_type = "lb11"
  location           = var.default_location
}

resource "hcloud_load_balancer_network" "load-balancer-network" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  network_id       = hcloud_network.mynet.id

  depends_on = [
    hcloud_network_subnet.master-subnet
  ]
}

resource "hcloud_load_balancer_target" "master-01" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  server_id        = hcloud_server.master-01.id
}

resource "hcloud_load_balancer_service" "ssh-master-01" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "tcp"
  listen_port      = 2222
  destination_port = 22
}



resource "hcloud_server" "master-01" {
  name        = "master-01"
  server_type = var.default_server_type
  image       = var.default_server_image
  location    = var.default_location
  labels = merge(
    { server = "master-01" }, // Default values
  var.default_labels)

  ssh_keys = [hcloud_ssh_key.main.id]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }


  network {
    network_id = hcloud_network.mynet.id
    alias_ips = [
    ]
  }
}

# SSH Key
resource "hcloud_ssh_key" "main" {
  name       = "my-ssh-key"
  public_key = file(var.ssh_key_path)
}
