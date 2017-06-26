if(-not (Get-Module azureVpnP2SSelfSignedCertificate)) {
  $here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace('tests', '')
  Import-Module (Join-Path $here 'azureVpnP2SSelfSignedCertificate.psd1') 
}

function New-SelfSignedCertificate() {
    $null
}

InModuleScope -moduleName azureVpnP2SSelfSignedCertificate {
    Describe 'New-AzureVPNClientCertificate' {
        BeforeAll {
            Mock New-SelfSignedCertificate {}
        }

        Context 'Logic' {
            it 'Parameters' {
                Mock Test-Path { $true }

                {New-AzureVPNClientCertificate -sub 'test' -thumbPrint '3223223' -ErrorAction Stop} | Should Throw
            }

            it 'Root Certificate Does Not Exist' {
                Mock Test-Path { $null }

                New-AzureVPNClientCertificate -subject 'azureSubject' -thumbPrint '3223223' -ErrorAction SilentlyContinue | Out-Null

                Assert-MockCalled New-SelfSignedCertificate -Exactly 0 -Scope It
            }

            it 'Root Certificate Does Exist' {
                Mock Test-Path { $true }

                New-AzureVPNClientCertificate -subject 'azureSubject' -thumbPrint '3223223' -ErrorAction SilentlyContinue | Out-Null

                Assert-MockCalled New-SelfSignedCertificate -Exactly 1 -Scope It
            }
        }
    }
}