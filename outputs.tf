output "vm_info" {
  description = "VMs created (name + IP if available)"
  value = {
    for k, v in module.vms :
    k => {
      name = v.vm_name
      ip   = try(v.vm_ip, null) # some providers may not expose IPs
    }
  }
}
