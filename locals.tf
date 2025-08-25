locals {
  vm_defs = merge([
    for group_name, group in var.vm_groups : {
      for i in range(group.count) : "${group_name}-${i}" => {
        vm_name       = "${group_name}-${i}"
        base_image    = group.base_image
        memory        = group.memory
        vcpu          = group.vcpu
        disk_size     = group.disk_size
        cloudinit_file= group.cloudinit_file
        ip_address = group.ip_address == null ? null : [group.ip_address[i]]
      }
    }
  ]...)
}
