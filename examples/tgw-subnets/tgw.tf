module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "2.12.1"

  name        = "network-tgw"
  description = "Network TGW"

  enable_auto_accept_shared_attachments = true

  ram_name                      = "network-tgw"
  ram_allow_external_principals = true
}