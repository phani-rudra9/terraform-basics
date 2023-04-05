resource "aws_vpc" "demo" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "demo-vpc"
    created_by = "phani"
    created_on_month="april"
    purpose = "demo"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = "demo-igw"
    created_by = "phani"
    created_on_month="april"
    purpose = "demo"
  }
}


resource "aws_subnet" "public-1a" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.public_subnet_1a_cidr_block
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "demo-public-1a"
    created_by = "phani"
    created_on_month="april"
    purpose = "demo"
  }
}


resource "aws_subnet" "public-1b" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "demo-public-1b"
    created_by = "phani"
    created_on_month="april"
    purpose = "demo"
  }
}


resource "aws_route_table" "demo-public-rt" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "demo-public-rt"
    created_by = "phani"
    created_on_month="april"
    purpose = "demo"
  }
}


resource "aws_route_table_association" "demo" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.demo-public-rt.id
}

resource "aws_route_table_association" "demo2" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.demo-public-rt.id
}