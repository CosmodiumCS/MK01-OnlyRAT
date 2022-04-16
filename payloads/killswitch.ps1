Remove-LocalUser -Name "onlyrat"
Remove-Item "C:/Users/onlyrat"
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
shutdown /r
Remove-Item "C:/Users/$env:UserName/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/GiLqXiexKP.cmd"
Remove-Item $env:temp/* -r