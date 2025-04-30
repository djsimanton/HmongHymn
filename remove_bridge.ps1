$scriptFolder = $PSScriptRoot
$files = Get-ChildItem -Path $scriptFolder -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # Remove top_bg block between <!-- start top_bg --> and <!-- start main -->
    $pattern = '(?s)<!-- start top_bg -->.*?<div class="top_bg">.*?<!-- start main -->'
    $replacement = '<!-- start main -->'

    $newContent = [regex]::Replace($content, $pattern, $replacement)

    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.UTF8Encoding]::new($false))
        Write-Host "✅ Removed top_bg from: $($file.Name)"
    } else {
        Write-Host "ℹ️ No match in: $($file.Name)"
    }
}
