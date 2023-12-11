$profilePath = $env:USERPROFILE
$magnetFolderPath = Join-Path -Path $profilePath -ChildPath ".magnet"
$confFilePath = Join-Path -Path $magnetFolderPath -ChildPath "magnet2.conf"

# Check if the .magnet folder exists, and if not, create it
if (-not (Test-Path -Path $magnetFolderPath -PathType Container)) {
    New-Item -Path $magnetFolderPath -ItemType Directory
}

# Check if the magnet2.conf file exists, and if not, create it
if (-not (Test-Path -Path $confFilePath -PathType Leaf)) {
    $confContent = @"
pvtkeypath=""
userSSH=
ip=
portaSSH=
portaTransmission=
userTransmission=
senhaTransmission=
"@
    $confContent | Out-File -FilePath $confFilePath
    Write-Host "magnet2.conf file created at: $confFilePath"
} else {
    Write-Host "magnet2.conf file already exists at: $confFilePath"
}
