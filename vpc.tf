##################################################
# Resource - VPC -
##################################################
resource "aws_vpc" "demo-vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.environment}-vpc"
    Env  = local.environment
  }
}

##################################################
# Resource - Subnet -
##################################################
resource "aws_subnet" "demo-subnet" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = var.demo-az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.environment}-subnet"
    Env  = local.environment
  }
}

##################################################
# Resource - Route Table -
##################################################
resource "aws_route_table" "demo-route-table" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${local.environment}-route-table"
    Env  = local.environment
  }
}

resource "aws_route_table_association" "demo-route-table-association" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-route-table.id
}

resource "aws_main_route_table_association" "demo-main-route-table-association" {
  vpc_id         = aws_vpc.demo-vpc.id
  route_table_id = aws_route_table.demo-route-table.id
}

##################################################
# Resource - IGW -
##################################################
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${local.environment}-igw"
    Env  = local.environment
  }
}

resource "aws_route" "demo-route" {
  route_table_id         = aws_route_table.demo-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo-igw.id
  depends_on             = [aws_route_table.demo-route-table]
}

##################################################
# Resource - Security Group -
##################################################
resource "aws_security_group" "demo-security-group" {
  name   = "${local.environment}-security-group"
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${local.environment}-security-group"
    Env  = local.environment
  }
}

resource "aws_security_group_rule" "demo-ingress-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.demo-accessgip]
  security_group_id = aws_security_group.demo-security-group.id
}

resource "aws_security_group_rule" "demo-ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.demo-accessgip]
  security_group_id = aws_security_group.demo-security-group.id
}
