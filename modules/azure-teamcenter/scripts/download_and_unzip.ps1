param( 
    [Parameter(Mandatory = $true)] 
    [string]$StorageAccountKey, 
 
    [Parameter(Mandatory = $true)] 
    [string]$StorageAccountName, 
 
    [Parameter(Mandatory = $true)] 
    [string]$Container,

    [Parameter(Mandatory = $true)] 
    [string]$Blob,

    [Parameter(Mandatory = $true)] 
    [string]$Target
)

Set-StrictMode -Version 3
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Check if Windows Azure Powershell is avaiable 
if ((Get-Module -ListAvailable Azure) -eq $null) 
{ 
    throw "Windows Azure Powershell not found! Please install from http://www.windowsazure.com/en-us/downloads/#cmd-line-tools" 
} 

# Setup Storage Context
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

# Make the folder
New-Item -ItemType directory -Force -Path $Target

# Copy the installation files
try 
    { 
        Get-AzureStorageBlobContent -Container $Container -Blob $Blob -Destination $Target -context $ctx
    } 
catch 
    { 
        throw "Unable to download blob " + $Blob
    }

# Unzip the file
$SourceFile = $Target + "\" + $Blob
$ExtractedTarget = $Target + "\" + (Get-Item $SourceFile).Basename
$Output = "Unzipping " + $SourceFile + " to " + $ExtractedTarget
Write-Output $Output
[System.IO.Compression.ZipFile]::ExtractToDirectory($SourceFile, $ExtractedTarget)

Write-Output "Done!"
