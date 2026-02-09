#!/bin/bash
# Complete HashiCorp Vault installation on Ubuntu from scratch

# 1. Update system and install prerequisites
sudo apt update
sudo apt install -y gpg curl lsb-release gnupg software-properties-common

# 2. Download and add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 3. Verify GPG key fingerprint (should match: 798A EC65 4E5C 1542 8C8E 42EE AA16 FCBC A621 E701)
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# 4. Add HashiCorp APT repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# 5. Update package lists and install Vault
sudo apt update
sudo apt install -y vault

# 6. Verify installation
vault --version

echo "✅ HashiCorp Vault installed successfully!"
echo "💡 Next steps: vault server -dev (for testing) or configure production setup"
