data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [
    "099720109477"
  ]
}

resource "aws_instance" "worker" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  iam_instance_profile        = aws_iam_instance_profile.boundary.name
  subnet_id                   = var.worker_public_subnet_id
  key_name                    = var.worker_keypair_name
  vpc_security_group_ids      = [var.worker_security_group_id != null ? var.worker_security_group_id : aws_security_group.worker.0.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/templates/user_data_worker.tmpl.sh", {
    boundary_cluster_id = split(".", replace(var.boundary_addr, "https://", "")).0
    boundary_scope_id   = var.boundary_scope_id
    boundary_addr       = var.boundary_addr
    boundary_username   = var.boundary_username
    boundary_password   = base64encode(var.boundary_password)
    initial_upstreams   = jsonencode(var.worker_upstreams)
    worker_tags         = jsonencode(var.worker_tags)
    worker_prefix       = var.worker_prefix
  })

  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdf"
    encrypted             = false

    tags = merge(var.tags, {
      Name      = "${var.name}-boundary-worker",
      Component = "worker",
      Purpose   = "boundary-storage"
    })

    volume_size = 32
    volume_type = "gp2"
  }

  tags = merge(var.tags, {
    Name = "${var.name}-boundary-worker"
  })
}

resource "aws_security_group" "worker" {
  count  = var.worker_security_group_id == null ? 1 : 0
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "allow_9202_worker" {
  type              = "ingress"
  from_port         = 9202
  to_port           = 9202
  protocol          = "tcp"
  cidr_blocks       = var.allow_cidr_blocks_to_worker
  security_group_id = var.worker_security_group_id != null ? var.worker_security_group_id : aws_security_group.worker.0.id
}