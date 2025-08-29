param location string = resourceGroup().location
param vmName string = 'testServer1'

resource publicIP 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
	name: '${vmName}-pip'
	location: location
	sku: { name: 'Basic' }
	properties: {
		publicIPAllocationMethod: 'Dynamic'
	}
}

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
	name: '${vmName}-vnet'
	location: location
	properties: {
		addressSpace: { addressPrefixes: [ '10.0.0.0/16' ] }
		subnets: [
			{
				name: 'default'
				properties: { addressPrefix: '10.0.0.0/24' }
			}
		}
	}
}

resource nic 'Microsoft.Network/networkInterfaces@2022-01-01' = {
	name: '${vmName}-nic'
	location: location
	properties: {
		ipConfigurations: [
			{
				name: 'ipconfig1'
				properties: {
					subnet: {
						id: vnet.properties.subnets[0].id
					}
					privateIPAllocationMethod: 'Dynamic'
					publicIPAddress: {
						id: publicIP.id
					}
				}
			}
		}
	}


resource vm 'Microsoft.Compute/virtualMachines@2022-01-01' = {
	name: vmName
	location: location
	properties: {
		hardwareProfile: {
			vmSize: 'Standard_B1s'
		}
		osProfile: {
			computerName: vmName
			adminUsername: 'azureuser'
			adminPassword: 'P@ssword1234!'
		}
		storageProfile: {
			imageReference: {
				publisher: 'MicrosoftWindowsServer'
				offer: 'WindowsServer'
				sku: '2022-Datacenter'
				version: 'latest'
			}
			osDisk: {
				createOption: 'FromImage'
			}
		}
		networkProfile: {
			networkInterfaces: [
				{
					id: nic.id
				}
			]
		}
	}
}
