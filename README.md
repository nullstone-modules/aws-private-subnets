# Private Subnets

Nullstone module to backfill an existing network with private subnets.

To protect infrastructure from adversaries, Nullstone uses subnets that aren't directly connected to the internet to host apps and datastores.
If you are importing a network that does not have private subnets, this module backfills private subnets.

When creating this module, you will need the `vpc_id` of the existing network and `nat_subnet_id` (a subnet that has an internet gateway).
