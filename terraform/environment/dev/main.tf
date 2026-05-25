module "networking" {
  source = "../../modules/networking"

  # ====================================================================
  # 1. variables for networking module
  # ====================================================================

  # VPC
  main_vpc_cidr_block  = "10.0.0.0/16"
  main_vpc_name        = "development"
  main_vpc_environment = "dev"

  # PUBLIC SUBNETS
  public_subnet_1_cidr_block = "10.0.1.0/24"
  public_subnet_1_az1a       = "us-east-1a"
  public_subnet_1_name       = "public-subnet-1"
  public_subnet_2_cidr_block = "10.0.2.0/24"
  public_subnet_2_az1b       = "us-east-1b"
  public_subnet_2_name       = "public-subnet-2"

  # PRIVATE SUBNETS
  private_subnet_1_cidr_block = "10.0.3.0/24"
  private_subnet_1_az1a       = "us-east-1a"
  private_subnet_1_name       = "private-subnet-1"
  private_subnet_2_cidr_block = "10.0.4.0/24"
  private_subnet_2_az1b       = "us-east-1b"
  private_subnet_2_name       = "private-subnet-2"

  # ELASTIC IP's
  nat_eip_az1_name = "nat-eip-az1"
  nat_eip_az2_name = "nat-eip-az2"

  # NAT Gateway
  nat_gw_az1_name = "nat-gw-az1"
  nat_gw_az2_name = "nat-gw-az2"

  # ROUTE TABLE
  public_rt_name  = "public-rt"
  private_rt_name = "private-rt"
}