Remove-Item "C:/Users/$env:UserName/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/GiLqXiexKP.cmd"
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Remove-LocalUser -Name "onlyrat"
Remove-Item "C:/Users/onlyrat"
powershell /c Remove-Item $env:temp/* -r