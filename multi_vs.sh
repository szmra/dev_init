#This code initializes multipass, vscode, generates ssh-key
brew install --cask multipass
ssh-keygen -y -t ed25519 -f ~/.ssh/multipass-ed25519 > ~/.ssh/multipass-ed25519.pub

multipass launch --name udev --cloud-init - <<EOF
#cloud-config
users:
  - default
  - name: s
    gecos: s
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    shell: /bin/bash
    ssh_import_id: None
    lock_passwd: true
    ssh_authorized_keys:
      - $(cat ~/.ssh/multipass-ed25519.pub)
package_update: true
package_upgrade: true
packages:
  - avahi-daemon
EOF

#adding ssh config to use specific ssh key
mkdir -p ~/.ssh/config.d
cat << EOF >> ~/.ssh/config.d/udev
Host udev
    HostName udev.local
    IdentitiesOnly yes
    IdentityFile ~/.ssh/multipass-ed25519
EOF

echo "Include config.d/udev" >> ~/.ssh/config
