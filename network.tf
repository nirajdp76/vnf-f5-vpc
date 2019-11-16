##############################################################################
# This file creates various network resources for the solution.
#  - VPC in user specified region and resource_group
#  - Address_Prefix in user specified region, zone and resource_group (for poc is using default)
#  - Public_Gateway in user specified region, zone and resource_group
#  - Subnet in user specified region, zone and resource_group
#  - Floating_IP attached to virtual server's primary network interface
##############################################################################


##############################################################################
# Create VPC
##############################################################################
resource "ibm_is_vpc" "f5_vpc01" {
  name = "${var.vpc_name}"
  resource_group = "${data.ibm_resource_group.rg.id}"
}

##############################################################################
# Create Public_Gateway for a given VPC
##############################################################################
resource "ibm_is_public_gateway" "f5_gateway01" {
  name = "f5-bigip-1nic-demo-gateway01"
  vpc  = "${ibm_is_vpc.f5_vpc01.id}"
  zone = "${var.zone}"

  //User can configure timeouts
  timeouts {
    create = "2m"
  }
}

##############################################################################
# Create Subnet for a given VPC
##############################################################################
resource "ibm_is_subnet" "f5_subnet1" {
  name            = "f5-bigip-1nic-demo-subnet01"
  vpc             = "${ibm_is_vpc.f5_vpc01.id}"
  zone            = "${var.zone}"
  ipv4_cidr_block = "10.240.0.0/24"
}

##############################################################################
# Create Floating-IP targeted to F5-BIGIP virtual server primary network
##############################################################################
resource ibm_is_floating_ip "f5_fip01" {
  name   = "f5-bigip-1nic-demo-ip01"
  target = "${ibm_is_instance.f5_vsi.primary_network_interface.0.id}"
}
