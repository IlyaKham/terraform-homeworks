variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

# CIDR для подсети в зоне A
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR for subnet in zone A"
}

# CIDR для подсети в зоне B
variable "subnet_b_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "CIDR for subnet in zone B"
}

### SSH vars
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOFwtWJso59gpfc2qGD8KqzmRi/jgIk195I2jhXuJkJ khamuro@Khamuro"
  description = "ssh-keygen -t ed25519"
}

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for VM"
}



variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for VM"
}
/*
variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for VM"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Amount of RAM for VM (GB)"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "Core fraction for VM (%)"
}
*/
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

variable "vm_web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone for VM web"
}

###DB_VM
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM db name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for VM db"
}
/*
variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for VM db"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Amount of RAM for VM db (GB)"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "Core fraction for VM db (%)"
}
*/
variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Whether VM db is preemptible"
}

variable "vm_db_serial_port_enable" {
  type        = number
  default     = 1
  description = "Enable serial port for VM db"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for VM db"
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
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
  description = "Resources configuration for VMs"
}

# Map переменная для metadata (общая для всех ВМ)
variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOFwtWJso59gpfc2qGD8KqzmRi/jgIk195I2jhXuJkJ khamuro@Khamuro"
  }
  description = "metadata for all VMs"
}

