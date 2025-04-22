# Get the folder where the PowerShell script is located
$scriptFolder = $PSScriptRoot

# Define the log file path in the same folder as the PowerShell script
$logFile = Join-Path -Path $scriptFolder -ChildPath "logfile.txt"

# Start logging to a text file in the same folder
Start-Transcript -Path $logFile

# Set the folder path for HTML files in the 'index' subfolder of the script folder
$folderPath = Join-Path -Path $scriptFolder -ChildPath "index"

# Check if the index folder exists
if (-not (Test-Path $folderPath)) {
    Write-Host "❌ Error: 'index' folder not found at path: $folderPath"
    Stop-Transcript
    exit
}

# Loop through each .html file
Get-ChildItem -Path $folderPath -Filter *.html | ForEach-Object {
    $file = $_.FullName

    # Read content with UTF-8 encoding (without BOM) to avoid encoding issues
    $content = Get-Content $file -Raw -Encoding UTF8

    Write-Host "Processing file: $($_.Name)"

    # Perform replacements
    $newContent = $content -replace '20110', '2025'
    $newContent = $newContent -replace 'MekongChristianMedia', '<a href="https://www.mekongchristianmedia.com" target="_blank">MekongChristianMedia</a>'

    # Write updated content if changes were made
    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($file, $newContent, [System.Text.UTF8Encoding]::new($false))
        Write-Host "✅ Updated $($_.Name)"
    } else {
        Write-Host "No changes needed for $($_.Name)"
    }
}

# End logging
Stop-Transcript

# Pause for review
Write-Host "Press Enter to close..."
Read-Host
