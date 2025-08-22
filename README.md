# 🧪 local-lab  
**Your personal cloud-in-a-box.**  
**Spin up virtual labs** with **OpenTofu** (or Terraform) + libvirt in **minutes.**  

*Simple. Modular. Fun.*

## ✨ Why local-lab?
Imagine spinning up a **Nextcloud server** ☁️ or a **Kali Linux hacking box** 🐉 with a single command.  

With `local-lab` you get:  
- 🚀 **One-command labs** ➡️ `tofu apply` and you’re live  
- 🧩 **Modular design** ➡️ easily add or clone VMs  
- 🔁 **Multi-VM scaling** with `count`  
- 💾 **Local-first** ➡️ no cloud dependency, no hidden costs   

It’s like having **AWS on your laptop**, but without the bill 💸.  


## ⚙️ Requirements
- [OpenTofu](https://opentofu.org/) or [Terraform](https://www.terraform.io/) `>= 0.13`  
- Linux host with **KVM/QEMU** and `libvirt`  
- Enough **disk space**  
  - Nextcloud VM disk size: **30 GB (max, thin-provisioned)**  
  - Kali VM disk size: **80 GB (max, thin-provisioned)**  
  > 💡 Real usage is much smaller at first — the VM disk grows only when data is written.  
- Downloaded cloud images (see below)  


## 🚀 Quickstart

### 1. Download Images
- [Debian 13 Generic Cloud](https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2)  
- [Kali Linux 2025.2 QEMU](https://cdimage.kali.org/current/kali-linux-2025.2-qemu-amd64.7z) ➡️ unzip to `.qcow2`  


### 2. Define your lab (`terraform.tfvars`)
You describe what you want. `local-lab` makes it real.  

```hcl
vm_groups = {
  nextcloud = {
    count          = 1
    base_image     = "./images/debian-13-genericcloud-amd64.qcow2"
    memory         = 6162
    vcpu           = 2
    disk_size      = 30
    cloudinit_file = "./cloud-init/nextcloud-example.yaml"
  }

  kali = {
    count          = 1
    base_image     = "./images/kali-linux-2025.2-qemu-amd64.qcow2"
    memory         = 2048
    vcpu           = 2
    disk_size      = 80
    cloudinit_file = "./cloud-init/kali-example.yaml"
  }
}
```

### 3. Launch local-lab
``` bash
tofu init
tofu apply
```

### 4. Destroy when done
``` bash
tofu destroy
```

## ❓ FAQ  
**Q: Can I spin up multiple identical VMs?**  
A: Yes. Just set `count` in your `terraform.tfvars` — instant clones with the same cloud-init configuration.  

**Q: Do I really need 80 GB free to run Kali?**  
A: Not immediately. The VM disk is **thin-provisioned** (`qcow2`), so it only grows as data is written. Still, make sure your host has enough capacity to handle the VM’s maximum size if needed.  

**Q: Do I need deep Terraform knowledge?**  
A: Not at all. You just tweak `terraform.tfvars`, run `tofu apply`, and enjoy your lab. The boilerplate is already handled.  

**Q: What kind of hardware do I need?**  
A: Any modern machine with virtualization enabled. Ensure enough RAM + disk for the number of VMs you plan to run.  

**Q: Can I use it for production?**  
A: The project is designed as a **lab environment** — ideal for learning, testing, hacking, or prototyping. For production, use a hardened setup.  

**Q: Will it support other providers?**  
A: Yes! Thanks to its **modular structure**, `local-lab` is designed to expand.  
Support for **VirtualBox** is already on the roadmap, making it easy to bring the same experience to different virtualization backends.  

**Q: What is the default network configuration?**  
A: By default, VMs are attached to a NATed virtual network and get IPs in the **192.168.250.x** range.  

**Q: How do credentials and access work?**  
A:  
- 🖥️ **VM Access (SSH)** ➡️ Defined in each VM’s **cloud-init YAML** (keys, users, passwords as you decide).  
- 🔑 **Kali Linux** ➡️ Default login: `kali` / `kali`.  
- ☁️ **Nextcloud** ➡️ Default login: `admin` / `changeme` but follow the setup described in [nextcloud-s3](https://github.com/carmine-ambrosino/nextcloud-s3/) before logging in. 


## 💡 Final Thought
`local-lab` is your **private mini-cloud**, always one command away.  
Spin up, hack, test, self-host — all **from your laptop**.  
