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
  public_rt_name      = "public-rt"
  private_rt_az1_name = "private-rt-az1"
  private_rt_az2_name = "private-rt-az2"
}

# ====================================================================
# 2. Security Module (IAM & Security Groups)
# ====================================================================

module "security" {
  source = "../../modules/security"

  # Connect the security module with the VPC created in the networking module
  vpc_id = module.networking.vpc_id
}

# ====================================================================
# 3. ALB Module
# ====================================================================

module "alb" {
  source = "../../modules/alb"

  # 1. Application Load Balancer (ALB)
  main_alb_name              = "dev-main-alb"
  main_alb_environment       = "dev"
  vpc_id                     = module.networking.vpc_id
  main_alb_security_group_id = [module.security.alb_sg_id]
  main_alb_subnets           = module.networking.public_subnets_ids

  # 2. Target Group
  main_tg_name = "dev-ecs-target-group"
  main_tg_port = "80"

  # 3. ALB Listener
  main_listener_port     = "80"
  main_listener_protocol = "HTTP"
  main_listener_name     = "dev-main-listener"
}

# ====================================================================
# 4. ECS & ECR Module 
# ====================================================================

module "ecs" {
  source = "../../modules/ecs"

  # 1. IAM & Security Roles
  task_execution_role_arn = module.security.ecs_task_execution_role_arn
  task_role_arn           = module.security.ecs_task_role_arn

  # 2. Container & Service Configuration
  container_image  = "nginx:latest"
  app_service_name = "dev-app-service"

  # 3. Networking Configuration (ECS Task runs in private subnets)
  subnets         = module.networking.private_subnets_ids
  security_groups = [module.security.ecs_task_sg_id]

  # 4. Load Balancer Integration
  target_group_arn = module.alb.target_group_arn
}
