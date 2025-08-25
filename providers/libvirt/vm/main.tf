# Base volume (backed by cloud image)
resource "libvirt_volume" "base" {
  name   = "${var.vm_name}-base-${substr(md5(var.base_image), 0, 6)}"
  source = var.base_image
  pool   = "default"
}

# Clone disk for VM
resource "libvirt_volume" "disk" {
  name           = "${var.vm_name}-${substr(md5(var.base_image), 0, 6)}.qcow2"
  base_volume_id = libvirt_volume.base.id
  pool           = "default"
  format         = "qcow2"
  size           = var.disk_size * 1024 * 1024 * 1024
}

# Cloud-init ISO with unique name
resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "${var.vm_name}-cloudinit-${substr(md5(var.cloudinit_tpl), 0, 6)}.iso"
  pool      = "default"
  user_data = var.cloudinit_tpl
}

# Virtual machine
resource "libvirt_domain" "vm" {
  name   = var.vm_name
  memory = var.memory
  vcpu   = var.vcpu
  
  cpu {
      mode = "host-passthrough"
  }

  network_interface {
    network_id     = var.network_id
    addresses = var.ip_address != null ? [var.ip_address] : null
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.disk.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
  }
}

