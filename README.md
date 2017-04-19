# Microsoft Azure - Point-To-Site VPN self-signed certificate helper

## Overview
A PowerShell module to help generate the required self-signed certificates to set up a Point-To-Site VPN on Microsoft Azure.

[Azure Point-To-Site Certificate Documentation](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-certificates-point-to-site)

## Commands
* New-AzureVPNRootCertificate
* New-AzureVPNClientCertificate
* Export-AzureVPNCertificate

## Examples
* New-AzureVPNRootCertificate
```PowerShell
New-AzureVPNRootCertificate -subject 'azureVPN'
```

* New-AzureVPNClientCertificate
```PowerShell
New-AzureVPNClientCertificate -thumbprint 'sdfsd8udf' -subject 'azureVpnClient'

New-AzureVPNRootCertificate -subject 'azureVPN' | New-AzureVPNClientCertificate -subject 'azureVPNClient'

New-AzureVPNClientCertificate -thumbprint 'sdfsd8udf' -subject 'azureVpnClient' | Export-AzureVPNCertificate -path 'c:\exportPath' -pfx -password (ConvertTo-SecureString -String '1234' -Force -AsPlainText)
```
* Export-AzureVPNCertificate
```PowerShell
$password = ConvertTo-SecureString -String '1234' -Force -AsPlainText)
Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -pfx -password $password -removeAfterExport

Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -cer
```

## Installation
The module is published to the PowerShell Gallery (<https://www.powershellgallery.com/packages/azureVpnP2SSelfSignedCertificate>).

```PowerShell
Install-Module -Name azureVpnP2SSelfSignedCertificate
```

## Versions
### 1.0.0.0
* Initial release

## Contributors
- Ben Taylor - ben@bentaylor.work