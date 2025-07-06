# List available recipes
default:
    @just --list

# Create Docker profile
create-profile:
    ./create-docker-profile.sh

# Build Docker container image
setup:
    ./setup.sh

# Clean up containers and images
teardown:
    ./teardown.sh

# Test the Docker installation
test:
    ./test.sh

# Show incus profile configuration
show-profile:
    incus profile show docker-profile
