module "block_public_access" {
  source = "../.."

  vpc_block_public_access = {
    internet_gateway_block_mode = "block-bidirectional"

    exclusions = [
      {
        name                            = "test-subnet-exclusion"
        internet_gateway_exclusion_mode = "allow-bidirectional"
        subnet_id                       = one(module.vpc.public_subnets)
        tags                            = local.tags
      },
      {
        name                            = "test-vpc-exclusion"
        internet_gateway_exclusion_mode = "allow-bidirectional"
        vpc_id                          = module.vpc.vpc_id
        tags                            = local.tags
      },
    ]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.test_name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_ipv6            = true
  create_egress_only_igw = true

  public_subnet_ipv6_prefixes                    = [0]
  public_subnet_assign_ipv6_address_on_creation  = true
  private_subnet_ipv6_prefixes                   = [3]
  private_subnet_assign_ipv6_address_on_creation = true
  intra_subnet_ipv6_prefixes                     = [6]
  intra_subnet_assign_ipv6_address_on_creation   = true

  tags = local.tags
}

resource "random_string" "test_id" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

locals {
  test_id   = random_string.test_id.result
  test_base = "vpc-block-public-access-${replace(basename(abspath(path.root)), "_", "-")}"
  test_name = "${local.test_base}-${local.test_id}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 1)

  tags = {
    Test = local.test_base
  }
}

data "aws_availability_zones" "available" {}
