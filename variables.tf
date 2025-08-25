variable "provider_type" {
  description = "Which provider to use (e.g., libvirt, virtualbox)"
  type        = string
  default     = "libvirt"
}

variable "network_cidr" {
  description = "CIDR block for the libvirt NAT network"
  type        = string
  default     = "192.168.250.0/24"
}

variable "vm_groups" {
  description = "VM groups definition"
  type = map(object({
    count          = number
    base_image     = string
    memory         = number
    vcpu           = number
    disk_size      = number
    cloudinit_file = string
    ip_address     = optional(list(string))
  }))
}

