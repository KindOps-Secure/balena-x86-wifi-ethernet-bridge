# x86_64 Wi‑Fi ↔ Ethernet Bridge for BalenaOS
A BalenaCloud‑deployable project that bridges a Wi‑Fi uplink to a wired Ethernet interface on x86_64 devices. Designed for hardware such as the Sophos XG 115w, Protectli/Qotom appliances, and other generic x86_64 boards with supported Wi‑Fi chipsets (ath10k recommended).

This project creates a true Layer‑2 bridge (same subnet) using Linux bridging and 4‑address Wi‑Fi mode, allowing wired‑only devices to appear directly on the upstream Wi‑Fi network.

## Created with “vibe‑code” via Copilot 🤖 ##

# 🚀 Features
• True L2 bridging between Wi‑Fi and Ethernet

• Automatic interface detection (Wi‑Fi + first Ethernet NIC)

• 4‑address Wi‑Fi mode for proper bridging (ath10k compatible)

• NetworkManager‑based Wi‑Fi configuration

• BalenaCloud‑ready deployment with host networking

• Minimal footprint and no Pi‑specific dependencies

# 🧩 How It Works
The system uses two layers:

# 1. Host OS (BalenaOS)
NetworkManager connects the device to your Wi‑Fi network using a .nmconnection file placed in system-connections/.

# 2. Bridge Service (Container)
A privileged container:

• Disables NetworkManager control of the Wi‑Fi and Ethernet interfaces

• Enables 4‑address mode on the Wi‑Fi NIC

• Creates a Linux bridge (br0)

• Adds both interfaces to the bridge

• Assigns an IP to br0 via DHCP from the upstream Wi‑Fi network

Any device plugged into Ethernet receives an IP from the same subnet as the Wi‑Fi network.
