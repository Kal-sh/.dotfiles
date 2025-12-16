#!/bin/bash

set -e

echo "=== Secure Server Setup: SSH-Key Only + Fail2ban + UFW ==="
echo "WARNING: After this script, PASSWORD login will be disabled."
echo "Make sure your SSH key is already installed on this server!"
echo ""
read -p "Press ENTER to continue or CTRL+C to abort..."

echo ">>> Updating packages..."
sudo apt update

echo ">>> Installing OpenSSH Server..."
sudo apt install -y openssh-server

echo ">>> Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo ">>> Configuring SSH for key-only login..."
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

echo ">>> Restarting SSH service..."
sudo systemctl restart ssh

echo ">>> Installing Fail2ban..."
sudo apt install -y fail2ban

echo ">>> Configuring Fail2ban (SSH jail)..."
sudo bash -c 'cat > /etc/fail2ban/jail.local' <<EOF
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 4
backend = systemd

[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
EOF

echo ">>> Restarting Fail2ban..."
sudo systemctl restart fail2ban

echo ">>> Installing UFW firewall..."
sudo apt install -y ufw

echo ">>> Allowing SSH through firewall..."
sudo ufw allow ssh

echo ">>> Enabling UFW firewall..."
sudo ufw --force enable

echo ""
echo "=== Server Secured Successfully ==="
echo "Password login is DISABLED."
echo "SSH key authentication is ENABLED."
echo "Fail2ban is protecting SSH."
echo ""

IP=$(hostname -I | awk '{print $1}')
echo "You can now SSH into this server using:"
echo ""
echo "    ssh $USER@$IP"
echo ""
#!/bin/bash

set -e

echo "=== Secure Server Setup: SSH-Key Only + Fail2ban + UFW ==="
echo "WARNING: After this script, PASSWORD login will be disabled."
echo "Make sure your SSH key is already installed on this server!"
echo ""
read -p "Press ENTER to continue or CTRL+C to abort..."

echo ">>> Updating packages..."
sudo apt update

echo ">>> Installing OpenSSH Server..."
sudo apt install -y openssh-server

echo ">>> Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo ">>> Configuring SSH for key-only login..."
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*UsePAM.*/UsePAM no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

echo ">>> Restarting SSH service..."
sudo systemctl restart ssh

echo ">>> Installing Fail2ban..."
sudo apt install -y fail2ban

echo ">>> Configuring Fail2ban (SSH jail)..."
sudo bash -c 'cat > /etc/fail2ban/jail.local' <<EOF
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 4
backend = systemd

[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
EOF

echo ">>> Restarting Fail2ban..."
sudo systemctl restart fail2ban

echo ">>> enabling Fail2ban..."
sudo systemctl enable fail2ban

echo ">>> Installing UFW firewall..."
sudo apt install -y ufw

echo ">>> Allowing SSH through firewall..."
sudo ufw allow ssh

echo ">>> Enabling UFW firewall..."
sudo ufw --force enable

echo ""
echo "=== Server Secured Successfully ==="
echo "Password login is DISABLED."
echo "SSH key authentication is ENABLED."
echo "Fail2ban is protecting SSH."
echo ""

IP=$(hostname -I | awk '{print $1}')
echo "You can now SSH into this server using:"
echo ""
echo "    ssh $USER@$IP"
echo ""

