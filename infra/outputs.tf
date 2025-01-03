
output "info_message" {
    value = <<EOF
    The infrastructure has been created successfully.
    You can access the hosts via the load balancer IP: ${hcloud_load_balancer.load_balancer.ipv4}
    EOF
    description = "Information message"
}

output "hcloud_load_balancer_ip_v4" {
  value = hcloud_load_balancer.load_balancer.ipv4
}