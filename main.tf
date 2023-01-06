
resource "aws_ec2_transit_gateway_route_table" "route_table" {
  transit_gateway_id = var.transit_gateway_id

  tags = merge(
    {
      "Name" = format("%s", var.transit_gateway_route_table_name)
    },
    var.tags,
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "association" {
  count = length(var.transit_gateway_attachment_id)

  transit_gateway_attachment_id  = var.transit_gateway_attachment_id[count.index]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.route_table.id
}

resource "aws_ec2_transit_gateway_route" "route" {
  count = length(var.transit_gateway_routes)

  destination_cidr_block = lookup(var.transit_gateway_routes[count.index], "destination_cidr_block")
  blackhole              = lookup(var.transit_gateway_routes[count.index], "blackhole", null)

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.route_table.id
  transit_gateway_attachment_id  = tobool(lookup(var.transit_gateway_routes[count.index], "blackhole", false)) == false ? lookup(var.transit_gateway_routes[count.index], "attachment_id") : null
}

resource "aws_ec2_transit_gateway_route_table_propagation" "propagation" {
  count = var.propagation_route_table == true ? length(var.transit_gateway_attachment_id) : 0

  transit_gateway_attachment_id  = var.transit_gateway_attachment_id[count.index]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.route_table.id
}
