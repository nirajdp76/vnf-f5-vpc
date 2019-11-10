#!/bin/bash
set -xe
export TF_LOG=debug 


export IBMCLOUD_IS_API_ENDPOINT=us-south-stage01.iaasdev.cloud.ibm.com
printenv

terraform init
terraform apply -auto-approve -state=terraform.tfstate -var-file=schematics.tfvars

# hack to show the VPC resource on the schematics UI, but destroy will not work
#cp -f terraform.tfstate ../
#cp -f terraform.tfstate.backup ../
