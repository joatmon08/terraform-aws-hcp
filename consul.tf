locals {
  ingress_consul_rules = [
    {
      description = "HCP Consul Server RPC"
      port        = 8300
      protocol    = "tcp"
    },
    {
      description = "Consul LAN Serf (tcp)"
      port        = 8301
      protocol    = "tcp"
    },
    {
      description = "Consul LAN Serf (udp)"
      port        = 8301
      protocol    = "udp"
    },
    {
      description = "Consul LAN Serf (udp)"
      port        = 8301
      protocol    = "udp"
    },
    {
      description = "Consul HTTP"
      port        = 80
      protocol    = "udp"
    },
    {
      description = "Consul HTTPS"
      port        = 443
      protocol    = "udp"
    }
  ]

  hcp_consul_security_groups = flatten([
    for _, sg in var.hcp_consul_security_group_ids : [
      for _, rule in local.ingress_consul_rules : {
        security_group_id = sg
        description       = rule.description
        port              = rule.port
        protocol          = rule.protocol
      }
    ]
  ])
}

resource "aws_security_group_rule" "hcp_consul" {
  for_each          = toset(local.hcp_consul_security_groups)
  description       = each.value.description
  protocol          = each.value.protocol
  security_group_id = each.value.security_group_id
  cidr_blocks       = [var.hvn_cidr_block]
  from_port         = each.value.port
  to_port           = each.value.port
  type              = "ingress"
}
