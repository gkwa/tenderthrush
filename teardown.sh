#!/usr/bin/env bash
set -e
set -x
set -u

# Function to check if container exists
container_exists() {
    incus list --format csv | grep -q "^$1,"
}

# Function to check if image exists
image_exists() {
    incus image list --format csv | grep -q "^$1,"
}

# Function to check if profile exists
profile_exists() {
    incus profile list --format csv | grep -q "^$1,"
}

# Clean up containers FIRST (they depend on profiles)
if container_exists "tenderbrush-base"; then
    echo "Deleting container: tenderbrush-base"
    incus delete tenderbrush-base --force
else
    echo "Container tenderbrush-base does not exist, skipping..."
fi

if container_exists "tenderbrush-docker"; then
    echo "Deleting container: tenderbrush-docker"
    incus delete tenderbrush-docker --force
else
    echo "Container tenderbrush-docker does not exist, skipping..."
fi

if container_exists "test-docker"; then
    echo "Deleting container: test-docker"
    incus delete test-docker --force
else
    echo "Container test-docker does not exist, skipping..."
fi

# Clean up images SECOND (they might depend on profiles)
if image_exists "ubuntu-noble-docker"; then
    echo "Deleting image: ubuntu-noble-docker"
    incus image delete ubuntu-noble-docker
else
    echo "Image ubuntu-noble-docker does not exist, skipping..."
fi

if image_exists "ubuntu-noble-base"; then
    echo "Deleting image: ubuntu-noble-base"
    incus image delete ubuntu-noble-base
else
    echo "Image ubuntu-noble-base does not exist, skipping..."
fi

# Clean up profile LAST (after all dependencies are removed)
if profile_exists "docker-profile"; then
    echo "Deleting profile: docker-profile"
    incus profile delete docker-profile
else
    echo "Profile docker-profile does not exist, skipping..."
fi

echo "Cleanup completed successfully"
