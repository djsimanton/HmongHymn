$folder = "C:\Users\D'Arcy\Dropbox\Publishing\App building\hmong\www-iphone\index"
$outputFile = "$env:USERPROFILE\Desktop\filelist.txt"

Get-ChildItem -Path $folder -Filter *.html -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Replace($folder, "").Replace("\", "/").TrimStart("/")
    "'/index/$relativePath',"
} | Set-Content $outputFile
