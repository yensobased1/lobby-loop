#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook True
;@Ahk2Exe-SetName Lobby Loop
;@Ahk2Exe-SetDescription Lobby Loop
;@Ahk2Exe-SetVersion 7.6.0
;@Ahk2Exe-SetMainIcon lobby_loop.ico
;@Ahk2Exe-UpdateManifest 1
InstallKeybdHook()
SetWorkingDir(A_ScriptDir)
SendMode("Event")
CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")
CoordMode("ToolTip", "Screen")

TITLE := "Lobby Loop"
VERSION := "7.6"

; Auto-update link (the raw link to version.txt on GitHub). Can also be set in the settings file.
UPDATE_URL_DEFAULT := "https://raw.githubusercontent.com/yensobased1/lobby-loop/main/version.txt"
; Picture used for the Discord bot
ICON_URL := "https://raw.githubusercontent.com/yensobased1/lobby-loop/main/lobby_loop_icon.png"

CHANGELOG := [
    "v7.6  (18 Nov 2026)",
    "  Lobby Loop is made for AFKing in squad fills: your teammates farm chests",
    "  for you while you bot.",
    "  + Settings > Mode: pick Solo / Duo / Trio / Squad, Build / Zero Build and",
    "    Fill / No fill. It checks the lobby before readying up (and can try to switch)",
    "  + Settings > Squad fill: stop moving while spectating, reward clicks",
    "  + Settings > Treasure (its own section): Pirate Shop Access, gizmos and weekly",
    "    treasure cosmetics. Only counts when Fortnite's YOU FOUND banner is on screen,",
    "    so season words like Treasure Hunters don't set it off. Sound, screenshot and",
    "    a clip of the 20 seconds before + 5 seconds after",
    "  + Doesn't click Play Again while your teammates are still playing, so you keep",
    "    the treasure they find",
    "  + Settings > Look: show or hide the status box (F10 does the same, and it's remembered)",
    "  + Fortnite Sleep Mode: clicks Keep Playing by itself, and gives the camera a tiny",
    "    nudge every 4 minutes while it's standing still so Fortnite doesn't fall asleep",
    "  + Clips go to Discord by themselves when they're under 10 MB",
    "  + Read the screen now: shows what Lobby Loop sees, to tune the words",
    "  + Extras: keep the PC awake, stop after X matches, Fortnite volume,",
    "    hide the status box from streams",
    "  + Bigger Settings window with 12 sections",
    "  + New phone commands: !mode !clip !read",
    "",
    "v7.5  (18 Nov 2026)",
    "  + Screen reader: knows when you're spectating and stops moving",
    "  + Treasure watcher: spots Sprite gizmos, pirate tokens and other treasure,",
    "    counts them and tells Discord (with a screenshot)",
    "  + Clicks reward buttons by itself (Continue, Collect, Claim...)",
    "  + Status box: mini style and accent colours (Settings > Look)",
    "  + Live stats dashboard that refreshes while it runs",
    "  + Settings > Popups: see and forget taught popup buttons (or Shift+F7)",
    "  + Settings > Share & tools: settings code, report a bug, install, uninstall",
    "  + Safe mode after a crash (extras off for that session)",
    "  + Discord control panel: tap reactions to start, stop, screenshot",
    "  + Live status message that shows when the PC went offline",
    "  + 20 new phone commands (type !help)",
    "",
    "v7.2  (17 Nov 2026)",
    "  + New status box: rounded card, status light (green running, amber paused,",
    "    grey off), stop-timer progress bar, last placement and XP",
    "  + Drag the status box anywhere (tray > Move status box)",
    "  + Tray > Stop timer: one click for 30 min, 1, 2, 4 or 8 hours",
    "  + Hover the tray icon to see the status",
    "  + Windows notifications when it stops, gets stuck or Fortnite crashes",
    "  + Self-test shows a card with a tick or cross for each check",
    "  + Tray > Keyboard shortcuts",
    "  + Discord: !timer 2h / !timer 9:30pm / !timer off and !profile overnight",
    "",
    "v7.1  (17 Nov 2026)",
    "  + Dark mode (Settings > Look), with a dark title bar",
    "  + New Settings window: sidebar with sections (Play, Schedule, Extras,",
    "    Discord alerts, Phone control, Look)",
    "  + Step-by-step guides for the Discord webhook and the phone-control bot",
    "  + Status box corner and size can be changed in Settings > Look",
    "  + Hotkeys section in Settings: change Lobby Loop's keys and your Fortnite keys",
    "  + Setup wizard and What's new use the same theme",
    "",
    "v7.0.2  (17 Nov 2026)",
    "  * Settings window: fixed overlapping columns and cut-off text",
    "  * Status box shows again (it was hidden on some PCs)",
    "  * Self-test result closes after 6 seconds (press F11 again to close it sooner)",
    "",
    "v7.0.1  (17 Nov 2026)",
    "  * Fixed the 'String has no method named Call' error on start",
    "",
    "v7.0  (17 Nov 2026)",
    "  + Setup wizard on first run: language, profile, keys, Discord, extras",
    "  + Profiles: Overnight, Quick 1 hour, Chill (tray > Profile or F12)",
    "  + Arabic / English (Settings or the setup wizard)",
    "  + Dim screen while running (F6): a black layer the button finder can see through",
    "  + Mutes Fortnite while running, sound back when it stops",
    "  + Reads your placement and XP from the end screen and saves every match",
    "  + Stats dashboard with charts (tray > Stats dashboard)",
    "  + Discord: screenshots, send log, daily summary, leaderboard",
    "  + Phone control with a Discord bot: !start !stop !status !ss !log !lb !summary !dim",
    "  + Start with Windows (no admin prompt)",
    "  + Lobby Loop icon on the .exe, tray and windows",
    "  + Status box: choose the corner, size, and hide/show it (F10)",
    "  + Works on 16:10 and ultrawide 21:9 screens",
    "",
    "v6.2  (17 Nov 2026)",
    "  + Discord: linking a webhook sets its name and picture to Lobby Loop automatically",
    "  + Every Discord alert shows the Lobby Loop name and icon",
    "",
    "v6.1  (17 Nov 2026)",
    "  + New name: Lobby Loop (github.com/yensobased1/lobby-loop)",
    "  + Auto-update is switched on and points at the Lobby Loop GitHub",
    "  + Your old Fortnite AFK settings, stats, popups and history are copied over",
    "",
    "v6.0  (17 Nov 2026)",
    "  + Works as an .exe: friends don't need AutoHotkey (use build_exe.bat)",
    "  + Stuck watchdog: no match finished for 40 min -> presses Esc, then",
    "    restarts Fortnite, then stops (each step only if the last one didn't help)",
    "  + Session history saved to a CSV file you can open in Excel (tray > Open history)",
    "  + Start every day at a set time (e.g. 2:00 AM), opens Fortnite first if needed",
    "  + Reopens Fortnite by itself if it crashes or closes while running",
    "  + Popup buttons: hover over an error/popup button and press F7 to teach it;",
    "    from then on it's clicked whenever it shows up",
    "  + More movement: crouch-walking, sliding, strafing, weapon swaps",
    "  + Auto-update: checks your GitHub for a new version when it starts",
    "  + Discord alerts (optional): match done, stopped, stuck, crashed",
    "",
    "v5.1  (17 Nov 2026)",
    "  * Fixed 'local variable k' error on start",
    "",
    "v5  (17 Nov 2026)",
    "  + Finds Ready / Play / Play Again by itself for everyone (olive or bright yellow,",
    "    any 16:9 screen size, works with the 'Stay with team' layout)",
    "  + Settings window (F12): stop timer, what happens when it stops, auto-start",
    "  + When it stops: just stop, close Fortnite, sleep or shut down the PC",
    "    (30-second countdown first, press Start/Stop to cancel)",
    "  + Auto-start when you click into Fortnite (optional)",
    "  + Custom movement keys and hotkeys in the settings file",
    "  + Stats: summary after each run, all-time matches and hours",
    "  + Update log (this window)",
    "",
    "v4 zen  (17 Nov 2026)",
    "  + Friend's version: finds the yellow buttons by itself, no saved positions",
    "",
    "v4  (17 Nov 2026)",
    "  - Removed auto-pause when you touch the mouse / keyboard",
    "  + Stop timer: after hours / minutes, or at a clock time (9:30 PM, 21:30)",
    "",
    "v3  (17 Nov 2026)",
    "  + Checks 4 points on each button, twice, before clicking",
    "  + Settings file, tray menu, beeps on start / stop, run timer",
    "",
    "v2  (17 Nov 2026)",
    "  * Fixed clicks using the wrong coordinates; stops instantly, no stuck keys",
    "  + Diagonal walking, sprinting, smooth camera, standing still",
    "  + Status box, F11 self-test, log file",
    "",
    "v1  (14-15 Nov 2026)",
    "  + Auto ready-up, walk / jump / look around, Play Again after every match",
    "  + Random Battle Bus drop and dive, restarts itself as Administrator",
    "",
    "Legend:  + new    - removed    * fixed"
]

; ============================================================
; Lobby Loop: Fortnite AFK (Away From Keyboard) helper v6   (update log: tray > What's new)
; https://github.com/yensobased1/lobby-loop
;
; Default keys:  F8 = Start / Stop   F9 = Exit   F11 = Self-test   F12 = Settings
;                F7 = Teach a popup button (hover over it first)
;                F6 = Dim screen      F10 = Show / hide the status box
;
; Needs Fortnite in Windowed Fullscreen (borderless). Run the .ahk with AutoHotkey v2,
; or build an .exe with build_exe.bat so friends don't need AutoHotkey.
; Files next to this script: <name>_settings.ini, _stats.ini, _popups.ini,
; _history.csv and <name>.log
; ============================================================

; ---------- Restart as Administrator (needed for hotkeys and clicks in Fortnite) ----------
if !A_IsAdmin {
    try Run('*RunAs "' A_ScriptFullPath '"')
    ExitApp()
}
try FileDelete(A_ScriptFullPath ".old")   ; leftover from an .exe update

; Epic launcher links that open Fortnite
FN_URI := "com.epicgames.launcher://apps/fn%3A4fe75bbc5a674f4f9b356b5c90567da5%3AFortnite?action=launch&silent=true"
FN_URI_OLD := "com.epicgames.launcher://apps/Fortnite?action=launch&silent=true"

; ---------- Settings ----------
DEFAULTS := [
    ["GAME_WINDOW", "ahk_exe FortniteClient-Win64-Shipping.exe", "Fortnite window, do not change"],
    ["SETUP_DONE", 0, "1 = the setup wizard has been completed"],
    ["LANG", "en", "Language: en (English) or ar (Arabic)"],
    ["PLAYER_NAME", "", "Your name for Discord and the leaderboard (blank = Windows user name)"],
    ["PROFILE", "custom", "overnight, quick, chill or custom"],
    ["START_WITH_WINDOWS", 0, "1 = start Lobby Loop when you log in to Windows"],
    ["MUTE_WHILE_RUNNING", 0, "1 = mute Fortnite while running"],
    ["BLACKOUT_ON_START", 0, "1 = dim the screen while running"],
    ["READ_RESULTS", 1, "1 = read your placement and XP from the end screen"],
    ["SCREENSHOT_EVERY_MATCH", 0, "1 = send an end-screen screenshot to Discord after every match"],
    ["DAILY_SUMMARY_TIME", "23:55", "Daily Discord summary at this time (blank = off)"],
    ["DISCORD_BOT_TOKEN", "", "Discord bot token for phone control (blank = off). Never share it"],
    ["DISCORD_CHANNEL_ID", "", "Discord channel ID the bot listens to"],
    ["DISCORD_ALLOWED_IDS", "", "Discord user IDs allowed to send commands, comma separated (blank = anyone)"],
    ["THEME", "dark", "Window theme: dark or light"],
    ["OVERLAY_CORNER", "top-left", "Status box corner: top-left, top-right, bottom-left, bottom-right or custom"],
    ["OVERLAY_X", 10, "Status box position when the corner is custom (set by dragging)"],
    ["OVERLAY_Y", 10, "Status box position when the corner is custom (set by dragging)"],
    ["NOTIFY", 1, "1 = Windows notifications when it stops, gets stuck or Fortnite crashes"],
    ["OVERLAY_STYLE", "card", "Status box style: card or mini"],
    ["ACCENT", "yellow", "Accent colour: yellow, purple, cyan, pink or green"],
    ["WATCH_TREASURE", 1, "1 = watch the screen for treasure (gizmos, pirate tokens...)"],
    ["TREASURE_WORDS", "", "Your own extra treasure words, separated by commas"],
    ["TREASURE_GIZMO", 1, "1 = look for gizmos (Sprite Locator, Lucky Locator...)"],
    ["TREASURE_GIZMO_WORDS", "SPRITE LOCATOR,LUCKY LOCATOR,GOLDEN FIREWORK,EXTRACTION ACCELERATOR,PORTABLE EXTRACTOR", "Gizmo prize names (only counted with a YOU FOUND banner)"],
    ["TREASURE_COSMETIC", 1, "1 = look for the weekly treasure cosmetics"],
    ["TREASURE_COSMETIC_WORDS", "SOLID GOLD", "This week's cosmetic prize names. Any other YOU FOUND prize also counts as a cosmetic"],
    ["TREASURE_TOKEN", 1, "1 = look for Pirate Shop Access (the pirate token)"],
    ["TREASURE_TOKEN_WORDS", "PIRATE SHOP ACCESS,SHOP ACCESS,!PIRATE SHOP ACCESS UNLOCKED", "Pirate Shop Access words. ! = counts even without the YOU FOUND banner"],
    ["TREASURE_FOUND_WORDS", "YOU FOUND,TREASURE FOUND", "Fortnite's prize banner (top of the screen). Treasure only counts when this is on screen (blank = any line)"],
    ["TREASURE_NOTIFY", 1, "1 = Windows notification when treasure is found"],
    ["TREASURE_BEEP", 1, "1 = play a sound when treasure is found"],
    ["TREASURE_DISCORD", 1, "1 = tell Discord when treasure is found"],
    ["TREASURE_SCREENSHOT", 1, "1 = add a screenshot to the Discord message"],
    ["TREASURE_CLIP", 0, "1 = save a clip when treasure is found (set your recorder's clip length to 25 s)"],
    ["CLIP_METHOD", "gamebar", "Clip with: gamebar (Win+Alt+G), nvidia (Alt+F10) or custom (CLIP_KEY)"],
    ["CLIP_KEY", "", "Your recorder's clip key when CLIP_METHOD is custom, e.g. F9 or ^!c"],
    ["CLIP_DELAY", 5, "Seconds to wait after the treasure before saving the clip"],
    ["CLIP_FOLDER", "", "Where your recorder saves clips (blank = your Videos folder)"],
    ["CLIP_UPLOAD", 1, "1 = send the clip to Discord when it's under 10 MB"],
    ["MODE_TEAM", "any", "Team size: any, solo, duo, trio or squad"],
    ["MODE_BUILD", "any", "Build: any, build or zerobuild"],
    ["MODE_FILL", "any", "Fill: any, fill or nofill"],
    ["MODE_ACTION", "wait", "If the lobby is on the wrong mode: wait (and tell you) or ready (ready up anyway)"],
    ["MODE_SWITCH", 0, "1 = try to switch to your mode by itself (experimental)"],
    ["KEEP_AWAKE", 1, "1 = keep the PC from sleeping while running"],
    ["MATCH_LIMIT", 0, "Stop after this many matches (0 = no limit)"],
    ["GAME_VOLUME", 100, "Fortnite volume while running, 0-100 (100 = leave it alone)"],
    ["STREAM_HIDE", 0, "1 = hide the status box from OBS, streams and screenshots"],
    ["AUTO_CLAIM", 1, "1 = click buttons that just say Continue, Collect, Claim, Accept..."],
    ["SPECTATE_IDLE", 1, "1 = stop moving while you're spectating teammates"],
    ["WAKE_FROM_SLEEP", 1, "1 = click Keep Playing when Fortnite goes into Sleep Mode, and keep it from falling asleep while waiting"],
    ["WAIT_FOR_SQUAD", 1, "1 = don't click Play Again while you're spectating, so you keep treasure your teammates find"],
    ["SCREEN_READER_SECONDS", 10, "How often the screen reader looks at the screen, in seconds"],
    ["AUTO_SCREENSHOT_MIN", 0, "Send a screenshot to Discord every this many minutes (0 = off)"],
    ["LIVE_STATUS", 0, "1 = keep a live status message in Discord (shows when the PC went offline)"],
    ["OVERLAY_SIZE", "normal", "Status box size: small, normal or large"],
    ["AUTO_START", 0, "1 = start by itself when you click into Fortnite"],
    ["START_AT_TIME", "", "Start every day at this time, e.g. 2:00 AM (blank = off)"],
    ["LAUNCH_FORTNITE", 1, "1 = open Fortnite by itself (scheduled start, crashes, stuck)"],
    ["STOP_AFTER_HOURS", 0, "Stop after this many hours (0 = off). Decimals OK, e.g. 1.5"],
    ["STOP_AFTER_MINUTES", 0, "Plus this many minutes (0 = off)"],
    ["STOP_AT_TIME", "", "Stop at a clock time, e.g. 9:30 PM or 21:30 (blank = off)"],
    ["STOP_ACTION", "nothing", "When it stops: nothing, close_fortnite, sleep or shutdown"],
    ["STUCK_MINUTES", 40, "No match finished for this many minutes = stuck (0 = watchdog off)"],
    ["DISCORD_WEBHOOK", "", "Discord webhook link for alerts (blank = off)"],
    ["DISCORD_EVERY_MATCH", 1, "1 = Discord message after every match, 0 = only stops / problems"],
    ["AUTO_UPDATE", 1, "1 = check for a new version when it starts"],
    ["UPDATE_URL", "", "Raw link to version.txt on GitHub (blank = use the built-in link)"],
    ["HOTKEY_TOGGLE", "F8", "Start / Stop key (e.g. F8, Insert, ^!s for Ctrl+Alt+S)"],
    ["HOTKEY_EXIT", "F9", "Exit key"],
    ["HOTKEY_TEST", "F11", "Self-test key"],
    ["HOTKEY_SETTINGS", "F12", "Settings window key"],
    ["HOTKEY_TEACH", "F7", "Teach a popup button key"],
    ["HOTKEY_BLACKOUT", "F6", "Dim screen key"],
    ["HOTKEY_OVERLAY", "F10", "Show / hide status box key"],
    ["KEY_FORWARD", "w", "Your Fortnite forward key"],
    ["KEY_LEFT", "a", "Your Fortnite left key"],
    ["KEY_BACK", "s", "Your Fortnite back key"],
    ["KEY_RIGHT", "d", "Your Fortnite right key"],
    ["KEY_JUMP", "Space", "Your Fortnite jump key"],
    ["KEY_SPRINT", "LShift", "Your Fortnite sprint key"],
    ["KEY_CROUCH", "LCtrl", "Your Fortnite crouch key"],
    ["KEY_SLOTS", "1,2,3,4,5", "Your weapon slot keys, separated by commas"],
    ["WALK_MIN", 500, "Shortest walk, ms (1000 = 1 second)"],
    ["WALK_MAX", 2200, "Longest walk, ms"],
    ["COMBO_CHANCE", 35, "% chance to walk diagonally"],
    ["SPRINT_CHANCE", 30, "% chance to sprint"],
    ["JUMP_CHANCE", 25, "% chance to jump (also leaves the Battle Bus)"],
    ["DIVE_CHANCE", 20, "% chance to dive and steer in the air"],
    ["DIVE_MIN", 2500, "Shortest dive, ms"],
    ["DIVE_MAX", 5000, "Longest dive, ms"],
    ["SLIDE_CHANCE", 8, "% chance to sprint and slide"],
    ["CROUCH_CHANCE", 8, "% chance to crouch-walk"],
    ["STRAFE_CHANCE", 6, "% chance to strafe left-right"],
    ["SWAP_CHANCE", 10, "% chance to switch weapon slot"],
    ["LOOK_CHANCE", 45, "% chance to turn the camera"],
    ["IDLE_CHANCE", 20, "% chance to stand still for a moment"],
    ["IDLE_MIN", 500, "Shortest stand-still, ms"],
    ["IDLE_MAX", 3000, "Longest stand-still, ms"],
    ["CLICK_COOLDOWN", 15000, "Min ms between clicks on the same button"],
    ["BUTTON_TOLERANCE", 10, "How close button colours must match (0-255). Keep it low"],
    ["SHOW_OVERLAY", 1, "1 = show the status box, 0 = hide it"],
    ["BEEP", 1, "1 = beep on start/stop, 0 = silent"]
]

ACTIONS := [
    ["nothing", "Just stop"],
    ["close_fortnite", "Close Fortnite"],
    ["sleep", "Sleep the PC"],
    ["shutdown", "Shut down the PC"]
]

SplitPath(A_ScriptName, , , , &BASE)
INI_FILE := A_ScriptDir "\" BASE "_settings.ini"
STATS_FILE := A_ScriptDir "\" BASE "_stats.ini"
POPUP_FILE := A_ScriptDir "\" BASE "_popups.ini"
HISTORY_FILE := A_ScriptDir "\" BASE "_history.csv"
LOG_FILE := A_ScriptDir "\" BASE ".log"
MATCHES_FILE := A_ScriptDir "\" BASE "_matches.csv"
DASH_FILE := A_ScriptDir "\" BASE "_dashboard.html"
TREASURE_FILE := A_ScriptDir "\" BASE "_treasure.csv"
migrated := MigrateOldFiles()     ; first run after the rename to Lobby Loop

; Read settings; rebuild the file if it's new, missing keys, or from an older version
S := Map()
needWrite := !FileExist(INI_FILE)
for d in DEFAULTS {
    v := IniRead(INI_FILE, "Settings", d[1], "__missing__")
    if (v = "__missing__") {
        needWrite := true
        v := d[2]
    }
    S[d[1]] := IsNumber(v) ? Number(v) : v
}
for pair in [["TREASURE_GIZMO_WORDS", "GIZMO,NEW SPRITE,SPRITE UNLOCKED"], ["TREASURE_COSMETIC_WORDS", "WEEKLY TREASURE,TREASURE UNLOCKED,TREASURE FOUND,NEW COSMETIC"],
            ["TREASURE_TOKEN_WORDS", "PIRATE TOKEN,DOUBLOON"]]
    if (S[pair[1]] = pair[2]) {
        for d in DEFAULTS
            if (d[1] = pair[1])
                S[pair[1]] := d[2]
        needWrite := true
    }
if (S["TREASURE_WORDS"] = "GIZMO,PIRATE TOKEN,TREASURE FOUND,TREASURE UNLOCKED,NEW SPRITE,SPRITE UNLOCKED") {
    S["TREASURE_WORDS"] := ""                     ; old v7.5 preset, now split into the categories
    needWrite := true
}
for old in ["AUTO_PAUSE", "COLOR_TOLERANCE"]
    if (IniRead(INI_FILE, "Settings", old, "__missing__") != "__missing__")
        needWrite := true
if needWrite
    WriteSettingsFile()

try FileDelete(LOG_FILE)

; Movement keys (fall back to defaults if a key name is wrong)
for name in ["KEY_FORWARD", "KEY_LEFT", "KEY_BACK", "KEY_RIGHT", "KEY_JUMP", "KEY_SPRINT", "KEY_CROUCH"] {
    S[name] := String(S[name])
    if !ValidKey(S[name]) {
        for d in DEFAULTS
            if (d[1] = name)
                S[name] := d[2]
        Log("Unknown key in " name ", using default " S[name])
    }
}
KEYMAP := Map("fwd", S["KEY_FORWARD"], "left", S["KEY_LEFT"], "back", S["KEY_BACK"],
              "right", S["KEY_RIGHT"], "jump", S["KEY_JUMP"], "sprint", S["KEY_SPRINT"],
              "crouch", S["KEY_CROUCH"])
SLOT_KEYS := []
for slotKey in StrSplit(String(S["KEY_SLOTS"]), ",", " `t")
    if ValidKey(slotKey)
        SLOT_KEYS.Push(slotKey)

; ---------- State ----------
running := false
stopReason := "you"
matches := 0
clicks := 0
sessionStart := 0
sessionStartTime := ""
stopTick := 0          ; A_TickCount when the hours/minutes timer ends (0 = off)
stopAt := ""           ; YYYYMMDDHHMISS clock time to stop at ("" = off)
startAtNext := ""      ; YYYYMMDDHHMISS next scheduled start ("" = off)
pendingAction := ""    ; stop action waiting for its countdown
pendingLeft := 0
autoStartArmed := true
lastProgress := 0      ; last time something happened (a click, a match ended)
unstickTries := 0
goneSince := 0         ; when Fortnite disappeared while running
launchTick := 0        ; when we last tried to open Fortnite
launchTries := 0
activateUntil := 0     ; keep bringing Fortnite to the front until this time
lastMsg := "Ready"
totalMatches := Integer(IniRead(STATS_FILE, "Stats", "TotalMatches", 0))
totalMinutes := Number(IniRead(STATS_FILE, "Stats", "TotalMinutes", 0))
totalXP := Integer(IniRead(STATS_FILE, "Stats", "TotalXP", 0))
bestPlace := Integer(IniRead(STATS_FILE, "Stats", "BestPlace", 0))
botLastId := ""        ; newest Discord message the bot has seen
botFails := 0
blackoutGui := ""
overlayHidden := false
lastPlace := ""        ; last placement read from the end screen
lastXP := ""
movingOverlay := false
testCard := ""
gameState := ""        ; lobby, end, match or spectating
treasureCount := Integer(IniRead(STATS_FILE, "Stats", "TreasureCount", 0))
lastTreasure := ""
liveMsgId := IniRead(STATS_FILE, "Stats", "LiveMsgId", "")
panelMsgId := IniRead(STATS_FILE, "Stats", "PanelMsgId", "")
panelSeen := Map()
botUserId := ""
resumeAtTick := 0
watchMinutes := Number(S["AUTO_SCREENSHOT_MIN"])
lastWatchShot := 0
safeMode := false
hadError := false
ocrPending := false
ocrStartTick := 0
lastOcrTick := 0
lastClaimTick := 0
dashOpenTick := 0
scriptStartTick := A_TickCount
lobbyVisit := false    ; true while the lobby button is on screen
modeChecked := false
modeRecheckTick := 0
modeWarned := false
lastNudgeTick := 0     ; last tiny camera move that keeps Fortnite out of Sleep Mode
sleepWakes := 0        ; times we clicked Keep Playing this run
PANEL_EMOJI := [["%E2%96%B6%EF%B8%8F", "start"], ["%E2%8F%B9%EF%B8%8F", "stop"], ["%F0%9F%93%B8", "ss"],
                ["%F0%9F%93%8A", "status"], ["%F0%9F%8C%99", "dim"]]
SHARE_KEYS := ["PROFILE", "STOP_AFTER_HOURS", "STOP_AFTER_MINUTES", "STOP_AT_TIME", "STOP_ACTION", "MUTE_WHILE_RUNNING",
               "BLACKOUT_ON_START", "READ_RESULTS", "WATCH_TREASURE", "TREASURE_WORDS", "AUTO_CLAIM", "SPECTATE_IDLE",
               "WALK_MIN", "WALK_MAX", "COMBO_CHANCE", "SPRINT_CHANCE", "JUMP_CHANCE", "DIVE_CHANCE", "DIVE_MIN", "DIVE_MAX",
               "SLIDE_CHANCE", "CROUCH_CHANCE", "STRAFE_CHANCE", "SWAP_CHANCE", "LOOK_CHANCE", "IDLE_CHANCE", "IDLE_MIN",
               "IDLE_MAX", "THEME", "ACCENT", "OVERLAY_STYLE", "OVERLAY_SIZE", "OVERLAY_CORNER", "STUCK_MINUTES",
               "TREASURE_GIZMO", "TREASURE_GIZMO_WORDS", "TREASURE_COSMETIC", "TREASURE_COSMETIC_WORDS", "TREASURE_TOKEN",
               "TREASURE_TOKEN_WORDS", "TREASURE_FOUND_WORDS", "WAIT_FOR_SQUAD", "WAKE_FROM_SLEEP", "TREASURE_NOTIFY", "TREASURE_BEEP", "TREASURE_DISCORD", "TREASURE_SCREENSHOT",
               "TREASURE_CLIP", "CLIP_METHOD", "CLIP_DELAY", "CLIP_UPLOAD", "MODE_TEAM", "MODE_BUILD", "MODE_FILL",
               "MODE_ACTION", "MODE_SWITCH", "KEEP_AWAKE", "MATCH_LIMIT", "GAME_VOLUME"]
CheckSafeMode()
OnExit(OnExitHandler)
OnError(OnErrorHandler)
OV := Map()            ; status box controls
AR := LoadTranslations()
WIZ := Map()
PROFILES := Map(
    "overnight", Map("STOP_AFTER_HOURS", 8, "STOP_AFTER_MINUTES", 0, "STOP_AT_TIME", "", "STOP_ACTION", "sleep",
                     "MUTE_WHILE_RUNNING", 1, "BLACKOUT_ON_START", 1, "IDLE_CHANCE", 20, "LOOK_CHANCE", 45,
                     "JUMP_CHANCE", 25, "SPRINT_CHANCE", 30),
    "quick",     Map("STOP_AFTER_HOURS", 1, "STOP_AFTER_MINUTES", 0, "STOP_AT_TIME", "", "STOP_ACTION", "nothing",
                     "MUTE_WHILE_RUNNING", 0, "BLACKOUT_ON_START", 0, "IDLE_CHANCE", 20, "LOOK_CHANCE", 45,
                     "JUMP_CHANCE", 25, "SPRINT_CHANCE", 30),
    "chill",     Map("STOP_AFTER_HOURS", 3, "STOP_AFTER_MINUTES", 0, "STOP_AT_TIME", "", "STOP_ACTION", "nothing",
                     "MUTE_WHILE_RUNNING", 1, "BLACKOUT_ON_START", 0, "IDLE_CHANCE", 35, "LOOK_CHANCE", 60,
                     "JUMP_CHANCE", 15, "SPRINT_CHANCE", 15)
)
PROFILE_KEYS := ["overnight", "quick", "chill", "custom"]
HOTKEY_FIELDS := [["HOTKEY_TOGGLE", "Start / Stop"], ["HOTKEY_SETTINGS", "Settings"], ["HOTKEY_TEST", "Self-test"],
                  ["HOTKEY_BLACKOUT", "Dim screen"], ["HOTKEY_OVERLAY", "Show / hide status box"],
                  ["HOTKEY_TEACH", "Teach a popup button"], ["HOTKEY_EXIT", "Exit"]]
GAMEKEY_FIELDS := [["KEY_FORWARD", "Forward"], ["KEY_LEFT", "Left"], ["KEY_BACK", "Back"], ["KEY_RIGHT", "Right"],
                   ["KEY_JUMP", "Jump"], ["KEY_SPRINT", "Sprint"], ["KEY_CROUCH", "Crouch"], ["KEY_SLOTS", "Weapon slots"]]

; ---------- Button detection ----------
SCALE := Min(A_ScreenWidth / 2560, A_ScreenHeight / 1440)   ; works for 16:9, 16:10 and 21:9
COLORS := [0xA8AF00, 0xF7FE19]           ; olive and bright-yellow Fortnite styles
REGIONS := Map(
    "end",   [0.62, 0.25, 1.00, 0.85],   ; right side: PLAY AGAIN after a match
    "lobby", [0.00, 0.55, 0.30, 1.00]    ; bottom-left: READY / PLAY in the lobby
)
lastClick := Map("end", 0, "lobby", 0)
POPUPS := LoadPopups()

; ---------- Hotkeys (from settings) ----------
HK_TOGGLE := RegisterHotkey("HOTKEY_TOGGLE", "F8", (*) => ToggleRun())
HK_EXIT := RegisterHotkey("HOTKEY_EXIT", "F9", (*) => ExitScript())
HK_TEST := RegisterHotkey("HOTKEY_TEST", "F11", (*) => SelfTest())
HK_SETTINGS := RegisterHotkey("HOTKEY_SETTINGS", "F12", (*) => OpenSettings())
HK_TEACH := RegisterHotkey("HOTKEY_TEACH", "F7", (*) => TeachPopup())
HK_BLACKOUT := RegisterHotkey("HOTKEY_BLACKOUT", "F6", (*) => ToggleBlackout())
HK_OVERLAY := RegisterHotkey("HOTKEY_OVERLAY", "F10", (*) => ToggleOverlay())
if RegExMatch(HK_TEACH, "^\w+$")
    try Hotkey("+" HK_TEACH, (*) => ForgetPopupUnderMouse())
lastMsg := Tx("Press {1} to start", HK_TOGGLE)

; ---------- Tray menu ----------
if (!A_IsCompiled && FileExist(A_ScriptDir "\lobby_loop.ico"))
    TraySetIcon(A_ScriptDir "\lobby_loop.ico")
A_IconTip := TITLE
profileMenu := Menu()
BuildProfileMenu()
timerMenu := Menu()
for preset in [["30 minutes", 0, 30], ["1 hour", 1, 0], ["2 hours", 2, 0], ["4 hours", 4, 0], ["8 hours", 8, 0]]
    timerMenu.Add(Tx(preset[1]), QuickTimer.Bind(preset[2], preset[3]))
timerMenu.Add()
timerMenu.Add(Tx("No limit"), QuickTimer.Bind(0, 0))
timerMenu.Add(Tx("Custom..."), (*) => OpenSettings())
toolsMenu := Menu()
toolsMenu.Add(Tx("Open history (Excel)"), (*) => OpenHistory())
toolsMenu.Add(Tx("Send screenshot to Discord"), (*) => SendScreenshot("Screenshot from " PlayerName()))
toolsMenu.Add(Tx("Send log to Discord"), (*) => SendLog())
toolsMenu.Add(Tx("Report a bug"), (*) => ReportBug())
toolsMenu.Add(Tx("Read the screen now"), (*) => ShowScreenText(3000))
toolsMenu.Add(Tx("Check the lobby mode now"), (*) => ShowModeCheck(3000))
toolsMenu.Add()
toolsMenu.Add(Tx("Keyboard shortcuts"), (*) => ShowShortcuts())
toolsMenu.Add(Tx("Setup wizard"), (*) => StartWizard())
toolsMenu.Add(Tx("Forget learned popup buttons"), (*) => ForgetPopups())
toolsMenu.Add()
toolsMenu.Add(Tx("Add Start menu and Desktop shortcuts"), (*) => InstallShortcuts())
toolsMenu.Add(Tx("Uninstall"), (*) => Uninstall())
toolsMenu.Add()
toolsMenu.Add(Tx("Edit all settings (advanced)"), (*) => Run('notepad.exe "' INI_FILE '"'))
toolsMenu.Add(Tx("Open log"), (*) => Run('notepad.exe "' LOG_FILE '"'))
A_TrayMenu.Delete()
trayStart := Tx("Start / Stop") "  (" HK_TOGGLE ")"
A_TrayMenu.Add(trayStart, (*) => ToggleRun())
A_TrayMenu.Add(Tx("Pause 15 minutes"), (*) => (PauseFor(15), ShowTip(Tx("Paused for {1} minutes.", 15), 2500)))
A_TrayMenu.Add(Tx("Settings") "  (" HK_SETTINGS ")", (*) => OpenSettings())
A_TrayMenu.Add(Tx("Profile"), profileMenu)
A_TrayMenu.Add(Tx("Stop timer"), timerMenu)
A_TrayMenu.Add(Tx("Self-test") "  (" HK_TEST ")", (*) => SelfTest())
A_TrayMenu.Add()
A_TrayMenu.Add(Tx("Dim screen") "  (" HK_BLACKOUT ")", (*) => ToggleBlackout())
A_TrayMenu.Add(Tx("Show / hide status box") "  (" HK_OVERLAY ")", (*) => ToggleOverlay())
A_TrayMenu.Add(Tx("Move status box"), (*) => MoveOverlay())
A_TrayMenu.Add()
A_TrayMenu.Add(Tx("Stats dashboard"), (*) => OpenDashboard())
A_TrayMenu.Add(Tx("Tools"), toolsMenu)
A_TrayMenu.Add(Tx("Check for updates"), (*) => CheckUpdate(false))
A_TrayMenu.Add(Tx("What's new") " (v" VERSION ")", (*) => ShowWhatsNew())
A_TrayMenu.Add(Tx("Reload"), (*) => Reload())
A_TrayMenu.Add()
A_TrayMenu.Add(Tx("Exit") "  (" HK_EXIT ")", (*) => ExitScript())
A_TrayMenu.Default := trayStart

; ---------- Status box ----------
statusTxt := ""
BuildOverlay()                     ; always built, so the setting / F10 can show it again later
if !S["SHOW_OVERLAY"] {
    overlayHidden := true
    statusGui.Hide()
}
SetTimer(RefreshOverlay, 400)

ApplyStartSchedule()
SetTimer(AutoStartWatch, 2000)
SetTimer(ScheduleWatch, 10000)
SetTimer(BotPoll, 6000)
SetTimer(ScreenReaderTick, 1000)
SetTimer(LiveTick, 60000)
GdipStart()

; ---------- Startup ----------
ShowTip(Tx("{1} loaded.", TITLE " v" VERSION) "`n" Tx("{1} = start/stop   {2} = settings   {3} = self-test", HK_TOGGLE, HK_SETTINGS, HK_TEST), 5000)
if migrated
    Log("Copied " migrated " file(s) from the old Fortnite AFK version")
Log("Loaded v" VERSION (A_IsCompiled ? " (exe)" : " (ahk)") ". Screen " A_ScreenWidth "x" A_ScreenHeight ", admin=" A_IsAdmin ", stop: " DescribeStop() ", start: " DescribeStart() ", popups: " POPUPS.Length)

if safeMode
    SetTimer(() => ShowCard("🛟 " Tx("Safe mode"), [["⚠️", Tx("Lobby Loop didn't close properly last time.")],
        ["•", Tx("Dim screen, mute, text reading, treasure watcher, reward clicks and live status are off until you restart it."), true]], 12000), -2500)
if !S["SETUP_DONE"] {
    IniWrite(VERSION, STATS_FILE, "Stats", "LastSeenVersion")
    StartWizard()
} else if (IniRead(STATS_FILE, "Stats", "LastSeenVersion", "") != VERSION) {
    IniWrite(VERSION, STATS_FILE, "Stats", "LastSeenVersion")
    ShowWhatsNew()
}
if (S["AUTO_UPDATE"] && UpdateUrl() != "")
    SetTimer(() => CheckUpdate(true), -3000)

; ============================================================
; Control
; ============================================================
; First run after the rename: copy settings, stats, popups and history
; from the old Fortnite AFK files (fortnite_afk*.ini/.csv) if they exist.
MigrateOldFiles() {
    oldBase := StrReplace(BASE, "lobby_loop", "fortnite_afk")
    if (oldBase = BASE)
        return 0
    copied := 0
    for suffix in ["_settings.ini", "_stats.ini", "_popups.ini", "_history.csv"] {
        oldFile := A_ScriptDir "\" oldBase suffix
        newFile := A_ScriptDir "\" BASE suffix
        if (FileExist(oldFile) && !FileExist(newFile)) {
            try {
                FileCopy(oldFile, newFile)
                copied += 1
            }
        }
    }
    return copied
}
RegisterHotkey(setting, fallback, fn) {
    hk := Trim(String(S[setting]))
    try {
        Hotkey(hk, fn)
        return hk
    } catch {
        Log("Bad hotkey " setting "=" hk ", using " fallback)
        Hotkey(fallback, fn)
        return fallback
    }
}

; "F8", "^!s", "+Insert", "Numpad0" ... (modifier symbols, then one key)
ValidHotkey(hk) {
    hk := Trim(String(hk))
    if (hk = "")
        return false
    if InStr(hk, " & ") {
        parts := StrSplit(hk, " & ")
        return parts.Length = 2 && ValidKey(parts[1]) && ValidKey(RegExReplace(parts[2], "i)\s+up$"))
    }
    if !RegExMatch(hk, "^[#!^+<>*~$]*(.+?)(?:\s+up)?$", &m)
        return false
    return ValidKey(m[1])
}

ValidKey(keyName) {
    keyName := Trim(String(keyName))
    return keyName != "" && (GetKeyVK(keyName) || GetKeySC(keyName))
}

ToggleRun(reason := "you") {
    global gameState, lobbyVisit, modeChecked, modeRecheckTick, modeWarned, lastNudgeTick, sleepWakes
    global running, sessionStart, sessionStartTime, matches, clicks, pendingAction, autoStartArmed
    global totalMinutes, lastProgress, unstickTries, goneSince, launchTick, launchTries
    autoStartArmed := false

    ; A stop action is counting down: this key cancels it
    if (pendingAction != "") {
        Log("Stop action cancelled: " pendingAction)
        pendingAction := ""
        SetTimer(ActionTick, 0)
        ToolTip()
        SetStatus(Tx("Cancelled"))
        ShowTip(Tx("Cancelled"), 2000)
        return
    }

    running := !running
    Log("Start/Stop: " (running ? "ON" : "OFF (" reason ")"))
    if running {
        sessionStart := A_TickCount
        sessionStartTime := A_Now
        matches := 0
        clicks := 0
        lastProgress := A_TickCount
        unstickTries := 0
        goneSince := 0
        launchTick := 0
        launchTries := 0
        ApplyStopLimits()
        SetStatus(Tx("Running"))
        ShowTip(TITLE ": " Tx("ON") "`n" Tx("Stop: {1}", DescribeStop()), 2500)
        if S["BEEP"]
            SoundBeep(1000, 120)
        if S["MUTE_WHILE_RUNNING"]
            SetGameMute(true)
        else if (Number(S["GAME_VOLUME"]) < 100)
            SetGameVolume(Number(S["GAME_VOLUME"]))
        if S["KEEP_AWAKE"]
            KeepAwake(true)
        lobbyVisit := false, modeChecked := false, modeRecheckTick := 0, modeWarned := false
        lastNudgeTick := A_TickCount, sleepWakes := 0
        if S["BLACKOUT_ON_START"]
            ToggleBlackout(true)
        gameState := ""
        if (S["LIVE_STATUS"] && DiscordReady())
            SetTimer(() => LiveUpdate(), -1500)
        SetTimer(MainLoop, 50)
    } else {
        SetTimer(MainLoop, 0)
        ReleaseAll()
        if S["MUTE_WHILE_RUNNING"]
            SetGameMute(false)
        else if (Number(S["GAME_VOLUME"]) < 100)
            SetGameVolume(100)
        KeepAwake(false)
        ToggleBlackout(false)
        runMs := A_TickCount - sessionStart
        totalMinutes += runMs / 60000
        IniWrite(Round(totalMinutes, 1), STATS_FILE, "Stats", "TotalMinutes")
        SaveHistory(runMs, reason)
        SetStatus(Tx("Stopped"))
        if (S["LIVE_STATUS"] && DiscordReady())
            SetTimer(() => LiveUpdate(), -1500)
        summary := FormatDuration(runMs) ", " matches " match" (matches = 1 ? "" : "es")
        ShowTip(TITLE ": " Tx("OFF") "`n" Tx("This run: {1}", summary), 4000)
        if (reason != "you") {
            Discord("Stopped (" reason "). This run: " summary "`n" LeaderboardLine())
            if (reason != "exit" && reason != "update" && reason != "pause")
                Notify(Tx("Stopped"), reason ". " Tx("This run: {1}", summary))
        }
        if S["BEEP"]
            SoundBeep(500, 120)
    }
}

ExitScript() {
    if running
        ToggleRun("exit")
    ReleaseAll()
    ToggleBlackout(false)
    Log("Exit")
    ExitApp()
}

; Starts by itself once Fortnite is focused (if AUTO_START = 1).
; Disarmed after any start/stop, re-armed when Fortnite is closed.
AutoStartWatch() {
    global autoStartArmed
    if !WinExist(S["GAME_WINDOW"]) {
        if !running
            autoStartArmed := true
        return
    }
    if (S["AUTO_START"] && autoStartArmed && !running && pendingAction = "" && WinActive(S["GAME_WINDOW"])) {
        Log("Auto-start")
        ToggleRun()
    }
}

SelfTest() {
    global testCard
    if IsObject(testCard) {                        ; pressed again while showing: close it
        CloseCard(testCard)
        return
    }
    ok := "✅", no := "❌", info := "•"
    rows := []
    hasWin := WinExist(S["GAME_WINDOW"]), isActive := WinActive(S["GAME_WINDOW"])
    rows.Push([hasWin ? ok : no, Tx("Fortnite is open")])
    rows.Push([isActive ? ok : "⚠️", isActive ? Tx("Fortnite is the active window") : Tx("Click into Fortnite before starting")])
    rows.Push([A_IsAdmin ? ok : no, Tx("Running as Administrator")])
    rows.Push([info, Tx("Fortnite Sleep Mode: set it to Never (Settings > Game > Energy Saving)"), true])
    txt := "Fortnite window: " (hasWin ? "found" : "NOT found") ", active: " (isActive ? "yes" : "no") ", admin: " (A_IsAdmin ? "yes" : "NO")
    for name in ["lobby", "end"] {
        t0 := A_TickCount
        b := FindButton(name)
        ms := A_TickCount - t0
        label := (name = "lobby") ? Tx("Lobby Ready / Play button") : Tx("End-of-match Play Again button")
        rows.Push([b ? ok : "⚪", label ": " (b ? Tx("found") " (" b.x ", " b.y ")" : Tx("not on screen right now")), !b])
        txt .= "`n" name ": " (b ? "FOUND at " b.x ", " b.y " (" b.w "x" b.h ")" : "not on screen") "  [" ms " ms]"
    }
    rows.Push([info, Tx("Start: {1}", DescribeStart()) "   ·   " Tx("Stop: {1}", DescribeStop()) ", " Tx("then {1}", StrLower(ActionLabel(S["STOP_ACTION"]))), true])
    rows.Push([info, "Discord: " (DiscordUrl() != "" ? Tx("on") : Tx("off")) "   ·   " Tx("Phone control") ": " (BotEnabled() ? Tx("on") : Tx("off")) "   ·   " Tx("Updates") ": " (UpdateUrl() != "" ? Tx("on") : Tx("off")), true])
    rows.Push([info, Tx("Screen {1}", A_ScreenWidth "x" A_ScreenHeight) "   ·   v" VERSION (A_IsCompiled ? " exe" : "") "   ·   " Tx("Learned popup buttons: {1}", POPUPS.Length), true])
    txt .= "`nStart: " DescribeStart() ", stop: " DescribeStop() ", Discord: " (DiscordUrl() != "" ? "on" : "off") ", bot: " (BotEnabled() ? "on" : "off") ", popups: " POPUPS.Length
    Log("Self-test:`n" txt)
    testCard := ShowCard("🔎 " Tx("Self-test"), rows, 8000, Tx("Closes by itself, or press {1} again.", HK_TEST))
}

; A small card in the middle of the screen that doesn't take focus from the game
ShowCard(heading, rows, ms, footer := "", col := 28) {
    g := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x08000000")
    g.BackColor := "15152B"
    g.MarginX := 22, g.MarginY := 16
    g.SetFont("s13 bold cECECF4", "Segoe UI")
    g.Add("Text", "w560 BackgroundTrans", heading)
    for r in rows {
        g.SetFont("s10 norm cECECF4")
        g.Add("Text", "xm y+9 w" col " BackgroundTrans", r[1])
        g.SetFont("s10 norm c" ((r.Length >= 3 && r[3]) ? "A0A0C0" : "ECECF4"))
        g.Add("Text", "x+4 yp w" (558 - col) " BackgroundTrans", r[2])
    }
    if (footer != "") {
        g.SetFont("s8 norm c777790")
        g.Add("Text", "xm y+14 w560 BackgroundTrans", footer)
    }
    g.Show("xCenter yCenter NoActivate AutoSize")
    g.GetPos(, , &w, &h)
    WinSetRegion("0-0 w" w " h" h " R20-20", g)
    WinSetTransparent(242, g)
    if ms
        SetTimer(() => CloseCard(g), -ms)
    return g
}

CloseCard(g) {
    global testCard
    try g.Destroy()
    if (IsObject(testCard) && testCard = g)
        testCard := ""
}

ShowShortcuts() {
    rows := []
    for pair in HOTKEY_FIELDS
        rows.Push([S[pair[1]], Tx(pair[2])])
    rows.Push(["", ""])
    rows.Push(["🖱️", Tx("Double-click the tray icon to start or stop"), true])
    ShowCard("⌨️ " Tx("Keyboard shortcuts"), rows, 10000, Tx("Change them in Settings > Hotkeys."), 90)
}

ShowWhatsNew() {
    txt := ""
    for line in CHANGELOG
        txt .= line "`r`n"
    g := ThemeGui(TITLE " v" VERSION " - " Tx("What's new"))
    g.SetFont("s10 c" UiCol("text"), "Consolas")
    UiEdit(g, "w680 h460 ReadOnly VScroll", txt)
    g.SetFont("s10 c" UiCol("text"), "Segoe UI")
    okBtn := UiButton(g, "w110 Default", "OK")
    okBtn.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())
    g.OnEvent("Close", (*) => g.Destroy())
    g.Show()
    okBtn.Focus()
}

; ============================================================
; Settings window
; ============================================================
; ============================================================
; Look and feel (dark / light theme)
; ============================================================
DarkOn() {
    return S["THEME"] != "light"
}

; Colours for the current theme
UiCol(name) {
    static dark := Map("bg", "16162A", "side", "1F1F3D", "sel", "3B2F80", "text", "ECECF4", "muted", "9494B8",
                       "accent", "F7FE19", "edit", "26264A", "line", "33335C")
    static light := Map("bg", "F7F7FB", "side", "ECECF6", "sel", "D9D3FF", "text", "1B1B2F", "muted", "6B6B85",
                        "accent", "5B34D6", "edit", "FFFFFF", "line", "DDDDEA")
    if (name = "accent")
        return AccentHex()
    return DarkOn() ? dark[name] : light[name]
}

AccentHex() {
    accents := Map("yellow", "F7FE19", "purple", "8F6BFF", "cyan", "34D5FF", "pink", "FF5FD2", "green", "3DDC84")
    k := StrLower(String(S["ACCENT"]))
    return accents.Has(k) ? accents[k] : "F7FE19"
}

ThemeGui(title, opts := "+AlwaysOnTop") {
    g := Gui(GuiOpts(opts), title)
    g.BackColor := UiCol("bg")
    g.SetFont("s10 c" UiCol("text"), "Segoe UI")
    g.MarginX := 20, g.MarginY := 16
    if DarkOn()
        DarkTitleBar(g.Hwnd)
    return g
}

DarkTitleBar(hwnd) {
    v := Buffer(4, 0)
    NumPut("Int", 1, v)
    if (DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", hwnd, "Int", 20, "Ptr", v, "Int", 4) != 0)
        DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", hwnd, "Int", 19, "Ptr", v, "Int", 4)
}

DarkControl(ctrl, themeName := "DarkMode_Explorer") {
    if DarkOn()
        DllCall("uxtheme\SetWindowTheme", "Ptr", ctrl.Hwnd, "Str", themeName, "Ptr", 0)
    return ctrl
}

UiText(g, opts, text, style := "", bg := "Trans") {
    g.SetFont(style = "title" ? "s15 bold c" UiCol("text") : style = "head" ? "s11 bold c" UiCol("text")
             : style = "muted" ? "s9 norm c" UiCol("muted") : style = "accent" ? "s10 bold c" UiCol("accent") : "s10 norm c" UiCol("text"))
    t := g.Add("Text", opts " Background" bg, text)
    g.SetFont("s10 norm c" UiCol("text"))
    return t
}

UiEdit(g, opts, text := "") {
    return g.Add("Edit", opts " -E0x200 Border Background" UiCol("edit") " c" UiCol("text"), text)
}

UiDDL(g, opts, items) {
    return DarkControl(g.Add("DropDownList", opts, items), "DarkMode_CFD")
}

UiButton(g, opts, text) {
    return DarkControl(g.Add("Button", opts, text))
}

; A tick box with its own label, so the label can use the theme colour. Returns [box, label].
UiCheck(g, opts, label, value, width := 440) {
    cb := DarkControl(g.Add("Checkbox", opts " w18 h20"))
    cb.Value := value ? 1 : 0
    lbl := UiText(g, "x+6 yp+1 w" width, label)
    lbl.OnEvent("Click", (*) => (cb.Value := !cb.Value))
    return [cb, lbl]
}

; ============================================================
; Discord how-to guides
; ============================================================
ShowGuide(kind, owner := "") {
    if (kind = "bot") {
        head := Tx("Phone control setup (about 5 minutes)")
        steps := [
            Tx("Click 'Open Developer Portal' below, then New Application, and name it Lobby Loop."),
            Tx("Click Bot (left menu), then Reset Token, then Copy. Paste it into 'Bot token'. Never share it."),
            Tx("On the same Bot page, turn on 'Message Content Intent' and click Save Changes."),
            Tx("Click OAuth2, then URL Generator. Tick 'bot', then Send Messages, Read Message History and Attach Files."),
            Tx("Open the link at the bottom of that page and add the bot to your server."),
            Tx("In Discord: User Settings, Advanced, turn on Developer Mode."),
            Tx("Right-click your channel and Copy Channel ID. Right-click your name and Copy User ID. Paste both here."),
            Tx("Click Save, then type !status in the channel. Lobby Loop answers in a few seconds.")
        ]
        foot := Tx("Commands: !start  !stop  !status  !ss (screenshot)  !log  !summary  !lb (leaderboard)  !dim. Add a name to control one PC, e.g. !stop zen")
    } else {
        head := Tx("Discord alerts setup (about 1 minute)")
        steps := [
            Tx("In Discord, right-click the channel for alerts and click Edit Channel."),
            Tx("Click Integrations, then Webhooks, then New Webhook."),
            Tx("Click the new webhook, then Copy Webhook URL."),
            Tx("Paste it into 'Discord alert link', click Send test message, then Save."),
            Tx("Lobby Loop sets the webhook's name and picture for you.")
        ]
        foot := Tx("Keep the link private: anyone who has it can post in your channel.")
    }
    g := ThemeGui(TITLE " - Discord", "+AlwaysOnTop" (owner != "" ? " +Owner" owner : ""))
    UiText(g, "w560", head, "title")
    for i, st in steps {
        UiText(g, "xm y+12 w26", i ".", "accent")
        UiText(g, "x+6 yp w530", st)
    }
    UiText(g, "xm y+18 w560", foot, "muted")
    if (kind = "bot") {
        portal := UiButton(g, "xm y+18 w220", Tx("Open Developer Portal"))
        portal.OnEvent("Click", (*) => Run("https://discord.com/developers/applications"))
        okBtn := UiButton(g, "x+10 w110 Default", "OK")
    } else {
        okBtn := UiButton(g, "xm y+18 w110 Default", "OK")
    }
    okBtn.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())
    g.Show()
}

; ============================================================
; Settings window: sidebar with sections
; ============================================================
SettingsNav(index, pages, navs, *) {
    for i, pg in pages
        for ctrl in pg
            ctrl.Visible := (i = index)
    for i, n in navs {
        n.Opt("Background" (i = index ? UiCol("sel") : UiCol("side")))
        n.SetFont(i = index ? "bold" : "norm")
        n.Redraw()
    }
}

SettingsForgetPopup(index, g, *) {
    ForgetPopup(index)
    g.Destroy()
    OpenSettings(8)
}

SettingsImportCode(g, code) {
    n := ImportCode(code)
    if !n {
        MsgBox(Tx("That code didn't work. It should start with LL75-"), TITLE, "Icon! Owner" g.Hwnd)
        return
    }
    MsgBox(Tx("Loaded {1} settings. Lobby Loop restarts now.", n), TITLE, "Iconi Owner" g.Hwnd)
    g.Destroy()
    Reload()
}

ProfileIndex(key) {
    for i, k in PROFILE_KEYS
        if (k = key)
            return i
    return 4
}

SetSetting(key, value) {
    S[key] := value
    IniWrite(value, INI_FILE, "Settings", key)
}

ActionLabels() {
    out := []
    for a in ACTIONS
        out.Push(Tx(a[2]))
    return out
}

ActionIndex(actionKey) {
    for i, a in ACTIONS
        if (a[1] = actionKey)
            return i
    return 1
}

ActionLabel(actionKey) {
    return Tx(ACTIONS[ActionIndex(actionKey)][2])
}

; "21:30" -> "9:30 PM" for display in the settings window
ClockText(value) {
    t := Trim(String(value))
    if (t = "")
        return ""
    c := ParseClock(t)
    return c ? FormatTime(FormatTime(A_Now, "yyyyMMdd") Format("{:02}{:02}00", c.h, c.m), "h:mm tt") : t
}

CurrentStopText() {
    if (Trim(String(S["STOP_AT_TIME"])) != "")
        return ClockText(S["STOP_AT_TIME"])
    total := Round(S["STOP_AFTER_HOURS"] * 60 + S["STOP_AFTER_MINUTES"])
    if (total <= 0)
        return ""
    return (total // 60 ? total // 60 "h" : "") (Mod(total, 60) ? Mod(total, 60) "m" : "")
}

; ============================================================
; Start / stop schedule
; ============================================================
SaveStop(h, m, t) {
    SetSetting("STOP_AFTER_HOURS", h)
    SetSetting("STOP_AFTER_MINUTES", m)
    SetSetting("STOP_AT_TIME", t)
}

ApplyStopLimits() {
    global stopTick, stopAt
    total := S["STOP_AFTER_HOURS"] * 60 + S["STOP_AFTER_MINUTES"]
    stopTick := (total > 0) ? A_TickCount + Round(total * 60000) : 0
    stopAt := ""
    t := Trim(String(S["STOP_AT_TIME"]))
    if (t != "") {
        if (c := ParseClock(t))
            stopAt := NextOccurrence(c)
        else {
            Log("STOP_AT_TIME not understood: " t)
            ShowTip("Stop time '" t "' not understood. Press " HK_SETTINGS " to set it again.", 5000)
        }
    }
}

ApplyStartSchedule() {
    global startAtNext
    startAtNext := ""
    t := Trim(String(S["START_AT_TIME"]))
    if (t = "")
        return
    if (c := ParseClock(t))
        startAtNext := NextOccurrence(c)
    else
        Log("START_AT_TIME not understood: " t)
}

; Fires the daily scheduled start
ScheduleWatch() {
    global startAtNext, goneSince
    WatchTick()
    ; daily Discord summary
    sumT := Trim(String(S["DAILY_SUMMARY_TIME"]))
    if (sumT != "" && DiscordReady() && (ck := ParseClock(sumT))) {
        today := FormatTime(, "yyyyMMdd")
        due := today Format("{:02}{:02}00", ck.h, ck.m)
        if (DateDiff(A_Now, due, "Seconds") >= 0 && IniRead(STATS_FILE, "Stats", "LastSummary", "") != today) {
            IniWrite(today, STATS_FILE, "Stats", "LastSummary")
            Log("Daily summary")
            SendDailySummary()
        }
    }
    if (startAtNext = "" || DateDiff(A_Now, startAtNext, "Seconds") < 0)
        return
    firedAt := startAtNext
    startAtNext := DateAdd(startAtNext, 1, "Days")    ; same time tomorrow
    if (running || pendingAction != "")
        return
    Log("Scheduled start (" FormatTime(firedAt, "h:mm tt") ")")
    Discord("Scheduled start at " FormatTime(firedAt, "h:mm tt"))
    if WinExist(S["GAME_WINDOW"])
        try WinActivate(S["GAME_WINDOW"])
    ToggleRun()
    if (!WinExist(S["GAME_WINDOW"]) && S["LAUNCH_FORTNITE"])
        goneSince := A_TickCount - 31000              ; open Fortnite right away
}

; "9:30 PM", "9:30pm", "9 30 am", "9pm", "21:30" -> {h, m} (24-hour), or 0
ParseClock(str) {
    str := StrLower(Trim(str))
    str := StrReplace(str, "a.m.", "am")
    str := StrReplace(str, "p.m.", "pm")
    if !RegExMatch(str, "^(\d{1,2})(?:\s*([:.\s])\s*(\d{2}))?\s*(am|pm)?$", &m)
        return 0
    if (m[2] = "" && m[4] = "")   ; a bare number like "90" is a duration, not a time
        return 0
    h := Integer(m[1])
    mi := (m[3] = "") ? 0 : Integer(m[3])
    if (m[4] != "") {
        if (h < 1 || h > 12)
            return 0
        if (m[4] = "pm" && h < 12)
            h += 12
        if (m[4] = "am" && h = 12)
            h := 0
    }
    if (h > 23 || mi > 59)
        return 0
    return {h: h, m: mi}
}

; "2h", "90m", "1h30m", "1h 30", "1.5h", "90" (minutes) -> {h, m}, or 0
ParseDuration(str) {
    str := StrLower(Trim(str))
    if RegExMatch(str, "^\d+(?:\.\d+)?$")
        return {h: 0, m: Number(str)}
    if !RegExMatch(str, "^(?:(\d+(?:\.\d+)?)\s*h[a-z]*)?\s*(?:(\d+)\s*(?:m[a-z]*)?)?$", &dm)
        return 0
    if (dm[1] = "" && dm[2] = "")
        return 0
    return {h: (dm[1] = "") ? 0 : Number(dm[1]), m: (dm[2] = "") ? 0 : Number(dm[2])}
}

NextOccurrence(c) {
    target := FormatTime(A_Now, "yyyyMMdd") Format("{:02}{:02}00", c.h, c.m)
    if (DateDiff(target, A_Now, "Seconds") <= 0)
        target := DateAdd(target, 1, "Days")
    return target
}

TimeLeftMs() {
    left := ""
    if stopTick
        left := stopTick - A_TickCount
    if (stopAt != "") {
        t := DateDiff(stopAt, A_Now, "Seconds") * 1000
        left := (left = "") ? t : Min(left, t)
    }
    return left
}

DescribeStop() {
    parts := []
    h := S["STOP_AFTER_HOURS"], m := S["STOP_AFTER_MINUTES"]
    if (h > 0 || m > 0) {
        total := Round(h * 60 + m)
        parts.Push("after " (total // 60 ? total // 60 "h " : "") Mod(total, 60) "m")
    }
    t := Trim(String(S["STOP_AT_TIME"]))
    if (t != "") {
        c := ParseClock(t)
        parts.Push(c ? "at " FormatTime(NextOccurrence(c), "h:mm tt") : "at '" t "' (not understood)")
    }
    if (parts.Length = 0)
        return Tx("no limit")
    if (parts.Length = 1)
        return parts[1]
    return parts[1] " or " parts[2] " (whichever is first)"
}

DescribeStart() {
    return (startAtNext = "") ? Tx("manual") : Tx("Starts at {1}", FormatTime(startAtNext, "h:mm tt"))
}

; ---------- What to do when the timer stops it ----------
StartStopAction() {
    global pendingAction, pendingLeft
    act := S["STOP_ACTION"]
    if (ActionIndex(act) = 1)
        return
    pendingAction := act
    pendingLeft := 30
    Log("Stop action in 30 s: " act)
    SetTimer(ActionTick, 1000)
    ActionTick()
}

ActionTick() {
    global pendingAction, pendingLeft
    if (pendingAction = "") {
        SetTimer(ActionTick, 0)
        return
    }
    if (pendingLeft <= 0) {
        SetTimer(ActionTick, 0)
        act := pendingAction
        pendingAction := ""
        ToolTip()
        DoStopAction(act)
        return
    }
    msg := Tx("{1} in {2} s", ActionLabel(pendingAction), pendingLeft)
    SetStatus(msg " (" Tx("Press {1} to cancel", HK_TOGGLE) ")")
    ToolTip(TITLE ": " msg "`n" Tx("Press {1} to cancel", HK_TOGGLE), A_ScreenWidth // 2 - 160, A_ScreenHeight // 2)
    if (S["BEEP"] && pendingLeft <= 5)
        SoundBeep(800, 80)
    pendingLeft -= 1
}

GameExe() {
    return Trim(StrReplace(S["GAME_WINDOW"], "ahk_exe", ""))
}

DoStopAction(act) {
    Log("Doing stop action: " act)
    Discord("Doing: " ActionLabel(act))
    if (act = "close_fortnite") {
        SetStatus("Closing Fortnite")
        try ProcessClose(GameExe())
    } else if (act = "sleep") {
        SetStatus("Putting the PC to sleep")
        DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
    } else if (act = "shutdown") {
        SetStatus("Shutting down")
        try ProcessClose(GameExe())
        Sleep(3000)
        Shutdown(1)
    }
}

; ============================================================
; Fortnite crash / relaunch and stuck watchdog
; ============================================================
TryLaunch() {
    global launchTick, launchTries
    if (launchTick && A_TickCount - launchTick < 360000)    ; give each try 6 minutes
        return
    if (launchTries >= 2) {
        Log("Fortnite didn't open after 2 tries")
        ToggleRun("Fortnite didn't open")
        SetStatus("Stopped: Fortnite didn't open")
        return
    }
    launchTries += 1
    launchTick := A_TickCount
    Log("Opening Fortnite (try " launchTries ")")
    Discord("Fortnite isn't running, opening it (try " launchTries ")")
    Notify("Fortnite", Tx("Fortnite isn't running. Opening it (try {1}).", launchTries))
    try Run(launchTries = 1 ? FN_URI : FN_URI_OLD)
}

Unstick() {
    global lastProgress, unstickTries, goneSince, launchTries, launchTick
    unstickTries += 1
    mins := S["STUCK_MINUTES"]
    Log("Stuck: no match finished in " mins " min (step " unstickTries ")")
    Notify(Tx("Looks stuck"), Tx("No match finished in {1} minutes. Trying to fix it.", mins))
    if S["BEEP"]
        SoundBeep(700, 150)
    ReleaseAll()
    if (unstickTries <= 2) {
        if !SendScreenshot("Looks stuck (no match finished in " mins " min), pressing Esc. This is the screen:")
            Discord("Looks stuck (no match finished in " mins " min), pressing Esc")
        SetStatus("Stuck? Pressing Esc")
        Send("{Esc}")
        Sleep(1500)
        if (!FindButton("end") && !FindButton("lobby") && !AnyPopupVisible())
            Send("{Esc}")                                  ; close the menu Esc may have opened
        lastProgress := A_TickCount - mins * 60000 + 300000 ; check again in 5 minutes
    } else if (unstickTries = 3 && S["LAUNCH_FORTNITE"]) {
        Discord("Still stuck, restarting Fortnite")
        SetStatus("Still stuck, restarting Fortnite")
        try ProcessClose(GameExe())
        goneSince := A_TickCount - 31000
        launchTries := 0
        launchTick := 0
        lastProgress := A_TickCount
    } else {
        ToggleRun("stuck")
        SetStatus("Stopped: stuck")
    }
}

; ============================================================
; Popup buttons (taught with F7)
; ============================================================
LoadPopups() {
    list := []
    loop 6 {
        v := IniRead(POPUP_FILE, "Popups", "P" A_Index, "")
        a := StrSplit(v, ",")
        if (a.Length = 5)
            list.Push({l: Number(a[1]), t: Number(a[2]), r: Number(a[3]), b: Number(a[4]), color: Integer(a[5]), last: 0})
    }
    return list
}

SavePopups() {
    try FileDelete(POPUP_FILE)
    for i, p in POPUPS
        IniWrite(Format("{:.5f},{:.5f},{:.5f},{:.5f},0x{:06X}", p.l, p.t, p.r, p.b, p.color), POPUP_FILE, "Popups", "P" i)
}

ForgetPopups() {
    global POPUPS
    POPUPS := []
    SavePopups()
    Log("Forgot all popup buttons")
    ShowTip("Forgot all learned popup buttons", 2500)
}

; Hover over an EMPTY part of a popup button (not the text) and press F7
TeachPopup() {
    MouseGetPos(&mx, &my)
    MouseMove(2, A_ScreenHeight - 2, 0)        ; move away so the hover highlight goes
    Sleep(400)
    cap := Capture(0, 0, A_ScreenWidth, A_ScreenHeight)
    MouseMove(mx, my, 0)
    c := Px(cap, mx, my)
    tol := 12
    l := mx, r := mx, t := my, b := my
    while Close(Px(cap, l - 1, my), c, tol)
        l -= 1
    while Close(Px(cap, r + 1, my), c, tol)
        r += 1
    while Close(Px(cap, mx, t - 1), c, tol)
        t -= 1
    while Close(Px(cap, mx, b + 1), c, tol)
        b += 1
    w := r - l, h := b - t
    if (w < 80 * SCALE || h < 25 * SCALE || w > A_ScreenWidth * 0.6 || h > 300 * SCALE) {
        ShowTip("Couldn't find a button there (" w "x" h ").`nHover over an EMPTY part of the button (beside the text) and press " HK_TEACH " again.", 6000)
        return
    }
    if (POPUPS.Length >= 6) {
        ShowTip("Already 6 popup buttons learned. Tray menu > Forget learned popup buttons.", 5000)
        return
    }
    POPUPS.Push({l: l / A_ScreenWidth, t: t / A_ScreenHeight, r: r / A_ScreenWidth, b: b / A_ScreenHeight, color: c, last: 0})
    SavePopups()
    Log("Learned popup #" POPUPS.Length ": " l "," t " - " r "," b " colour " Format("0x{:06X}", c))
    ShowTip("Learned popup button #" POPUPS.Length " (" w "x" h ").`nIt will be clicked whenever it shows up.", 4000)
}

; Is a learned popup button on screen? Returns its centre {x, y} or 0.
PopupVisible(p) {
    l := Round(p.l * A_ScreenWidth), t := Round(p.t * A_ScreenHeight)
    r := Round(p.r * A_ScreenWidth), b := Round(p.b * A_ScreenHeight)
    w := r - l, h := b - t
    if (w < 10 || h < 5)
        return 0
    cap := Capture(l, t, w + 1, h + 1)
    cy := (t + b) // 2
    pts := [[l + w * 0.08, cy], [r - w * 0.08, cy], [l + w * 0.08, t + h * 0.3], [r - w * 0.08, b - h * 0.3]]
    for pt in pts
        if !Close(Px(cap, Round(pt[1]), Round(pt[2])), p.color, 14)
            return 0
    ; must have text (a clearly different colour) across the middle
    xx := l + w // 4
    while (xx < r - w // 4) {
        q := Px(cap, xx, cy)
        if (q >= 0 && ColorDist(q, p.color) > 120)
            return {x: (l + r) // 2, y: cy}
        xx += 2
    }
    return 0
}

AnyPopupVisible() {
    for p in POPUPS
        if PopupVisible(p)
            return true
    return false
}

TryPopups() {
    global clicks
    for i, p in POPUPS {
        if (A_TickCount - p.last < S["CLICK_COOLDOWN"])
            continue
        if !PopupVisible(p)
            continue
        Sleep(300)
        if !CanAct()
            return false
        pos := PopupVisible(p)
        if !pos
            continue
        ReleaseAll()
        p.last := A_TickCount
        MouseMove(pos.x + Random(-8, 8), pos.y + Random(-4, 4), 6)
        Sleep(Random(120, 260))
        Click()
        clicks += 1
        Log("Clicked popup #" i)
        Discord("Clicked popup button #" i)
        Sleep(Random(500, 900))
        return true
    }
    return false
}

; ============================================================
; History (CSV for Excel)
; ============================================================
SaveHistory(runMs, reason) {
    if (sessionStartTime = "")
        return
    if !FileExist(HISTORY_FILE)
        try FileAppend("Date,Start,End,Minutes,Matches,Clicks,Stopped by`r`n", HISTORY_FILE, "UTF-8")
    line := FormatTime(sessionStartTime, "yyyy-MM-dd") "," FormatTime(sessionStartTime, "HH:mm") "," FormatTime(A_Now, "HH:mm")
        . "," Round(runMs / 60000, 1) "," matches "," clicks "," StrReplace(reason, ",", " ") "`r`n"
    try FileAppend(line, HISTORY_FILE, "UTF-8")
}

OpenHistory() {
    if !FileExist(HISTORY_FILE) {
        ShowTip("No history yet. It's saved every time you stop.", 3000)
        return
    }
    try Run('"' HISTORY_FILE '"')
}

; ============================================================
; Discord alerts (optional)
; ============================================================
DiscordUrl() {
    return Trim(String(S["DISCORD_WEBHOOK"]))
}

IsDiscordUrl(url) {
    return RegExMatch(url, "i)^https://(ptb\.|canary\.)?discord(app)?\.com/api/webhooks/")
}

DiscordReady() {
    return DiscordUrl() != "" || BotEnabled()
}

; Webhook name shown in Discord, e.g. "Lobby Loop · Zain"
BotName() {
    return SubStr(TITLE " · " PlayerName(), 1, 80)
}

Discord(msg, url := "") {
    if (url = "")
        url := DiscordUrl()
    if (url = "" || !IsDiscordUrl(url)) {
        if (url = "" && BotEnabled()) {               ; no webhook: post through the bot
            body := '{"content":"' JsonEscape(SubStr("**" BotName() "** - " FormatTime(, "h:mm tt") ": " msg, 1, 1990)) '"}'
            return BotRequest("POST", "https://discord.com/api/v10/channels/" Trim(String(S["DISCORD_CHANNEL_ID"])) "/messages", body) != ""
        }
        return false
    }
    body := '{"username":"' JsonEscape(BotName()) '","avatar_url":"' ICON_URL '","content":"' JsonEscape(SubStr(FormatTime(, "h:mm tt") ": " msg, 1, 1990)) '"}'
    try {
        req := ComObject("WinHttp.WinHttpRequest.5.1")
        req.SetTimeouts(3000, 3000, 3000, 4000)
        req.Open("POST", url, false)
        req.SetRequestHeader("Content-Type", "application/json")
        req.Send(body)
        ok := (req.Status >= 200 && req.Status < 300)
        if !ok
            Log("Discord error " req.Status)
        return ok
    } catch as e {
        Log("Discord failed: " e.Message)
        return false
    }
}

; Sends a message with a file (screenshot or log) using curl.exe, which comes with Windows 10/11
DiscordFile(msg, filePath) {
    curl := A_WinDir "\System32\curl.exe"
    if !FileExist(curl) || !FileExist(filePath)
        return false
    hook := DiscordUrl()
    if (hook != "") {
        url := hook
        payload := '{"username":"' JsonEscape(BotName()) '","avatar_url":"' ICON_URL '","content":"' JsonEscape(SubStr(msg, 1, 1990)) '"}'
        auth := ""
    } else if BotEnabled() {
        url := "https://discord.com/api/v10/channels/" Trim(String(S["DISCORD_CHANNEL_ID"])) "/messages"
        payload := '{"content":"' JsonEscape(SubStr("**" BotName() "**: " msg, 1, 1990)) '"}'
        auth := ' -H "Authorization: Bot ' Trim(String(S["DISCORD_BOT_TOKEN"])) '"'
    } else {
        return false
    }
    if (hook != "")
        url .= (InStr(url, "?") ? "&" : "?") "wait=true"   ; makes Discord reply, so we know it worked
    jsonPath := A_Temp "\ll_payload.json"
    outPath := A_Temp "\ll_curl.txt"
    try FileDelete(jsonPath)
    try FileDelete(outPath)
    FileAppend(payload, jsonPath, "UTF-8-RAW")
    cmd := '"' curl '" -s -m 40 -o "' outPath '"' auth ' -F "payload_json=<' jsonPath '" -F "files[0]=@' filePath '" "' url '"'
    try RunWait(cmd, , "Hide")
    reply := ""
    try reply := FileRead(outPath, "UTF-8")
    ok := InStr(reply, '"id"') > 0
    Log("Discord file upload " (ok ? "OK" : "failed: " SubStr(reply, 1, 200)))
    return ok
}

TestDiscord(url, g) {
    url := Trim(url)
    if !IsDiscordUrl(url) {
        MsgBox("Paste the webhook link first.`nIt starts with https://discord.com/api/webhooks/", TITLE, "Icon! Owner" g.Hwnd)
        return
    }
    SetupWebhook(url)
    if Discord("Test message: alerts are working!", url)
        MsgBox("Sent! Check your Discord channel.`nClick Save to keep the link.", TITLE, "Iconi Owner" g.Hwnd)
    else
        MsgBox("Couldn't send. Check the link and your internet.", TITLE, "Icon! Owner" g.Hwnd)
}

; Sets the webhook's own name and picture (works with just the webhook link)
SetupWebhook(url) {
    if !IsDiscordUrl(url)
        return false
    tmp := A_Temp "\lobby_loop_icon.png"
    try {
        Download(ICON_URL "?t=" A_TickCount, tmp)
    } catch {
        Log("Couldn't download the bot picture")
        return false
    }
    b64 := FileToBase64(tmp)
    if (b64 = "")
        return false
    body := '{"name":"' JsonEscape(TITLE) '","avatar":"data:image/png;base64,' b64 '"}'
    try {
        req := ComObject("WinHttp.WinHttpRequest.5.1")
        req.SetTimeouts(3000, 3000, 5000, 8000)
        req.Open("PATCH", url, false)
        req.SetRequestHeader("Content-Type", "application/json")
        req.Send(body)
        ok := (req.Status >= 200 && req.Status < 300)
        Log("Webhook name/picture " (ok ? "set" : "failed, status " req.Status))
        return ok
    } catch as e {
        Log("Webhook setup failed: " e.Message)
        return false
    }
}

FileToBase64(path) {
    try data := FileRead(path, "RAW")
    catch
        return ""
    flags := 0x40000001                   ; base64, no line breaks
    chars := 0
    DllCall("Crypt32\CryptBinaryToStringW", "Ptr", data, "UInt", data.Size, "UInt", flags, "Ptr", 0, "UInt*", &chars)
    if !chars
        return ""
    out := Buffer(chars * 2, 0)
    DllCall("Crypt32\CryptBinaryToStringW", "Ptr", data, "UInt", data.Size, "UInt", flags, "Ptr", out, "UInt*", &chars)
    return StrGet(out, "UTF-16")
}

JsonEscape(str) {
    str := StrReplace(str, "\", "\\")
    str := StrReplace(str, '"', '\"')
    str := StrReplace(str, "`r", "")
    str := StrReplace(str, "`n", "\n")
    return str
}

; ============================================================
; Auto-update (from your GitHub)
; ============================================================
UpdateUrl() {
    u := Trim(String(S["UPDATE_URL"]))
    return (u != "") ? u : UPDATE_URL_DEFAULT
}

CheckUpdate(silent := true, autoYes := false) {
    url := UpdateUrl()
    if (url = "") {
        if !silent
            MsgBox("No update link is set yet.`nPut the version.txt link in UPDATE_URL (tray > Edit all settings).", TITLE, "Iconi")
        return
    }
    tmp := A_Temp "\fnafk_version.txt"
    try {
        Download(url "?t=" A_TickCount, tmp)
        txt := FileRead(tmp)
    } catch {
        Log("Update check failed")
        if !silent
            MsgBox("Couldn't check for updates. Check your internet and the update link.", TITLE, "Icon!")
        return
    }
    if !RegExMatch(txt, "im)^\s*version\s*=\s*([\d.]+)", &vm) {
        Log("version.txt has no version= line")
        if !silent
            MsgBox("The update file doesn't have a version= line.", TITLE, "Icon!")
        return
    }
    latest := vm[1]
    if (VerCompare(latest, VERSION) <= 0) {
        Log("Up to date (v" VERSION ")")
        if !silent
            ShowTip("You have the latest version (v" VERSION ")", 3000)
        if autoYes
            Discord("**" PlayerName() "**: already on the latest version (v" VERSION ").")
        return
    }
    if (autoYes || MsgBox("Version " latest " is available (you have " VERSION ").`n`nUpdate now?", TITLE, "YesNo Iconi") = "Yes") {
        DoUpdate(url, latest)
        return
    }
    return
}

DoUpdate(url, latest) {
    folder := SubStr(url, 1, InStr(url, "/", , -1))      ; same folder as version.txt
    fileUrl := folder A_ScriptName
    tmp := A_Temp "\fnafk_update_" A_ScriptName
    try {
        Download(fileUrl "?t=" A_TickCount, tmp)
    } catch {
        MsgBox("Couldn't download " A_ScriptName ".`nIs it uploaded next to version.txt?", TITLE, "Icon!")
        return
    }
    ; sanity checks so a broken download never replaces a working copy
    good := false
    if A_IsCompiled {
        try {
            f := FileOpen(tmp, "r")
            good := f.Length > 300000 && f.ReadUShort() = 0x5A4D     ; "MZ" = a real .exe
            f.Close()
        }
    } else {
        t := FileRead(tmp)
        good := InStr(t, "#Requires AutoHotkey v2") && InStr(t, "Lobby Loop")
    }
    if !good {
        Log("Update download looked wrong, not installed")
        MsgBox("The downloaded file doesn't look right, so it wasn't installed.", TITLE, "Icon!")
        return
    }
    if running
        ToggleRun("update")
    Log("Updating to v" latest)
    Discord("Updated to v" latest)
    if A_IsCompiled {
        FileMove(A_ScriptFullPath, A_ScriptFullPath ".old", 1)   ; a running .exe can be renamed
        FileMove(tmp, A_ScriptFullPath, 1)
        Run('"' A_ScriptFullPath '"')
        ExitApp()
    } else {
        FileCopy(tmp, A_ScriptFullPath, 1)
        Reload()
    }
}

; ============================================================
; Language (English / Arabic)
; ============================================================
; Tx("English text {1}", value) returns the Arabic version when LANG = ar
Tx(text, args*) {
    if (S["LANG"] = "ar" && AR.Has(text))
        text := AR[text]
    return args.Length ? Format(text, args*) : text
}

IsArabic() {
    return S["LANG"] = "ar"
}

; GUI options for the current language (right-to-left layout for Arabic)
GuiOpts(extra := "") {
    return extra (IsArabic() ? " +E0x400000" : "")
}

LoadTranslations() {
    return Map(
        "Wake Fortnite from Sleep Mode (clicks Keep Playing)", "إيقاظ Fortnite من وضع السكون (يضغط Keep Playing)",
        "Best: in Fortnite go to Settings > Game > Energy Saving and set Sleep Mode to Never.", "الأفضل: في Fortnite اذهب إلى الإعدادات > اللعبة > توفير الطاقة واضبط وضع السكون على Never.",
        "Show the status box", "إظهار مربع الحالة",
        "Woke Fortnite from Sleep Mode", "تم إيقاظ Fortnite من وضع السكون",
        "Fortnite Sleep Mode: set it to Never (Settings > Game > Energy Saving)", "وضع السكون في Fortnite: اضبطه على Never (الإعدادات > اللعبة > توفير الطاقة)",
        "Pirate Shop Access", "وصول متجر القراصنة",
        "Gizmo", "أداة",
        "Weekly treasure cosmetic", "زي الكنز الأسبوعي",
        "Prize banner (must be on screen)", "لافتة الجائزة (يجب أن تظهر على الشاشة)",
        "Pirate Shop Access (pirate token)", "وصول متجر القراصنة (رمز القراصنة)",
        "Gizmos (Sprite Locator, Lucky Locator...)", "الأدوات (Sprite Locator، Lucky Locator...)",
        "Weekly treasure cosmetics (and any other prize)", "أزياء الكنز الأسبوعية (وأي جائزة أخرى)",
        "Separate words with commas. Start a word with ! to count it without the banner.", "افصل الكلمات بفواصل. ابدأ الكلمة بـ ! لتُحسب بدون اللافتة.",
        "Waiting for my squad to finish", "في انتظار انتهاء فريقي",
        "Don't click Play Again while my teammates are still playing", "لا تضغط Play Again بينما زملائي ما زالوا يلعبون",
        "Treasure your teammates find only counts if you're still in the match.", "الكنوز التي يجدها زملاؤك تُحسب لك فقط إذا كنت ما زلت في المباراة.",
        "'{1}' should be a number from {2} to {3}.", "يجب أن تكون '{1}' رقمًا من {2} إلى {3}.",
        "Add a screenshot", "إضافة لقطة شاشة",
        "All of it is saved in {1}. Use it to tune the treasure words.", "كل النص محفوظ في {1}. استخدمه لضبط كلمات الكنوز.",
        "Any", "أي",
        "Before readying up, Lobby Loop reads the mode button in the lobby (for example 'Build, Squad, Fill').", "قبل الاستعداد، يقرأ Lobby Loop زر الوضع في الردهة (مثلًا 'Build, Squad, Fill').",
        "Build", "البناء",
        "Check the lobby mode now", "افحص وضع الردهة الآن",
        "Click into Fortnite. Checking in {1} seconds...", "اضغط داخل Fortnite. الفحص بعد {1} ثوانٍ...",
        "Clip key", "زر المقطع",
        "Clip key pressed. Check your recorder's folder for a new clip.", "تم الضغط على زر المقطع. افحص مجلد برنامج التسجيل بحثًا عن مقطع جديد.",
        "Clip saved", "تم حفظ المقطع",
        "Clip with", "التسجيل بواسطة",
        "Couldn't read the mode button. Open the Fortnite lobby first.", "تعذرت قراءة زر الوضع. افتح ردهة Fortnite أولًا.",
        "Fill", "التعبئة",
        "Hide the status box from OBS / streams / screenshots", "إخفاء مربع الحالة عن OBS والبث ولقطات الشاشة",
        "If the mode is wrong", "إذا كان الوضع خاطئًا",
        "Keep the PC awake while running", "إبقاء الكمبيوتر مستيقظًا أثناء التشغيل",
        "Turn on Settings > Treasure to get told when you get gizmos, treasure cosmetics or pirate tokens.", "فعّل الإعدادات > الكنوز ليتم إخبارك عندما تحصل على أدوات أو أزياء كنوز أو رموز قراصنة.",
        "Start by itself, every day or with Windows.", "يبدأ وحده، كل يوم أو مع Windows.",
        "Lobby Loop keeps you in squad fills while you're away, so your teammates can farm chests for you while you bot.", "يبقيك Lobby Loop في فرق التعبئة أثناء غيابك، ليفتح زملاؤك الصناديق ويجمعوا لك وأنت تستخدم البوت.",
        "Lobby is on: {1}", "الردهة على: {1}",
        "Your teammates open chests and farm while you bot. Lobby Loop keeps you queued, moving and out of the way.", "زملاؤك يفتحون الصناديق ويجمعون وأنت تستخدم البوت. يبقيك Lobby Loop في الطابور ويتحرك ولا يعيقهم.",
        "Mode", "الوضع",
        "Mode check", "فحص الوضع",
        "My own clip key (Medal, OBS...)", "زر المقطع الخاص بي (Medal، OBS...)",
        "My own words", "كلماتي الخاصة",
        "NVIDIA (Alt+F10)", "NVIDIA (Alt+F10)",
        "No fill", "بدون تعبئة",
        "No text found on screen.", "لم يُعثر على نص في الشاشة.",
        "No treasure found yet.", "لم يُعثر على كنوز بعد.",
        "On some PCs this also hides it from your screen. Turn it off if the status box disappears.", "على بعض الأجهزة يخفيه هذا عن شاشتك أيضًا. أوقفه إذا اختفى مربع الحالة.",
        "Or set Fortnite's volume while running (0-100, 100 = leave it):", "أو اضبط صوت Fortnite أثناء التشغيل (0-100، 100 = اتركه):",
        "Pick a clip method, or type your clip key first.", "اختر طريقة التسجيل، أو اكتب زر المقطع أولًا.",
        "Play a sound", "تشغيل صوت",
        "Read the screen now", "اقرأ الشاشة الآن",
        "Reading the screen...", "جارٍ قراءة الشاشة...",
        "Ready up anyway", "استعد على أي حال",
        "Recent finds", "آخر ما وُجد",
        "Save a clip (20 s before + 5 s after)", "حفظ مقطع (20 ث قبل + 5 ث بعد)",
        "Send the clip to Discord (if under 10 MB)", "إرسال المقطع إلى Discord (إذا كان أقل من 10 ميغابايت)",
        "Set your recorder's clip length to 25 seconds (Game Bar: 30).", "اضبط طول المقطع في برنامج التسجيل على 25 ثانية (Game Bar: ‏30).",
        "Spots treasure on screen and tells you, with a screenshot or a clip.", "يرصد الكنوز على الشاشة ويخبرك، مع لقطة شاشة أو مقطع.",
        "Squad fill", "تعبئة الفريق",
        "Stop after this many matches (0 = no limit):", "التوقف بعد هذا العدد من المباريات (0 = بلا حد):",
        "Stopped: {1} matches done", "توقف: انتهت {1} مباريات",
        "Team size", "حجم الفريق",
        "Tell Discord", "إخبار Discord",
        "Test the clip key", "اختبار زر المقطع",
        "The lobby is on {1}, you wanted {2}.", "الردهة على {1}، وأنت أردت {2}.",
        "The switch clicks the mode button and then the words for your mode. If it doesn't work, use Report a bug with a screenshot of the mode screen.", "يضغط التبديل على زر الوضع ثم على كلمات وضعك. إذا لم ينجح، استخدم الإبلاغ عن خطأ مع لقطة لشاشة الوضع.",
        "Treasure", "الكنوز",
        "Try to switch the mode for me (experimental)", "حاول تبديل الوضع لي (تجريبي)",
        "Wait (seconds)", "الانتظار (ثوانٍ)",
        "Wait and tell me", "انتظر وأخبرني",
        "Watch for treasure", "مراقبة الكنوز",
        "Weekly treasure cosmetics", "أزياء الكنوز الأسبوعية",
        "What Lobby Loop reads on screen", "ما يقرؤه Lobby Loop على الشاشة",
        "What to look for", "عمّ تبحث",
        "When I find treasure", "عندما أجد كنزًا",
        "Windows Game Bar (Win+Alt+G)", "شريط ألعاب Windows ‏(Win+Alt+G)",
        "Windows notification", "إشعار Windows",
        "Wrong mode", "وضع خاطئ",
        "Wrong mode, waiting (Settings > Mode)", "وضع خاطئ، في الانتظار (الإعدادات > الوضع)",
        "You want: {1}", "أنت تريد: {1}",
        "any", "أي",
        "Start / Stop", "تشغيل / إيقاف",
        "Accent colour", "لون التمييز",
        "Add Start menu and Desktop shortcuts", "إضافة اختصارات قائمة ابدأ وسطح المكتب",
        "Add shortcuts", "إضافة اختصارات",
        "Added {1} to the Start menu and your Desktop.", "تمت إضافة {1} إلى قائمة ابدأ وسطح المكتب.",
        "Also delete your settings, stats and history?", "حذف الإعدادات والإحصائيات والسجل أيضًا؟",
        "Buttons you taught with {1}. They're clicked whenever they show up.", "الأزرار التي علّمتها بـ {1}. يُضغط عليها كلما ظهرت.",
        "Card", "بطاقة",
        "Click reward buttons (Continue, Collect, Claim...)", "الضغط على أزرار المكافآت (Continue، Collect، Claim...)",
        "Clicked '{1}'", "تم الضغط على '{1}'",
        "Copied. Send it to a friend.", "تم النسخ. أرسله لصديق.",
        "Copy my code", "نسخ رمزي",
        "Cyan", "سماوي",
        "Dim screen, mute, text reading, treasure watcher, reward clicks and live status are off until you restart it.", "تعتيم الشاشة والكتم وقراءة النص ومراقبة الكنوز والضغط على المكافآت والحالة المباشرة متوقفة حتى تعيد التشغيل.",
        "Forget", "نسيان",
        "Forget all", "نسيان الكل",
        "Forgot popup button #{1}.", "تم نسيان زر النافذة المنبثقة #{1}.",
        "Green", "أخضر",
        "Live status message (shows when the PC went offline)", "رسالة حالة مباشرة (تُظهر متى انقطع الكمبيوتر)",
        "Loaded {1} settings. Lobby Loop restarts now.", "تم تحميل {1} إعداد. سيُعاد تشغيل Lobby Loop الآن.",
        "Lobby Loop didn't close properly last time.", "لم يُغلق Lobby Loop بشكل صحيح في المرة السابقة.",
        "Mini", "مصغّر",
        "No learned popup button under the mouse.", "لا يوجد زر نافذة منبثقة محفوظ تحت المؤشر.",
        "No popup buttons learned yet.", "لا توجد أزرار نوافذ منبثقة محفوظة بعد.",
        "Open a GitHub issue", "فتح بلاغ على GitHub",
        "Pause 15 minutes", "إيقاف مؤقت 15 دقيقة",
        "Paused for {1} minutes.", "متوقف مؤقتًا لمدة {1} دقيقة.",
        "Pink", "وردي",
        "Popups", "النوافذ المنبثقة",
        "Post the control panel", "نشر لوحة التحكم",
        "Purple", "بنفسجي",
        "Remove {1} from this PC?", "إزالة {1} من هذا الكمبيوتر؟",
        "Report a bug", "الإبلاغ عن خطأ",
        "Safe mode", "الوضع الآمن",
        "Screenshot to Discord every (minutes, 0 = off):", "لقطة شاشة إلى Discord كل (دقائق، 0 = معطل):",
        "Send to my Discord", "إرسال إلى Discord الخاص بي",
        "Settings code (your profile, timers, movement and look. No names or Discord links):", "رمز الإعدادات (ملفك ومؤقتاتك وحركتك ومظهرك. بدون أسماء أو روابط Discord):",
        "Share & tools", "المشاركة والأدوات",
        "Share your setup with friends, report bugs, install or remove.", "شارك إعدادك مع أصدقائك، أبلغ عن الأخطاء، ثبّت أو أزل.",
        "Spectating teammates", "يشاهد زملاء الفريق",
        "Status box style", "نمط صندوق الحالة",
        "Stop moving while I'm spectating teammates", "إيقاف الحركة أثناء مشاهدة زملاء الفريق",
        "That code didn't work. It should start with LL75-", "هذا الرمز لم يعمل. يجب أن يبدأ بـ LL75-",
        "This removes the shortcuts, Start with Windows and the program file.", "سيؤدي هذا إلى إزالة الاختصارات والتشغيل مع Windows وملف البرنامج.",
        "To teach one: hover over an empty part of the popup's button and press {1}. To forget the one under the mouse: Shift+{1}.", "لتعليم زر: ضع المؤشر على جزء فارغ من زر النافذة واضغط {1}. لنسيان الزر تحت المؤشر: Shift+{1}.",
        "Tools", "الأدوات",
        "Treasure words (separated by commas):", "كلمات الكنوز (مفصولة بفواصل):",
        "Treasure!", "كنز!",
        "Type !help in your channel to see all 30+ commands.", "اكتب !help في قناتك لرؤية أكثر من 30 أمرًا.",
        "Uninstall", "إلغاء التثبيت",
        "Use the pasted code", "استخدام الرمز الملصق",
        "Watch for treasure (gizmos, pirate tokens...)", "مراقبة الكنوز (gizmos، رموز القراصنة...)",
        "What happened? (what you did, what you expected, what went wrong)", "ماذا حدث؟ (ماذا فعلت، ماذا توقعت، ما الخطأ)",
        "Yellow", "أصفر",
        "Your log and version are added for you. Nothing personal is sent.", "يُضاف السجل والإصدار تلقائيًا. لا يُرسل أي شيء شخصي.",
        "Stop timer", "مؤقت الإيقاف",
        "30 minutes", "30 دقيقة",
        "1 hour", "ساعة",
        "2 hours", "ساعتان",
        "4 hours", "4 ساعات",
        "8 hours", "8 ساعات",
        "No limit", "بلا حد",
        "Custom...", "مخصص...",
        "Move status box", "تحريك صندوق الحالة",
        "Keyboard shortcuts", "اختصارات لوحة المفاتيح",
        "this run", "هذه الجلسة",
        "Drag the status box where you want it. It saves by itself after 20 seconds.", "اسحب صندوق الحالة إلى المكان الذي تريده. يُحفظ تلقائيًا بعد 20 ثانية.",
        "Status box position saved.", "تم حفظ موضع صندوق الحالة.",
        "Where I dragged it", "حيث سحبته",
        "Windows notifications (stopped, stuck, crashed)", "إشعارات Windows (توقف، تعليق، تعطل)",
        "Fortnite isn't running. Opening it (try {1}).", "Fortnite لا يعمل. جارٍ فتحه (المحاولة {1}).",
        "Looks stuck", "يبدو عالقًا",
        "No match finished in {1} minutes. Trying to fix it.", "لم تنته أي مباراة خلال {1} دقيقة. جارٍ المحاولة لإصلاح ذلك.",
        "Fortnite is open", "Fortnite مفتوح",
        "Fortnite is the active window", "Fortnite هو النافذة النشطة",
        "Click into Fortnite before starting", "اضغط داخل Fortnite قبل التشغيل",
        "Running as Administrator", "يعمل كمسؤول",
        "Lobby Ready / Play button", "زر جاهز / لعب في الردهة",
        "End-of-match Play Again button", "زر العب مجددًا بعد المباراة",
        "found", "تم العثور عليه",
        "not on screen right now", "غير ظاهر على الشاشة الآن",
        "Start: {1}", "التشغيل: {1}",
        "on", "مفعّل",
        "off", "معطّل",
        "Updates", "التحديثات",
        "Screen {1}", "الشاشة {1}",
        "Learned popup buttons: {1}", "أزرار النوافذ المنبثقة المحفوظة: {1}",
        "Closes by itself, or press {1} again.", "يُغلق تلقائيًا، أو اضغط {1} مجددًا.",
        "Double-click the tray icon to start or stop", "انقر نقرًا مزدوجًا على أيقونة الشريط للتشغيل أو الإيقاف",
        "Change them in Settings > Hotkeys.", "غيّرها من الإعدادات > مفاتيح الاختصار.",
        "Hotkeys", "مفاتيح الاختصار",
        "Change the keys if they clash with your game or keyboard.", "غيّر المفاتيح إن تعارضت مع لعبتك أو لوحة المفاتيح.",
        "Lobby Loop keys", "مفاتيح Lobby Loop",
        "Your Fortnite keys", "مفاتيح Fortnite الخاصة بك",
        "Teach a popup button", "تعليم زر نافذة منبثقة",
        "Weapon slots", "خانات الأسلحة",
        "Examples: F8, Insert, Numpad0, ^!s (Ctrl+Alt+S), +F8 (Shift+F8). Lobby Loop restarts after you save.", "أمثلة: F8، Insert، Numpad0، ^!s (Ctrl+Alt+S)، +F8 (Shift+F8). يُعاد تشغيل Lobby Loop بعد الحفظ.",
        "Play", "اللعب",
        "Schedule", "الجدولة",
        "Discord alerts", "تنبيهات Discord",
        "Phone control", "التحكم من الهاتف",
        "Look", "المظهر",
        "How long it runs and what happens after.", "مدة التشغيل وما يحدث بعدها.",
        "Start by itself, every day or with Windows.", "التشغيل تلقائيًا، كل يوم أو مع Windows.",
        "Comfort and stats while it runs.", "راحة وإحصائيات أثناء التشغيل.",
        "Messages, screenshots and a daily summary in your channel.", "رسائل ولقطات شاشة وملخص يومي في قناتك.",
        "Control Lobby Loop from Discord on your phone (optional).", "تحكم في Lobby Loop من Discord على هاتفك (اختياري).",
        "Language, theme and the status box.", "اللغة والمظهر وصندوق الحالة.",
        "Theme", "المظهر",
        "Dark", "داكن",
        "Light", "فاتح",
        "Status box corner", "زاوية صندوق الحالة",
        "Top left", "أعلى اليسار",
        "Top right", "أعلى اليمين",
        "Bottom left", "أسفل اليسار",
        "Bottom right", "أسفل اليمين",
        "Status box size", "حجم صندوق الحالة",
        "Small", "صغير",
        "Normal", "عادي",
        "Large", "كبير",
        "How do I get this?", "كيف أحصل عليه؟",
        "How do I set this up?", "كيف أعد هذا؟",
        "Open Developer Portal", "فتح بوابة المطورين",
        "Phone control setup (about 5 minutes)", "إعداد التحكم من الهاتف (حوالي 5 دقائق)",
        "Discord alerts setup (about 1 minute)", "إعداد تنبيهات Discord (حوالي دقيقة)",
        "Click 'Open Developer Portal' below, then New Application, and name it Lobby Loop.", "اضغط 'فتح بوابة المطورين' بالأسفل، ثم New Application، وسمّه Lobby Loop.",
        "Click Bot (left menu), then Reset Token, then Copy. Paste it into 'Bot token'. Never share it.", "اضغط Bot (القائمة اليسرى)، ثم Reset Token، ثم Copy. الصقه في 'رمز البوت'. لا تشاركه أبدًا.",
        "On the same Bot page, turn on 'Message Content Intent' and click Save Changes.", "في نفس صفحة Bot، فعّل 'Message Content Intent' واضغط Save Changes.",
        "Click OAuth2, then URL Generator. Tick 'bot', then Send Messages, Read Message History and Attach Files.", "اضغط OAuth2، ثم URL Generator. حدد 'bot'، ثم Send Messages و Read Message History و Attach Files.",
        "Open the link at the bottom of that page and add the bot to your server.", "افتح الرابط أسفل تلك الصفحة وأضف البوت إلى خادمك.",
        "In Discord: User Settings, Advanced, turn on Developer Mode.", "في Discord: إعدادات المستخدم، Advanced، فعّل Developer Mode.",
        "Right-click your channel and Copy Channel ID. Right-click your name and Copy User ID. Paste both here.", "اضغط بزر الفأرة الأيمن على قناتك واختر Copy Channel ID. ثم على اسمك واختر Copy User ID. الصق الاثنين هنا.",
        "Click Save, then type !status in the channel. Lobby Loop answers in a few seconds.", "اضغط حفظ، ثم اكتب !status في القناة. سيرد Lobby Loop خلال ثوانٍ.",
        "Commands: !start  !stop  !status  !ss (screenshot)  !log  !summary  !lb (leaderboard)  !dim. Add a name to control one PC, e.g. !stop zen", "الأوامر: !start  !stop  !status  !ss (لقطة شاشة)  !log  !summary  !lb (المتصدرين)  !dim. أضف اسمًا للتحكم بجهاز واحد، مثل !stop zen",
        "In Discord, right-click the channel for alerts and click Edit Channel.", "في Discord، اضغط بزر الفأرة الأيمن على قناة التنبيهات واختر Edit Channel.",
        "Click Integrations, then Webhooks, then New Webhook.", "اضغط Integrations، ثم Webhooks، ثم New Webhook.",
        "Click the new webhook, then Copy Webhook URL.", "اضغط على الـ Webhook الجديد، ثم Copy Webhook URL.",
        "Paste it into 'Discord alert link', click Send test message, then Save.", "الصقه في 'رابط تنبيهات Discord'، اضغط إرسال رسالة تجريبية، ثم حفظ.",
        "Lobby Loop sets the webhook's name and picture for you.", "يضبط Lobby Loop اسم وصورة الـ Webhook تلقائيًا.",
        "Keep the link private: anyone who has it can post in your channel.", "احتفظ بالرابط سرًا: أي شخص يملكه يمكنه النشر في قناتك.",
        "Settings", "الإعدادات",
        "Self-test", "فحص",
        "Setup wizard", "معالج الإعداد",
        "Profile", "الملف الشخصي",
        "Overnight", "طوال الليل",
        "Quick 1 hour", "ساعة سريعة",
        "Chill", "هادئ",
        "Custom", "مخصص",
        "Dim screen", "تعتيم الشاشة",
        "Show / hide status box", "إظهار / إخفاء صندوق الحالة",
        "Stats dashboard", "لوحة الإحصائيات",
        "Open history (Excel)", "فتح السجل (Excel)",
        "Send screenshot to Discord", "إرسال لقطة شاشة إلى Discord",
        "Send log to Discord", "إرسال السجل إلى Discord",
        "Forget learned popup buttons", "نسيان أزرار النوافذ المنبثقة",
        "Check for updates", "التحقق من التحديثات",
        "What's new", "ما الجديد",
        "Edit all settings (advanced)", "تعديل كل الإعدادات (متقدم)",
        "Open log", "فتح السجل",
        "Reload", "إعادة التحميل",
        "Exit", "خروج",
        "ON", "يعمل",
        "OFF", "متوقف",
        "Matches", "المباريات",
        "Clicks", "النقرات",
        "{1} = start,  {2} = settings", "{1} = تشغيل،  {2} = الإعدادات",
        "Stop: {1}", "الإيقاف: {1}",
        "Stops in {1}", "يتوقف بعد {1}",
        "Stops in {1}   (at {2})", "يتوقف بعد {1}   (الساعة {2})",
        "Stop: no limit ({1} to set)", "الإيقاف: بلا حد ({1} للضبط)",
        "Starts at {1}", "يبدأ الساعة {1}",
        "then {1}", "ثم {1}",
        "All time: {1} matches, {2}h {3}m", "الإجمالي: {1} مباراة، {2} س {3} د",
        "no limit", "بلا حد",
        "manual", "يدوي",
        "Just stop", "إيقاف فقط",
        "Close Fortnite", "إغلاق Fortnite",
        "Sleep the PC", "وضع الكمبيوتر في السكون",
        "Shut down the PC", "إيقاف تشغيل الكمبيوتر",
        "Running", "يعمل",
        "Stopped", "متوقف",
        "Walking", "يمشي",
        "Diving", "يقفز بالمظلة",
        "Sliding", "ينزلق",
        "Crouch-walking", "يمشي منحنيًا",
        "Strafing", "يتحرك جانبيًا",
        "Standing still", "واقف",
        "Paused: click into Fortnite", "متوقف مؤقتًا: اضغط داخل Fortnite",
        "Waiting: Fortnite is not open", "بانتظار فتح Fortnite",
        "Ready / Play clicked, waiting for match", "تم الضغط على جاهز / لعب، بانتظار المباراة",
        "Match {1} done, Play Again clicked", "انتهت المباراة {1}، تم الضغط على العب مجددًا",
        "Clicked a popup button", "تم الضغط على زر نافذة منبثقة",
        "Press {1} to start", "اضغط {1} للتشغيل",
        "{1} loaded.", "تم تحميل {1}.",
        "{1} = start/stop   {2} = settings   {3} = self-test", "{1} = تشغيل/إيقاف   {2} = الإعدادات   {3} = فحص",
        "This run: {1}", "هذه الجلسة: {1}",
        "Cancelled", "تم الإلغاء",
        "Press {1} to cancel", "اضغط {1} للإلغاء",
        "{1} in {2} s", "{1} خلال {2} ث",
        "Saved.", "تم الحفظ.",
        "Save", "حفظ",
        "Cancel", "إلغاء",
        "Back", "رجوع",
        "Next", "التالي",
        "Finish", "إنهاء",
        "Send test message", "إرسال رسالة تجريبية",
        "Language", "اللغة",
        "Your name (for Discord and the leaderboard):", "اسمك (لـ Discord ولوحة المتصدرين):",
        "Stop after a time, or at a clock time:", "الإيقاف بعد مدة، أو في ساعة محددة:",
        "e.g.   2h    90m    1h30m    9:30 PM    21:30      (blank = never)", "مثال:   2h    90m    1h30m    9:30 PM    21:30      (فارغ = أبدًا)",
        "When it stops:", "عند الإيقاف:",
        "Close / sleep / shut down wait 30 s first. Press {1} to cancel.", "الإغلاق / السكون / الإيقاف ينتظر 30 ث أولًا. اضغط {1} للإلغاء.",
        "Start every day at:", "التشغيل كل يوم الساعة:",
        "e.g.   2:00 AM    14:30      (blank = off, Fortnite must be logged in)", "مثال:   2:00 AM    14:30      (فارغ = معطل، يجب تسجيل الدخول في Fortnite)",
        "Start by itself when I click into Fortnite", "التشغيل تلقائيًا عند الضغط داخل Fortnite",
        "Open Fortnite by itself (scheduled start, crash, stuck)", "فتح Fortnite تلقائيًا (التشغيل المجدول، التعطل، التعليق)",
        "Mute Fortnite while running", "كتم صوت Fortnite أثناء التشغيل",
        "Dim the screen while running", "تعتيم الشاشة أثناء التشغيل",
        "Start with Windows", "التشغيل مع Windows",
        "Read my placement and XP after each match", "قراءة ترتيبي ونقاط الخبرة بعد كل مباراة",
        "Screenshot to Discord after every match", "إرسال لقطة شاشة إلى Discord بعد كل مباراة",
        "Daily Discord summary at (blank = off):", "ملخص يومي على Discord الساعة (فارغ = معطل):",
        "Discord alert link (optional):", "رابط تنبيهات Discord (اختياري):",
        "Paste your Discord webhook link here. Blank = no alerts.", "الصق رابط Webhook هنا. فارغ = بدون تنبيهات.",
        "Phone control (Discord bot, optional):", "التحكم من الهاتف (بوت Discord، اختياري):",
        "Bot token", "رمز البوت",
        "Channel ID", "معرف القناة",
        "Your Discord user ID (only you can control it)", "معرف مستخدم Discord الخاص بك (أنت فقط يمكنك التحكم)",
        "Welcome to Lobby Loop", "مرحبًا بك في Lobby Loop",
        "Pick your language and your name.", "اختر لغتك واسمك.",
        "How do you want to play?", "كيف تريد أن تلعب؟",
        "Overnight: runs 8 hours, dims the screen, mutes the game, then puts the PC to sleep", "طوال الليل: يعمل 8 ساعات، يعتم الشاشة، يكتم اللعبة، ثم يضع الكمبيوتر في السكون",
        "Quick 1 hour: runs for 1 hour, then stops", "ساعة سريعة: يعمل لمدة ساعة ثم يتوقف",
        "Chill: 3 hours with calmer, slower movement", "هادئ: 3 ساعات بحركة أهدأ وأبطأ",
        "Custom: keep my own settings", "مخصص: احتفظ بإعداداتي",
        "Your Fortnite keys (change them if you don't use the defaults):", "مفاتيح Fortnite الخاصة بك (غيّرها إن لم تستخدم الافتراضية):",
        "Forward", "للأمام",
        "Left", "يسار",
        "Back", "رجوع",
        "Right", "يمين",
        "Jump", "قفز",
        "Sprint", "ركض",
        "Crouch", "انحناء",
        "Discord alerts (optional). Leave blank to skip.", "تنبيهات Discord (اختياري). اتركه فارغًا للتخطي.",
        "Extras", "إضافات",
        "All set!", "كل شيء جاهز!",
        "1. Open Fortnite in Windowed Fullscreen and go to the lobby.", "1. افتح Fortnite في وضع ملء الشاشة بنافذة واذهب إلى الردهة.",
        "2. Press {1} to check that the buttons are found.", "2. اضغط {1} للتأكد من العثور على الأزرار.",
        "3. Press {1} to start. Press it again to stop.", "3. اضغط {1} للتشغيل. اضغط مجددًا للإيقاف.",
        "Step {1} of {2}", "الخطوة {1} من {2}",
        "Profile: {1}", "الملف الشخصي: {1}",
        "Screen dimmed by Lobby Loop. Press {1} to undo.", "الشاشة معتمة بواسطة Lobby Loop. اضغط {1} للتراجع.",
        "No history yet. It's saved every time you stop.", "لا يوجد سجل بعد. يُحفظ في كل مرة تتوقف فيها.",
        "Discord isn't set up. Press {1} and paste your webhook link.", "Discord غير مُعد. اضغط {1} والصق رابط Webhook.",
        "Sent to Discord", "تم الإرسال إلى Discord",
        "Couldn't send to Discord", "تعذر الإرسال إلى Discord"
    )
}

; ============================================================
; Profiles
; ============================================================

ProfileLabel(key) {
    labels := Map("overnight", "Overnight", "quick", "Quick 1 hour", "chill", "Chill", "custom", "Custom")
    return Tx(labels.Has(key) ? labels[key] : "Custom")
}

ApplyProfile(key) {
    if PROFILES.Has(key) {
        for setting, value in PROFILES[key]
            SetSetting(setting, value)
    }
    SetSetting("PROFILE", key)
    if running
        ApplyStopLimits()
    BuildProfileMenu()
    Log("Profile: " key)
}

BuildProfileMenu() {
    global profileMenu
    try profileMenu.Delete()
    for key in PROFILE_KEYS {
        name := ProfileLabel(key)
        profileMenu.Add(name, ProfileMenuPick.Bind(key))
        if (S["PROFILE"] = key)
            profileMenu.Check(name)
    }
}

ProfileMenuPick(key, *) {
    ApplyProfile(key)
    ShowTip(Tx("Profile: {1}", ProfileLabel(key)) "`n" Tx("Stop: {1}", DescribeStop()), 3000)
}

; ============================================================
; Status box position, size and visibility
; ============================================================
PlaceOverlay() {
    if (statusTxt = "")
        return
    statusGui.GetPos(, , &w, &h)
    corner := StrLower(String(S["OVERLAY_CORNER"]))
    if (corner = "custom") {
        x := Max(0, Min(Integer(S["OVERLAY_X"]), A_ScreenWidth - w))
        y := Max(0, Min(Integer(S["OVERLAY_Y"]), A_ScreenHeight - h))
    } else {
        x := InStr(corner, "right") ? A_ScreenWidth - w - 12 : 12
        y := InStr(corner, "bottom") ? A_ScreenHeight - h - 60 : 12
    }
    statusGui.Move(x, y)
}

BuildOverlay() {
    global statusGui, statusTxt, OV
    sizes := Map("small", [9, 360], "normal", [10, 420], "large", [12, 510])
    sz := sizes.Has(StrLower(S["OVERLAY_SIZE"])) ? sizes[StrLower(S["OVERLAY_SIZE"])] : sizes["normal"]
    fs := sz[1], W := sz[2], pad := 16, inner := sz[2] - 32
    al := IsArabic() ? " Right" : ""
    statusGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +E0x08000000")
    if S["STREAM_HIDE"]
        DllCall("SetWindowDisplayAffinity", "Ptr", statusGui.Hwnd, "UInt", 0x11)   ; hidden from OBS / screenshots
    statusGui.BackColor := "15152B"
    statusGui.MarginX := pad, statusGui.MarginY := 10
    statusGui.SetFont("s" (fs + 4) " c777790", "Segoe UI")
    OV["dot"] := statusGui.Add("Text", "x" pad " y6 w" (fs * 2 + 4) " BackgroundTrans", "●")
    statusGui.SetFont("s" (fs + 1) " bold cECECF4")
    if (StrLower(S["OVERLAY_STYLE"]) = "mini") {
        OV["head"] := statusGui.Add("Text", "x+2 yp+5 w" (W - 70) " BackgroundTrans" al, TITLE)
        statusTxt := OV["head"]
        statusGui.MarginY := 6
        statusGui.Show("x-4000 y-4000 NoActivate AutoSize")
        WinSetTransparent(228, statusGui)
        statusGui.GetPos(, , &w, &h)
        WinSetRegion("0-0 w" w " h" h " R" h "-" h, statusGui)
        PlaceOverlay()
        Log("Status box (mini) ready")
        return
    }
    OV["head"] := statusGui.Add("Text", "x+2 yp+5 w" (inner - fs * 2 - 6) " BackgroundTrans" al, TITLE)
    statusGui.SetFont("s" fs " norm cD0D0E8")
    OV["now"] := statusGui.Add("Text", "x" pad " y+6 w" inner " BackgroundTrans" al, "")
    OV["bar"] := statusGui.Add("Progress", "x" pad " y+8 w" inner " h5 c" AccentHex() " Background2A2A4E", 0)
    statusGui.SetFont("s" (fs - 1) " norm cA0A0C0")
    OV["timer"] := statusGui.Add("Text", "x" pad " y+6 w" inner " BackgroundTrans" al, "")
    OV["run"] := statusGui.Add("Text", "x" pad " y+4 w" inner " BackgroundTrans" al, "")
    OV["total"] := statusGui.Add("Text", "x" pad " y+4 w" inner " BackgroundTrans" al, "")
    statusTxt := OV["now"]
    statusGui.Show("x-4000 y-4000 NoActivate AutoSize")
    WinSetTransparent(228, statusGui)
    statusGui.GetPos(, , &w, &h)
    WinSetRegion("0-0 w" w " h" h " R20-20", statusGui)
    PlaceOverlay()
    statusGui.GetPos(&ox, &oy, &ow, &oh)
    Log("Status box at " ox "," oy " (" ow "x" oh ")")
}

; Lets you drag the status box with the mouse; clicking the menu item again (or 20 s) saves the spot
MoveOverlay() {
    global movingOverlay
    if (statusTxt = "")
        return
    if overlayHidden
        ToggleOverlay()
    if movingOverlay {
        FinishMoveOverlay()
        return
    }
    movingOverlay := true
    WinSetExStyle("-0x20", statusGui)
    WinSetTransparent(255, statusGui)
    OnMessage(0x201, OverlayDrag)
    ShowTip(Tx("Drag the status box where you want it. It saves by itself after 20 seconds."), 4000)
    SetTimer(FinishMoveOverlay, -20000)
}

OverlayDrag(wParam, lParam, msg, hwnd) {
    if !movingOverlay
        return
    if (DllCall("GetAncestor", "Ptr", hwnd, "UInt", 2, "Ptr") = statusGui.Hwnd) {
        PostMessage(0xA1, 2, 0, , "ahk_id " statusGui.Hwnd)     ; drag by the "title bar"
        return 0
    }
}

FinishMoveOverlay() {
    global movingOverlay
    if !movingOverlay
        return
    SetTimer(FinishMoveOverlay, 0)
    movingOverlay := false
    OnMessage(0x201, OverlayDrag, 0)
    WinSetExStyle("+0x20", statusGui)
    WinSetTransparent(228, statusGui)
    statusGui.GetPos(&x, &y)
    SetSetting("OVERLAY_X", x)
    SetSetting("OVERLAY_Y", y)
    SetSetting("OVERLAY_CORNER", "custom")
    ShowTip(Tx("Status box position saved."), 2000)
}

Notify(heading, msg) {
    if S["NOTIFY"]
        try TrayTip(msg, TITLE " · " heading, "Iconi Mute")
}

QuickTimer(h, m, *) {
    SaveStop(h, m, "")
    if running
        ApplyStopLimits()
    Log("Quick stop timer: " DescribeStop())
    ShowTip(Tx("Stop: {1}", DescribeStop()), 2500)
}

ToggleOverlay(want := -1) {
    global overlayHidden
    if (statusTxt = "")
        return
    overlayHidden := (want = -1) ? !overlayHidden : !want
    if overlayHidden
        statusGui.Hide()
    else
        statusGui.Show("NoActivate")
    SetSetting("SHOW_OVERLAY", overlayHidden ? 0 : 1)      ; remembered next time
}

; ============================================================
; Dim screen (black layer that screen capture can't see, so detection still works)
; ============================================================
ToggleBlackout(want := -1) {
    global blackoutGui
    if (want = -1)
        want := (blackoutGui = "")
    if (want && blackoutGui = "") {
        g := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +E0x08000000")
        g.BackColor := "000000"
        g.SetFont("s10", "Segoe UI")
        g.Add("Text", "c404040 x20 y" (A_ScreenHeight - 40) " w" (A_ScreenWidth - 40), Tx("Screen dimmed by Lobby Loop. Press {1} to undo.", HK_BLACKOUT))
        g.Show("x0 y0 w" A_ScreenWidth " h" A_ScreenHeight " NoActivate")
        WinSetTransparent(254, g)
        DllCall("SetWindowDisplayAffinity", "Ptr", g.Hwnd, "UInt", 0x11)   ; hidden from screen capture
        blackoutGui := g
        if (statusTxt != "" && !overlayHidden)
            statusGui.Show("NoActivate")                                 ; keep the status box on top
        Log("Screen dimmed")
    } else if (!want && blackoutGui != "") {
        blackoutGui.Destroy()
        blackoutGui := ""
        Log("Screen back to normal")
    }
}

; ============================================================
; Mute Fortnite (Windows per-app volume)
; ============================================================
SetGameMute(mute) {
    pid := ProcessExist(GameExe())
    if !pid
        return false
    found := false
    dev := 0, mgr := 0, sessEnum := 0
    try {
        enumr := ComObject("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
        ComCall(4, enumr, "Int", 0, "Int", 1, "Ptr*", &dev)                       ; GetDefaultAudioEndpoint
        ComCall(3, dev, "Ptr", GuidBuf("{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"), "UInt", 23, "Ptr", 0, "Ptr*", &mgr) ; Activate
        ComCall(5, mgr, "Ptr*", &sessEnum)                                       ; GetSessionEnumerator
        cnt := 0
        ComCall(3, sessEnum, "Int*", &cnt)
        loop cnt {
            ctl := 0
            ComCall(4, sessEnum, "Int", A_Index - 1, "Ptr*", &ctl)
            try {
                ctl2 := ComObjQuery(ctl, "{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}")
                spid := 0
                ComCall(14, ctl2, "UInt*", &spid)                                 ; GetProcessId
                if (spid = pid) {
                    vol := ComObjQuery(ctl, "{87CE5498-68D6-44E5-9215-6F24D7ED6E4E}")
                    ComCall(5, vol, "Int", mute ? 1 : 0, "Ptr", 0)                ; SetMute
                    found := true
                }
            }
            ObjRelease(ctl)
        }
    } catch as e {
        Log("Mute failed: " e.Message)
    }
    for p in [sessEnum, mgr, dev]
        if p
            ObjRelease(p)
    if found
        Log(mute ? "Fortnite muted" : "Fortnite unmuted")
    return found
}

GuidBuf(str) {
    buf := Buffer(16, 0)
    DllCall("ole32\CLSIDFromString", "WStr", str, "Ptr", buf)
    return buf
}

; ============================================================
; Start with Windows (a logon task, so it starts as Administrator without a prompt)
; ============================================================
SetStartWithWindows(on) {
    task := "Lobby Loop - " BASE
    if on {
        tr := A_IsCompiled ? '\"' A_ScriptFullPath '\"' : '\"' A_AhkPath '\" \"' A_ScriptFullPath '\"'
        cmd := 'schtasks /Create /F /RL HIGHEST /SC ONLOGON /DELAY 0000:30 /TN "' task '" /TR "' tr '"'
    } else {
        cmd := 'schtasks /Delete /F /TN "' task '"'
    }
    code := RunWait(A_ComSpec ' /c ' cmd, , "Hide")
    Log("Start with Windows " (on ? "on" : "off") ": exit code " code)
    return code = 0
}

; ============================================================
; Screenshots (GDI+)
; ============================================================
GdipStart() {
    static token := 0
    if token
        return token
    DllCall("LoadLibrary", "Str", "gdiplus", "Ptr")
    si := Buffer(24, 0)
    NumPut("UInt", 1, si, 0)
    DllCall("gdiplus\GdiplusStartup", "Ptr*", &token, "Ptr", si, "Ptr", 0)
    return token
}

; Saves part of the screen as .jpg or .png. Returns true on success.
SaveRegionImage(path, x, y, w, h) {
    GdipStart()
    hdcScreen := DllCall("GetDC", "Ptr", 0, "Ptr")
    hdcMem := DllCall("CreateCompatibleDC", "Ptr", hdcScreen, "Ptr")
    hbm := DllCall("CreateCompatibleBitmap", "Ptr", hdcScreen, "Int", w, "Int", h, "Ptr")
    obm := DllCall("SelectObject", "Ptr", hdcMem, "Ptr", hbm, "Ptr")
    DllCall("BitBlt", "Ptr", hdcMem, "Int", 0, "Int", 0, "Int", w, "Int", h, "Ptr", hdcScreen, "Int", x, "Int", y, "UInt", 0x00CC0020)
    DllCall("SelectObject", "Ptr", hdcMem, "Ptr", obm)
    DllCall("DeleteDC", "Ptr", hdcMem)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdcScreen)
    pBitmap := 0
    DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Ptr", hbm, "Ptr", 0, "Ptr*", &pBitmap)
    DllCall("DeleteObject", "Ptr", hbm)
    if !pBitmap
        return false
    isPng := (SubStr(path, -4) = ".png")
    clsid := GuidBuf(isPng ? "{557CF406-1A04-11D3-9A73-0000F81EF32E}" : "{557CF401-1A04-11D3-9A73-0000F81EF32E}")
    try FileDelete(path)
    r := DllCall("gdiplus\GdipSaveImageToFile", "Ptr", pBitmap, "WStr", path, "Ptr", clsid, "Ptr", 0)
    DllCall("gdiplus\GdipDisposeImage", "Ptr", pBitmap)
    return r = 0
}

TakeScreenshot() {
    path := A_Temp "\lobby_loop_screenshot.jpg"
    return SaveRegionImage(path, 0, 0, A_ScreenWidth, A_ScreenHeight) ? path : ""
}

SendScreenshot(msg := "Screenshot") {
    if !DiscordReady() {
        ShowTip(Tx("Discord isn't set up. Press {1} and paste your webhook link.", HK_SETTINGS), 4000)
        return false
    }
    path := TakeScreenshot()
    ok := (path != "") && DiscordFile(msg, path)
    if !ok
        Log("Screenshot to Discord failed")
    return ok
}

SendLog() {
    if !DiscordReady() {
        ShowTip(Tx("Discord isn't set up. Press {1} and paste your webhook link.", HK_SETTINGS), 4000)
        return false
    }
    copyPath := A_Temp "\" BASE "_log.txt"
    try FileCopy(LOG_FILE, copyPath, 1)
    ok := DiscordFile("Log file (v" VERSION (A_IsCompiled ? " exe" : "") ")", copyPath)
    ShowTip(ok ? Tx("Sent to Discord") : Tx("Couldn't send to Discord"), 2500)
    return ok
}

; ============================================================
; Reading placement and XP from the end screen (Windows' built-in text reader)
; ============================================================
; Saves the two areas of the end screen that hold "YOU PLACED #12" and "8,300 XP"
SaveResultCrops() {
    W := A_ScreenWidth, H := A_ScreenHeight
    p1 := A_Temp "\ll_place.png", p2 := A_Temp "\ll_xp.png"
    ok1 := SaveRegionImage(p1, Round(W * 0.30), 0, Round(W * 0.40), Round(H * 0.08))
    ok2 := SaveRegionImage(p2, Round(W * 0.30), Round(H * 0.45), Round(W * 0.40), Round(H * 0.25))
    return ok1 && ok2
}

; Runs the text reader on the saved crops. Returns {place, xp} ("" when not read).
ReadResults() {
    result := {place: "", xp: ""}
    script := A_Temp "\ll_ocr.ps1"
    out := A_Temp "\ll_ocr.txt"
    if !FileExist(script)
        FileAppend(OcrScript(), script, "UTF-8")
    try FileDelete(out)
    cmd := 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "' script '" "' A_Temp '\ll_place.png" "' A_Temp '\ll_xp.png" "' out '"'
    try RunWait(cmd, , "Hide")
    if !FileExist(out) {
        Log("Text reader gave no result")
        return result
    }
    txt := FileRead(out, "UTF-8")
    parts := StrSplit(txt, "|||")
    placeTxt := parts.Length >= 1 ? parts[1] : ""
    xpTxt := parts.Length >= 2 ? parts[2] : ""
    if RegExMatch(placeTxt, "#\s*(\d{1,3})", &pm) || RegExMatch(placeTxt, "i)PLACED\D{0,4}(\d{1,3})", &pm)
        result.place := Integer(pm[1])
    if RegExMatch(xpTxt, "i)([\d][\d,\. ]{0,8})\s*XP", &xm) {
        digits := RegExReplace(xm[1], "[^\d]")
        if (digits != "")
            result.xp := Integer(digits)
    }
    Log("Read results: place=" result.place " xp=" result.xp " (raw: " StrReplace(StrReplace(txt, "`r", " "), "`n", " ") ")")
    return result
}

OcrScript() {
    return '
    (
param($a, $b, $out)
Add-Type -AssemblyName System.Runtime.WindowsRuntime
$null = [Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime]
$null = [Windows.Media.Ocr.OcrEngine, Windows.Foundation, ContentType = WindowsRuntime]
$null = [Windows.Graphics.Imaging.BitmapDecoder, Windows.Graphics, ContentType = WindowsRuntime]
$null = [Windows.Globalization.Language, Windows.Globalization, ContentType = WindowsRuntime]
$asTask = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq "AsTask" -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -match "^IAsyncOperation.1$" })[0]
function Await($op, $type) { $t = $asTask.MakeGenericMethod($type).Invoke($null, @($op)); $t.Wait(-1) | Out-Null; $t.Result }
$lang = New-Object Windows.Globalization.Language("en-US")
if ([Windows.Media.Ocr.OcrEngine]::IsLanguageSupported($lang)) { $eng = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang) } else { $eng = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages() }
function Read-Text($path) {
  try {
    $f = Await ([Windows.Storage.StorageFile]::GetFileFromPathAsync($path)) ([Windows.Storage.StorageFile])
    $s = Await ($f.OpenAsync([Windows.Storage.FileAccessMode]::Read)) ([Windows.Storage.Streams.IRandomAccessStream])
    $d = Await ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($s)) ([Windows.Graphics.Imaging.BitmapDecoder])
    $bmp = Await ($d.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])
    $r = Await ($eng.RecognizeAsync($bmp)) ([Windows.Media.Ocr.OcrResult])
    $s.Dispose()
    return $r.Text
  } catch { return "" }
}
$t1 = Read-Text $a
$t2 = Read-Text $b
[IO.File]::WriteAllText($out, $t1 + "|||" + $t2)
    )'
}

; Called right after Play Again was clicked
RecordMatch(res) {
    global totalXP, bestPlace, lastPlace, lastXP
    lastPlace := res.place, lastXP := res.xp
    if !FileExist(MATCHES_FILE)
        try FileAppend("Date,Time,Placement,XP`r`n", MATCHES_FILE, "UTF-8")
    try FileAppend(FormatTime(, "yyyy-MM-dd") "," FormatTime(, "HH:mm") "," res.place "," res.xp "`r`n", MATCHES_FILE, "UTF-8")
    if (res.xp != "") {
        totalXP += res.xp
        IniWrite(totalXP, STATS_FILE, "Stats", "TotalXP")
    }
    if (res.place != "" && (bestPlace = 0 || res.place < bestPlace)) {
        bestPlace := res.place
        IniWrite(bestPlace, STATS_FILE, "Stats", "BestPlace")
    }
}

; ============================================================
; Daily summary and leaderboard
; ============================================================
PlayerName() {
    n := Trim(String(S["PLAYER_NAME"]))
    return (n != "") ? n : A_UserName
}

; Machine-readable line other Lobby Loops read for the leaderboard
LeaderboardLine() {
    hours := Round(totalMinutes / 60, 1)
    return "``LB|" StrReplace(PlayerName(), "|", "/") "|" totalMatches "|" hours "|" bestPlace "|" totalXP "``"
}

ReadCsvRows(path) {
    rows := []
    if !FileExist(path)
        return rows
    for i, line in StrSplit(FileRead(path, "UTF-8"), "`n", "`r") {
        if (i = 1 || Trim(line) = "")
            continue
        rows.Push(StrSplit(line, ","))
    }
    return rows
}

TodayStats(day := "") {
    if (day = "")
        day := FormatTime(, "yyyy-MM-dd")
    st := {matches: 0, minutes: 0, xp: 0, best: 0, placeSum: 0, placeCount: 0}
    for r in ReadCsvRows(MATCHES_FILE) {
        if (r.Length < 4 || r[1] != day)
            continue
        st.matches += 1
        if IsNumber(r[4])
            st.xp += r[4]
        if IsNumber(r[3]) && r[3] > 0 {
            st.placeSum += r[3], st.placeCount += 1
            if (st.best = 0 || r[3] < st.best)
                st.best := Integer(r[3])
        }
    }
    for r in ReadCsvRows(HISTORY_FILE)
        if (r.Length >= 4 && r[1] = day && IsNumber(r[4]))
            st.minutes += r[4]
    if (running && FormatTime(sessionStartTime, "yyyy-MM-dd") = day)
        st.minutes += (A_TickCount - sessionStart) / 60000
    return st
}

SendDailySummary() {
    st := TodayStats()
    msg := "📊 **Daily summary for " PlayerName() "**`n"
        . "Matches today: **" st.matches "**   ·   Time: **" Floor(st.minutes / 60) "h " Mod(Round(st.minutes), 60) "m**`n"
    if st.placeCount
        msg .= "Best placement: **#" st.best "**   ·   Average: **#" Round(st.placeSum / st.placeCount) "**`n"
    if st.xp
        msg .= "XP today: **" FormatNumber(st.xp) "**`n"
    msg .= "All time: " totalMatches " matches, " Round(totalMinutes / 60, 1) " h`n" LeaderboardLine()
    return Discord(msg)
}

FormatNumber(n) {
    s := String(Round(n))
    out := ""
    while (StrLen(s) > 3) {
        out := "," SubStr(s, -3) out
        s := SubStr(s, 1, StrLen(s) - 3)
    }
    return s out
}

; Reads the last 100 messages in the channel and ranks everyone's newest LB line
BuildLeaderboard() {
    resp := BotRequest("GET", "https://discord.com/api/v10/channels/" Trim(S["DISCORD_CHANNEL_ID"]) "/messages?limit=100")
    if (resp = "")
        return "Couldn't read the channel for the leaderboard."
    try msgs := JsonParse(resp)
    catch
        return "Couldn't read the channel for the leaderboard."
    best := Map()
    for m in msgs {
        content := m.Has("content") ? m["content"] : ""
        if !RegExMatch(content, "LB\|([^|``]+)\|(\d+)\|([\d.]+)\|(\d+)\|?(\d*)", &lb)
            continue
        key := StrLower(lb[1])
        if !best.Has(key)        ; newest message comes first
            best[key] := {name: lb[1], matches: Integer(lb[2]), hours: lb[3], place: Integer(lb[4]), xp: lb[5]}
    }
    if (best.Count = 0)
        return "No leaderboard data yet. It appears after daily summaries or stops."
    list := []
    for _, v in best
        list.Push(v)
    ; sort by matches, most first (simple insertion sort)
    loop list.Length - 1 {
        i := A_Index + 1
        cur := list[i], j := i - 1
        while (j >= 1 && list[j].matches < cur.matches) {
            list[j + 1] := list[j], j -= 1
        }
        list[j + 1] := cur
    }
    medals := ["🥇", "🥈", "🥉"]
    out := "🏆 **Lobby Loop leaderboard**`n"
    for i, v in list {
        out .= (i <= 3 ? medals[i] : i ".") " **" v.name "**: " v.matches " matches, " v.hours " h" (v.place ? ", best #" v.place : "") "`n"
        if (i >= 15)
            break
    }
    return out
}

; ============================================================
; Discord phone control (bot)
; ============================================================
BotEnabled() {
    return Trim(String(S["DISCORD_BOT_TOKEN"])) != "" && Trim(String(S["DISCORD_CHANNEL_ID"])) != ""
}

BotRequest(method, url, body := "") {
    global botFails
    try {
        req := ComObject("WinHttp.WinHttpRequest.5.1")
        req.SetTimeouts(3000, 3000, 4000, 6000)
        req.Open(method, url, false)
        req.SetRequestHeader("Authorization", "Bot " Trim(String(S["DISCORD_BOT_TOKEN"])))
        req.SetRequestHeader("User-Agent", "DiscordBot (https://github.com/yensobased1/lobby-loop, " VERSION ")")
        if (body != "")
            req.SetRequestHeader("Content-Type", "application/json")
        req.Send(body)
        st := req.Status
        if (st >= 200 && st < 300) {
            botFails := 0
            return req.ResponseText
        }
        Log("Discord bot HTTP " st)
        if (st = 401 || st = 403) {
            botFails += 10
            Log("Bot token or channel is wrong, or the bot can't read the channel")
        }
    } catch as e {
        botFails += 1
        Log("Discord bot request failed: " e.Message)
    }
    return ""
}

BotPoll() {
    global botLastId, botFails
    if !BotEnabled() || botFails >= 10
        return
    url := "https://discord.com/api/v10/channels/" Trim(String(S["DISCORD_CHANNEL_ID"])) "/messages?limit=10"
    if (botLastId != "")
        url .= "&after=" botLastId
    resp := BotRequest("GET", url)
    if (resp = "")
        return
    try msgs := JsonParse(resp)
    catch
        return
    if !(msgs is Array)
        return
    if (botLastId = "") {                       ; first check: skip old messages
        botLastId := msgs.Length ? MaxId(msgs) : "0"
        Log("Phone control is listening")
        PanelPoll()
        return
    }
    ; oldest first
    sorted := []
    for m in msgs
        sorted.Push(m)
    loop sorted.Length - 1 {
        i := A_Index + 1
        cur := sorted[i], j := i - 1
        while (j >= 1 && IdLess(cur["id"], sorted[j]["id"])) {
            sorted[j + 1] := sorted[j], j -= 1
        }
        sorted[j + 1] := cur
    }
    for m in sorted {
        if IdLess(botLastId, m["id"])
            botLastId := m["id"]
        if m.Has("webhook_id")
            continue
        author := m.Has("author") ? m["author"] : Map()
        if (author.Has("bot") && author["bot"])
            continue
        authorId := author.Has("id") ? author["id"] : ""
        allowed := Trim(String(S["DISCORD_ALLOWED_IDS"]))
        if (allowed != "" && !InStr("," StrReplace(allowed, " ") ",", "," authorId ","))
            continue
        HandleCommand(Trim(m.Has("content") ? m["content"] : ""), authorId)
    }
    PanelPoll()
}

IdLess(a, b) {
    a := String(a), b := String(b)
    return (StrLen(a) != StrLen(b)) ? StrLen(a) < StrLen(b) : StrCompare(a, b) < 0
}

MaxId(msgs) {
    top := "0"
    for m in msgs
        if IdLess(top, m["id"])
            top := m["id"]
    return top
}

HandleCommand(text, authorId := "") {
    global liveMsgId, watchMinutes, lastWatchShot
    global modeChecked
    if (SubStr(text, 1, 1) != "!")
        return
    parts := StrSplit(Trim(SubStr(text, 2)), " ", , 2)
    cmd := StrLower(parts[1])
    target := parts.Length >= 2 ? Trim(parts[2]) : ""
    arg := ""
    if (cmd = "timer" || cmd = "profile" || cmd = "watch" || cmd = "pause" || cmd = "mode") {   ; these take a value, not a PC name
        arg := target
        target := ""
    }
    if (target != "" && !InStr(PlayerName() " " TITLE " " BASE, target))
        return                                      ; meant for someone else
    who := "**" PlayerName() "**: "
    Log("Discord command: " text)
    switch cmd {
        case "help":
            Discord(who "**commands**`n"
                . "▶️ ``!start`` ``!stop`` ``!pause 15`` ``!resume`` ``!status`` ``!ping```n"
                . "📸 ``!ss`` ``!watch 10`` / ``!watch off`` ``!live`` ``!panel`` ``!log```n"
                . "⏰ ``!timer 2h`` / ``!timer 9:30pm`` / ``!timer off`` ``!profile overnight```n"
                . "📊 ``!stats`` ``!summary`` ``!week`` ``!last`` ``!treasures`` ``!lb`` ``!uptime```n"
                . "🎛️ ``!dim`` ``!mute`` ``!unmute`` ``!overlay`` ``!popups```n"
                . "🎯 ``!mode`` / ``!mode zerobuild squad fill`` / ``!mode any```n"
                . "🏴‍☠️ ``!clip`` ``!read```n"
                . "🛠️ ``!version`` ``!update`` ``!reload`` ``!restartgame`` ``!closegame`` ``!sleep`` ``!shutdown`` ``!cancel```n"
                . "Add a name to target one PC, e.g. ``!stop zen``. Power commands need your user ID in Settings > Phone control.")
        case "status":
            Discord(who StatusText())
        case "start":
            if running {
                Discord(who "already running.")
            } else {
                if WinExist(S["GAME_WINDOW"])
                    try WinActivate(S["GAME_WINDOW"])
                ToggleRun()
                Discord(who "started ▶")
            }
        case "stop":
            if running {
                ToggleRun("Discord")
                Discord(who "stopped ⏹")
            } else {
                Discord(who "isn't running.")
            }
        case "ss", "screenshot":
            if !SendScreenshot(who "screenshot")
                Discord(who "couldn't take a screenshot.")
        case "log":
            SendLog()
        case "summary":
            SendDailySummary()
        case "lb", "leaderboard":
            Discord(BuildLeaderboard())
        case "dim":
            ToggleBlackout()
            Discord(who "screen " (blackoutGui != "" ? "dimmed" : "back to normal"))
        case "panel":
            if !PanelCreate()
                Discord(who "couldn't post the control panel. The bot needs Send Messages and Add Reactions.")
        case "live":
            SetSetting("LIVE_STATUS", 1)
            liveMsgId := ""
            if !LiveUpdate()
                Discord(who "couldn't post the live status message.")
        case "watch":
            v := StrLower(Trim(arg))
            watchMinutes := (v = "off" || v = "0" || v = "") ? 0 : (IsNumber(v) ? Max(1, Number(v)) : 0)
            SetSetting("AUTO_SCREENSHOT_MIN", watchMinutes)
            lastWatchShot := 0
            Discord(who (watchMinutes ? "screenshot every " watchMinutes " min while running." : "auto screenshots off."))
        case "pause":
            mins := IsNumber(Trim(arg)) ? Max(1, Number(Trim(arg))) : 15
            PauseFor(mins)
            Discord(who "paused for " mins " min. ``!resume`` to start now.")
        case "resume":
            ResumeNow()
            Discord(who (running ? "running ▶" : "couldn't start."))
        case "mute":
            Discord(who (SetGameMute(true) ? "Fortnite muted 🔇" : "Fortnite isn't open."))
        case "unmute":
            Discord(who (SetGameMute(false) ? "Fortnite unmuted 🔊" : "Fortnite isn't open."))
        case "stats":
            avg := AveragePlace()
            Discord(who "📊 all time: **" totalMatches "** matches, **" Round(totalMinutes / 60, 1) " h**, **" FormatNumber(totalXP) "** XP"
                . (bestPlace ? ", best #" bestPlace : "") (avg ? ", average #" avg : "") ", 🏴‍☠️ " treasureCount " treasures")
        case "week":
            wk := WeekStats()
            Discord(who "📅 last 7 days: **" wk.matches "** matches, **" Floor(wk.minutes / 60) "h " Mod(Round(wk.minutes), 60) "m**"
                . (wk.best ? ", best #" wk.best : "") (wk.xp ? ", " FormatNumber(wk.xp) " XP" : "") ", 🏴‍☠️ " wk.treasures)
        case "last":
            Discord(who LastMatchText())
        case "treasures":
            Discord(who "🏴‍☠️ " treasureCount " treasures all time" (lastTreasure != "" ? ". Last: **" lastTreasure "**" : ""))
        case "uptime":
            Discord(who "Lobby Loop open for " FormatDuration(A_TickCount - scriptStartTick) ", PC on for " FormatDuration(A_TickCount) ".")
        case "ping":
            Discord(who "pong 🏓 v" VERSION " · Fortnite " (WinExist(S["GAME_WINDOW"]) ? "open" : "closed") " · " (running ? StateLabel() : "stopped"))
        case "version":
            Discord(who "v" VERSION (A_IsCompiled ? " (exe)" : " (ahk)") ". Type ``!update`` to check for a new one.")
        case "overlay":
            ToggleOverlay()
            Discord(who "status box " (overlayHidden ? "hidden" : "shown"))
        case "popups":
            Discord(who POPUPS.Length " learned popup buttons. Forget them in Settings > Popups (or Shift+" HK_TEACH " over one).")
        case "update", "reload", "restartgame", "closegame", "sleep", "shutdown":
            if (Trim(String(S["DISCORD_ALLOWED_IDS"])) = "") {
                Discord(who "for safety, ``!" cmd "`` only works after you add your Discord user ID in Settings > Phone control.")
                return
            }
            switch cmd {
                case "update":
                    Discord(who "checking for updates...")
                    CheckUpdate(true, true)
                case "reload":
                    Discord(who "restarting Lobby Loop 🔄")
                    Reload()
                case "restartgame":
                    try ProcessClose(GameExe())
                    Discord(who "restarting Fortnite 🔄")
                    SetTimer(() => Run(FN_URI), -5000)
                case "closegame":
                    if running
                        ToggleRun("Discord closegame")
                    try ProcessClose(GameExe())
                    Discord(who "Fortnite closed.")
                case "sleep", "shutdown":
                    StartPowerAction(cmd)
                    Discord(who (cmd = "sleep" ? "PC goes to sleep" : "PC shuts down") " in 30 s. ``!cancel`` to stop it.")
            }
        case "mode":
            if (arg = "") {
                m := ReadLobbyMode()
                Discord(who "🎯 wanted: **" ModeText(S["MODE_TEAM"], S["MODE_BUILD"], S["MODE_FILL"]) "**"
                    . (IsObject(m) ? ", lobby shows: **" m.text "** " (ModeOk(m) ? "✅" : "❌") : ", couldn't read the lobby right now"))
                return
            }
            for word in StrSplit(StrLower(StrReplace(StrReplace(arg, "-", ""), ",", " ")), " ") {
                switch word {
                    case "any":
                        SetSetting("MODE_TEAM", "any"), SetSetting("MODE_BUILD", "any"), SetSetting("MODE_FILL", "any")
                    case "solo", "solos", "duo", "duos", "trio", "trios", "squad", "squads":
                        SetSetting("MODE_TEAM", RTrim(word, "s"))
                    case "build", "builds":
                        SetSetting("MODE_BUILD", "build")
                    case "zb", "zero", "zerobuild":
                        SetSetting("MODE_BUILD", "zerobuild")
                    case "fill":
                        SetSetting("MODE_FILL", "fill")
                    case "nofill":
                        SetSetting("MODE_FILL", "nofill")
                }
            }
            modeChecked := false
            Discord(who "🎯 mode set to **" ModeText(S["MODE_TEAM"], S["MODE_BUILD"], S["MODE_FILL"]) "**")
        case "clip":
            Discord(who (DoClip("phone") ? "🎬 clip key pressed" : "🎬 no clip key set (Settings > Treasure)"))
        case "read":
            lines := OcrRegionSync(0, 0, A_ScreenWidth, A_ScreenHeight)
            all := ""
            for ln in lines
                if (StrLen(all) < 1500 && StrLen(ln.text) >= 3)
                    all .= ln.text " · "
            Discord(who "🔎 on screen: " (all != "" ? all : "no text found"))
        case "cancel":
            if (pendingAction != "") {
                ToggleRun()                                   ; cancels the countdown
                Discord(who "cancelled ✋")
            } else {
                Discord(who "nothing to cancel.")
            }
    }
}

StatusText() {
    if running
        s1 := "running " FormatDuration(A_TickCount - sessionStart) ", " matches " matches this run. Now: " lastMsg
    else
        s1 := "stopped."
    left := running ? TimeLeftMs() : ""
    s2 := (left != "") ? " Stops in " FormatDuration(left) "." : ""
    return s1 s2 " All time: " totalMatches " matches, " Round(totalMinutes / 60, 1) " h."
}

; ============================================================
; Small JSON reader (for Discord replies)
; ============================================================
JsonParse(str) {
    pos := 1
    return JsonValue(str, &pos)
}

JsonWs(str, &pos) {
    if RegExMatch(str, "\G\s+", &m, pos)
        pos += m.Len
}

JsonValue(str, &pos) {
    JsonWs(str, &pos)
    ch := SubStr(str, pos, 1)
    if (ch = "{") {
        obj := Map()
        pos += 1
        JsonWs(str, &pos)
        if (SubStr(str, pos, 1) = "}") {
            pos += 1
            return obj
        }
        loop {
            JsonWs(str, &pos)
            k := JsonValue(str, &pos)
            JsonWs(str, &pos)
            pos += 1                                   ; the colon
            obj[k] := JsonValue(str, &pos)
            JsonWs(str, &pos)
            c := SubStr(str, pos, 1)
            pos += 1
            if (c = "}")
                return obj
            if (c != ",")
                throw Error("JSON: expected , or }")
        }
    }
    if (ch = "[") {
        arr := []
        pos += 1
        JsonWs(str, &pos)
        if (SubStr(str, pos, 1) = "]") {
            pos += 1
            return arr
        }
        loop {
            arr.Push(JsonValue(str, &pos))
            JsonWs(str, &pos)
            c := SubStr(str, pos, 1)
            pos += 1
            if (c = "]")
                return arr
            if (c != ",")
                throw Error("JSON: expected , or ]")
        }
    }
    if (ch = '"') {
        out := ""
        pos += 1
        loop {
            if RegExMatch(str, '\G[^"\\]+', &m, pos) {
                out .= m[0]
                pos += m.Len
            }
            c := SubStr(str, pos, 1)
            if (c = "")
                throw Error("JSON: unfinished text")
            if (c = '"') {
                pos += 1
                return out
            }
            n := SubStr(str, pos + 1, 1)                 ; c is a backslash
            if (n = "u") {
                out .= Chr(Integer("0x" SubStr(str, pos + 2, 4)))
                pos += 6
                continue
            }
            out .= (n = "n") ? "`n" : (n = "t") ? "`t" : (n = "r") ? "`r" : (n = "b") ? "`b" : (n = "f") ? "`f" : n
            pos += 2
        }
    }
    if RegExMatch(str, "\G(-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?|true|false|null)", &m, pos) {
        pos += m.Len
        v := m[1]
        return (v = "true") ? true : (v = "false") ? false : (v = "null") ? "" : v
    }
    throw Error("JSON: unexpected character at " pos)
}

; ============================================================
; Stats dashboard (an HTML page built from your history)
; ============================================================
OpenDashboard(refreshOnly := false) {
    global dashOpenTick
    days := Map()
    for r in ReadCsvRows(HISTORY_FILE) {
        if (r.Length < 5)
            continue
        if !days.Has(r[1])
            days[r[1]] := {min: 0, matches: 0}
        if IsNumber(r[4])
            days[r[1]].min += r[4]
        if IsNumber(r[5])
            days[r[1]].matches += r[5]
    }
    dayJs := ""
    for d, v in days                                  ; Map keys come out sorted, so dates are in order
        dayJs .= (dayJs = "" ? "" : ",") '["' d '",' Round(v.min, 1) ',' v.matches ']'
    matchJs := ""
    for r in ReadCsvRows(MATCHES_FILE) {
        if (r.Length < 4)
            continue
        place := IsNumber(r[3]) ? r[3] : "null"
        xp := IsNumber(r[4]) ? r[4] : "null"
        matchJs .= (matchJs = "" ? "" : ",") '["' r[1] " " r[2] '",' place ',' xp ']'
    }
    html := DashboardHtml()
    html := StrReplace(html, "Lobby Loop", TITLE)
    html := StrReplace(html, "__PLAYER__", PlayerName())
    html := StrReplace(html, "__DAYS__", "[" dayJs "]")
    html := StrReplace(html, "__MATCHES__", "[" matchJs "]")
    html := StrReplace(html, "__TOTALS__", '{"matches":' totalMatches ',"hours":' Round(totalMinutes / 60, 1) ',"xp":' totalXP ',"best":' bestPlace ',"treasures":' treasureCount '}')
    ; live session (this run) - the page refreshes itself every 30 s while Lobby Loop is running
    sess := ""
    if (running && sessionStartTime != "") {
        startDay := FormatTime(sessionStartTime, "yyyy-MM-dd"), startHm := FormatTime(sessionStartTime, "HH:mm")
        for r in ReadCsvRows(MATCHES_FILE)
            if (r.Length >= 4 && (r[1] > startDay || (r[1] = startDay && StrCompare(r[2], startHm) >= 0)))
                sess .= (sess = "" ? "" : ",") '["' r[2] '",' (IsNumber(r[3]) ? r[3] : "null") ',' (IsNumber(r[4]) ? r[4] : "null") ']'
    }
    liveJs := '{"running":' (running ? "true" : "false") ',"time":"' (running ? FormatDuration(A_TickCount - sessionStart) : "") '","matches":' matches
        . ',"state":"' JsonEscape(running ? StateLabel() : "stopped") '","updated":"' FormatTime(, "HH:mm:ss") '","list":[' sess ']}'
    html := StrReplace(html, "__LIVE__", liveJs)
    html := StrReplace(html, "__REFRESH__", running ? '<meta http-equiv="refresh" content="30">' : "")
    try FileDelete(DASH_FILE)
    FileAppend(html, DASH_FILE, "UTF-8")
    if !refreshOnly {
        dashOpenTick := A_TickCount
        SetTimer(DashboardRefresh, 30000)
        try Run('"' DASH_FILE '"')
    }
}

DashboardRefresh() {
    if (A_TickCount - dashOpenTick > 4 * 3600000) {   ; stop refreshing after 4 hours
        SetTimer(DashboardRefresh, 0)
        return
    }
    if running
        OpenDashboard(true)
}

DashboardHtml() {
    return '
    (
<!DOCTYPE html>
<html><head><meta charset="utf-8">__REFRESH__<title>Lobby Loop stats</title>
<style>
body{margin:0;font-family:Segoe UI,Arial,sans-serif;background:#120b33;color:#eee}
header{padding:24px 32px;background:linear-gradient(135deg,#2e1a80,#5b34d6)}
h1{margin:0;font-size:26px}h1 span{color:#f7fe19}
.sub{opacity:.8;margin-top:4px}
.cards{display:flex;flex-wrap:wrap;gap:16px;padding:24px 32px}
.card{background:#1f1458;border-radius:14px;padding:16px 20px;min-width:170px}
.card b{display:block;font-size:30px;color:#f7fe19}
.card i{font-style:normal;opacity:.75}
.panel{background:#1f1458;border-radius:14px;margin:0 32px 24px;padding:16px 20px}
.panel h2{margin:0 0 12px;font-size:17px}
svg text{fill:#bbb;font-size:11px}
.empty{opacity:.6;padding:20px 0}
</style></head><body>
<header><h1><span>&#x1F501;</span> Lobby Loop stats</h1><div class="sub">__PLAYER__</div></header>
<div class="panel" id="live" style="display:none;margin-top:24px"><h2>&#x1F7E2; Live session</h2><div id="livebody"></div></div>
<div class="cards" id="cards"></div>
<div class="panel"><h2>Matches per day (last 14 days)</h2><div id="c1"></div></div>
<div class="panel"><h2>Hours played per day (last 14 days)</h2><div id="c2"></div></div>
<div class="panel"><h2>Placement (last 50 matches, lower is better)</h2><div id="c3"></div></div>
<script>
var days = __DAYS__;
var matches = __MATCHES__;
var totals = __TOTALS__;
var live = __LIVE__;
if (live.running) {
  document.getElementById("live").style.display = "block";
  var lh = "<div class=cards style=padding:0>" + [["Running", live.time], ["Matches this run", live.matches], ["Now", live.state]].map(function(c){return "<div class=card><b>"+c[1]+"</b><i>"+c[0]+"</i></div>";}).join("") + "</div>";
  if (live.list.length) {
    lh += "<div style=margin-top:12px>" + live.list.map(function(m){return "<span style=display:inline-block;margin:4px;padding:6px;background:#2a2a4e;border-radius:8px>" + m[0] + (m[1]!==null ? " &middot; #" + m[1] : "") + (m[2]!==null ? " &middot; " + m[2].toLocaleString() + " XP" : "") + "</span>";}).join("") + "</div>";
  }
  lh += "<div style=opacity:.6;margin-top:8px>Updates every 30 seconds &middot; last update " + live.updated + "</div>";
  document.getElementById("livebody").innerHTML = lh;
}
var places = matches.filter(function(m){return m[1]!==null;});
var avg = places.length ? Math.round(places.reduce(function(a,m){return a+m[1];},0)/places.length) : null;
var cards = [["Matches",totals.matches],["Hours",totals.hours],["Total XP",totals.xp.toLocaleString()],
  ["Best placement",totals.best?"#"+totals.best:"-"],["Average placement",avg?"#"+avg:"-"],["Treasures",totals.treasures]];
document.getElementById("cards").innerHTML = cards.map(function(c){return "<div class=card><b>"+c[1]+"</b><i>"+c[0]+"</i></div>";}).join("");
function at(n,v){return " "+n+"=\""+v+"\"";}
function bars(el, rows, idx, color, unit){
  rows = rows.slice(-14);
  if(!rows.length){document.getElementById(el).innerHTML="<div class=empty>No data yet.</div>";return;}
  var W=Math.max(400,rows.length*56), H=200, max=Math.max.apply(null,rows.map(function(r){return r[idx];}).concat([1]));
  var s="<svg"+at("width",W)+at("height",H+30)+">";
  rows.forEach(function(r,i){var v=r[idx], h=Math.round(v/max*(H-20)), x=i*56+10;
    s+="<rect"+at("x",x)+at("y",H-h)+at("width",40)+at("height",h)+at("rx",5)+at("fill",color)+"/>";
    s+="<text"+at("x",x+20)+at("y",H-h-5)+at("text-anchor","middle")+">"+(Math.round(v*10)/10)+unit+"</text>";
    s+="<text"+at("x",x+20)+at("y",H+16)+at("text-anchor","middle")+">"+r[0].slice(5)+"</text>";});
  document.getElementById(el).innerHTML=s+"</svg>";
}
bars("c1", days, 2, "#f7fe19", "");
bars("c2", days.map(function(d){return [d[0],d[1],d[1]/60];}), 2, "#8f6bff", "h");
(function(){
  var rows=places.slice(-50);
  if(!rows.length){document.getElementById("c3").innerHTML="<div class=empty>No placements read yet.</div>";return;}
  var W=Math.max(400,rows.length*18), H=200, max=Math.max.apply(null,rows.map(function(r){return r[1];}).concat([10]));
  function py(r){return 10+Math.round(r[1]/max*(H-20));}
  var pts=rows.map(function(r,i){return (i*18+15)+","+py(r);}).join(" ");
  var s="<svg"+at("width",W)+at("height",H+10)+"><polyline"+at("points",pts)+at("fill","none")+at("stroke","#f7fe19")+at("stroke-width",3)+"/>";
  rows.forEach(function(r,i){s+="<circle"+at("cx",i*18+15)+at("cy",py(r))+at("r",4)+at("fill","#f7fe19")+"><title>#"+r[1]+" ("+r[0]+")</title></circle>";});
  document.getElementById("c3").innerHTML=s+"</svg>";
})();
</script></body></html>
    )'
}

; ============================================================
; Setup wizard (first run, or tray > Setup wizard)
; ============================================================
StartWizard() {
    global WIZ
    WIZ := Map("page", 1, "LANG", S["LANG"], "PLAYER_NAME", S["PLAYER_NAME"], "PROFILE", S["PROFILE"],
               "KEY_FORWARD", S["KEY_FORWARD"], "KEY_LEFT", S["KEY_LEFT"], "KEY_BACK", S["KEY_BACK"],
               "KEY_RIGHT", S["KEY_RIGHT"], "KEY_JUMP", S["KEY_JUMP"], "KEY_SPRINT", S["KEY_SPRINT"],
               "KEY_CROUCH", S["KEY_CROUCH"], "DISCORD_WEBHOOK", S["DISCORD_WEBHOOK"],
               "MUTE_WHILE_RUNNING", S["MUTE_WHILE_RUNNING"], "BLACKOUT_ON_START", S["BLACKOUT_ON_START"],
               "START_WITH_WINDOWS", S["START_WITH_WINDOWS"], "AUTO_START", S["AUTO_START"], "READ_RESULTS", S["READ_RESULTS"])
    WizardPage()
}

WizardPage() {
    global WIZ
    page := WIZ["page"], pages := 6
    S["LANG"] := WIZ["LANG"]                         ; show the wizard in the chosen language
    g := ThemeGui(TITLE " - " Tx("Setup wizard"))
    UiText(g, "w460", Tx("Step {1} of {2}", page, pages), "muted")
    g.SetFont("s14 bold c" UiCol("text"))
    ctrls := Map()
    switch page {
        case 1:
            g.Add("Text", "w460 y+6", Tx("Welcome to Lobby Loop"))
            g.SetFont("s10 norm")
            g.Add("Text", "w460 y+10", Tx("Lobby Loop keeps you in squad fills while you're away, so your teammates can farm chests for you while you bot."))
            g.Add("Text", "w460 y+8", Tx("Pick your language and your name."))
            g.Add("Text", "y+12", Tx("Language"))
            ctrls["LANG"] := UiDDL(g, "w220", ["English", "العربية"])
            ctrls["LANG"].Choose(WIZ["LANG"] = "ar" ? 2 : 1)
            g.Add("Text", "y+12 w460", Tx("Your name (for Discord and the leaderboard):"))
            ctrls["PLAYER_NAME"] := UiEdit(g, "w220", WIZ["PLAYER_NAME"] != "" ? WIZ["PLAYER_NAME"] : A_UserName)
        case 2:
            g.Add("Text", "w460 y+6", Tx("How do you want to play?"))
            g.SetFont("s10 norm")
            descs := Map("overnight", "Overnight: runs 8 hours, dims the screen, mutes the game, then puts the PC to sleep",
                         "quick", "Quick 1 hour: runs for 1 hour, then stops",
                         "chill", "Chill: 3 hours with calmer, slower movement",
                         "custom", "Custom: keep my own settings")
            for i, key in PROFILE_KEYS {
                rb := g.Add("Radio", "w460 y+10" (i = 1 ? " Group" : ""), Tx(descs[key]))
                if DarkOn()
                    DllCall("uxtheme\SetWindowTheme", "Ptr", rb.Hwnd, "Str", "", "Str", "")   ; lets the text use the theme colour
                rb.Value := (WIZ["PROFILE"] = key)
                ctrls["P_" key] := rb
            }
        case 3:
            g.Add("Text", "w460 y+6", Tx("Your Fortnite keys (change them if you don't use the defaults):"))
            g.SetFont("s10 norm")
            for pair in [["KEY_FORWARD", "Forward"], ["KEY_LEFT", "Left"], ["KEY_BACK", "Back"], ["KEY_RIGHT", "Right"],
                         ["KEY_JUMP", "Jump"], ["KEY_SPRINT", "Sprint"], ["KEY_CROUCH", "Crouch"]] {
                g.Add("Text", "xm w120 y+8", Tx(pair[2]))
                ctrls[pair[1]] := UiEdit(g, "x+10 yp-3 w120", WIZ[pair[1]])
            }
        case 4:
            g.Add("Text", "w460 y+6", "Discord")
            g.SetFont("s10 norm")
            g.Add("Text", "w460 y+10", Tx("Discord alerts (optional). Leave blank to skip."))
            ctrls["DISCORD_WEBHOOK"] := UiEdit(g, "w460 r1", WIZ["DISCORD_WEBHOOK"])
            tb := UiButton(g, "y+8 w190", Tx("Send test message"))
            tb.OnEvent("Click", (*) => TestDiscord(ctrls["DISCORD_WEBHOOK"].Value, g))
            hb := UiButton(g, "x+10 yp w190", "❓ " Tx("How do I get this?"))
            hb.OnEvent("Click", (*) => ShowGuide("webhook", g.Hwnd))
        case 5:
            g.Add("Text", "w460 y+6", Tx("Extras"))
            g.SetFont("s10 norm")
            for pair in [["MUTE_WHILE_RUNNING", "Mute Fortnite while running"], ["BLACKOUT_ON_START", "Dim the screen while running"],
                         ["READ_RESULTS", "Read my placement and XP after each match"], ["AUTO_START", "Start by itself when I click into Fortnite"],
                         ["START_WITH_WINDOWS", "Start with Windows"]] {
                ctrls[pair[1]] := UiCheck(g, "xm y+10", Tx(pair[2]), WIZ[pair[1]])[1]
            }
        case 6:
            g.Add("Text", "w460 y+6", "✅ " Tx("All set!"))
            g.SetFont("s10 norm")
            g.Add("Text", "w460 y+12", Tx("1. Open Fortnite in Windowed Fullscreen and go to the lobby."))
            g.Add("Text", "w460 y+6", Tx("2. Press {1} to check that the buttons are found.", HK_TEST))
            g.Add("Text", "w460 y+6", Tx("3. Press {1} to start. Press it again to stop.", HK_TOGGLE))
    }
    g.SetFont("s10 norm")
    if (page > 1) {
        bBack := UiButton(g, "xm y+24 w110", Tx("Back"))
        bBack.OnEvent("Click", (*) => WizardNav(g, ctrls, -1))
        bNext := UiButton(g, "x+10 w110 Default", page = pages ? Tx("Finish") : Tx("Next"))
    } else {
        bNext := UiButton(g, "xm y+24 w110 Default", Tx("Next"))
    }
    bNext.OnEvent("Click", (*) => WizardNav(g, ctrls, +1))
    g.OnEvent("Close", (*) => WizardClose(g))
    g.OnEvent("Escape", (*) => WizardClose(g))
    g.Show()
}

WizardNav(g, ctrls, dir) {
    global WIZ
    ; keep what was typed on this page
    for key, c in ctrls {
        if (key = "LANG")
            WIZ["LANG"] := (c.Value = 2) ? "ar" : "en"
        else if (SubStr(key, 1, 2) = "P_") {
            if c.Value
                WIZ["PROFILE"] := SubStr(key, 3)
        } else
            WIZ[key] := (c.Type = "Edit") ? Trim(c.Value) : c.Value
    }
    if (dir > 0 && WIZ["page"] = 4 && WIZ["DISCORD_WEBHOOK"] != "" && !IsDiscordUrl(WIZ["DISCORD_WEBHOOK"])) {
        MsgBox("That doesn't look like a Discord webhook link.`nIt should start with https://discord.com/api/webhooks/", TITLE, "Icon! Owner" g.Hwnd)
        return
    }
    if (dir > 0 && WIZ["page"] = 3) {
        for k in ["KEY_FORWARD", "KEY_LEFT", "KEY_BACK", "KEY_RIGHT", "KEY_JUMP", "KEY_SPRINT", "KEY_CROUCH"]
            if !ValidKey(WIZ[k]) {
                MsgBox("'" WIZ[k] "' isn't a key name AutoHotkey knows (examples: w, Space, LShift, LCtrl).", TITLE, "Icon! Owner" g.Hwnd)
                return
            }
    }
    g.Destroy()
    if (dir > 0 && WIZ["page"] = 6) {
        WizardFinish()
        return
    }
    WIZ["page"] := WIZ["page"] + dir
    WizardPage()
}

WizardClose(g) {
    g.Destroy()
    S["LANG"] := IniRead(INI_FILE, "Settings", "LANG", "en")   ; nothing saved
}

WizardFinish() {
    oldHook := DiscordUrl()
    for key in ["LANG", "PLAYER_NAME", "KEY_FORWARD", "KEY_LEFT", "KEY_BACK", "KEY_RIGHT", "KEY_JUMP", "KEY_SPRINT", "KEY_CROUCH",
                "DISCORD_WEBHOOK", "MUTE_WHILE_RUNNING", "READ_RESULTS", "AUTO_START"]
        SetSetting(key, WIZ[key])
    ApplyProfile(WIZ["PROFILE"])
    SetSetting("BLACKOUT_ON_START", WIZ["BLACKOUT_ON_START"])   ; after the profile, so the tick box wins
    SetSetting("MUTE_WHILE_RUNNING", WIZ["MUTE_WHILE_RUNNING"])
    if (WIZ["START_WITH_WINDOWS"] != S["START_WITH_WINDOWS"])
        SetStartWithWindows(WIZ["START_WITH_WINDOWS"])
    SetSetting("START_WITH_WINDOWS", WIZ["START_WITH_WINDOWS"])
    if (WIZ["DISCORD_WEBHOOK"] != "" && WIZ["DISCORD_WEBHOOK"] != oldHook)
        SetupWebhook(WIZ["DISCORD_WEBHOOK"])
    SetSetting("SETUP_DONE", 1)
    Log("Setup wizard finished")
    Reload()                                         ; restart so keys, language and hotkeys take effect
}

; ============================================================
; v7.5: Screen reader (spectating, treasure, reward buttons)
; ============================================================
; Every few seconds a screenshot is read by Windows' built-in text reader in the
; background (it never pauses the game). The text decides:
;   - "SPECTATING" / "NEXT TEAMMATE"  -> you're eliminated, stop moving
;   - treasure words (TREASURE_WORDS)  -> count it, tell Discord
;   - a button that just says CONTINUE / COLLECT / CLAIM ... -> click it
ScreenReaderTick() {
    global ocrPending, ocrStartTick, lastOcrTick
    out := A_Temp "\ll_screen.txt"
    if ocrPending {
        if FileExist(out) {
            ocrPending := false
            txt := ""
            try txt := FileRead(out, "UTF-8")
            try FileDelete(out)
            HandleScreenText(txt)
        } else if (A_TickCount - ocrStartTick > 25000) {
            ocrPending := false
            Log("Screen reader timed out")
        }
        return
    }
    if (!running || !WinActive(S["GAME_WINDOW"]))
        return
    if (!S["WATCH_TREASURE"] && !S["AUTO_CLAIM"] && !S["SPECTATE_IDLE"] && !S["WAIT_FOR_SQUAD"] && !S["WAKE_FROM_SLEEP"])
        return
    if (A_TickCount - lastOcrTick < (S["WATCH_TREASURE"] ? 3 : Max(5, S["SCREEN_READER_SECONDS"])) * 1000)
        return
    lastOcrTick := A_TickCount
    img := A_Temp "\ll_screen.png"
    if !SaveRegionImage(img, 0, 0, A_ScreenWidth, A_ScreenHeight)
        return
    script := A_Temp "\ll_ocr_lines_v75.ps1"
    if !FileExist(script)
        FileAppend(OcrLinesScript(), script, "UTF-8")
    try FileDelete(out)
    try Run('powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "' script '" "' img '" "' out '"', , "Hide")
    ocrPending := true
    ocrStartTick := A_TickCount
}

HandleScreenText(txt) {
    global gameState, lastClaimTick, clicks
    lines := []
    for raw in StrSplit(txt, "`n", "`r") {
        p := StrSplit(raw, "|", , 5)
        if (p.Length < 5 || !IsNumber(p[1]))
            continue
        lines.Push({x: Integer(p[1]), y: Integer(p[2]), w: Integer(p[3]), h: Integer(p[4]), text: Trim(p[5])})
    }
    joined := ""
    for ln in lines
        joined .= " " StrUpper(ln.text)
    if (S["WAKE_FROM_SLEEP"] && InStr(joined, "SLEEP MODE") && WakeFromSleep(lines))
        return
    spect := InStr(joined, "SPECTATING") || InStr(joined, "NEXT TEAMMATE") || InStr(joined, "PREVIOUS TEAMMATE")
    if (spect && gameState != "spectating") {
        gameState := "spectating"
        Log("Spectating detected")
    } else if (!spect && gameState = "spectating") {
        gameState := "match"
        Log("Back from spectating")
    }
    if S["WATCH_TREASURE"]
        CheckTreasure(lines)
    if (S["AUTO_CLAIM"] && gameState != "spectating" && A_TickCount - lastClaimTick > 10000) {
        for ln in lines {
            u := Trim(StrUpper(ln.text))
            if (IsClaimWord(u) && ln.w > 20 && running && WinActive(S["GAME_WINDOW"])) {
                lastClaimTick := A_TickCount
                ReleaseAll()
                MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
                Sleep(150)
                Click()
                clicks += 1
                Log("Clicked reward button '" ln.text "' at " ln.x "," ln.y)
                SetStatus(Tx("Clicked '{1}'", ln.text))
                break
            }
        }
    }
}

IsClaimWord(u) {
    for w in ["CONTINUE", "COLLECT", "CLAIM", "CLAIM ALL", "CLAIM REWARD", "CLAIM REWARDS", "COLLECT ALL", "ACCEPT", "OKAY", "GOT IT"]
        if (u = w)
            return true
    return false
}

OcrLinesScript() {
    return '
    (
param($in, $out)
Add-Type -AssemblyName System.Runtime.WindowsRuntime
$null = [Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime]
$null = [Windows.Media.Ocr.OcrEngine, Windows.Foundation, ContentType = WindowsRuntime]
$null = [Windows.Graphics.Imaging.BitmapDecoder, Windows.Graphics, ContentType = WindowsRuntime]
$null = [Windows.Globalization.Language, Windows.Globalization, ContentType = WindowsRuntime]
$asTask = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq "AsTask" -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -match "^IAsyncOperation.1$" })[0]
function Await($op, $type) { $t = $asTask.MakeGenericMethod($type).Invoke($null, @($op)); $t.Wait(-1) | Out-Null; $t.Result }
$lang = New-Object Windows.Globalization.Language("en-US")
if ([Windows.Media.Ocr.OcrEngine]::IsLanguageSupported($lang)) { $eng = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang) } else { $eng = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages() }
$sb = New-Object System.Text.StringBuilder
try {
  $f = Await ([Windows.Storage.StorageFile]::GetFileFromPathAsync($in)) ([Windows.Storage.StorageFile])
  $s = Await ($f.OpenAsync([Windows.Storage.FileAccessMode]::Read)) ([Windows.Storage.Streams.IRandomAccessStream])
  $d = Await ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($s)) ([Windows.Graphics.Imaging.BitmapDecoder])
  $bmp = Await ($d.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])
  $r = Await ($eng.RecognizeAsync($bmp)) ([Windows.Media.Ocr.OcrResult])
  $s.Dispose()
  foreach ($l in $r.Lines) {
    $x1 = 99999; $y1 = 99999; $x2 = 0; $y2 = 0
    foreach ($w in $l.Words) {
      $b = $w.BoundingRect
      if ($b.X -lt $x1) { $x1 = $b.X }
      if ($b.Y -lt $y1) { $y1 = $b.Y }
      if ($b.X + $b.Width -gt $x2) { $x2 = $b.X + $b.Width }
      if ($b.Y + $b.Height -gt $y2) { $y2 = $b.Y + $b.Height }
    }
    [void]$sb.AppendLine(([string][int]$x1) + "|" + ([string][int]$y1) + "|" + ([string][int]($x2 - $x1)) + "|" + ([string][int]($y2 - $y1)) + "|" + $l.Text)
  }
} catch { }
[IO.File]::WriteAllText($out + ".tmp", $sb.ToString())
Move-Item -Force ($out + ".tmp") $out
    )'
}

; ============================================================
; v7.5: HTTP helper (webhook or bot), live status message
; ============================================================
; Returns {status, text}. auth = "" for webhooks, "bot" for the bot token.
HttpJson(method, url, body := "", auth := "") {
    res := {status: 0, text: ""}
    try {
        req := ComObject("WinHttp.WinHttpRequest.5.1")
        req.SetTimeouts(3000, 3000, 5000, 8000)
        req.Open(method, url, false)
        if (auth = "bot")
            req.SetRequestHeader("Authorization", "Bot " Trim(String(S["DISCORD_BOT_TOKEN"])))
        req.SetRequestHeader("User-Agent", "DiscordBot (https://github.com/yensobased1/lobby-loop, " VERSION ")")
        if (body != "")
            req.SetRequestHeader("Content-Type", "application/json")
        req.Send(body)
        res.status := req.Status
        res.text := req.ResponseText
    } catch as e {
        Log("HTTP " method " failed: " e.Message)
    }
    return res
}

ApiBase() {
    return "https://discord.com/api/v10/channels/" Trim(String(S["DISCORD_CHANNEL_ID"]))
}

; Posts a message and returns its id ("" if it failed). Uses the webhook, or the bot if there's no webhook.
DiscordPostGetId(content) {
    body := '{"username":"' JsonEscape(BotName()) '","avatar_url":"' ICON_URL '","content":"' JsonEscape(SubStr(content, 1, 1990)) '"}'
    hook := DiscordUrl()
    if (hook != "")
        res := HttpJson("POST", hook (InStr(hook, "?") ? "&" : "?") "wait=true", body)
    else if BotEnabled()
        res := HttpJson("POST", ApiBase() "/messages", '{"content":"' JsonEscape(SubStr(content, 1, 1990)) '"}', "bot")
    else
        return ""
    if (res.status >= 200 && res.status < 300) {
        try return JsonParse(res.text)["id"]
    }
    return ""
}

DiscordEdit(msgId, content) {
    hook := DiscordUrl()
    body := '{"content":"' JsonEscape(SubStr(content, 1, 1990)) '"}'
    if (hook != "")
        res := HttpJson("PATCH", RegExReplace(hook, "\?.*$") "/messages/" msgId, body)
    else if BotEnabled()
        res := HttpJson("PATCH", ApiBase() "/messages/" msgId, body, "bot")
    else
        return false
    return res.status >= 200 && res.status < 300
}

UnixNow() {
    return DateDiff(A_NowUTC, "19700101000000", "Seconds")
}

; A message that updates itself every minute. Discord shows "Last update: 3 minutes ago",
; so if that keeps growing, the PC is offline or Lobby Loop was closed.
LiveTick() {
    if (S["LIVE_STATUS"] && DiscordReady())
        LiveUpdate()
}

LiveUpdate(closing := false) {
    global liveMsgId
    content := LiveText(closing)
    if (liveMsgId != "" && DiscordEdit(liveMsgId, content))
        return true
    id := DiscordPostGetId(content)
    if (id != "") {
        liveMsgId := id
        IniWrite(id, STATS_FILE, "Stats", "LiveMsgId")
        return true
    }
    return false
}

LiveText(closing := false) {
    if closing
        head := "⚫ **" BotName() "** closed"
    else if running
        head := "🟢 **" BotName() "** running " FormatDuration(A_TickCount - sessionStart) " · " matches " matches this run · " StateLabel()
    else
        head := "⚪ **" BotName() "** stopped"
    left := running ? TimeLeftMs() : ""
    t := (left != "") ? "`n⏹ Stops in " FormatDuration(left) : ""
    last := (lastPlace != "") ? "`n🏆 Last: #" lastPlace (lastXP != "" ? ", " FormatNumber(lastXP) " XP" : "") : ""
    return "📡 **Live status**`n" head t last "`n📊 All time: " totalMatches " matches, " Round(totalMinutes / 60, 1) " h, 🏴‍☠️ " treasureCount " treasures"
        . "`n🕒 Last update: <t:" UnixNow() ":R>  (if this gets old, the PC is offline or Lobby Loop is closed)"
}

StateLabel() {
    labels := Map("lobby", "🏠 in the lobby", "end", "🏁 end screen", "spectating", "👻 spectating", "match", "🎮 in a match")
    return labels.Has(gameState) ? labels[gameState] : "🎮 in a match"
}

; ============================================================
; v7.5: Discord control panel (tap a reaction instead of typing)
; ============================================================
PanelCreate() {
    global panelMsgId, panelSeen
    if !BotEnabled()
        return false
    text := "🎛️ **Lobby Loop control panel** for **" PlayerName() "**`n"
        . "▶️ start   ⏹️ stop   📸 screenshot   📊 status   🌙 dim screen`n"
        . "Tap a reaction. To use the same one again, tap it off and on (or give the bot **Manage Messages** so it clears your tap)."
    res := HttpJson("POST", ApiBase() "/messages", '{"content":"' JsonEscape(text) '"}', "bot")
    if (res.status < 200 || res.status >= 300)
        return false
    try panelMsgId := JsonParse(res.text)["id"]
    catch
        return false
    IniWrite(panelMsgId, STATS_FILE, "Stats", "PanelMsgId")
    for e in PANEL_EMOJI {
        HttpJson("PUT", ApiBase() "/messages/" panelMsgId "/reactions/" e[1] "/@me", "", "bot")
        Sleep(450)
    }
    panelSeen := Map()
    Log("Control panel posted")
    return true
}

PanelPoll() {
    global panelSeen, botUserId, panelMsgId
    if (panelMsgId = "" || !BotEnabled())
        return
    if (botUserId = "") {
        me := HttpJson("GET", "https://discord.com/api/v10/users/@me", "", "bot")
        try botUserId := JsonParse(me.text)["id"]
    }
    for e in PANEL_EMOJI {
        res := HttpJson("GET", ApiBase() "/messages/" panelMsgId "/reactions/" e[1] "?limit=100", "", "bot")
        if (res.status = 404) {                      ; panel was deleted
            panelMsgId := ""
            IniWrite("", STATS_FILE, "Stats", "PanelMsgId")
            return
        }
        if (res.status != 200)
            continue
        try users := JsonParse(res.text)
        catch
            continue
        now := Map()
        for u in users
            if (u["id"] != botUserId)
                now[u["id"]] := true
        prev := panelSeen.Has(e[2]) ? panelSeen[e[2]] : Map()
        for uid in now.Clone() {
            if (prev.Has(uid) || !UserAllowed(uid))
                continue
            Log("Panel: " e[2] " by " uid)
            HandleCommand("!" e[2])
            del := HttpJson("DELETE", ApiBase() "/messages/" panelMsgId "/reactions/" e[1] "/" uid, "", "bot")
            if (del.status = 204)
                now.Delete(uid)                      ; cleared, so the next tap counts again
        }
        panelSeen[e[2]] := now
    }
}

UserAllowed(uid) {
    allowed := Trim(String(S["DISCORD_ALLOWED_IDS"]))
    return allowed = "" || InStr("," StrReplace(allowed, " ") ",", "," uid ",")
}

; ============================================================
; v7.5: pause / resume, auto screenshots, power commands
; ============================================================
PauseFor(mins) {
    global resumeAtTick
    if running
        ToggleRun("pause")
    resumeAtTick := A_TickCount + mins * 60000
    SetTimer(ResumeCheck, 5000)
    Log("Paused for " mins " min")
}

ResumeCheck() {
    global resumeAtTick
    if (!resumeAtTick || A_TickCount < resumeAtTick)
        return
    resumeAtTick := 0
    SetTimer(ResumeCheck, 0)
    ResumeNow()
    Discord("▶ Resumed after the pause")
}

ResumeNow() {
    global resumeAtTick
    resumeAtTick := 0
    SetTimer(ResumeCheck, 0)
    if running
        return
    if WinExist(S["GAME_WINDOW"])
        try WinActivate(S["GAME_WINDOW"])
    ToggleRun()
}

WatchTick() {
    global lastWatchShot
    mins := watchMinutes
    if (!running || mins <= 0 || !DiscordReady())
        return
    if (A_TickCount - lastWatchShot >= mins * 60000) {
        lastWatchShot := A_TickCount
        SendScreenshot("📸 Auto screenshot (every " mins " min) · " StateLabel())
    }
}

StartPowerAction(act) {
    global pendingAction, pendingLeft
    if running
        ToggleRun("Discord " act)
    pendingAction := act
    pendingLeft := 30
    Log("Power action from Discord in 30 s: " act)
    SetTimer(ActionTick, 1000)
    ActionTick()
}

; ============================================================
; v7.5: safe mode (after a crash) and error logging
; ============================================================
CheckSafeMode() {
    global safeMode
    clean := IniRead(STATS_FILE, "Stats", "CleanExit", 1)
    IniWrite(0, STATS_FILE, "Stats", "CleanExit")
    if (clean != 0)
        return
    safeMode := true
    for key in ["BLACKOUT_ON_START", "MUTE_WHILE_RUNNING", "READ_RESULTS", "WATCH_TREASURE", "AUTO_CLAIM", "LIVE_STATUS"]
        S[key] := 0                                   ; this session only, nothing is saved
    Log("Safe mode: Lobby Loop didn't close properly last time")
}

OnExitHandler(reason, code) {
    try {
        if S["MUTE_WHILE_RUNNING"]
            SetGameMute(false)
        else if (Number(S["GAME_VOLUME"]) < 100)
            SetGameVolume(100)
        KeepAwake(false)
        ToggleBlackout(false)
        ReleaseAll()
        if (S["LIVE_STATUS"] && DiscordReady() && liveMsgId != "")
            LiveUpdate(true)
        if !hadError
            IniWrite(1, STATS_FILE, "Stats", "CleanExit")
    }
}

OnErrorHandler(err, mode) {
    global hadError
    hadError := true
    try Log("ERROR: " err.Message " (line " err.Line ", " err.What ")")
    return 0                                           ; still show the normal error box
}

; ============================================================
; v7.5: share settings with a code
; ============================================================
ExportCode() {
    txt := ""
    for key in SHARE_KEYS
        txt .= key "=" S[key] ";"
    code := "LL75-" Base64Encode(txt)
    A_Clipboard := code
    Log("Settings code copied (" StrLen(code) " characters)")
    return code
}

ImportCode(code) {
    code := Trim(code)
    if (SubStr(code, 1, 5) != "LL75-")
        return 0
    txt := Base64Decode(SubStr(code, 6))
    if (txt = "")
        return 0
    n := 0
    for pair in StrSplit(txt, ";") {
        kv := StrSplit(pair, "=", , 2)
        if (kv.Length != 2)
            continue
        for key in SHARE_KEYS
            if (key = kv[1]) {
                SetSetting(key, IsNumber(kv[2]) ? Number(kv[2]) : kv[2])
                n += 1
            }
    }
    Log("Imported " n " settings from a code")
    return n
}

Base64Encode(str) {
    size := StrPut(str, "UTF-8") - 1
    buf := Buffer(size + 1, 0)
    StrPut(str, buf, "UTF-8")
    chars := 0
    DllCall("Crypt32\CryptBinaryToStringW", "Ptr", buf, "UInt", size, "UInt", 0x40000001, "Ptr", 0, "UInt*", &chars)
    out := Buffer(chars * 2, 0)
    DllCall("Crypt32\CryptBinaryToStringW", "Ptr", buf, "UInt", size, "UInt", 0x40000001, "Ptr", out, "UInt*", &chars)
    return StrGet(out, "UTF-16")
}

Base64Decode(b64) {
    bytes := 0
    if !DllCall("Crypt32\CryptStringToBinaryW", "Str", b64, "UInt", 0, "UInt", 1, "Ptr", 0, "UInt*", &bytes, "Ptr", 0, "Ptr", 0)
        return ""
    buf := Buffer(bytes + 2, 0)
    if !DllCall("Crypt32\CryptStringToBinaryW", "Str", b64, "UInt", 0, "UInt", 1, "Ptr", buf, "UInt*", &bytes, "Ptr", 0, "Ptr", 0)
        return ""
    return StrGet(buf, bytes, "UTF-8")
}

; ============================================================
; v7.5: report a bug
; ============================================================
ReportBug() {
    g := ThemeGui(TITLE " - " Tx("Report a bug"))
    UiText(g, "w520", "🐞 " Tx("Report a bug"), "title")
    UiText(g, "w520 y+6", Tx("What happened? (what you did, what you expected, what went wrong)"))
    desc := UiEdit(g, "w520 r6 y+6")
    UiText(g, "w520 y+8", Tx("Your log and version are added for you. Nothing personal is sent."), "muted")
    gh := UiButton(g, "xm y+14 w250 Default", "🐙 " Tx("Open a GitHub issue"))
    gh.OnEvent("Click", (*) => (BugToGitHub(desc.Value), g.Destroy()))
    dc := UiButton(g, "x+10 yp w250", "💬 " Tx("Send to my Discord"))
    dc.OnEvent("Click", (*) => (BugToDiscord(desc.Value), g.Destroy()))
    g.OnEvent("Escape", (*) => g.Destroy())
    g.Show()
}

BugInfo() {
    tail := ""
    try {
        logLines := StrSplit(FileRead(LOG_FILE), "`n", "`r")
        start := Max(1, logLines.Length - 40)
        loop logLines.Length - start + 1
            tail .= logLines[start + A_Index - 1] "`n"
    }
    return "Version: " VERSION (A_IsCompiled ? " (exe)" : " (ahk)") "`nScreen: " A_ScreenWidth "x" A_ScreenHeight "`nWindows: " A_OSVersion "`nLanguage: " S["LANG"] "`n`nLast log lines:`n``````" "`n" tail "``````"
}

BugToGitHub(desc) {
    body := "**What happened:**`n" (Trim(desc) != "" ? desc : "(no description)") "`n`n" BugInfo()
    body := SubStr(body, 1, 6000)
    title := "Bug: " SubStr(StrReplace(Trim(desc), "`n", " "), 1, 70)
    Run("https://github.com/yensobased1/lobby-loop/issues/new?title=" UriEncode(title) "&body=" UriEncode(body))
    Log("Bug report opened on GitHub")
}

BugToDiscord(desc) {
    if !DiscordReady() {
        ShowTip(Tx("Discord isn't set up. Press {1} and paste your webhook link.", HK_SETTINGS), 4000)
        return
    }
    copyPath := A_Temp "\" BASE "_log.txt"
    try FileCopy(LOG_FILE, copyPath, 1)
    ok := DiscordFile("🐞 **Bug report** from " PlayerName() " (v" VERSION ")`n" SubStr(desc, 1, 1500), copyPath)
    ShowTip(ok ? Tx("Sent to Discord") : Tx("Couldn't send to Discord"), 2500)
}

UriEncode(str) {
    out := ""
    size := StrPut(str, "UTF-8")
    buf := Buffer(size, 0)
    StrPut(str, buf, "UTF-8")
    loop size - 1 {
        b := NumGet(buf, A_Index - 1, "UChar")
        if ((b >= 0x30 && b <= 0x39) || (b >= 0x41 && b <= 0x5A) || (b >= 0x61 && b <= 0x7A) || b = 0x2D || b = 0x2E || b = 0x5F || b = 0x7E)
            out .= Chr(b)
        else
            out .= Format("%{:02X}", b)
    }
    return out
}

; ============================================================
; v7.5: install shortcuts / uninstall
; ============================================================
InstallShortcuts() {
    target := A_IsCompiled ? A_ScriptFullPath : A_AhkPath
    args := A_IsCompiled ? "" : '"' A_ScriptFullPath '"'
    ico := A_IsCompiled ? A_ScriptFullPath : (FileExist(A_ScriptDir "\lobby_loop.ico") ? A_ScriptDir "\lobby_loop.ico" : "")
    ok := 0
    for path in [A_Programs "\" TITLE ".lnk", A_Desktop "\" TITLE ".lnk"] {
        try {
            FileCreateShortcut(target, path, A_ScriptDir, args, TITLE, ico)
            ok += 1
        }
    }
    Log("Installed " ok " shortcuts")
    ShowTip(Tx("Added {1} to the Start menu and your Desktop.", TITLE), 3500)
}

Uninstall() {
    if (MsgBox(Tx("Remove {1} from this PC?", TITLE) "`n`n" Tx("This removes the shortcuts, Start with Windows and the program file."), TITLE, "YesNo Icon!") != "Yes")
        return
    if running
        ToggleRun("uninstall")
    SetStartWithWindows(false)
    try FileDelete(A_Programs "\" TITLE ".lnk")
    try FileDelete(A_Desktop "\" TITLE ".lnk")
    if (MsgBox(Tx("Also delete your settings, stats and history?"), TITLE, "YesNo Icon?") = "Yes") {
        for f in [INI_FILE, STATS_FILE, POPUP_FILE, HISTORY_FILE, MATCHES_FILE, TREASURE_FILE, DASH_FILE, LOG_FILE]
            try FileDelete(f)
    }
    Log("Uninstalled")
    Run(A_ComSpec ' /c ping 127.0.0.1 -n 3 > nul & del /f /q "' A_ScriptFullPath '"', , "Hide")
    ExitApp()
}

; ============================================================
; v7.5: popups (forget one, or the one under the mouse)
; ============================================================
ForgetPopup(index) {
    global POPUPS
    if (index < 1 || index > POPUPS.Length)
        return
    POPUPS.RemoveAt(index)
    SavePopups()
    Log("Forgot popup #" index)
}

ForgetPopupUnderMouse() {
    MouseGetPos(&mx, &my)
    for i, p in POPUPS {
        if (mx >= p.l * A_ScreenWidth && mx <= p.r * A_ScreenWidth && my >= p.t * A_ScreenHeight && my <= p.b * A_ScreenHeight) {
            ForgetPopup(i)
            ShowTip(Tx("Forgot popup button #{1}.", i), 2500)
            return
        }
    }
    ShowTip(Tx("No learned popup button under the mouse."), 2500)
}

; ============================================================
; v7.5: stats for phone commands
; ============================================================
WeekStats() {
    st := {matches: 0, minutes: 0, xp: 0, best: 0, treasures: 0}
    from := FormatTime(DateAdd(A_Now, -6, "Days"), "yyyy-MM-dd")
    for r in ReadCsvRows(MATCHES_FILE) {
        if (r.Length < 4 || StrCompare(r[1], from) < 0)
            continue
        st.matches += 1
        if IsNumber(r[4])
            st.xp += r[4]
        if (IsNumber(r[3]) && r[3] > 0 && (st.best = 0 || r[3] < st.best))
            st.best := Integer(r[3])
    }
    for r in ReadCsvRows(HISTORY_FILE)
        if (r.Length >= 4 && StrCompare(r[1], from) >= 0 && IsNumber(r[4]))
            st.minutes += r[4]
    for r in ReadCsvRows(TREASURE_FILE)
        if (r.Length >= 1 && StrCompare(r[1], from) >= 0)
            st.treasures += 1
    return st
}

LastMatchText() {
    rows := ReadCsvRows(MATCHES_FILE)
    if !rows.Length
        return "no matches recorded yet."
    r := rows[rows.Length]
    return "last match " r[1] " " r[2] (IsNumber(r[3]) ? ", placed #" r[3] : "") (r.Length >= 4 && IsNumber(r[4]) ? ", " FormatNumber(r[4]) " XP" : "")
}

AveragePlace() {
    sum := 0, n := 0
    for r in ReadCsvRows(MATCHES_FILE)
        if (r.Length >= 3 && IsNumber(r[3]) && r[3] > 0)
            sum += r[3], n += 1
    return n ? Round(sum / n) : 0
}

; ============================================================
; Helpers
; ============================================================
WriteSettingsFile() {
    txt := "; " TITLE " settings. Change a value, save, then right-click the tray icon > Reload.`n"
    txt .= "; Chances are percent (0-100). Times are milliseconds (1000 = 1 second).`n"
    txt .= "; Tip: start/stop times, stop action, auto-start and Discord are easier to set in the Settings window (F12).`n[Settings]`n"
    for d in DEFAULTS
        txt .= "; " d[3] "`n" d[1] "=" S[d[1]] "`n"
    try FileDelete(INI_FILE)
    FileAppend(txt, INI_FILE, "UTF-16")
}

Log(msg) {
    try FileAppend(FormatTime(, "HH:mm:ss") "  " msg "`n", LOG_FILE)
}

ShowTip(msg, ms) {
    ToolTip(msg)
    SetTimer(() => ToolTip(), -ms)
}

SetStatus(msg) {
    global lastMsg
    lastMsg := msg
}

FormatDuration(ms) {
    sec := Max(0, ms) // 1000
    return Format("{:02}:{:02}:{:02}", sec // 3600, Mod(sec // 60, 60), Mod(sec, 60))
}

RefreshOverlay() {
    static lastState := ""
    ; tray icon tooltip, even when the status box is hidden
    tip := TITLE ": " (running ? Tx("ON") " " FormatDuration(A_TickCount - sessionStart) ", " matches " " Tx("Matches") : Tx("OFF"))
    A_IconTip := SubStr(tip, 1, 120)
    if (statusTxt = "" || overlayHidden)
        return
    state := !running ? "off" : (WinActive(S["GAME_WINDOW"]) ? "on" : "paused")
    if (state != lastState) {
        OV["dot"].SetFont("c" (state = "on" ? "3DDC84" : state = "paused" ? "FFB300" : "777790"))
        lastState := state
    }
    icons := Map("lobby", "🏠", "end", "🏁", "spectating", "👻", "match", "🎮")
    stateIcon := (running && icons.Has(gameState)) ? "  " icons[gameState] : ""
    if !OV.Has("now") {                              ; mini style: one line
        left := running ? TimeLeftMs() : ""
        mini := (running ? Tx("ON") " " FormatDuration(A_TickCount - sessionStart) : Tx("OFF")) stateIcon "   🎮 " matches
        if (left != "")
            mini .= "   ⏹ " FormatDuration(left)
        if treasureCount
            mini .= "   🏴‍☠️ " treasureCount
        SetIfChanged(OV["head"], mini)
        return
    }
    SetIfChanged(OV["head"], TITLE "   " (running ? Tx("ON") "  " FormatDuration(A_TickCount - sessionStart) : Tx("OFF")) stateIcon)
    SetIfChanged(OV["now"], running ? lastMsg : Tx("{1} = start,  {2} = settings", HK_TOGGLE, HK_SETTINGS))
    ; stop timer + progress bar
    left := running ? TimeLeftMs() : ""
    pct := 0
    if (left != "") {
        elapsed := A_TickCount - sessionStart
        pct := Round(100 * elapsed / Max(1, elapsed + Max(0, left)))
        timerTxt := "⏹ " (stopAt != "" ? Tx("Stops in {1}   (at {2})", FormatDuration(left), FormatTime(stopAt, "h:mm tt")) : Tx("Stops in {1}", FormatDuration(left)))
    } else if running {
        timerTxt := "⏹ " Tx("Stop: no limit ({1} to set)", HK_SETTINGS)
    } else if (startAtNext != "") {
        timerTxt := "⏰ " Tx("Starts at {1}", FormatTime(startAtNext, "h:mm tt"))
    } else {
        timerTxt := "⏹ " Tx("Stop: {1}", DescribeStop())
    }
    if (ActionIndex(S["STOP_ACTION"]) > 1)
        timerTxt .= ", " Tx("then {1}", StrLower(ActionLabel(S["STOP_ACTION"])))
    if (OV["bar"].Value != pct)
        OV["bar"].Value := pct
    SetIfChanged(OV["timer"], timerTxt)
    runTxt := "🎮 " matches " " Tx("this run")
    if (lastPlace != "")
        runTxt .= "     🏆 #" lastPlace
    if (lastXP != "")
        runTxt .= "     ⭐ " FormatNumber(lastXP) " XP"
    if treasureCount
        runTxt .= "     🏴‍☠️ " treasureCount
    SetIfChanged(OV["run"], runTxt)
    mins := totalMinutes + (running ? (A_TickCount - sessionStart) / 60000 : 0)
    SetIfChanged(OV["total"], "📊 " Tx("All time: {1} matches, {2}h {3}m", totalMatches, Floor(mins / 60), Mod(Floor(mins), 60)))
}

SetIfChanged(ctrl, text) {
    if (ctrl.Value != text)
        ctrl.Value := text
}

CanAct() {
    return running && WinActive(S["GAME_WINDOW"])
}

SleepActive(ms) {
    end := A_TickCount + ms
    while (A_TickCount < end) {
        if !CanAct()
            return
        Sleep(20)
    }
}

HoldKeys(keyList, ms) {
    for keyName in keyList
        Send("{" keyName " down}")
    SleepActive(ms)
    for keyName in keyList
        Send("{" keyName " up}")
}

TapKey(keyName) {
    Send("{" keyName " down}")
    Sleep(Random(40, 90))
    Send("{" keyName " up}")
}

ReleaseAll() {
    for _, keyName in KEYMAP
        Send("{" keyName " up}")
}

Pick(arr) {
    return arr[Random(1, arr.Length)]
}

Chance(pct) {
    return Random(1, 100) <= pct
}

Look(dx, dy, steps := 8) {
    loop steps {
        if !CanAct()
            return
        DllCall("mouse_event", "UInt", 0x0001, "Int", Round(dx / steps), "Int", Round(dy / steps), "UInt", 0, "UPtr", 0)
        Sleep(Random(8, 22))
    }
}

; ---------- Screen capture (one screenshot of an area, read pixels from memory) ----------
Capture(x, y, w, h) {
    hdcScreen := DllCall("GetDC", "Ptr", 0, "Ptr")
    hdcMem := DllCall("CreateCompatibleDC", "Ptr", hdcScreen, "Ptr")
    hbm := DllCall("CreateCompatibleBitmap", "Ptr", hdcScreen, "Int", w, "Int", h, "Ptr")
    obm := DllCall("SelectObject", "Ptr", hdcMem, "Ptr", hbm, "Ptr")
    DllCall("BitBlt", "Ptr", hdcMem, "Int", 0, "Int", 0, "Int", w, "Int", h, "Ptr", hdcScreen, "Int", x, "Int", y, "UInt", 0x00CC0020)
    bi := Buffer(40, 0)
    NumPut("UInt", 40, bi, 0)
    NumPut("Int", w, bi, 4)
    NumPut("Int", -h, bi, 8)
    NumPut("UShort", 1, bi, 12)
    NumPut("UShort", 32, bi, 14)
    buf := Buffer(w * h * 4, 0)
    DllCall("GetDIBits", "Ptr", hdcMem, "Ptr", hbm, "UInt", 0, "UInt", h, "Ptr", buf, "Ptr", bi, "UInt", 0)
    DllCall("SelectObject", "Ptr", hdcMem, "Ptr", obm)
    DllCall("DeleteObject", "Ptr", hbm)
    DllCall("DeleteDC", "Ptr", hdcMem)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdcScreen)
    return {x: x, y: y, w: w, h: h, buf: buf}
}

Px(cap, x, y) {
    if (x < cap.x || y < cap.y || x >= cap.x + cap.w || y >= cap.y + cap.h)
        return -1
    return NumGet(cap.buf, ((y - cap.y) * cap.w + (x - cap.x)) * 4, "UInt") & 0xFFFFFF
}

Close(p, c, tol) {
    if (p < 0)
        return false
    return Abs(((p >> 16) & 0xFF) - ((c >> 16) & 0xFF)) <= tol
        && Abs(((p >> 8) & 0xFF) - ((c >> 8) & 0xFF)) <= tol
        && Abs((p & 0xFF) - (c & 0xFF)) <= tol
}

ColorDist(p, c) {
    return Abs(((p >> 16) & 0xFF) - ((c >> 16) & 0xFF))
         + Abs(((p >> 8) & 0xFF) - ((c >> 8) & 0xFF))
         + Abs((p & 0xFF) - (c & 0xFF))
}

FindButton(regionName) {
    rg := REGIONS[regionName]
    x1 := Round(rg[1] * A_ScreenWidth), y1 := Round(rg[2] * A_ScreenHeight)
    x2 := Round(rg[3] * A_ScreenWidth) - 1, y2 := Round(rg[4] * A_ScreenHeight) - 1
    cap := Capture(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
    tol := S["BUTTON_TOLERANCE"]
    q := Round(40 * SCALE)
    tries := 0
    y := y2
    while (y >= y1) {
        x := x1
        while (x <= x2) {
            p := Px(cap, x, y)
            if ((p & 0xFF) <= 70 && ((p >> 8) & 0xFF) >= 130) {
                for c in COLORS {
                    if (!Close(p, c, tol) || !Close(Px(cap, x + q, y), c, tol))
                        continue
                    tries += 1
                    if (tries > 150)
                        return 0
                    if (b := Measure(cap, x, y, c, tol))
                        return b
                }
            }
            x += 8
        }
        y -= 8
    }
    return 0
}

Measure(cap, fx, fy, c, tol) {
    st := 2
    y := fy - Round(6 * SCALE)
    if !Close(Px(cap, fx, y), c, tol)
        return 0
    l := fx, r := fx
    while Close(Px(cap, l - st, y), c, tol)
        l -= st
    while Close(Px(cap, r + st, y), c, tol)
        r += st
    w := r - l
    if (w < 250 * SCALE)
        return 0
    sx := l + Round(15 * SCALE)
    top := y, bot := fy
    while Close(Px(cap, sx, top - st), c, tol)
        top -= st
    while Close(Px(cap, sx, bot + st), c, tol)
        bot += st
    h := bot - top
    if (h < 80 * SCALE || h > 220 * SCALE)
        return 0
    cx := (l + r) // 2, cy := (top + bot) // 2
    xx := l + w // 5
    while (xx < r - w // 5) {
        p := Px(cap, xx, cy)
        if (p >= 0 && ((p >> 16) & 0xFF) + ((p >> 8) & 0xFF) + (p & 0xFF) < 270)
            return {x: cx, y: cy, w: w, h: h}
        xx += 3
    }
    return 0
}

TryClick(regionName) {
    global clicks, gameState
    if (A_TickCount - lastClick[regionName] < S["CLICK_COOLDOWN"])
        return false
    if !FindButton(regionName)
        return false
    Sleep(300)
    if !CanAct()
        return false
    b := FindButton(regionName)
    if !b
        return false
    gameState := regionName                         ; "lobby" or "end"
    ReleaseAll()
    lastClick[regionName] := A_TickCount
    MouseMove(b.x + Random(-b.w // 6, b.w // 6), b.y + Random(-b.h // 6, b.h // 6), 6)
    Sleep(Random(120, 260))
    Click()
    clicks += 1
    Log("Clicked " regionName " button at " b.x "," b.y " (" b.w "x" b.h ")")
    Sleep(Random(350, 600))
    return true
}

; ============================================================
; Movement
; ============================================================
DoWalk(allowSprint := true) {
    i := Random(1, 4)
    dirs := [KEYMAP["fwd"], KEYMAP["left"], KEYMAP["back"], KEYMAP["right"]]
    keyList := [dirs[i]]
    if Chance(S["COMBO_CHANCE"])
        keyList.Push((i = 1 || i = 3) ? Pick([KEYMAP["left"], KEYMAP["right"]]) : Pick([KEYMAP["fwd"], KEYMAP["back"]]))
    if (allowSprint && Chance(S["SPRINT_CHANCE"]))
        keyList.Push(KEYMAP["sprint"])
    HoldKeys(keyList, Random(S["WALK_MIN"], S["WALK_MAX"]))
}

DoCrouchWalk() {
    SetStatus(Tx("Crouch-walking"))
    TapKey(KEYMAP["crouch"])
    DoWalk(false)
    TapKey(KEYMAP["crouch"])
}

DoSlide() {
    SetStatus(Tx("Sliding"))
    Send("{" KEYMAP["fwd"] " down}{" KEYMAP["sprint"] " down}")
    SleepActive(Random(600, 1000))
    if CanAct() {
        TapKey(KEYMAP["crouch"])
        SleepActive(Random(700, 1200))
    }
    Send("{" KEYMAP["sprint"] " up}{" KEYMAP["fwd"] " up}")
}

DoStrafe() {
    SetStatus(Tx("Strafing"))
    side := Random(0, 1)
    loop Random(3, 6) {
        if !CanAct()
            return
        HoldKeys([side ? KEYMAP["left"] : KEYMAP["right"]], Random(150, 320))
        side := !side
    }
}

DoJump() {
    HoldKeys([KEYMAP["jump"]], Random(60, 140))
}

DoDive() {
    Look(Random(-400, 400), Random(250, 450))
    HoldKeys([KEYMAP["fwd"], Pick([KEYMAP["left"], KEYMAP["right"]])], Random(S["DIVE_MIN"], S["DIVE_MAX"]))
}

DoSwap() {
    if (SLOT_KEYS.Length)
        TapKey(Pick(SLOT_KEYS))
}

; ============================================================
; Main loop
; ============================================================
MainLoop() {
    global gameState, matches, totalMatches, lastProgress, unstickTries, goneSince, launchTick, launchTries, activateUntil
    global lobbyVisit, modeChecked, modeRecheckTick
    if !running
        return

    ; Stop timer (checked even when Fortnite isn't focused)
    left := TimeLeftMs()
    if (left != "" && left <= 0) {
        why := "time limit reached"
        if (stopAt != "" && DateDiff(stopAt, A_Now, "Seconds") <= 0)
            why := "reached " FormatTime(stopAt, "h:mm tt")
        ToggleRun("timer, " why)
        SetStatus("Stopped: " why)
        StartStopAction()
        return
    }

    ; Fortnite closed or crashed?
    if !WinExist(S["GAME_WINDOW"]) {
        if !goneSince
            goneSince := A_TickCount
        lastProgress := A_TickCount
        if (S["LAUNCH_FORTNITE"] && A_TickCount - goneSince > 30000) {
            TryLaunch()
            if running
                SetStatus("Opening Fortnite... (try " launchTries ")")
        } else {
            SetStatus(Tx("Waiting: Fortnite is not open"))
        }
        return
    }
    if goneSince {
        goneSince := 0
        if launchTick {
            Log("Fortnite is open again")
            Discord("Fortnite is open again")
            launchTick := 0
            launchTries := 0
            activateUntil := A_TickCount + 180000
        }
    }

    if !WinActive(S["GAME_WINDOW"]) {
        if (A_TickCount < activateUntil)
            try WinActivate(S["GAME_WINDOW"])    ; we just opened it: bring it to the front
        lastProgress := A_TickCount              ; watchdog only counts time spent in Fortnite
        SetStatus(Tx("Paused: click into Fortnite"))
        return
    }

    ; Stuck watchdog
    if (S["STUCK_MINUTES"] > 0 && A_TickCount - lastProgress > S["STUCK_MINUTES"] * 60000) {
        Unstick()
        return
    }

    ; 1) Menus: learned popups, Play Again after a match, lobby Ready / Play
    if TryPopups() {
        lastProgress := A_TickCount
        SetStatus(Tx("Clicked a popup button"))
        return
    }

    ; end screen
    if (A_TickCount - lastClick["end"] >= S["CLICK_COOLDOWN"] && FindButton("end")) {
        lobbyVisit := false
        if (S["WAIT_FOR_SQUAD"] && gameState = "spectating") {
            SetStatus("👻 " Tx("Waiting for my squad to finish"))
            AntiSleepNudge()
            lastProgress := A_TickCount
            SleepActive(1000)
            return
        }
        ; save the result areas (and a screenshot) before Play Again changes the screen
        gotCrops := false, shot := ""
        if S["READ_RESULTS"]
            gotCrops := SaveResultCrops()
        if (S["SCREENSHOT_EVERY_MATCH"] && DiscordReady())
            shot := TakeScreenshot()
        limit := Integer(S["MATCH_LIMIT"])
        if (limit > 0 && matches + 1 >= limit) {
            OnMatchEnd(gotCrops, shot)
            ToggleRun("match limit reached (" limit ")")
            SetStatus(Tx("Stopped: {1} matches done", limit))
            StartStopAction()
            return
        }
        if TryClick("end") {
            OnMatchEnd(gotCrops, shot)
            return
        }
    }

    ; lobby: mode check, then Ready / Play
    if (A_TickCount - lastClick["lobby"] >= S["CLICK_COOLDOWN"] && FindButton("lobby")) {
        if !lobbyVisit {                                ; just got to the lobby
            lobbyVisit := true
            modeChecked := false, modeRecheckTick := 0
        }
        if (!modeChecked || (modeRecheckTick && A_TickCount >= modeRecheckTick)) {
            modeChecked := true
            modeRecheckTick := 0
            if !ModeCheckBeforeReady()
                modeRecheckTick := A_TickCount + 60000        ; look again in a minute
        }
        if modeRecheckTick {
            SetStatus("⚠️ " Tx("Wrong mode, waiting (Settings > Mode)"))
            AntiSleepNudge()
            lastProgress := A_TickCount
            SleepActive(1000)
            return
        }
        if TryClick("lobby") {
            lobbyVisit := false
            lastProgress := A_TickCount
            unstickTries := 0
            SetStatus(Tx("Ready / Play clicked, waiting for match"))
        } else {
            SleepActive(200)
        }
        return
    }
    lobbyVisit := false

    ; eliminated: stop moving while spectating teammates
    if (gameState = "spectating" && S["SPECTATE_IDLE"]) {
        SetStatus("👻 " Tx("Spectating teammates"))
        AntiSleepNudge()
        SleepActive(1000)
        return
    }
    if (gameState != "spectating")
        gameState := "match"

    ; 2) Move around like a person
    SetStatus(Tx("Walking"))
    if Chance(S["SLIDE_CHANCE"])
        DoSlide()
    else if Chance(S["CROUCH_CHANCE"])
        DoCrouchWalk()
    else if Chance(S["STRAFE_CHANCE"])
        DoStrafe()
    else
        DoWalk()
    if (CanAct() && Chance(S["JUMP_CHANCE"]))
        DoJump()
    if (CanAct() && Chance(S["DIVE_CHANCE"])) {
        SetStatus(Tx("Diving"))
        DoDive()
    }
    if (CanAct() && Chance(S["SWAP_CHANCE"]))
        DoSwap()
    if (CanAct() && Chance(S["LOOK_CHANCE"]))
        Look(Random(-300, 300), Random(-40, 40))
    if (CanAct() && Chance(S["IDLE_CHANCE"])) {
        SetStatus(Tx("Standing still"))
        SleepActive(Random(S["IDLE_MIN"], S["IDLE_MAX"]))
    }
}

; Counts a finished match, reads the result, tells Discord
OnMatchEnd(gotCrops, shot) {
    global matches, totalMatches, lastProgress, unstickTries
    matches += 1
    totalMatches += 1
    lastProgress := A_TickCount
    unstickTries := 0
    IniWrite(totalMatches, STATS_FILE, "Stats", "TotalMatches")
    SetStatus(Tx("Match {1} done, Play Again clicked", matches))
    res := gotCrops ? ReadResults() : {place: "", xp: ""}
    RecordMatch(res)
    info := (res.place != "" ? ", placed #" res.place : "") (res.xp != "" ? ", " FormatNumber(res.xp) " XP" : "")
    text := "Match " matches " done" info " (all time: " totalMatches ")"
    if (shot != "")
        DiscordFile(text, shot)
    else if S["DISCORD_EVERY_MATCH"]
        Discord(text)
}

; ============================================================
; v7.6: Treasure watcher (categories, actions, clips)
; ============================================================
; Checked in this order: the rarest first, cosmetics last (it also catches any other YOU FOUND prize)
TreasureCategories() {
    cats := []
    for c in [["token", "Pirate Shop Access", "TREASURE_TOKEN"], ["gizmo", "Gizmo", "TREASURE_GIZMO"],
              ["custom", "My own words", ""], ["cosmetic", "Weekly treasure cosmetic", "TREASURE_COSMETIC"]] {
        on := (c[3] = "") ? true : S[c[3]]
        words := (c[3] = "") ? S["TREASURE_WORDS"] : S[c[3] "_WORDS"]
        if on
            cats.Push({key: c[1], name: c[2], words: WordList(words)})
    }
    return cats
}

WordList(text) {
    out := []
    for w in StrSplit(StrUpper(String(text)), ",", " `t")
        if (w != "")
            out.Push(w)
    return out
}

; Season text that says "treasure" / "pirate" all the time but isn't a prize
TreasureNoise(u) {
    for w in ["TREASURE HUNTERS", "TREASURE HOURS", "TREASURE HUNT CHEST", "TREASURE MAP", "CAPTAIN", "EQUIP", "QUEST", "ITEM SHOP", "PLUNDER THE"]
        if InStr(u, w)
            return true
    return false
}

; banner = the text is from Fortnite's "YOU FOUND ..." prize banner
TreasureCategoryFor(u, banner) {
    cats := TreasureCategories()
    for cat in cats
        for w in cat.words {
            strong := (SubStr(w, 1, 1) = "!")
            w2 := LTrim(w, "!")
            if (w2 != "" && InStr(u, w2) && (banner || strong))
                return cat
        }
    if banner
        for cat in cats
            if (cat.key = "cosmetic")
                return cat                              ; any other prize from the banner
    return ""
}

CheckTreasure(lines) {
    static seen := Map()
    W := A_ScreenWidth, H := A_ScreenHeight
    foundWords := WordList(S["TREASURE_FOUND_WORDS"])
    hits := []
    for ln in lines {
        u := StrUpper(ln.text)
        if TreasureNoise(u)
            continue
        isBanner := !foundWords.Length
        if !isBanner
            for w in foundWords
                if (InStr(u, w) && ln.y < H * 0.5) {        ; the prize banner is at the top of the screen
                    isBanner := true
                    break
                }
        if isBanner {
            txt := ln.text                                  ; add the lines right next to it (same banner)
            for other in lines
                if (other != ln && Abs(other.y - ln.y) < Max(ln.h, 20) * 3 && other.y < H * 0.5
                    && Abs((other.x + other.w / 2) - (ln.x + ln.w / 2)) < W * 0.25 && !TreasureNoise(StrUpper(other.text)))
                    txt .= " " other.text
            cat := TreasureCategoryFor(StrUpper(txt), true)
        } else {
            txt := ln.text
            cat := TreasureCategoryFor(u, false)            ; only ! words count without the banner
        }
        if IsObject(cat)
            hits.Push([txt, cat])
    }
    for h in hits {
        k := h[2].key ":" StrUpper(h[1])
        if (seen.Has(k) && A_TickCount - seen[k] < (h[2].key = "token" ? 1800000 : 180000))
            continue                                        ; Pirate Shop Access screens stay up: count it once
        seen[k] := A_TickCount
        TreasureFound(Trim(h[1]), h[2])
        break                                               ; one find per screen
    }
}

TreasureFound(text, cat := "") {
    global treasureCount, lastTreasure
    catKey := IsObject(cat) ? cat.key : "custom"
    catName := IsObject(cat) ? Tx(cat.name) : Tx("Treasure")
    treasureCount += 1
    lastTreasure := text
    IniWrite(treasureCount, STATS_FILE, "Stats", "TreasureCount")
    n := Integer(IniRead(STATS_FILE, "Stats", "Treasure_" catKey, 0)) + 1
    IniWrite(n, STATS_FILE, "Stats", "Treasure_" catKey)
    if !FileExist(TREASURE_FILE)
        try FileAppend("Date,Time,Category,Treasure`r`n", TREASURE_FILE, "UTF-8")
    try FileAppend(FormatTime(, "yyyy-MM-dd") "," FormatTime(, "HH:mm") "," catKey "," StrReplace(text, ",", " ") "`r`n", TREASURE_FILE, "UTF-8")
    Log("Treasure (" catKey "): " text)
    SetStatus("🏴‍☠️ " text)
    if S["TREASURE_BEEP"]
        SetTimer(() => (SoundBeep(1200, 90), SoundBeep(1600, 140)), -10)
    if S["TREASURE_NOTIFY"]
        Notify("🏴‍☠️ " catName, text)
    msg := "🏴‍☠️ **" catName "**: " text " (#" treasureCount " all time)"
    if (DiscordReady() && S["TREASURE_DISCORD"]) {
        shot := A_Temp "\ll_treasure.png"
        sent := false
        if S["TREASURE_SCREENSHOT"] {
            try FileCopy(A_Temp "\ll_screen.png", shot, 1)
            sent := FileExist(shot) && DiscordFile(msg, shot)
        }
        if !sent
            Discord(msg)
    }
    if S["TREASURE_CLIP"]
        SetTimer(() => DoClip(text), -Max(100, Number(S["CLIP_DELAY"]) * 1000))
}

; Presses the clip key of the recorder you use. Its clip length should be 25 s
; (20 s before the treasure + the 5 s we wait).
DoClip(why := "") {
    method := StrLower(String(S["CLIP_METHOD"]))
    if (method = "gamebar")
        Send("#!g")
    else if (method = "nvidia")
        Send("!{F10}")
    else if (Trim(String(S["CLIP_KEY"])) != "")
        Send(HotkeyToSend(S["CLIP_KEY"]))
    else
        return false
    Log("Clip key pressed (" method ")" (why != "" ? " for: " why : ""))
    SetStatus("🎬 " Tx("Clip saved"))
    if (S["CLIP_UPLOAD"] && DiscordReady())
        SetTimer(() => ClipUpload(why), -12000)       ; give the recorder time to save the file
    return true
}

; "^!c" -> "^!{c}", "F8" -> "{F8}" (so Send presses it like the hotkey)
HotkeyToSend(hk) {
    hk := Trim(String(hk))
    if !RegExMatch(hk, "^([#!^+]*)(.+)$", &m)
        return hk
    return m[1] "{" m[2] "}"
}

ClipFolder() {
    f := Trim(String(S["CLIP_FOLDER"]))
    return (f != "") ? f : EnvGet("USERPROFILE") "\Videos"
}

; Newest video saved in the last 2 minutes (searches sub-folders too)
FindNewestClip() {
    newest := "", newestTime := ""
    limit := DateAdd(A_Now, -2, "Minutes")
    for ext in ["mp4", "mkv", "mov"] {
        try {
            loop files ClipFolder() "\*." ext, "R" {
                if (A_LoopFileTimeModified < limit)
                    continue
                if (newest = "" || A_LoopFileTimeModified > newestTime)
                    newest := A_LoopFileFullPath, newestTime := A_LoopFileTimeModified
            }
        }
    }
    return newest
}

ClipUpload(why := "") {
    path := FindNewestClip()
    if (path = "") {
        Log("No new clip found in " ClipFolder())
        Discord("🎬 Clip key pressed" (why != "" ? " for **" why "**" : "") ", but no new video showed up in " ClipFolder())
        return
    }
    sizeMB := Round(FileGetSize(path) / 1048576, 1)
    SplitPath(path, &name)
    if (sizeMB <= 9.5) {
        if DiscordFile("🎬 Clip" (why != "" ? ": **" why "**" : "") " (" sizeMB " MB)", path)
            return
    }
    Discord("🎬 Clip saved on the PC: **" name "** (" sizeMB " MB, too big for Discord's 10 MB limit)")
}

RecentTreasureText(count := 5) {
    rows := ReadCsvRows(TREASURE_FILE)
    if !rows.Length
        return Tx("No treasure found yet.")
    out := ""
    loop Min(count, rows.Length) {
        r := rows[rows.Length - A_Index + 1]
        out .= (out = "" ? "" : "`n") "🏴‍☠️ " r[1] " " r[2] "   " (r.Length >= 4 ? r[4] : r[r.Length])
    }
    return out
}

; ============================================================
; v7.6: read part of the screen right now (used by the mode check, Stay with team,
;       and the "Read the screen now" button)
; ============================================================
OcrRegionSync(x, y, w, h) {
    lines := []
    img := A_Temp "\ll_region.png", out := A_Temp "\ll_region.txt"
    if !SaveRegionImage(img, x, y, w, h)
        return lines
    script := A_Temp "\ll_ocr_lines_v75.ps1"
    if !FileExist(script)
        FileAppend(OcrLinesScript(), script, "UTF-8")
    try FileDelete(out)
    try RunWait('powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "' script '" "' img '" "' out '"', , "Hide")
    if !FileExist(out)
        return lines
    for raw in StrSplit(FileRead(out, "UTF-8"), "`n", "`r") {
        p := StrSplit(raw, "|", , 5)
        if (p.Length < 5 || !IsNumber(p[1]))
            continue
        lines.Push({x: x + Integer(p[1]), y: y + Integer(p[2]), w: Integer(p[3]), h: Integer(p[4]), text: Trim(p[5])})
    }
    return lines
}

ShowScreenText(waitMs := 0) {
    if waitMs {
        ShowTip(Tx("Click into Fortnite. Checking in {1} seconds...", waitMs // 1000), waitMs - 300)
        Sleep(waitMs)
    }
    ShowTip(Tx("Reading the screen..."), 1500)
    lines := OcrRegionSync(0, 0, A_ScreenWidth, A_ScreenHeight)
    all := ""
    for ln in lines
        all .= ln.text "`r`n"
    path := A_ScriptDir "\" BASE "_screen_text.txt"
    try FileDelete(path)
    try FileAppend(all, path, "UTF-8")
    rows := []
    for ln in lines {
        if (rows.Length >= 14)
            break
        if (StrLen(ln.text) >= 3)
            rows.Push(["•", ln.text])
    }
    if !rows.Length
        rows.Push(["⚠️", Tx("No text found on screen.")])
    ShowCard("🔎 " Tx("What Lobby Loop reads on screen"), rows, 15000, Tx("All of it is saved in {1}. Use it to tune the treasure words.", BASE "_screen_text.txt"), 28)
}

; ============================================================
; v7.6: game mode (Solo / Duo / Trio / Squad, Build / Zero Build, Fill / No fill)
; ============================================================
; Reads the mode button above Ready in the lobby, e.g. "Build, Squad, Fill"
ReadLobbyMode() {
    lines := OcrRegionSync(0, Round(A_ScreenHeight * 0.52), Round(A_ScreenWidth * 0.32), Round(A_ScreenHeight * 0.36))
    all := "", anchor := ""
    for ln in lines {
        u := StrUpper(ln.text)
        all .= " " u
        if (!IsObject(anchor) && RegExMatch(u, "\b(SOLOS?|DUOS?|TRIOS?|SQUADS?|ZERO BUILD|BATTLE ROYALE)\b"))
            anchor := ln
    }
    if !IsObject(anchor)
        return 0
    m := ParseMode(all)
    m.x := anchor.x, m.y := anchor.y, m.w := anchor.w, m.h := anchor.h, m.text := ModeText(m.team != "" ? m.team : "?", m.build != "" ? m.build : "?", m.fill != "" ? m.fill : "?")
    return m
}

ParseMode(u) {
    team := RegExMatch(u, "\bSOLOS?\b") ? "solo" : RegExMatch(u, "\bDUOS?\b") ? "duo" : RegExMatch(u, "\bTRIOS?\b") ? "trio" : RegExMatch(u, "\bSQUADS?\b") ? "squad" : ""
    build := InStr(u, "ZERO BUILD") ? "zerobuild" : ((InStr(u, "BUILD") || InStr(u, "BATTLE ROYALE")) ? "build" : "")
    fill := RegExMatch(u, "NO FILL|DON.?T FILL") ? "nofill" : (RegExMatch(u, "\bFILL\b") ? "fill" : "")
    return {team: team, build: build, fill: fill}
}

ModeWanted() {
    return StrLower(S["MODE_TEAM"]) != "any" || StrLower(S["MODE_BUILD"]) != "any" || StrLower(S["MODE_FILL"]) != "any"
}

ModeOk(m) {
    if !IsObject(m)
        return false
    for pair in [["MODE_TEAM", "team"], ["MODE_BUILD", "build"], ["MODE_FILL", "fill"]] {
        want := StrLower(S[pair[1]])
        if (want != "any" && m.%pair[2]% != "" && m.%pair[2]% != want)
            return false
    }
    return true
}

ModeText(team, build, fill) {
    names := Map("any", Tx("any"), "solo", "Solo", "duo", "Duo", "trio", "Trio", "squad", "Squad",
                 "build", "Build", "zerobuild", "Zero Build", "fill", "Fill", "nofill", "No fill")
    get(k) => names.Has(StrLower(k)) ? names[StrLower(k)] : k
    return get(build) ", " get(team) ", " get(fill)
}

; Experimental: opens the mode picker and clicks the words for the mode you want
TrySwitchMode(m) {
    labels := Map("solo", ["SOLO", "SOLOS"], "duo", ["DUO", "DUOS"], "trio", ["TRIO", "TRIOS"], "squad", ["SQUAD", "SQUADS"],
                  "build", ["BUILD", "BATTLE ROYALE"], "zerobuild", ["ZERO BUILD"], "fill", ["FILL"], "nofill", ["NO FILL", "DON'T FILL"])
    Log("Trying to switch mode from '" m.text "'")
    ReleaseAll()
    MouseMove(m.x + m.w // 2, m.y + m.h // 2, 5)
    Sleep(200)
    Click()
    Sleep(2200)
    for key in ["MODE_BUILD", "MODE_TEAM", "MODE_FILL"] {
        want := StrLower(S[key])
        if (want = "any" || !labels.Has(want))
            continue
        lines := OcrRegionSync(0, 0, A_ScreenWidth, A_ScreenHeight)
        clicked := false
        for ln in lines {
            u := Trim(StrUpper(ln.text))
            for lab in labels[want]
                if (u = lab) {
                    MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
                    Sleep(150)
                    Click()
                    clicked := true
                    Log("Mode switch: clicked '" ln.text "'")
                    break
                }
            if clicked
                break
        }
        if !clicked
            Log("Mode switch: couldn't find '" want "' on screen")
        Sleep(1400)
    }
    Send("{Esc}")
    Sleep(1800)
    after := ReadLobbyMode()
    ok := ModeOk(after)
    Log("Mode switch " (ok ? "worked" : "didn't work") (IsObject(after) ? ", now: " after.text : ""))
    return ok
}

; Called once per lobby visit before clicking Ready. Returns true if it's OK to ready up.
ModeCheckBeforeReady() {
    global modeWarned
    if !ModeWanted()
        return true
    m := ReadLobbyMode()
    if !IsObject(m) {
        Log("Mode check: couldn't read the mode button")
        return true                                     ; can't tell, don't block
    }
    if ModeOk(m) {
        modeWarned := false
        return true
    }
    wanted := ModeText(S["MODE_TEAM"], S["MODE_BUILD"], S["MODE_FILL"])
    Log("Wrong mode: '" m.text "', want " wanted)
    if (S["MODE_SWITCH"] && TrySwitchMode(m))
        return true
    if !modeWarned {
        modeWarned := true
        Notify(Tx("Wrong mode"), Tx("The lobby is on {1}, you wanted {2}.", m.text, wanted))
        Discord("⚠️ Wrong mode: the lobby is on **" m.text "**, you wanted **" wanted "**.")
    }
    return StrLower(S["MODE_ACTION"]) = "ready"
}



KeepAwake(on) {
    ; ES_CONTINUOUS | ES_SYSTEM_REQUIRED while running, back to normal when stopped
    DllCall("SetThreadExecutionState", "UInt", on ? 0x80000001 : 0x80000000)
}

; Sets Fortnite's own volume (0-100) in the Windows volume mixer
SetGameVolume(pct) {
    pid := ProcessExist(GameExe())
    if !pid
        return false
    found := false
    dev := 0, mgr := 0, sessEnum := 0
    try {
        enumr := ComObject("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
        ComCall(4, enumr, "Int", 0, "Int", 1, "Ptr*", &dev)
        ComCall(3, dev, "Ptr", GuidBuf("{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"), "UInt", 23, "Ptr", 0, "Ptr*", &mgr)
        ComCall(5, mgr, "Ptr*", &sessEnum)
        cnt := 0
        ComCall(3, sessEnum, "Int*", &cnt)
        loop cnt {
            ctl := 0
            ComCall(4, sessEnum, "Int", A_Index - 1, "Ptr*", &ctl)
            try {
                ctl2 := ComObjQuery(ctl, "{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}")
                spid := 0
                ComCall(14, ctl2, "UInt*", &spid)
                if (spid = pid) {
                    vol := ComObjQuery(ctl, "{87CE5498-68D6-44E5-9215-6F24D7ED6E4E}")
                    ComCall(3, vol, "Float", Max(0, Min(100, pct)) / 100, "Ptr", 0)   ; SetMasterVolume
                    found := true
                }
            }
            ObjRelease(ctl)
        }
    } catch as e {
        Log("Volume failed: " e.Message)
    }
    for p in [sessEnum, mgr, dev]
        if p
            ObjRelease(p)
    return found
}




; ============================================================
; v7.6: Settings window (12 sections)
; ============================================================
OpenSettings(startPage := 1) {
    g := ThemeGui(TITLE " - " Tx("Settings"))
    c := Map()
    pages := []
    navs := []
    CW := 620                                         ; content width
    CX := 230                                         ; content left edge
    COL2 := 320                                       ; second column offset

    ; sidebar
    g.Add("Text", "x0 y0 w200 h660 Background" UiCol("side"))
    UiText(g, "x20 y18 w170", "🔁 " TITLE, "head", UiCol("side"))
    UiText(g, "x20 y+2 w170", "v" VERSION, "muted", UiCol("side"))
    sections := [["🎮", "Play"], ["🎯", "Mode"], ["🤝", "Squad fill"], ["⏰", "Schedule"], ["✨", "Extras"], ["🏴‍☠️", "Treasure"],
                 ["⌨️", "Hotkeys"], ["🧩", "Popups"], ["🔔", "Discord alerts"], ["📱", "Phone control"], ["🎨", "Look"], ["🔗", "Share & tools"]]
    for i, sec in sections {
        n := g.Add("Text", "x10 y" (78 + (i - 1) * 44) " w180 h38 0x200 Background" UiCol("side"), "   " sec[1] "   " StrReplace(Tx(sec[2]), "&", "&&"))
        n.OnEvent("Click", SettingsNav.Bind(i, pages, navs))
        navs.Push(n)
    }

    add(ctrl) => (pages[pages.Length].Push(ctrl), ctrl)
    addAll(arr) {
        for x in arr
            pages[pages.Length].Push(x)
        return arr[1]
    }
    newPage(title, sub := "") {
        pages.Push([])
        add(UiText(g, "x" CX " y22 w" CW, title, "title"))
        if (sub != "")
            add(UiText(g, "x" CX " y+2 w" CW, sub, "muted"))
    }
    tick(key, label, opts := "y+8", width := 0) => (c[key] := addAll(UiCheck(g, "x" CX " " opts, Tx(label), S[key], width ? width : CW - 30)))
    say(text, opts := "y+12", width := 0) => add(UiText(g, "x" CX " " opts " w" (width ? width : CW), text))
    hint(text, opts := "y+3") => add(UiText(g, "x" CX " " opts " w" CW, text, "muted"))
    edit(key, opts := "y+4 w200", value := "") => (c[key] := add(UiEdit(g, "x" CX " " opts " r1", value != "" ? value : S[key])))
    choice(key, items, keys, opts := "y+4 w260") {
        d := add(UiDDL(g, "x" CX " " opts, items))
        idx := 1
        for i, k in keys
            if (k = StrLower(String(S[key])))
                idx := i
        d.Choose(idx)
        c[key] := d
        return d
    }

    ; ---- 1. Play ----
    newPage(Tx("Play"), Tx("Lobby Loop keeps you in squad fills while you're away, so your teammates can farm chests for you while you bot."))
    say(Tx("Profile"), "y+16")
    c["PROFILE"] := add(UiDDL(g, "x" CX " y+4 w300", [ProfileLabel("overnight"), ProfileLabel("quick"), ProfileLabel("chill"), ProfileLabel("custom")]))
    c["PROFILE"].Choose(ProfileIndex(S["PROFILE"]))
    say(Tx("Stop after a time, or at a clock time:"), "y+14")
    c["STOP"] := add(UiEdit(g, "x" CX " y+4 w300 r1", CurrentStopText()))
    hint(Tx("e.g.   2h    90m    1h30m    9:30 PM    21:30      (blank = never)"))
    say(Tx("When it stops:"), "y+12")
    c["ACTION"] := add(UiDDL(g, "x" CX " y+4 w300", ActionLabels()))
    c["ACTION"].Choose(ActionIndex(S["STOP_ACTION"]))
    hint(Tx("Close / sleep / shut down wait 30 s first. Press {1} to cancel.", HK_TOGGLE))
    say(Tx("Stop after this many matches (0 = no limit):"), "y+12")
    edit("MATCH_LIMIT", "y+4 w120")
    say(Tx("Your name (for Discord and the leaderboard):"), "y+12")
    c["PLAYER_NAME"] := add(UiEdit(g, "x" CX " y+4 w300 r1", PlayerName()))

    ; ---- 2. Mode ----
    newPage(Tx("Mode"), Tx("Before readying up, Lobby Loop reads the mode button in the lobby (for example 'Build, Squad, Fill')."))
    say(Tx("Team size"), "y+16 Section", 280)
    choice("MODE_TEAM", [Tx("Any"), "Solo", "Duo", "Trio", "Squad"], ["any", "solo", "duo", "trio", "squad"], "y+4 w260")
    add(UiText(g, "xs+" COL2 " ys w280", Tx("Build")))
    d := add(UiDDL(g, "xs+" COL2 " y+4 w260", [Tx("Any"), "Build", "Zero Build"]))
    d.Choose(StrLower(S["MODE_BUILD"]) = "build" ? 2 : StrLower(S["MODE_BUILD"]) = "zerobuild" ? 3 : 1)
    c["MODE_BUILD"] := d
    say(Tx("Fill"), "y+16 Section", 280)
    choice("MODE_FILL", [Tx("Any"), "Fill", Tx("No fill")], ["any", "fill", "nofill"], "y+4 w260")
    add(UiText(g, "xs+" COL2 " ys w280", Tx("If the mode is wrong")))
    d2 := add(UiDDL(g, "xs+" COL2 " y+4 w260", [Tx("Wait and tell me"), Tx("Ready up anyway")]))
    d2.Choose(StrLower(S["MODE_ACTION"]) = "ready" ? 2 : 1)
    c["MODE_ACTION"] := d2
    tick("MODE_SWITCH", "Try to switch the mode for me (experimental)", "y+18")
    hint(Tx("The switch clicks the mode button and then the words for your mode. If it doesn't work, use Report a bug with a screenshot of the mode screen."))
    mb := add(UiButton(g, "x" CX " y+14 w260", "🔎 " Tx("Check the lobby mode now")))
    mb.OnEvent("Click", (*) => (g.Destroy(), ShowModeCheck(3000)))

    ; ---- 3. Squad fill ----
    newPage(Tx("Squad fill"), Tx("Your teammates open chests and farm while you bot. Lobby Loop keeps you queued, moving and out of the way."))
    tick("SPECTATE_IDLE", "Stop moving while I'm spectating teammates", "y+16")
    tick("WAIT_FOR_SQUAD", "Don't click Play Again while my teammates are still playing")
    hint(Tx("Treasure your teammates find only counts if you're still in the match."))
    tick("WAKE_FROM_SLEEP", "Wake Fortnite from Sleep Mode (clicks Keep Playing)", "y+12")
    hint(Tx("Best: in Fortnite go to Settings > Game > Energy Saving and set Sleep Mode to Never."))
    tick("AUTO_CLAIM", "Click reward buttons (Continue, Collect, Claim...)", "y+8")
    hint(Tx("Turn on Settings > Treasure to get told when you get gizmos, treasure cosmetics or pirate tokens."), "y+16")

    ; ---- 4. Schedule ----
    newPage(Tx("Schedule"), Tx("Start by itself, every day or with Windows."))
    say(Tx("Start every day at:"), "y+16")
    c["START"] := add(UiEdit(g, "x" CX " y+4 w200 r1", ClockText(S["START_AT_TIME"])))
    hint(Tx("e.g.   2:00 AM    14:30      (blank = off, Fortnite must be logged in)"))
    tick("AUTO_START", "Start by itself when I click into Fortnite", "y+14")
    tick("LAUNCH_FORTNITE", "Open Fortnite by itself (scheduled start, crash, stuck)")
    tick("START_WITH_WINDOWS", "Start with Windows")

    ; ---- 5. Extras ----
    newPage(Tx("Extras"), Tx("Comfort and stats while it runs."))
    tick("MUTE_WHILE_RUNNING", "Mute Fortnite while running", "y+16")
    say(Tx("Or set Fortnite's volume while running (0-100, 100 = leave it):"), "y+6")
    edit("GAME_VOLUME", "y+4 w120")
    tick("BLACKOUT_ON_START", "Dim the screen while running", "y+12")
    tick("KEEP_AWAKE", "Keep the PC awake while running")
    tick("READ_RESULTS", "Read my placement and XP after each match")
    tick("NOTIFY", "Windows notifications (stopped, stuck, crashed)")
    tick("STREAM_HIDE", "Hide the status box from OBS / streams / screenshots")
    hint(Tx("On some PCs this also hides it from your screen. Turn it off if the status box disappears."))

    ; ---- 6. Treasure ----
    newPage(Tx("Treasure"), Tx("Spots treasure on screen and tells you, with a screenshot or a clip."))
    tick("WATCH_TREASURE", "Watch for treasure", "y+14")
    add(UiText(g, "x" CX " y+14 w300 Section", Tx("What to look for"), "head"))
    add(UiText(g, "xs y+10 w300", Tx("Prize banner (must be on screen)")))
    c["TREASURE_FOUND_WORDS"] := add(UiEdit(g, "xs y+4 w300 r1", S["TREASURE_FOUND_WORDS"]))
    for item in [["TREASURE_TOKEN", "Pirate Shop Access (pirate token)"], ["TREASURE_GIZMO", "Gizmos (Sprite Locator, Lucky Locator...)"],
                 ["TREASURE_COSMETIC", "Weekly treasure cosmetics (and any other prize)"]] {
        c[item[1]] := addAll(UiCheck(g, "xs y+10", Tx(item[2]), S[item[1]], 280))
        c[item[1] "_WORDS"] := add(UiEdit(g, "xs y+4 w300 r1", S[item[1] "_WORDS"]))
    }
    add(UiText(g, "xs y+10 w300", Tx("My own words")))
    c["TREASURE_WORDS"] := add(UiEdit(g, "xs y+4 w300 r1", S["TREASURE_WORDS"]))
    add(UiText(g, "xs y+4 w300", Tx("Separate words with commas. Start a word with ! to count it without the banner."), "muted"))
    add(UiText(g, "xs+" COL2 " ys w300", Tx("When I find treasure"), "head"))
    first := true
    for item in [["TREASURE_NOTIFY", "Windows notification"], ["TREASURE_BEEP", "Play a sound"], ["TREASURE_DISCORD", "Tell Discord"],
                 ["TREASURE_SCREENSHOT", "Add a screenshot"], ["TREASURE_CLIP", "Save a clip (20 s before + 5 s after)"]] {
        c[item[1]] := addAll(UiCheck(g, "xs+" COL2 (first ? " y+10" : " y+6"), Tx(item[2]), S[item[1]], 270))
        first := false
    }
    add(UiText(g, "xs+" COL2 " y+10 w300", Tx("Clip with")))
    cm := add(UiDDL(g, "xs+" COL2 " y+4 w300", [Tx("Windows Game Bar (Win+Alt+G)"), Tx("NVIDIA (Alt+F10)"), Tx("My own clip key (Medal, OBS...)")]))
    cm.Choose(StrLower(S["CLIP_METHOD"]) = "nvidia" ? 2 : StrLower(S["CLIP_METHOD"]) = "custom" ? 3 : 1)
    c["CLIP_METHOD"] := cm
    add(UiText(g, "xs+" COL2 " y+8 w145", Tx("Clip key")))
    add(UiText(g, "x+10 yp w145", Tx("Wait (seconds)")))
    c["CLIP_KEY"] := add(UiEdit(g, "xs+" COL2 " y+4 w145 r1", S["CLIP_KEY"]))
    c["CLIP_DELAY"] := add(UiEdit(g, "x+10 yp w145 r1", S["CLIP_DELAY"]))
    c["CLIP_UPLOAD"] := addAll(UiCheck(g, "xs+" COL2 " y+8", Tx("Send the clip to Discord (if under 10 MB)"), S["CLIP_UPLOAD"], 270))
    add(UiText(g, "xs+" COL2 " y+6 w300", Tx("Set your recorder's clip length to 25 seconds (Game Bar: 30)."), "muted"))
    add(UiText(g, "x" CX " y474 w" CW, Tx("Recent finds"), "head"))
    add(UiText(g, "x" CX " y+2 w" CW " r2", RecentTreasureText(2), "muted"))
    rb := add(UiButton(g, "x" CX " y+6 w250", "🔎 " Tx("Read the screen now")))
    rb.OnEvent("Click", (*) => (g.Destroy(), ShowScreenText(4000)))
    tc := add(UiButton(g, "x+10 yp w200", "🎬 " Tx("Test the clip key")))
    tc.OnEvent("Click", (*) => SettingsTestClip(g, c))

    ; ---- 7. Hotkeys ----
    newPage(Tx("Hotkeys"), Tx("Change the keys if they clash with your game or keyboard."))
    add(UiText(g, "x" CX " y+16 w280 Section", Tx("Lobby Loop keys"), "head"))
    for i, pair in HOTKEY_FIELDS {
        add(UiText(g, "xs y+" (i = 1 ? 10 : 8) " w170", Tx(pair[2])))
        c[pair[1]] := add(UiEdit(g, "x+5 yp-3 w100 r1", S[pair[1]]))
    }
    add(UiText(g, "xs+" COL2 " ys w280", Tx("Your Fortnite keys"), "head"))
    for i, pair in GAMEKEY_FIELDS {
        add(UiText(g, "xs+" COL2 " y+" (i = 1 ? 10 : 8) " w150", Tx(pair[2])))
        c[pair[1]] := add(UiEdit(g, "x+5 yp-3 w120 r1", S[pair[1]]))
    }
    hint(Tx("Examples: F8, Insert, Numpad0, ^!s (Ctrl+Alt+S), +F8 (Shift+F8). Lobby Loop restarts after you save."), "y+16")

    ; ---- 8. Popups ----
    newPage(Tx("Popups"), Tx("Buttons you taught with {1}. They're clicked whenever they show up.", HK_TEACH))
    if !POPUPS.Length
        hint(Tx("No popup buttons learned yet."), "y+18")
    for i, p in POPUPS {
        pw := Round((p.r - p.l) * A_ScreenWidth), ph := Round((p.b - p.t) * A_ScreenHeight)
        add(g.Add("Text", "x" CX " y+" (i = 1 ? 18 : 10) " w22 h22 Background" Format("{:06X}", p.color)))
        add(UiText(g, "x+10 yp+2 w300", "#" i "   " pw " x " ph " px   (" Round(p.l * 100) "%, " Round(p.t * 100) "%)"))
        fb := add(UiButton(g, "x+10 yp-4 w140", "🗑 " Tx("Forget")))
        fb.OnEvent("Click", SettingsForgetPopup.Bind(i, g))
    }
    if POPUPS.Length {
        fa := add(UiButton(g, "x" CX " y+18 w200", Tx("Forget all")))
        fa.OnEvent("Click", (*) => (ForgetPopups(), g.Destroy(), OpenSettings(8)))
    }
    hint(Tx("To teach one: hover over an empty part of the popup's button and press {1}. To forget the one under the mouse: Shift+{1}.", HK_TEACH), "y+18")

    ; ---- 9. Discord alerts ----
    newPage(Tx("Discord alerts"), Tx("Messages, screenshots and a daily summary in your channel."))
    say(Tx("Discord alert link (optional):"), "y+16")
    c["HOOK"] := add(UiEdit(g, "x" CX " y+4 w" CW " r1", DiscordUrl()))
    tb := add(UiButton(g, "x" CX " y+10 w220", Tx("Send test message")))
    tb.OnEvent("Click", (*) => TestDiscord(c["HOOK"].Value, g))
    hb := add(UiButton(g, "x+10 yp w220", "❓ " Tx("How do I get this?")))
    hb.OnEvent("Click", (*) => ShowGuide("webhook", g.Hwnd))
    tick("SCREENSHOT_EVERY_MATCH", "Screenshot to Discord after every match", "y+16")
    tick("LIVE_STATUS", "Live status message (shows when the PC went offline)")
    say(Tx("Daily Discord summary at (blank = off):"), "y+14 Section", 280)
    c["SUMMARY"] := add(UiEdit(g, "x" CX " y+4 w200 r1", ClockText(S["DAILY_SUMMARY_TIME"])))
    add(UiText(g, "xs+" COL2 " ys w300", Tx("Screenshot to Discord every (minutes, 0 = off):")))
    c["AUTO_SCREENSHOT_MIN"] := add(UiEdit(g, "xs+" COL2 " y+4 w120 r1", S["AUTO_SCREENSHOT_MIN"]))

    ; ---- 10. Phone control ----
    newPage(Tx("Phone control"), Tx("Control Lobby Loop from Discord on your phone (optional)."))
    hb2 := add(UiButton(g, "x" CX " y+14 w260", "❓ " Tx("How do I set this up?")))
    hb2.OnEvent("Click", (*) => ShowGuide("bot", g.Hwnd))
    say(Tx("Bot token"), "y+14")
    c["TOKEN"] := add(UiEdit(g, "x" CX " y+4 w" CW " r1 Password", S["DISCORD_BOT_TOKEN"]))
    say(Tx("Channel ID"), "y+12")
    c["CHANNEL"] := add(UiEdit(g, "x" CX " y+4 w" CW " r1", S["DISCORD_CHANNEL_ID"]))
    say(Tx("Your Discord user ID (only you can control it)"), "y+12")
    c["ALLOWED"] := add(UiEdit(g, "x" CX " y+4 w" CW " r1", S["DISCORD_ALLOWED_IDS"]))
    pb := add(UiButton(g, "x" CX " y+14 w260", "🎛️ " Tx("Post the control panel")))
    pb.OnEvent("Click", (*) => ShowTip(PanelCreate() ? Tx("Sent to Discord") : Tx("Couldn't send to Discord"), 2500))
    hint(Tx("Type !help in your channel to see all 30+ commands."), "y+10")

    ; ---- 11. Look ----
    newPage(Tx("Look"), Tx("Language, theme and the status box."))
    add(UiText(g, "x" CX " y+18 w280 Section", Tx("Language")))
    c["LANG"] := add(UiDDL(g, "xs y+4 w260", ["English", "العربية"]))
    c["LANG"].Choose(IsArabic() ? 2 : 1)
    add(UiText(g, "xs+" COL2 " ys w280", Tx("Theme")))
    c["THEME"] := add(UiDDL(g, "xs+" COL2 " y+4 w260", [Tx("Dark"), Tx("Light")]))
    c["THEME"].Choose(DarkOn() ? 1 : 2)
    add(UiText(g, "xs y+16 w280 Section", Tx("Accent colour")))
    c["ACCENT"] := add(UiDDL(g, "xs y+4 w260", [Tx("Yellow"), Tx("Purple"), Tx("Cyan"), Tx("Pink"), Tx("Green")]))
    ai := 1
    for i, k in ["yellow", "purple", "cyan", "pink", "green"]
        if (k = StrLower(S["ACCENT"]))
            ai := i
    c["ACCENT"].Choose(ai)
    add(UiText(g, "xs+" COL2 " ys w280", Tx("Status box style")))
    c["STYLE"] := add(UiDDL(g, "xs+" COL2 " y+4 w260", [Tx("Card"), Tx("Mini")]))
    c["STYLE"].Choose(StrLower(S["OVERLAY_STYLE"]) = "mini" ? 2 : 1)
    add(UiText(g, "xs y+16 w280 Section", Tx("Status box corner")))
    c["CORNER"] := add(UiDDL(g, "xs y+4 w260", [Tx("Top left"), Tx("Top right"), Tx("Bottom left"), Tx("Bottom right"), Tx("Where I dragged it")]))
    ci := 1
    for i, k in ["top-left", "top-right", "bottom-left", "bottom-right", "custom"]
        if (k = StrLower(S["OVERLAY_CORNER"]))
            ci := i
    c["CORNER"].Choose(ci)
    add(UiText(g, "xs+" COL2 " ys w280", Tx("Status box size")))
    c["SIZE"] := add(UiDDL(g, "xs+" COL2 " y+4 w260", [Tx("Small"), Tx("Normal"), Tx("Large")]))
    si := 2
    for i, k in ["small", "normal", "large"]
        if (k = StrLower(S["OVERLAY_SIZE"]))
            si := i
    c["SIZE"].Choose(si)
    c["SHOW_OVERLAY"] := addAll(UiCheck(g, "xs y+18", Tx("Show the status box") "  (" HK_OVERLAY ")", !overlayHidden, 260))
    mv := add(UiButton(g, "xs+" COL2 " yp-4 w260", "✋ " Tx("Move status box")))
    mv.OnEvent("Click", (*) => (g.Destroy(), MoveOverlay()))

    ; ---- 12. Share & tools ----
    newPage(StrReplace(Tx("Share & tools"), "&", "&&"), Tx("Share your setup with friends, report bugs, install or remove."))
    say(Tx("Settings code (your profile, timers, movement and look. No names or Discord links):"), "y+18")
    c["CODE"] := add(UiEdit(g, "x" CX " y+4 w" CW " r2"))
    cb1 := add(UiButton(g, "x" CX " y+8 w300", "📋 " Tx("Copy my code")))
    cb1.OnEvent("Click", (*) => (c["CODE"].Value := ExportCode(), ShowTip(Tx("Copied. Send it to a friend."), 2500)))
    cb2 := add(UiButton(g, "x+10 yp w300", "📥 " Tx("Use the pasted code")))
    cb2.OnEvent("Click", (*) => SettingsImportCode(g, c["CODE"].Value))
    add(UiText(g, "x" CX " y+22 w" CW, Tx("Tools"), "head"))
    t1 := add(UiButton(g, "x" CX " y+8 w300", "🐞 " Tx("Report a bug")))
    t1.OnEvent("Click", (*) => ReportBug())
    t2 := add(UiButton(g, "x+10 yp w300", "📌 " Tx("Add shortcuts")))
    t2.OnEvent("Click", (*) => InstallShortcuts())
    t3 := add(UiButton(g, "x" CX " y+8 w300", "📊 " Tx("Stats dashboard")))
    t3.OnEvent("Click", (*) => OpenDashboard())
    t4 := add(UiButton(g, "x+10 yp w300", "🗑️ " Tx("Uninstall")))
    t4.OnEvent("Click", (*) => (g.Destroy(), Uninstall()))

    ; ---- bottom bar ----
    g.Add("Text", "x" CX " y582 w" CW " h1 Background" UiCol("line"))
    saveBtn := UiButton(g, "x" (CX + CW - 250) " y596 w120 Default", Tx("Save"))
    saveBtn.OnEvent("Click", (*) => SaveSettingsGui(g, c))
    cancelBtn := UiButton(g, "x+10 yp w120", Tx("Cancel"))
    cancelBtn.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())

    SettingsNav(Min(Max(1, startPage), pages.Length), pages, navs)
    g.Show("w" (CX + CW + 30) " h646")
}

SettingsTestClip(g, c) {
    oldMethod := S["CLIP_METHOD"], oldKey := S["CLIP_KEY"]
    S["CLIP_METHOD"] := ["gamebar", "nvidia", "custom"][c["CLIP_METHOD"].Value]
    S["CLIP_KEY"] := Trim(c["CLIP_KEY"].Value)
    ok := DoClip("test")
    S["CLIP_METHOD"] := oldMethod, S["CLIP_KEY"] := oldKey
    MsgBox(ok ? Tx("Clip key pressed. Check your recorder's folder for a new clip.") : Tx("Pick a clip method, or type your clip key first."), TITLE, "Iconi Owner" g.Hwnd)
}

ShowModeCheck(waitMs := 0) {
    if waitMs {
        ShowTip(Tx("Click into Fortnite. Checking in {1} seconds...", waitMs // 1000), waitMs - 300)
        Sleep(waitMs)
    }
    m := ReadLobbyMode()
    wanted := ModeText(S["MODE_TEAM"], S["MODE_BUILD"], S["MODE_FILL"])
    if !IsObject(m)
        rows := [["⚠️", Tx("Couldn't read the mode button. Open the Fortnite lobby first.")]]
    else
        rows := [[ModeOk(m) ? "✅" : "❌", Tx("Lobby is on: {1}", m.text)], ["•", Tx("You want: {1}", wanted), true]]
    ShowCard("🎯 " Tx("Mode check"), rows, 8000)
}

SaveSettingsGui(g, c) {
    global botLastId, botFails, watchMinutes
    bad(msg) => MsgBox(msg, TITLE, "Icon! Owner" g.Hwnd)
    num(key, label, lo, hi) {
        v := Trim(c[key].Value)
        if (v = "")
            v := lo
        if (!IsNumber(v) || v < lo || v > hi)
            throw Error(Tx("'{1}' should be a number from {2} to {3}.", label, lo, hi))
        return Number(v)
    }
    ; stop timer
    str := Trim(c["STOP"].Value)
    stopH := 0, stopM := 0, stopT := ""
    if (str != "") {
        if (ck := ParseClock(str))
            stopT := Format("{:02}:{:02}", ck.h, ck.m)
        else if (dur := ParseDuration(str))
            stopH := dur.h, stopM := dur.m
        else
            return bad("Couldn't understand the stop time '" str "'.`n`nTry: 2h, 90m, 1h30m, 9:30 PM or 21:30")
    }
    startT := "", sumT := ""
    if (Trim(c["START"].Value) != "") {
        if !(ck2 := ParseClock(Trim(c["START"].Value)))
            return bad("Couldn't understand the start time.`n`nTry: 2:00 AM or 14:30")
        startT := Format("{:02}:{:02}", ck2.h, ck2.m)
    }
    if (Trim(c["SUMMARY"].Value) != "") {
        if !(ck3 := ParseClock(Trim(c["SUMMARY"].Value)))
            return bad("Couldn't understand the summary time.`n`nTry: 11:55 PM or 23:55")
        sumT := Format("{:02}:{:02}", ck3.h, ck3.m)
    }
    hook := Trim(c["HOOK"].Value)
    if (hook != "" && !IsDiscordUrl(hook))
        return bad("That doesn't look like a Discord webhook link.`nIt should start with https://discord.com/api/webhooks/")
    channel := Trim(c["CHANNEL"].Value)
    if (channel != "" && !RegExMatch(channel, "^\d{15,22}$"))
        return bad("The channel ID should be a long number (right-click the channel > Copy Channel ID).")
    try {
        nums := Map("MATCH_LIMIT", num("MATCH_LIMIT", Tx("Stop after this many matches (0 = no limit):"), 0, 10000),
                    "GAME_VOLUME", num("GAME_VOLUME", Tx("Or set Fortnite's volume while running (0-100, 100 = leave it):"), 0, 100),
                    "CLIP_DELAY", num("CLIP_DELAY", Tx("Wait (seconds)"), 0, 60),
                    "AUTO_SCREENSHOT_MIN", num("AUTO_SCREENSHOT_MIN", Tx("Screenshot to Discord every (minutes, 0 = off):"), 0, 1440))
    } catch as e {
        return bad(e.Message)
    }
    oldStream := S["STREAM_HIDE"] ? 1 : 0
    clipKey := Trim(c["CLIP_KEY"].Value)
    if (clipKey != "" && !ValidHotkey(clipKey))
        return bad("'" clipKey "' isn't a key Lobby Loop can press (examples: F8, ^!c, +F9).")
    ; hotkeys and game keys
    keysChanged := false
    seenHk := Map()
    for pair in HOTKEY_FIELDS {
        v := Trim(c[pair[1]].Value)
        if !ValidHotkey(v)
            return bad("'" v "' can't be used as the " Tx(pair[2]) " key.`n`nExamples: F8, Insert, Numpad0, ^!s, +F8")
        if seenHk.Has(StrLower(v))
            return bad("'" v "' is used for two Lobby Loop keys. Pick a different key for one of them.")
        seenHk[StrLower(v)] := true
    }
    for pair in GAMEKEY_FIELDS {
        v := Trim(c[pair[1]].Value)
        if (pair[1] = "KEY_SLOTS") {
            for slot in StrSplit(v, ",", " `t")
                if !ValidKey(slot)
                    return bad("'" slot "' isn't a key name (weapon slots look like: 1,2,3,4,5).")
        } else if !ValidKey(v) {
            return bad("'" v "' isn't a key name AutoHotkey knows (examples: w, Space, LShift, LCtrl).")
        }
    }

    ; profile first, then the values typed on this window win
    newProfile := PROFILE_KEYS[c["PROFILE"].Value]
    if (newProfile != S["PROFILE"])
        ApplyProfile(newProfile)
    if (hook != "" && hook != DiscordUrl())
        SetupWebhook(hook)
    SaveStop(stopH, stopM, stopT)
    SetSetting("STOP_ACTION", ACTIONS[c["ACTION"].Value][1])
    SetSetting("START_AT_TIME", startT)
    SetSetting("DAILY_SUMMARY_TIME", sumT)
    for key in ["AUTO_START", "LAUNCH_FORTNITE", "MUTE_WHILE_RUNNING", "BLACKOUT_ON_START", "READ_RESULTS",
                "SCREENSHOT_EVERY_MATCH", "NOTIFY", "SPECTATE_IDLE", "WAIT_FOR_SQUAD", "WAKE_FROM_SLEEP", "AUTO_CLAIM", "WATCH_TREASURE", "LIVE_STATUS", "MODE_SWITCH",
                "KEEP_AWAKE", "STREAM_HIDE",
                "TREASURE_GIZMO", "TREASURE_COSMETIC", "TREASURE_TOKEN", "TREASURE_NOTIFY", "TREASURE_BEEP", "TREASURE_DISCORD",
                "TREASURE_SCREENSHOT", "TREASURE_CLIP", "CLIP_UPLOAD"]
        if c.Has(key)
            SetSetting(key, c[key].Value)
    for key, v in nums
        SetSetting(key, v)
    for key in ["TREASURE_GIZMO_WORDS", "TREASURE_COSMETIC_WORDS", "TREASURE_TOKEN_WORDS", "TREASURE_WORDS", "TREASURE_FOUND_WORDS"]
        SetSetting(key, Trim(c[key].Value))
    SetSetting("CLIP_KEY", clipKey)
    SetSetting("CLIP_METHOD", ["gamebar", "nvidia", "custom"][c["CLIP_METHOD"].Value])
    SetSetting("MODE_TEAM", ["any", "solo", "duo", "trio", "squad"][c["MODE_TEAM"].Value])
    SetSetting("MODE_BUILD", ["any", "build", "zerobuild"][c["MODE_BUILD"].Value])
    SetSetting("MODE_FILL", ["any", "fill", "nofill"][c["MODE_FILL"].Value])
    SetSetting("MODE_ACTION", c["MODE_ACTION"].Value = 2 ? "ready" : "wait")
    watchMinutes := nums["AUTO_SCREENSHOT_MIN"]
    if (c["START_WITH_WINDOWS"].Value != (S["START_WITH_WINDOWS"] ? 1 : 0))
        SetStartWithWindows(c["START_WITH_WINDOWS"].Value)
    SetSetting("START_WITH_WINDOWS", c["START_WITH_WINDOWS"].Value)
    SetSetting("PLAYER_NAME", Trim(c["PLAYER_NAME"].Value))
    SetSetting("DISCORD_WEBHOOK", hook)
    SetSetting("DISCORD_BOT_TOKEN", Trim(c["TOKEN"].Value))
    SetSetting("DISCORD_CHANNEL_ID", channel)
    SetSetting("DISCORD_ALLOWED_IDS", Trim(c["ALLOWED"].Value))
    for pair in HOTKEY_FIELDS
        if (Trim(c[pair[1]].Value) != String(S[pair[1]])) {
            SetSetting(pair[1], Trim(c[pair[1]].Value))
            keysChanged := true
        }
    for pair in GAMEKEY_FIELDS
        if (Trim(c[pair[1]].Value) != String(S[pair[1]])) {
            SetSetting(pair[1], Trim(c[pair[1]].Value))
            keysChanged := true
        }
    newLang := (c["LANG"].Value = 2) ? "ar" : "en"
    newTheme := (c["THEME"].Value = 2) ? "light" : "dark"
    newSize := ["small", "normal", "large"][c["SIZE"].Value]
    newStyle := (c["STYLE"].Value = 2) ? "mini" : "card"
    newAccent := ["yellow", "purple", "cyan", "pink", "green"][c["ACCENT"].Value]
    needReload := keysChanged || (newLang != S["LANG"]) || (newTheme != S["THEME"]) || (newSize != StrLower(S["OVERLAY_SIZE"]))
        || (newStyle != StrLower(S["OVERLAY_STYLE"])) || (newAccent != StrLower(S["ACCENT"])) || (oldStream != c["STREAM_HIDE"].Value)
    SetSetting("OVERLAY_STYLE", newStyle)
    SetSetting("ACCENT", newAccent)
    SetSetting("LANG", newLang)
    SetSetting("THEME", newTheme)
    SetSetting("OVERLAY_SIZE", newSize)
    SetSetting("OVERLAY_CORNER", ["top-left", "top-right", "bottom-left", "bottom-right", "custom"][c["CORNER"].Value])
    if (c["SHOW_OVERLAY"].Value = (overlayHidden ? 1 : 0))
        ToggleOverlay(c["SHOW_OVERLAY"].Value)
    g.Destroy()
    botLastId := "", botFails := 0
    if running {
        ApplyStopLimits()
        KeepAwake(S["KEEP_AWAKE"])
        if !S["MUTE_WHILE_RUNNING"]
            SetGameVolume(S["GAME_VOLUME"])
    }
    ApplyStartSchedule()
    PlaceOverlay()
    Log("Settings saved. Profile: " S["PROFILE"] ", mode: " ModeText(S["MODE_TEAM"], S["MODE_BUILD"], S["MODE_FILL"]) ", stop: " DescribeStop())
    if needReload {
        Reload()
        return
    }
    ShowTip(Tx("Saved.") "`n" Tx("Stop: {1}", DescribeStop()) ", " Tx("then {1}", StrLower(ActionLabel(S["STOP_ACTION"]))), 4000)
}

; ============================================================
; v7.6: Fortnite Sleep Mode
; Fortnite sleeps after 5-60 minutes with no input (15 by default). In the queue that cancels
; matchmaking; Keep Playing takes you back (or to the lobby).
; ============================================================
WakeFromSleep(lines) {
    global sleepWakes, lastNudgeTick, clicks, lastProgress, lobbyVisit
    static lastWake := 0
    if (!running || !WinActive(S["GAME_WINDOW"]) || A_TickCount - lastWake < 8000)
        return false
    for ln in lines {
        if (Trim(StrUpper(ln.text)) != "KEEP PLAYING")
            continue
        lastWake := A_TickCount
        sleepWakes += 1
        ReleaseAll()
        MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
        Sleep(200)
        Click()
        clicks += 1
        lastNudgeTick := A_TickCount
        lastProgress := A_TickCount
        lobbyVisit := false
        Log("Fortnite was in Sleep Mode: clicked Keep Playing (" sleepWakes " this run)")
        SetStatus("😴 " Tx("Woke Fortnite from Sleep Mode"))
        if (sleepWakes = 1 || Mod(sleepWakes, 10) = 0)
            Discord("😴 Fortnite went into **Sleep Mode**, clicked Keep Playing (" sleepWakes "x this run). "
                . "Tip: in Fortnite set Settings > Game > Energy Saving > Sleep Mode to **Never**.")
        return true
    }
    return false
}

; A tiny camera turn every few minutes while Lobby Loop is standing still on purpose,
; so Fortnite doesn't count you as inactive
AntiSleepNudge() {
    global lastNudgeTick
    if (!S["WAKE_FROM_SLEEP"] || A_TickCount - lastNudgeTick < 240000 || !CanAct())
        return
    lastNudgeTick := A_TickCount
    dx := Random(15, 40) * (Random(0, 1) ? 1 : -1)
    Look(dx, 0, 3)
    Sleep(150)
    Look(-dx, 0, 3)
}
