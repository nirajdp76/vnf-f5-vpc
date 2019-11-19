##############################################################################
# This file creates the compute instances for the solution.
# - Virtual Server using F5-BIGIP custom image
# - Two virtual servers initialized with nginx to demo Load Balancing using F5-BIGIP
##############################################################################


##############################################################################
# Create ssh key for all virtual servers.
##############################################################################
resource "ibm_is_ssh_key" "f5_ssh_pub_key" {
  name       = "${var.ssh_key_name}"
  public_key = "${var.ssh_public_key}"
}

##############################################################################
# Create F5-BIGIP virtual server.
##############################################################################
resource "ibm_is_instance" "f5_vsi" {
  name    = "${var.f5_vsi_name}"
  image   = "${data.ibm_is_image.f5_custom_image.id}"
  profile = "${var.profile}"

  primary_network_interface = {
    subnet = "${ibm_is_subnet.f5_subnet1.id}"
  }

  vpc  = "${ibm_is_vpc.f5_vpc.id}"
  zone = "${var.zone}"
  keys = ["${ibm_is_ssh_key.f5_ssh_pub_key.id}"]
  # user_data = "$(replace(file("f5-userdata.sh"), "F5-LICENSE-REPLACEMENT", var.f5_license)"

  //User can configure timeouts
  timeouts {
    create = "10m"
    delete = "10m"
  }

  # Hack to handle some race condition; will remove it once have root caused the issues.
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
