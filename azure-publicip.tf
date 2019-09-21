variable "sid" {
  default = "groupc"
}

variable "cid" {
  default = "groupc"
}

variable "cs" {
  default = "groupc"
}


variable "tid" {
  default = "groupc"
}

provider "azurerm" {
    subscription_id = "${var.sid}"
    client_id       = "${var.cid}"
    client_secret   = "${var.cs}"
    tenant_id       = "${var.tid}"
}

variable "prefix" {
  default = "groupcc"
}

resource "azurerm_resource_group" "test" {
  name     = "${var.prefix}-resources"
  location = "Central US"
}

resource "azurerm_public_ip" "test" {
  name                = "${var.prefix}-publicip"
  location            = "Central US"
  resource_group_name = "${azurerm_resource_group.test.name}"
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}
output "public_ip_address" {
  description = "The actual ip address allocated for the resource."
  value       = "${azurerm_public_ip.test.ip_address} > /var/lib/jenkins/workspace/Azure-InfraAutomation/azurevm/hosts"
}
