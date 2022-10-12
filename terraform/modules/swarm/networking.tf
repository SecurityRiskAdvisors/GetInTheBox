##
# VPCs
##
resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
}

resource "aws_subnet" "primary" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_default_route_table" "primary" {
  default_route_table_id = aws_vpc.primary.default_route_table_id

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.primary.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }
}

##
# secgroups
##

resource "aws_security_group" "swarm_sg" {
  name        = "[${var.project}] Red Swarm"
  description = "Swarm node security group"
  vpc_id      = aws_vpc.primary.id
}

# outbound to anything
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.swarm_sg.id
}

# nodes can communicate between each other
resource "aws_security_group_rule" "ingress_self" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.swarm_sg.id
  security_group_id        = aws_security_group.swarm_sg.id
}

# ingress from IP whitelist
resource "aws_security_group_rule" "ingress_sra" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.ingress_ip_cidrs
  security_group_id = aws_security_group.swarm_sg.id
}
