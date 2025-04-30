# Define the script tag to insert
$scriptTag = '<script src="js/font-buttons.js"></script>'

# Get the folder where this script is located
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Get all .html files in the script folder (not in subfolders)
Get-ChildItem -Path $scriptFolder -Filter *.html -File | ForEach-Object {
    $filePath = $_.FullName
    $content = Get-Content $filePath -Raw

    # Only proceed if the script tag is not already included
    if ($content -notmatch [regex]::Escape($scriptTag)) {
        if ($content -match '</body>') {
            # Insert script tag before </body>
            $newContent = $content -replace '(?i)</body>', "$scriptTag`r`n</body>"
            Set-Content -Path $filePath -Value $newContent -Encoding UTF8
            Write-Host "Updated: $($_.Name)"
        } else {
            Write-Host "No </body> tag found in $($_.Name), skipped."
        }
    } else {
        Write-Host "Already contains script tag: $($_.Name)"
    }
}
