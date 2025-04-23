# Login to Azure
Connect-AzAccount

# Variables
$resourceGroupName = "ExampleResourceGroup"
$location = "EastUS"
$vmName = "ExampleVM"
$adminUsername = "azureuser"
$adminPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
$size = "Standard_B1s"

# Create a Resource Group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a Virtual Network
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location `
    -Name "ExampleVNet" -AddressPrefix "10.0.0.0/16"

# Create a Subnet
$subnet = Add-AzVirtualNetworkSubnetConfig -Name "ExampleSubnet" -AddressPrefix "10.0.0.0/24" `
    -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# Create a Public IP Address
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location `
    -Name "ExamplePublicIP" -AllocationMethod Static

# Create a Network Security Group
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $location `
    -Name "ExampleNSG"

# Create a Network Interface
$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroupName -Location $location `
    -Name "ExampleNIC" -SubnetId $subnet.Id -PublicIpAddressId $publicIp.Id -NetworkSecurityGroupId $nsg.Id

# Create a Virtual Machine Configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $size |
    Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential (New-Object PSCredential ($adminUsername, $adminPassword)) |
    Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest" |
    Add-AzVMNetworkInterface -Id $nic.Id

# Create the Virtual Machine
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig