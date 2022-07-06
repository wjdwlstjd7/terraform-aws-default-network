resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_list)

  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_list[count.index]
  availability_zone = format("${var.region[var.region_code]}%s", element(var.azs, count.index))
  tags = {
    Name = format("SUNBNET-MSA-2%s-PUB", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

### private_subnet ####
resource "aws_subnet" "app" {
  count = length(var.ap_subnet_cidr_list)

  cidr_block = var.ap_subnet_cidr_list[count.index]
  availability_zone = "${var.region[var.region_code]}${var.azs[count.index]}"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = format("SUBNET-MSA-2%s-APP", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}


resource "aws_subnet" "db" {
  count = length(var.db_subnet_cidr_list)

  cidr_block = var.db_subnet_cidr_list[count.index]
  availability_zone = "${var.region[var.region_code]}${var.azs[count.index]}"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = format("SUBNET-MAS-2%s-DB", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}