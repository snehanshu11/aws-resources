
output "private_subnet" {
  value = { for obj in aws_subnet.private: obj.availability_zone => obj.cidr_block }
}

output "public_subnet" {
  value = { for obj in aws_subnet.public: obj.availability_zone => obj.cidr_block }
}

output "internet_gateway" {
  value = {"gateway_id":aws_internet_gateway.gw.id ,"vpc_id": aws_internet_gateway.gw.vpc_id}
}

output "vpc" {
  value = {"vpc_id": aws_vpc.demo.id, "cidr_block": aws_vpc.demo.cidr_block}
}