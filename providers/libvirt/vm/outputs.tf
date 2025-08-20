# Outputs
output "vm_name" {
  value = var.vm_name
}

output "vm_ip" {
  value = try(libvirt_domain.vm.network_interface[0].addresses[0], null)
}
