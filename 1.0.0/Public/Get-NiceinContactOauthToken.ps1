<#
.Synopsis
    Generates Oauth Access Token for inContact API.

.EXAMPLE
    Get-NiceinContactOauthToken -APPID "Application ID" -APPSEC "Application Secret" -AKID "Access Key ID" -AKSEC "Access Key Secret"

.NOTES
    Modified by: Derek Hartman
    Date: 3/8/2023

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-NiceinContactOauthToken {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Application ID.")]
        [string[]]$APPID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Application Secret.")]
        [string[]]$APPSEC,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Access Key ID.")]
        [string[]]$AKID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Access Key Secret.")]
        [string[]]$AKSEC

    ) 
	
    $keybase64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $($APPID), $($APPSEC))))

    $Uri = @{
        "AToken" = "https://cxone.niceincontact.com/auth/token"
    }

    $Body = "grant_type=password&username=$($AKID)&password=$($AKSEC)"

    $Header = @{
        'Authorization' = "Basic $keybase64AuthInfo";
		'Content-Type'  = 'application/x-www-form-urlencoded';
    }

    $Token = Invoke-RestMethod -Method POST -Uri $Uri.AToken -Body $Body -Headers $Header

    Write-Output $Token
}