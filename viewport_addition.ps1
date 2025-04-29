# Get the folder where the script is located
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Define the line to insert after
$insertAfterPattern = '<meta name="keywords"'

# Define the line to insert
$viewportMeta = '<meta name="viewport" content="width=device-width, initial-scale=1.25, maximum-scale=1.25, user-scalable=no">'

# Get all .html files in the folder (non-recursive)
Get-ChildItem -Path $scriptFolder -Filter *.html -File | ForEach-Object {
    $file = $_.FullName
    $lines = Get-Content $file
    $newLines = @()

    foreach ($line in $lines) {
        $newLines += $line
        if ($line -match $insertAfterPattern) {
            $newLines += $viewportMeta
        }
    }

    # Save updated file
    Set-Content -Path $file -Value $newLines -Encoding UTF8
}

Write-Output "Viewport tag added to applicable HTML files."
