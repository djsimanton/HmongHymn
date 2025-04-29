# Set folder to where the script is running
$folder = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Define the old and new viewport meta tag
$old = '<meta name="viewport" content="width=device-width, initial-scale=1.25, maximum-scale=1.25, user-scalable=no">'
$new = '<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">'

# Process all .html files in the root of the folder
Get-ChildItem -Path $folder -Filter *.html -File | ForEach-Object {
    (Get-Content $_.FullName) -replace [regex]::Escape($old), $new | Set-Content $_.FullName
}

Write-Host "Viewport meta tag updated in all HTML files."
