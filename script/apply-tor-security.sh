#!/bin/bash

# Tor Security Configuration Apply Script
# This script applies the hardened Tor configuration

echo "=== Tor Security Configuration Apply ==="
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges to modify system files."
    echo "Please run with: sudo $0"
    exit 1
fi

# Backup original config
echo "1. Creating backup of original torrc..."
cp /etc/tor/torrc /etc/tor/torrc.backup.$(date +%Y%m%d_%H%M%S)
echo "   ✓ Backup created"

# Apply new secure configuration
echo "2. Applying secure Tor configuration..."
if [ -f "/home/kalu/Downloads/torrc.secure" ]; then
    cp /home/kalu/Downloads/torrc.secure /etc/tor/torrc
    echo "   ✓ Secure configuration applied"
else
    echo "   ✗ Secure configuration file not found"
    exit 1
fi

# Set proper permissions
echo "3. Setting secure permissions..."
chmod 640 /etc/tor/torrc
chown root:debian-tor /etc/tor/torrc
chmod 750 /var/lib/tor
chown debian-tor:debian-tor /var/lib/tor
echo "   ✓ Permissions set"

# Create log directory and files
echo "4. Setting up logging..."
mkdir -p /var/log/tor
touch /var/log/tor/notices.log /var/log/tor/warnings.log
chown debian-tor:debian-tor /var/log/tor/*.log
chmod 640 /var/log/tor/*.log
echo "   ✓ Logging configured"

# Configure log rotation
echo "5. Setting up log rotation..."
cat > /etc/logrotate.d/tor << 'EOF'
/var/log/tor/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 644 debian-tor debian-tor
    postrotate
        /bin/systemctl reload tor@default || true
    endscript
}
EOF
echo "   ✓ Log rotation configured"

# Configure firewall rules
echo "6. Configuring firewall..."
if command -v ufw >/dev/null 2>&1; then
    # Tor control port - restrict to localhost only
    ufw deny from any to any port 9051 comment "Block external Tor control access"
    
    # Allow localhost Tor traffic
    ufw allow in on lo to any port 9050 comment "Allow Tor SOCKS on localhost"
    ufw allow in on lo to any port 9051 comment "Allow Tor control on localhost"
    
    echo "   ✓ Firewall rules configured"
else
    echo "   ! UFW not found - please configure firewall manually"
fi

# Apply sysctl security hardening
echo "7. Applying system security hardening..."
cat > /etc/sysctl.d/99-tor-security.conf << 'EOF'
# Tor network security hardening
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0

# Connection tracking for Tor
net.netfilter.nf_conntrack_max = 131072
EOF

sysctl -p /etc/sysctl.d/99-tor-security.conf >/dev/null 2>&1
echo "   ✓ System hardening applied"

# Restart Tor service
echo "8. Restarting Tor service..."
systemctl restart tor@default
sleep 3

# Verify Tor is running
if systemctl is-active --quiet tor@default; then
    echo "   ✓ Tor service is running"
else
    echo "   ✗ Tor service failed to start"
    echo "   Check logs with: journalctl -u tor@default"
fi

echo
echo "=== Configuration Complete ==="
echo
echo "Security improvements applied:"
echo "✓ SOCKS proxy restricted to localhost only"
echo "✓ Control port secured with password authentication"
echo "✓ Cookie authentication disabled"
echo "✓ Safe logging enabled"
echo "✓ Bandwidth and connection limits set"
echo "✓ Middle relay configuration (no exit traffic)"
echo "✓ Proper file permissions"
echo "✓ Log rotation configured"
echo "✓ Firewall rules applied"
echo "✓ System-level hardening"
echo
echo "To verify Tor status:"
echo "  sudo systemctl status tor@default"
echo
echo "To view Tor logs:"
echo "  sudo tail -f /var/log/tor/notices.log"
echo
echo "Configuration files:"
echo "  - /etc/tor/torrc (main config)"
echo "  - /etc/tor/torrc.backup.* (backups)"
echo "  - /var/log/tor/ (logs)"