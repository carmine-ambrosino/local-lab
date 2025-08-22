# WLS2 Local lab
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

## Enable Nested Virtualization for WSL2
1. Find the WSL VM name 
In PowerShell (Admin):
``` powershell
Get-VM
```
Look for the VM named WSL or similar.

2. Expose virtualization extensions:
``` powershell
Set-VMProcessor -VMName <YourWSLVMName> -ExposeVirtualizationExtensions $true
```

3. Allocate enough resources 
Create or edit C:\Users\<YourUser>\.wslconfig:
``` bash
[wsl2]
memory=12GB
processors=6
```

4. Restart WSL
``` powershell
wsl --shutdown
```

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

## Install opentofu

## Clone repository

## Init e apply
``` bash
tofu init
tofu apply
``` 