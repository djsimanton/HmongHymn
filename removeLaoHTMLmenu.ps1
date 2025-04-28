# Path to the index folder relative to where the script is run
$indexFolderPath = Join-Path -Path $PSScriptRoot -ChildPath "index"

# Pattern to find the <li><a href="contentlao.html"> line, allowing for spaces/tabs
$pattern = '^[ \t]*<li><a href="contentlao\.html">ເພງສັນລະເສີນ \(Lao\)</a></li>[ \t]*\r?\n?'

# Get all .html files inside the index folder
$files = Get-ChildItem -Path $indexFolderPath -Filter "*.html"

foreach ($file in $files) {
    # Read file contents
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    # Remove the matching line
    $newContent = [regex]::Replace($content, $pattern, "", [System.Text.RegularExpressions.RegexOptions]::Multiline)

    if ($newContent -ne $content) {
        # Write back to file (UTF-8 without BOM)
        $utf8Encoding = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8Encoding)

        Write-Host "✅ Modified: $($file.Name)"
    } else {
        Write-Host "ℹ️ No matching line found in: $($file.Name)"
    }
}
