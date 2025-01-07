resource "aws_vpc_block_public_access_options" "this" {
  internet_gateway_block_mode = var.vpc_block_public_access.internet_gateway_block_mode
}

resource "aws_vpc_block_public_access_exclusion" "this" {
  for_each = { for exclusion in var.vpc_block_public_access.exclusions : exclusion.name => exclusion }

  internet_gateway_exclusion_mode = each.value.internet_gateway_exclusion_mode

  subnet_id = each.value.subnet_id
  vpc_id    = each.value.vpc_id

  tags = merge(
    {
      Name = each.value.name
    },
    each.value.tags,
  )
}
