# Создание 3 одинаковых виртуальных дисков с помощью count
resource "yandex_compute_disk" "additional_disk" {
  count = 3

  name     = "additional-disk-${count.index + 1}"
  type     = "network-hdd"  
  zone     = "ru-central1-a"
  size     = 1
}

# Создание одиночной ВМ "storage" с динамическим подключением дисков
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 5
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
  }

  # Динамическое подключение дополнительных дисков
  dynamic "secondary_disk" {
    for_each = {
      for idx, disk in yandex_compute_disk.additional_disk : 
      disk.name => disk.id
    }
    
    content {
      disk_id = secondary_disk.value
    }
  }

  metadata = local.metadata
}



