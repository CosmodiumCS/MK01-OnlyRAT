Set ws = CreateObject("wscript.shell")

wscript.sleep(1000)
ws.sendkeys("%y")
wscript.sleep(500)
ws.sendkeys("%y")
wscript.sleep(500)
ws.sendkeys("{ENTER}")