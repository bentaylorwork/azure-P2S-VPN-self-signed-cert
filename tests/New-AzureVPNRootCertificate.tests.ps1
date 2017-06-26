if(-not (Get-Module azureVpnP2SSelfSignedCertificate)) {
  $here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace('tests', '')
  Import-Module (Join-Path $here 'azureVpnP2SSelfSignedCertificate.psd1') 
}

InModuleScope -moduleName azureVpnP2SSelfSignedCertificate {
    function New-SelfSignedCertificate() {
        $null
    }
    Describe 'New-AzureVPNRootCertificate' {
        BeforeAll {
            Mock New-SelfSignedCertificate {}
        }

        Context 'Logic' {
            it 'Parameters' {
                {New-AzureVPNRootCertificate -subject 'azureSubject' -ErrorAction Stop} | Should Not Throw
            }

            it 'Create Self-Signed root certificate' {
                New-AzureVPNRootCertificate -subject 'azureSubject' -ErrorAction SilentlyContinue | Out-Null

                Assert-MockCalled New-SelfSignedCertificate -Exactly 1 -Scope It
            }
        }
    }
}