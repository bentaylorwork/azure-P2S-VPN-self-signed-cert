if(-not (Get-Module azureVpnP2SSelfSignedCertificate)) {
  $here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace('tests', '')
  Import-Module (Join-Path $here 'azureVpnP2SSelfSignedCertificate.psd1') 
}

InModuleScope -moduleName azureVpnP2SSelfSignedCertificate {

$certInfo = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>System.Security.Cryptography.X509Certificates.X509Certificate2</T>
      <T>System.Security.Cryptography.X509Certificates.X509Certificate</T>
      <T>System.Object</T>
    </TN>
    <ToString>[Subject]_x000D__x000A_  CN=azureVPNRootCert_x000D__x000A__x000D__x000A_[Issuer]_x000D__x000A_  CN=azureVPNRootCert_x000D__x000A__x000D__x000A_[Serial Number]_x000D__x000A_  179D404CA0B6B0A345B6919DAE30A989_x000D__x000A__x000D__x000A_[Not Before]_x000D__x000A_  04/04/2017 00:11:29_x000D__x000A__x000D__x000A_[Not After]_x000D__x000A_  04/04/2018 00:31:29_x000D__x000A__x000D__x000A_[Thumbprint]_x000D__x000A_  C8A900563F172F6BD10109D9AA8B12EE1037C2A4_x000D__x000A_</ToString>
    <Props>
      <BA N="RawData">MIIC8TCCAdmgAwIBAgIQF51ATKC2sKNFtpGdrjCpiTANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBhenVyZVZQTlJvb3RDZXJ0MB4XDTE3MDQwMzIyMTEyOVoXDTE4MDQwMzIyMzEyOVowGzEZMBcGA1UEAwwQYXp1cmVWUE5Sb290Q2VydDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANfNQtqPrYvhlpQuKMjFtX7EQM4WbhXKMFUfs4MnOgE3Z3RW6C5AeWrARwonW52MlfMcJbvLEGIxyTRW+FrWIO0y2vsdlz11OpuH31lA9aSFATSi6+eBV5j7th+3dtWW7GbHof758smfQ5OXTzHdV/SR5t6wNxXXuhDvL4jGWNYGwCVtL3rW2zntTGRQ85uX0AYQAHr6Yy9HF+Guqpzt5VoVdZroeVO/LccNuYYObifiEG8BSDLzBmgoDg0ejsSPdpalGw4OWyNKsvKw6a6DBjTtlCwgsoKOnhaSQfA/v+oDmyYLFRWLEmfLoJw+kkPY7lbLbYnaavuW58d9x+6H+yMCAwEAAaMxMC8wDgYDVR0PAQH/BAQDAgIEMB0GA1UdDgQWBBT+IawzYxq9qiQBmJuGHqmyzGfdjjANBgkqhkiG9w0BAQsFAAOCAQEANHFhKveGtFxSSY4IahZlKcoeL/HvG7xyJ9+t1pV0Dd2KYqP80/mt2Wyhahe895ZQHIBvuSEE2b/mGrWEmWE4QDBBkvNnljjX9RtSkZTurTv2fotfDhB/qqHIj+uPQMEiBgcmxkkXxsTYJYKnwkT8IHf/jkxX6vVQqxxsIe1DHY5lVp1tsWnZpWFVC59LGynTZzdgtfuy9YlwuqnKQlss5APWLR8E/06eHGMeJeDZbJ8YfK3deEuU8uRPzlvawel1flCejIy80ewpU6FyXn9Muki5nP2fCeFkwTPYYk2JYB8BeCEU10brnSnjYAN0tOcmm3trkNWaGwXHg2bv5LDeLQ==</BA>
    </Props>
    <MS>
      <S N="PSPath">Microsoft.PowerShell.Security\Certificate::currentuser\my\C8A900563F172F6BD10109D9AA8B12EE1037C2A4</S>
      <S N="PSParentPath">Microsoft.PowerShell.Security\Certificate::currentuser\my</S>
      <S N="PSChildName">C8A900563F172F6BD10109D9AA8B12EE1037C2A4</S>
      <Obj N="PSDrive" RefId="1">
        <TN RefId="1">
          <T>System.Management.Automation.PSDriveInfo</T>
          <T>System.Object</T>
        </TN>
        <ToString>Cert</ToString>
        <Props>
          <S N="CurrentLocation"></S>
          <S N="Name">Cert</S>
          <S N="Provider">Microsoft.PowerShell.Security\Certificate</S>
          <S N="Root">\</S>
          <S N="Description">X509 Certificate Provider</S>
          <Nil N="MaximumSize" />
          <Obj N="Credential" RefId="2">
            <TN RefId="2">
              <T>System.Management.Automation.PSCredential</T>
              <T>System.Object</T>
            </TN>
            <ToString>System.Management.Automation.PSCredential</ToString>
            <Props>
              <Nil N="UserName" />
              <Nil N="Password" />
            </Props>
          </Obj>
          <Nil N="DisplayRoot" />
        </Props>
        <MS>
          <Obj N="Used" RefId="3">
            <S></S>
          </Obj>
          <Ref N="Free" RefId="3" />
        </MS>
      </Obj>
      <Obj N="PSProvider" RefId="4">
        <TN RefId="3">
          <T>System.Management.Automation.ProviderInfo</T>
          <T>System.Object</T>
        </TN>
        <ToString>Microsoft.PowerShell.Security\Certificate</ToString>
        <Props>
          <S N="ImplementingType">Microsoft.PowerShell.Commands.CertificateProvider</S>
          <S N="HelpFile">Microsoft.PowerShell.Security.dll-Help.xml</S>
          <S N="Name">Certificate</S>
          <Nil N="PSSnapIn" />
          <S N="ModuleName">Microsoft.PowerShell.Security</S>
          <S N="Module">Microsoft.PowerShell.Security</S>
          <S N="Description"></S>
          <S N="Capabilities">ShouldProcess</S>
          <S N="Home"></S>
          <Obj N="Drives" RefId="5">
            <TN RefId="4">
              <T>System.Collections.ObjectModel.Collection`1[[System.Management.Automation.PSDriveInfo, System.Management.Automation, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
              <T>System.Object</T>
            </TN>
            <LST>
              <Ref RefId="1" />
            </LST>
          </Obj>
        </Props>
      </Obj>
      <B N="PSIsContainer">false</B>
    </MS>
  </Obj>
</Objs>
"@
    Describe 'Export-AzureVPNCertificate' {
        BeforeEach {
            Mock Get-Item {
                [System.Management.Automation.PSSerializer]::Deserialize($certInfo)
            }

            $SecureString =  'password123' | ConvertTo-SecureString -AsPlainText -Force
        }

        Context 'General' {
            it 'Parameters' {
                {Export-AzureVPNCertificate -thumbdrint 'dsfdssds435353' -path 'c:\exportPath' -cer -ErrorAction Stop} | Should Throw
            }
        }

        Context 'Root Certificate Does Not Exist' {
            BeforeEach {
                Mock Test-Path { $true }
            }
            it 'CER' {
                { Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -cer -ErrorAction Stop } | Should throw
            }
            it 'PFX' {
                { Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -pfx -password $SecureString -ErrorAction Stop } | Should throw
            }
            it 'removeAfterExport' {
                Mock Set-Content { $null }
                Mock Remove-Item { $null }

                Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -cer -removeAfterExport -ErrorAction SilentlyContinue | Out-Null

                Assert-MockCalled Remove-Item -Exactly 0 -Scope It
            }
        }
        Context 'Root Certificate Does Exist' {
            BeforeEach {
                $script:i = 1

                Mock Test-Path {
                    if ($script:i -ge 3)
                    {
                        $false
                    }
                    else
                    {
                        $true
                    }

                    $script:i++
                }
            }
            it 'PFX' {
                Mock Export-PfxCertificate { $null }

                Export-AzureVPNCertificate -pfx -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -password $SecureString | Out-Null

                Assert-MockCalled Export-PfxCertificate -Exactly 1 -Scope it
            }
            it 'CER' {
                Mock Set-Content { $null }

                Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -cer -ErrorAction SilentlyContinue | Out-Null

                Assert-MockCalled Set-Content -Exactly 1 -Scope It
            }

            it 'removeAfterExport' {
                Mock Set-Content { $null }
                Mock Remove-Item { $null }

                Export-AzureVPNCertificate -thumbPrint 'dsfdssds435353' -path 'c:\exportPath' -cer -removeAfterExport -ErrorAction SilentlyContinue | Out-Null

                Assert-MockCalled Remove-Item -Exactly 1 -Scope It
            }
        }
    }
}