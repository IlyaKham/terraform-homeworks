resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  
  content = templatefile("${path.module}/inventory.tftpl", {
    webservers = [
      for vm in yandex_compute_instance.web : {
        name   = vm.name
        ip     = vm.network_interface[0].nat_ip_address
        fqdn   = coalesce(vm.fqdn, "${vm.name}.auto.internal")
      }
    ]
    
    databases = [
      for name, vm in yandex_compute_instance.database : {
        name   = name
        ip     = vm.network_interface[0].ip_address
        fqdn   = coalesce(vm.fqdn, "${name}.auto.internal")
      }
    ]
    
    storage = [{
      name   = yandex_compute_instance.storage.name
      ip     = yandex_compute_instance.storage.network_interface[0].ip_address
      fqdn   = coalesce(yandex_compute_instance.storage.fqdn, "storage.auto.internal")
    }]
  })
  
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.database,
    yandex_compute_instance.storage
  ]
}

output "inventory_path" {
  value = local_file.ansible_inventory.filename
}