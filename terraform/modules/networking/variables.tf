# ====================================================================
# 1. VPC variables
# ====================================================================

variable "main_vpc_cidr_block" {
  description = "The CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "main_vpc_name" {
  description = "VPC Name"
  type = string
  default = "development"
}

variable "main_vpc_environment" {
  description = "VPC Environment"
  type = string
  default = "dev"
}

# ====================================================================
# 2. Public Subnets Variables
# ====================================================================

variable "public_subnet_1_cidr_block" {
  description = "The CIDR Block for public subnet 1"
  type = string
  default = "10.0.1.0/24"
}

variable "public_subnet_1_az1a" {
  description = "The availability zone for public subnet 1"
  type = string
  default = "us-east-1a"
}

variable "public_subnet_1_name" {
  description = "The public subnet 1 name"
  type = string
  default = "public-subnet-1"
}

variable "public_subnet_2_cidr_block" {
  description = "The CIDR Block for public subnet 2"
  type = string
  default = "10.0.2.0/24"
}

variable "public_subnet_2_az1b" {
  description = "The availability zone for public subnet 2"
  type = string
  default = "us-east-1b"
}

variable "public_subnet_2_name" {
  description = "The public subnet 2 name"
  type = string
  default = "public-subnet-2"
}

# ====================================================================
# 3. Private Subnets Variables
# ====================================================================

variable "private_subnet_1_cidr_block" {
  description = "The CIDR Block for private subnet 1"
  type = string
  default = "10.0.3.0/24"
}

variable "private_subnet_1_az1a" {
  description = "The availability zone for private subnet 1"
  type = string
  default = "us-east-1a"
}

variable "private_subnet_1_name" {
  description = "The private subnet 1 name"
  type = string
  default = "private-subnet-1"
}

variable "private_subnet_2_cidr_block" {
  description = "The CIDR Block for private subnet 2"
  type = string
  default = "10.0.4.0/24"
}

variable "private_subnet_2_az1b" {
  description = "The availability zone for private subnet 2"
  type = string
  default = "us-east-1b"
}

variable "private_subnet_2_name" {
  description = "The private subnet 2 name"
  type = string
  default = "private-subnet-2"
}

# ====================================================================
# 4. Internet Gateway (IGW) Variables
# ====================================================================

variable "main_igw_name" {
  description = "The IGW name"
  type = string
  default = "main_igw"
}

# ====================================================================
# 5. Elastic IP's Variables
# ====================================================================

variable "nat_eip_az1_name" {
  description = "The Elastic IP in AZ1"
  type = string
  default = "nat-eip-az1"
}

variable "nat_eip_az2_name" {
  description = "The Elastic IP in AZ2"
  type = string
  default = "nat-eip-az2"
}

# ====================================================================
# 6. NAT Gateway Variables
# ====================================================================

variable "nat_gw_az1_name" {
  description = "Name of NAT Gateway in availability zone 1"
  type = string
  default = "nat-gw-az1"
}

variable "nat_gw_az2_name" {
  description = "Name of NAT Gateway in availability zone 2"
  type = string
  default = "nat-gw-az2"
}