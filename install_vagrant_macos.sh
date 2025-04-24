#!/bin/bash

set -e

# Function to install Homebrew
install_brew() {
    echo "🍺 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
}


echo "🔍 Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    install_brew
else
    echo "✅ Homebrew is already installed."
fi

echo "🔍 Update and Upgrading Homebrew..."
brew update
brew upgrade

# Install Docker Desktop
echo "🐳 Checking for Docker..."
if ! command -v docker &> /dev/null; then
    echo "Installing Docker Desktop..."
    brew install --cask docker
    echo "Opening Docker.app to complete setup..."
    open /Applications/Docker.app
else
    echo "✅ Docker is already installed."
fi

# Install Vagrant
echo "📦 Checking for Vagrant..."
if ! command -v vagrant &> /dev/null; then
    echo "Installing Vagrant..."
    brew install --cask vagrant
else
    echo "✅ Vagrant is already installed."
fi

# Lock correct csv version to avoid gem conflict
echo "📚 Installing compatible csv gem version..."
vagrant plugin install csv --plugin-version 3.2.8


# Install VirtualBox
echo "📦 Checking for VirtualBox..."
if ! command -v virtualbox &> /dev/null; then
    echo "Installing VirtualBox..."
    brew install --cask virtualbox@beta
else
    echo "✅ VirtualBox is already installed."
fi

# Tap and install HashiCorp Vagrant (optional redundancy)
echo "🍻 Tapping HashiCorp..."
brew tap hashicorp/tap

echo "⬇️ Installing HashiCorp Vagrant via brew..."
brew install hashicorp/tap/hashicorp-vagrant

# Fix gem version conflict by pre-installing correct CSV gem
echo "🔧 Fixing Vagrant plugin gem conflict..."
vagrant plugin expunge --force || true

echo "📚 Installing compatible csv gem version (3.2.8)..."
vagrant plugin install csv --plugin-version 3.2.8

echo "🔌 Installing vagrant-docker-compose plugin..."
vagrant plugin install vagrant-docker-compose

echo "✅ Setup complete. Docker + Vagrant (Docker provider) ready to go on Apple Silicon!"
