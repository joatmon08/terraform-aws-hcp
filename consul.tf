resource "aws_security_group" "allow_hcp_consul" {
  count       = length(var.consul_security_group_ids) > 0 ? 1 : 0
  name        = "allow-hcp-consul"
  description = "Allow HCP Consul traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Consul Server RPC"
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = [var.hvn_cidr_block]
  }

  ingress {
    description = "Consul LAN Serf (tcp)"
    from_port   = 8301
    to_port     = 8301
    protocol    = "tcp"
    cidr_blocks = [var.hvn_cidr_block]
  }

  ingress {
    description = "Consul LAN Serf (udp)"
    from_port   = 8301
    to_port     = 8301
    protocol    = "udp"
    cidr_blocks = [var.hvn_cidr_block]
  }

  ingress {
    description     = "Consul LAN Serf (tcp) to Security Groups"
    from_port       = 8301
    to_port         = 8301
    protocol        = "tcp"
    security_groups = var.consul_security_group_ids
  }

  ingress {
    description     = "Consul LAN Serf (udp) to Security Groups"
    from_port       = 8301
    to_port         = 8301
    protocol        = "udp"
    security_groups = var.consul_security_group_ids
  }

  ingress {
    description = "Consul HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = [var.hvn_cidr_block]
  }

  ingress {
    description = "Consul HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = [var.hvn_cidr_block]
  }


  tags = merge({
    Name = "allow-hcp-consul"
  }, var.tags)
}