variable "vnf_cos_instance_id" {
  default     = ""
  description = "The COS instance-id hosting the F5-BIGIP qcow2 image."
}
variable "zone" {
  default = "us-south-1"
  description = "The VPC Zone that you want your VPC networks and virtual servers to be provisioned in. To list available zones, run `ibmcloud is zones`."
}

variable "vpc_name" {
  default = "f5-bigip-1nic-demo-vpc"
  description = "The name of your VPC to be provisioned."
}

variable "ssh_public_key" {
  default = ""
  description = "The [public SSH key](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-ssh-keys) that you use to access your VPC virtual servers. Use the public key from the `~/.ssh/id_rsa.pub` file generated by the latest version of ssh-keygen tool, with the recommended key-size 2048."
}

variable "ssh_key_name" {
  default = "f5-ssh-pub-key"
  description = "The name of the public SSH key."
}

variable "f5_image" {
  default = "r006-648e7564-a7e1-40d5-8e92-6ff67c26ce9c"
  description = "The ID of the F5 custom image provisioned in your IBM Cloud account. To list available images, run `ibmcloud is images`. The default image is for an `f5-bigip` image in a demo account."
}

variable "f5_vsi_name" {
  default = "f5-bigip-1nic-demo-appliance"
  description = "The name of your F5 Virtual Server to be provisioned."
}

variable "profile" {
  default = "bx2-2x8"
  description = "The profile of compute CPU and memory resources that you want your VPC virtual servers to have. To list available profiles, run `ibmcloud is instance-profiles`."
}

variable "f5_license" {
  default = ""
  description = "Optional. The BYOL license key that you want your F5 virtual server in a VPC to be used by registration flow during cloud-init."
}