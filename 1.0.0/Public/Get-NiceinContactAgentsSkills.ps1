<#
.Synopsis
    Returns all Active Agent's Skills

.EXAMPLE
    Get-NiceinContactAgentsSkills -Token $Token -AgentID "xxxxxxx"

.NOTES
    Modified by: Derek Hartman
    Date: 11/20/2019

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-NiceinContactAgentsSkills {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Token.")]
        [string[]]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Agents ID.")]
        [string[]]$AgentID
    )
    $Uri = @{
        "Agents" = "https://api-c14.incontact.com/inContactAPI/services/v16.0/agents/$AgentID/skills?isSkillActive=true"
    }
    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Accept'          = "*/*"
    }

    $AgentsSkills = Invoke-RestMethod -Method GET -Uri $Uri.Agents -Headers $Header
    Write-Output $AgentsSkills.agentSkillAssignments
}