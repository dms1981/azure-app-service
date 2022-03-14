terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~> 2.0"
    }
    time = {}
  }
  required_version = "~> 1.0"
}
provider "azurerm" {
  features {}
  client_id       = local.az-service-principal.appId
  client_secret   = var.client_secret
  subscription_id = local.az-service-principal.subscription
  tenant_id       = local.az-service-principal.tenant
}