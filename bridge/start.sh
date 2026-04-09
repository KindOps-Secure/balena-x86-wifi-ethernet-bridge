#!/bin/bash
set -e

# Detect interfaces
WIFI_IF=$(iw dev | awk '$1=="Interface"{print $2}')
ETH_IF=$(ls /sys/class/net | grep -E "enp|eth" | head -n1)

echo "WiFi interface: $WIFI_IF"
echo "Ethernet interface: $ETH_IF"

# Stop NetworkManager from touching interfaces
nmcli dev set "$WIFI_IF" managed no || true
nmcli dev set "$ETH_IF" managed no || true

# Enable 4-address mode on WiFi
iw dev "$WIFI_IF" set 4addr on

# Create bridge if missing
if ! ip link show br0 >/dev/null 2>&1; then
    ip link add name br0 type bridge
fi

# Add interfaces to bridge
ip link set "$ETH_IF" master br0
ip link set "$WIFI_IF" master br0

# Bring everything up
ip link set br0 up
ip link set "$ETH_IF" up
ip link set "$WIFI_IF" up

# Disable IP on physical interfaces
ip addr flush dev "$ETH_IF"
ip addr flush dev "$WIFI_IF"

# Let br0 get IP from upstream WiFi
dhclient br0

echo "Bridge setup complete. br0 is now your primary interface."

sleep infinity
