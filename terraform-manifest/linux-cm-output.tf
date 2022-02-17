output "web_linuxvm_public_ip_address" {
  value = azurerm_linux_virtual_machine.linux_vm.public_ip_address
}

output "web_linuxvm_private_ip_address" {
  value = azurerm_linux_virtual_machine.linux_vm.private_ip_address
}