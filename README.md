## Importing an Instance in GCP Using Terraform

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
- When we create the metadata_startup_script section on the terraform we need to change the line endings to from CRLF to LF 
- The above setting will change the current openfile line ending to Unix-style. other wise the sudo journalctl -u google-startup-scripts.service gives the following error
```
#with using #!/bin/bash at the top give below error
startup-script: /bin/bash: /tmp/metadata-scripts188395429/startup-script: /bin/bash^M: bad interpreter: No such file or directory

#without using #!/bin/bash at the top give below error
startup-script: /tmp/metadata-scripts3282388603/startup-script: line 1: syntax error near unexpected token `$'{\r''
```
- using the below journalctl command metadata_startup_script execution status can be viewed
```
sudo journalctl -u google-startup-scripts.service
```

