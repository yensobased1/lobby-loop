"""Builds tests/upload_test.ahk from the real HttpUploadFile() in lobby_loop.ahk.
The test uploads a PNG + JSON to httpbin.org (which echoes the request back) and checks
that both arrive byte-for-byte. Run by GitHub Actions on Windows."""
import re, os, sys
src = open("lobby_loop.ahk", encoding="utf-8").read()
m = re.search(r"^HttpUploadFile\(.*?^\}\n", src, re.M | re.S)
if not m:
    sys.exit("HttpUploadFile() not found")
os.makedirs("tests", exist_ok=True)
test = r'''#Requires AutoHotkey v2.0
#NoTrayIcon
''' + m.group(0) + r'''
pic := A_ScriptDir "\..\lobby_loop_icon.png"
payload := '{"content":"upload test é ✓"}'
r := HttpUploadFile("https://httpbin.org/post", payload, pic)
size := FileGetSize(pic)
out := FileOpen("*", "w")
if (r.err != "") {
    out.Write("FAIL: " r.err "`n")
    ExitApp(1)
}
ok := r.status = 200
    && InStr(r.text, '"payload_json": "{\"content\":\"upload test')
    && InStr(r.text, '"files[0]": "data:application/octet-stream;base64,')
; httpbin returns the file as base64: check its length matches the real file
if RegExMatch(r.text, '"files\[0\]": "data:application/octet-stream;base64,([A-Za-z0-9+/=]+)"', &mm) {
    b64 := mm[1]
    pad := (SubStr(b64, -1) = "=") + (SubStr(b64, -2, 1) = "=")
    got := StrLen(b64) * 3 // 4 - pad
    ok := ok && (got = size)
    out.Write("file sent " size " bytes, received " got " bytes`n")
} else ok := false
out.Write((ok ? "PASS" : "FAIL") ": HTTP " r.status "`n")
ExitApp(ok ? 0 : 1)
'''
open("tests/upload_test.ahk", "w", encoding="utf-8").write(test)
print("wrote tests/upload_test.ahk")
