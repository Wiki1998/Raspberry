#!/bin/bash
set -e  # Stop on error

# Update the system
echo "Updating the system..."
sudo apt update

echo "Upgrading packages..."
sudo apt upgrade -y

echo "Performing distribution upgrade..."
sudo apt dist-upgrade -y

# Install GCC, G++, and libc6-dev
echo "Installing GCC..."
sudo apt install gcc -y

echo "Installing G++..."
sudo apt install g++ -y

echo "Installing libc6-dev..."
sudo apt install libc6-dev -y

# Check installed versions
echo "Checking installed versions of GCC and libc..."
gcc_version=$(gcc --version | head -n 1)
libc_version=$(ldd --version | head -n 1)
echo "Installed GCC version: $gcc_version"
echo "Installed libc version: $libc_version"

# Install CMake
readonly CMAKE_VERSION=3.23.2
CMAKE_TAR=cmake-$CMAKE_VERSION.tar.gz
CMAKE_DIR=cmake-$CMAKE_VERSION

echo "Installing CMake version $CMAKE_VERSION..."
wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/$CMAKE_TAR

echo "Extracting CMake archive..."
tar -zxvf $CMAKE_TAR

echo "Entering CMake directory..."
cd $CMAKE_DIR

echo "Running CMake bootstrap script..."
./bootstrap

echo "Compiling CMake with $(nproc) cores..."
make -j$(nproc)

echo "Installing CMake..."
sudo make install

echo "Returning to the original directory..."
cd ..

echo "Cleaning up CMake files..."
rm -rf $CMAKE_DIR $CMAKE_TAR

# Verify CMake installation
cmake_version=$(cmake --version | head -n 1)
echo "Installed CMake version: $cmake_version"

# Install other required packages
echo "Installing build-essential..."
sudo apt install build-essential -y

echo "Installing libarchive-dev..."
sudo apt install libarchive-dev -y

echo "Installing mesa-common-dev and mesa-utils..."
sudo apt install mesa-common-dev mesa-utils -y

echo "Installing libglib2.0-0..."
sudo apt install libglib2.0-0 -y

echo "All required packages have been installed successfully."
