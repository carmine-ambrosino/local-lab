terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}

# Configure the Libvirt provider (KVM/QEMU)
provider "libvirt" {
  uri = "qemu:///system"
}