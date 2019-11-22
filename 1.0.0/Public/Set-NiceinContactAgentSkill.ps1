<#
.Synopsis
    Adds Skill to incontact agent

.EXAMPLE
    Set-NiceinContactAgentSkill -AgentID "xxx" -SkillID "xxxx" -Token $Token

.NOTES
    Modified by: Derek Hartman
    Date: 11/22/2019

#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Set-NiceinContactAgentSkill {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Agent ID")]
        [string[]]$AgentID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter Skill ID")]
        [string[]]$SkillID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Token")]
        [string[]]$Token

    ) 

    $Uri = @{
        "Agents" = "https://api-c14.incontact.com/inContactAPI/services/v16.0/agents/$AgentID/skills"
    }

    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Content-Type'  = 'application/json';
        'Accept'          = "*/*"
    }
    
    $Body = @{"skillId" = "$SkillID"} 
    $Body += @{"proficiency" = 3}
    $Body += @{"isActive" = $True}

    $OuterBody = @{ "skills" = @($Body) }

    $postData = ConvertTo-Json $OuterBody

    $Agents = Invoke-RestMethod -Method POST -Uri $Uri.Agents -Body $postData -Headers $Header

    Write-Output $Agents
}