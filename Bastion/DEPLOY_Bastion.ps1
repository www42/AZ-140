$rgName = 'az140-11-RG'
$location = (Get-AzResourceGroup -Name $rgName).Location
$vnetName  = 'az140-adds-vnet11'
$templateFile = 'Bastion.bicep'

$subnetId = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rgName | % Subnets | ? Name -eq 'AzureBastionSubnet' | % Id

New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile $templateFile -TemplateParameterObject @{subnetId = $subnetId; location = $location}
