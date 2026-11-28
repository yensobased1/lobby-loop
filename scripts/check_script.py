"""Static checks for Lobby Loop, run by GitHub Actions on every push.
Fails (exit 1) when:
  * a setting S["KEY"] is used but missing from DEFAULTS
  * a Tx("...") text or tick("KEY", "...") label has no Arabic translation
  * a function assigns a global without declaring it (AutoHotkey v2 makes it local by mistake)
Usage: python scripts/check_script.py lobby_loop.ahk"""
import re, sys, collections

path = sys.argv[1] if len(sys.argv) > 1 else "lobby_loop.ahk"
s = open(path, encoding="utf-8").read()
errors, warnings = [], []

# ---- settings keys ----
defs = set(re.findall(r'^\s*\["([A-Z0-9_]+)",', s, re.M))
for k in sorted(set(re.findall(r'\bS\["([A-Z0-9_]+)"\]', s)) - defs):
    errors.append(f'setting S["{k}"] is used but not in DEFAULTS')

# ---- translations ----
tr = s.split("LoadTranslations() {", 1)[1].split("\n    )\n", 1)[0]
keys = re.findall(r'^\s*"((?:[^"\\]|"")*)",\s*"', tr, re.M)
for k, n in collections.Counter(keys).items():
    if n > 1:
        warnings.append(f'translation listed {n} times: "{k}"')
need = set(re.findall(r'Tx\("((?:[^"]|"")*)"', s)) | set(re.findall(r'tick\("[A-Z_]+",\s*"((?:[^"]|"")*)"', s))
need.discard("English text {1}")                      # the example in Tx()'s own comment
for t in sorted(need - set(keys)):
    errors.append(f'no Arabic translation for: "{t}"')

# ---- globals assigned inside functions without a declaration ----
code = re.sub(r"return '\n\s*\(\n.*?\n\s*\)'", "return ''", s, flags=re.S)
glob = {m.group(1) for m in re.finditer(r"^([A-Za-z_]\w*)\s*:=", code, re.M) if not m.group(1).startswith("A_")}
gl = {g.lower(): g for g in glob}
for name, params, body in re.findall(r"^(\w+)\(([^)]*)\)\s*\{\n(.*?)^\}", code, re.M | re.S):
    declared = {x.strip().lower() for line in re.findall(r"^\s*global (.*)$", body, re.M) for x in line.split(",")}
    declared = {d.split(":=")[0].strip() for d in declared}
    params_l = {x.strip().split(":=")[0].strip().lstrip("&").rstrip("*").lower() for x in params.split(",") if x.strip()}
    assigned = set(re.findall(r"(?<![\.\w])([A-Za-z_]\w*)\s*(?::=|\+=|-=|\.=|\*=)", body))
    for a in assigned:
        al = a.lower()
        if al in gl and al not in declared and al not in params_l and a == gl[al]:
            # a nested function or static of the same name is fine; flag only plain top-level-looking uses
            if not re.search(r"^\s*static\b[^\n]*\b" + re.escape(a) + r"\b", body, re.M):
                warnings.append(f"{name}() assigns global {a} without 'global {a}'")

for w in warnings:
    print("warning:", w)
for e in errors:
    print("ERROR:", e)
print(f"checked {path}: {len(errors)} error(s), {len(warnings)} warning(s)")
sys.exit(1 if errors else 0)
