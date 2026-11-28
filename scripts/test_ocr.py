"""Builds tests/ocr_test.ahk from the real OcrImage() in lobby_loop.ahk and reads text
from assets/banner_flow.png on Windows. Run by GitHub Actions."""
import re, os, sys
src = open("lobby_loop.ahk", encoding="utf-8").read()
parts = []
for name in ["OcrImage", "WinRtFactory", "WinRtString", "WinRtTakeString", "WinRtWait", "WinRtClose"]:
    m = re.search(r"^" + name + r"\(.*?^\}\n", src, re.M | re.S)
    if not m:
        sys.exit(name + "() not found")
    parts.append(m.group(0))
os.makedirs("tests", exist_ok=True)
test = "#Requires AutoHotkey v2.0\n#NoTrayIcon\nLog(msg) => FileAppend(\"log: \" msg \"`n\", \"*\")\n" + "\n".join(parts) + r'''
img := A_ScriptDir "\..\assets\banner_flow.png"
all := ""
lines := OcrImage(img, &all)
out := FileOpen("*", "w")
out.Write(lines)
ok := InStr(all, "Lobby Loop") && InStr(all, "Treasure") && RegExMatch(lines, "m)^\d+\|\d+\|\d+\|\d+\|")
; second read of the same file proves the file was released (no lock left behind)
lines2 := OcrImage(img)
ok := ok && lines2 = lines
out.Write((ok ? "PASS" : "FAIL") ": " StrLen(lines) " chars read`n")
ExitApp(ok ? 0 : 1)
'''
open("tests/ocr_test.ahk", "w", encoding="utf-8").write(test)
print("wrote tests/ocr_test.ahk")
