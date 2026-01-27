
# Создание ВМ для баз данных с помощью for_each
resource "yandex_compute_instance" "database" {
  for_each = var.each_vm

  name        = each.key
  platform_id = var.vm_db_platform_id
  
  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk_volume
    }
  }
  
  
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false

    # Назначение группы безопасности
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.metadata
}

variable "each_vm" {
  type = map(object({
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = {
    "main" = {
      cpu         = 2
      ram         = 4
      disk_volume = 10
    }
    "replica" = {
      cpu         = 2
      ram         = 2
      disk_volume = 5
    }
  }

  description = "Configuration for db_vms"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform for db"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Using preemptible in study purpose."
}



