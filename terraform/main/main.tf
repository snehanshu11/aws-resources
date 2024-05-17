module "network-west-2" {
  source         = "../modules/network"
  vpc_cidr       = "10.0.0.0/16"
  tag            = "demo-app"
  public_subnet  = { "us-west-2a" : "10.0.1.0/24", "us-west-2b" : "10.0.2.0/24" }
  private_subnet = { "us-west-2a" : "10.0.3.0/24", "us-west-2b" : "10.0.4.0/24" }

}
