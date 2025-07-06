#!/usr/bin/env bash
set -e
set -x
set -u

# Create Incus profile for Docker containers
incus profile create docker-profile || true

# Apply profile configuration from YAML
incus profile edit docker-profile <docker-profile.yaml

# Show the profile configuration
echo Docker profile created with the following configuration:
incus profile show docker-profile
