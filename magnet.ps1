param($1)
Write-Host "$1"
ssh -i .\.ssh\id_rsa ra@192.168.111.101 -p 2201 -f magnet "$1"