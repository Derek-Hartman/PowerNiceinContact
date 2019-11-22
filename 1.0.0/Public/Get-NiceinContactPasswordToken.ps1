<#
.Synopsis
    Generates Token for inContact API.

.EXAMPLE
    Get-NiceinContactPasswordToken -Key "key" -Username "username" -Password "password" -Scope "scope"

.NOTES
    Modified by: Derek Hartman
    Date: 11/14/2019

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-NiceinContactPasswordToken {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Basic Auth Key.")]
        [string[]]$Key,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your inContact Username.")]
        [string[]]$Username,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your inContact Password.")]
        [string[]]$Password,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Scope.")]
        [string[]]$Scope

    )

    $Uri = @{
        "Token" = "https://api.incontact.com/InContactAuthorizationServer/Token"
    }

    $Body = @{'grant_type' = "password";} 
    $Body += @{'username'   = "$Username";}
    $Body += @{'password'   = "$Password";}
    $Body += @{'scope'      = "$Scope"}

    $JsonBody = ConvertTo-Json $Body

    $Header = @{
        'Authorization' = "basic $Key";
        'Content-Type'  = 'application/json';
    }

    $Token = Invoke-RestMethod -Method POST -Uri $Uri.Token -Body $JsonBody -Headers $Header

    Write-Output $Token.access_token
}