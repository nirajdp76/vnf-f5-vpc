resource "ibm_is_vpc" "f5_vpc01" {
  name = "${var.vpc_name}"
}

resource "ibm_is_security_group" "f5_sg01" {
  name = "f5-bigip-1nic-demo-sg01"
  vpc  = "${ibm_is_vpc.f5_vpc01.id}"
}

resource "ibm_is_security_group_rule" "f5_egress_all" {
  depends_on = ["ibm_is_floating_ip.f5_fip01"]
  group      = "${ibm_is_vpc.f5_vpc01.default_security_group}"
  direction  = "outbound"
  remote     = "0.0.0.0/0"

  tcp = {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "f5_sg01_rule1" {
  depends_on = ["ibm_is_floating_ip.f5_fip01"]
  group      = "${ibm_is_vpc.f5_vpc01.default_security_group}"
  direction  = "inbound"
  remote     = "0.0.0.0/0"

  tcp = {
    port_min = 8443
    port_max = 8443
  }
}

resource "ibm_is_security_group_rule" "f5_sg01_rule2" {
  depends_on = ["ibm_is_floating_ip.f5_fip01"]
  group      = "${ibm_is_vpc.f5_vpc01.default_security_group}"
  direction  = "inbound"
  remote     = "0.0.0.0/0"

  tcp = {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "f5_sg01_rule3" {
  depends_on = ["ibm_is_floating_ip.f5_fip01"]
  group      = "${ibm_is_vpc.f5_vpc01.default_security_group}"
  direction  = "inbound"
  remote     = "0.0.0.0/0"

  tcp = {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "f5_sg01_icmp_rule" {
  depends_on = ["ibm_is_floating_ip.f5_fip01"]
  group      = "${ibm_is_vpc.f5_vpc01.default_security_group}"
  direction  = "inbound"
  remote     = "0.0.0.0/0"

  icmp = {
    code = 0
    type = 8
  }
}

resource "ibm_is_security_group_network_interface_attachment" "f5_sgnic1" {
  security_group    = "${ibm_is_security_group.f5_sg01.id}"
  network_interface = "${ibm_is_instance.f5_vsi.primary_network_interface.0.id}"
}

resource "ibm_is_subnet" "f5_subnet1" {
  name            = "f5-bigip-1nic-demo-subnet01"
  vpc             = "${ibm_is_vpc.f5_vpc01.id}"
  zone            = "${var.zone}"
  ipv4_cidr_block = "10.240.0.0/24"
}

resource "ibm_is_ssh_key" "f5_ssh01" {
  name       = "${var.ssh_key_name}"
  public_key = "${var.ssh_public_key}"
}

resource "ibm_is_instance" "f5_vsi" {
  depends_on = ["ibm_is_public_gateway.f5_gateway01"]
  name    = "${var.f5_vsi_name}"
  image   = "${var.f5_image}"
  profile = "${var.profile}"

  primary_network_interface = {
    subnet = "${ibm_is_subnet.f5_subnet1.id}"
  }

  vpc  = "${ibm_is_vpc.f5_vpc01.id}"
  zone = "${var.zone}"
  keys = ["${ibm_is_ssh_key.f5_ssh01.id}"]
  # user_data = "$(replace(file("f5-userdata.sh"), "F5-LICENSE-REPLACEMENT", var.f5_license)"

  //User can configure timeouts
  timeouts {
    create = "10m"
    delete = "10m"
  }
}

resource ibm_is_floating_ip "f5_fip01" {
  name   = "f5-bigip-1nic-demo-ip01"
  target = "${ibm_is_instance.f5_vsi.primary_network_interface.0.id}"
}

resource "ibm_is_public_gateway" "f5_gateway01" {
  name = "f5-bigip-1nic-demo-gateway01"
  vpc  = "${ibm_is_vpc.f5_vpc01.id}"
  zone = "${var.zone}"

  //User can configure timeouts
  timeouts {
    create = "10m"
  }
}
