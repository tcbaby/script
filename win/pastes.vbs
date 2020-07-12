Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.AppActivate "String"
for i=1 to 22 
WScript.Sleep 99
WshShell.SendKeys "^v"
' WshShell.SendKeys i
WshShell.SendKeys "%s"
Next

' 打印: ctrl+v, enter