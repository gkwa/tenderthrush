#!/usr/bin/env bash
set -e
set -x
set -u

cloud-init status --wait
apt-get update
apt-get install -y curl git
