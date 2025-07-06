#!/usr/bin/env bash
set -e
set -x
set -u

# Function to check if container exists
container_exists() {
    incus list --format csv | grep -q "^$1,"
}

# Clean up any existing test container
if container_exists "test-docker"; then
    echo "Cleaning up existing test-docker container..."
    incus delete test-docker --force
fi

# Test the Docker installation
echo "Launching test container from ubuntu-noble-docker image..."
incus launch ubuntu-noble-docker test-docker

echo "Testing Docker in the container..."
incus exec test-docker -- docker run --rm hello-world

echo "Stopping and cleaning up test container..."
incus stop test-docker --force
incus delete test-docker --force

echo "Docker test completed successfully!"
