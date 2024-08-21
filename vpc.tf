data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

# create vpc
resource "aws_vpc" "lab_vpc" {
  cidr_block = var.lab_vpc.cidr_block
  tags = {
    Name = var.lab_vpc.vpc_name
  }
}

# create igw
resource "aws_internet_gateway" "lab_vpc_igw" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "My IGW"
  }
}

# create public subnet
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnet
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = each.value.cidr_block //variable >> map >> key >> value 
  availability_zone       = each.value.zone
  map_public_ip_on_launch = true
  tags = {
    Name = each.value.name
  }
}

# create public route table
resource "aws_route_table" "my_public_rtb" {
  vpc_id = aws_vpc.lab_vpc.id
  route {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_vpc_igw.id
  }
  tags = {
    Name = "public rtb"
  }
}

resource "aws_route_table_association" "public_rtb_association" {
  for_each =  aws_subnet.public_subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.my_public_rtb.id
}