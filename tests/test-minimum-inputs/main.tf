module "block_public_access" {
  source = "../.."

  vpc_block_public_access = {
    internet_gateway_block_mode = "block-bidirectional"
  }
}
