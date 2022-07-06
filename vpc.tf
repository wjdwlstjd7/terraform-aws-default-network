# AWS VPC 생성
resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = false

  tags = {
    Name = "VPC-HX-MSA"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

# Default route table
resource "aws_default_route_table" "main" {

  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "RT-default"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

# Default VPC DHCP Options
resource "aws_default_vpc_dhcp_options" "default" {

  tags = {
    Name = "DHCP-default"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_vpc.main]
  lifecycle {
    ignore_changes = [
      tags]
  }
}

# Default Network ACL
resource "aws_default_network_acl" "default" {

  default_network_acl_id = aws_vpc.main.default_network_acl_id

  ingress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  egress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  tags = {
    Name = "NACL-default"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  lifecycle {
    ignore_changes = [
      tags,
      subnet_ids]
  }
}

# Default Security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "SG-default"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}