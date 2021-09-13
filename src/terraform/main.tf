##################################################################################
# 1. Use Service Principal to log on
# Configure the Azure Provider
# Remarks: client_secret crash with the 1.38.0 version
# Could not regsiter an AAD App with SPN
##################################################################################
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.42.0"
  
  subscription_id = var.subscription_id
  # client_id = var.client_id
  # tenant_id = var.tenant_id
  # client_secret = var.client_secret
}