$TAG = "winrm:1809"
$NAME = "winrm_server"
$USERNAME = "User"
$PASSWORD = "Password12345!"

Write-Host "[+] Building docker image" -ForegroundColor green
docker build -t $TAG .

Write-Host "[+] Running container" -ForegroundColor green
docker run -d --name $NAME $TAG

Write-Host "[+] Connecting to container via WinRM" -ForegroundColor green
$IP = docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $NAME
$CRED = New-Object PSCredential $USERNAME, (ConvertTo-SecureString -String $PASSWORD -AsPlainText -Force)
Enter-PSSession -Credential $CRED -ComputerName $IP -Authentication Basic -UseSSL -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck)