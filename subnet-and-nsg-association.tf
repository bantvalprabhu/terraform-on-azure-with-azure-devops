resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.subnet_address
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "subnet_nsg" {
  name                = "${var.subnet_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

locals {
  inboud_ports = {
    "100" : "80",
    "101" : "443",
    "102" : "22"
  }
}
resource "azurerm_network_security_rule" "subnet_nsg_rules" {
  for_each                    = local.inboud_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.subnet_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_associate" {
  depends_on = [
    azurerm_network_security_rule.subnet_nsg_rules
  ]
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_rule.subnet_nsg_rules.id
}