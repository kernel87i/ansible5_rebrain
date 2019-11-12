variable "do_token" {
  description = "access to API Vscale"
}

variable "access_key" {
  description = "This is the AWS access key"
}

variable "secret_key" {
  description = "This is the AWS secret key"
}

variable "region" {
  description = "This is the AWS region"
}

variable "vscale_msk" {
  description = "vscale MSK data"
  default     = "msk0"
}


variable "vscale_centos_7" {
  description = "centos"
  default     = "centos_7_64_001_master"
}

variable "ansible_user" {
  description = "This connections user ansible-playbook"
  default     = "root"
}

variable "private_key" {
  description = "This private key to acceess Vcale"
}

variable "vscale_rplan" {
  type = "map"
  default = {
    "s"   = "small"
    "m"   = "medium"
    "l"   = "large"
    "xl"  = "huge"
    "xxl" = "monster"
  }
}


variable "devs" {
  default = ["dev1.Sergey_Babanin1"]
}
