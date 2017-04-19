function New-AzureVPNRootCertificate
{
    <#
    .Synopsis
        Generates a root cert for use with an Azure point-to-site VPN.
    .EXAMPLE
        New-AzureVPNRootCert -subject 'supportAccess.remote'
    .NOTES
        Written by Ben Taylor
	    Version 1.0, 01.04.2017

        Requires Windows 10.
    #>
    [CmdletBinding(SupportsShouldProcess=$true)]
    [OutputType()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $subject
    )

    Write-Verbose "Creating root certificate - $subject"

    $rootCert = @{
        Type              = 'Custom'
        KeySpec           = 'Signature'
        Subject           = $subject
        KeyExportPolicy   = 'Exportable'
        HashAlgorithm     = 'sha256'
        KeyLength         = '2048'
        CertStoreLocation = 'Cert:\CurrentUser\My'
        KeyUsageProperty  = 'Sign'
        KeyUsage          = 'CertSign'
        ErrorAction       = 'Stop'
    }

    try
    {
        If ($Pscmdlet.ShouldProcess($subject, 'New-AzureVPNRootCertificate')) {
            New-SelfSignedCertificate @rootCert
        }
    }
    catch
    {
        Write-Error $_
    }
}

function New-AzureVPNClientCertificate
{
    <#
    .Synopsis
        Creates a client cert from the root cert in a local Cert Store to be used with an Azure point-to-site VPN.
    .EXAMPLE
        New-AzureVPNClientCert -subject 'supportAccess.remote' -path 'c:\export\'
    .NOTES
        Written by Ben Taylor
	    Version 1.0, 01.04.2017

        Requires Windows 10.
    #>
    [CmdletBinding(DefaultParameterSetName='certificatethumbPrint', SupportsShouldProcess=$true)]
    [OutputType()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $subject,
        [Parameter(Mandatory=$true, ParameterSetName='certificateSubject')]
        [ValidateNotNullOrEmpty()]
        [String]
        $rootSubject,
        [Parameter(Mandatory=$true, ParameterSetName='certificatethumbPrint', ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $thumbPrint
    )

    try
    {
        if($psBoundParameters['rootSubject'])
        {
            $thumbPrint = (Get-ChildItem cert:\currentuser\my\ | Where-Object { $_.Subject -eq $subject }).Thumbprint
        }

        if(Test-Path cert:\currentuser\my\$thumbPrint)
        {
            $rootCertificate = Get-ChildItem -Path "Cert:\CurrentUser\My\$thumbPrint"

            Write-Verbose "Creating client certificate - $subject"

            $clientCert = @{
                    Type              = 'Custom'
                    KeySpec           = 'Signature'
                    Subject           =  $subject
                    KeyExportPolicy   = 'Exportable'
                    HashAlgorithm     = 'sha256'
                    KeyLength         = '2048'
                    CertStoreLocation = 'Cert:\CurrentUser\My'
                    Signer            = $rootCertificate
                    TextExtension     = @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
                    ErrorAction       = 'Stop'
            }

            If ($Pscmdlet.ShouldProcess($subject, 'New-AzureVPNClientCertificate')) {
                New-SelfSignedCertificate @clientcert
            }
        }
        else
        {
            Write-Error 'No root certificate found. Please check the subject or the thumbprint'    
        }
    }
    catch
    {
        Write-Error $_
    }
}

function Export-AzureVPNCertificate
{
    <#
    .Synopsis
        Allow you to export the required certs for an Azure point-to-site VPN.

        Filename of certificate is always the Thumb Print
    .EXAMPLE
        Export-AzureVPNCertificate -subject 'supportAccess.remote'
    .NOTES
        Written by Ben Taylor
        Version 1.0, 01.04.2017
    #>
    [CmdletBinding(DefaultParameterSetName='certificatethumbPrintPfx', SupportsShouldProcess=$true)]
    [OutputType()]
    Param(

        [Parameter(Mandatory=$true, ParameterSetName='certificatethumbPrintPfx', ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Parameter(Mandatory=$true, ParameterSetName='certificatethumbPrintCer', ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $thumbPrint,
        [Parameter(Mandatory=$true, ParameterSetName='certificateSubjectPfx')]
        [Parameter(Mandatory=$true, ParameterSetName='certificateSubjectCer')]
        [ValidateNotNullOrEmpty()]
        [String]
        $subject,
        [Parameter(Mandatory=$false, ParameterSetName='certificateSubjectPfx')]
        [Parameter(Mandatory=$false, ParameterSetName='certificateSubjectCer')]
        [Parameter(Mandatory=$false, ParameterSetName='certificatethumbPrintPfx')]
        [Parameter(Mandatory=$false, ParameterSetName='certificatethumbPrintCer')]
        [ValidateScript({ Test-Path $_ })]
        [String]
        $path = $env:TMP,
        [Parameter(Mandatory=$true, ParameterSetName='certificateSubjectPfx')]
        [Parameter(Mandatory=$true, ParameterSetName='certificatethumbPrintPfx')]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $password,
        [Parameter(Mandatory=$false, ParameterSetName='certificateSubjectPfx')]
        [Parameter(Mandatory=$false, ParameterSetName='certificateSubjectCer')]
        [Parameter(Mandatory=$false, ParameterSetName='certificatethumbPrintPfx')]
        [Parameter(Mandatory=$false, ParameterSetName='certificatethumbPrintCer')]
        [switch]
        $removeAfterExport,
        [Parameter(Mandatory=$true, ParameterSetName='certificatethumbPrintPfx')]
        [Parameter(Mandatory=$true, ParameterSetName='certificateSubjectPfx')]
        [switch]
        $pfx,
        [Parameter(Mandatory=$true, ParameterSetName='certificatethumbPrintCer')]
        [Parameter(Mandatory=$true, ParameterSetName='certificateSubjectCer')]
        [switch]
        $cer
    )

    try
    {
        if($psBoundParameters['subject'])
        {
            $thumbPrint = (Get-ChildItem cert:\currentuser\my\ | Where-Object { $_.Subject -eq $subject }).Thumbprint
        }

        if(Test-Path cert:\currentuser\my\$thumbPrint)
        {
            Write-Verbose 'Exporting certificate'

            $clientCert = Get-Item cert:\currentuser\my\$thumbPrint

            if($pfx)
            {
                $fileType = 'pfx'
            }
            else
            {
                $fileType = 'cer'
            }

            $fullPath = Join-Path $path ($thumbPrint + '.' + $fileType)

            if(-not (Test-Path $fullPath))
            {
                if($psBoundParameters['pfx'])
                {
                    $clientCert | Export-PfxCertificate -FilePath $fullPath -Password $password | Out-Null
                }
                elseif($psBoundParameters['cer'])
                {
                    Set-Content -Path $fullPath -Value ([convert]::tobase64string((Get-Item cert:\currentuser\my\$thumbPrint).RawData)) -Encoding Ascii | Out-Null
                }

                [pscustomobject]@{
                    ThumbPrint = $thumbPrint
                    Path       = $fullPath
                    Subject    = $clientCert.subject
                }

                if($psBoundParameters['removeAfterExport'] -eq $true)
                {
                    Write-Verbose 'Removing Client Certificate after export'
                    $clientCert | Remove-Item
                }
            }
            else
            {
                Write-Error 'There is a cert with that name in the current path.'
            }
        }
        else
        {
            Write-Error 'Could not find cert in store.'
        }
    }
    catch
    {
        Write-Error $_
    }
}