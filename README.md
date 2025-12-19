# UDM Pro SE: 2.5G WAN/LAN Hybrid Port (Port 9)

This setup allows you to use the 2.5G WAN port (Port 9 / `eth8`) as a Trunk port, carrying both your **ISP Internet (VLAN 10)** and your **Local LAN (VLAN 1)**.

## 🚀 The Script: `setup-trunk.sh`

This script uses conditional checks to ensure the VLAN interface is created and bridged only if it doesn't already exist.

### 1. Persistent Storage
Place the script in `/persistent/` to ensure it survives firmware updates.

```bash
mkdir -p /persistent/scripts
vi /persistent/scripts/setup-trunk.sh
