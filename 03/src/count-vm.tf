data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "web" {
  count = 2
  
  depends_on = [
    yandex_compute_instance.database
  ]
  
  name        = "${var.vm_web_name}-${count.index + 1}"
  platform_id = var.vm_web_platform_id
  
   resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true

    #Назначение группы безопасности
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.metadata

}




# Переменные
variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for VM"
}


variable "vm_web_name" {
  type        = string
  default     = "web"
  description = "VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for VM"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Whether VM is preemptible"
}

variable "vm_web_serial_port_enable" {
  type        = number
  default     = 1
  description = "Enable serial port"
}



# Map переменная для ресурсов ВМ
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
  }
  description = "Resources configuration for VMs"
}
