# Virtual Server for Virtual Private Cloud using Custom Image

With this template, you can use IBM Cloud Schematics to create F5-BIGIP virtual server using custom image from you IBM Cloud account. Schematics uses [Terraform](https://www.terraform.io/) as the infrastructure-as-code engine. With this template, you can create and manage infrastructure as a single unit as follows. For more information about how to use this template, see the [IBM Cloud Schematics documentation](https://cloud.ibm.com/docs/schematics).

**Included**:
* 1 [virtual private cloud](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-getting-started) instance, in specified zone.
* 1 [VPC virtual servers using bring your own custom F5-BigIP image](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-getting-started) instances per zone. 

**Not included**:
* This is a poc work.
* [Bring your F5 Custom Image](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-images#custom-images)

**Must have IBM IS Terraform Provider fixes**:
* Provide `data source for ibm_loogin_target` that would provide some key information from provider session (example: account-id)
* Provide `resource for ibm_is_image` - IS Image create, update, delete
* Catalog offering Deployment variable must provide way to mark some variable sensitive (example: vendor svc account apikey)

## Costs

When you apply template, the infrastructure resources that you create incur charges as follows. To clean up the resources, you can [delete your Schematics workspace or your instance](https://cloud.ibm.com/docs/schematics?topic=schematics-manage-lifecycle#destroy-resources). Removing the workspace or the instance cannot be undone. Make sure that you back up any data that you must keep before you start the deletion process.

* **VPC**: VPC charges are incurred for the infrastructure resources within the VPC, as well as network traffic for internet data transfer. For more information, see [Pricing for VPC](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc).
* **VPC virtual servers**: You specify how many virtual servers to provision in each VPC. The price for your virtual server instances depends on the flavor of the instances, how many you provision, and how long the instances are run. For more information, see [Pricing for Virtual Servers for VPC](https://cloud.ibm.com/docs/infrastructure/vpc-on-classic?topic=vpc-on-classic-pricing-for-vpc#pricing-for-virtual-servers-for-vpc).

## Dependencies

Before you can apply the template in IBM Cloud, complete the following steps.

1.  Make sure that you have the following permissions in IBM Cloud Identity and Access Management:
    * **Manager** service access role for IBM Cloud Schematics
    * **Operator** platform role for VPC Infrastructure
2.  Download the [`ibmcloud` command line interface (CLI) tool](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-install-ibmcloud-cli).
3.  Install the `ibmcloud terraform` and `ibmcloud is` CLI plug-ins for Schematics and VPC infrastructure. **Tip**: To update your current plug-ins, run `ibmcloud plugin update`.
    *  `ibmcloud plugin install schematics`
    *  `ibmcloud plugin install vpc-infrastructure`
4.  [Create or use an existing SSH key for VPC virtual servers](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-ssh-keys).
5. [Bring your F5 Custom Image](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-images#custom-images)

## Configuring your deployment values

When you select the [`vnf-f5-vpc`template](https://cloud.ibm.com/catalog/content/vnf-f5-vpc) from the IBM Cloud catalog, you set up your deployment variables from the **Create** page. When you apply the template, IBM Cloud Schematics provisions the resources according to the values that you specify for these variables.

### Required values
Fill in the following values, based on the steps that you completed before you began.

|Variable Name|Description|
|-------------|-----------|
|`ssh_public_key`|Enter the [public SSH key](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-ssh-keys) that you use to access your VPC virtual servers. Use the public key from the `~/.ssh/id_rsa.pub` file generated by the latest version of ssh-keygen tool, with the recommended key-size 2048.|
|`f5_image`|The ID of the F5 custom image provisioned in your IBM Cloud account. To list available images, run `ibmcloud is images`. The default image is for an `f5-bigip` image in a demo account.|

### Optional values
Before you apply your template, you can customize the following default variable values.

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|`ibmcloud_api_key`|Temp Hack to workaround IBM IS Provider gap. The APIKey of the IBM Cloud account where resources will be provisioned.|`None`|
|`ibmcloud_vnf_svc_api_key`|The APIKey of the IBM Cloud NFV service account that is hosting the F5-BIGIP qcow2 image file.|`None`|
|`generation`|The VPC Generation to target. Valid values are 2 or 1..|`2`|
|`region`|The VPC Region that you want your VPC to be provisioned. To list available zones, run `ibmcloud is regions`.|`us-south`|
|`zone`|The VPC Zone that you want your VPC virtual servers to be provisioned. To list available zones, run `ibmcloud is zones`.|`us-south-1`|
|`resource_group`|The resource group to use. If unspecified, the account's default resource group is used. To list available resource groups, run `ibmcloud resource groups`.|`Default`|
|`vpc_name`|The name of your VPC to be provisioned.|`f5-1arm-vpc`|
|`ssh_key_name`|The name of your public SSH key.|`f5-sshkey`|
|`f5_image_name`|The name of the F5 custom image to be provisioned in your IBM Cloud account.|`f5-bigip-15-0-1-0-0-11`|
|`f5_vsi_name`|The name of your F5 Virtual Server to be provisioned.|`f5-1arm-vsi`|
|`profile`|Enter the profile of compute CPU and memory resources that you want your VPC virtual servers to have. To list available profiles, run `ibmcloud is instance-profiles`.|`bx2-2x8`|
|`f5_license`|Optional: The BYOL license key that you want your F5 virtual server in a VPC to be used by registration flow during cloud-init.|`None`|
|`vnf_f5bigip_cos_instance_id`|Hidden: The COS instance-id hosting the F5-BIGIP qcow2 image.|`NA`|
|`vnf_f5bigip_cos_image_url`|The COS image object url for F5-BIGIP qcow2 image.|`NA`|

## Outputs
After you apply the template your VPC resources are successfully provisioned in IBM Cloud, you can review information such as the virtual server IP addresses and VPC identifiers in the Schematics log files, in the `Terraform SHOW` section.
