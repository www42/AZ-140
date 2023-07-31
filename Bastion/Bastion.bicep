param name string = 'az140-11-bastion'
param location string = 'westeurope'
param subnetId string
param pipName string = 'az140-adds-vnet11-ip'

resource bastion 'Microsoft.Network/bastionHosts@2022-07-01' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: pip.id
          }
          subnet: {
            id: subnetId
          }
        }
      }
    ]
    scaleUnits: 2
  }
}

resource pip 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: pipName
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

output bastionIp string = pip.properties.ipAddress
