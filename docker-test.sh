#!/usr/bin/env bash
set -e
set -x
set -u

echo Testing Docker installation...
docker run --rm hello-world
echo Docker is working correctly in the container
