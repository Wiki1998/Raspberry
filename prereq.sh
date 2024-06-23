#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y

# Install GCC, G++, and libc6-dev
echo "Installing GCC, G++, and libc6-dev..."
sudo apt install gcc g++ libc6-dev -y

# Check installed versions
echo "Checking installed versions of GCC and libc..."
gcc_version=$(gcc --version | head -n 1)
libc_version=$(ldd --version | head -n 1)
echo "Installed GCC version: $gcc_version"
echo "Installed libc version: $libc_version"

# Install CMake
CMAKE_VERSION=3.23.2
CMAKE_TAR=cmake-$CMAKE_VERSION.tar.gz
CMAKE_DIR=cmake-$CMAKE_VERSION

echo "Installing CMake version $CMAKE_VERSION..."
wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/$CMAKE_TAR
tar -zxvf $CMAKE_TAR
cd $CMAKE_DIR
./bootstrap
make -j$(nproc)
sudo make install
cd ..
rm -rf $CMAKE_DIR $CMAKE_TAR

# Verify CMake installation
cmake_version=$(cmake --version | head -n 1)
echo "Installed CMake version: $cmake_version"

# Install other required packages
echo "Installing build-essential, libarchive-dev, mesa-common-dev, mesa-utils, and libglib2.0-0..."
sudo apt install build-essential libarchive-dev mesa-common-dev mesa-utils libglib2.0-0 -y

echo "All required packages have been installed successfully."
