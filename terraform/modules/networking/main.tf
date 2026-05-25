# ====================================================================
# 1. Create VPC
# ====================================================================

resource "aws_vpc" "main_vpc" {
  cidr_block = var.main_vpc_cidr_block
  tags = {
    Name = var.main_vpc_name
    environment = var.main_vpc_environment
  }
}

# ====================================================================
# 2. Create Public Subnets 
# ====================================================================

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_1_cidr_block
  availability_zone = var.public_subnet_1_az1a
  tags = {
    Name = var.public_subnet_1_name
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_2_cidr_block
  availability_zone = var.public_subnet_2_az1b
  tags = {
    Name = var.public_subnet_2_name
  }
}

# ====================================================================
# 3. Create Private Subnets 
# ====================================================================

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_1_cidr_block
  availability_zone = var.private_subnet_1_az1a
  tags = {
    Name = var.private_subnet_1_name
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_2_cidr_block
  availability_zone = var.private_subnet_2_az1b
  tags = {
    Name = var.private_subnet_2_name
  }
}

# ====================================================================
# 4. Create Internet Gatway
# ====================================================================

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.main_igw_name
  }
}

# ====================================================================
# 5. Create Elastic IP
# ====================================================================

resource "aws_eip" "nat_eip_az1" {
  domain = "vpc"
  tags = {
    Name = nat_eip_az1_name
    environment = var.main_vpc_environment
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}

resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"
  tags = {
    Name = nat_eip_az2_name
    environment = var.main_vpc_environment
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}

# ====================================================================
# 6. Create NAT Gateway
# ====================================================================

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id = aws_subnet.public_subnet_1.id
  tags = {
    Name = var.nat_gw_az1_name
    environment = var.main_vpc_environment 
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id = aws_subnet.public_subnet_2.id
  tags = {
    Name = var.nat_gw_az2_name
    environment = var.main_vpc_environment
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}

# ====================================================================
# 7. Create Route Table
# ====================================================================

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.public_rt_name
    environment = var.main_vpc_environment
  } 
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.private_rt_name
    environment = var.main_vpc_environment
  }
}

# ====================================================================
# 8. Create Route Table Association
# ====================================================================

resource "aws_route_table_association" "public_rta_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rta_1" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rta_2" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}