<#
.Synopsis
    Creates a new inContact Agent

.EXAMPLE
    New-NiceinContactAgent -FirstName "xxxx" -LastName "xxxxxx" -TeamID "xxx" -EmailAddress "xxxx" -Username "xxxx" -TimeZone "(GMT-05:00) Eastern Time (US & Canada)" -Country "US" -State "xx" -City "xxx" -UserType "xxx" -NTLoginName "xxxx" -Token $Token

.NOTES
    Modified by: Derek Hartman
    Date: 10/21/2020

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function New-NiceinContactAgent {
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
            HelpMessage = "Enter Username")]
        [string[]]$Username,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter TimeZone")]
        [string[]]$TimeZone,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Country")]
        [string[]]$Country,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter State Code")]
        [string[]]$State,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter City")]
        [string[]]$City,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter User Type")]
        [string[]]$UserType,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter User NTLoginName")]
        [string[]]$NTLoginName,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Token")]
        [string[]]$Token

    ) 

    $Uri = @{
        "Agents" = "https://api-c14.incontact.com/inContactAPI/services/v16.0/agents"
    }

    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Content-Type'  = 'application/json';
        'Accept'          = "*/*"
    }
    
    $Body = @{"firstName" = "$FirstName"} 
    $Body += @{"lastName" = "$LastName"}
    $Body += @{"teamId" = "$TeamID"}
    $Body += @{"emailAddress" = "$EmailAddress"}
    $Body += @{"userName" = "$Username"}
    $Body += @{"profileId" = 208}
    $Body += @{"timeZone" = "$TimeZone"}
    $Body += @{"country" = "$Country"}
    $Body += @{"state" = "$State"}
    $Body += @{"city" = "$City"}
    $Body += @{"userType" = "$UserType"}
    $Body += @{"federatedId" = "$Username"}
    $Body += @{"custom1" = "$NTLoginName"}
    $Body += @{"ntLoginName" = "$NTLoginName"}
    $Body += @{"chatRefusalTimeout" = 60}
    $Body += @{"phoneRefusalTimeout" = 30}
    $Body += @{"workItemRefusalTimeout" = 60}

    $OuterBody = @{ "agents" = @($Body) }

    $postData = ConvertTo-Json $OuterBody

    $Agents = Invoke-RestMethod -Method POST -Uri $Uri.Agents -Body $postData -Headers $Header

    Write-Output $Agents
}