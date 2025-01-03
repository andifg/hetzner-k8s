variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "default_network_zone" {
  description = "Default region to deploy resources"
  type        = string
  default     = "eu-central"
}

variable "default_location" {
  description = "Default datacenter"
  type        = string
  default     = "fsn1"

}

variable "default_server_type" {
  description = "Default server type"
  type        = string
  default     = "cx22"
}

variable "ssh_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "default_server_image" {
  description = "Default server image"
  type        = string
  default     = "debian-12"
}

variable "default_labels" {
  description = "Default tags for resources"
  type        = map(string)
  default = {
    "env" = "dev"
  }
}
