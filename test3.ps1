$PlinkUrl = "https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe"
$PlinkPath = "$env:TEMP\plink.exe"

$RemoteHost = "pentest.yoobi.kr"
$RemotePort = "10500"
$SshUser = "root"
$SshPass = "P@ssw0rd"

# 로컬포트:원격호스트:원격포트
$LocalForward = "8080:localhost:80"

# 1. plink.exe 다운로드 (파일이 없을 경우에만)
if (-not (Test-Path $PlinkPath)) {
    Write-Host "[!] plink.exe가 없습니다. 다운로드를 시작합니다..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $PlinkUrl -OutFile $PlinkPath
    Write-Host "[+] 다운로드 완료: $PlinkPath" -ForegroundColor Green
}

# 2. 실행 정책 확인 및 안내
Write-Host "[+] SSH 터널링을 시작합니다..." -ForegroundColor Cyan
Write-Host "[+] 연결 정보: $SshUser@$RemoteHost (Port: $RemotePort)"
Write-Host "[+] 터널링 경로: localhost:8080 -> $RemoteHost 내부 80포트"
Write-Host "[!] 종료하려면 Ctrl+C를 누르세요." -ForegroundColor Magenta

# 3. plink 실행
# & 기호를 사용하여 외부 파일을 실행합니다.
& $PlinkPath -batch -ssh -P $RemotePort -pw $SshPass -L $LocalForward "$SshUser@$RemoteHost" -N
