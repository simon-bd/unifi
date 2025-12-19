# 1. Create the persistent script directory
mkdir -p /persistent/scripts

# 2. Create the shell script
cat <<'EOF' > /persistent/scripts/setup-trunk.sh
#!/bin/bash
# Wait for UniFi services to finish provisioning the bridge
sleep 60
# Create Tagged VLAN 1 on the 2.5G Physical Port (eth8)
ip link add link eth8 name eth8.1 type vlan id 1
ip link set dev eth8.1 up
# Attach the new interface to the LAN bridge (br0)
ip link set eth8.1 master br0
EOF

# 3. Make script executable
chmod +x /persistent/scripts/setup-trunk.sh

# 4. Create the systemd service file
cat <<'EOF' > /etc/systemd/system/vlan-trunk.service
[Unit]
Description=Setup eth8.1 VLAN Trunk for 2.5G Port
After=network.target

[Service]
Type=simple
ExecStart=/persistent/scripts/setup-trunk.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# 5. Reload systemd, enable the service for boot, and start it now
systemctl daemon-reload
systemctl enable vlan-trunk.service
systemctl start vlan-trunk.service

# 6. Verify status
systemctl status vlan-trunk.service
