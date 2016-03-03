# The code structure for this is thanks to Ramiro Morales, https://github.com/ramiro
# Thanks for a much improved methodology for installing these fonts!

$name = 'hackfont'
$version = '2.019'
$dl_version = $version -replace '\.', '_'

$url = "https://github.com/chrissimpkins/Hack/releases/download/v${version}/Hack-v${dl_version}-ttf.zip"
$destination = Join-Path $Env:Temp $packageName

# Download and unzip to destination
Install-ChocolateyZipPackage $packageName -url $url -unzipLocation $destination

# Obtain system font folder for extraction
$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)

# Loop the extracted files and install them
Get-ChildItem $destination -Recurse -Filter *.ttf |
    ForEach-Object { $fontsFolder.CopyHere($_.FullName) }

# Remove our temporary files
Remove-Item $destination -Recurse