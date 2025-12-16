#!/bin/bash

# Step 1: Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install required dependencies
echo "Installing required dependencies..."
sudo apt install -y python3 python3-pip build-essential wget git python3-dev libpq-dev \
  libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libjpeg-dev libssl-dev \
  libffi-dev zlib1g-dev postgresql:14

# Step 3: Verify PostgreSQL installation and configure it
echo "Configuring PostgreSQL..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create the Odoo user in PostgreSQL
sudo -u postgres createuser -s odoo

# Step 4: Navigate to the /opt directory
cd /opt

# Step 5: Install Odoo .deb file (you can modify the file name if necessary)
echo "Installing Odoo .deb file..."
sudo wget https://github.com/odoo/odoo/releases/download/17.0/odoo_17.0.deb -O odoo_17.deb

# Install the Odoo .deb package
sudo dpkg -i odoo_17*.deb
sudo apt --fix-broken install

# Step 6: Configure Odoo
echo "Configuring Odoo..."
sudo cp /etc/odoo/odoo.conf /etc/odoo/odoo.conf.bak
sudo bash -c 'cat > /etc/odoo/odoo.conf <<EOL
[options]
admin_passwd = admin
db_host = False
db_port = False
db_user = admin
db_password = False
addons_path = /usr/lib/python3/dist-packages/odoo/addons
logfile = /var/log/odoo/odoo.log
EOL'

# Step 7: Start and enable Odoo service
echo "Starting and enabling Odoo service..."
sudo systemctl start odoo
sudo systemctl enable odoo

# Step 8: Check Odoo service status
echo "Checking Odoo service status..."
sudo systemctl status odoo

# Step 9: Open the necessary port in the firewall (if applicable)
echo "Configuring firewall (if applicable)..."
sudo ufw allow 8069
sudo ufw reload

# Step 10: Tail Odoo logs (for troubleshooting)
echo "Displaying Odoo logs..."
sudo tail -f /var/log/odoo/odoo.log

# Final message
echo "Odoo installation completed successfully!"
echo "You can now access Odoo at http://localhost:8069 or http://<your_server_ip>:8069"
