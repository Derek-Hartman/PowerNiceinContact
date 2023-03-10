<#
.Synopsis
    Get all Active users from the UserHub

.EXAMPLE
    Get-NiceinContactUserHubActiveUsers -AToken "Access Token"

.NOTES
    Modified by: Derek Hartman
    Date: 3/10/2023

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-NiceinContactUserHubActiveUsers {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Access Token.")]
        [string[]]$AToken
    )
    $Uri = @{
        "Users" = "https://na1.nice-incontact.com/user-management/v1/users?includeDeleted=false"
    }
    $Header = @{
        'Authorization'   = "Bearer $AToken"
        'Accept'          = "*/*"
    }

    $ActiveUsers = Invoke-RestMethod -Method GET -Uri $Uri.Users -Headers $Header
    Write-Output $ActiveUsers.Users
}