locals {
  additional_providers = [
    {
      alias    = "psk"
      provider = "aws"
      region   = "eu-north-1"
      profile  = "nv-network"
    },
  ]
}
