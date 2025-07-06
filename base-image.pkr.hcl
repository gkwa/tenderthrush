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
  output_image   = "003-need-to-fix"
  container_name = "tenderbrush-base"
  reuse          = true
  skip_publish   = true
}

build {
  sources = ["incus.base"]
  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
      "apt-get update",
      "apt-get install -y curl git",
    ]
  }
}
