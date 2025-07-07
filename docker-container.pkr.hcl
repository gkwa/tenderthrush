packer {
  required_plugins {
    incus = {
      version = ">= 1.0.0"
      source  = "github.com/bketelsen/incus"
    }
  }
}

source "incus" "base" {
  image          = "ubuntu-noble-base"
  output_image   = "ubuntu-noble-docker"
  container_name = "tenderbrush-docker"
  reuse          = true
  skip_publish   = true
  profile        = "docker-profile"
}

build {
  sources = ["incus.base"]

  provisioner "shell" {
    scripts = ["docker-setup.sh"]
  }

  provisioner "shell" {
    scripts = ["docker-test.sh"]
  }
}
