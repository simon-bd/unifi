#!/bin/sh

# Ensure the VLAN interface exists
if ! ip link show eth8.1 > /dev/null 2>&1; then
    ip link add link eth8 name eth8.1 type vlan id 1
    ip link set dev eth8.1 up
fi

# Ensure it is attached to the bridge
if ! bridge link show | grep -q "eth8.1"; then
    ip link set eth8.1 master br0
fi