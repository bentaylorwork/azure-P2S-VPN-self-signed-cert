Login-AzureAccount

$vNetGatewayName      = 'VNet1GW'
$resourceGroupName    = 'TestRG'
$exportPath           = 'c:\a'

$rootCert = New-AzureVPNRootCertificate -subject 'azureVPNRootCertTest'
$rootCert | Export-AzureVPNCertificate -cer -path $exportPath

$uploadRootCert = @{
                        VirtualNetworkGatewayname    = $vNetGatewayName
                        ResourceGroupName            = $resourceGroupName
                        VpnClientRootCertificateName = $rootCert.thumbPrint
                        PublicCertData               = Get-Content -Path $rootCert.Path
                   }

Add-AzureVpnClientRootCertificate @uploadRootCert