Remove-Item $env:temp/*
Remove-Item "C:/Users/$env:UserName/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/GiLqXiexKP.cmd"
Remove-LocalUser -Name "onlyrat"
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
shutdown /r