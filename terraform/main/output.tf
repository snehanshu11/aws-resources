output "vpc" {
  value = module.network-west-2.vpc
}

output "public_subnet" {
  value = module.network-west-2.public_subnet
}

output "private_subnet" {
  value = module.network-west-2.private_subnet
}

output "internet_gateway" {
  value = module.network-west-2.internet_gateway
}