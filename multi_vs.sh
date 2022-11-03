#!/bin/zsh
#This code initializes multipass, vscode, generates ssh-key
VM_NAME=$1
ssh-keygen -t ed25519 -f ~/.ssh/$VM_NAME-ed25519 -N ""

multipass launch --name $VM_NAME --cloud-init - <<EOF
#cloud-config
users:
  - default
  - name: s
    gecos: s
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    shell: /bin/bash
    ssh_import_id: None
    lock_passwd: false
    ssh_authorized_keys:
      - $(cat ~/.ssh/${VM_NAME}-ed25519.pub)
package_update: true
package_upgrade: true
packages:
  - avahi-daemon
EOF

#adding ssh config to use specific ssh key
mkdir -p ~/.ssh/config.d
cat << EOF >> ~/.ssh/config.d/$VM_NAME
Host $VM_NAME
    HostName $VM_NAME.local
    IdentitiesOnly yes
    IdentityFile ~/.ssh/$VM_NAME-ed25519
EOF

echo "Include config.d/$VM_NAME" >> ~/.ssh/config
