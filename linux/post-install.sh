#!/bin/bash

# How to execute this script:
# Run the following command in your terminal:
# bash <(curl -sSL https://raw.githubusercontent.com/CrazyWolf13/home-assets/refs/heads/main/linux/post-install.sh)

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
    sudo apt install -y nala btop screen fastfetch git fdisk xclip
    clear
    echo "IP is: $(hostname -I | awk '{print $1}')"
    echo "Hostname is: $(hostname)"
    echo "Done!"
}

# Function for installing quality of life tools
install_qol_tools() {
    read -p "Do you want to install quality of life tools (bat, eza, fzf, cmatrix, duf, grc, oh-my-posh)? [y/N]: " install_qol
    if [[ "$install_qol" =~ ^[Yy]$ ]]; then
        echo "Installing quality of life tools..."
        sudo apt install -y bat eza fzf cmatrix duf grc
        curl -s https://ohmyposh.dev/install.sh | bash
        echo "Quality of life tools installed!"
    else
        echo "Skipping quality of life tools installation."
    fi
}

# Function to inject content into .bashrc
inject_bashrc() {
    read -p "Do you want to inject custom settings into your .bashrc file? [y/N]: " activate_bashrc
    if [[ "$activate_bashrc" =~ ^[Yy]$ ]]; then
        echo "Injecting custom settings into .bashrc..."
        
        # Prompt for personal token input
        read -sp "Enter your GitHub personal access token: " PERSONAL_TOKEN
        echo
        
        # The line to be added to .bashrc
        echo "ACCES_TOKEN=$PERSONAL_TOKEN" >> ~/.bashrc
        echo "bash <(curl -H \"Authorization: token $PERSONAL_TOKEN\" -sSL https://raw.githubusercontent.com/CrazyWolf13/chezmoi/refs/heads/main/dot_bashrc)" >> ~/.bashrc
        
        echo "Custom settings have been injected into your .bashrc."
    else
        echo "Skipping .bashrc injection."
    fi
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

# Ask user if they want to install quality of life tools
install_qol_tools

# Ask user if they want to inject custom settings into .bashrc
inject_bashrc
