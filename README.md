# WinRM Windows Docker image

Run Microsoft WinRM service in a Windows container.

*Why?*

You might want to have an integration test environment to try it out.

## Build the image

```ps1
docker build -t winrm:ltsc2022 .
```

## Run the container

```ps1
docker run -d --name winrm_server winrm:ltsc2022
```

or, if you want to expose WinRM ports:

```ps1
docker run -d --name winrm_server -p 55985:5985 -p 55986:5986 winrm:ltsc2022
```

## Connect to the container via WinRM

```ps1
$IP = docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" winrm_server
$CRED = New-Object PSCredential 'User', (ConvertTo-SecureString -String 'Password12345!' -AsPlainText -Force)
Enter-PSSession -Credential $CRED -ComputerName $IP -Authentication Basic -UseSSL -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck)
```

## Stop the container

```ps1
docker rm --force winrm_server
```

## DockerHub

- [peco602/winrm-windows-docker](https://hub.docker.com/repository/docker/peco602/winrm-windows-docker)