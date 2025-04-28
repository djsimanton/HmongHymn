# Save this as: fix-html-pwa.ps1
$indexFolder = Join-Path $PSScriptRoot "index"
$htmlFiles = Get-ChildItem -Path $indexFolder -Filter *.html

foreach ($file in $htmlFiles) {
    Write-Output "Processing: $($file.Name)"

    $content = Get-Content $file.FullName -Raw

    # 1. Fix Google Fonts URL to https
    $content = $content -replace 'http://fonts\.googleapis\.com', 'https://fonts.googleapis.com'

    # 2. Ensure manifest link is present
    if ($content -notmatch '<link\s+rel="manifest"') {
        $content = $content -replace '(?i)(<head[^>]*>)', { 
            param($m) "$($m.Groups[1].Value)`n<link rel=""manifest"" href=""/manifest.json"">"
        }
    }

    # 3. Ensure viewport meta tag is present
    if ($content -notmatch '<meta\s+name="viewport"') {
        $content = $content -replace '(?i)(<head[^>]*>)', { 
            param($m) "$($m.Groups[1].Value)`n<meta name=""viewport"" content=""width=device-width, initial-scale=1"">"
        }
    }

    # 4. Ensure theme-color meta tag is present
    if ($content -notmatch '<meta\s+name="theme-color"') {
        $content = $content -replace '(?i)(<head[^>]*>)', { 
            param($m) "$($m.Groups[1].Value)`n<meta name=""theme-color"" content=""#003366"">"
        }
    }

    # 5. Add Service Worker registration script before </body>
    if ($content -notmatch 'navigator\.serviceWorker\.register') {
        $swScript = @"
<script>
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/sw.js')
    .then(function(registration) {
      console.log('Service Worker registered with scope:', registration.scope);
    }, function(err) {
      console.log('Service Worker registration failed:', err);
    });
}
</script>
"@

        $content = $content -replace '(?i)(</body>)', "$swScript`n`$1"
    }

    # Save updated content back to file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Output "✅ All files processed successfully!"
