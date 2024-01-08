#!/bin/bash

PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - ;\
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" ;\
sudo apt-get update && sudo apt-get install boundary-enterprise jq -y

mkfs -t xfs /dev/nvme1n1
mkdir -p /var/lib/boundary
mount /dev/nvme1n1 /var/lib/boundary

## Add volume mount for session recording and worker logging
mkdir -p /var/lib/boundary/worker/registration
mkdir -p /var/lib/boundary/sessions

adduser --system --group boundary || true
chown boundary:boundary -R /var/lib/boundary
chgrp boundary /var/lib/boundary
chmod g+rwx /var/lib/boundary

echo '${boundary_password}' > /etc/boundary.d/password

## Activate worker using controller-led worker registration

cat << EOF > /etc/boundary.d/register.sh
#!/bin/bash

set -e

export BOUNDARY_ADDR=${boundary_addr}
export BOUNDARY_CLI_FORMAT=json
export BOUNDARY_KEYRING_TYPE=none

boundary authenticate password -scope-id=${boundary_scope_id} -login-name=${boundary_username} -password=file:///etc/boundary.d/password > /var/lib/boundary/worker/registration/auth

cat /var/lib/boundary/worker/registration/auth | jq -r '.item.attributes.token' > /var/lib/boundary/worker/registration/token

if [ -f /var/lib/boundary/worker/registration/id ]; then
  echo "Boundary worker already initialized, bypassing generation of controller-led activation token"
else
  boundary workers create controller-led -token file:///var/lib/boundary/worker/registration/token -name ${worker_prefix}$(hostname) -description "Boundary worker at $${PRIVATE_IP}" > /var/lib/boundary/worker/registration/worker-info
  cat /var/lib/boundary/worker/registration/worker-info | jq -r '.item.controller_generated_activation_token' > /var/lib/boundary/worker/registration/controller-generated-activation-token
  cat /var/lib/boundary/worker/registration/worker-info | jq -r '.item.id' > /var/lib/boundary/worker/registration/id
  sleep 10
fi
EOF

cat << EOF > /etc/boundary.d/deregister.sh
#!/bin/bash

set -e

export BOUNDARY_ADDR=${boundary_addr}
export BOUNDARY_CLI_FORMAT=json
export BOUNDARY_KEYRING_TYPE=none

boundary authenticate password -scope-id=${boundary_scope_id} -login-name=${boundary_username} -password=file:///etc/boundary.d/password > /var/lib/boundary/worker/registration/auth

cat /var/lib/boundary/worker/registration/auth | jq -r '.item.attributes.token' > /var/lib/boundary/worker/registration/token

boundary workers delete -token file:///var/lib/boundary/worker/registration/token -id=\$(cat /var/lib/boundary/worker/registration/id)
rm -f /var/lib/boundary/worker/registration/id
rm -f /var/lib/boundary/worker/registration/controller-generated-activation-token
EOF

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
  recording_storage_path = "/var/lib/boundary/sessions"
  controller_generated_activation_token = "file:///var/lib/boundary/worker/registration/controller-generated-activation-token"
  tags {
    type = ${worker_tags}
  }
}
EOF

cat << EOF > /lib/systemd/system/boundary.service
[Unit]
Description="HashiCorp Boundary - Identity-based access management for dynamic infrastructure"
Documentation=https://www.boundaryproject.io/docs
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
EnvironmentFile=-/etc/boundary.d/boundary.env
User=boundary
Group=boundary
ProtectSystem=full
ProtectHome=read-only
ExecStartPre=/bin/bash /etc/boundary.d/register.sh
ExecStart=/usr/bin/boundary server -config=/etc/boundary.d/boundary.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
ExecStopPost=/bin/bash /etc/boundary.d/deregister.sh
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable boundary
systemctl start boundary