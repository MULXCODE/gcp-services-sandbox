provider "google" {
  project = "elevated-watch-270607"
}

resource "google_compute_instance" "default" {
  count = 3

  name         = format("%s-%s", "test", count.index)
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["allow-ssh", "allow-int-http"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}


data "template_file" "ansible_inventory" {
  template = "${file("${path.module}/templates/inventory.tpl")}"
  depends_on = [
    "google_compute_instance.default",
  ]
  vars = {
    web_servers = join("\n", 
        google_compute_instance.default.*.network_interface[*][0].access_config[0].nat_ip)
  }
}

resource "null_resource" "generate_ansible_inventory" {
  triggers = {
    template_rendered = "${data.template_file.ansible_inventory.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_inventory.rendered}' > inventory.generated"
  }
}

resource "null_resource" "instance_names" {
    for_each = toset(google_compute_instance.default[*].name)

    provisioner "local-exec" {
        command = "echo '${each.value}' >> instance_names"
    }
}

resource "null_resource" "gcloud_compute_ssh" {
    for_each = toset(google_compute_instance.default[*].name)

    provisioner "local-exec" {
        command = <<EOT
gcloud compute ssh ${each.value} --zone us-central1-a
        EOT
    }
}
resource "null_resource" "ssh_test" {
    for_each = {
        for rt_key, rt_id in tolist(google_compute_instance.default.*.network_interface[*][0].access_config[0].nat_ip) :
        format("%s", rt_key) => rt_id
     #toset(google_compute_instance.default.*.network_interface[*][0].access_config[0].nat_ip)   
    }

    provisioner "local-exec" {
        command = <<EOT
ssh-copy-id -i ~/.ssh/google_compute_engine.pub -o StrictHostKeyChecking=no garrettwong@${each.value}
        EOT
    }

    depends_on = ["null_resource.gcloud_compute_ssh"]
}

# TBD: https://www.terraform.io/docs/provisioners/index.html (Destroy-Time Provisioner)
# Remove IP entries from ~/.ssh/known_hosts file
resource "null_resource" "remove_ext_ip_from_known_hosts" {
    for_each = toset(google_compute_instance.default[*].name)

    provisioner "local-exec" {
        when = "destroy"
        command = <<EOT

        EOT
    }
}