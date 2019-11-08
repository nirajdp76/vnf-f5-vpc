variable "region" {
  default = "us-south"
  description = "The VPC Region that you want your VPC, networks and the F5 virtual server to be provisioned in. To list available regions, run `ibmcloud is regions`."
}

variable "riaas_endpoint" {
  default = "us-south.iaas.cloud.ibm.com"
  description = "The VPC Regional api endpoint. To list available regional endpoints, run `ibmcloud is regions`."
}

provider "ibm" {
  generation            = 2
  region                = "${var.region}"
  ibmcloud_timeout      = 300
  riaas_endpoint        = "${var.riaas_endpoint}"
}
