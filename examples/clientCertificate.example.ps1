$count = 0

while($count -le $numberOfClientCerts)
{
    $clientCertName = 'azureVPNClient.' + $count

    $rootCert | New-AzureVPNClientCertificate -thumbPrint 'sddddffddffd' -subject $clientCertName | Export-AzureVPNCertificate -path $exportPath -pfx -password $pfxpassword -removeAfterExport

    $count++
}