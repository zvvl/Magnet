param($1)

$profilePath = $env:USERPROFILE
$magnetFolderPath = Join-Path -Path $profilePath -ChildPath ".magnet"
$confFilePath = Join-Path -Path $magnetFolderPath -ChildPath "magnet2.conf"

if (-not (Test-Path -Path $magnetFolderPath -PathType Container)) {
    New-Item -Path $magnetFolderPath -ItemType Directory
}

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

$fileContent = Get-Content -Path $conffilePath

$variables = @{}

foreach ($line in $fileContent) {
    $parts = $line -split '='
    if ($parts.Length -eq 2) {
        $variableName = $parts[0].Trim()
        $variableValue = $parts[1].Trim()
        $variables[$variableName] = $variableValue
    }
}

if ($variables.ContainsKey('pvtkeypath') -and $variables.ContainsKey('userSSH') -and $variables.ContainsKey('ip') -and $variables.ContainsKey('portaSSH') -and $variables.ContainsKey('portaTransmission') -and $variables.ContainsKey('userTransmission') -and $variables.ContainsKey('senhaTransmission')) {
    $pvtkeypathBosta = $variables['pvtkeypath']
    $pvtkeypathValue = $pvtkeypathBosta.ToString() 
    $userSSHValue = $variables['userSSH']
    $ipValue = $variables['ip']
    $portaSSHValue = $variables['portaSSH']
    $portaTransmissionValue = $variables['portaTransmission']
    $userTransmissionValue = $variables['userTransmission']
    $senhaTransmissionValue = $variables['senhaTransmission']

    Write-Host "pvtkeypath: $pvtkeypathValue"
    Write-Host "userSSH: $userSSHValue"
    Write-Host "ip: $ipValue"
    Write-Host "portaSSH: $portaSSHValue"
    Write-Host "portaTransmission: $portaTransmissionValue"
    Write-Host "userTransmission: $userTransmissionValue"
    Write-Host "senhaTransmission: $senhaTransmissionValue"
    Write-Host "magnet passado: $1"
    Write-Host ""
    Write-Host "ssh -i $pvtkeypathValue $userSSHValue@$ipValue -p $portaSSHValue -f transmission-remote $portaTransmissionValue -n ${userTransmissionValue}:$senhaTransmissionValue --add ""$1"""
    ssh -i $pvtkeypathValue $userSSHValue@$ipValue -p $portaSSHValue -f transmission-remote $portaTransmissionValue -n ${userTransmissionValue}:$senhaTransmissionValue --add ""$1""
    

} else {
    Write-Host "num deu."
}
    




}







