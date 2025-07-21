# terraform-homework

# Homework 4 – Terraform AWS Infrastructure
This project creates:
- VPC with public and private subnets
- Internet Gateway and Route Tables
- EC2 instance with Security Group
- Fully parameterized infrastructure using variables

## 🔧 Example terraform.tfvars
```hcl
region = "us-east-1"
key_name = "hello"
vpcs = [
  {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
  }
]

subnets = [
  { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a", auto_assign_ip = true, name = "public-1" },
  { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b", auto_assign_ip = true, name = "public-2" },
  { cidr_block = "10.0.3.0/24", availability_zone = "us-east-1c", auto_assign_ip = false, name = "private-1" },
  { cidr_block = "10.0.4.0/24", availability_zone = "us-east-1d", auto_assign_ip = false, name = "private-2" }
]

igw_name = "my-igw"
route_table_names = ["public-rt", "private-rt"]
ports = [22, 80, 443, 3306]

ec2_config = {
  ami  = "ami-05ffe3c48a9991133"
  type = "t2.micro"
}
