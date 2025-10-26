terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}


provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-azure-basics-react"
  location = "West Europe"
}


resource "azurerm_static_web_app" "react_app" {
  name                = "terraform-azure-basics-react-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Free"
  sku_size            = "Free"
  tags = {
    Environment = "Development"
    Project     = "Terraform React App"
  }
}


output "static_web_app_url" {
  description = "The default hostname of the static web app"
  value       = azurerm_static_web_app.react_app.default_host_name
}


output "deployment_token" {
  description = "The deployment token for GitHub Actions"
  value       = azurerm_static_web_app.react_app.api_key
  sensitive   = true
}
