//gcc -o snapz.exe snapz.c -lvfw32
// snapz.exe - a command line cam image grabber
// Written by Ted Burke, Last updated 5-4-2011
// ted.burke@dit.ie, batchloaf.wordpress.com
//
// To compile with MinGW:
//	gcc -o snapz.exe snapz.c -lvfw32
//

#include <windows.h>
#include <vfw.h>
#include <stdio.h>

// Window handles
HWND hWnd;
HWND hWndCap;

int capture_w = 640;
int capture_h = 480;
int capture_device = 0;	// default capture device
int time_delay = 0;	// delay in ms before snapshot
int preview_video = 0;	// Don't show on screen

// Message handling function
LRESULT CALLBACK WndProc(
    HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
    switch(msg)
    {
    case WM_TIMER:
        // Save DIB snapshot, then exit from program
        capGrabFrame(hWndCap);
        capFileSaveDIB (hWndCap, "snapz.dib");
        DestroyWindow(hWnd);
        break;
    case WM_CLOSE:
        DestroyWindow(hWnd);
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, msg, wParam, lParam);
    }
    return 0;
}

int WINAPI WinMain(
    HINSTANCE hInstance, HINSTANCE hPrevInstance,
    LPSTR lpCmdLine, int nCmdShow)
{
    // Register window class
    WNDCLASSEX wc;
    wc.cbSize        = sizeof(WNDCLASSEX);
    wc.style         = 0;
    wc.lpfnWndProc   = WndProc;
    wc.cbClsExtra    = 0;
    wc.cbWndExtra    = 0;
    wc.hInstance     = hInstance;
    wc.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
    wc.hCursor       = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
    wc.lpszMenuName  = NULL;
    wc.lpszClassName = "snapzWindowClass";
    wc.hIconSm       = LoadIcon(NULL, IDI_APPLICATION);
    if(!RegisterClassEx(&wc))
        fprintf(stderr, "Window Registration Failed!");

    // Create main window
    hWnd = CreateWindowEx(
        WS_EX_CLIENTEDGE,
        "snapzWindowClass",
        "snapz",
        WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, CW_USEDEFAULT,
        capture_w + 100, capture_h + 100,
        NULL, NULL, hInstance, NULL);
    if (hWnd == NULL)
        fprintf(stderr, "Couldn't create main window.");

    // Create capture window
    hWndCap = capCreateCaptureWindow(
        NULL, WS_CHILD,
        0, 0, capture_w, capture_h,
        hWnd, 0);
    if (hWndCap == NULL)
        fprintf(stderr, "Couldn't create capture window.");

    // Connect to capture driver and set resolution
    capDriverConnect(hWndCap, capture_device);
    DWORD dwSize = capGetVideoFormatSize(hWndCap);
    LPBITMAPINFO lpbi = (LPBITMAPINFO)malloc(dwSize);
    capGetVideoFormat(hWndCap, lpbi, dwSize);
    lpbi->bmiHeader.biWidth = capture_w;
    lpbi->bmiHeader.biHeight = capture_h;
    capSetVideoFormat(hWndCap, lpbi, dwSize);
    free(lpbi);

    // Initialise and start video preview
    if (preview_video > 0)
    {
        // Set up video preview
        capPreviewRate(hWndCap, 1); // rate in ms
        capPreview(hWndCap, TRUE);
        ShowWindow(hWndCap, SW_SHOW);

        //Show main window
        ShowWindow(hWnd, nCmdShow);
        UpdateWindow(hWnd);
    }

    // Set timer to trigger snapshot
    SetTimer(hWnd, 1, time_delay, NULL);

    // Message loop
    MSG msg;
    while(GetMessage(&msg, NULL, 0, 0) > 0)
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    // Tidy up video capture stuff
    KillTimer(hWnd, 1);
    capPreview(hWndCap, FALSE);
    capDriverDisconnect(hWndCap);
    if (hWndCap) DestroyWindow(hWndCap);

    return msg.wParam;
}