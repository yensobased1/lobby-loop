"""Lobby Loop README banners, drawn from scratch as SVG and rendered to PNG (2x).
Run: python3 assets/make_banners.py   (needs cairosvg)"""
import base64, os, sys
import cairosvg
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "icons"))
from icons import ICONS

BG1, BG2 = "#14103A", "#2A1A80"
NEON, NEON2 = "#F2F542", "#C9F23A"
INK, MUTED = "#FFFFFF", "#B9B4E8"
CARD = "#1F1950"
TITLE_FONT = "Poppins, 'Inter Display', sans-serif"
BODY_FONT = "Inter, sans-serif"

def icon(name, x, y, size, color, stroke=2):
    s = size / 24
    body = ICONS[name].replace('fill="C"', f'fill="{color}"')
    return (f'<g transform="translate({x},{y}) scale({s})" fill="none" stroke="{color}" '
            f'stroke-width="{stroke}" stroke-linecap="round" stroke-linejoin="round">{body}</g>')

def esc(t):
    return t.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

def defs():
    return f'''<defs>
  <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="{BG1}"/><stop offset="1" stop-color="{BG2}"/></linearGradient>
  <radialGradient id="glow" cx=".5" cy=".5" r=".5"><stop offset="0" stop-color="#6B4BFF" stop-opacity=".55"/><stop offset="1" stop-color="#6B4BFF" stop-opacity="0"/></radialGradient>
  <radialGradient id="glowY" cx=".5" cy=".5" r=".5"><stop offset="0" stop-color="{NEON}" stop-opacity=".22"/><stop offset="1" stop-color="{NEON}" stop-opacity="0"/></radialGradient>
  <linearGradient id="neon" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="{NEON}"/><stop offset="1" stop-color="{NEON2}"/></linearGradient>
  <linearGradient id="gold" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#FFE27A"/><stop offset="1" stop-color="#E8A417"/></linearGradient>
  <pattern id="dots" width="22" height="22" patternUnits="userSpaceOnUse"><circle cx="2" cy="2" r="1.2" fill="#FFFFFF" fill-opacity=".06"/></pattern>
  <filter id="soft" x="-20%" y="-20%" width="140%" height="140%"><feGaussianBlur stdDeviation="10"/></filter>
</defs>'''

def sparkle(x, y, r, color=NEON, op=1):
    return (f'<path transform="translate({x},{y})" fill="{color}" fill-opacity="{op}" '
            f'd="M0 {-r} C{r*.18} {-r*.18} {r*.18} {-r*.18} {r} 0 C{r*.18} {r*.18} {r*.18} {r*.18} 0 {r} '
            f'C{-r*.18} {r*.18} {-r*.18} {r*.18} {-r} 0 C{-r*.18} {-r*.18} {-r*.18} {-r*.18} 0 {-r}Z"/>')

def pill(x, y, text, fill="#FFFFFF", fop=.08, color=INK, size=15, pad=14, h=32, weight=600, stroke=None):
    w = len(text) * size * .58 + pad * 2
    st = f' stroke="{stroke}" stroke-width="1.5"' if stroke else ""
    return (f'<rect x="{x}" y="{y}" width="{w:.0f}" height="{h}" rx="{h/2}" fill="{fill}" fill-opacity="{fop}"{st}/>'
            f'<text x="{x + w/2:.0f}" y="{y + h/2 + size*.36:.1f}" text-anchor="middle" font-family="{BODY_FONT}" '
            f'font-size="{size}" font-weight="{weight}" fill="{color}">{esc(text)}</text>'), w

def frame(w, h, inner, rx=28):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="{w}" height="{h}" viewBox="0 0 {w} {h}">'
            f'{defs()}<clipPath id="clip"><rect width="{w}" height="{h}" rx="{rx}"/></clipPath><g clip-path="url(#clip)">'
            f'<rect width="{w}" height="{h}" fill="url(#bg)"/><rect width="{w}" height="{h}" fill="url(#dots)"/>{inner}</g>'
            f'<rect x="1" y="1" width="{w-2}" height="{h-2}" rx="{rx-1}" fill="none" stroke="#FFFFFF" stroke-opacity=".10" stroke-width="2"/></svg>')

def save(name, svg, w):
    with open(os.path.join(HERE, name + ".svg"), "w", encoding="utf-8") as f:
        f.write(svg)
    cairosvg.svg2png(bytestring=svg.encode(), write_to=os.path.join(HERE, name + ".png"), output_width=w * 2)
    os.remove(os.path.join(HERE, name + ".svg"))
    print("made", name)

# ---------------------------------------------------------------- hero
def hero():
    W, H = 1280, 440
    logo = base64.b64encode(open(os.path.join(HERE, "..", "lobby_loop_icon.png"), "rb").read()).decode()
    p = []
    p.append(f'<circle cx="200" cy="220" r="260" fill="url(#glow)"/><circle cx="1040" cy="230" r="300" fill="url(#glow)"/>')
    p.append(f'<circle cx="200" cy="220" r="170" fill="url(#glowY)"/>')
    # loop ring decoration
    p.append('<circle cx="200" cy="220" r="150" fill="none" stroke="#FFFFFF" stroke-opacity=".07" stroke-width="2"/>'
             '<circle cx="200" cy="220" r="185" fill="none" stroke="#FFFFFF" stroke-opacity=".04" stroke-width="2"/>')
    p.append(f'<clipPath id="logoclip"><rect x="80" y="100" width="240" height="240" rx="54"/></clipPath>'
             f'<image x="80" y="100" width="240" height="240" clip-path="url(#logoclip)" xlink:href="data:image/png;base64,{logo}"/>'
             f'<rect x="80" y="100" width="240" height="240" rx="54" fill="none" stroke="{NEON}" stroke-opacity=".35" stroke-width="2"/>')
    p += [sparkle(345, 92, 13), sparkle(70, 360, 8, op=.8), sparkle(705, 70, 7, op=.5), sparkle(1220, 395, 9, op=.6)]
    # title
    p.append(f'<text x="380" y="168" font-family="{TITLE_FONT}" font-size="76" font-weight="800" fill="{INK}" letter-spacing="-1.5">Lobby <tspan fill="url(#neon)">Loop</tspan></text>')
    p.append(f'<text x="383" y="214" font-family="{BODY_FONT}" font-size="26" font-weight="600" fill="{INK}">Your squad farms the chests. You bot.</text>')
    p.append(f'<text x="383" y="250" font-family="{BODY_FONT}" font-size="18" fill="{MUTED}">AFK helper for Fortnite squad fills, made for overnight runs.</text>')
    x = 383
    for t, hl in [("v7.9.1", True), ("Free", False), ("Windows 10 / 11", False), ("English · Arabic", False)]:
        s, w = pill(x, 285, t, fill=NEON if hl else "#FFFFFF", fop=1 if hl else .08, color=BG1 if hl else INK, size=14)
        p.append(s); x += w + 10
    # keys row
    x = 383
    for k, t in [("F8", "start / stop"), ("F12", "settings"), ("F6", "dim screen")]:
        p.append(f'<rect x="{x}" y="343" width="46" height="34" rx="8" fill="#FFFFFF" fill-opacity=".1" stroke="#FFFFFF" stroke-opacity=".25"/>'
                 f'<text x="{x+23}" y="366" text-anchor="middle" font-family="{BODY_FONT}" font-size="15" font-weight="700" fill="{INK}">{k}</text>'
                 f'<text x="{x+56}" y="366" font-family="{BODY_FONT}" font-size="15" fill="{MUTED}">{t}</text>')
        x += 56 + len(t) * 8.5 + 28
    # status box mock
    bx, by, bw, bh = 950, 92, 290, 262
    p.append(f'<rect x="{bx+8}" y="{by+14}" width="{bw}" height="{bh}" rx="18" fill="#000" fill-opacity=".35" filter="url(#soft)"/>')
    p.append(f'<rect x="{bx}" y="{by}" width="{bw}" height="{bh}" rx="18" fill="#15152B" stroke="{NEON}" stroke-opacity=".55" stroke-width="1.5"/>')
    p.append(f'<circle cx="{bx+26}" cy="{by+32}" r="7" fill="#3BE37A"/><circle cx="{bx+26}" cy="{by+32}" r="12" fill="#3BE37A" fill-opacity=".2"/>')
    p.append(f'<text x="{bx+44}" y="{by+38}" font-family="{BODY_FONT}" font-size="17" font-weight="700" fill="{INK}">Running · 6h 42m</text>')
    p.append(f'<text x="{bx+24}" y="{by+66}" font-family="{BODY_FONT}" font-size="13.5" fill="{MUTED}">Squad · Zero Build · Fill</text>')
    rows = [("refresh", "Match 23 · back in the lobby"), ("people", "Teammates farming chests"), ("chest", "Treasure found: 3"), ("clock", "Stops at 8:00 AM")]
    for i, (ic, t) in enumerate(rows):
        yy = by + 92 + i * 36
        p.append(icon(ic, bx + 22, yy, 20, NEON if ic == "chest" else "#C9CBE6"))
        p.append(f'<text x="{bx+54}" y="{yy+15}" font-family="{BODY_FONT}" font-size="15" fill="{INK}">{esc(t)}</text>')
    p.append(f'<rect x="{bx+22}" y="{by+bh-24}" width="{bw-44}" height="6" rx="3" fill="#FFFFFF" fill-opacity=".1"/>'
             f'<rect x="{bx+22}" y="{by+bh-24}" width="{(bw-44)*.68:.0f}" height="6" rx="3" fill="url(#neon)"/>')
    save("banner_hero", frame(W, H, "".join(p)), W)

# ---------------------------------------------------------------- feature cards
def card(name, ic, title, lines, visual):
    W, H = 620, 300
    p = [f'<circle cx="560" cy="250" r="220" fill="url(#glow)"/>']
    p.append(f'<rect x="36" y="36" width="64" height="64" rx="18" fill="{NEON}"/>')
    p.append(icon(ic, 50, 50, 36, BG1, 2.2))
    p.append(f'<text x="120" y="80" font-family="{TITLE_FONT}" font-size="30" font-weight="700" fill="{INK}">{esc(title)}</text>')
    for i, l in enumerate(lines):
        p.append(f'<text x="38" y="{138 + i*26}" font-family="{BODY_FONT}" font-size="17" fill="{MUTED}">{esc(l)}</text>')
    p.append(visual)
    save(name, frame(W, H, "".join(p), 24), W)

def chip(x, y, text, on=False, w=None, size=14):
    w = w or len(text) * size * .6 + 28
    fill, col, op = (NEON, BG1, 1) if on else ("#FFFFFF", INK, .09)
    return (f'<rect x="{x}" y="{y}" width="{w:.0f}" height="34" rx="10" fill="{fill}" fill-opacity="{op}"/>'
            f'<text x="{x + w/2:.0f}" y="{y+22}" text-anchor="middle" font-family="{BODY_FONT}" font-size="{size}" font-weight="700" fill="{col}">{esc(text)}</text>'), w

def arrow(x1, y, x2):
    return (f'<path d="M{x1} {y}H{x2}" stroke="{NEON}" stroke-width="2.5" stroke-linecap="round"/>'
            f'<path d="M{x2-6} {y-5}L{x2} {y}L{x2-6} {y+5}" fill="none" stroke="{NEON}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>')

def v_queue():
    p, x = [], 38
    for i, t in enumerate(["Lobby", "Ready", "Match", "Play Again"]):
        s, w = chip(x, 222, t, on=(i == 3)); p.append(s)
        if i < 3: p.append(arrow(x + w + 6, 239, x + w + 30))
        x += w + 36
    p.append(f'<path d="M{x-20} 262 q0 22 -30 22 H70 q-30 0 -30 -22" fill="none" stroke="{NEON}" stroke-opacity=".45" stroke-width="2" stroke-dasharray="5 6"/>')
    return "".join(p)

def v_treasure():
    x, y = 270, 184
    return (f'<rect x="{x}" y="{y}" width="318" height="92" rx="16" fill="#120E30" stroke="url(#gold)" stroke-width="2"/>'
            f'<text x="{x+92}" y="{y+36}" font-family="{BODY_FONT}" font-size="13" font-weight="800" letter-spacing="2" fill="#FFD45A">YOU FOUND</text>'
            f'<text x="{x+92}" y="{y+62}" font-family="{TITLE_FONT}" font-size="18" font-weight="700" fill="{INK}">Pirate Shop Access</text>'
            f'<text x="{x+92}" y="{y+82}" font-family="{BODY_FONT}" font-size="12.5" fill="{MUTED}">saved · claimed · sent to Discord</text>'
            f'<circle cx="{x+48}" cy="{y+48}" r="30" fill="url(#gold)"/>' + icon("compass", x + 30, y + 30, 36, "#5A3A00", 2.4)
            + sparkle(x + 306, y - 6, 9, "#FFD45A"))

def v_phone():
    x, y = 380, 150
    return (f'<rect x="{x}" y="{y}" width="200" height="132" rx="24" fill="#0E0B26" stroke="#FFFFFF" stroke-opacity=".2" stroke-width="2"/>'
            f'<rect x="{x+68}" y="{y+10}" width="54" height="6" rx="3" fill="#FFFFFF" fill-opacity=".2"/>'
            f'<rect x="{x+96}" y="{y+24}" width="88" height="28" rx="12" fill="#5865F2"/>'
            f'<text x="{x+140}" y="{y+43}" text-anchor="middle" font-family="DejaVu Sans Mono, monospace" font-size="14" font-weight="700" fill="#fff">!status</text>'
            f'<rect x="{x+14}" y="{y+62}" width="172" height="56" rx="12" fill="#FFFFFF" fill-opacity=".09"/>'
            f'<text x="{x+26}" y="{y+84}" font-family="{BODY_FONT}" font-size="13" font-weight="700" fill="{NEON}">Lobby Loop</text>'
            f'<text x="{x+26}" y="{y+105}" font-family="{BODY_FONT}" font-size="13" fill="{INK}">running 6h, 23 matches</text>')

def v_remote():
    x, y = 250, 182
    s1, w1 = chip(x, y, "Parsec"); s2, w2 = chip(x + w1 + 10, y, "AnyDesk")
    return (s1 + s2 +
            f'<rect x="{x}" y="{y+48}" width="330" height="44" rx="12" fill="#15152B" stroke="{NEON}" stroke-opacity=".5"/>'
            + icon("phone", x + 16, y + 58, 22, NEON) +
            f'<text x="{x+48}" y="{y+76}" font-family="{BODY_FONT}" font-size="15" font-weight="600" fill="{INK}">You\'re in control · back in 45s</text>')

def v_safety():
    items = ["Wakes Fortnite from Sleep Mode", "Clicks error popups", "Waits out server downtime", "Reopens Fortnite after a crash"]
    p = []
    for i, t in enumerate(items):
        x, y = 38 + (i % 2) * 290, 214 + (i // 2) * 40
        p.append(f'<circle cx="{x+11}" cy="{y+11}" r="11" fill="{NEON}"/><path d="M{x+6} {y+11}l3.5 3.5 6.5-7" fill="none" stroke="{BG1}" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"/>'
                 f'<text x="{x+30}" y="{y+17}" font-family="{BODY_FONT}" font-size="15" fill="{INK}">{esc(t)}</text>')
    return "".join(p)

def v_stats():
    p = []
    vals = [5, 8, 6, 11, 9, 14, 12]
    for i, v in enumerate(vals):
        h = v * 7
        p.append(f'<rect x="{380 + i*28}" y="{282 - h}" width="18" height="{h}" rx="5" fill="{NEON if i == 5 else "#FFFFFF"}" fill-opacity="{1 if i == 5 else .18}"/>')
    rows = [("1", "you", "142"), ("2", "zen", "117"), ("3", "friend", "96")]
    for i, (r, n, m) in enumerate(rows):
        y = 214 + i * 26
        p.append(f'<text x="40" y="{y}" font-family="{BODY_FONT}" font-size="15" font-weight="800" fill="{NEON if i == 0 else MUTED}">#{r}</text>'
                 f'<text x="78" y="{y}" font-family="{BODY_FONT}" font-size="15" fill="{INK}">{n}</text>'
                 f'<text x="300" y="{y}" text-anchor="end" font-family="{BODY_FONT}" font-size="15" font-weight="600" fill="{INK}">{m} matches</text>')
    return "".join(p)

# ---------------------------------------------------------------- how it works
def flow():
    W, H = 1280, 250
    p = [f'<circle cx="640" cy="125" r="420" fill="url(#glow)"/>',
         f'<text x="640" y="56" text-anchor="middle" font-family="{TITLE_FONT}" font-size="28" font-weight="700" fill="{INK}">How a night with Lobby Loop goes</text>']
    steps = [("gamepad", "Lobby", "checks your mode"), ("playcircle", "Ready up", "squad fill"), ("people", "Match", "team farms, you idle"),
             ("chest", "Treasure", "screenshot + claim"), ("refresh", "Play again", "until your timer")]
    n, cw, gap = len(steps), 196, 46
    x0 = (W - (n * cw + (n - 1) * gap)) / 2
    for i, (ic, t, sub) in enumerate(steps):
        x = x0 + i * (cw + gap)
        on = i == 3
        p.append(f'<rect x="{x}" y="86" width="{cw}" height="120" rx="20" fill="{CARD}" stroke="{NEON if on else "#FFFFFF"}" stroke-opacity="{.8 if on else .12}" stroke-width="2"/>')
        p.append(f'<circle cx="{x+cw/2}" cy="122" r="22" fill="{NEON}" fill-opacity="{1 if on else .14}"/>')
        p.append(icon(ic, x + cw/2 - 13, 109, 26, BG1 if on else NEON, 2.2))
        p.append(f'<text x="{x+cw/2}" y="168" text-anchor="middle" font-family="{TITLE_FONT}" font-size="19" font-weight="700" fill="{INK}">{t}</text>'
                 f'<text x="{x+cw/2}" y="190" text-anchor="middle" font-family="{BODY_FONT}" font-size="14" fill="{MUTED}">{sub}</text>')
        if i < n - 1:
            p.append(arrow(x + cw + 8, 146, x + cw + gap - 8))
    p.append(f'<path d="M{x0 + (n-1)*(cw+gap) + cw/2} 206 v18 H{x0 + cw/2} v-18" fill="none" stroke="{NEON}" stroke-opacity=".45" stroke-width="2" stroke-dasharray="5 6"/>')
    save("banner_flow", frame(W, H, "".join(p)), W)

hero()
card("feature_queue", "refresh", "Auto queue", ["Readies up in the mode you pick, clicks Play Again", "and keeps you in squad fills all night."], v_queue())
card("feature_treasure", "gem", "Treasure watcher", ["Spots gizmos, treasure and Pirate Shop Access,", "screenshots the proof and claims it."], v_treasure())
card("feature_phone", "phonebell", "Phone control", ["30+ Discord commands: start, stop, status,", "screenshots, settings and more."], v_phone())
card("feature_remote", "monitor", "Remote play", ["Steps aside when you take over from", "your phone, then carries on by itself."], v_remote())
card("feature_safety", "shield", "Overnight safety", ["Recovers from the stuff that usually", "ends an AFK night early."], v_safety())
card("feature_stats", "trophy", "Stats & leaderboard", ["Match history, a dashboard and", "a friends leaderboard on Discord."], v_stats())
flow()
