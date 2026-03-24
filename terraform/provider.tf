terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Uncomment to use remote state in Azure Storage
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "tfstate"
  #   container_name       = "tfstate"
  #   key                  = "aks.tfstate"
  # }
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_delete            = true
      graceful_shutdown                   = false
      skip_shutdown_and_force_delete       = false
    }
  }
  
  skip_provider_registration = false
}
