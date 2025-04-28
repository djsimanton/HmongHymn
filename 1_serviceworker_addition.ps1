# Save as: add-serviceworker.ps1

# Define the folder location where the HTML files are located
$indexFolder = Join-Path $PSScriptRoot "index"
$htmlFiles = Get-ChildItem -Path $indexFolder -Filter *.html

foreach ($file in $htmlFiles) {
    Write-Output "Processing: $($file.Name)"

    # Read the content of the HTML file with explicit UTF8 encoding
    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # If PWA tags already exist, skip this file
    if ($content -match '<link\s+rel=["'']manifest["'']') {
        Write-Output "Skipping $($file.Name) - manifest already present."
        continue
    }

    # Define the PWA-related tags (manifest, theme-color, and service worker registration script)
    $pwaTags = @"
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#003366">
    <script>
        if ('serviceWorker' in navigator) {
            window.addEventListener('load', function() {
                navigator.serviceWorker.register('/service-worker.js')
                    .then(function(registration) {
                        console.log('Service Worker registered with scope:', registration.scope);
                    })
                    .catch(function(error) {
                        console.log('Service Worker registration failed:', error);
                    });
            });
        }
    </script>
"@

    # Insert PWA tags after the <head> tag
    $headIndex = $content.IndexOf("<head")
    if ($headIndex -gt -1) {
        # Find the end of the <head> tag
        $headEndIndex = $content.IndexOf(">", $headIndex)

        # Insert the PWA tags right after the <head> tag
        $content = $content.Substring(0, $headEndIndex + 1) + "`n" + $pwaTags + $content.Substring($headEndIndex + 1)
    }

    # Fix Google Fonts link if needed (http -> https)
    $content = $content -replace 'http://fonts\.googleapis\.com', 'https://fonts.googleapis.com'

    # Save the modified content back to the file with UTF8 encoding
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Output "✅ All files updated with service worker, manifest, and theme-color meta tags successfully."
