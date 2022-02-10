'This program check whether webcam is available or not
' if available then capture and displays in picture box

'Created by Dixanta Bahadur Shrestha
'Created Date: 12-March-2006

'Programmer does not garuntees if  not functions well

Global Const ws_child As Long = &H40000000
Global Const ws_visible As Long = &H10000000

Global Const WM_USER = 1024
Global Const wm_cap_driver_connect = WM_USER + 10
Global Const wm_cap_set_preview = WM_USER + 50
Global Const WM_CAP_SET_PREVIEWRATE = WM_USER + 52
Global Const WM_CAP_DRIVER_DISCONNECT As Long = WM_USER + 11
Global Const WM_CAP_DLG_VIDEOFORMAT As Long = WM_USER + 41
Declare Function SendMessage Lib "user32" Alias "SendMessageA" (
    ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, 
    ByVal lParam As Long) As Long
Declare Function capCreateCaptureWindow Lib "avicap32.dll" Alias 
    "capCreateCaptureWindowA" (
    ByVal a As String, ByVal b As Long, ByVal c As Integer, 
    ByVal d As Integer, ByVal e As Integer, ByVal f As Integer, 
    ByVal g As Long, ByVal h As Integer) As Long


 

Dim hwdc As Long
Dim startcap As Boolean
Private Sub cmdCapture_Click()
Dim temp As Long

  hwdc = capCreateCaptureWindow("Dixanta Vision System", 
      ws_child Or ws_visible, 0, 0, 320, 240, Picture1.hWnd, 0)
  If (hwdc <> 0) Then
    temp = SendMessage(hwdc, wm_cap_driver_connect, 0, 0)
    temp = SendMessage(hwdc, wm_cap_set_preview, 1, 0)
    temp = SendMessage(hwdc, WM_CAP_SET_PREVIEWRATE, 30, 0)
    startcap = True
    Else
    MsgBox ("No Webcam found")
  End If
End Sub

Private Sub cmdClose_Click()
Dim temp As Long
If startcap = True Then
temp = SendMessage(hwdc, WM_CAP_DRIVER_DISCONNECT, 0&, 0&)
startcap = False
End If
End Sub

Private Sub cmdVideoFormat_Click()
 Dim temp As Long
 If startcap = True Then
  temp = SendMessage(hwdc, WM_CAP_DLG_VIDEOFORMAT, 0&, 0&)
End If
End Sub