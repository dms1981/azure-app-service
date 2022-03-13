resource "azurerm_resource_group" "rg-acr" {
  location = var.acr_rg_location
  name     = var.acr_rg_name
}

resource "azurerm_container_registry" "acr-main" {
  admin_enabled       = true
  location            = azurerm_resource_group.rg-acr.location
  name                = format("acr%s%s", var.acr_name, azurerm_resource_group.rg-acr.location)
  resource_group_name = azurerm_resource_group.rg-acr.name
  sku                 = var.acr_sku
}

resource "azuread_application" "acr-app" {
  display_name = "acr-app"
}

resource "azuread_service_principal" "acr-sp" {
  application_id = azuread_application.acr-app.application_id
}

resource "time_rotating" "acr-sp-rotation" {
  rotation_days = 7
}

resource "azuread_service_principal_password" "acr-sp-pass" {
  service_principal_id = azuread_service_principal.acr-sp.id
  rotate_when_changed = {
    rotation = time_rotating.acr-sp-rotation.id
  }
}

resource "azurerm_role_assignment" "acr-assignment" {
  scope                = azurerm_container_registry.acr-main.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal_password.acr-sp-pass.service_principal_id
}