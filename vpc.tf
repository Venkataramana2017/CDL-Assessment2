resource "aws_vpc" "Test_VPCc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Test_VPC"
  }
}

resource "aws_subnet" "private_us_east_1a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public Subnet us-east-1a"
  }
}

resource "aws_subnet" "private_us_east_1b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private Subnet us-east-1b"
  }
}

resource "aws_subnet" "private_us_east_1c" {
  vpc_id     = aws_vpc.Test_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Private Subnet us-east-1c"
  }
}
resource "aws_internet_gateway" "test_vpc_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "Test_VPC - Internet Gateway"
  }
}

resource "aws_route_table" "my_vpc_private" {
    vpc_id = aws_vpc.test_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_vpc_igw.id
    }

    tags = {
        Name = "Private Subnets Route Table for Test_VPC"
    }
}

resource "aws_route_table_association" "Test_vpc_us_east_1a_private" {
    subnet_id = aws_subnet.private_us_east_1a.id
    route_table_id = aws_route_table.Test_vpc_private.id
}

resource "aws_route_table_association" "Test_vpc_us_east_1b_private" {
    subnet_id = aws_subnet.private_us_east_1b.id
    route_table_id = aws_route_table.Test_vpc_private.id

  resource "aws_route_table_association" "Test_vpc_us_east_1c_private" {
    subnet_id = aws_subnet.private_us_east_1c.id
    route_table_id = aws_route_table.Test_vpc_private.id
    
