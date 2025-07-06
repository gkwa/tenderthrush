#!/usr/bin/env bash
set -e
set -x
set -u

# Function to check if container exists
container_exists() {
    incus list --format csv | grep -q "^$1,"
}

# Clean up any existing containers before starting
if container_exists tenderbrush; then
    echo Cleaning up existing tenderbrush container...
    incus delete tenderbrush --force
fi

# Create Docker profile if it doesn't exist
echo Creating Docker profile...
./create-docker-profile.sh

# Check if base image exists, if not create it
if ! incus image show ubuntu-noble-base &>/dev/null; then
    echo Base image not found, creating it...
    packer build base-image.pkr.hcl 2>&1 | tee base-output.txt

    # Clean up container after base image creation
    if container_exists tenderbrush; then
        echo Cleaning up tenderbrush container after base image creation...
        incus delete tenderbrush --force
    fi
fi

# Build Docker container image
echo Building Docker container image...
packer build docker-container.pkr.hcl 2>&1 | tee output.txt

# Clean up container after Docker image creation
if container_exists tenderbrush; then
    echo Cleaning up tenderbrush container after Docker image creation...
    incus delete tenderbrush --force
fi

echo Setup completed successfully
