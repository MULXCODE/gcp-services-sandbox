
Set-Content -Path C:\Password.txt -Value 'CleartextP$ss111'
Set-Content -Path .\Test.txt -Value 'Test'
Set-Content -Path C:\Basic.txt -Value 'basic'

net user Administrator CleartextP$ss111
net user jon CleartextP$ss111 /add
net localgroup administrators jon /add

# install dotnet
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile dotnet.ps1
.\dotnet.ps1


# install git
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url="github.com/git-for-windows/git/releases/download/v2.21.0.windows.1/Git-2.21.0-64-bit.exe"
Invoke-WebRequest -Uri $url -OutFile install_git.exe

.\install_git.exe /VERYSILENT /SUPRESSMESSAGEBOXES

# install gcds
wget https://dl.google.com/dirsync/dirsync-win64.exe -OutFile dirsync-win64.exe

# install chrome
$Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer



# fault tolerant msft active directory
net user Administrator /active:yes
net user Administrator /passwordreq:yes
