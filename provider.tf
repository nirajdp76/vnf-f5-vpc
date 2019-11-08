variable "ibmcloud_api_key" {
  default = ""
  description = "The APIKey of the IBM Cloud account where resources will be provisioned."
}

variable "region" {
  default = "us-south"
  description = "The VPC Region that you want your VPC, networks and the F5 virtual server to be provisioned in. To list available regions, run `ibmcloud is regions`."
}

variable "generation" {
  default = 2
  description = "The VPC Generation to target. Valid values are 2 or 1."
}

provider "ibm" {
  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
  generation            = "${var.generation}"
  region                = "${var.region}"
  ibmcloud_timeout      = 300
}
