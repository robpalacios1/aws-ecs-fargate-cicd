# ====================================================================
# 1. Create VPC
# ====================================================================

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "development"
    environment = "dev"
  }
}

# ====================================================================
# 2. Create Public Subnets 
# ====================================================================

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public_subnet_2"
  }
}

# ====================================================================
# 3. Create Private Subnets 
# ====================================================================

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet_1"
  }
}

# ====================================================================
# 4. Create Internet Gatway
# ====================================================================

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}

# ====================================================================
# 5. Create Elastic IP
# ====================================================================

resource "aws_eip" "nat_eip_az1" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-az1"
    environment = "development"
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}

resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-az2"
    environment = "development"
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}