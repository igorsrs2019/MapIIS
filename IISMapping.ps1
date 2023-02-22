# Import Modules
Import-Module WebAdministration

# Identify all IIS sites
$sites = Get-ChildItem IIS:\Sites

# Count Sites

$totalSites = $sites.Count

Write-Host "The total sites on this IIS is: $totalSites"


# Get all the sites in IIS
$sites = Get-Website

# Initialize counters for running and stopped sites
$runningCount = 0
$stoppedCount = 0



# Iterate through each site and check its state
foreach ($site in $sites) {
    if ($site.State -eq 'Started') {
        $runningCount++
    }
    else {
        $stoppedCount++
    }
}

# Display the counts to the console
Write-Host "Running sites: $runningCount"
Write-Host "Stopped sites: $stoppedCount"

"`n"

# Loop through each site
foreach ($site in $sites) {
    Write-Output "Site: $($site.Name)"
    
    # Identify the physical path of the site
    $physicalPath = $site.PhysicalPath
    Write-Output "Physical Path: $physicalPath"
    
    # Look for the web.config file
    $webConfigPath = Join-Path $physicalPath "web.config.txt"
    if (Test-Path $webConfigPath) {
        Write-Output "web.config found at: $webConfigPath"
        
        # Read the contents of the web.config file
        $webConfigContent = Get-Content $webConfigPath
        
        # Add the contents of the web.config file to a text block file
        $output = "Site: $($site.Name)`n`n$webConfigContent`n`n`n`n" 
        Add-Content -Path "IISMap.txt" -Value $output
    } else {


        Write-Output "web.config not found."
    }
    
   

}
"`n"
Write-Output  "Script completed.-> Look for a file called IISMap.txt in the same directory.<-"