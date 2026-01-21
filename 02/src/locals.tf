locals {
  vm_web_name = "${var.vm_web_name}-${var.vm_web_zone}-${var.vm_web_platform_id}"
   
  vm_db_name = "${var.vm_db_name}-${var.vm_db_zone}-${var.vm_db_platform_id}"
}