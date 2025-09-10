resource "google_compute_firewall" "ssh_http_firewall" {
  name    = "allow-ssh-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080"]
  }

  source_ranges = var.my_ip
  target_tags   = ["ssh-server"]
}
