terraform {
  required_providers {
    dns = {
      source = "hashicorp/dns"
      version = "3.1.0"
    }    
  }
}

variable "tsig_key" {
  type = string
  sensitive = true
}

provider "dns" {
  update {
    server = ""
    key_name = ""
    key_algorithm = ""
    key_secret = var.tsig_key
  }
}
