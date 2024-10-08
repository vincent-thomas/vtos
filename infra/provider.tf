terraform {
  required_providers {
    dns = {
      source = "hashicorp/dns"
      version = "3.1.0"
    }    
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
  sensitive = true
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure = true
}

# variable "tsig_key" {
#   type = string
#   sensitive = true
# }
#
# provider "dns" {
#   update {
#     server = ""
#     key_name = ""
#     key_algorithm = ""
#     key_secret = var.tsig_key
#   }
# }
