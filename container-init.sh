#!/usr/bin/env bash
set -e
set -x
set -u

cloud-init status --wait
echo Container is ready for Docker installation
