<#
.Synopsis
    Generates Token for inContact API.

.EXAMPLE
    Get-NiceinContactActiveAgents -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 11/14/2019

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-NiceinContactActiveAgents {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Token.")]
        [string[]]$Token
    )
    $Uri = @{
        "Agents" = "https://api-c14.incontact.com/inContactAPI/services/v16.0/agents"
    }
    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Accept'          = "*/*"
    }

    $ActiveAgents = Invoke-RestMethod -Method GET -Uri $Uri.Agents -Headers $Header
    Write-Output $ActiveAgents.agents
}