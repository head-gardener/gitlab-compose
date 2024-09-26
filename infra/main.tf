terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.41"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "gitlab" {
  name       = "gitlab"
  public_key = file("${path.module}/key/id_ed25519.pub")
}

data "digitalocean_image" "docker" {
  slug = "docker-20-04"
}

resource "digitalocean_droplet" "gitlab" {
  backups            = "false"
  ipv6               = "false"
  monitoring         = "false"
  name               = "gitlab"
  region             = "fra1"
  size               = "s-1vcpu-2gb"
  vpc_uuid           = "bbd52e78-d996-4e4d-ba82-cfb485053d62"
  image              = data.digitalocean_image.docker.id

  ssh_keys           = [
    digitalocean_ssh_key.gitlab.id,
  ]

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.ipv4_address
    private_key = file("${path.module}/key/id_ed25519")
  }
  
  # we need to wait for ssh or ansible will cry
  provisioner "remote-exec" {
    inline = [ "true" ]
  }

  provisioner "local-exec" {
    command = <<EOF
      ansible-playbook -T 30 -i '${self.ipv4_address},'\
        --ssh-common-args='-o StrictHostKeyChecking=no'\
        --private-key '${path.module}/key/id_ed25519'\
        -u root ./init.yml
    EOF
  }
}

output "ip" {
  value = digitalocean_droplet.gitlab.ipv4_address
}
