#### Public route_table ####
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  depends_on = [
    aws_internet_gateway.main]
  tags = merge(local.tags, {
    Name = "RT-MAS-PUBLIC"
  })
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

#### Private route_table ####
resource "aws_route_table" "app" {
  count  = length(var.ap_subnet_cidr_list)
  vpc_id = aws_vpc.main.id
  depends_on = [
    aws_nat_gateway.main]
  tags   = merge(local.tags, {
    Name = format("RT-MSA-2%s-app", element(var.azs, count.index))
  })
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_route" "private_nat_gateway" {
  count = length(var.ap_subnet_cidr_list)
  route_table_id = element(aws_route_table.app.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table" "db" {
  count = length(var.db_subnet_cidr_list)
  vpc_id = aws_vpc.main.id
  tags = merge(local.tags, {
    Name = format("RT-MSA-2%s-DB", element(var.azs, count.index))
  })
  lifecycle {
    ignore_changes = [
      tags]
  }
}

#### Route table association ####
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_list)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = one(aws_route_table.public.*.id)
}

resource "aws_route_table_association" "app" {
  count = length(var.ap_subnet_cidr_list)
  subnet_id = element(aws_subnet.app.*.id, count.index)
  route_table_id = element(aws_route_table.app.*.id, count.index)
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnet_cidr_list)
  subnet_id = element(aws_subnet.db.*.id, count.index)
  route_table_id = element(aws_route_table.db.*.id, count.index)
}