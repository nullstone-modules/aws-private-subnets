resource "aws_eip" "nat" {
  vpc  = true
  tags = merge({ "Name" = format("%s-%s", local.resource_name, local.azs[0]) }, local.tags)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.nat_subnet_id
  tags          = merge({ "Name" = format("%s-%s", local.resource_name, element(local.azs, 0)) }, local.tags)
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id

  timeouts {
    create = "5m"
  }
}
