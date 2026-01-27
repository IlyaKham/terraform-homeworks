locals {
  ssh_public_key = file("~/.ssh/id_ed25519.pub")
  ssh_user       = "ubuntu"

   metadata = {
    serial-port-enable = "1"
    ssh-keys           = "${local.ssh_user}:${local.ssh_public_key}"
  }
}