# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW-MSA"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

#NAT Gateway
resource "aws_nat_gateway" "main" {
  count = length(var.ap_subnet_cidr_list)
  connectivity_type = "private"
  subnet_id = element(aws_subnet.app.*.id, count.index)

  tags = {
    Name = "NAT-MAS"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}