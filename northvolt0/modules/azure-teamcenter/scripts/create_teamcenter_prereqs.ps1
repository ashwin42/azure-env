Set-StrictMode -Version 3

Write-Output "Creating new teamcenter user"

New-LocalUser -Name "teamcenter" -Description "Teamcenter service account" -NoPassword
Add-LocalGroupMember -Group "Administrators" -Member "teamcenter"