#!/bin/bash

# HashiCorp Vault Installation Script for Ubuntu
# Run as root or with sudo

set -e  # Exit on any error

echo "Updating system and installing prerequisites..."
apt update
apt install -y curl gnupg software-properties-common lsb-release

echo "Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

echo "Installing Vault..."
apt update
apt install -y vault

echo "Verifying installation..."
vault version

echo "Creating Vault user and directories..."
useradd --system --home-dir /etc/vault.d --shell /bin/false vault
mkdir -p /etc/vault.d /opt/vault/data /var/log/vault
chown -R vault:vault /etc/vault.d /opt/vault /var/log/vault
chmod 750 /etc/vault.d /opt/vault/data

echo "Vault installed successfully. Next steps:"
echo "1. Create /etc/vault.d/vault.hcl config file (see example below)"
echo "2. Enable and start: systemctl enable --now vault"
echo "3. Initialize: vault operator init (after setting VAULT_ADDR)"
