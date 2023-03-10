<#
.Synopsis
    Activates user in UserHub

.EXAMPLE
    New-NiceinContactUserHubUserInvite -AToken "Access Token" -SenderUserId "Sender User ID" -InviteUserID "Invite User ID"

.NOTES
    Modified by: Derek Hartman
    Date: 3/9/2023

#>


[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function New-NiceinContactUserHubUserInvite {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Access Token.")]
        [string[]]$AToken,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Sender User Id")]
        [string[]]$SenderUserId,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Invite User ID")]
        [string[]]$InviteUserID
    )

    $Uri = @{
    "Invite" = "https://na1.nice-incontact.com/user-management/v1/users/invite"
    }

    $Header = @{
        'Authorization'   = "Bearer $Atoken"
        'Content-Type'    = "application/json"
        'Accept'          = "application/json"
    }

    $InviteUserVar = "$InviteUserID"
    $Body = @{ "inviteUserIds" = @($InviteUserVar) }
    $Body += @{"senderUserId" = "$SenderUserId"}

    $postData = ConvertTo-Json $Body

    $InviteUser = Invoke-RestMethod -Method POST -Uri $Uri.Invite -Body $postData -Headers $Header

    Write-Output $InviteUser
}