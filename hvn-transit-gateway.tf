resource "aws_ram_resource_share" "transit" {
  count                     = var.use_transit_gateway ? 1 : 0
  name                      = var.hvn_name
  allow_external_principals = true
}

resource "aws_ram_principal_association" "transit" {
  count              = var.use_transit_gateway ? 1 : 0
  resource_share_arn = aws_ram_resource_share.transit.0.arn
  principal          = hcp_hvn.hvn.provider_account_id
}

resource "aws_ram_resource_association" "transit" {
  count              = var.use_transit_gateway ? 1 : 0
  resource_share_arn = aws_ram_resource_share.transit.0.arn
  resource_arn       = var.transit_gateway_arn
}

resource "hcp_aws_transit_gateway_attachment" "transit" {
  count = var.use_transit_gateway ? 1 : 0
  depends_on = [
    aws_ram_principal_association.transit,
    aws_ram_resource_association.transit,
  ]

  hvn_id                        = hcp_hvn.hvn.hvn_id
  transit_gateway_attachment_id = var.hvn_name
  transit_gateway_id            = var.transit_gateway_id
  resource_share_arn            = aws_ram_resource_share.transit.0.arn
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "this" {
  count = var.use_transit_gateway ? 1 : 0

  transit_gateway_attachment_id = hcp_aws_transit_gateway_attachment.transit.0.provider_transit_gateway_attachment_id
  tags = {
    Name = var.hvn_name
  }
}