output "f5_admin_portal" {
    value = "https://${ibm_is_floating_ip.f5_fip01.address}:8443"
    description = "Web url to interact with F5-BIGIP admin portal."
}
