variable "ibmcloud_api_key" {
 default = ""
 description = "The APIKey of the IBM Cloud account where resources will be provisioned."
}

variable "ibmcloud_vnf_svc_api_key" {
 default = ""
 description = "The APIKey of the IBM Cloud NFV service account that is hosting the F5-BIGIP qcow2 image file."
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
#  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
  generation            = "${var.generation}"
  region                = "${var.region}"
  ibmcloud_timeout      = 300
}

provider "ibm" {
  alias                 = "vfnsvc"
  ibmcloud_api_key      = "${var.ibmcloud_vnf_svc_api_key}"
  generation            = "${var.generation}"
  region                = "${var.region}"
  ibmcloud_timeout      = 300
}
