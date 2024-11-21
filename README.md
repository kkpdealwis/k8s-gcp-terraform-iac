## Importing an Instance in GCP using Terraform

```
import {
  id = "projects/trim-field-426016-a8/zones/us-central1-c/instances/instance-20241121-140719"
  to = google_compute_instance.instance-20241121-140719
}

resource "google_compute_instance" "instance-20241121-140719" {
  name         = "instance-20241121-140719"  # Replace with the actual instance name
  machine_type = "e2-medium"  # Replace with the actual machine type
  zone         = "us-central1-a"  # Replace with the actual zone

  # Boot disk
  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-arm64-v20241115"  # Replace with the actual image
    }
  }

  # Network interface
  network_interface {
    network = "default"  # This attaches the instance to the default VPC network
    access_config {}  # This is needed to allow internet access via an ephemeral public IP
  }

  # Optionally add other configurations, such as metadata, labels, etc.
}
```
- when importing an instance from Google Cloud to Terraform import and resource blocks are required for the referencing instance
- name, machine_type, zone, boot_dis, network_interface are required when importing instance from GCP to terraform
