output "storage_vm_info" {
  value = {
    name        = yandex_compute_instance.storage.name
    id          = yandex_compute_instance.storage.id
    private_ip  = yandex_compute_instance.storage.network_interface.0.ip_address
    public_ip   = yandex_compute_instance.storage.network_interface.0.nat_ip_address
    attached_disks = length(yandex_compute_instance.storage.secondary_disk)
  }
  description = "Информация о ВМ storage"
}

# Вывод информации о созданных дисках и ВМ
output "disk_ids" {
  value = [
    for disk in yandex_compute_disk.additional_disk : {
      name = disk.name
      id   = disk.id
    }
  ]
  description = "Информация о созданных дополнительных дисках"
}