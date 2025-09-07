resource "google_compute_firewall" "http_firewall" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.my_ip
  target_tags   = ["ssh-server"]
}

resource "google_compute_instance" "ssh_vm" {
  name         = "terraform-vm"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // to get a public IP
    }
  }

  tags                = ["ssh-server"]
  deletion_protection = false
}
