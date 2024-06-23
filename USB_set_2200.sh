#!/bin/bash

# Define variables
DEVICE_IP="169.254.38.55"
VM_IP="169.254.38.1"
INTERFACE="usb0"
NETMASK="255.255.0.0"

# Function to configure the network interface
configure_interface() {
    echo "Configuring network interface $INTERFACE..."
    sudo ifconfig $INTERFACE down
    sudo ifconfig $INTERFACE $VM_IP netmask $NETMASK up
}

# Function to add route
add_route() {
    echo "Adding route to $DEVICE_IP..."
    sudo route add -host $DEVICE_IP $INTERFACE
}

# Function to check connectivity
check_connectivity() {
    echo "Checking connectivity to $DEVICE_IP..."
    ping -c 4 $DEVICE_IP
}

# Function to persist configuration
persist_configuration() {
    echo "Persisting configuration to /etc/network/interfaces..."
    sudo bash -c "cat >> /etc/network/interfaces" <<EOL

# EB2200 configuration
allow-hotplug $INTERFACE
iface $INTERFACE inet static
    address $VM_IP
    netmask $NETMASK
    up route add -host $DEVICE_IP $INTERFACE
    down route delete -host $DEVICE_IP $INTERFACE
EOL
}

# Main script execution
configure_interface
add_route
check_connectivity
persist_configuration

echo "Configuration complete."
