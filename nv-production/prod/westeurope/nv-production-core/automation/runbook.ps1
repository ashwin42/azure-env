# Script to drain a session host and send a message to the users asking them to save their work and log off
# This script is intended to be run as a runbook in Azure Automation

Param(
    [Parameter(Mandatory=$false)]
    [string]$subscriptionId = "${subscription_id}",

    [Parameter(Mandatory=$false)]
    [string]$hostPoolName,

    [Parameter(Mandatory=$false)]
    [string]$sessionHostName,

    [Parameter(Mandatory=$false)]
    [string]$resourceGroupName,

    [Parameter(Mandatory=$false)]
    [string]$message = "This machine will be patched in 30 minutes. Please save your work and log off. You can log back in straight away!",

    [Parameter(Mandatory=$false)]
    [string]$messageTitle = "Planned maintenance",

    # bool doesn't work in azurerm_automation_software_update_configuration so we use a string
    [Parameter(Mandatory=$false)]
    [string]$drain = "true"
)

Import-Module -Name Az.DesktopVirtualization

# Connect using a Managed Service Identity
try {
        $AzureContext = (Connect-AzAccount -Identity -Subscription $subscriptionId).context
    }
catch{
        Write-Output "There is no system-assigned user identity. Aborting.";
        exit
    }

if ($drain -eq "true") { $allowNewSession = $false } else { $allowNewSession = $true }

# Set the session host to drain mode and send a message to the user
try {
    Update-AzWvdSessionHost -HostPoolName $hostPoolName `
                            -Name $sessionHostName `
                            -ResourceGroupName $resourceGroupName `
                            -AllowNewSession:$allowNewSession

    if ($drain) {
        # list all users and send a message to the users
        $users = Get-AzWvdUserSession -HostPoolName $hostPoolName `
                                      -SessionHostName $sessionHostName `
                                      -ResourceGroupName $resourceGroupName `
                                      
        foreach ($user in $users) {
            $sessionId =  $user.Id.split("/")[-1]
          
            Send-AzWvdUserSessionMessage -ResourceGroupName $resourceGroupName `
                                         -HostPoolName $hostPoolName `
                                         -SessionHostName $sessionHostName `
                                         -MessageTitle $messageTitle `
                                         -MessageBody $message `
                                         -UserSessionId $sessionId
                                           
        }
    }
}
catch {
  Write-Error -message $_.Exception
  throw $_.Exception
}
