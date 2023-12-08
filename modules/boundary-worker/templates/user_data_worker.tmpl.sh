#!/bin/bash

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - ;\
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" ;\
sudo apt-get update && sudo apt-get install boundary-enterprise -y

PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

cat << EOF > /etc/boundary.d/boundary.hcl
disable_mlock = true

hcp_boundary_cluster_id = "${boundary_cluster_id}"

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}

worker {
  public_addr = "$${PUBLIC_IP}"
  auth_storage_path = "/var/lib/boundary/worker"
  controller_generated_activation_token = "${controller_generated_activation_token}"
  recording_storage_path = "/var/lib/boundary/sessions"
  tags {
    type = ${worker_tags}
  }
}
EOF

mkdir -p /var/lib/boundary/worker
mkdir -p /var/lib/boundary/sessions

mkfs -t xfs /dev/nvme1n1
mkdir -p /var/lib/boundary
mount /dev/nvme1n1 /var/lib/boundary

adduser --system --group boundary || true
chown boundary:boundary -R /var/lib/boundary
chgrp boundary /var/lib/boundary
chmod g+rwx /var/lib/boundary

systemctl daemon-reload
systemctl enable boundary
systemctl start boundary