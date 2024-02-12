provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  vpc_cidr = "10.1.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../../"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 20)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 30)]
  tgw_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 40)]

  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  transit_gateway_routes = {
    public  = "10.0.0.0/8"
    private = "10.0.0.0/8"
    intra   = "10.0.0.0/8"
  }

  enable_nat_gateway     = true
  enable_tgw_nat_gateway = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_vpn_gateway     = false

  enable_ipv6                                    = false
  private_subnet_assign_ipv6_address_on_creation = false

  tags = local.tags
}
