<#
.Synopsis
    Creates a new inContact UserHub User

.EXAMPLE
    New-NiceinContactUserHubUser -FirstName "Derek" -LastName "API Test" -TeamID "xxxxx" -EmailAddress "email@gmail.com" -TimeZone "America/New_York" -AssignedGroup "xxxx" -Role "xxxxx" -Username "xxxx@c14.com" -LoginAuthenticatorId "xxxx" -AToken "xxx"

.NOTES
    Modified by: Derek Hartman
    Date: 3/9/2023

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function New-NiceinContactUserHubUser {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter First Name")]
        [string[]]$FirstName,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Last Name")]
        [string[]]$LastName,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter TeamID")]
        [string[]]$TeamID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Email Address")]
        [string[]]$EmailAddress,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter TimeZone")]
        [string[]]$TimeZone,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Assigned Group")]
        [string[]]$AssignedGroup,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Role")]
        [string[]]$Role,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Username")]
        [string[]]$Username,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Login Authenticator ID")]
        [string[]]$LoginAuthenticatorId,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Access Token")]
        [string[]]$AToken

    )

    $Uri = @{
        "Users" = "https://na1.nice-incontact.com/user-management/v1/users"
    }

    $Header = @{
        'Authorization'   = "Bearer $Atoken"
        'Content-Type'    = "application/json"
        'Accept'          = "application/json"
    }

    $Body = @{"firstName" = "$FirstName"}
    $Body += @{"lastName" = "$LastName"}
    $Body += @{"emailAddress" = "$EmailAddress"}
    $Body += @{"assignedGroup" = "$AssignedGroup"}
    $Body += @{"rank" = 0}
    $Body += @{"timeZone" = "$TimeZone"}
    $Body += @{"role" = "$Role"}
    $Body += @{"teamId" = "$TeamID"}
    $Body += @{"userName" = "$Username"}
    $Body += @{"externalIdentity" = "$EmailAddress"}
    $Body += @{"billable" = $True}
    $Body += @{"loginAuthenticatorId" = "$loginAuthenticatorId"}
    $Body += @{"status" = "ACTIVE"}

    $postData = ConvertTo-Json $Body

    $NewUser = Invoke-RestMethod -Method POST -Uri $Uri.Users -Body $postData -Headers $Header

    Write-Output $NewUser
}