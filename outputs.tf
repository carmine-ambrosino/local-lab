output "vm_info" {
  description = "VMs created"
  value = {
    for k, v in module.vms :
    k => {
      name = v.vm_name
      ip   = v.vm_ip 
    }
  }
}
