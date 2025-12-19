# UDM Pro SE: 2.5G WAN/LAN Hybrid Port (Port 9)

This setup allows you to use the 2.5G WAN port (Port 9 / `eth8`) as a Trunk port, carrying both your **ISP Internet (VLAN 10)** and your **Local LAN (VLAN 1)**.

## 🚀 The Script: `setup-trunk.sh`

This script uses conditional checks to ensure the VLAN interface is created and bridged only if it doesn't already exist.

### 1. Persistent Storage
Place the script in `/persistent/` to ensure it survives firmware updates.

```bash
mkdir -p /persistent/scripts
vi /persistent/scripts/setup-trunk.sh

. The Systemd Service

Path: /etc/systemd/system/vlan-trunk.service
Ini, TOML

[Unit]
Description=Bridge eth8.1 to br0 (2.5G Trunk)
After=network-online.target

[Service]
Type=oneshot
ExecStartPre=/bin/sleep 60
ExecStart=/bin/sh /persistent/scripts/setup-trunk.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

🚀 Installation Guide

Run these commands via SSH to deploy the configuration:

    Create persistent directory:
    Bash

mkdir -p /persistent/scripts

Create the script: Save the script content above into /persistent/scripts/setup-trunk.sh and make it executable:
Bash

chmod +x /persistent/scripts/setup-trunk.sh

Create the service: Save the service content above into /etc/systemd/system/vlan-trunk.service.

Enable and start the service:
Bash

    systemctl daemon-reload
    systemctl enable vlan-trunk.service
    systemctl start vlan-trunk.service

🔍 Verification & Maintenance
Check Status

Verify the bridge is active and forwarding:
Bash

bridge link show | grep eth8.1

Post-Update Recovery

UniFi OS updates may delete files in /etc/systemd/system/. Because the script is stored in /persistent/, you can restore functionality by re-creating the .service file and running:
Bash

systemctl daemon-reload
systemctl enable --now vlan-trunk.service


Would you like me to add a "One-Liner" restore command to the bottom of this README for even faster recovery after updates?
