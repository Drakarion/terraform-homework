#vpc
data "aws_vpc" "default" {
  default = true
}

#availability zones
data "aws_availability_zones" "available" {
  state = "available"
  exclude_names = ["us-west-2d"]
}


data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#security group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "SSH, HTTP, HTTPS, MySQL"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2
resource "aws_instance" "web" {
  count         = 3
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id = var.subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  #Apache, web-page
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              echo "Hello, World!" > /var/www/html/index.html
              systemctl enable apache2
              systemctl start apache2
              EOF
}
