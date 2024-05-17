variable "vpc_cidr" {
  type = string
}

variable "tag" {
  type = string
}

variable "public_subnet" {
  type = map(string)
}

variable "private_subnet" {
  type = map(string)
}