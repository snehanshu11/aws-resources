resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.tag}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = "${var.tag}"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.demo.id
  for_each = var.public_subnet
  cidr_block = each.value
  availability_zone = each.key
  tags = {
    Name ="${var.tag}"
    Type = "public"
  }

}

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.demo.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name ="${var.tag}"
    Type = "public"
  }
}

resource "aws_route_table_association" "a" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt-public.id
}



resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.demo.id
  for_each = var.private_subnet
  cidr_block = each.value
  availability_zone = each.key
  tags = {
    Name ="${var.tag}"
    Type = "private"
  }

}


resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name ="${var.tag}"
    Type = "private"
  }
}

resource "aws_route_table_association" "b" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt-private.id
}
