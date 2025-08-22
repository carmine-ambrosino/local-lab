# Examples
## Netcloud S3
This cloud-init script sets up [nextcloud-s3](https://github.com/carmine-ambrosino/nextcloud-s3) automatically.

>⚠️ **Heads up:** the setup isn’t instant. Your VM will need a bit of time to get everything in place—on average, around **10 to 15** minutes. 
So grab a coffee ☕, stretch your legs 🧘, or just stare meaningfully into the terminal while the magic happens.

### Monitoring setup
Once you're inside the VM (with ssh - view next section), here are a few handy commands to check how things are going:
- **Check cloud-init logs – see what the script is doing:** `sudo tail -f /var/log/cloud-init-output.log`
- **Check docker logs:** `sudo docker logs -f compose-nextcloud-aio-nextcloud-1`

>⚠️ Remeber to setup [nextcloud.local](https://github.com/carmine-ambrosino/nextcloud-s3?tab=readme-ov-file#2-setup-nextcloudlocal)

### `users` section
``` bash
#cloud-config
users:
  - name: yourusername
    groups: sudo, docker
    gecos: "SSH Access User"
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh-authorized-keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC...your-public-key...
```

#### 🚀 Generate an SSH Key Pair 
🔐 SSH keys are the secret sauce behind safe and smooth remote connections. Let’s get you set up with your very own key pair — step by step!


##### 🛠️ Step 1: Make Sure SSH Is Installed
Before we generate keys, we need to make sure your system has SSH tools ready to roll.
###### 🪟 Windows
- **Built-in SSH (Windows 10/11)**  
  Open PowerShell and type:
  ```powershell
  ssh -V
  ```
  
###### 🐧 Linux / 🍎 macOS
``` bash
which ssh
```

##### 🔐 Step 2: Generate Your SSH Key Pair
- Open your terminal and run:
``` bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
###### What does this do?
- -t rsa: Uses RSA encryption
-b 4096: Sets a strong 4096-bit key
-C: Adds a comment (usually your email)

You’ll be asked:
1. Where to save the key (press Enter for default: ~/.ssh/id_rsa)
2. To enter a passphrase (optional but adds extra security 💪)

##### Step 3: Find Your Keys
After generation, you’ll have two files:
- Private Key: ~/.ssh/id_rsa — keep this secret! 🤫
- Public Key: ~/.ssh/id_rsa.pub — this one you can share 🎁

##### Step 4: Use Your SSH Key
Let’s put that shiny new key to work!

#### ⚠️ Password-based authentication (for lab/testing only)
This configuration enables password login for a user. You must provide a hashed password.

``` bash
#cloud-config
users:
  - name: user
    gecos: "SSH Access User"
    groups: sudo, docker
    shell: /bin/bash
    lock_passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    passwd: "<PASSWORD HASH>"

ssh_pwauth: true
chpasswd:
  expire: false
```

##### Hash example
``` python
python3 -c 'import crypt; print(crypt.crypt("SECRETPASSWORD", crypt.mksalt(crypt.METHOD_SHA512)))'
```

⚠️ **Security Warning:** Password-based SSH access is vulnerable to brute-force attacks. This configuration is suitable for lab or testing environments only. For production, always use SSH key authentication.