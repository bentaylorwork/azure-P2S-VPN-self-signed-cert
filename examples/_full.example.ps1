Login-AzureAccount

$vNetGatewayName      = 'VNet1GW'
$resourceGroupName    = 'TestRG'
$pfxpassword          = Read-Host -AsSecureString
$exportPath           = 'c:\a'
$numberOfClientCerts = 20

$rootCert = New-AzureVPNRootCertificate -subject 'azureVPNRootCertTest'
$rootCert | Export-AzureVPNCertificate -cer -path $exportPath

$uploadRootCert = @{
                        VirtualNetworkGatewayname    = $vNetGatewayName
                        ResourceGroupName            = $resourceGroupName
                        VpnClientRootCertificateName = $rootCert.thumbPrint
                        PublicCertData               = Get-Content -Path $rootCert.Path
                   }

Add-AzureVpnClientRootCertificate @uploadRootCert

$count = 0

while($count -le $numberOfClientCerts)
{
    $clientCertName = 'azureVPNClient.' + $count

    $rootCert | New-AzureVPNClientCertificate -subject $clientCertName | Export-AzureVPNCertificate -path $exportPath -pfx -password $pfxpassword -removeAfterExport

    $count++
}

$vpnPackage = @{
                    ResourceGroupName = $rgname
                    VirtualNetworkGatewayName = $gw.Name
                    ProcessorArchitecture = Amd64
}

Get-AzureVpnClientPackage @vpnPackage