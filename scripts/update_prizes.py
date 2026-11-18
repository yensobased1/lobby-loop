"""Reads this season's weekly prizes from fnchesttracker.com and updates treasure_words.txt.

Run by .github/workflows/weekly-prizes.yml. Safe by design: if the page can't be read or looks
wrong, the file is left alone (Lobby Loop keeps using last week's list).
"""
import datetime
import html
import re
import sys
import urllib.request

URL = "https://fnchesttracker.com/tracker"
FILE = "treasure_words.txt"
TYPES = ["outfit", "pickaxe", "back bling", "jam track", "loading screen", "car", "glider", "emote",
         "wrap", "contrail", "banner", "spray", "music", "body", "vehicle", "decal", "wheels"]


def fetch():
    req = urllib.request.Request(URL, headers={"User-Agent": "lobby-loop-prize-sync (github.com/yensobased1/lobby-loop)"})
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read().decode("utf-8", "replace")


def tokens(page):
    page = re.sub(r"(?is)<(script|style|svg|noscript)\b.*?</\1>", " ", page)
    parts = re.split(r"<[^>]+>", page)
    out = []
    for p in parts:
        t = html.unescape(re.sub(r"\s+", " ", p)).strip()
        if t:
            out.append(t)
    return out


def is_type(t):
    low = t.lower().rstrip(".…")
    return any(low == ty or low.startswith(ty) for ty in TYPES)


def parse(toks):
    weeks, current, week = {}, None, None
    for i, t in enumerate(toks):
        m = re.fullmatch(r"Week\s+(\d{1,2})", t, re.I)
        if m:
            week = int(m.group(1))
            weeks.setdefault(week, [])
            continue
        if t.lower() == "this week" and week:
            current = week
            continue
        if week and is_type(t) and i > 0:
            name = toks[i - 1]
            if 2 <= len(name) <= 60 and not is_type(name) and not re.fullmatch(r"Week\s+\d+|Found.*|This week", name, re.I):
                typ = t.split(",")[0].rstrip(".… ")
                if typ.lower().startswith("body"):
                    typ = "Car"
                if name not in [n for n, _ in weeks[week]]:
                    weeks[week].append((name, typ[:1].upper() + typ[1:]))
    weeks = {w: v for w, v in weeks.items() if len(v) >= 3}
    if weeks and not current:
        current = max(weeks)
    return weeks, current


def main():
    try:
        weeks, current = parse(tokens(fetch()))
    except Exception as e:  # network or page change: keep the old file
        print("Couldn't read the page:", e)
        return 0
    if not weeks or not current:
        print("No prize weeks found, leaving the file alone.")
        return 0
    lines = open(FILE, encoding="utf-8").read().splitlines()
    vals = {}
    for ln in lines:
        m = re.match(r"^(\w+)=(.*)$", ln)
        if m:
            vals[m.group(1)] = m.group(2)
    old_weeks = int(vals.get("week", "0") or 0)
    if current < old_weeks:
        print("The page shows an older week than the file, leaving it alone.")
        return 0
    new = {"week": str(current)}
    for w, items in sorted(weeks.items()):
        new[f"prizes_{w}"] = ";".join(f"{n.replace(';', ',').replace('|', '/')}|{t}" for n, t in items)
    words = [w for w in vals.get("cosmetic", "SOLID GOLD").split(",") if w]
    for items in weeks.values():
        for n, _ in items:
            u = n.upper()
            u = u.replace("SOLID GOLD ", "")
            if len(u) >= 4 and u not in words and "SOLID GOLD" not in u:
                words.append(u)
    if "SOLID GOLD" not in words:
        words.insert(0, "SOLID GOLD")
    new["cosmetic"] = ",".join(words)
    changed = any(vals.get(k) != v for k, v in new.items())
    if not changed:
        print("Already up to date.")
        return 0
    new["version"] = datetime.date.today().isoformat() + "-auto"
    out, done = [], set()
    for ln in lines:
        m = re.match(r"^(\w+)=", ln)
        if m and m.group(1) in new:
            out.append(f"{m.group(1)}={new[m.group(1)]}")
            done.add(m.group(1))
        elif m and m.group(1).startswith("prizes_") and m.group(1) not in new:
            out.append(ln)  # keep weeks the page no longer shows
        else:
            out.append(ln)
    for k, v in new.items():
        if k not in done:
            out.append(f"{k}={v}")
    open(FILE, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
    print("Updated to week", current, "with", sum(len(v) for v in weeks.values()), "prizes")
    return 0


if __name__ == "__main__":
    sys.exit(main())
