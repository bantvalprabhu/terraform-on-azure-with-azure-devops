resource "azurerm_public_ip" "web_linuxvm_publicip" {
  name                = "web-linuxvm-publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "vm-${random_string.myrandom.id}"
}