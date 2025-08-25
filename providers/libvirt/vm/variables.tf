variable "vm_name" {
  description = "VM name"
  type        = string
}

variable "base_image" {
  description = "Path to base cloud image"
  type        = string
}

variable "memory" {
  description = "RAM in MB"
  type        = number
  default     = 1024
}

variable "vcpu" {
  description = "Number of vCPUs"
  type        = number
  default     = 1
}

variable "disk_size" {
  description = "VM disk size in GB"
  type        = number
  default     = 20
}

variable "network_id" {
  description = "Network ID (libvirt only)"
  type        = string
  default     = null
}

variable "cloudinit_tpl" {
  description = "Cloud-init user-data content"
  type        = string
  default     = null
}

variable "ip_address" {
  description = "Static IP address for the VM (must be inside the network_cidr)"
  type        = list(string)
  default     = null
}
