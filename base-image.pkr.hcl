packer {
  required_plugins {
    incus = {
      version = ">= 1.0.0"
      source  = "github.com/bketelsen/incus"
    }
  }
}

source "incus" "base" {
  image          = "images:ubuntu/noble/cloud"
  output_image   = "ubuntu-noble-base"
  container_name = "tenderbrush-base"
  reuse          = true
  skip_publish   = true
}

build {
  sources = ["incus.base"]
  provisioner "shell" {
    scripts = ["base-setup.sh"]
  }
}
