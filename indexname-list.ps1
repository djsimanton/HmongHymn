# Get the folder where the script is located
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition
$outputFile = Join-Path $scriptFolder "filelist.txt"

# Get all files in the script folder and its subfolders
Get-ChildItem -Path $scriptFolder -Recurse -File | ForEach-Object {
    # Skip the output file itself
    if ($_.FullName -ne $outputFile) {
        # Create relative path (from script folder), convert to forward slashes
        $relativePath = $_.FullName.Substring($scriptFolder.Length).TrimStart("\").Replace("\", "/")
        "'$relativePath',"
    }
} | Set-Content $outputFile
