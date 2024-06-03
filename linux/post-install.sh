#!/bin/bash

# Function to check for GUI environment
check_gui() {
    if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ] || [ -n "$MIR_SOCKET" ]; then
        return 0  # GUI environment detected
    else
        return 1  # No GUI environment
    fi
}

# Function for GUI-specific installation
gui_install() {
    echo "Installing GUI-specific packages..."
    sudo apt install -y flameshot
}

# Function for server-specific installation
server_install() {
    echo "Installing server-specific packages..."
}

# Function for general installation
general_install() {
    echo "Running general installation tasks..."
    sudo apt update
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y nala btop screen
    clear
    echo "IP is: $(hostname -I | awk '{print $1}')"
    echo "Hostname is: $(hostname)"
    echo "Done!"
}

# Main script logic
if check_gui; then
    echo "GUI environment detected. Running GUI-specific installation..."
    gui_install
else
    echo "No GUI environment detected. Running server-specific installation..."
    server_install
fi

# Run general installation tasks
general_install
