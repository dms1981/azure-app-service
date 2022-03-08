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

resource "azurerm_container_registry_task" "acr-build" {
  name                  = format("%s-%s", var.acr_task_name, azurerm_container_registry.acr-main.name)
  container_registry_id = azurerm_container_registry.acr-main.id
  platform {
    os = "Windows"
  }
  docker_step {
    context_access_token = local.github-personal-access-token.token
    context_path         = "https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service#master"
    dockerfile_path      = "./dotnet/Dockerfile"
    image_names          = ["helloworld:{{.Run.ID}}"]
  }
}