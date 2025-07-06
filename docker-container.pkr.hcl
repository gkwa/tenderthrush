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
  output_image   = "docker-container"
  container_name = "tenderbrush-docker"
  reuse          = true
  skip_publish   = true
  profile        = "docker-profile"
}

build {
  sources = ["incus.base"]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
      "echo 'Container is ready for Docker installation'",
    ]
  }

  provisioner "shell" {
    scripts = [
      "docker-setup.sh",
    ]
  }

  provisioner "shell" {
    inline = [
      "echo 'Testing Docker installation...'",
      "docker run --rm hello-world",
      "echo 'Docker is working correctly in the container!'",
    ]
  }
}
