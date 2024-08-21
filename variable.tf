variable "lab_vpc" {
  type = object({
    vpc_name   = string
    cidr_block = string
  })

  default = {
    vpc_name   = "My Vpc"
    cidr_block = "10.0.0.0/16"
  }
}
# create variable for public subnet >> with map >> key and values
variable "public_subnet" {
  type = map(object({
    cidr_block = string
    zone       = string
    name       = string
  }))
  default = {
    "public_subnet_1" = {
      cidr_block = "10.0.1.0/24"
      zone       = "ap-southeast-1a"
      name       = "Public_subnet_1"
    },
    "public_subnet_2" = {
      cidr_block = "10.0.2.0/24"
      zone       = "ap-southeast-1b"
      name       = "Public_subnet_2"
    },
    "public_subnet_3" = {
      cidr_block = "10.0.3.0/24"
      zone       = "ap-southeast-1c"
      name       = "Public_subnet_3"
    },
  }
}

variable "public-subnet_name" {
  type    = list(string)
  default = ["public subnet 1", "public subnet 2", "public subnet 3"]
}
