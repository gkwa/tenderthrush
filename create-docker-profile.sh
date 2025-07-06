#!/usr/bin/env bash
set -e
set -x
set -u

# Create Incus profile for Docker containers
incus profile create docker-profile || true

# Configure the profile with necessary settings for Docker
incus profile set docker-profile security.nesting true
incus profile set docker-profile security.syscalls.intercept.mknod true
incus profile set docker-profile security.syscalls.intercept.setxattr true

# Add network device to the profile - this is critical!
incus profile device add docker-profile eth0 nic network=incusbr0 name=eth0

# Add root device to the profile
incus profile device add docker-profile root disk pool=default path=/

# Show the profile configuration
echo "Docker profile created with the following configuration:"
incus profile show docker-profile
