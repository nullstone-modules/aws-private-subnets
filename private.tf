locals {
  azs = data.aws_availability_zones.this.names
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id                          = var.vpc_id
  cidr_block                      = var.private_subnets[count.index]
  availability_zone               = local.azs[count.index]
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch         = false

  tags = merge({ "Name" = format("%s-private-%s", local.resource_name, element(local.azs, count.index)) }, local.tags)
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags   = merge({ "Name" = "${local.resource_name}-private" }, local.tags)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
