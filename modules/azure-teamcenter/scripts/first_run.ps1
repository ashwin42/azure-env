param( 
    [Parameter(Mandatory = $true)] 
    [string]$StorageAccountKey, 
 
    [Parameter(Mandatory = $true)] 
    [string]$StorageAccountName, 
 
    [Parameter(Mandatory = $true)] 
    [string]$Container
)

$ScriptsToRun = @("create_teamcenter_prereqs.ps1", "download_and_unzip.ps1")

$BlobsToUnzip = @("Tc12.0.0.0_wntx64_1_of_2.zip", "Tc12.0.0.0_wntx64_2_of_2.zip")

$Target = "Teamcenter"

Write-Output "Running first_run script..."

# Install azure sdk
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name AzureRM -AllowClobber -Force

# Setup Storage Context
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

# Copy the installation files
foreach ($Script in $ScriptsToRun) {
    try { Get-AzureStorageBlobContent -Container $Container -Blob $Script -context $ctx } 
    catch { throw "Unable to download blob " + $Blob }
}

# Run the scripts
& "$PSScriptRoot\create_teamcenter_prereqs.ps1"

foreach ($Blob in $BlobsToUnzip) {
	& "$PSScriptRoot\download_and_unzip.ps1 -StorageAccountKey $StorageAccountKey -StorageAccountName $StorageAccountName -Container $Container -Blob $Blob -Target $Target"
}
