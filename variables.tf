variable "vpc_block_public_access" {
  description = "VPC block public access settings"
  type = object({
    internet_gateway_block_mode = string

    exclusions = optional(list(object({
      name                            = string
      internet_gateway_exclusion_mode = string

      subnet_id = optional(string)
      vpc_id    = optional(string)
      tags      = optional(map(string), {})
    })), [])
  })
}
