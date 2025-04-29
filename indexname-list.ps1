# Set $indexFolder to the 'index' folder relative to the script location
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition
$indexFolder = Join-Path $scriptFolder "index"
$outputFile = Join-Path $scriptFolder "filelist.txt"

# Get all files inside 'index' and subfolders (no file type filter)
Get-ChildItem -Path $indexFolder -Recurse -File | ForEach-Object {
    # Get the relative path from the 'index' folder, convert to forward slashes
    $relativePath = $_.FullName.Substring($indexFolder.Length).TrimStart("\").Replace("\", "/")
    "'/index/$relativePath',"
} | Set-Content $outputFile
