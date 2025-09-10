output "public_ip" {
  value = google_compute_instance.super_cool_gce.network_interface.0.access_config.0.nat_ip
}

output "machine_uri" {
  value = google_compute_instance.super_cool_gce.self_link
}
