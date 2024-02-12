module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "2.12.1"

  name        = "network-tgw"
  description = "Network TGW"

  enable_auto_accept_shared_attachments = true

  # vpc_attachments = {
  #   network_prod_vpc = {
  #     vpc_id       = module.vpc.vpc_id
  #     subnet_ids   = module.vpc.intra_subnets
  #     dns_support  = true
  #     ipv6_support = false

  #     tgw_routes = [
  #       {
  #         blackhole              = false
  #         destination_cidr_block = "0.0.0.0/0"
  #       },
  #       # {
  #       #   blackhole = false
  #       #   destination_cidr_block = "40.0.0.0/20"
  #       # }
  #     ]
  #   }
  # }
  ram_name                      = "network-tgw"
  ram_allow_external_principals = true
  # ram_principals                = [local.account_id.network-prod, local.account_id.shared-infra-prod]
}