resource "google_compute_instance" "super_cool_gce" {
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
