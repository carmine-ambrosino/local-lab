# WSL2 Local lab
## Prerequisites
Before starting, make sure you have:

- Windows 10/11 (Pro, Enterprise, or Home) with the latest updates
- A CPU supporting Intel VT‑x or AMD‑V
- Virtualization enabled in BIOS/UEFI
- Administrator rights on Windows
- Enough memory e virtual cpu to run your lab

## Install WSL2 and a Linux Distribution
1. Enable WSL and Virtual Machine Platform.
Open PowerShell as Administrator:
``` powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

2. Set WSL2 as the default version:
``` powershell
wsl --set-default-version 2
```

3. Install Linux on WSL2
``` powershell
wsl --install -d Ubuntu
```

4. Launch Ubuntu and create your Linux user.

## WSL2 setting
Make sure you have enough RAM and vCPU for WSL. Check WSL Settings.
More info: [Learn Microsoft WSL config](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconfig)

## Install KVM and libvirt in WSL2

1. Inside your **WSL2** terminal:
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```

2. Enable and start libvirt:
``` bash
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
```

3. Add your user to the libvirt group:
``` bash
sudo usermod -aG libvirt $(whoami)
```

## Install required packages
``` bash
sudo apt install curl git
``` 

## Install opentofu
``` bash
# Download the installer script:
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
# Alternatively: wget --secure-protocol=TLSv1_2 --https-only https://get.opentofu.org/install-opentofu.sh -O install-opentofu.sh

# Give it execution permissions:
chmod +x install-opentofu.sh

# Please inspect the downloaded script

# Run the installer:
./install-opentofu.sh --install-method deb

# Remove the installer:
rm -f install-opentofu.sh
```

## Clone repository
``` bash
git clone https://github.com/carmine-ambrosino/local-lab.git
cd local-lab
```

## Create your .tfvars
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

> ⚠️ Make sure of your cloud-init file

## Init e apply
``` bash
tofu init
tofu apply
``` 