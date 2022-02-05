function Get-WebCamImage { 
 
#requires -version 2.0 
 
<# 
.Synopsis 
   Use PowerShell to preview video from your webcam and also take snapshots 
.Description 
   This PowerShell script previews video from your webcam and takes snapshots to JPEG 
   Script uses WebCamLib which is a C# wrapper around a couple of API's in avicap32.dll 
   The script can run interactively or from the command line.  
   You can use some other program like the old vidcap32.exe from MSFT to change the  
   resolution of the captured image, i.e increase it to 640x480  
   Video Preview must be partially visible or the photos will be frozen on last scene. 
   Start the shell using a single-threaded apartment, Use -sta switch as per example 
   Code uses clipboard to transfer photo which only works when powershell is in sta mode 
.Parameter AppActivate 
   Application is forced on top to ensure picture is taken 
.Parameter CamIndex 
   The camera is selected, use index 0 for the first camera 
.Parameter Interval 
   When this parameter is used, a snapshot is taken every x second(s)    
.Parameter PathBase 
   The base path that images are created.  
   Defaults to "c:\cap\image" (ensure base 'folder' exists) 
   Images are created - "c:\cap\image0.jpg","c:\cap\image1.jpg","c:\cap\image2.jpg" 
.Parameter UseCam 
   start using camera straight away when this switch is selected 
 
.example 
   Get-WebCamImage 
    
   Description 
   ----------- 
   The camera application is displayed 
.example 
   Get-WebCamImage -CamIndex 0 -UseCam 
    
   Description 
   ----------- 
   The camera application is displayed, first camera in drop downlist is selected  
   and started.  
.example 
   Get-WebCamImage -CamIndex 0 -UseCam -interval 3 
    
   Description 
   ----------- 
   The camera application is displayed, first camera in drop downlist is selected  
   and started. A image is captured and saved in default path every 3 seconds 
.example 
   %windir%\system32\WindowsPowerShell\v1.0\powershell.exe -sta -WindowStyle Hidden -file C:\scripts\get-WebCam.ps1 
   or 
   powershell.exe C:\scripts\get-WebCam.ps1 -sta  
    
   Description 
   ----------- 
   If you want to launch the application from a shortcut use this command or similar 
   Note the -sta parameter is required.        
.Link 
   http://social.technet.microsoft.com/Profile/en-US/?user=Matthew Painter 
.link 
   http://weblogs.asp.net/nleghari/pages/webcam.aspx 
.Notes 
   NAME:      Get-WebCamImage 
   VERSION:   1.0 
   AUTHOR:    Matthew Painter 
   LASTEDIT:  26/09/2010 
 
#> 
   [CmdletBinding()]    
    
      Param ( 
      [Parameter( 
      ValueFromPipeline=$False, 
      Mandatory=$False, 
      HelpMessage="Application is forced on top to ensure picture is taken")] 
      [Switch]$AppActivate, 
       
      [Parameter( 
      ValueFromPipeline=$False, 
      Mandatory=$false, 
      HelpMessage="The dropdown list index specifying the camera to be selected")] 
      [int]$CamIndex=0, 
 
      [Parameter( 
      ValueFromPipeline=$False, 
      Mandatory=$False, 
      HelpMessage="Interval in seconds between each snapshot image taken")] 
      [int]$Interval, 
       
      [Parameter( 
      ValueFromPipeline=$False, 
      Mandatory=$False, 
      HelpMessage="The base path that images are created")] 
      [String]$PathBase="c:\cap\image", 
       
      [Parameter( 
      ValueFromPipeline=$False, 
      Mandatory=$false, 
      HelpMessage="This parameter is a switch - start using camera straight away")] 
      [switch]$UseCam 
      ) 
    
   $source=@" 
using System; 
using System.Collections.Generic; 
using System.Text; 
using System.Collections; 
using System.Runtime.InteropServices; 
using System.ComponentModel; 
using System.Data; 
using System.Drawing; 
using System.Windows.Forms; 
 
namespace WebCamLib 
{ 
    public class Device 
    { 
        private const short WM_CAP = 0x400; 
        private const int WM_CAP_DRIVER_CONNECT = 0x40a; 
        private const int WM_CAP_DRIVER_DISCONNECT = 0x40b; 
        private const int WM_CAP_EDIT_COPY = 0x41e; 
        private const int WM_CAP_SET_PREVIEW = 0x432; 
        private const int WM_CAP_SET_OVERLAY = 0x433; 
        private const int WM_CAP_SET_PREVIEWRATE = 0x434; 
        private const int WM_CAP_SET_SCALE = 0x435; 
        private const int WS_CHILD = 0x40000000; 
        private const int WS_VISIBLE = 0x10000000; 
 
        [DllImport("avicap32.dll")] 
        protected static extern int capCreateCaptureWindowA([MarshalAs(UnmanagedType.VBByRefStr)] ref string lpszWindowName, 
            int dwStyle, int x, int y, int nWidth, int nHeight, int hWndParent, int nID); 
 
        [DllImport("user32", EntryPoint = "SendMessageA")] 
        protected static extern int SendMessage(int hwnd, int wMsg, int wParam, [MarshalAs(UnmanagedType.AsAny)] object lParam); 
 
        [DllImport("user32")] 
        protected static extern int SetWindowPos(int hwnd, int hWndInsertAfter, int x, int y, int cx, int cy, int wFlags); 
 
        [DllImport("user32")] 
        protected static extern bool DestroyWindow(int hwnd); 
                 
        int index; 
        int deviceHandle; 
 
        public Device(int index) 
        { 
            this.index = index; 
        } 
 
        private string _name; 
 
        public string Name 
        { 
            get { return _name; } 
            set { _name = value; } 
        } 
 
        private string _version; 
 
        public string Version 
        { 
            get { return _version; } 
            set { _version = value; } 
        } 
 
        public override string ToString() 
        { 
            return this.Name; 
        } 
 
        public void Init(int windowHeight, int windowWidth, int handle) 
        { 
            string deviceIndex = Convert.ToString(this.index); 
            deviceHandle = capCreateCaptureWindowA(ref deviceIndex, WS_VISIBLE | WS_CHILD, 0, 0, windowWidth, windowHeight, handle, 0); 
 
            if (SendMessage(deviceHandle, WM_CAP_DRIVER_CONNECT, this.index, 0) > 0) 
            { 
                SendMessage(deviceHandle, WM_CAP_SET_SCALE, -1, 0); 
                SendMessage(deviceHandle, WM_CAP_SET_PREVIEWRATE, 0x42, 0); 
                SendMessage(deviceHandle, WM_CAP_SET_PREVIEW, -1, 0); 
                SetWindowPos(deviceHandle, 1, 0, 0, windowWidth, windowHeight, 6); 
            } 
        } 
 
        public void ShowWindow(global::System.Windows.Forms.Control windowsControl) 
        { 
            Init(windowsControl.Height, windowsControl.Width, windowsControl.Handle.ToInt32());                         
        } 
         
        public void CopyC() 
        { 
           SendMessage(this.deviceHandle, WM_CAP_EDIT_COPY, 0, 0);          
        } 
 
        public void Stop() 
        { 
            SendMessage(deviceHandle, WM_CAP_DRIVER_DISCONNECT, this.index, 0); 
            DestroyWindow(deviceHandle); 
        } 
    } 
     
    public class DeviceManager 
    { 
        [DllImport("avicap32.dll")] 
        protected static extern bool capGetDriverDescriptionA(short wDriverIndex, 
            [MarshalAs(UnmanagedType.VBByRefStr)]ref String lpszName, 
           int cbName, [MarshalAs(UnmanagedType.VBByRefStr)] ref String lpszVer, int cbVer); 
 
        static ArrayList devices = new ArrayList(); 
 
        public static Device[] GetAllDevices() 
        { 
            String dName = "".PadRight(100); 
            String dVersion = "".PadRight(100); 
 
            for (short i = 0; i < 10; i++) 
            { 
                if (capGetDriverDescriptionA(i, ref dName, 100, ref dVersion, 100)) 
                { 
                    Device d = new Device(i); 
                    d.Name = dName.Trim(); 
                    d.Version = dVersion.Trim(); 
                    devices.Add(d);                     
                } 
            } 
 
            return (Device[])devices.ToArray(typeof(Device)); 
        } 
 
        public static Device GetDevice(int deviceIndex) 
        { 
            return (Device)devices[deviceIndex]; 
        } 
    } 
} 
"@ 
       
   Add-Type -AssemblyName System.Drawing  
   $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |   
   Where-Object { $_.FormatDescription -eq "JPEG" }  
    
   Add-Type -TypeDefinition $source -ReferencedAssemblies System.Windows.Forms, System.Data, System.Drawing 
 
 
 
#region Import the Assemblies 
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null 
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null 
#endregion 
 
#region Generated Form Objects 
$MainForm = New-Object System.Windows.Forms.Form 
$btnQuitApp = New-Object System.Windows.Forms.Button 
$btnCopyImage = New-Object System.Windows.Forms.Button 
$btnStopCam = New-Object System.Windows.Forms.Button 
$btnSelectDevice = New-Object System.Windows.Forms.Button 
$cmbDevices = New-Object System.Windows.Forms.ComboBox 
$picCapture = New-Object System.Windows.Forms.PictureBox 
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState 
#endregion Generated Form Objects 
 
#Build drop down list 
$devices = [WebCamLib.DeviceManager]::GetAllDevices() 
foreach ($d in $devices) 
{ 
   $cmbDevices.Items.Add($d) | Out-Null 
} 
 
if ($devices.Length -gt 0) 
{ 
   $cmbDevices.SelectedIndex = 0 
} 
 
#Select Button code 
$handler_btnSelectDevice_Click=  
{ 
   $d = [WebCamLib.DeviceManager]::GetDevice($cmbDevices.SelectedIndex) 
   $d.ShowWindow($picCapture) 
} 
 
#Copy Button Code 
$handler_btnCopyImage_Click=  
{ 
    [windows.forms.clipboard]::clear() 
    $d.CopyC()      
    $bitmap = [Windows.Forms.Clipboard]::GetImage()  
     
    if ($bitmap -ne $null) 
    {            
       $ep = New-Object Drawing.Imaging.EncoderParameters    
       $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)    
       $c = 0  
       while (Test-Path "${PathBase}${c}.jpg")  
       {  
          $c++  
       }  
       $bitmap.Save("$PathBase$c.jpg", $jpegCodec, $ep) 
       Write-host "Snap taken "$PathBase$c.jpg"" 
       $bitmap.dispose() 
       $ep.dispose() 
       [windows.forms.clipboard]::clear() 
    } 
    else 
    { 
       write-host "no image on clipboard" 
    } 
  
      
} 
 
#Stop Button Code 
$handler_btnStopCam_Click=  
{ 
   $d = [WebCamLib.DeviceManager]::GetDevice($cmbDevices.SelectedIndex) 
   $d.Stop() 
   if ($timer -ne $null){$timer.Stop()} 
} 
 
#Quit Button Code 
$handler_btnQuitApp_Click=  
{ 
   $MainForm.close() 
} 
 
 
$OnLoadForm_StateCorrection= 
{#Correct the initial state of the form to prevent the .Net maximized form issue 
   $MainForm.WindowState = $InitialFormWindowState 
     
   if($UseCam) 
   {        
      write-host "Using camera $CamIndex" 
      $d = [WebCamLib.DeviceManager]::GetDevice($cmbDevices.$CamIndex) 
      $d.ShowWindow($picCapture) 
   } 
} 
 
if ($interval -gt 0) 
{ 
   # Make Timer  
   [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")   
   $timer = New-Object System.Windows.Forms.Timer  
   if ($interval -gt 30 ) {$timer.Interval = 5000} Else {$timer.Interval = 1000} 
   $SecsToInterval = $interval 
  
   $timer.add_Tick({ 
  
   $SecsToInterval -= ($timer.Interval / 1000) 
  
   if ( $SecsToInterval -eq 0 )  
   { 
      $SecsToInterval = $interval 
       
      if ($Appactivate) 
      { 
         [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic") 
         [Microsoft.VisualBasic.Interaction]::AppActivate("PowerShell WebCam") 
      } 
       
      & $handler_btnCopyImage_Click 
   } 
  
   write-host " [ Next Snap in : $(new-Timespan -sec $SecsToInterval) ]" 
  
   }) 
  
   $timer.Enabled = $true 
   $timer.Start() 
} 
 
 
#---------------------------------------------- 
#region Generated Form Code 
$MainForm.Text = "PowerShell WebCam" 
$MainForm.Name = "MainForm" 
$MainForm.DataBindings.DefaultDataSourceUpdateMode = 0 
$System_Drawing_Size = New-Object System.Drawing.Size 
#$System_Drawing_Size.Width = 271 
#$System_Drawing_Size.Height = 172
$System_Drawing_Size.Width = 371 
$System_Drawing_Size.Height = 272 
$MainForm.ClientSize = $System_Drawing_Size 
 
$btnQuitApp.TabIndex = 5 
$btnQuitApp.Name = "btnQuitApp" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$btnQuitApp.Size = $System_Drawing_Size 
$btnQuitApp.UseVisualStyleBackColor = $True 
 
$btnQuitApp.Text = "Quit" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 12 
$System_Drawing_Point.Y = 137 
$btnQuitApp.Location = $System_Drawing_Point 
$btnQuitApp.DataBindings.DefaultDataSourceUpdateMode = 0 
$btnQuitApp.add_Click($handler_btnQuitApp_Click) 
 
$MainForm.Controls.Add($btnQuitApp) 
 
$btnCopyImage.TabIndex = 4 
$btnCopyImage.Name = "btnCopyImage" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$btnCopyImage.Size = $System_Drawing_Size 
$btnCopyImage.UseVisualStyleBackColor = $True 
 
$btnCopyImage.Text = "Copy" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 12 
$System_Drawing_Point.Y = 71 
$btnCopyImage.Location = $System_Drawing_Point 
$btnCopyImage.DataBindings.DefaultDataSourceUpdateMode = 0 
$btnCopyImage.add_Click($handler_btnCopyImage_Click) 
 
$MainForm.Controls.Add($btnCopyImage) 
 
$btnStopCam.TabIndex = 3 
$btnStopCam.Name = "btnStopCam" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$btnStopCam.Size = $System_Drawing_Size 
$btnStopCam.UseVisualStyleBackColor = $True 
 
$btnStopCam.Text = "Stop" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 13 
$System_Drawing_Point.Y = 108 
$btnStopCam.Location = $System_Drawing_Point 
$btnStopCam.DataBindings.DefaultDataSourceUpdateMode = 0 
$btnStopCam.add_Click($handler_btnStopCam_Click) 
 
$MainForm.Controls.Add($btnStopCam) 
 
$btnSelectDevice.TabIndex = 2 
$btnSelectDevice.Name = "btnSelectDevice" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$btnSelectDevice.Size = $System_Drawing_Size 
$btnSelectDevice.UseVisualStyleBackColor = $True 
 
$btnSelectDevice.Text = "Select Device" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 12 
$System_Drawing_Point.Y = 42 
$btnSelectDevice.Location = $System_Drawing_Point 
$btnSelectDevice.DataBindings.DefaultDataSourceUpdateMode = 0 
$btnSelectDevice.add_Click($handler_btnSelectDevice_Click) 
 
$MainForm.Controls.Add($btnSelectDevice) 
 
$cmbDevices.FormattingEnabled = $True 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 242 
$System_Drawing_Size.Height = 21 
$cmbDevices.Size = $System_Drawing_Size 
$cmbDevices.DataBindings.DefaultDataSourceUpdateMode = 0 
$cmbDevices.Name = "cmbDevices" 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 12 
$System_Drawing_Point.Y = 11 
$cmbDevices.Location = $System_Drawing_Point 
$cmbDevices.TabIndex = 1 
 
$MainForm.Controls.Add($cmbDevices) 
 
$picCapture.BackColor = [System.Drawing.Color]::FromArgb(255,0,0,0) 
$picCapture.TabIndex = 0 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 160 
$System_Drawing_Size.Height = 120
#$System_Drawing_Size.Width = 260 
#$System_Drawing_Size.Height = 220  
$picCapture.Size = $System_Drawing_Size 
$picCapture.BorderStyle = 2 
 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 94 
$System_Drawing_Point.Y = 42 
$picCapture.Location = $System_Drawing_Point 
 
 
$picCapture.TabStop = $False 
$picCapture.Name = "picCapture" 
$picCapture.DataBindings.DefaultDataSourceUpdateMode = 0 
 
$MainForm.Controls.Add($picCapture) 
 
#endregion Generated Form Code 
 
#Save the initial state of the form 
$InitialFormWindowState = $MainForm.WindowState 
#Init the OnLoad event to correct the initial state of the form 
$MainForm.add_Load($OnLoadForm_StateCorrection) 
#Show the Form 
$MainForm.ShowDialog()| Out-Null 
 
} #End Function 
 
 
 
Get-WebCamImage