variable "acr_name" {}
variable "acr_rg_name" {}
variable "acr_rg_location" {}
variable "acr_sku" {}
variable "acr_task_name" {}
variable "client_secret" {
  sensitive = true
}