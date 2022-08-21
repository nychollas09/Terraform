resource "aws_vpc" "new-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "available-zones" {}

resource "aws_internet_gateway" "new-igw" {
  vpc_id = resource.aws_vpc.new-vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new-rtb" {
  vpc_id = resource.aws_vpc.new-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = resource.aws_internet_gateway.new-igw.id
  }

  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_subnet" "new-subnets" {
  count = 2

  vpc_id                  = resource.aws_vpc.new-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available-zones.names[count.index]
  map_public_ip_on_launch = true # Gerar IP Public de Acesso para a Subnet

  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

resource "aws_route_table_association" "new-rtb-association" {
  count          = 2
  subnet_id      = resource.aws_subnet.new-subnets[count.index].id
  route_table_id = resource.aws_route_table.new-rtb.id
}

# resource "aws_subnet" "new-subnet-1" {
#   vpc_id            = aws_vpc.new-vpc.id
#   cidr_block        = "10.0.0.0/24"
#   availability_zone = data.aws_availability_zones.available-zones.names[0]

#   tags = {
#     Name = "${var.prefix}-subnet-1"
#   }
# }

# resource "aws_subnet" "new-subnet-2" {
#   vpc_id            = aws_vpc.new-vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = data.aws_availability_zones.available-zones.names[1]

#   tags = {
#     Name = "${var.prefix}-subnet-2"
#   }
# }
