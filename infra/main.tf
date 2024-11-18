# [START compute_instances_quickstart]
resource "google_compute_firewall" "allow_http_https" {
    name       = "allow-http-https"
    network    = "default"

    allow {
        protocol = "tcp"
        ports = ["80", "443"]
    }

    direction  = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["http-server", "https-server"]
}
resource "google_compute_instance" "default" {
  name         = "my-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags         = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-arm64-v20241115"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}