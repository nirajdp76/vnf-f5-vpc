variable "region" {
  default = "us-south"
  description = "The VPC Region that you want your VPC, networks and the F5 virtual server to be provisioned in. To list available regions, run `ibmcloud is regions`."
}

provider "ibm" {
  generation            = 2
  region                = "${var.region}"
  ibmcloud_timeout      = 300
}
