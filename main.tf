# Create a NAT network
resource "libvirt_network" "lab_net" {
  count     = var.provider_type == "libvirt" ? 1 : 0
  name      = "labnet-${terraform.workspace}"
  mode      = "nat"
  domain    = "labnet-${terraform.workspace}.local"
  addresses = [var.network_cidr]
  autostart = true
}


# Create VMs using libvirt module
module "vms" {
  source      = "./providers/${var.provider_type}/vm"
  for_each    = local.vm_defs

  vm_name     = each.value.vm_name
  base_image  = each.value.base_image
  memory      = each.value.memory
  vcpu        = each.value.vcpu
  disk_size   = each.value.disk_size
  cloudinit_tpl = each.value.cloudinit_file != null ? file(each.value.cloudinit_file) : null
  network_id  = var.provider_type == "libvirt" ? one(libvirt_network.lab_net[*].id) : null
  ip_address  = each.value.ip_address
}

