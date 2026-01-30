Install-Module -Name Posh-SSH
Import-Module Posh-SSH

$pass = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("root", $pass)

# 터널링 세션 생성
$session = New-SSHTunnel -ComputerName "pentest.yoobi.kr" -Port 10500 -Credential $credential -LocalPort 8080 -RemotePort 80
Start-SSHTunnel -SSHTunnel $session
