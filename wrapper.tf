resource "null_resource" "wrapper" {
  provisioner "local-exec" {
    command = "chmod +x ./wrapper_script.sh && ./wrapper_script.sh"
  }
}
