#!/bin/bash
set -xe
#export TF_LOG=debug 


export IBMCLOUD_IS_API_ENDPOINT=us-south-stage01.iaasdev.cloud.ibm.com

export IBMCLOUD_ACCOUNT_MANAGEMENT_API_ENDPOINT="https://accountmanagement.stage1.ng.bluemix.net "
export IBMCLOUD_CF_API_ENDPOINT="https://api.stage1.ng.bluemix.net" 
export IBMCLOUD_CS_API_ENDPOINT="https://containers.test.cloud.ibm.com" 
export IBMCLOUD_CR_API_ENDPOINT="https://registry.stage1.ng.bluemix.net" 
export IBMCLOUD_CIS_API_ENDPOINT="https://api.cis.test.cloud.ibm.com" 
export IBMCLOUD_GS_API_ENDPOINT="https://api.global-search-tagging.test.cloud.ibm.com" 
export IBMCLOUD_GT_API_ENDPOINT="https://tags.global-search-tagging.test.cloud.ibm.com"
export IBMCLOUD_IAM_API_ENDPOINT="https://iam.test.cloud.ibm.com"
export IBMCLOUD_IAMPAP_API_ENDPOINT="https://iam.test.cloud.ibm.com"
export IBMCLOUD_ICD_API_ENDPOINT="https://api.us-south.databases.test.cloud.ibm.com" 
export IBMCLOUD_MCCP_API_ENDPOINT="https://mccp.stage1.ng.bluemix.net" 
export IBMCLOUD_RESOURCE_MANAGEMENT_API_ENDPOINT="https://resource-controller.test.cloud.ibm.com" 
export IBMCLOUD_RESOURCE_CONTROLLER_API_ENDPOINT="https://resource-controller.test.cloud.ibm.com" 
export IBMCLOUD_RESOURCE_CATALOG_API_ENDPOINT="https://globalcatalog.test.cloud.ibm.com"  
export IBMCLOUD_UAA_ENDPOINT="https://login.stage1.ng.bluemix.net/UAALoginServerWAR" 
export IBMCLOUD_CSE_ENDPOINT="https://api.serviceendpoint.test.cloud.ibm.com" 
export IBMCLOUD_IS_API_ENDPOINT="us-east-stage02.iaasdev.cloud.ibm.com"  
export IBMCLOUD_IS_NG_API_ENDPOINT="us-south-stage01.iaasdev.cloud.ibm.com"  
printenv

# This is to copy the schamtics UI variables
cp schematics.tfvars vnf-f5-vpc-master/

cd vnf-f5-vpc-master/
ls -la

terraform init
terraform apply -auto-approve -var-file=schematics.tfvars
ls -la

ls -la ../
# hack to show the VPC resource on the schematics UI, but destroy will not work
#cp -f terraform.tfstate ../
#cp -f terraform.tfstate.backup ../
