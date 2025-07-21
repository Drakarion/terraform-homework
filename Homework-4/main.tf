resource "aws_vpc" "main" {
  cidr_block = var.vpcs[0].cidr_block
  enable_dns_support = var.vpcs[0].enable_dns_support
  enable_dns_hostnames = var.vpcs[0].enable_dns_hostnames

  tags = local.tags
}

resource "aws_subnet" "subnet" {
  count = length(var.subnets)

  vpc_id = aws_vpc.main.id
  cidr_block = var.subnets[count.index].cidr_block
  availability_zone = var.subnets[count.index].availability_zone
  map_public_ip_on_launch = var.subnets[count.index].auto_assign_ip

  tags = merge(local.tags, { Name = var.subnets[count.index].name })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, { Name = var.igw_name })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.tags, { Name = var.route_table_names[0] })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, { Name = var.route_table_names[1] })
}

resource "aws_route_table_association" "public_assoc" {
  count = 2
  subnet_id = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  count = 2
  subnet_id = aws_subnet.subnet[count.index + 2].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "main" {
  name = "main-sg"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_instance" "web" {
  ami = var.ec2_config["ami"]
  instance_type = var.ec2_config["type"]
  subnet_id = aws_subnet.subnet[0].id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name = var.key_name
  associate_public_ip_address = true
  
  tags = local.tags
}

resource "aws_key_pair" "default" {
  key_name = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")

  tags = local.tags
}