output "options" {
  description = "VPC block public access options"
  value       = aws_vpc_block_public_access_options.this
}

output "exclusions" {
  description = "Map of VPC block public access exclusion objects"
  value       = aws_vpc_block_public_access_exclusion.this
}
