variable "ami" {
  default = "ami-05f991c49d264708f" # Ubuntu 22.04 LTS в us-west-2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "bastion"
}

variable "subnet_ids" {
  default = [
    "subnet-016997ae8d8eb1a9f",
    "subnet-0d8de3b537c1e8ae3",
    "subnet-0618617449680ec00"
  ]
}