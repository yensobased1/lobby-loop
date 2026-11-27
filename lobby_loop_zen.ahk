#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook True
;@Ahk2Exe-SetName Lobby Loop Zen
;@Ahk2Exe-SetDescription Lobby Loop Zen
;@Ahk2Exe-SetVersion 7.9.1
;@Ahk2Exe-SetMainIcon lobby_loop.ico
;@Ahk2Exe-UpdateManifest 1
InstallKeybdHook()
SetWorkingDir(A_ScriptDir)
SendMode("Event")
CoordMode("Mouse", "Screen")
CoordMode("Pixel", "Screen")
CoordMode("ToolTip", "Screen")

TITLE := "Lobby Loop Zen"
VERSION := "7.9.1"

; Auto-update link (the raw link to version.txt on GitHub). Can also be set in the settings file.
UPDATE_URL_DEFAULT := "https://raw.githubusercontent.com/yensobased1/lobby-loop/main/version.txt"
; Picture used for the Discord bot
ICON_URL := "https://raw.githubusercontent.com/yensobased1/lobby-loop/main/lobby_loop_icon.png"

CHANGELOG := [
    "v7.9.1  (27 Nov 2026) - bug fixes",
    "  * Online treasure words never reached some PCs (Settings > Save put the old",
    "    lists back). Now they're added to your lists every time, your own words stay",
    "  * GIZMO and PIRATE SHOP ACCESS always count, even if your word lists miss them",
    "  * OCR slips (one wrong letter, missing spaces, e.g. SPRITEGIZMO) still match",
    "  * The match recap's TREASURE FOUND: counts once per match, not twice",
    "  * Dim screen waits until Fortnite is open, so you're not left with a black",
    "    screen while it starts",
    "  * Match recap: gold Pirate Shop Access icon detected, Discord gets a close-up",
    "  * New drawn icons in Settings; Lobby Loop's own windows never trigger the watcher",
    "  + Remote play (Settings > Phone control) for Parsec / AnyDesk from your phone:",
    "    steps aside when you move the mouse and lets go of all keys, hands back after",
    "    60 s, shows the status box to them, brings Fortnite back to the front",
    "  + Tells you on Discord if the PC gets locked (and waits) or the screen size changes",
    "  + Phone: !focus, !keys, !remote on/off, !set remote on; !status shows PC time",
    "",
    "v7.9  (22 Nov 2026)",
    "  * Clicks CLAIM on the TREASURE FOUND! screen (it got stuck there before),",
    "    one prize after another, and saves the item name (e.g. Oscar's Wraps, Loading screen)",
    "  * No more false finds from the status box, Settings or other windows, or when",
    "    you tab out",
    "  * Gizmos: YOU FOUND SPRITE GIZMO now counts as a gizmo",
    "  * The weekly cosmetics category is now just called Treasure",
    "  * Phone control: tells you when the bot token is missing, and retries after",
    "    10 minutes instead of giving up",
    "  * !timer and !profile work again",
    "  - Removed Treasure Hours (button, schedule and !th)",
    "  + Fresh restart: reopens Fortnite every 6 hours (you pick), only between matches",
    "  + !set: change settings from your phone (mode, stop, after a match, volume...)",
    "  + Multi-monitor: works on the screen Fortnite is on (or pick one in Settings > Look)",
    "  + Settings: Lobby Loop's own icon set on every section, page and setting",
    "  + Match recap: TREASURE FOUND: with only an icon now counts. A gold icon counts as",
    "    Pirate Shop Access, and Discord gets a close-up of the icon",
    "",
    "v7.8  (18 Nov 2026)",
    "  + Weekly prizes update by themselves (a GitHub job reads fnchesttracker.com)",
    "  + One-click Overnight treasure farm (Settings > Play) and a Setup checklist",
    "  + Weekly Discord recap (Sundays 8 PM) and a friends leaderboard card",
    "  + Empty squad check (experimental): leaves when you got no teammates or they",
    "    all left, and tracks teammates per match and the best hours for full squads",
    "  + Team Fill check before every queue",
    "  + Auto-resume after Fortnite outages (waits for 2 good checks)",
    "  + Phone push alerts with the free ntfy app",
    "  + Prizes I already own, and a notice when only gizmos and Pirate Shop Access are left",
    "  + Odds calculator (Epic's official odds)",
    "  + Files go in a 'Lobby Loop data' folder, auto-clean and low disk warning",
    "  + Search box in Settings, game language check, trust panel",
    "",
    "v7.7  (18 Nov 2026)",
    "  + Treasure words update by themselves from GitHub (new weekly prize names)",
    "  + Stop after the match when you find Pirate Shop Access (or any treasure),",
    "    so the prize is safe. Then your stop action (sleep, shut down...)",
    "  + Settings > Play > After a match: Play Again (faster) or Return to lobby",
    "    (prize banners and claim screens only show there). Settings that need the",
    "    lobby say so under them",
    "  + Lobby proof: screenshots the prize / UNLOCKED! screen, then clicks Claim",
    "  + Known Fortnite popups (disconnected, server not responding, removed...)",
    "    are clicked by themselves, no teaching needed",
    "  + Counts how often you're kicked for being idle and warns you",
    "  + Checks Fortnite's servers before reopening it (waits during outages)",
    "  + Checks Fortnite is on Windowed Fullscreen",
    "  + FPS saver: Fortnite runs at 30 FPS while Lobby Loop runs, yours comes back after",
    "  + Laptop battery guard (optional): stop or sleep when the battery is low",
    "  + Weekly prize checklist (names from fnchesttracker.com): ticks itself off when",
    "    you find one, and Discord says how many of this week's prizes you have (!prizes)",
    "  + Settings: treasure split into Treasure and Alerts & clips",
    "",
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
    ["FRESH_RESTART_HOURS", 6, "Restart Fortnite every this many hours, between matches (0 = off)"],
    ["GAME_MONITOR", 0, "Screen Fortnite runs on: 0 = find it by itself, 1, 2, 3..."],
    ["WEEKLY_RECAP", 1, "1 = weekly recap in Discord on Sundays at 8 PM"],
    ["LEADERBOARD_WEBHOOK", "", "Friends leaderboard: a webhook link for a shared channel (each PC keeps one card there)"],
    ["NTFY_TOPIC", "", "Phone push with the ntfy app: your topic name (blank = off)"],
    ["NTFY_SERVER", "", "ntfy server (blank = https://ntfy.sh)"],
    ["EMPTY_SQUAD", 0, "1 = leave the match when you got no teammates or they all left (experimental)"],
    ["SQUAD_MIN_ROWS", 1, "Squad list rows that mean 'only me' (1 if the list shows you too, 0 if not)"],
    ["SQUAD_LEAVE_SEC", 30, "Seconds with no teammates before leaving"],
    ["SQUAD_REGION", "0,0.06,0.20,0.42", "Where the squad list is: left,top,right,bottom as parts of the screen"],
    ["CLEAN_DAYS", 60, "Delete match lists older than this many days (0 = keep, treasure finds are always kept)"],
    ["CLEAN_PROOF_DAYS", 0, "Delete proof screenshots older than this many days (0 = keep forever)"],
    ["LOG_MAX_MB", 5, "Keep the log under this many MB"],
    ["DISK_MIN_GB", 5, "Warn when a drive has less than this many GB free (0 = off)"],
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
    ["TREASURE_GIZMO_WORDS", "GIZMO,SPRITE LOCATOR,LUCKY LOCATOR,GOLDEN FIREWORK,EXTRACTION ACCELERATOR,PORTABLE EXTRACTOR", "Gizmo prize names (only counted with a YOU FOUND banner)"],
    ["TREASURE_COSMETIC", 1, "1 = look for the weekly treasure cosmetics"],
    ["TREASURE_COSMETIC_WORDS", "SOLID GOLD", "This week's cosmetic prize names. Any other YOU FOUND prize also counts as a cosmetic"],
    ["TREASURE_TOKEN", 1, "1 = look for Pirate Shop Access (the pirate token)"],
    ["TREASURE_TOKEN_WORDS", "PIRATE SHOP ACCESS,SHOP ACCESS,!PIRATE SHOP ACCESS UNLOCKED", "Pirate Shop Access words. ! = counts even without the YOU FOUND banner"],
    ["TREASURE_ONLINE", 1, "1 = get the newest treasure words from GitHub (weekly prize names)"],
    ["TREASURE_ONLINE_VERSION", "", "Version of the online treasure words in use (set by itself)"],
    ["TREASURE_WORDS_URL", "", "Where to get the treasure words (blank = Lobby Loop's GitHub)"],
    ["TREASURE_STOP", "off", "Stop after the match when you find: off, token (Pirate Shop Access) or any"],
    ["LOBBY_AFTER_MATCH", 1, "After a match: 1 = Return to lobby (prize screens only show there), 0 = Play Again (faster)"],
    ["LOBBY_PRIZE_WAIT", 8, "Seconds to wait in the lobby for prize screens before readying up"],
    ["TREASURE_PROOF", 1, "1 = on the lobby UNLOCKED! treasure screen, save a screenshot, then click Claim All"],
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
    ["REMOTE_MODE", 0, "1 = remote play (Parsec / AnyDesk): step aside when you move the mouse, show the status box to them"],
    ["REMOTE_HANDS_SEC", 60, "Remote play: hand control back after this many seconds without mouse movement"],
    ["REMOTE_REFOCUS", 1, "Remote play: bring Fortnite back to the front if it loses focus for 90 seconds"],
    ["MATCH_LIMIT", 0, "Stop after this many matches (0 = no limit)"],
    ["GAME_VOLUME", 100, "Fortnite volume while running, 0-100 (100 = leave it alone)"],
    ["STREAM_HIDE", 0, "1 = hide the status box from OBS, streams and screenshots"],
    ["AUTO_CLAIM", 1, "1 = click buttons that just say Continue, Collect, Claim, Accept..."],
    ["SPECTATE_IDLE", 1, "1 = stop moving while you're spectating teammates"],
    ["KNOWN_POPUPS", 1, "1 = click known Fortnite popups by itself (disconnected, server not responding...)"],
    ["CHECK_SERVERS", 1, "1 = check Fortnite's servers before reopening Fortnite (waits during outages)"],
    ["FPS_SAVER", 0, "1 = Fortnite at 30 FPS while Lobby Loop runs (your setting comes back after)"],
    ["BATTERY_GUARD", 0, "1 = stop when a laptop battery gets low"],
    ["BATTERY_MIN", 20, "Battery % that counts as low"],
    ["BATTERY_SLEEP", 0, "1 = also put the PC to sleep when the battery is low"],
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
DATA_DIR := A_ScriptDir "\Lobby Loop data"          ; all settings, stats and logs live here (v7.8)
try DirCreate(DATA_DIR)
if !DirExist(DATA_DIR)
    DATA_DIR := A_ScriptDir
else
    MoveDataFiles(DATA_DIR)
INI_FILE := DATA_DIR "\" BASE "_settings.ini"
STATS_FILE := DATA_DIR "\" BASE "_stats.ini"
POPUP_FILE := DATA_DIR "\" BASE "_popups.ini"
HISTORY_FILE := DATA_DIR "\" BASE "_history.csv"
LOG_FILE := DATA_DIR "\" BASE ".log"
MATCHES_FILE := DATA_DIR "\" BASE "_matches.csv"
DASH_FILE := DATA_DIR "\" BASE "_dashboard.html"
TREASURE_FILE := DATA_DIR "\" BASE "_treasure.csv"
TEAMMATES_FILE := DATA_DIR "\" BASE "_teammates.csv"
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
stopAfterFind := ""    ; treasure found: stop when this match ends
idleKicksRun := 0
totalIdleKicks := Integer(IniRead(STATS_FILE, "Stats", "IdleKicks", 0))
handsOffUntil := 0     ; remote play: you moved the mouse, Lobby Loop waits until this time
ownMouseTick := 0      ; last time Lobby Loop itself moved the mouse
pcLocked := false      ; Windows is locked (AnyDesk/Parsec can lock it when you leave)
unfocusedSince := 0    ; remote play: when Fortnite lost focus
wordsShown := Map()    ; word lists as the Settings window showed them
dimPending := false    ; dim the screen once Fortnite is open
fpsWaiting := false    ; FPS saver waits for Lobby Loop to open Fortnite
backToLobbyUntil := 0  ; just clicked Return to lobby: don't walk while the lobby loads
prizeWaitUntil := 0    ; in the lobby: wait for prize screens until this time
squadMatchTick := 0    ; when this match started (for the squad list check)
squadBaseline := 0     ; most rows seen in the squad list this match
squadLowSince := 0
squadLeft := false
serverFetches := 0     ; how many times the Epic status page was really read
NAV_ICONS := Map()     ; settings sidebar: nav text hwnd -> [picture, folder, icon]
fnStartTick := 0       ; when Fortnite was (last seen) started, for the fresh restart
PANEL_EMOJI := [["%E2%96%B6%EF%B8%8F", "start"], ["%E2%8F%B9%EF%B8%8F", "stop"], ["%F0%9F%93%B8", "ss"],
                ["%F0%9F%93%8A", "status"], ["%F0%9F%8C%99", "dim"]]
SHARE_KEYS := ["PROFILE", "STOP_AFTER_HOURS", "STOP_AFTER_MINUTES", "STOP_AT_TIME", "STOP_ACTION", "MUTE_WHILE_RUNNING",
               "BLACKOUT_ON_START", "READ_RESULTS", "WATCH_TREASURE", "TREASURE_WORDS", "AUTO_CLAIM", "SPECTATE_IDLE",
               "WALK_MIN", "WALK_MAX", "COMBO_CHANCE", "SPRINT_CHANCE", "JUMP_CHANCE", "DIVE_CHANCE", "DIVE_MIN", "DIVE_MAX",
               "SLIDE_CHANCE", "CROUCH_CHANCE", "STRAFE_CHANCE", "SWAP_CHANCE", "LOOK_CHANCE", "IDLE_CHANCE", "IDLE_MIN",
               "IDLE_MAX", "THEME", "ACCENT", "OVERLAY_STYLE", "OVERLAY_SIZE", "OVERLAY_CORNER", "STUCK_MINUTES",
               "TREASURE_GIZMO", "TREASURE_GIZMO_WORDS", "TREASURE_COSMETIC", "TREASURE_COSMETIC_WORDS", "TREASURE_TOKEN",
               "TREASURE_TOKEN_WORDS", "TREASURE_FOUND_WORDS", "WAIT_FOR_SQUAD", "WAKE_FROM_SLEEP", "TREASURE_ONLINE",
               "TREASURE_STOP", "TREASURE_PROOF", "LOBBY_AFTER_MATCH", "LOBBY_PRIZE_WAIT", "WEEKLY_RECAP", "EMPTY_SQUAD", "FRESH_RESTART_HOURS",
               "SQUAD_MIN_ROWS", "SQUAD_LEAVE_SEC", "SQUAD_REGION", "CLEAN_DAYS", "CLEAN_PROOF_DAYS", "LOG_MAX_MB", "DISK_MIN_GB", "KNOWN_POPUPS", "CHECK_SERVERS", "FPS_SAVER", "BATTERY_GUARD", "BATTERY_MIN",
               "BATTERY_SLEEP", "TREASURE_NOTIFY", "TREASURE_BEEP", "TREASURE_DISCORD", "TREASURE_SCREENSHOT",
               "TREASURE_CLIP", "CLIP_METHOD", "CLIP_DELAY", "CLIP_UPLOAD", "MODE_TEAM", "MODE_BUILD", "MODE_FILL",
               "MODE_ACTION", "MODE_SWITCH", "KEEP_AWAKE", "MATCH_LIMIT", "GAME_VOLUME", "REMOTE_MODE", "REMOTE_HANDS_SEC", "REMOTE_REFOCUS"]
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
MON_X := 0, MON_Y := 0, MON_W := A_ScreenWidth, MON_H := A_ScreenHeight   ; the screen Fortnite is on (v7.9)
UpdateMonitor(true)
SCALE := Min(MON_W / 2560, MON_H / 1440)   ; works for 16:9, 16:10 and 21:9
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
A_TrayMenu.Add("📋 " Tx("Setup checklist"), (*) => ShowChecklist())
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
SetTimer(() => UpdateTreasureWords(), -8000)
SetTimer(() => UpdateTreasureWords(), 21600000)          ; and every 6 hours
SetTimer(CheckWindowModeOnce, -15000)
SetTimer(RemoteWatch, 250)
OnMessage(0x7E, (*) => SetTimer(DisplayChanged, -1500))     ; screen size changed (Parsec / AnyDesk can do this)
try DllCall("wtsapi32\WTSRegisterSessionNotification", "Ptr", A_ScriptHwnd, "UInt", 0)
OnMessage(0x2B1, OnSessionChange)                            ; PC locked / unlocked
SetTimer(CheckLanguageOnce, -20000)
if (Trim(String(S["DISCORD_CHANNEL_ID"])) != "" && Trim(String(S["DISCORD_BOT_TOKEN"])) = "") {
    Log("Phone control is off: no bot token (Settings > Phone control)")
    SetTimer(() => Notify(Tx("Phone control is off"), Tx("The bot token is missing. Paste it in Settings > Phone control.")), -12000)
}
SetTimer(() => CleanData(), -60000)
SetTimer(() => (IniRead(STATS_FILE, "Stats", "ChecklistShown", "") = "" && !running) ? ShowChecklist() : 0, -25000)
if !running
    FpsRestoreLater()                                    ; put your FPS back if Lobby Loop closed while it was set

; ---------- Startup ----------
ShowTip(Tx("{1} loaded.", TITLE " v" VERSION) "`n" Tx("{1} = start/stop   {2} = settings   {3} = self-test", HK_TOGGLE, HK_SETTINGS, HK_TEST), 5000)
if migrated
    Log("Copied " migrated " file(s) from the old Fortnite AFK version")
Log("Loaded v" VERSION (A_IsCompiled ? " (exe)" : " (ahk)") ". Screen " MON_W "x" MON_H ", admin=" A_IsAdmin ", stop: " DescribeStop() ", start: " DescribeStart() ", popups: " POPUPS.Length)

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
        newFile := DATA_DIR "\" BASE suffix
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
    global gameState, lobbyVisit, modeChecked, modeRecheckTick, modeWarned, lastNudgeTick, sleepWakes, stopAfterFind, idleKicksRun
    global running, sessionStart, sessionStartTime, matches, clicks, pendingAction, autoStartArmed
    global totalMinutes, lastProgress, unstickTries, goneSince, launchTick, launchTries, dimPending
    autoStartArmed := false
    dimPending := false

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
        lastNudgeTick := A_TickCount, sleepWakes := 0, stopAfterFind := "", idleKicksRun := 0
        SetTimer(FpsRestoreTick, 0)
        FpsApply()
        if fpsWaiting
            ShowTip(Tx("FPS saver starts the next time Lobby Loop opens Fortnite."), 3500)
        if S["BLACKOUT_ON_START"] {
            if WinExist(S["GAME_WINDOW"])
                ToggleBlackout(true)
            else
                dimPending := true                       ; dims once Fortnite is open (no black screen while it starts)
        }
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
        FpsRestoreLater()
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
        NtfyPush("Stopped", "Stopped (" reason "). This run: " summary, 3)
        LbCardUpdate(true)
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
    if (Trim(String(S["DISCORD_CHANNEL_ID"])) != "" || Trim(String(S["DISCORD_BOT_TOKEN"])) != "")
        rows.Push([BotEnabled() ? ok : no, BotEnabled() ? Tx("Phone control is set up") : Tx("Phone control: the bot token or channel ID is missing (Settings > Phone control)")])
    rows.Push([info, Tx("Fortnite Sleep Mode: set it to Never (Settings > Game > Energy Saving)"), true])
    wm := FortniteWindowMode()
    rows.Push([wm = 1 ? ok : (wm = "" ? info : "⚠️"), SubStr(WindowModeText(), 3), wm = ""])
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
    rows.Push([info, Tx("Screen {1}", MON_W "x" MON_H) "   ·   v" VERSION (A_IsCompiled ? " exe" : "") "   ·   " Tx("Learned popup buttons: {1}", POPUPS.Length), true])
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
        if NAV_ICONS.Has(n.Hwnd) {                      ; icon follows the highlight colour
            ni := NAV_ICONS[n.Hwnd]
            try ni[1].Value := ni[2] "\" (i = index ? "sel_" : "side_") ni[3] ".png"
        }
    }
}

SettingsForgetPopup(index, g, *) {
    ForgetPopup(index)
    g.Destroy()
    OpenSettings(9)
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
    BatteryCheck()
    WeeklyRecapCheck()
    CleanData()
    UpdateMonitor()
    FreshRestartTrack()
    if running {
        DiskCheck()
        LbCardUpdate()
    }
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
    ToolTip(TITLE ": " msg "`n" Tx("Press {1} to cancel", HK_TOGGLE), MON_X + MON_W // 2 - 160, MON_Y + MON_H // 2)
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
    if ((why := ServersDown()) != "") {
        ServersDownNotice(why)
        return
    }
    launchTries += 1
    launchTick := A_TickCount
    FpsApply()
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
    } else if (unstickTries = 3 && (why := ServersDown()) != "") {
        unstickTries := 2                                  ; servers are down: don't restart, check again later
        ServersDownNotice(why)
        lastProgress := A_TickCount
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
    UpdateMonitor()
    OwnMouse(), MouseMove(MON_X + 2, MON_Y + MON_H - 2, 0)        ; move away so the hover highlight goes
    Sleep(400)
    cap := Capture(MON_X, MON_Y, MON_W, MON_H)
    OwnMouse(), MouseMove(mx, my, 0)
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
    if (w < 80 * SCALE || h < 25 * SCALE || w > MON_W * 0.6 || h > 300 * SCALE) {
        ShowTip("Couldn't find a button there (" w "x" h ").`nHover over an EMPTY part of the button (beside the text) and press " HK_TEACH " again.", 6000)
        return
    }
    if (POPUPS.Length >= 6) {
        ShowTip("Already 6 popup buttons learned. Tray menu > Forget learned popup buttons.", 5000)
        return
    }
    POPUPS.Push({l: (l - MON_X) / MON_W, t: (t - MON_Y) / MON_H, r: (r - MON_X) / MON_W, b: (b - MON_Y) / MON_H, color: c, last: 0})
    SavePopups()
    Log("Learned popup #" POPUPS.Length ": " l "," t " - " r "," b " colour " Format("0x{:06X}", c))
    ShowTip("Learned popup button #" POPUPS.Length " (" w "x" h ").`nIt will be clicked whenever it shows up.", 4000)
}

; Is a learned popup button on screen? Returns its centre {x, y} or 0.
PopupVisible(p) {
    l := MON_X + Round(p.l * MON_W), t := MON_Y + Round(p.t * MON_H)
    r := MON_X + Round(p.r * MON_W), b := MON_Y + Round(p.b * MON_H)
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
        OwnMouse(), MouseMove(pos.x + Random(-8, 8), pos.y + Random(-4, 4), 6)
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
        "Bring Fortnite back to the front if it loses focus", "أعد Fortnite إلى الواجهة إذا فقد التركيز",
        "Step aside when I move the mouse (and show the status box to Parsec / AnyDesk)", "توقف عندما أحرك الماوس (وأظهر مربع الحالة في Parsec / AnyDesk)",
        "You're in control ({1}s)", "أنت المتحكم الآن ({1} ث)",
        "PC is locked, waiting", "الكمبيوتر مقفل، في الانتظار",
        "Remote play (Parsec / AnyDesk from your phone)", "اللعب عن بُعد (Parsec / AnyDesk من هاتفك)",
        "Hand back after (seconds without mouse movement):", "أعد التحكم بعد (ثوانٍ بدون حركة الماوس):",
        "Always on: a Discord message if the PC gets locked or the screen size changes. Phone: !focus, !keys, !remote on.", "يعمل دائمًا: رسالة على Discord إذا قُفل الكمبيوتر أو تغير حجم الشاشة. الهاتف: ‎!focus و ‎!keys و ‎!remote on.",
        "A Jam Track: {1}%", "مقطع Jam Track: ‏{1}%",
        "A car: {1}%", "سيارة: {1}%",
        "A loading screen: {1}%", "شاشة تحميل: {1}%",
        "A pickaxe or back bling: {1}%", "فأس أو حقيبة ظهر: {1}%",
        "A rough guess of what your squad's chests could give you. Epic says every player has the same odds per chest. Lobby Loop doesn't change them.", "تقدير تقريبي لما قد تمنحك إياه صناديق فريقك. تقول Epic إن لكل لاعب نفس الفرص لكل صندوق. Lobby Loop لا يغيّرها.",
        "About {1} chests.", "حوالي {1} صندوق.",
        "After a match: Return to lobby (prize screens)", "بعد المباراة: العودة إلى الردهة (شاشات الجوائز)",
        "Alerts on your phone (Discord or ntfy)", "تنبيهات على هاتفك (Discord أو ntfy)",
        "All prizes owned", "تملك كل الجوائز",
        "Best hour for full squads: around {1}.", "أفضل وقت لفرق كاملة: حوالي {1}.",
        "Change", "تغيير",
        "Chests your squad opens per match (guess)", "الصناديق التي يفتحها فريقك في كل مباراة (تقدير)",
        "Clean now", "نظّف الآن",
        "Cleaned {1} old items.", "تم تنظيف {1} عنصرًا قديمًا.",
        "Click into Fortnite (in a match). Checking in {1} seconds...", "اضغط داخل Fortnite (في مباراة). الفحص بعد {1} ثوانٍ...",
        "Clips may fail to save.", "قد يفشل حفظ المقاطع.",
        "Close", "إغلاق",
        "Close Fortnite first, then press Set it again. (Or in Fortnite: Settings > Display > Window Mode > Windowed Fullscreen.)", "أغلق Fortnite أولًا ثم اضغط اضبطه مرة أخرى. (أو في Fortnite: الإعدادات > العرض > وضع النافذة > ملء الشاشة بنافذة.)",
        "Couldn't send", "تعذر الإرسال",
        "Counts as only you: {1} or fewer", "يُعتبر أنت فقط: {1} أو أقل",
        "Counts the names in the squad list (top left). Nobody left = nobody farming for you. Test it in a match first.", "يعد الأسماء في قائمة الفريق (أعلى اليسار). لا أحد = لا أحد يجمع لك. اختبره في مباراة أولًا.",
        "Data folder:", "مجلد البيانات:",
        "Delete match lists older than this many days (0 = keep, treasure finds are always kept):", "احذف قوائم المباريات الأقدم من هذا العدد من الأيام (0 = احتفظ، الكنوز تُحفظ دائمًا):",
        "Delete proof screenshots older than this many days (0 = keep forever):", "احذف لقطات الإثبات الأقدم من هذا العدد من الأيام (0 = احتفظ للأبد):",
        "Everyone pastes the same link. Each PC keeps one card there and updates it. !lb ranks everyone if your bot can see that channel.", "يلصق الجميع نفس الرابط. كل جهاز يحتفظ ببطاقة واحدة هناك ويحدّثها. ‏!lb يرتّب الجميع إذا كان البوت يرى تلك القناة.",
        "Fortnite Sleep Mode: Never (Settings > Game > Energy Saving)", "وضع السكون في Fortnite: أبدًا (الإعدادات > اللعبة > توفير الطاقة)",
        "Fortnite is set to '{1}'. Lobby Loop reads English words, so set Fortnite to English (Settings > Game > Language).", "لغة Fortnite هي '{1}'. يقرأ Lobby Loop كلمات إنجليزية، لذا اضبط Fortnite على الإنجليزية (الإعدادات > اللعبة > اللغة).",
        "Fortnite language", "لغة Fortnite",
        "Fortnite language: {1}", "لغة Fortnite: ‏{1}",
        "Fortnite on Windowed Fullscreen", "Fortnite على ملء الشاشة بنافذة",
        "Free space on {1}: {2}", "المساحة الحرة على {1}: ‏{2}",
        "Friends leaderboard: webhook link of a shared channel (optional)", "لوحة متصدري الأصدقاء: رابط webhook لقناة مشتركة (اختياري)",
        "Gizmos: about {1}", "الأدوات: حوالي {1}",
        "Gold outfit: {1}%", "الزي الذهبي: {1}%",
        "Hours per night", "ساعات في الليلة",
        "Install ntfy, subscribe to the same topic. Pick a long name nobody can guess: anyone with the name can read it.", "ثبّت ntfy واشترك في نفس الموضوع. اختر اسمًا طويلًا لا يمكن تخمينه: أي شخص يعرف الاسم يمكنه قراءته.",
        "Keep the log under (MB):", "أبقِ السجل أقل من (ميغابايت):",
        "Keys: {1} start / stop, {2} settings, {3} self-test", "المفاتيح: {1} تشغيل / إيقاف، {2} الإعدادات، {3} الفحص الذاتي",
        "Last 30 days: {1} teammates per match on average, no teammates in {2} of {3} matches.", "آخر 30 يومًا: {1} زملاء في المباراة في المتوسط، بدون زملاء في {2} من {3} مباريات.",
        "Leave when I got no teammates, or they all left (experimental)", "غادر عندما لا يكون لدي زملاء أو غادروا كلهم (تجريبي)",
        "Lobby Loop is free and open source (github.com/yensobased1/lobby-loop). It has no login, no remote access and never asks for your Epic password. Your Discord links stay in your settings file on this PC. It does not change your odds: Epic gives every player the same odds per chest. Epic's rules ban cheats and exploits and can ban accounts, so use it at your own risk.", "‏Lobby Loop مجاني ومفتوح المصدر (github.com/yensobased1/lobby-loop). لا يحتاج تسجيل دخول ولا وصولًا عن بُعد ولا يطلب كلمة مرور Epic أبدًا. روابط Discord تبقى في ملف إعداداتك على هذا الجهاز. لا يغيّر فرصك: تمنح Epic كل لاعب نفس الفرص لكل صندوق. قواعد Epic تمنع الغش والثغرات وقد تحظر الحسابات، فاستخدمه على مسؤوليتك.",
        "Low disk space", "مساحة القرص منخفضة",
        "Matches per hour", "مباريات في الساعة",
        "Nights left", "الليالي المتبقية",
        "No teammate counts yet (turn on the empty squad check, or play a few matches).", "لا توجد أعداد زملاء بعد (فعّل فحص الفريق الفارغ أو العب بضع مباريات).",
        "Nobody left to farm, leaving the match", "لم يبقَ أحد ليجمع، مغادرة المباراة",
        "Odds", "الفرص",
        "Odds calculator", "حاسبة الفرص",
        "Odds: 1 in 127 gizmo, 272 loading screen, 391 Jam Track, 568 pickaxe/back bling, 7,813 car, 137,500 Pirate Shop Access, 1,562,500 Gold outfit (Epic, 7 Nov 2026). Treasure Hours raise some of them.", "الفرص: 1 من 127 أداة، 272 شاشة تحميل، 391 Jam Track، ‏568 فأس/حقيبة ظهر، 7,813 سيارة، 137,500 وصول متجر القراصنة، 1,562,500 زي ذهبي (Epic، ‏7 نوفمبر 2026). ساعات الكنوز ترفع بعضها.",
        "Only {1} GB free on {2}.", "متبقٍ {1} غيغابايت فقط على {2}.",
        "Open the data folder", "فتح مجلد البيانات",
        "Overnight treasure farm", "جمع الكنوز طوال الليل",
        "Overnight treasure farm (one click)", "جمع الكنوز طوال الليل (بضغطة واحدة)",
        "Overnight treasure farm is set.", "تم ضبط جمع الكنوز طوال الليل.",
        "Phone push with the free ntfy app: topic name (optional)", "إشعارات الهاتف عبر تطبيق ntfy المجاني: اسم الموضوع (اختياري)",
        "Pirate Shop Access: {1}%", "وصول متجر القراصنة: {1}%",
        "Post my card", "انشر بطاقتي",
        "Prizes I already own", "الجوائز التي أملكها",
        "Restart as admin", "إعادة التشغيل كمسؤول",
        "Rows in the squad list: {1}", "الصفوف في قائمة الفريق: {1}",
        "Same as Settings > Mode > Fill. If the lobby is on No fill, it waits and tells you (or switches, if that's on).", "مثل الإعدادات > الوضع > التعبئة. إذا كانت الردهة على بدون تعبئة، ينتظر ويخبرك (أو يبدّل إذا كان ذلك مفعّلًا).",
        "Search settings", "ابحث في الإعدادات",
        "Send me a screenshot of the squad list if the count looks wrong.", "أرسل لقطة لقائمة الفريق إذا بدا العدد خاطئًا.",
        "Sent", "تم الإرسال",
        "Set it", "اضبطه",
        "Set up", "إعداد",
        "Setup checklist", "قائمة الإعداد",
        "Squad list test", "اختبار قائمة الفريق",
        "Storage", "التخزين",
        "Team Fill check: Fill", "فحص التعبئة: تعبئة",
        "Team Fill check: make sure Fill is on before every queue", "فحص التعبئة: تأكد من تفعيل التعبئة قبل كل طابور",
        "Test push", "اختبار الإشعار",
        "Test the squad count", "اختبار عدد الفريق",
        "The prize list comes with the online treasure words. Press Update the words now first.", "قائمة الجوائز تأتي مع كلمات الكنوز من الإنترنت. اضغط حدّث الكلمات الآن أولًا.",
        "Tick what's already in your Locker. A repeat prize gives you nothing, so Lobby Loop tells you when only gizmos and Pirate Shop Access are left.", "حدد ما هو موجود في خزانتك. الجائزة المكررة لا تعطيك شيئًا، لذا يخبرك Lobby Loop عندما يتبقى فقط الأدوات ووصول متجر القراصنة.",
        "Trust", "الثقة",
        "Turn on", "تفعيل",
        "Turn on the overnight treasure farm settings?", "تفعيل إعدادات جمع الكنوز طوال الليل؟",
        "Warn when a drive has less than (GB, 0 = off):", "حذّر عندما يكون في القرص أقل من (غيغابايت، 0 = إيقاف):",
        "Week {1}", "الأسبوع {1}",
        "Weekly recap on Sundays at 8 PM", "ملخص أسبوعي أيام الأحد الساعة 8 مساءً",
        "What I own", "ما أملكه",
        "Where Lobby Loop keeps its files, and cleaning up.", "أين يحفظ Lobby Loop ملفاته، والتنظيف.",
        "You own all of week {1}'s prizes. Only gizmos and Pirate Shop Access can still drop for you this week.", "تملك كل جوائز الأسبوع {1}. فقط الأدوات ووصول متجر القراصنة يمكن أن تسقط لك هذا الأسبوع.",
        "Your stop timer, stop action and keys stay the same.", "مؤقت التوقف وإجراء التوقف والمفاتيح تبقى كما هي.",
        "same as Windows", "مثل Windows",
        "After a match: Return to lobby", "بعد المباراة: العودة إلى الردهة",
        "Don't leave while teammates play", "لا تغادر بينما يلعب الزملاء",
        "Online treasure words", "كلمات الكنوز من الإنترنت",
        "Lobby proof + Claim", "إثبات الردهة + الاستلام",
        "Stop after finding Pirate Shop Access", "توقف بعد العثور على وصول متجر القراصنة",
        "Wake from Sleep Mode", "الإيقاظ من وضع السكون",
        "Known popups", "النوافذ المعروفة",
        "Server check + auto-resume", "فحص الخوادم + الاستئناف التلقائي",
        "Reopen Fortnite if it closes", "أعد فتح Fortnite إذا أُغلق",
        "Keep the PC awake", "إبقاء الكمبيوتر مستيقظًا",
        "FPS saver (30 FPS)", "موفر الإطارات (30 إطارًا)",
        "Stand still while spectating", "الثبات أثناء المشاهدة",
        "Weekly Discord recap", "ملخص Discord الأسبوعي",
        "3 times this run. Try the Chill profile or more movement.", "3 مرات في هذا التشغيل. جرّب ملف Chill أو حركة أكثر.",
        "Alerts & clips", "التنبيهات والمقاطع",
        "Also put the PC to sleep", "وضع الكمبيوتر في السكون أيضًا",
        "Any treasure", "أي كنز",
        "Battery % that counts as low:", "نسبة البطارية التي تُعتبر منخفضة:",
        "Check Fortnite's servers first (wait during outages)", "افحص خوادم Fortnite أولًا (انتظر أثناء الأعطال)",
        "Click known Fortnite popups by itself (disconnected, server not responding, removed...)", "اضغط على نوافذ Fortnite المعروفة تلقائيًا (انقطع الاتصال، الخادم لا يستجيب، تمت الإزالة...)",
        "Clips", "المقاطع",
        "Fresh restart: restart Fortnite every this many hours, between matches (0 = off):", "إعادة تشغيل منعشة: أعد تشغيل Fortnite كل هذا العدد من الساعات بين المباريات (0 = إيقاف):",
        "Keeps Fortnite running smoothly overnight. It never restarts during a match.", "يبقي Fortnite سلسًا طوال الليل. لا يعيد التشغيل أثناء مباراة أبدًا.",
        "Fortnite's screen", "شاشة Fortnite",
        "Find it by itself", "اعثر عليها تلقائيًا",
        "Screen {1}", "الشاشة {1}",
        "main", "الرئيسية",
        "Fresh restart: reopening Fortnite", "إعادة تشغيل منعشة: إعادة فتح Fortnite",
        "Type !help in your channel to see all 30+ commands. Change settings with !set (type !set to see them).", "اكتب ‎!help في قناتك لرؤية كل الأوامر. غيّر الإعدادات بـ ‎!set (اكتب ‎!set لرؤيتها).",
        "Phone control is set up", "التحكم بالهاتف جاهز",
        "Phone control: the bot token or channel ID is missing (Settings > Phone control)", "التحكم بالهاتف: رمز البوت أو معرّف القناة مفقود (الإعدادات > التحكم بالهاتف)",
        "Phone control is off", "التحكم بالهاتف متوقف",
        "The bot token is missing. Paste it in Settings > Phone control.", "رمز البوت مفقود. الصقه في الإعدادات > التحكم بالهاتف.",
        "Phone control needs the bot token too, or your commands won't work. Save without it?", "التحكم بالهاتف يحتاج رمز البوت أيضًا وإلا لن تعمل أوامرك. الحفظ بدونه؟",
        "Claimed {1}", "تم استلام {1}",
        "After a match:", "بعد المباراة:",
        "Play Again (faster)", "Play Again (أسرع)",
        "Return to lobby (shows prizes)", "العودة إلى الردهة (تُظهر الجوائز)",
        "Prize banners and claim screens only show in the lobby, so treasure needs Return to lobby.", "لافتات الجوائز وشاشات الاستلام تظهر في الردهة فقط، لذا تحتاج الكنوز إلى العودة إلى الردهة.",
        "Needs Return to lobby (Settings > Play > After a match)", "يتطلب العودة إلى الردهة (الإعدادات > اللعب > بعد المباراة)",
        "now: Play Again", "الآن: Play Again",
        "Lobby proof: screenshot the prize screen, then click Claim", "إثبات الردهة: التقط شاشة الجائزة ثم اضغط Claim",
        "After each match, go back to the lobby (prize screens only show there)", "بعد كل مباراة، ارجع إلى الردهة (شاشات الجوائز تظهر هناك فقط)",
        "Back to the lobby to check for prizes", "العودة إلى الردهة للبحث عن الجوائز",
        "Checking for prize screens...", "جارٍ البحث عن شاشات الجوائز...",
        "Loading the lobby...", "جارٍ تحميل الردهة...",
        "Lobby Loop stops now that the prize is claimed.", "يتوقف Lobby Loop الآن بعد استلام الجائزة.",
        "Week {1} prizes", "جوائز الأسبوع {1}",
        "This week's prizes", "جوائز هذا الأسبوع",
        "Open Chest Tracker (fnchesttracker.com)", "فتح Chest Tracker ‏(fnchesttracker.com)",
        "Comes with the online treasure words.", "تأتي مع كلمات الكنوز من الإنترنت.",
        "Closed a Fortnite popup ({1})", "تم إغلاق نافذة Fortnite ({1})",
        "Couldn't download the treasure words. Check your internet.", "تعذر تنزيل كلمات الكنوز. تحقق من الإنترنت.",
        "Couldn't read Fortnite's settings file", "تعذرت قراءة ملف إعدادات Fortnite",
        "FPS saver starts the next time Lobby Loop opens Fortnite.", "يبدأ موفر الإطارات في المرة القادمة التي يفتح فيها Lobby Loop لعبة Fortnite.",
        "FPS saver: Fortnite at 30 FPS while running (yours comes back after)", "موفر الإطارات: Fortnite على 30 إطارًا أثناء التشغيل (يعود إعدادك بعد ذلك)",
        "Fortnite is Windowed. Windowed Fullscreen works best.", "Fortnite في وضع النافذة. وضع ملء الشاشة بنافذة يعمل أفضل.",
        "Fortnite is on Fullscreen. Switch to Windowed Fullscreen (Settings > Display > Window Mode).", "Fortnite في وضع ملء الشاشة. انتقل إلى ملء الشاشة بنافذة (الإعدادات > العرض > وضع النافذة).",
        "Fortnite is on Windowed Fullscreen", "Fortnite على ملء الشاشة بنافذة",
        "Fortnite servers look down", "يبدو أن خوادم Fortnite متوقفة",
        "Fortnite servers look down, waiting", "يبدو أن خوادم Fortnite متوقفة، في الانتظار",
        "Fortnite window mode", "وضع نافذة Fortnite",
        "Found it!", "وجدته!",
        "Get the newest words online (weekly prize names)", "احصل على أحدث الكلمات من الإنترنت (أسماء الجوائز الأسبوعية)",
        "Keep it safe", "احفظه بأمان",
        "Kicked for being idle", "طُردت بسبب الخمول",
        "Kicked for being idle: {1} times so far.", "طُردت بسبب الخمول: {1} مرات حتى الآن.",
        "Laptop: stop when the battery is low", "الحاسوب المحمول: توقف عندما تنخفض البطارية",
        "Lobby Loop stops after this match ends, so the prize is safe.", "يتوقف Lobby Loop بعد انتهاء هذه المباراة، لتبقى الجائزة بأمان.",
        "Lobby proof: screenshot the UNLOCKED! screen, then click Claim All", "إثبات الردهة: التقط شاشة UNLOCKED! ثم اضغط Claim All",
        "Never", "أبدًا",
        "Online words: {1}", "الكلمات من الإنترنت: {1}",
        "Open proof screenshots", "فتح لقطات الإثبات",
        "Saved proof, clicked {1}", "تم حفظ الإثبات، تم الضغط على {1}",
        "Spots the prizes your squad finds in chests, and keeps them safe.", "يرصد الجوائز التي يجدها فريقك في الصناديق ويحفظها بأمان.",
        "Starts the next time Lobby Loop opens Fortnite. Your FPS comes back once Fortnite closes after the run.", "يبدأ في المرة القادمة التي يفتح فيها Lobby Loop لعبة Fortnite. يعود إعداد الإطارات بعد إغلاق Fortnite عقب التشغيل.",
        "Stop after the match when I find:", "توقف بعد المباراة عندما أجد:",
        "Stopped: battery {1}%", "توقف: البطارية {1}%",
        "Stopped: found {1}", "توقف: تم العثور على {1}",
        "Then it does your stop action (Settings > Play).", "ثم ينفذ إجراء التوقف الخاص بك (الإعدادات > اللعب).",
        "Treasure words updated ({1}).", "تم تحديث كلمات الكنوز ({1}).",
        "Update the words now", "حدّث الكلمات الآن",
        "What happens when treasure is found.", "ما يحدث عند العثور على كنز.",
        "not downloaded yet", "لم تُنزّل بعد",
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
        "Treasure (any other prize)", "كنز (أي جائزة أخرى)",
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
        x := Max(SysGet(76), Min(Integer(S["OVERLAY_X"]), SysGet(76) + SysGet(78) - w))     ; anywhere on the desktop
        y := Max(SysGet(77), Min(Integer(S["OVERLAY_Y"]), SysGet(77) + SysGet(79) - h))
    } else {
        x := MON_X + (InStr(corner, "right") ? MON_W - w - 12 : 12)
        y := MON_Y + (InStr(corner, "bottom") ? MON_H - h - 60 : 12)
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
    if (S["STREAM_HIDE"] && !S["REMOTE_MODE"])          ; remote play: Parsec / AnyDesk must see it
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
    NtfyPush(heading, msg, InStr(heading, "🏴") || InStr(heading, "🎁") ? 5 : 3)
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
        g.Add("Text", "c404040 x20 y" (MON_H - 40) " w" (MON_W - 40), Tx("Screen dimmed by Lobby Loop. Press {1} to undo.", HK_BLACKOUT))
        g.Show("x" MON_X " y" MON_Y " w" MON_W " h" MON_H " NoActivate")
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
    return SaveRegionImage(path, MON_X, MON_Y, MON_W, MON_H) ? path : ""
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
    W := MON_W, H := MON_H
    p1 := A_Temp "\ll_place.png", p2 := A_Temp "\ll_xp.png"
    ok1 := SaveRegionImage(p1, MON_X + Round(W * 0.30), MON_Y, Round(W * 0.40), Round(H * 0.08))
    ok2 := SaveRegionImage(p2, MON_X + Round(W * 0.30), MON_Y + Round(H * 0.45), Round(W * 0.40), Round(H * 0.25))
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
    wk := WeekStats()
    return "``LB|" StrReplace(PlayerName(), "|", "/") "|" totalMatches "|" hours "|" bestPlace "|" totalXP "|" wk.matches "|" wk.treasures "|" PrizeProgress(PrizeWeek()).got "``"
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
    resp := BotRequest("GET", "https://discord.com/api/v10/channels/" LeaderboardChannel() "/messages?limit=100")
    if (resp = "")
        return "Couldn't read the channel for the leaderboard."
    try msgs := JsonParse(resp)
    catch
        return "Couldn't read the channel for the leaderboard."
    best := Map()
    for m in msgs {
        content := m.Has("content") ? m["content"] : ""
        if !RegExMatch(content, "LB\|([^|``]+)\|(\d+)\|([\d.]+)\|(\d+)\|?(\d*)(?:\|(\d+)\|(\d+)\|(\d+))?", &lb)
            continue
        key := StrLower(lb[1])
        if !best.Has(key)        ; newest message comes first
            best[key] := {name: lb[1], matches: Integer(lb[2]), hours: lb[3], place: Integer(lb[4]), xp: lb[5], wk: lb[6], tr: lb[7], pr: lb[8]}
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
        out .= (i <= 3 ? medals[i] : i ".") " **" v.name "**: " v.matches " matches, " v.hours " h" (v.place ? ", best #" v.place : "")
            . (v.wk != "" ? "   ·   this week " v.wk " matches, " v.tr " treasure, prizes " v.pr : "") "`n"
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
    static failedAt := 0
    if !BotEnabled()
        return
    if (botFails >= 10) {                              ; paused after errors: try again every 10 minutes
        if !failedAt
            failedAt := A_TickCount
        if (A_TickCount - failedAt < 600000)
            return
        botFails := 0, failedAt := 0
        Log("Phone control: trying again")
    }
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
    if (cmd = "timer" || cmd = "profile" || cmd = "watch" || cmd = "pause" || cmd = "mode" || cmd = "set") {   ; these take a value, not a PC name
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
                . "🎯 ``!mode`` / ``!mode zerobuild squad fill`` / ``!mode any`` ``!servers`` ``!prizes```n"
                . "🗓️ ``!recap``   👥 ``!teammates``   ⚙️ ``!set`` (change settings)`n"
                . "🏴‍☠️ ``!clip`` ``!read```n"
                . "📱 ``!focus`` (Fortnite to the front) ``!keys`` (unstick keys) ``!remote on`` / ``off```n"
                . "🛠️ ``!version`` ``!update`` ``!reload`` ``!restartgame`` ``!closegame`` ``!sleep`` ``!shutdown`` ``!cancel```n"
                . "Add a name to target one PC, e.g. ``!stop zen``. Power commands need your user ID in Settings > Phone control.")
        case "timer":
            if (arg = "" || StrLower(arg) = "off" || arg = "0") {
                SaveStop(0, 0, "")
            } else if (ck := ParseClock(arg)) {
                SaveStop(0, 0, Format("{:02}:{:02}", ck.h, ck.m))
            } else if (dur := ParseDuration(arg)) {
                SaveStop(dur.h, dur.m, "")
            } else {
                Discord(who "couldn't understand ``" arg "``. Try ``!timer 2h``, ``!timer 90m``, ``!timer 9:30pm`` or ``!timer off``.")
                return
            }
            if running
                ApplyStopLimits()
            Discord(who "⏰ stop: **" DescribeStop() "**")
        case "profile":
            want := StrLower(arg)
            if !HasValue(PROFILE_KEYS, want) {
                Discord(who "profiles: ``!profile overnight``, ``!profile quick``, ``!profile chill``, ``!profile custom``")
                return
            }
            ApplyProfile(want)
            if running
                ApplyStopLimits()
            Discord(who "🎚️ profile: **" ProfileLabel(want) "**, stop: " DescribeStop())
        case "status":
            Discord(who StatusText())
        case "focus":
            if !WinExist(S["GAME_WINDOW"])
                Discord(who "Fortnite isn't open.")
            else {
                try WinActivate(S["GAME_WINDOW"])
                Sleep(400)
                Discord(who (WinActive(S["GAME_WINDOW"]) ? "Fortnite is in front 🎯" : "couldn't bring Fortnite to the front (is the PC locked?)"))
            }
        case "keys":
            ReleaseAll()
            Discord(who "let go of every key and mouse button ⌨️")
        case "remote":
            v := StrLower(Trim(arg))
            if (v = "on" || v = "off")
                SetSetting("REMOTE_MODE", v = "on" ? 1 : 0)
            Discord(who "remote play is **" (S["REMOTE_MODE"] ? "on" : "off") "**" (v = "" ? " (``!remote on`` / ``!remote off``)" : "") ". Restart Lobby Loop for the status box to show in Parsec / AnyDesk.")
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
                . (bestPlace ? ", best #" bestPlace : "") (avg ? ", average #" avg : "") ", 🏴‍☠️ " treasureCount " treasures, 💤 kicked for idle " totalIdleKicks "x")
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
            lines := OcrRegionSync(MON_X, MON_Y, MON_W, MON_H)
            all := ""
            for ln in lines
                if (StrLen(all) < 1500 && StrLen(ln.text) >= 3)
                    all .= ln.text " · "
            Discord(who "🔎 on screen: " (all != "" ? all : "no text found"))
        case "prizes":
            wk := PrizeWeek()
            Discord(who (wk ? "🎁 **Week " wk " prizes**`n" StrReplace(PrizesText(wk), "⬜", "▫️") : "no prize list yet (it comes with the online treasure words)."))
        case "set":
            PhoneSet(arg, authorId, who)
        case "recap":
            Discord(WeeklyRecapText())
        case "teammates":
            Discord(who "👥 " TeammateStatsText())
        case "servers":
            why := ServersDown()
            Discord(who (why != "" ? "🛑 Fortnite servers look down: **" why "**" : "✅ Fortnite servers look fine") " (status.epicgames.com)")
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
    s3 := " PC time " FormatTime(, "h:mm tt") ", screen " MON_W "x" MON_H (pcLocked ? ", 🔒 locked" : "") (A_TickCount < handsOffUntil ? ", 📱 you're in control" : "") "."
    return s1 s2 " All time: " totalMatches " matches, " Round(totalMinutes / 60, 1) " h." s3
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
    html := StrReplace(html, "Lobby Loop Zen", TITLE)
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
<html><head><meta charset="utf-8">__REFRESH__<title>Lobby Loop Zen stats</title>
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
<header><h1><span>&#x1F501;</span> Lobby Loop Zen stats</h1><div class="sub">__PLAYER__</div></header>
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
    if (!S["WATCH_TREASURE"] && !S["AUTO_CLAIM"] && !S["SPECTATE_IDLE"] && !S["WAIT_FOR_SQUAD"] && !S["WAKE_FROM_SLEEP"] && !S["KNOWN_POPUPS"] && !S["EMPTY_SQUAD"])
        return
    if (A_TickCount - lastOcrTick < (S["WATCH_TREASURE"] ? 3 : Max(5, S["SCREEN_READER_SECONDS"])) * 1000)
        return
    lastOcrTick := A_TickCount
    UpdateMonitor()
    img := A_Temp "\ll_screen.png"
    if !SaveRegionImage(img, MON_X, MON_Y, MON_W, MON_H)
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
        lines.Push({x: MON_X + Integer(p[1]), y: MON_Y + Integer(p[2]), w: Integer(p[3]), h: Integer(p[4]), text: Trim(p[5])})
    }
    if (!running || !WinActive(S["GAME_WINDOW"]))       ; tabbed out while it was reading: ignore it
        return
    lines := DropOwnWindows(lines)                     ; status box, Settings, tips: never read our own text
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
    SquadCheck(lines)
    if S["WATCH_TREASURE"]
        CheckTreasure(lines)
    if ClaimPrizeScreen(lines, joined)
        return
    if KnownPopup(lines, joined)
        return
    if (S["AUTO_CLAIM"] && gameState != "spectating" && A_TickCount - lastClaimTick > 10000) {
        for ln in lines {
            u := Trim(StrUpper(ln.text))
            if (IsClaimWord(u) && ln.w > 20 && running && WinActive(S["GAME_WINDOW"])) {
                lastClaimTick := A_TickCount
                ReleaseAll()
                OwnMouse(), MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
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
    return "Version: " VERSION (A_IsCompiled ? " (exe)" : " (ahk)") "`nScreen: " MON_W "x" MON_H "`nWindows: " A_OSVersion "`nLanguage: " S["LANG"] "`n`nLast log lines:`n``````" "`n" tail "``````"
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
        for f in [INI_FILE, STATS_FILE, POPUP_FILE, HISTORY_FILE, MATCHES_FILE, TREASURE_FILE, DASH_FILE, LOG_FILE, TEAMMATES_FILE]
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
        if (mx - MON_X >= p.l * MON_W && mx - MON_X <= p.r * MON_W && my - MON_Y >= p.t * MON_H && my - MON_Y <= p.b * MON_H) {
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
    return running && WinActive(S["GAME_WINDOW"]) && A_TickCount >= handsOffUntil && !pcLocked
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
        OwnMouse(), DllCall("mouse_event", "UInt", 0x0001, "Int", Round(dx / steps), "Int", Round(dy / steps), "UInt", 0, "UPtr", 0)
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
    x1 := MON_X + Round(rg[1] * MON_W), y1 := MON_Y + Round(rg[2] * MON_H)
    x2 := MON_X + Round(rg[3] * MON_W) - 1, y2 := MON_Y + Round(rg[4] * MON_H) - 1
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
    OwnMouse(), MouseMove(b.x + Random(-b.w // 6, b.w // 6), b.y + Random(-b.h // 6, b.h // 6), 6)
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
    global gameState, matches, totalMatches, lastProgress, unstickTries, goneSince, launchTick, launchTries, activateUntil, dimPending
    global unfocusedSince
    global lobbyVisit, modeChecked, modeRecheckTick, backToLobbyUntil, prizeWaitUntil
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

    ; Windows is locked (AnyDesk / Parsec can lock it when you disconnect): nothing can be clicked
    if pcLocked {
        SetStatus("🔒 " Tx("PC is locked, waiting"))
        lastProgress := A_TickCount
        return
    }
    ; Remote play: you're using the mouse, so Lobby Loop waits
    if (A_TickCount < handsOffUntil) {
        SetStatus("📱 " Tx("You're in control ({1}s)", Ceil((handsOffUntil - A_TickCount) / 1000)))
        lastProgress := A_TickCount
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
        if !unfocusedSince
            unfocusedSince := A_TickCount
        if (A_TickCount < activateUntil)
            try WinActivate(S["GAME_WINDOW"])    ; we just opened it: bring it to the front
        else if (S["REMOTE_MODE"] && S["REMOTE_REFOCUS"] && A_TickCount - unfocusedSince > 90000) {
            Log("Remote play: Fortnite lost focus for 90 s, bringing it back")
            try WinActivate(S["GAME_WINDOW"])
            unfocusedSince := A_TickCount
        }
        lastProgress := A_TickCount              ; watchdog only counts time spent in Fortnite
        SetStatus(Tx("Paused: click into Fortnite"))
        return
    }
    unfocusedSince := 0
    if dimPending {
        dimPending := false
        ToggleBlackout(true)
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
        if (stopAfterFind != "") {
            OnMatchEnd(gotCrops, shot)
            StopIfFound("end")
            return
        }
        limit := Integer(S["MATCH_LIMIT"])
        if (limit > 0 && matches + 1 >= limit) {
            OnMatchEnd(gotCrops, shot)
            ToggleRun("match limit reached (" limit ")")
            SetStatus(Tx("Stopped: {1} matches done", limit))
            StartStopAction()
            return
        }
        if (S["LOBBY_AFTER_MATCH"] && ReturnToLobbyClick()) {
            lastClick["end"] := A_TickCount
            gameState := "end"
            backToLobbyUntil := A_TickCount + 45000
            OnMatchEnd(gotCrops, shot)
            SetStatus("🏠 " Tx("Back to the lobby to check for prizes"))
            return
        }
        if TryClick("end") {
            OnMatchEnd(gotCrops, shot)
            return
        }
    }

    ; lobby: mode check, then Ready / Play
    if (A_TickCount - lastClick["lobby"] >= S["CLICK_COOLDOWN"] && FindButton("lobby")) {
        if StopIfFound("lobby")
            return
        if !lobbyVisit {                                ; just got to the lobby
            lobbyVisit := true
            modeChecked := false, modeRecheckTick := 0
            prizeWaitUntil := S["WATCH_TREASURE"] ? A_TickCount + Max(0, Number(S["LOBBY_PRIZE_WAIT"])) * 1000 : 0
        }
        if (prizeWaitUntil && A_TickCount < prizeWaitUntil) {
            SetStatus("🎁 " Tx("Checking for prize screens..."))
            lastProgress := A_TickCount
            SleepActive(500)
            return
        }
        if FreshRestartDue() {                          ; only here, between matches
            FreshRestart()
            return
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
    if (backToLobbyUntil && A_TickCount < backToLobbyUntil) {      ; lobby / prize screens still loading
        SetStatus("🏠 " Tx("Loading the lobby..."))
        lastProgress := A_TickCount
        SleepActive(500)
        return
    }
    backToLobbyUntil := 0

    ; eliminated: stop moving while spectating teammates
    if (gameState = "spectating" && S["SPECTATE_IDLE"]) {
        SetStatus("👻 " Tx("Spectating teammates"))
        AntiSleepNudge()
        SleepActive(1000)
        return
    }
    if (gameState != "spectating" && gameState != "match") {
        gameState := "match"
        OnMatchStart()
    }

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
    RecordTeammates()
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
              ["custom", "My own words", ""], ["cosmetic", "Treasure", "TREASURE_COSMETIC"]] {
        on := (c[3] = "") ? true : S[c[3]]
        words := (c[3] = "") ? S["TREASURE_WORDS"] : S[c[3] "_WORDS"]
        if (c[1] = "token")
            words := MergeWords("PIRATE SHOP ACCESS", words)     ; always counts
        else if (c[1] = "gizmo")
            words := MergeWords("GIZMO", words)
        if on
            cats.Push({key: c[1], name: c[2], words: WordList(words)})
    }
    return cats
}

; Joins two comma lists without repeats (online first, then the ones only you have)
MergeWords(online, mine) {
    out := [], seen := Map()
    for src in [online, mine]
        for w in StrSplit(String(src), ",", " `t")
            if (w != "" && !seen.Has(k := StrUpper(w))) {
                seen[k] := 1
                out.Push(w)
            }
    txt := ""
    for w in out
        txt .= (txt = "" ? "" : ",") w
    return txt
}

; One wrong, missing or extra letter (OCR slips). Both are PrizeKey() text.
FuzzyIn(hay, needle) {
    n := StrLen(needle)
    if (n < 6 || StrLen(hay) < n - 1)
        return false
    loop StrLen(hay) - (n - 1) + 1 {
        i := A_Index
        for len in [n - 1, n, n + 1]
            if (i + len - 1 <= StrLen(hay) && EditDist1(SubStr(hay, i, len), needle))
                return true
    }
    return false
}

EditDist1(a, b) {
    la := StrLen(a), lb := StrLen(b)
    if (Abs(la - lb) > 1)
        return false
    i := 1, j := 1, diff := 0
    while (i <= la && j <= lb) {
        if (SubStr(a, i, 1) == SubStr(b, j, 1)) {
            i += 1, j += 1
            continue
        }
        if (++diff > 1)
            return false
        if (la > lb)
            i += 1
        else if (lb > la)
            j += 1
        else
            i += 1, j += 1
    }
    return diff + (la - i + 1) + (lb - j + 1) <= 1
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
            if (w2 != "" && (banner || strong)
                && (InStr(u, w2) || (StrLen(w2) >= 5 && InStr(PrizeKey(u), PrizeKey(w2))) || FuzzyIn(PrizeKey(u), PrizeKey(w2))))
                return cat
        }
    if banner
        for cat in cats
            if (cat.key = "cosmetic")
                return cat                              ; any other prize from the banner
    return ""
}

CheckTreasure(lines) {
    static seen := Map(), recapMatch := -1
    W := MON_W, H := MON_H
    foundWords := WordList(S["TREASURE_FOUND_WORDS"])
    hits := []
    for ln in lines {
        img := ""
        u := StrUpper(ln.text)
        if TreasureNoise(u)
            continue
        isBanner := !foundWords.Length
        if !isBanner
            for w in foundWords
                if InStr(u, w) {                                ; the prize banner (shows when you get back to the lobby)
                    isBanner := true
                    break
                }
        if isBanner {
            txt := ln.text                                  ; add the lines right next to it (same banner)
            for other in lines
                if (other != ln && Abs(other.y - ln.y) < Max(ln.h, 20) * 3 && other.x >= ln.x - W * 0.05
                    && Abs((other.x + other.w / 2) - (ln.x + ln.w / 2)) < W * 0.25 && !TreasureNoise(StrUpper(other.text)))
                    txt .= " " other.text
            img := ""
            if IsObject(item := PrizeFromScreen(lines))
                txt := item.name " (" item.type ")"
            cat := TreasureCategoryFor(StrUpper(txt), true)
            ; match recap: "TREASURE FOUND:" with only an icon under it (no name)
            if (!IsObject(item) && RegExMatch(StrUpper(Trim(txt)), "^TREASURE FOUND\W*$")) {
                if (recapMatch = totalMatches)
                    continue                                    ; this match's recap was already counted
                recapMatch := totalMatches
                ic := RecapIcon(ln)
                img := ic.path
                if ic.gold {
                    txt := "Pirate Shop Access (gold icon)"
                    for c2 in TreasureCategories()
                        if (c2.key = "token")
                            cat := c2
                    if (!IsObject(cat) || cat.key != "token")
                        cat := {key: "token", name: "Pirate Shop Access", words: []}
                } else {
                    txt := "Treasure (icon on the match recap)"
                }
            }
        } else {
            txt := ln.text
            cat := TreasureCategoryFor(u, false)            ; only ! words count without the banner
        }
        if IsObject(cat)
            hits.Push([txt, cat, img])
    }
    for h in hits {
        k := h[2].key ":" StrUpper(h[1])
        if (seen.Has(k) && A_TickCount - seen[k] < (h[2].key = "token" ? 1800000 : 180000))
            continue                                        ; Pirate Shop Access screens stay up: count it once
        seen[k] := A_TickCount
        TreasureFound(Trim(h[1]), h[2], h[3])
        TreasureStopCheck(Trim(h[1]), h[2])
        break                                               ; one find per screen
    }
}

TreasureFound(text, cat := "", img := "") {
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
    prize := MarkPrize(text)
    if IsObject(prize)
        catName := prize.type
    msg := "🏴‍☠️ **" catName "**: " text " (#" treasureCount " all time)"
        . (IsObject(prize) ? "`n🎁 Week " prize.week " prize: **" prize.name "** (" prize.got "/" prize.total " this week)" : "")
    if !S["TREASURE_NOTIFY"]
        NtfyPush("Treasure: " catName, text, 5, "pirate_flag")
    if IsObject(prize)
        SetTimer(() => OwnedNotice(), -5000)
    if (DiscordReady() && S["TREASURE_DISCORD"]) {
        shot := A_Temp "\ll_treasure.png"
        sent := false
        if (img != "" && FileExist(img))                ; close-up of the prize icon
            sent := DiscordFile(msg, img)
        if (S["TREASURE_SCREENSHOT"] && !sent) {
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
    lines := OcrRegionSync(MON_X, MON_Y, MON_W, MON_H)
    all := ""
    for ln in lines
        all .= ln.text "`r`n"
    path := DATA_DIR "\" BASE "_screen_text.txt"
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
    lines := OcrRegionSync(MON_X, MON_Y + Round(MON_H * 0.52), Round(MON_W * 0.32), Round(MON_H * 0.36))
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
    OwnMouse(), MouseMove(m.x + m.w // 2, m.y + m.h // 2, 5)
    Sleep(200)
    Click()
    Sleep(2200)
    for key in ["MODE_BUILD", "MODE_TEAM", "MODE_FILL"] {
        want := StrLower(S[key])
        if (want = "any" || !labels.Has(want))
            continue
        lines := OcrRegionSync(MON_X, MON_Y, MON_W, MON_H)
        clicked := false
        for ln in lines {
            u := Trim(StrUpper(ln.text))
            for lab in labels[want]
                if (u = lab) {
                    OwnMouse(), MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
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
    global wordsShown
    g := ThemeGui(TITLE " - " Tx("Settings"))
    c := Map()
    pages := []
    navs := []
    lobbyNotes := []                                  ; "needs Return to lobby" notes, updated live
    CW := 620                                         ; content width
    CX := 230                                         ; content left edge
    COL2 := 320                                       ; second column offset

    ; sidebar
    g.Add("Text", "x0 y0 w200 h710 Background" UiCol("side"))
    UiText(g, "x20 y18 w170", "🔁 " TITLE, "head", UiCol("side"))
    UiText(g, "x20 y+2 w170", "v" VERSION, "muted", UiCol("side"))
    sections := [["🎮", "Play"], ["🎯", "Mode"], ["🤝", "Squad fill"], ["⏰", "Schedule"], ["✨", "Extras"], ["🏴‍☠️", "Treasure"], ["🎬", "Alerts & clips"],
                 ["⌨️", "Hotkeys"], ["🧩", "Popups"], ["🔔", "Discord alerts"], ["📱", "Phone control"], ["🎨", "Look"], ["🧹", "Storage"], ["🔗", "Share & tools"]]
    for i, sec in sections {
        n := g.Add("Text", "x10 y" (72 + (i - 1) * 40) " w180 h35 0x200 Background" UiCol("side"), "           " StrReplace(Tx(sec[2]), "&", "&&"))
        n.OnEvent("Click", SettingsNav.Bind(i, pages, navs))
        navs.Push(n)
    }
    sbox := UiEdit(g, "x12 y652 w176 r1", "")
    SendMessage(0x1501, 1, StrPtr("🔍 " Tx("Search settings")), sbox)      ; placeholder text
    sbox.OnEvent("Change", SettingsSearch.Bind(sbox, pages, navs))

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
    lobbyNote(opts) {
        t := add(UiText(g, opts " w300", LobbyNoteText(S["LOBBY_AFTER_MATCH"]), "muted"))
        lobbyNotes.Push(t)
        return t
    }
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
    say(Tx("After a match:"), "y+12")
    am := add(UiDDL(g, "x" CX " y+4 w300", [Tx("Play Again (faster)"), Tx("Return to lobby (shows prizes)")]))
    am.Choose(S["LOBBY_AFTER_MATCH"] ? 2 : 1)
    am.OnEvent("Change", (*) => UpdateLobbyNotes(lobbyNotes, am.Value = 2))
    c["LOBBY_AFTER_MATCH"] := am
    hint(Tx("Prize banners and claim screens only show in the lobby, so treasure needs Return to lobby."))
    say(Tx("Stop after this many matches (0 = no limit):"), "y+12")
    edit("MATCH_LIMIT", "y+4 w120")
    say(Tx("Your name (for Discord and the leaderboard):"), "y+12")
    c["PLAYER_NAME"] := add(UiEdit(g, "x" CX " y+4 w300 r1", PlayerName()))
    op := add(UiButton(g, "x" CX " y+18 w300", "🌙 " Tx("Overnight treasure farm (one click)")))
    op.OnEvent("Click", (*) => ApplyOvernightPreset(g))
    cl := add(UiButton(g, "x+10 yp w300", "📋 " Tx("Setup checklist")))
    cl.OnEvent("Click", (*) => ShowChecklist(g.Hwnd))

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
    tfa := UiCheck(g, "x" CX " y+14", Tx("Team Fill check: make sure Fill is on before every queue"), StrLower(S["MODE_FILL"]) = "fill", CW - 30)
    tfc := addAll(tfa)
    tfc.OnEvent("Click", (*) => c["MODE_FILL"].Choose(tfc.Value ? 2 : 1))
    tfa[2].OnEvent("Click", (*) => c["MODE_FILL"].Choose(tfc.Value ? 2 : 1))
    c["MODE_FILL"].OnEvent("Change", (*) => (tfc.Value := (c["MODE_FILL"].Value = 2)))
    hint(Tx("Same as Settings > Mode > Fill. If the lobby is on No fill, it waits and tells you (or switches, if that's on)."))
    tick("EMPTY_SQUAD", "Leave when I got no teammates, or they all left (experimental)", "y+12")
    hint(Tx("Counts the names in the squad list (top left). Nobody left = nobody farming for you. Test it in a match first."))
    sq := add(UiButton(g, "x" CX " y+8 w260", "👥 " Tx("Test the squad count")))
    sq.OnEvent("Click", (*) => (g.Destroy(), ShowSquadTest(3000)))
    add(UiText(g, "x" CX " y+10 w" CW " r2", TeammateStatsText(), "muted"))

    ; ---- 4. Schedule ----
    newPage(Tx("Schedule"), Tx("Start by itself, every day or with Windows."))
    say(Tx("Start every day at:"), "y+16")
    c["START"] := add(UiEdit(g, "x" CX " y+4 w200 r1", ClockText(S["START_AT_TIME"])))
    hint(Tx("e.g.   2:00 AM    14:30      (blank = off, Fortnite must be logged in)"))
    tick("AUTO_START", "Start by itself when I click into Fortnite", "y+14")
    tick("LAUNCH_FORTNITE", "Open Fortnite by itself (scheduled start, crash, stuck)")
    tick("CHECK_SERVERS", "Check Fortnite's servers first (wait during outages)")
    tick("START_WITH_WINDOWS", "Start with Windows")
    say(Tx("Fresh restart: restart Fortnite every this many hours, between matches (0 = off):"), "y+14")
    edit("FRESH_RESTART_HOURS", "y+4 w120")
    hint(Tx("Keeps Fortnite running smoothly overnight. It never restarts during a match."))

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
    tick("FPS_SAVER", "FPS saver: Fortnite at 30 FPS while running (yours comes back after)", "y+12")
    hint(Tx("Starts the next time Lobby Loop opens Fortnite. Your FPS comes back once Fortnite closes after the run."))
    tick("BATTERY_GUARD", "Laptop: stop when the battery is low", "y+12")
    say(Tx("Battery % that counts as low:"), "y+4 Section", 280)
    edit("BATTERY_MIN", "y+4 w120")
    c["BATTERY_SLEEP"] := addAll(UiCheck(g, "xs+" COL2 " ys+22", Tx("Also put the PC to sleep"), S["BATTERY_SLEEP"], 260))
    hint(WindowModeText(), "y+16")

    ; ---- 6. Treasure ----
    newPage(Tx("Treasure"), Tx("Spots the prizes your squad finds in chests, and keeps them safe."))
    tick("WATCH_TREASURE", "Watch for treasure", "y+12")
    tick("TREASURE_ONLINE", "Get the newest words online (weekly prize names)", "y+6")
    add(UiText(g, "x" CX " y+12 w300 Section", Tx("What to look for"), "head"))
    lobbyNote("xs y+2")
    add(UiText(g, "xs y+8 w300", Tx("Prize banner (must be on screen)")))
    c["TREASURE_FOUND_WORDS"] := add(UiEdit(g, "xs y+4 w300 r1", S["TREASURE_FOUND_WORDS"]))
    for item in [["TREASURE_TOKEN", "Pirate Shop Access (pirate token)"], ["TREASURE_GIZMO", "Gizmos (Sprite Locator, Lucky Locator...)"],
                 ["TREASURE_COSMETIC", "Treasure (any other prize)"]] {
        c[item[1]] := addAll(UiCheck(g, "xs y+9", Tx(item[2]), S[item[1]], 280))
        c[item[1] "_WORDS"] := add(UiEdit(g, "xs y+4 w300 r1", S[item[1] "_WORDS"]))
    }
    add(UiText(g, "xs y+9 w300", Tx("My own words")))
    c["TREASURE_WORDS"] := add(UiEdit(g, "xs y+4 w300 r1", S["TREASURE_WORDS"]))
    add(UiText(g, "xs y+4 w300", Tx("Separate words with commas. Start a word with ! to count it without the banner."), "muted"))
    add(UiText(g, "xs+" COL2 " ys w300", Tx("Keep it safe"), "head"))
    lobbyNote("xs+" COL2 " y+2")
    add(UiText(g, "xs+" COL2 " y+8 w300", Tx("Stop after the match when I find:")))
    st := add(UiDDL(g, "xs+" COL2 " y+4 w300", [Tx("Never"), Tx("Pirate Shop Access"), Tx("Any treasure")]))
    st.Choose(StrLower(S["TREASURE_STOP"]) = "token" ? 2 : StrLower(S["TREASURE_STOP"]) = "any" ? 3 : 1)
    c["TREASURE_STOP"] := st
    add(UiText(g, "xs+" COL2 " y+4 w300", Tx("Then it does your stop action (Settings > Play)."), "muted"))
    c["TREASURE_PROOF"] := addAll(UiCheck(g, "xs+" COL2 " y+12", Tx("Lobby proof: screenshot the prize screen, then click Claim"), S["TREASURE_PROOF"], 276))
    uw := add(UiButton(g, "xs+" COL2 " y+10 w300", "🌐 " Tx("Update the words now")))
    uw.OnEvent("Click", (*) => SettingsUpdateWords(g))
    add(UiText(g, "xs+" COL2 " y+4 w300", Tx("Online words: {1}", S["TREASURE_ONLINE_VERSION"] != "" ? S["TREASURE_ONLINE_VERSION"] : Tx("not downloaded yet")), "muted"))
    add(UiText(g, "xs+" COL2 " y+10 w300", PrizeWeek() ? Tx("Week {1} prizes", PrizeWeek()) : Tx("This week's prizes"), "head"))
    add(UiText(g, "xs+" COL2 " y+2 w300 r5", PrizesText(PrizeWeek()), "muted"))
    ws := add(UiButton(g, "xs+" COL2 " y+4 w300", "🌐 " Tx("Open Chest Tracker (fnchesttracker.com)")))
    ws.OnEvent("Click", (*) => Run("https://fnchesttracker.com/tracker"))
    ob2 := add(UiButton(g, "xs+" COL2 " y+6 w145", "✅ " Tx("What I own")))
    ob2.OnEvent("Click", (*) => ShowOwnedPicker(g.Hwnd))
    oc := add(UiButton(g, "x+10 yp w145", "🎲 " Tx("Odds")))
    oc.OnEvent("Click", (*) => ShowOddsCalc(g.Hwnd))

    ; ---- 7. Alerts & clips ----
    newPage(StrReplace(Tx("Alerts & clips"), "&", "&&"), Tx("What happens when treasure is found."))
    add(UiText(g, "x" CX " y+16 w300 Section", Tx("When I find treasure"), "head"))
    lobbyNote("xs y+2")
    first := true
    for item in [["TREASURE_NOTIFY", "Windows notification"], ["TREASURE_BEEP", "Play a sound"], ["TREASURE_DISCORD", "Tell Discord"],
                 ["TREASURE_SCREENSHOT", "Add a screenshot"], ["TREASURE_CLIP", "Save a clip (20 s before + 5 s after)"]] {
        c[item[1]] := addAll(UiCheck(g, "xs" (first ? " y+10" : " y+8"), Tx(item[2]), S[item[1]], 270))
        first := false
    }
    add(UiText(g, "xs+" COL2 " ys w300", Tx("Clips"), "head"))
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
    add(UiText(g, "x" CX " y380 w" CW, Tx("Tools"), "head"))
    rb := add(UiButton(g, "x" CX " y+8 w250", "🔎 " Tx("Read the screen now")))
    rb.OnEvent("Click", (*) => (g.Destroy(), ShowScreenText(4000)))
    tc := add(UiButton(g, "x+10 yp w200", "🎬 " Tx("Test the clip key")))
    tc.OnEvent("Click", (*) => SettingsTestClip(g, c))
    pf := add(UiButton(g, "x" CX " y+8 w250", "📁 " Tx("Open proof screenshots")))
    pf.OnEvent("Click", (*) => (DirCreate(DATA_DIR "\" BASE "_treasure_proof"), Run(DATA_DIR "\" BASE "_treasure_proof")))
    add(UiText(g, "x" CX " y+18 w" CW, Tx("Recent finds"), "head"))
    add(UiText(g, "x" CX " y+2 w" CW " r3", RecentTreasureText(3), "muted"))

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
    tick("KNOWN_POPUPS", "Click known Fortnite popups by itself (disconnected, server not responding, removed...)", "y+14")
    hint(Tx("Kicked for being idle: {1} times so far.", totalIdleKicks))
    if !POPUPS.Length
        hint(Tx("No popup buttons learned yet."), "y+14")
    for i, p in POPUPS {
        pw := Round((p.r - p.l) * MON_W), ph := Round((p.b - p.t) * MON_H)
        add(g.Add("Text", "x" CX " y+" (i = 1 ? 18 : 10) " w22 h22 Background" Format("{:06X}", p.color)))
        add(UiText(g, "x+10 yp+2 w300", "#" i "   " pw " x " ph " px   (" Round(p.l * 100) "%, " Round(p.t * 100) "%)"))
        fb := add(UiButton(g, "x+10 yp-4 w140", "🗑 " Tx("Forget")))
        fb.OnEvent("Click", SettingsForgetPopup.Bind(i, g))
    }
    if POPUPS.Length {
        fa := add(UiButton(g, "x" CX " y+18 w200", Tx("Forget all")))
        fa.OnEvent("Click", (*) => (ForgetPopups(), g.Destroy(), OpenSettings(9)))
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
    tick("WEEKLY_RECAP", "Weekly recap on Sundays at 8 PM", "y+14")
    say(Tx("Friends leaderboard: webhook link of a shared channel (optional)"), "y+12")
    c["LEADERBOARD_WEBHOOK"] := add(UiEdit(g, "x" CX " y+4 w" (CW - 170) " r1", S["LEADERBOARD_WEBHOOK"]))
    lbb := add(UiButton(g, "x+10 yp-2 w160", "🏆 " Tx("Post my card")))
    lbb.OnEvent("Click", (*) => (SetSetting("LEADERBOARD_WEBHOOK", Trim(c["LEADERBOARD_WEBHOOK"].Value)), ShowTip(LbCardUpdate(true) ? Tx("Sent to Discord") : Tx("Couldn't send to Discord"), 2500)))
    hint(Tx("Everyone pastes the same link. Each PC keeps one card there and updates it. !lb ranks everyone if your bot can see that channel."))
    say(Tx("Phone push with the free ntfy app: topic name (optional)"), "y+12")
    c["NTFY_TOPIC"] := add(UiEdit(g, "x" CX " y+4 w" (CW - 170) " r1", S["NTFY_TOPIC"]))
    ntb := add(UiButton(g, "x+10 yp-2 w160", "📲 " Tx("Test push")))
    ntb.OnEvent("Click", (*) => (SetSetting("NTFY_TOPIC", Trim(c["NTFY_TOPIC"].Value)), ShowTip(NtfyPush("Test", "Test push from " PlayerName() "'s Lobby Loop", 3) ? Tx("Sent") : Tx("Couldn't send"), 2500)))
    hint(Tx("Install ntfy, subscribe to the same topic. Pick a long name nobody can guess: anyone with the name can read it."))

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
    hint(Tx("Type !help in your channel to see all 30+ commands. Change settings with !set (type !set to see them)."), "y+10")
    say(Tx("Remote play (Parsec / AnyDesk from your phone)"), "y+18")
    tick("REMOTE_MODE", "Step aside when I move the mouse (and show the status box to Parsec / AnyDesk)", "y+6")
    say(Tx("Hand back after (seconds without mouse movement):"), "y+6")
    edit("REMOTE_HANDS_SEC", "y+4 w120")
    tick("REMOTE_REFOCUS", "Bring Fortnite back to the front if it loses focus", "y+8")
    hint(Tx("Always on: a Discord message if the PC gets locked or the screen size changes. Phone: !focus, !keys, !remote on."))

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
    add(UiText(g, "xs y+16 w280 Section", Tx("Fortnite's screen")))
    monItems := [Tx("Find it by itself")]
    loop MonitorGetCount() {
        MonitorGet(A_Index, &ml, &mt, &mr, &mb)
        monItems.Push(Tx("Screen {1}", A_Index) "  (" (mr - ml) "x" (mb - mt) (A_Index = MonitorGetPrimary() ? ", " Tx("main") : "") ")")
    }
    c["GAME_MONITOR"] := add(UiDDL(g, "xs y+4 w260", monItems))
    c["GAME_MONITOR"].Choose(Min(Integer(S["GAME_MONITOR"]) + 1, monItems.Length))
    c["SHOW_OVERLAY"] := addAll(UiCheck(g, "xs y+18", Tx("Show the status box") "  (" HK_OVERLAY ")", !overlayHidden, 260))
    mv := add(UiButton(g, "xs+" COL2 " yp-4 w260", "✋ " Tx("Move status box")))
    mv.OnEvent("Click", (*) => (g.Destroy(), MoveOverlay()))

    ; ---- 13. Storage ----
    newPage(Tx("Storage"), Tx("Where Lobby Loop keeps its files, and cleaning up."))
    say(Tx("Data folder:"), "y+16")
    hint(DATA_DIR)
    df := add(UiButton(g, "x" CX " y+6 w260", "📁 " Tx("Open the data folder")))
    df.OnEvent("Click", (*) => Run(DATA_DIR))
    say(Tx("Delete match lists older than this many days (0 = keep, treasure finds are always kept):"), "y+16")
    edit("CLEAN_DAYS", "y+4 w120")
    say(Tx("Delete proof screenshots older than this many days (0 = keep forever):"), "y+12")
    edit("CLEAN_PROOF_DAYS", "y+4 w120")
    say(Tx("Keep the log under (MB):"), "y+12 Section", 280)
    edit("LOG_MAX_MB", "y+4 w120")
    add(UiText(g, "xs+" COL2 " ys w300", Tx("Warn when a drive has less than (GB, 0 = off):")))
    c["DISK_MIN_GB"] := add(UiEdit(g, "xs+" COL2 " y+4 w120 r1", S["DISK_MIN_GB"]))
    cn := add(UiButton(g, "x" CX " y+16 w260", "🧹 " Tx("Clean now")))
    cn.OnEvent("Click", (*) => CleanData(true))
    try freeTxt := Round(DriveGetSpaceFree(SubStr(DATA_DIR, 1, 3)) / 1024, 1) " GB"
    catch
        freeTxt := "?"
    hint(Tx("Free space on {1}: {2}", SubStr(DATA_DIR, 1, 2), freeTxt), "y+8")

    ; ---- 14. Share & tools ----
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
    add(UiText(g, "x" CX " y+22 w" CW, "🛡️ " Tx("Trust"), "head"))
    add(UiText(g, "x" CX " y+4 w" CW, TRUST_TEXT(), "muted"))
    ck2 := add(UiButton(g, "x" CX " y+10 w300", "📋 " Tx("Setup checklist")))
    ck2.OnEvent("Click", (*) => ShowChecklist(g.Hwnd))

    ; ---- bottom bar ----
    g.Add("Text", "x" CX " y636 w" CW " h1 Background" UiCol("line"))
    saveBtn := UiButton(g, "x" (CX + CW - 250) " y650 w120 Default", Tx("Save"))
    saveBtn.OnEvent("Click", (*) => SaveSettingsGui(g, c))
    wordsShown := Map()
    for key in ["TREASURE_GIZMO_WORDS", "TREASURE_COSMETIC_WORDS", "TREASURE_TOKEN_WORDS", "TREASURE_WORDS", "TREASURE_FOUND_WORDS"]
        if c.Has(key)
            wordsShown[key] := Trim(c[key].Value)
    cancelBtn := UiButton(g, "x+10 yp w120", Tx("Cancel"))
    cancelBtn.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())

    AddSettingsIcons(g, pages, navs, sections)
    SettingsNav(Min(Max(1, startPage), pages.Length), pages, navs)
    g.Show("w" (CX + CW + 30) " h700")
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
    global botLastId, botFails, watchMinutes, wordsShown
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
    lbHook := Trim(c["LEADERBOARD_WEBHOOK"].Value)
    if (lbHook != "" && !IsDiscordUrl(lbHook))
        return bad("The leaderboard link should be a Discord webhook link (https://discord.com/api/webhooks/...).")
    ntfyTopic := Trim(c["NTFY_TOPIC"].Value)
    if (ntfyTopic != "" && !RegExMatch(ntfyTopic, "^[A-Za-z0-9_\-]{1,64}$"))
        return bad("The ntfy topic can only use letters, numbers, - and _ (no spaces).")
    channel := Trim(c["CHANNEL"].Value)
    if (channel != "" && Trim(c["TOKEN"].Value) = "" && MsgBox(Tx("Phone control needs the bot token too, or your commands won't work. Save without it?"), TITLE, "YesNo Icon! Owner" g.Hwnd) != "Yes")
        return
    if (channel != "" && !RegExMatch(channel, "^\d{15,22}$"))
        return bad("The channel ID should be a long number (right-click the channel > Copy Channel ID).")
    try {
        nums := Map("MATCH_LIMIT", num("MATCH_LIMIT", Tx("Stop after this many matches (0 = no limit):"), 0, 10000),
                    "BATTERY_MIN", num("BATTERY_MIN", Tx("Battery % that counts as low:"), 5, 95),
                    "FRESH_RESTART_HOURS", num("FRESH_RESTART_HOURS", Tx("Fresh restart: restart Fortnite every this many hours, between matches (0 = off):"), 0, 48),
                    "CLEAN_DAYS", num("CLEAN_DAYS", Tx("Delete match lists older than this many days (0 = keep, treasure finds are always kept):"), 0, 3650),
                    "CLEAN_PROOF_DAYS", num("CLEAN_PROOF_DAYS", Tx("Delete proof screenshots older than this many days (0 = keep forever):"), 0, 3650),
                    "LOG_MAX_MB", num("LOG_MAX_MB", Tx("Keep the log under (MB):"), 1, 500),
                    "DISK_MIN_GB", num("DISK_MIN_GB", Tx("Warn when a drive has less than (GB, 0 = off):"), 0, 1000),
                    "GAME_VOLUME", num("GAME_VOLUME", Tx("Or set Fortnite's volume while running (0-100, 100 = leave it):"), 0, 100),
                    "CLIP_DELAY", num("CLIP_DELAY", Tx("Wait (seconds)"), 0, 60),
                    "AUTO_SCREENSHOT_MIN", num("AUTO_SCREENSHOT_MIN", Tx("Screenshot to Discord every (minutes, 0 = off):"), 0, 1440),
                    "REMOTE_HANDS_SEC", num("REMOTE_HANDS_SEC", Tx("Hand back after (seconds without mouse movement):"), 5, 3600))
    } catch as e {
        return bad(e.Message)
    }
    oldStream := S["STREAM_HIDE"] ? 1 : 0
    oldRemote := S["REMOTE_MODE"] ? 1 : 0
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
                "SCREENSHOT_EVERY_MATCH", "NOTIFY", "SPECTATE_IDLE", "WAIT_FOR_SQUAD", "WAKE_FROM_SLEEP", "AUTO_CLAIM", "TREASURE_ONLINE", "TREASURE_PROOF",
                "KNOWN_POPUPS", "CHECK_SERVERS", "FPS_SAVER", "BATTERY_GUARD", "BATTERY_SLEEP", "WEEKLY_RECAP", "EMPTY_SQUAD", "WATCH_TREASURE", "LIVE_STATUS", "MODE_SWITCH",
                "KEEP_AWAKE", "STREAM_HIDE", "REMOTE_MODE", "REMOTE_REFOCUS",
                "TREASURE_GIZMO", "TREASURE_COSMETIC", "TREASURE_TOKEN", "TREASURE_NOTIFY", "TREASURE_BEEP", "TREASURE_DISCORD",
                "TREASURE_SCREENSHOT", "TREASURE_CLIP", "CLIP_UPLOAD"]
        if c.Has(key)
            SetSetting(key, c[key].Value)
    for key, v in nums
        SetSetting(key, v)
    for key in ["TREASURE_GIZMO_WORDS", "TREASURE_COSMETIC_WORDS", "TREASURE_TOKEN_WORDS", "TREASURE_WORDS", "TREASURE_FOUND_WORDS"]
        if (!wordsShown.Has(key) || Trim(c[key].Value) != wordsShown[key])
            SetSetting(key, Trim(c[key].Value))          ; changed here (an online update while the window was open is kept)
    SetSetting("CLIP_KEY", clipKey)
    SetSetting("CLIP_METHOD", ["gamebar", "nvidia", "custom"][c["CLIP_METHOD"].Value])
    SetSetting("MODE_TEAM", ["any", "solo", "duo", "trio", "squad"][c["MODE_TEAM"].Value])
    SetSetting("MODE_BUILD", ["any", "build", "zerobuild"][c["MODE_BUILD"].Value])
    SetSetting("MODE_FILL", ["any", "fill", "nofill"][c["MODE_FILL"].Value])
    SetSetting("MODE_ACTION", c["MODE_ACTION"].Value = 2 ? "ready" : "wait")
    SetSetting("TREASURE_STOP", ["off", "token", "any"][c["TREASURE_STOP"].Value])
    SetSetting("LOBBY_AFTER_MATCH", c["LOBBY_AFTER_MATCH"].Value = 2 ? 1 : 0)
    if !S["FPS_SAVER"]
        FpsRestoreLater()
    watchMinutes := nums["AUTO_SCREENSHOT_MIN"]
    if (c["START_WITH_WINDOWS"].Value != (S["START_WITH_WINDOWS"] ? 1 : 0))
        SetStartWithWindows(c["START_WITH_WINDOWS"].Value)
    SetSetting("START_WITH_WINDOWS", c["START_WITH_WINDOWS"].Value)
    SetSetting("PLAYER_NAME", Trim(c["PLAYER_NAME"].Value))
    SetSetting("DISCORD_WEBHOOK", hook)
    SetSetting("LEADERBOARD_WEBHOOK", lbHook)
    SetSetting("NTFY_TOPIC", ntfyTopic)
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
        || (newStyle != StrLower(S["OVERLAY_STYLE"])) || (newAccent != StrLower(S["ACCENT"])) || (oldStream != c["STREAM_HIDE"].Value) || (oldRemote != c["REMOTE_MODE"].Value)
    SetSetting("OVERLAY_STYLE", newStyle)
    SetSetting("ACCENT", newAccent)
    SetSetting("LANG", newLang)
    SetSetting("THEME", newTheme)
    SetSetting("OVERLAY_SIZE", newSize)
    SetSetting("OVERLAY_CORNER", ["top-left", "top-right", "bottom-left", "bottom-right", "custom"][c["CORNER"].Value])
    if (c["GAME_MONITOR"].Value - 1 != Integer(S["GAME_MONITOR"])) {
        SetSetting("GAME_MONITOR", c["GAME_MONITOR"].Value - 1)
        UpdateMonitor(true)
    }
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
        BumpWeek("SleepWakes")
        ReleaseAll()
        OwnMouse(), MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
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


; ============================================================
; v7.7: online treasure words (from GitHub, so weekly prize names update by themselves)
; treasure_words.txt looks like:  version=2026-11-18 / token=... / gizmo=... / cosmetic=... / banner=...
; ============================================================
TreasureWordsUrl() {
    u := Trim(String(S["TREASURE_WORDS_URL"]))
    return (u != "") ? u : "https://raw.githubusercontent.com/yensobased1/lobby-loop/main/treasure_words.txt"
}

UpdateTreasureWords(manual := false) {
    if (!S["TREASURE_ONLINE"] && !manual)
        return false
    tmp := A_Temp "\ll_treasure_words.txt"
    try {
        try FileDelete(tmp)
        Download(TreasureWordsUrl() "?t=" A_TickCount, tmp)
        txt := FileRead(tmp, "UTF-8")
    } catch {
        Log("Couldn't download the treasure words")
        if manual
            ShowTip(Tx("Couldn't download the treasure words. Check your internet."), 3500)
        return false
    }
    vals := Map()
    for line in StrSplit(txt, "`n", "`r")
        if RegExMatch(line, "^[ \t]*(\w+)[ \t]*=[ \t]*(.*?)[ \t]*$", &m)
            vals[StrLower(m[1])] := m[2]
    if !vals.Has("version") {
        Log("treasure_words.txt has no version= line")
        return false
    }
    changed := 0
    for pair in [["token", "TREASURE_TOKEN_WORDS"], ["gizmo", "TREASURE_GIZMO_WORDS"], ["cosmetic", "TREASURE_COSMETIC_WORDS"], ["banner", "TREASURE_FOUND_WORDS"]]
        if vals.Has(pair[1]) {
            merged := MergeWords(vals[pair[1]], S[pair[2]])     ; online words first, your own words kept
            if (merged != String(S[pair[2]])) {
                SetSetting(pair[2], merged)
                changed += 1
            }
        }
    if (!manual && !changed && vals["version"] = String(S["TREASURE_ONLINE_VERSION"]))
        return false                                   ; already have these
    SetSetting("TREASURE_ONLINE_VERSION", vals["version"])
    if vals.Has("week") {
        try IniDelete(STATS_FILE, "WeeklyPrizes")
        IniWrite(vals["week"], STATS_FILE, "WeeklyPrizes", "Week")
        for k, v in vals
            if RegExMatch(k, "^prizes_(\d+)$", &pm)
                IniWrite(v, STATS_FILE, "WeeklyPrizes", "W" pm[1])
    }
    Log("Treasure words updated to " vals["version"] " (" changed " lists changed)")
    if (changed || manual)
        ShowTip(Tx("Treasure words updated ({1}).", vals["version"]), 3500)
    return true
}

; ============================================================
; v7.7: stop after the match when you find something (so the prize is safe)
; ============================================================
TreasureStopCheck(text, cat) {
    global stopAfterFind
    rule := StrLower(String(S["TREASURE_STOP"]))
    if (rule = "off" || !running || stopAfterFind != "")
        return
    if (rule = "token" && (!IsObject(cat) || cat.key != "token"))
        return
    stopAfterFind := text
    if (gameState = "match" || gameState = "spectating") {
        Log("Will stop after this match (found: " text ")")
        Notify("🏴‍☠️ " Tx("Found it!"), Tx("Lobby Loop stops after this match ends, so the prize is safe."))
        Discord("🏴‍☠️ Found **" text "**. Lobby Loop stops after this match ends (it won't leave early).")
    } else {
        Log("Found in the lobby: stopping after the claim (" text ")")
        Notify("🏴‍☠️ " Tx("Found it!"), Tx("Lobby Loop stops now that the prize is claimed."))
        Discord("🏴‍☠️ Found **" text "**. Stopping after it's claimed.")
        SetTimer(() => StopIfFound("lobby"), -7000)      ; gives the lobby proof time to screenshot and claim
    }
}

; Called where Play Again would be clicked, and in the lobby. Returns true if it stopped.
StopIfFound(where) {
    global stopAfterFind
    if (stopAfterFind = "")
        return false
    found := stopAfterFind
    stopAfterFind := ""
    if !running                                         ; already stopped: don't start it again
        return false
    ToggleRun("found " found)
    SetStatus("🏴‍☠️ " Tx("Stopped: found {1}", found))
    StartStopAction()
    return true
}

; ============================================================
; v7.7: lobby proof: when the lobby shows an UNLOCKED! treasure screen, save a screenshot first,
;       then click Claim All
; ============================================================
LobbyProof(lines, joined) {
    global lastClaimTick, clicks
    static lastProof := 0
    if (!S["TREASURE_PROOF"] || A_TickCount - lastProof < 20000)
        return false
    prizeScreen := InStr(joined, "UNLOCKED")
    if !prizeScreen
        for w in WordList(S["TREASURE_FOUND_WORDS"])
            if InStr(joined, w)
                prizeScreen := true
    if !prizeScreen
        return false
    isTreasure := InStr(joined, "PIRATE SHOP ACCESS")
    if !isTreasure
        for cat in TreasureCategories()
            for w in cat.words
                if (StrLen(LTrim(w, "!")) >= 6 && InStr(joined, LTrim(w, "!"))) {
                    isTreasure := true
                    break
                }
    if !isTreasure
        return false
    btn := ""
    for ln in lines {
        u := Trim(StrUpper(ln.text))
        if (u = "CLAIM ALL" || u = "CLAIM" || u = "CLAIM REWARD" || u = "COLLECT")
            btn := ln
    }
    if !IsObject(btn)
        return false
    lastProof := A_TickCount
    dir := DATA_DIR "\" BASE "_treasure_proof"
    try DirCreate(dir)
    shot := dir "\" FormatTime(, "yyyy-MM-dd_HH-mm-ss") ".png"
    saved := SaveRegionImage(shot, MON_X, MON_Y, MON_W, MON_H)
    Log("Lobby proof " (saved ? "saved: " shot : "screenshot failed"))
    if (saved && DiscordReady())
        DiscordFile("🏴‍☠️ **Treasure unlocked** on " PlayerName() "'s account. Proof screenshot, clicking " btn.text " now.", shot)
    if !WinActive(S["GAME_WINDOW"])                    ; may have just stopped for this find: still claim it
        return true
    Sleep(400)
    ReleaseAll()
    OwnMouse(), MouseMove(btn.x + btn.w // 2, btn.y + btn.h // 2, 5)
    Sleep(180)
    Click()
    clicks += 1
    lastClaimTick := A_TickCount
    Log("Lobby proof: clicked '" btn.text "'")
    SetStatus("📸 " Tx("Saved proof, clicked {1}", btn.text))
    return true
}

; ============================================================
; v7.7: known popups (no teaching needed) and the kicked-for-idle counter
; ============================================================
KnownPopup(lines, joined) {
    global clicks, lastProgress, idleKicksRun, totalIdleKicks
    static lastHit := 0
    if (!S["KNOWN_POPUPS"] || A_TickCount - lastHit < 8000)
        return false
    ctx := ""
    for w in ["DISCONNECTED", "CONNECTION LOST", "LOST CONNECTION", "SERVER NOT RESPONDING", "UNABLE TO CONNECT", "MATCHMAKING ERROR",
              "LOGIN FAILED", "REMOVED FROM THE MATCH", "REMOVED FROM MATCH", "REMOVED FROM THE GAME", "KICKED", "INACTIVITY",
              "IDLE TOO LONG", "SOMETHING WENT WRONG", "ERROR CODE", "TRY AGAIN LATER", "NETWORK ERROR", "SERVERS ARE"]
        if InStr(joined, w) {
            ctx := w
            break
        }
    if (ctx = "")
        return false
    btn := ""
    for want in ["RECONNECT", "TRY AGAIN", "RETRY", "OKAY", "OK", "CONTINUE", "RETURN TO LOBBY", "CLOSE"] {
        for ln in lines
            if (Trim(StrUpper(ln.text)) = want) {
                btn := ln
                break
            }
        if IsObject(btn)
            break
    }
    if !IsObject(btn)
        return false
    lastHit := A_TickCount
    idle := InStr(joined, "INACTIV") || InStr(joined, "IDLE") || InStr(joined, "AFK")
    if idle {
        idleKicksRun += 1
        totalIdleKicks += 1
        BumpWeek("IdleKicks")
        IniWrite(totalIdleKicks, STATS_FILE, "Stats", "IdleKicks")
        Log("Kicked for being idle (" idleKicksRun " this run)")
        if (idleKicksRun = 3) {
            Notify(Tx("Kicked for being idle"), Tx("3 times this run. Try the Chill profile or more movement."))
            Discord("⚠️ Kicked for being idle **3 times** this run. Try more movement (Settings > Play > Profile).")
        }
    } else {
        Log("Known popup: " ctx)
        if !SendScreenshot("⚠️ Fortnite popup (**" ctx "**), clicking " btn.text ":")
            Discord("⚠️ Fortnite popup (**" ctx "**), clicking " btn.text)
    }
    if !(running && WinActive(S["GAME_WINDOW"]))
        return true
    ReleaseAll()
    OwnMouse(), MouseMove(btn.x + btn.w // 2, btn.y + btn.h // 2, 5)
    Sleep(180)
    Click()
    clicks += 1
    lastProgress := A_TickCount
    SetStatus("🧩 " Tx("Closed a Fortnite popup ({1})", btn.text))
    return true
}

; ============================================================
; v7.7: Fortnite server status (status.epicgames.com), checked before reopening Fortnite
; ============================================================
; After an outage, Fortnite only counts as back after 2 good checks in a row (about 5 minutes)
ServersDown() {
    static wasDown := false, streak := 0, seen := 0
    if !S["CHECK_SERVERS"]
        return ""
    why := ServersDownRaw(wasDown)
    if (why != "") {
        if !wasDown {
            wasDown := true
            BumpWeek("Outages")
        }
        streak := 0, seen := serverFetches
        return why
    }
    if !wasDown
        return ""
    if (serverFetches != seen) {
        seen := serverFetches
        streak += 1
    }
    if (streak >= 2) {
        wasDown := false, streak := 0
        Log("Fortnite servers are back")
        Discord("✅ Fortnite servers are back. Resuming.")
        NtfyPush("Servers back", "Fortnite servers are back. Lobby Loop is resuming.", 3)
        return ""
    }
    return "checking the servers are really back"
}

ServersDownRaw(fast := false) {
    global serverFetches
    static cache := "", cacheTick := 0
    if (cacheTick && A_TickCount - cacheTick < (fast ? 150000 : 300000))
        return cache
    cacheTick := A_TickCount
    serverFetches += 1
    cache := ""
    res := HttpJson("GET", "https://status.epicgames.com/api/v2/summary.json")
    if (res.status != 200)
        return ""                                       ; can't tell: don't block anything
    t := res.text
    pos := 1
    while (pos := RegExMatch(t, '"name":"([^"]*)","status":"(\w+)"', &m, pos)) {
        pos += m.Len
        nm := StrUpper(m[1]), st := m[2]
        if (st = "major_outage" && (InStr(nm, "FORTNITE") || InStr(nm, "LOGIN") || InStr(nm, "MATCHMAKING") || InStr(nm, "GAME SERVICES")))
            return cache := m[1] " (major outage)"
    }
    pos := 1
    while (pos := RegExMatch(t, '"name":"([^"]*Fortnite[^"]*)","status":"(investigating|identified|in_progress|verifying)"', &m, pos)) {
        pos += m.Len
        return cache := m[1]
    }
    return ""
}

ServersDownNotice(why) {
    static lastSent := 0
    SetStatus("🛑 " Tx("Fortnite servers look down, waiting"))
    if (A_TickCount - lastSent > 1800000) {
        lastSent := A_TickCount
        Log("Fortnite servers look down: " why)
        Discord("🛑 Fortnite servers look down (**" why "**). Waiting instead of reopening Fortnite.")
        Notify(Tx("Fortnite servers look down"), why)
    }
}

; ============================================================
; v7.7: Fortnite's own settings file (window mode check and the FPS saver)
; ============================================================
FortniteConfig() {
    return EnvGet("LOCALAPPDATA") "\FortniteGame\Saved\Config\WindowsClient\GameUserSettings.ini"
}

FN_SECTION() => "/Script/FortniteGame.FortGameUserSettings"

; 0 = fullscreen, 1 = windowed fullscreen, 2 = windowed, "" = unknown
FortniteWindowMode() {
    cfg := FortniteConfig()
    if !FileExist(cfg)
        return ""
    v := IniRead(cfg, FN_SECTION(), "FullscreenMode", "")
    return IsNumber(v) ? Integer(v) : ""
}

WindowModeText() {
    m := FortniteWindowMode()
    return (m = 1) ? "✅ " Tx("Fortnite is on Windowed Fullscreen")
         : (m = 0) ? "⚠️ " Tx("Fortnite is on Fullscreen. Switch to Windowed Fullscreen (Settings > Display > Window Mode).")
         : (m = 2) ? "⚠️ " Tx("Fortnite is Windowed. Windowed Fullscreen works best.")
         : "• " Tx("Couldn't read Fortnite's settings file")
}

CheckWindowModeOnce() {
    if (IniRead(STATS_FILE, "Stats", "WindowModeWarned", "") = FormatTime(, "yyyyMMdd"))
        return
    if (FortniteWindowMode() = 0 || FortniteWindowMode() = 2) {
        IniWrite(FormatTime(, "yyyyMMdd"), STATS_FILE, "Stats", "WindowModeWarned")
        Notify(Tx("Fortnite window mode"), WindowModeText())
        Log("Window mode warning: " FortniteWindowMode())
    }
}

; FPS saver: 30 FPS while Lobby Loop runs. Fortnite only reads the file when it starts and writes
; it back when it closes, so the limit is set while Fortnite is closed (before Lobby Loop opens it)
; and your own value is put back once Fortnite has closed after the run.
FpsApply() {
    global fpsWaiting
    if !S["FPS_SAVER"]
        return false
    cfg := FortniteConfig()
    if !FileExist(cfg)
        return false
    if ProcessExist(GameExe()) {
        if (IniRead(cfg, FN_SECTION(), "FrameRateLimit", "") != "30.000000")
            fpsWaiting := true                          ; applies the next time Lobby Loop opens Fortnite
        return false
    }
    if (IniRead(STATS_FILE, "FpsSaver", "Original", "__none__") = "__none__")
        IniWrite(IniRead(cfg, FN_SECTION(), "FrameRateLimit", "0.000000"), STATS_FILE, "FpsSaver", "Original")
    try {
        IniWrite("30.000000", cfg, FN_SECTION(), "FrameRateLimit")
        fpsWaiting := false
        Log("FPS saver: Fortnite set to 30 FPS (yours is saved)")
        return true
    } catch as e {
        Log("FPS saver couldn't write Fortnite's settings: " e.Message)
    }
    return false
}

FpsRestoreTick() {
    if running
        return                                          ; keep 30 FPS while running
    if ProcessExist(GameExe())
        return                                          ; Fortnite writes its settings when it closes: wait
    orig := IniRead(STATS_FILE, "FpsSaver", "Original", "__none__")
    SetTimer(FpsRestoreTick, 0)
    if (orig = "__none__")
        return
    try {
        IniWrite(orig, FortniteConfig(), FN_SECTION(), "FrameRateLimit")
        IniDelete(STATS_FILE, "FpsSaver", "Original")
        Log("FPS saver: your Fortnite frame limit is back (" orig ")")
    } catch as e {
        Log("FPS saver couldn't restore: " e.Message)
    }
}

FpsRestoreLater() {
    if (IniRead(STATS_FILE, "FpsSaver", "Original", "__none__") != "__none__")
        SetTimer(FpsRestoreTick, 5000)
}

; ============================================================
; v7.7: laptop battery guard
; ============================================================
BatteryStatus() {
    buf := Buffer(12, 0)
    if !DllCall("GetSystemPowerStatus", "Ptr", buf)
        return 0
    flag := NumGet(buf, 1, "UChar")
    return {onBattery: NumGet(buf, 0, "UChar") = 0, percent: NumGet(buf, 2, "UChar"), noBattery: (flag = 128 || flag = 255)}
}

BatteryCheck() {
    if (!S["BATTERY_GUARD"] || !running)
        return
    b := BatteryStatus()
    if (!IsObject(b) || b.noBattery || !b.onBattery || b.percent > Number(S["BATTERY_MIN"]))
        return
    Log("Battery low: " b.percent "% on battery")
    Discord("🔋 Battery at **" b.percent "%** and not charging. Stopping" (S["BATTERY_SLEEP"] ? " and putting the PC to sleep." : "."))
    ToggleRun("battery " b.percent "%")
    SetStatus("🔋 " Tx("Stopped: battery {1}%", b.percent))
    if S["BATTERY_SLEEP"]
        StartPowerAction("sleep")
}

SettingsUpdateWords(g) {
    ok := UpdateTreasureWords(true)
    g.Destroy()
    OpenSettings(6)
    if !ok
        ShowTip(Tx("Couldn't download the treasure words. Check your internet."), 3500)
}

; ============================================================
; v7.7: weekly prize checklist (names from treasure_words.txt, taken from fnchesttracker.com)
;   prizes_3=Solid Gold Miku|Outfit;Miku's Takarabako|Back bling;...
; ============================================================
PrizeWeek() {
    v := IniRead(STATS_FILE, "WeeklyPrizes", "Week", 0)
    return IsNumber(v) ? Integer(v) : 0
}

PrizeList(week) {
    out := []
    for item in StrSplit(IniRead(STATS_FILE, "WeeklyPrizes", "W" week, ""), ";", " `t") {
        p := StrSplit(item, "|", " `t")
        if (p.Length && p[1] != "")
            out.Push({name: p[1], type: p.Length >= 2 ? p[2] : "Prize"})
    }
    return out
}

PrizeKey(text) => RegExReplace(StrUpper(text), "[^A-Z0-9]")   ; ignores spaces, ' and - so OCR slips still match

PrizesText(week) {
    if !week
        return Tx("Comes with the online treasure words.")
    out := ""
    for p in PrizeList(week)
        out .= (out = "" ? "" : "`n") (PrizeOwned(p.name) ? "✅ " : "⬜ ") p.name "  (" p.type ")"
    return out != "" ? out : Tx("Comes with the online treasure words.")
}

; If the found text names a weekly prize, tick it off. Returns {name, type, week, got, total} or "".
MarkPrize(text) {
    key := PrizeKey(text)
    hit := ""
    loop PrizeWeek() {
        wk := PrizeWeek() - A_Index + 1                 ; this week first
        for p in PrizeList(wk)
            if (StrLen(PrizeKey(p.name)) >= 4 && InStr(key, PrizeKey(p.name))) {
                hit := {name: p.name, type: p.type, week: wk}
                break
            }
        if IsObject(hit)
            break
    }
    if !IsObject(hit)
        return ""
    IniWrite(FormatTime(, "yyyy-MM-dd HH:mm"), STATS_FILE, "PrizesFound", PrizeKey(hit.name))
    got := 0, total := 0
    for p in PrizeList(hit.week) {
        total += 1
        if (IniRead(STATS_FILE, "PrizesFound", PrizeKey(p.name), "") != "")
            got += 1
    }
    hit.got := got, hit.total := total
    Log("Weekly prize found: " hit.name " (week " hit.week ", " got "/" total ")")
    return hit
}

; ============================================================
; v7.7: Return to lobby instead of Play Again (prize banners and claim screens only show in the lobby)
; ============================================================
ReturnToLobbyClick() {
    global clicks
    labels := ["RETURN TO LOBBY", "BACK TO LOBBY", "LEAVE MATCH", "RETURN TO THE LOBBY"]
    confirms := ["CONFIRM", "YES", "LEAVE", "LEAVE MATCH", "RETURN TO LOBBY"]
    clickLine(ln) {
        global clicks
        ReleaseAll()
        OwnMouse(), MouseMove(ln.x + ln.w // 2, ln.y + ln.h // 2, 5)
        Sleep(180)
        Click()
        clicks += 1
    }
    findLine(words) {
        for ln in OcrRegionSync(MON_X, MON_Y, MON_W, MON_H) {
            u := Trim(StrUpper(ln.text))
            for w in words
                if (u = w)
                    return ln
        }
        return ""
    }
    ln := findLine(labels)
    viaMenu := false
    if !IsObject(ln) {                                  ; not on the end screen: try the Esc menu
        Send("{Esc}")
        Sleep(1300)
        ln := findLine(labels)
        viaMenu := true
    }
    if !IsObject(ln) {
        if viaMenu
            Send("{Esc}")                               ; close the menu again, Play Again it is
        Log("Return to lobby: button not found, using Play Again")
        return false
    }
    clickLine(ln)
    Log("Clicked '" ln.text "'" (viaMenu ? " (Esc menu)" : ""))
    Sleep(1300)
    if IsObject(ok := findLine(confirms)) {             ; "Are you sure?"
        clickLine(ok)
        Log("Confirmed '" ok.text "'")
    }
    return true
}

LobbyNoteText(returnOn) {
    return "🏠 " Tx("Needs Return to lobby (Settings > Play > After a match)") (returnOn ? "  ✅" : "  ⚠️ " Tx("now: Play Again"))
}

UpdateLobbyNotes(notes, returnOn) {
    for t in notes
        t.Value := LobbyNoteText(returnOn)
}


; ============================================================
; v7.8: data folder (keeps the Desktop / script folder tidy)
; ============================================================
MoveDataFiles(dataDir) {
    moved := 0
    for suffix in ["_settings.ini", "_stats.ini", "_popups.ini", "_history.csv", ".log", "_matches.csv", "_dashboard.html",
                   "_treasure.csv", "_screen_text.txt", "_teammates.csv"] {
        src := A_ScriptDir "\" BASE suffix, dst := dataDir "\" BASE suffix
        if (FileExist(src) && !FileExist(dst)) {
            try {
                FileMove(src, dst)
                moved += 1
            }
        }
    }
    src := A_ScriptDir "\" BASE "_treasure_proof"
    if (DirExist(src) && !DirExist(dataDir "\" BASE "_treasure_proof"))
        try DirMove(src, dataDir "\" BASE "_treasure_proof")
    return moved
}

; ============================================================
; v7.8: weekly counters (idle kicks, Sleep Mode wakes, empty squads...) for the recap
; ============================================================
WeekKey(daysAgo := 0) => FormatTime(DateAdd(A_Now, -daysAgo, "Days"), "YWeek")

BumpWeek(name, by := 1) {
    k := "Week_" WeekKey()
    IniWrite(Integer(IniRead(STATS_FILE, k, name, 0)) + by, STATS_FILE, k, name)
}

WeekCount(name) => Integer(IniRead(STATS_FILE, "Week_" WeekKey(), name, 0))

; ============================================================
; v7.8: one-click overnight treasure farm preset
; ============================================================
OvernightPreset() => [["LOBBY_AFTER_MATCH", 1, "After a match: Return to lobby"], ["WAIT_FOR_SQUAD", 1, "Don't leave while teammates play"],
    ["WATCH_TREASURE", 1, "Watch for treasure"], ["TREASURE_ONLINE", 1, "Online treasure words"], ["TREASURE_PROOF", 1, "Lobby proof + Claim"],
    ["TREASURE_STOP", "token", "Stop after finding Pirate Shop Access"], ["MODE_FILL", "fill", "Team Fill check: Fill"],
    ["WAKE_FROM_SLEEP", 1, "Wake from Sleep Mode"], ["KNOWN_POPUPS", 1, "Known popups"], ["CHECK_SERVERS", 1, "Server check + auto-resume"],
    ["LAUNCH_FORTNITE", 1, "Reopen Fortnite if it closes"], ["KEEP_AWAKE", 1, "Keep the PC awake"], ["FPS_SAVER", 1, "FPS saver (30 FPS)"],
    ["SPECTATE_IDLE", 1, "Stand still while spectating"], ["WEEKLY_RECAP", 1, "Weekly Discord recap"]]

ApplyOvernightPreset(g := 0) {
    list := ""
    for p in OvernightPreset()
        list .= "•  " Tx(p[3]) "`n"
    opts := "YesNo Iconi" (IsObject(g) ? " Owner" g.Hwnd : "")
    if (MsgBox(Tx("Turn on the overnight treasure farm settings?") "`n`n" list "`n" Tx("Your stop timer, stop action and keys stay the same."), TITLE, opts) != "Yes")
        return
    for p in OvernightPreset()
        SetSetting(p[1], p[2])
    Log("Overnight treasure farm preset applied")
    if IsObject(g) {
        g.Destroy()
        OpenSettings(1)
    }
    ShowTip("🌙 " Tx("Overnight treasure farm is set."), 3000)
}

; ============================================================
; v7.8: weekly recap and the friends leaderboard
; ============================================================
WeeklyRecapText() {
    st := WeekStats()
    cats := Map("token", 0, "gizmo", 0, "cosmetic", 0, "custom", 0)
    from := FormatTime(DateAdd(A_Now, -6, "Days"), "yyyy-MM-dd")
    for r in ReadCsvRows(TREASURE_FILE)
        if (r.Length >= 4 && StrCompare(r[1], from) >= 0 && cats.Has(r[3]))
            cats[r[3]] += 1
    tm := TeammateSummary(7)
    wk := PrizeWeek()
    pr := PrizeProgress(wk)
    msg := "🗓️ **Weekly recap for " PlayerName() "**`n"
        . "🎮 Matches: **" st.matches "**   ·   ⏱️ Time: **" Floor(st.minutes / 60) "h " Mod(Round(st.minutes), 60) "m**`n"
        . "🏴‍☠️ Treasure: **" st.treasures "** (Pirate Shop Access " cats["token"] ", gizmos " cats["gizmo"] ", cosmetics " cats["cosmetic"] ")`n"
    if wk
        msg .= "🎁 Week " wk " prizes: **" pr.got "/" pr.total "** found or owned`n"
    if tm.matches
        msg .= "🤝 Teammates per match: **" tm.avg "** (no teammates in " tm.zero " of " tm.matches " matches)`n"
    msg .= "😴 Sleep Mode wakes: " WeekCount("SleepWakes") "   ·   💤 Idle kicks: " WeekCount("IdleKicks")
        . "   ·   🚪 Empty squads left: " WeekCount("EmptyLeaves") "   ·   🛑 Outage waits: " WeekCount("Outages")
    return msg "`n" LeaderboardLine()
}

WeeklyRecapCheck() {
    if (!S["WEEKLY_RECAP"] || !DiscordReady() || A_WDay != 1 || A_Hour < 20)   ; Sundays, 8 PM
        return
    if (IniRead(STATS_FILE, "Stats", "LastRecap", "") = FormatTime(, "yyyyMMdd"))
        return
    IniWrite(FormatTime(, "yyyyMMdd"), STATS_FILE, "Stats", "LastRecap")
    Log("Weekly recap")
    Discord(WeeklyRecapText())
    LbCardUpdate(true)
}

; Each friend's PC keeps ONE card in the shared channel and edits it (a webhook can only edit its own messages)
LbCardText() {
    st := WeekStats()
    pr := PrizeProgress(PrizeWeek())
    return "🏆 **" PlayerName() "**   ·   this week: **" st.matches "** matches, **" Round(st.minutes / 60, 1) " h**, **"
        . st.treasures "** treasure" (PrizeWeek() ? ", prizes **" pr.got "/" pr.total "**" : "")
        . "   ·   all time: " totalMatches " matches, " Round(totalMinutes / 60, 1) " h"
        . "`n-# updated " FormatTime(, "ddd h:mm tt") "   " LeaderboardLine()
}

LbCardUpdate(force := false) {
    static lastTick := 0
    hook := Trim(String(S["LEADERBOARD_WEBHOOK"]))
    if (hook = "" || !IsDiscordUrl(hook))
        return false
    if (!force && A_TickCount - lastTick < 1800000)       ; every 30 minutes
        return false
    lastTick := A_TickCount
    body := '{"username":"' JsonEscape(SubStr("Lobby Loop · " PlayerName(), 1, 80)) '","avatar_url":"' ICON_URL '","content":"' JsonEscape(SubStr(LbCardText(), 1, 1990)) '"}'
    hookKey := SubStr(RegExReplace(hook, "[^0-9]"), 1, 20)
    id := IniRead(STATS_FILE, "Leaderboard", "Msg_" hookKey, "")
    if (id != "") {
        res := HttpJson("PATCH", RegExReplace(hook, "\?.*$") "/messages/" id, body)
        if (res.status >= 200 && res.status < 300)
            return true
        if (res.status != 404)
            return false                                   ; rate limit or network: try again later
    }
    res := HttpJson("POST", RegExReplace(hook, "\?.*$") "?wait=true", body)
    if (res.status >= 200 && res.status < 300 && RegExMatch(res.text, '"id"\s*:\s*"(\d+)"', &m)) {
        IniWrite(m[1], STATS_FILE, "Leaderboard", "Msg_" hookKey)
        Log("Leaderboard card posted")
        return true
    }
    Log("Leaderboard card failed: " res.status)
    return false
}

; Channel the leaderboard reads: the shared webhook's channel if there is one, else the phone-control channel
LeaderboardChannel() {
    static cache := Map()
    hook := Trim(String(S["LEADERBOARD_WEBHOOK"]))
    if (hook = "" || !IsDiscordUrl(hook))
        return Trim(String(S["DISCORD_CHANNEL_ID"]))
    if cache.Has(hook)
        return cache[hook]
    res := HttpJson("GET", RegExReplace(hook, "\?.*$"))
    ch := RegExMatch(res.text, '"channel_id"\s*:\s*"(\d+)"', &m) ? m[1] : Trim(String(S["DISCORD_CHANNEL_ID"]))
    cache[hook] := ch
    return ch
}

; ============================================================
; v7.8: squad list (top left): empty squad check and teammate stats  (EXPERIMENTAL)
; Counts the name rows in the squad list. Rows that are "just me" = SQUAD_MIN_ROWS.
; ============================================================
SquadRegion() {
    p := StrSplit(String(S["SQUAD_REGION"]), ",", " ")
    if (p.Length != 4)
        p := [0, 0.06, 0.20, 0.42]
    return {x: MON_X + Round(p[1] * MON_W), y: MON_Y + Round(p[2] * MON_H), x2: MON_X + Round(p[3] * MON_W), y2: MON_Y + Round(p[4] * MON_H)}
}

SquadRows(lines) {
    r := SquadRegion()
    ys := []
    for ln in lines {
        cx := ln.x + ln.w // 2, cy := ln.y + ln.h // 2
        if (cx < r.x || cx > r.x2 || cy < r.y || cy > r.y2)
            continue
        letters := RegExReplace(ln.text, "[^A-Za-z]")
        if (StrLen(letters) < 3)                            ; skip health numbers and icons
            continue
        dupe := false
        for y in ys
            if (Abs(y - cy) < Max(14, ln.h))
                dupe := true
        if !dupe
            ys.Push(cy)
    }
    return ys.Length
}

OnMatchStart() {
    global squadMatchTick, squadBaseline, squadLowSince, squadLeft
    squadMatchTick := A_TickCount, squadBaseline := 0, squadLowSince := 0, squadLeft := false
}

SquadCheck(lines) {
    global squadBaseline, squadLowSince, squadLeft, backToLobbyUntil
    if (!running || gameState != "match" || !squadMatchTick || squadLeft)
        return
    age := A_TickCount - squadMatchTick
    if (age < 90000)                                        ; still loading in
        return
    rows := SquadRows(lines)
    squadBaseline := Max(squadBaseline, rows)
    if !S["EMPTY_SQUAD"]
        return
    minRows := Integer(S["SQUAD_MIN_ROWS"])
    why := ""
    if (age > 150000 && squadBaseline <= minRows)
        why := "no teammates"
    else if (squadBaseline > minRows && rows <= minRows) {
        if !squadLowSince
            squadLowSince := A_TickCount
        else if (A_TickCount - squadLowSince >= Number(S["SQUAD_LEAVE_SEC"]) * 1000)
            why := "all teammates left"
    } else {
        squadLowSince := 0
    }
    if (why = "")
        return
    squadLeft := true
    Log("Empty squad (" why "): leaving the match")
    BumpWeek("EmptyLeaves")
    SetStatus("🚪 " Tx("Nobody left to farm, leaving the match"))
    Discord("🚪 " (why = "no teammates" ? "Got **no teammates**" : "**All teammates left**") ", leaving the match to find a new squad.")
    if ReturnToLobbyClick() {
        backToLobbyUntil := A_TickCount + 45000
        RecordTeammates(true)
    }
}

RecordTeammates(leftEarly := false) {
    static lastMatchTick := 0
    if (!squadMatchTick || squadMatchTick = lastMatchTick || squadBaseline = 0)
        return
    lastMatchTick := squadMatchTick
    mates := Max(0, squadBaseline - Integer(S["SQUAD_MIN_ROWS"]))
    if !FileExist(TEAMMATES_FILE)
        try FileAppend("Date,Time,Hour,Teammates,LeftEarly`r`n", TEAMMATES_FILE, "UTF-8")
    try FileAppend(FormatTime(, "yyyy-MM-dd") "," FormatTime(, "HH:mm") "," A_Hour "," mates "," (leftEarly ? 1 : 0) "`r`n", TEAMMATES_FILE, "UTF-8")
}

TeammateSummary(days := 30) {
    from := FormatTime(DateAdd(A_Now, -(days - 1), "Days"), "yyyy-MM-dd")
    out := {matches: 0, sum: 0, zero: 0, avg: 0, best: ""}
    byHour := Map()
    for r in ReadCsvRows(TEAMMATES_FILE) {
        if (r.Length < 4 || StrCompare(r[1], from) < 0 || !IsNumber(r[4]))
            continue
        out.matches += 1, out.sum += r[4]
        if (r[4] = 0)
            out.zero += 1
        h := Integer(r[3])
        if !byHour.Has(h)
            byHour[h] := [0, 0]
        byHour[h][1] += r[4], byHour[h][2] += 1
    }
    if out.matches
        out.avg := Round(out.sum / out.matches, 1)
    bestAvg := -1
    for h, v in byHour
        if (v[2] >= 3 && v[1] / v[2] > bestAvg)
            bestAvg := v[1] / v[2], out.best := Format("{:02}:00", h)
    return out
}

TeammateStatsText() {
    t := TeammateSummary(30)
    if !t.matches
        return Tx("No teammate counts yet (turn on the empty squad check, or play a few matches).")
    return Tx("Last 30 days: {1} teammates per match on average, no teammates in {2} of {3} matches.", t.avg, t.zero, t.matches)
        . (t.best != "" ? "`n" Tx("Best hour for full squads: around {1}.", t.best) : "")
}

ShowSquadTest(waitMs := 3000) {
    ShowTip(Tx("Click into Fortnite (in a match). Checking in {1} seconds...", waitMs // 1000), waitMs - 300)
    Sleep(waitMs)
    r := SquadRegion()
    lines := OcrRegionSync(r.x, r.y, r.x2 - r.x, r.y2 - r.y)
    rows := SquadRows(lines)
    list := [["👥", Tx("Rows in the squad list: {1}", rows)], ["•", Tx("Counts as only you: {1} or fewer", S["SQUAD_MIN_ROWS"]), true]]
    for ln in lines
        if (list.Length < 10)
            list.Push(["•", ln.text, true])
    ShowCard("👥 " Tx("Squad list test"), list, 12000, Tx("Send me a screenshot of the squad list if the count looks wrong."))
}

; ============================================================
; v7.8: phone push alerts through ntfy (free app, no account: pick a topic name nobody can guess)
; ============================================================
NtfyPush(heading, msg, priority := 3, tags := "") {
    topic := Trim(String(S["NTFY_TOPIC"]))
    if (topic = "")
        return false
    server := RTrim(Trim(String(S["NTFY_SERVER"])) != "" ? Trim(String(S["NTFY_SERVER"])) : "https://ntfy.sh", "/")
    try {
        n := StrPut(msg, "UTF-8") - 1
        buf := Buffer(n + 1)
        StrPut(msg, buf, "UTF-8")
        arr := ComObjArray(0x11, Max(n, 1))
        loop n
            arr[A_Index - 1] := NumGet(buf, A_Index - 1, "UChar")
        req := ComObject("WinHttp.WinHttpRequest.5.1")
        req.SetTimeouts(3000, 3000, 4000, 5000)
        req.Open("POST", server "/" topic, false)
        req.SetRequestHeader("Title", RegExReplace(TITLE " - " heading, "[^\x20-\x7E]"))   ; headers: plain text only
        req.SetRequestHeader("Priority", String(priority))
        if (tags != "")
            req.SetRequestHeader("Tags", tags)
        req.SetRequestHeader("Content-Type", "text/plain; charset=utf-8")
        req.Send(arr)
        return req.Status >= 200 && req.Status < 300
    } catch as e {
        Log("ntfy failed: " e.Message)
    }
    return false
}

; ============================================================
; v7.8: prizes you already own (a repeat prize gives nothing, only gizmos repeat)
; ============================================================
PrizeOwned(name) => IniRead(STATS_FILE, "PrizesFound", PrizeKey(name), "") != "" || IniRead(STATS_FILE, "PrizesOwned", PrizeKey(name), "") != ""

PrizeProgress(week) {
    got := 0, total := 0
    if week
        for p in PrizeList(week) {
            total += 1
            if PrizeOwned(p.name)
                got += 1
        }
    return {got: got, total: total}
}

ShowOwnedPicker(owner := 0) {
    wk := PrizeWeek()
    if !wk {
        ShowTip(Tx("The prize list comes with the online treasure words. Press Update the words now first."), 3500)
        return
    }
    g := ThemeGui(TITLE " - " Tx("Prizes I already own"))
    UiText(g, "x20 y16 w480", Tx("Tick what's already in your Locker. A repeat prize gives you nothing, so Lobby Loop tells you when only gizmos and Pirate Shop Access are left."), "muted")
    boxes := []
    loop wk {
        w := wk - A_Index + 1
        UiText(g, "x20 y+12 w480", Tx("Week {1}", w), "head")
        for p in PrizeList(w) {
            b := UiCheck(g, "x20 y+6", p.name "  (" p.type ")", PrizeOwned(p.name), 440)
            boxes.Push([p.name, b[1]])
        }
    }
    sb := UiButton(g, "x20 y+16 w140 Default", Tx("Save"))
    sb.OnEvent("Click", (*) => SaveOwned(g, boxes))
    cb := UiButton(g, "x+10 yp w140", Tx("Cancel"))
    cb.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())
    if owner
        g.Opt("+Owner" owner)
    g.Show("w520")
}

SaveOwned(g, boxes) {
    for b in boxes {
        if b[2].Value
            IniWrite(1, STATS_FILE, "PrizesOwned", PrizeKey(b[1]))
        else
            try IniDelete(STATS_FILE, "PrizesOwned", PrizeKey(b[1]))
    }
    g.Destroy()
    ShowTip(Tx("Saved."), 2000)
    OwnedNotice(true)
}

; Once a week: tell the user when they own every cosmetic prize of this week
OwnedNotice(now := false) {
    wk := PrizeWeek()
    if !wk
        return
    pr := PrizeProgress(wk)
    if (!pr.total || pr.got < pr.total)
        return
    if (!now && IniRead(STATS_FILE, "Stats", "OwnedNotice", "") = WeekKey() "_" wk)
        return
    IniWrite(WeekKey() "_" wk, STATS_FILE, "Stats", "OwnedNotice")
    msg := Tx("You own all of week {1}'s prizes. Only gizmos and Pirate Shop Access can still drop for you this week.", wk)
    Notify("🎁 " Tx("All prizes owned"), msg)
    Discord("🎁 " msg)
}

; ============================================================
; v7.8: odds calculator (Epic's official per-chest odds, 7 Nov 2026)
; ============================================================
ShowOddsCalc(owner := 0) {
    g := ThemeGui(TITLE " - " Tx("Odds calculator"))
    hrs := Round(Max(1, totalMinutes / 60 / Max(1, Integer(IniRead(STATS_FILE, "Stats", "Runs", 1)))), 1)
    mph := (totalMinutes > 60) ? Round(totalMatches / (totalMinutes / 60), 1) : 2.5
    daysLeft := Max(1, DateDiff("20261205235959", A_Now, "Days") + 1)
    UiText(g, "x20 y16 w520", Tx("A rough guess of what your squad's chests could give you. Epic says every player has the same odds per chest. Lobby Loop doesn't change them."), "muted")
    fields := [["hours", Tx("Hours per night"), Min(hrs, 12)], ["nights", Tx("Nights left"), daysLeft], ["mph", Tx("Matches per hour"), mph],
               ["chests", Tx("Chests your squad opens per match (guess)"), 15]]
    ed := Map()
    for f in fields {
        UiText(g, "x20 y+12 w300", f[2])
        ed[f[1]] := UiEdit(g, "x330 yp-3 w120 r1", f[3])
    }
    out := UiText(g, "x20 y+16 w520 r8", "")
    calc(*) {
        n := 1
        for k in ["hours", "nights", "mph", "chests"] {
            v := Trim(ed[k].Value)
            n *= IsNumber(v) ? Max(0, Number(v)) : 0
        }
        n := Round(n)
        p(oneIn) => Round((1 - (1 - 1 / oneIn) ** n) * 100, n > 0 && oneIn > 100000 ? 2 : 0)
        out.Value := Tx("About {1} chests.", FormatNumber(n)) "`n"
            . "🧭 " Tx("Gizmos: about {1}", Round(n / 127)) "`n"
            . "🖼️ " Tx("A loading screen: {1}%", p(272)) "    🎵 " Tx("A Jam Track: {1}%", p(391)) "`n"
            . "⛏️ " Tx("A pickaxe or back bling: {1}%", p(568)) "    🚗 " Tx("A car: {1}%", p(7813)) "`n"
            . "🏴‍☠️ " Tx("Pirate Shop Access: {1}%", p(137500)) "    👑 " Tx("Gold outfit: {1}%", p(1562500)) "`n`n"
            . Tx("Odds: 1 in 127 gizmo, 272 loading screen, 391 Jam Track, 568 pickaxe/back bling, 7,813 car, 137,500 Pirate Shop Access, 1,562,500 Gold outfit (Epic, 7 Nov 2026). Treasure Hours raise some of them.")
    }
    for _, e in ed
        e.OnEvent("Change", calc)
    calc()
    cb := UiButton(g, "x20 y+12 w140 Default", Tx("Close"))
    cb.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())
    if owner
        g.Opt("+Owner" owner)
    g.Show("w560")
}

; ============================================================
; v7.8: game language check (all screen reading uses English words)
; ============================================================
GameLanguage() {
    cfg := FortniteConfig()
    if !FileExist(cfg)
        return ""
    v := IniRead(cfg, "Internationalization", "Culture", "")
    if (v = "")
        try if RegExMatch(FileRead(cfg), "im)^\s*Culture\s*=\s*([A-Za-z\-]+)", &m)
            v := m[1]
    return v                                               ; "" = not set (Fortnite follows Windows)
}

LanguageOk() {
    v := GameLanguage()
    return (v = "") ? "" : (SubStr(StrLower(v), 1, 2) = "en")
}

CheckLanguageOnce() {
    if (LanguageOk() != false)
        return
    if (IniRead(STATS_FILE, "Stats", "LanguageWarned", "") = FormatTime(, "yyyyMMdd"))
        return
    IniWrite(FormatTime(, "yyyyMMdd"), STATS_FILE, "Stats", "LanguageWarned")
    Notify(Tx("Fortnite language"), Tx("Fortnite is set to '{1}'. Lobby Loop reads English words, so set Fortnite to English (Settings > Game > Language).", GameLanguage()))
}

; ============================================================
; v7.8: auto-clean and low disk warning
; ============================================================
CleanData(manual := false) {
    static lastRun := 0
    if (!manual && lastRun && A_TickCount - lastRun < 86400000)
        return
    lastRun := A_TickCount
    removed := 0
    ; proof screenshots
    pd := Integer(S["CLEAN_PROOF_DAYS"])
    if (pd > 0) {
        limit := DateAdd(A_Now, -pd, "Days")
        loop files DATA_DIR "\" BASE "_treasure_proof\*.png" {
            if (A_LoopFileTimeModified < limit) {
                try FileDelete(A_LoopFileFullPath)
                removed += 1
            }
        }
    }
    ; old rows in the match / run / teammate lists (treasure finds are always kept)
    days := Integer(S["CLEAN_DAYS"])
    if (days > 0) {
        from := FormatTime(DateAdd(A_Now, -Max(14, days), "Days"), "yyyy-MM-dd")
        for f in [MATCHES_FILE, HISTORY_FILE, TEAMMATES_FILE] {
            if !FileExist(f)
                continue
            txt := FileRead(f, "UTF-8"), out := "", cut := 0
            for i, line in StrSplit(txt, "`n", "`r") {
                if (line = "")
                    continue
                if (i > 1 && RegExMatch(line, "^(\d{4}-\d{2}-\d{2})", &m) && StrCompare(m[1], from) < 0) {
                    cut += 1
                    continue
                }
                out .= line "`r`n"
            }
            if cut {
                try {
                    FileDelete(f)
                    FileAppend(out, f, "UTF-8")
                    removed += cut
                }
            }
        }
    }
    ; log size
    maxMB := Max(1, Number(S["LOG_MAX_MB"]))
    if (FileExist(LOG_FILE) && FileGetSize(LOG_FILE) > maxMB * 1048576) {
        try {
            t := FileRead(LOG_FILE, "UTF-8")
            t := SubStr(t, StrLen(t) // 2)
            FileDelete(LOG_FILE)
            FileAppend("(older lines removed by auto-clean)`r`n" t, LOG_FILE, "UTF-8")
            removed += 1
        }
    }
    if removed
        Log("Auto-clean removed " removed " old items")
    if manual
        ShowTip(Tx("Cleaned {1} old items.", removed), 2500)
}

DiskCheck() {
    static lastWarn := 0
    minGB := Number(S["DISK_MIN_GB"])
    if (minGB <= 0 || (lastWarn && A_TickCount - lastWarn < 21600000))
        return
    for path in [DATA_DIR, ClipFolder()] {
        try free := DriveGetSpaceFree(SubStr(path, 1, 3))
        catch
            continue
        if (free < minGB * 1024) {
            lastWarn := A_TickCount
            msg := Tx("Only {1} GB free on {2}.", Round(free / 1024, 1), SubStr(path, 1, 2)) (S["TREASURE_CLIP"] ? " " Tx("Clips may fail to save.") : "")
            Log("Low disk: " msg)
            Notify("💾 " Tx("Low disk space"), msg)
            Discord("💾 " msg)
            return
        }
    }
}

; ============================================================
; v7.8: settings search
; ============================================================
SettingsSearch(box, pages, navs, *) {
    q := Trim(box.Value)
    if (StrLen(q) < 2)
        return
    hits := []
    for i, pg in pages {
        for ctrl in pg {
            try t := ctrl.Text
            catch
                continue
            if InStr(t, q) {
                hits.Push(i)
                break
            }
        }
    }
    for i, n in navs                                       ; pages with a match get a dot
        n.Text := RegExReplace(n.Text, "  •$") (HasValue(hits, i) ? "  •" : "")
    if hits.Length
        SettingsNav(hits[1], pages, navs)
}

HasValue(arr, v) {
    for x in arr
        if (x = v)
            return true
    return false
}

; ============================================================
; v7.8: first-run checklist (+ the trust panel)
; ============================================================
TRUST_TEXT() => Tx("Lobby Loop is free and open source (github.com/yensobased1/lobby-loop). It has no login, no remote access and never asks for your Epic password. Your Discord links stay in your settings file on this PC. It does not change your odds: Epic gives every player the same odds per chest. Epic's rules ban cheats and exploits and can ban accounts, so use it at your own risk.")

ShowChecklist(owner := 0) {
    IniWrite(1, STATS_FILE, "Stats", "ChecklistShown")
    g := ThemeGui(TITLE " - " Tx("Setup checklist"))
    UiText(g, "x20 y16 w600", "📋 " Tx("Setup checklist"), "title")
    wm := FortniteWindowMode(), lang := LanguageOk()
    items := [
        [wm = 1, Tx("Fortnite on Windowed Fullscreen"), wm = 1 ? "" : Tx("Set it"), (*) => FixWindowMode(g)],
        [lang != false, Tx("Fortnite language: {1}", GameLanguage() != "" ? GameLanguage() : Tx("same as Windows")), "", ""],
        ["?", Tx("Fortnite Sleep Mode: Never (Settings > Game > Energy Saving)"), "", ""],
        [StrLower(S["MODE_FILL"]) = "fill", Tx("Team Fill check: Fill"), StrLower(S["MODE_FILL"]) = "fill" ? "" : Tx("Turn on"), (*) => (SetSetting("MODE_FILL", "fill"), g.Destroy(), ShowChecklist())],
        [S["LOBBY_AFTER_MATCH"] = 1, Tx("After a match: Return to lobby (prize screens)"), S["LOBBY_AFTER_MATCH"] ? "" : Tx("Turn on"), (*) => (SetSetting("LOBBY_AFTER_MATCH", 1), g.Destroy(), ShowChecklist())],
        [DiscordReady() || Trim(S["NTFY_TOPIC"]) != "", Tx("Alerts on your phone (Discord or ntfy)"), Tx("Set up"), (*) => (g.Destroy(), OpenSettings(10))],
        [A_IsAdmin = 1, Tx("Running as Administrator"), A_IsAdmin ? "" : Tx("Restart as admin"), (*) => RestartAsAdmin()],
        ["?", Tx("Keys: {1} start / stop, {2} settings, {3} self-test", HK_TOGGLE, HK_SETTINGS, HK_TEST), Tx("Change"), (*) => (g.Destroy(), OpenSettings(8))]]
    for it in items {
        icon := (it[1] = "?") ? "•" : (it[1] ? "✅" : "⚠️")
        UiText(g, "x20 y+10 w30", icon)
        UiText(g, "x50 yp w430", it[2])
        if (it[3] != "") {
            b := UiButton(g, "x490 yp-4 w130", it[3])
            b.OnEvent("Click", it[4])
        }
    }
    UiText(g, "x20 y+18 w600", "🛡️ " Tx("Trust"), "head")
    UiText(g, "x20 y+4 w600", TRUST_TEXT(), "muted")
    ob := UiButton(g, "x20 y+16 w260", "🌙 " Tx("Overnight treasure farm"))
    ob.OnEvent("Click", (*) => (g.Destroy(), ApplyOvernightPreset()))
    cb := UiButton(g, "x+10 yp w140 Default", Tx("Close"))
    cb.OnEvent("Click", (*) => g.Destroy())
    g.OnEvent("Escape", (*) => g.Destroy())
    if owner
        g.Opt("+Owner" owner)
    g.Show("w640")
}

FixWindowMode(g) {
    if ProcessExist(GameExe()) {
        MsgBox(Tx("Close Fortnite first, then press Set it again. (Or in Fortnite: Settings > Display > Window Mode > Windowed Fullscreen.)"), TITLE, "Iconi Owner" g.Hwnd)
        return
    }
    try {
        for k in ["FullscreenMode", "LastConfirmedFullscreenMode", "PreferredFullscreenMode"]
            IniWrite(1, FortniteConfig(), FN_SECTION(), k)
        Log("Window mode set to Windowed Fullscreen")
    }
    g.Destroy()
    ShowChecklist()
}

RestartAsAdmin() {
    try {
        if A_IsCompiled
            Run('*RunAs "' A_ScriptFullPath '"')
        else
            Run('*RunAs "' A_AhkPath '" "' A_ScriptFullPath '"')
        ExitApp()
    }
}

; ============================================================
; v7.9: never read our own windows (status box, Settings, tips, cards)
; ============================================================
DropOwnWindows(lines) {
    rects := []
    pid := DllCall("GetCurrentProcessId")
    wins := WinGetList("ahk_pid " pid)
    for hwnd in WinGetList("ahk_class AutoHotkeyGUI")      ; also a second Lobby Loop (e.g. Zen) on the same PC
        wins.Push(hwnd)
    for hwnd in wins {
        try {
            if !(WinGetStyle(hwnd) & 0x10000000)            ; WS_VISIBLE
                continue
            WinGetPos(&x, &y, &w, &h, hwnd)
            if (w > 0 && h > 0)
                rects.Push([x, y, x + w, y + h])
        }
    }
    if !rects.Length
        return lines
    out := []
    for ln in lines {
        cx := ln.x + ln.w // 2, cy := ln.y + ln.h // 2
        inside := false
        for r in rects
            if (cx >= r[1] && cx <= r[3] && cy >= r[2] && cy <= r[4]) {
                inside := true
                break
            }
        if !inside
            out.Push(ln)
    }
    return out
}

; ============================================================
; v7.9: the TREASURE FOUND! / UNLOCKED! screen in the lobby: read the item, save proof, click CLAIM
; ============================================================
PRIZE_TYPES() => ["LOADING SCREEN", "OUTFIT", "PICKAXE", "BACK BLING", "JAM TRACK", "CAR", "VEHICLE", "DECAL", "WHEELS", "BODY",
                  "GLIDER", "EMOTE", "WRAP", "CONTRAIL", "SPRAY", "BANNER", "EMOTICON", "MUSIC", "GIZMO", "SPRITE", "HARVESTING TOOL"]

; On the prize screen the type sits right above the item name, e.g. LOADING SCREEN / OSCAR'S WRAPS
PrizeFromScreen(lines) {
    for ln in lines {
        u := Trim(StrUpper(RegExReplace(ln.text, "[^A-Za-z ]")))
        isType := false
        for t in PRIZE_TYPES()
            if (u = t)
                isType := true
        if !isType
            continue
        best := "", bestDy := 99999
        for other in lines {
            dy := other.y - (ln.y + ln.h)
            if (other != ln && dy >= -5 && dy < ln.h * 4 && Abs(other.x - ln.x) < MON_W * 0.08 && dy < bestDy
                && StrLen(RegExReplace(other.text, "[^A-Za-z]")) >= 2)
                best := other, bestDy := dy
        }
        if IsObject(best)
            return {name: Trim(best.text, " .!•"), type: StrTitle(StrLower(u))}
    }
    return ""
}

ClaimPrizeScreen(lines, joined) {
    global lastClaimTick, clicks, prizeWaitUntil, backToLobbyUntil
    static lastShot := Map()
    if !(InStr(joined, "TREASURE FOUND") || InStr(joined, "YOU FOUND") || InStr(joined, "UNLOCKED"))
        return false
    btn := ""
    for ln in lines {
        u := Trim(StrUpper(ln.text), " .!•")
        if (u = "CLAIM" || u = "CLAIM ALL" || u = "CLAIM REWARD" || u = "COLLECT")
            btn := ln
    }
    if (!IsObject(btn) && (!InStr(joined, "TREASURE FOUND") || gameState = "match" || gameState = "spectating"))
        return false                                    ; in-match notice: nothing to click
    if (A_TickCount - lastClaimTick < 3500)
        return true
    item := PrizeFromScreen(lines)
    label := IsObject(item) ? item.name " (" item.type ")" : "treasure"
    ; proof screenshot first (once per item)
    if (S["TREASURE_PROOF"] && (!lastShot.Has(label) || A_TickCount - lastShot[label] > 120000)) {
        lastShot[label] := A_TickCount
        dir := DATA_DIR "\" BASE "_treasure_proof"
        try DirCreate(dir)
        shot := dir "\" FormatTime(, "yyyy-MM-dd_HH-mm-ss") ".png"
        if SaveRegionImage(shot, MON_X, MON_Y, MON_W, MON_H) {
            Log("Prize proof saved: " shot)
            if DiscordReady()
                DiscordFile("🏴‍☠️ **Treasure claimed** on " PlayerName() "'s account: **" label "**", shot)
        }
    }
    if !WinActive(S["GAME_WINDOW"])
        return true
    ; click CLAIM (where OCR found it, or the usual spot at the bottom middle)
    x := IsObject(btn) ? btn.x + btn.w // 2 : MON_X + MON_W // 2
    y := IsObject(btn) ? btn.y + btn.h // 2 : MON_Y + Round(MON_H * 0.884)
    ReleaseAll()
    OwnMouse(), MouseMove(x, y, 5)
    Sleep(180)
    Click()
    clicks += 1
    lastClaimTick := A_TickCount
    prizeWaitUntil := A_TickCount + 8000               ; another prize screen may follow
    backToLobbyUntil := Max(backToLobbyUntil, A_TickCount + 8000)
    Log("Claimed " label (IsObject(btn) ? "" : " (clicked where CLAIM usually is)"))
    SetStatus("🏴‍☠️ " Tx("Claimed {1}", label))
    return true
}

; ============================================================
; v7.9: multi-monitor: everything reads and clicks on the screen Fortnite is on
; ============================================================
UpdateMonitor(force := false) {
    global MON_X, MON_Y, MON_W, MON_H, SCALE
    static last := 0
    if (!force && A_TickCount - last < 5000)
        return
    last := A_TickCount
    cnt := MonitorGetCount()
    want := Integer(S["GAME_MONITOR"])
    mon := (want >= 1 && want <= cnt) ? want : 0
    if !mon {
        try {
            WinGetPos(&wx, &wy, &ww, &wh, S["GAME_WINDOW"])
            cx := wx + ww // 2, cy := wy + wh // 2
            loop cnt {
                MonitorGet(A_Index, &l, &t, &r, &b)
                if (cx >= l && cx < r && cy >= t && cy < b)
                    mon := A_Index
            }
        }
        if !mon
            mon := MonitorGetPrimary()
    }
    MonitorGet(mon, &l, &t, &r, &b)
    if (l = MON_X && t = MON_Y && r - l = MON_W && b - t = MON_H)
        return
    MON_X := l, MON_Y := t, MON_W := r - l, MON_H := b - t
    SCALE := Min(MON_W / 2560, MON_H / 1440)
    if !force
        Log("Fortnite is on screen " mon " (" MON_W "x" MON_H " at " MON_X "," MON_Y ")")
}

; ============================================================
; v7.9.1: remote play (Parsec / AnyDesk from your phone)
; ============================================================
OwnMouse() {
    global ownMouseTick
    ownMouseTick := A_TickCount
}

; You moved the mouse (Lobby Loop didn't): it lets go of everything and waits
RemoteWatch() {
    global handsOffUntil
    static lx := "", ly := ""
    if !S["REMOTE_MODE"] {
        lx := ""
        return
    }
    CoordMode("Mouse", "Screen")
    MouseGetPos(&x, &y)
    if (lx = "") {
        lx := x, ly := y
        return
    }
    moved := Abs(x - lx) + Abs(y - ly)
    lx := x, ly := y
    if (moved < 25 || A_TickCount - ownMouseTick < 1200)
        return
    if (Abs(x - (MON_X + MON_W // 2)) <= 4 && Abs(y - (MON_Y + MON_H // 2)) <= 4)
        return                                          ; Fortnite put the cursor in the middle (a match started)
    if (running && A_TickCount >= handsOffUntil) {
        ReleaseAll()                                    ; no stuck W / Shift while you play
        Log("Remote play: you moved the mouse, Lobby Loop waits")
    }
    handsOffUntil := A_TickCount + Max(5, Number(S["REMOTE_HANDS_SEC"])) * 1000
}

DisplayChanged() {
    ow := MON_W, oh := MON_H
    UpdateMonitor(true)
    if (ow = MON_W && oh = MON_H)
        return
    Log("Screen size changed: " ow "x" oh " -> " MON_W "x" MON_H)
    try PlaceOverlay()
    if (blackoutGui != "") {
        ToggleBlackout(false)
        ToggleBlackout(true)
    }
    if running
        Discord("🖥️ **" PlayerName() "**: screen changed to " MON_W "x" MON_H " (Parsec / AnyDesk can do this). Lobby Loop adjusted, but buttons are found best at your normal size.")
}

OnSessionChange(wParam, lParam, *) {
    global pcLocked
    if (wParam = 7) {
        pcLocked := true
        Log("PC locked")
        if running {
            Discord("🔒 **" PlayerName() "**: the PC got **locked**, so Lobby Loop can't click anything. It waits and carries on when unlocked. Tip: in AnyDesk turn off *Lock account on session end*; in Parsec turn off *Lock on disconnect*.")
            NtfyPush("PC locked", "Lobby Loop can't click while Windows is locked.", 4, "lock")
        }
    } else if (wParam = 8) {
        pcLocked := false
        Log("PC unlocked")
        if running
            Discord("🔓 **" PlayerName() "**: unlocked, carrying on.")
    }
}

; ============================================================
; v7.9: fresh restart: reopen Fortnite every few hours, only in the lobby between matches
; ============================================================
FreshRestartTrack() {
    global fnStartTick
    if ProcessExist(GameExe()) {
        if !fnStartTick
            fnStartTick := A_TickCount
    } else {
        fnStartTick := 0
    }
}

FreshRestartDue() {
    h := Number(S["FRESH_RESTART_HOURS"])
    return running && h > 0 && fnStartTick && A_TickCount - fnStartTick > h * 3600000
}

FreshRestart() {
    global fnStartTick, lobbyVisit, goneSince
    h := S["FRESH_RESTART_HOURS"]
    Log("Fresh restart after " h " h")
    SetStatus("🔄 " Tx("Fresh restart: reopening Fortnite"))
    Discord("🔄 Fresh restart: Fortnite has been open for " h "+ hours, reopening it between matches.")
    ReleaseAll()
    try ProcessClose(GameExe())
    fnStartTick := 0, lobbyVisit := false
    goneSince := A_TickCount - 31000                    ; let the normal reopen kick in straight away
    if !S["LAUNCH_FORTNITE"]
        SetTimer(() => Run(FN_URI), -8000)
}

; ============================================================
; v7.9: !set from your phone (safe settings only, needs your Discord user ID)
; ============================================================
PhoneSet(arg, authorId, who) {
    if (Trim(String(S["DISCORD_ALLOWED_IDS"])) = "") {
        Discord(who "for safety, ``!set`` only works after you add your Discord user ID in Settings > Phone control.")
        return
    }
    list := "⚙️ **!set** what you can change:`n"
        . "``!set mode zerobuild squad fill``   ``!set stop 8am`` / ``2h`` / ``off``   ``!set profile overnight```n"
        . "``!set after lobby`` / ``playagain``   ``!set limit 20``   ``!set restart 6`` (hours, 0 = off)`n"
        . "``!set volume 30``   ``!set mute on``   ``!set dim on``   ``!set fps on``   ``!set screen 2`` (0 = auto)`n"
        . "``!set treasure on``   ``!set stopfind token`` / ``any`` / ``off``   ``!set clip on``   ``!set fill on``   ``!set squadcheck on``   ``!set recap on``   ``!set remote on``"
    p := StrSplit(Trim(arg), " ", , 2)
    key := StrLower(p[1]), val := p.Length >= 2 ? Trim(p[2]) : ""
    if (key = "" || val = "") {
        Discord(who list)
        return
    }
    onoff(v) => (v ~= "i)^(on|yes|1|true)$") ? 1 : (v ~= "i)^(off|no|0|false)$") ? 0 : ""
    toggles := Map("mute", "MUTE_WHILE_RUNNING", "dim", "BLACKOUT_ON_START", "fps", "FPS_SAVER", "treasure", "WATCH_TREASURE",
                   "clip", "TREASURE_CLIP", "squadcheck", "EMPTY_SQUAD", "recap", "WEEKLY_RECAP", "remote", "REMOTE_MODE")
    switch key {
        case "stop", "timer":
            HandleCommand("!timer " val, authorId)
            return
        case "profile":
            HandleCommand("!profile " val, authorId)
            return
        case "mode":
            HandleCommand("!mode " val, authorId)
            return
        case "after":
            v := StrLower(StrReplace(val, " "))
            if (v ~= "^(lobby|returntolobby|return)$")
                SetSetting("LOBBY_AFTER_MATCH", 1)
            else if (v ~= "^(playagain|play|again)$")
                SetSetting("LOBBY_AFTER_MATCH", 0)
            else
                return Discord(who "use ``!set after lobby`` or ``!set after playagain``")
            return Discord(who "after a match: **" (S["LOBBY_AFTER_MATCH"] ? "Return to lobby" : "Play Again") "**")
        case "limit", "restart", "volume", "screen":
            if !IsInteger(val)
                return Discord(who "``!set " key "`` needs a number.")
            n := Integer(val)
            settingKey := Map("limit", "MATCH_LIMIT", "restart", "FRESH_RESTART_HOURS", "volume", "GAME_VOLUME", "screen", "GAME_MONITOR")[key]
            ranges := Map("limit", [0, 10000], "restart", [0, 48], "volume", [0, 100], "screen", [0, MonitorGetCount()])[key]
            if (n < ranges[1] || n > ranges[2])
                return Discord(who "``!set " key "`` must be " ranges[1] " to " ranges[2] ".")
            SetSetting(settingKey, n)
            if (key = "volume" && running && !S["MUTE_WHILE_RUNNING"])
                SetGameVolume(n)
            if (key = "screen")
                UpdateMonitor(true)
            return Discord(who "✅ " key " set to **" n "**")
        case "stopfind":
            v := StrLower(val)
            if !(v ~= "^(off|token|any)$")
                return Discord(who "use ``!set stopfind token``, ``any`` or ``off``")
            SetSetting("TREASURE_STOP", v)
            return Discord(who "✅ stop when I find: **" (v = "off" ? "never" : v = "token" ? "Pirate Shop Access" : "any treasure") "**")
        case "fill":
            o := onoff(val)
            if (o = "")
                return Discord(who "use ``!set fill on`` or ``off``")
            SetSetting("MODE_FILL", o ? "fill" : "any")
            return Discord(who "✅ Team Fill check **" (o ? "on" : "off") "**")
    }
    if toggles.Has(key) {
        o := onoff(val)
        if (o = "")
            return Discord(who "use ``!set " key " on`` or ``off``")
        SetSetting(toggles[key], o)
        if (key = "mute" && running)
            SetGameMute(o)
        if (key = "dim" && running)
            ToggleBlackout(o)
        return Discord(who "✅ " key " **" (o ? "on" : "off") "**")
    }
    Discord(who "I don't know ``" key "``.`n" list)
}


; ============================================================
; v7.9: Lobby Loop's own icon set (drawn for Lobby Loop, stored inside the script)
; ============================================================
IconData() {
    static m := 0
    if IsObject(m)
        return m
    m := Map()
    m["dark_bg_alarm"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAErUlEQVR42t2WbUxbZRTHz6UvcC+UQlvKS4vT8jJAzXjpWgoMUD8NAY0OOkZJ0OhGJCaILlsxIpOFFxlbY4YRQzaTuUQUImzEuGQf5KUFSnkJoFkmG7DesmQFChMutKVcP1x3xXJpMXFfPJ9OzpN7fs9znuf870HE4gR4muYDT9mYASwWSy5X8IOC9pOCHxQklytYLBbjKpshxGZrqz5VKFUW3Fx26i2vgMbGSxJppHF4sL7u3NbWlpcTsNlsbVWNQqkCAECQfVUBQQBAoVRpq2rYbPcds/z9Q3ZmP6utVqaqAGBlxVZTXfX48arX/ONjpvT0TBRFJVJpdEysQd+/ve36m77zFZ0+80lmZhYA2JaXq7Qf4riZKnGqMk2pVEVIpEJRCAAsLVotFotx2DA0ZFhdXQEAqTSyrr45WCAAgL6+3qbGWmZA+w83MAyjs/v7BxwrUOflv+Hr68u4d7vd3t3V2dnRThDrNIMgCHVBPnOJcPyB0+7Q6ZoWFiyRkQfqGpqVyjSqrNvb2/NzczMzdxcWLA6HM5DPRxCEzWY//8KLGRlZ4xOjOG4eGtJjKNbR8R11dIYT0BYTE3u+7gKGYQBgsy1/3369r/eXnffB5wdlZmUXFJ4IDhYAAEEQH1d9NPP7XYYXsBsgEAov6lqEAhEAGPT9uktNGxsEY4lQFKv44HRa+hEAWFy0VlaU22zLnl4RZRWVZw7GxgHA7du3mi/UO51Ouvs0JaWHDiX9Oj1FkiQAbG059QN9YnGYTBaFYf4hYrF+oM9LHxyMS1Cp0gHg/r2ZLy/rqESUJSWlFKqLC9XFSUkpdJAkyZbLl2Zn7wFAenpmbGycF8DRo7kIggBAW9tX9N4p80NRN4cyp9N5pa0VABAEycnJ8wTw8WEdVigBwGyen5qc2L+iTUyMWXAzAChSVW6i9A9AeHh4YCAfAEwjxn+rmiaTEQB4vMDQ0LA9AQKhiHIePlzwJJ+BDCpLfyIQiPYEoE+Ku7mxsTsFHTxZVl6sKXUrBbG+TjkYhu4JWFlZoSWeQdTGR3++9RMA+Pj4HC/SNHyuEwiF9Gqw4C/fZrPtCVhcfEQ5MlnUboDL5Wr54mJjQ+36+hoAxMXFFxWV0KvPyWRPklj3BCwvLT2YnwMA+eFUDofDeAED/b3vl5+cnpp0uVzT05NUkMPhyOUKAJifm3VrZvf/g8Ggf+bAszweL+fV/O6uTkaG1fpIe7aSy/V1OOxUJDfv9YAAHgAMDg54abSenh8p5Sk6URIRIfHwlujsEolUfVxDSV7PzW4vWmTf3CRJSExM5nK5icny4SEDQRAeMCJRyLnP6oUiEQBc//ab8fFR72J3585v0VHREmkkP5Cf/dIrFtxsseCM2RVKVXXNebE4FACMw4Nft7bs1K49ASRJjowY4+MTxKFhfn5oVvbLiUkpXC53c3PT4XSwOZzwcEnGkax3T7335jG1nx8KAJOTEw31tU6nY1//A3oAePudstzc1xCPswVJkjdvdF290rp7YPECoBtCoylNZpqrXC7XmMl47drV2dn7nmaa/cymAQE8uVwhkUqFwhAAWFqyWnDcZDKurf3hfWj6nw6//6H9CeArxLmU4S7IAAAAAElFTkSuQmCC"
    m["dark_bg_battery"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAB0ElEQVR42mMUE9NioCVgYqAxGLVg1ALKAQsyh4ODQ0lJWUhYhFRTvn/7dvPmtS9fvuKzwMXFPTU9m4uLizyX/v//f8P61YsWzvvz5w+yODM3tygDA4OBgVFFVT0bGxvZQcHIyKipqc3KynbhwlksPoiMimNkZPz79++ypYuePXtCqunc3DyxMYn8ggKBQSFr16z4/PkTugVKyioMDAznz59dtXIpv4CAqora+fNn//79i8wmkFqYmLKy85mYmDQ0tP7//3f7zq2PHz4gLODg4GBgYPjx4xsDA0NnZ7+0jOyK5UuWLlmAzMZvAdzVzi7u1ja2T588zkhPxJ5MpWVkGRgYZGRl0NhEAmERIbjG0ZxMpgVPnzxmYGB48vgJGptI8PbNO7hGRCr68f07BycnLw8/AwNDeXkhJGmisfEDDk5OCGPvnl17dm+/fecWigU3b97QNzDU0zdISEy7c+cmAwODpZUNXDMyG7vp7ByRkTGQAuPOnZvv379Dz2iLFs3r1pvIxMQUHBJGSYjv3LEV2XREWfT27Zt7d28bGZuws7OTXdjt2rlt7pwZaIUdI3KzhYWFRVlFTVRUlFTTf/z4cffObTS3Y7FgNKONWjBCLQAArcO2YIcc0HoAAAAASUVORK5CYII="
    m["dark_bg_bell"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACwklEQVR42mMUE9NioCVgYqAxGLWAIGAhRhEHB4exiZm6uoaIiBgDA8Pr1y9v3rxx7uzpHz9+UGoBOzt7WHiUt08ANzc3mtTXr183b1q3etWKX79+4jGBEU8ylZSUqq1vkZWVw6P/4cMHzY21L18+J9kCERHRnv7JwkIiDAwMHz9+3LJ53bGjR589e8LAwCAtLWtpZePrF8DHx8/AwPDm9euS4ty3b99gNYeZm1sUS9QzMdU3tsnJKTAwMJw/d6ayovjcuTMfP3749+/fv3//Pn78cOXKpT27d6qoqElISHJxc6uoqu3bu4sEC+ztnfz8gxgYGK5du9pQV/njx3dMNT9//jx8+KCBvqGIqKiYmPjjR48ePXpAbDL18QtgYGD4+/fvxP6u379/4wrf379/TZzY/e/fPwYGBl//QGLzAb+AgJqaBgMDw9kzp549e4o/mT1+/Pjs2dMMDAwaGlq8vHxEWSAvr8jIyMjAwHDhwnlicsmli+cZGBgYGRnlFRSJsoCXlxfC+PD+HTEWvH0DTT98fMT5AOJ8BgaG/wz/ibEAroyJiWm0NB0iFjAyMJJnFlaN6BawsLDA8+TPnz+JMReuzNc/kIWFhUB9EBuXqKmpzcDA8PnzJy4uLhtbe4IWMDMzf/78iZeXT1NTOzYucf682TiLaxVVtb7+qfB8QAb4//9/UWH2ndu3sAcRIzVilRF/haOqqi4uIYGmR01dU1VF7dixQ+/fv2dgYBAUFLSysrt959atm9fRVL588eL27ZvEVplwsGbdVnZ29n17d/f3dTIwMBQVlzs6uf78+TMkyJs6rYpv376ys7MbGBpLSkkxMjAaGplAUgHVmi379+0OCg4XEhKaNXsRXPDA/j1Uy8nLli66cvkSSh1w4fzyZUuIinMiW9dMTMy2dvaGBsYMDAxnz505euQgpKakmgVkAwBfAPBR/zaZsAAAAABJRU5ErkJggg=="
    m["dark_bg_bellring"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD9klEQVR42t1WbUxbZRQ+7+XSiy0toysdH+vKZj+4gDpkU1dokcHcD0A+tmyJCSRzQ1FGzIDojDE6TRZNFkjEbckQXVDn4gw/NqfyOdRBdPQDkcHaThfWjdAV7Bdl7Qr3+uMmXXtFuCHwZ+fXe899z/O857znnPcgqTQd1lIwWGNZc4IogSCBpdJqn6/Ys29i4tbsrJcjSlJS8qHq1/Bo/PbtiWUICgt31zce3fK44jE+//ffBjkSHKyuKSzcnZOju3fPfuvvv8J/4eEfJJlRW3cEIUTTtEF/LaSPiYnJ3vaMWp0mkUgBwOGwm803jIYhv9/PbDDorxUUvIAQOlxXb7PZLObxkC0KZVF0dHTLydaUlI0AcPrUJz9cvggABEHs2/9SUXGZQCBgndrn81262HHh2/MPHgQAoLik9NWaOgC4e8d2uLZ6fn6eHaKi4rL8/AIA6O/vbT/bxkT2+EdNGo2Wx+P9Nyw8Hi/ziaee25Fj0A/5fLMWi3mjTC6Xp4pEcR6Py2K+EeEBhmGtbV9KpRv8fn/1wUqXyymRJJxoblkvlgCA2+3+/lLH4MDA5OQdAEhJke3Q5Ja8WCYSxQHAtMPR2FA3MzMtFq8/81k7QRB2+9Qrh6ooinroAUmml5XvBYCuzh+v/tqPYdh7x45v2pQKACaj/u2jDUaj3u12URRFUZTb7RodHenp7lQoVImJSXyBQKFU9fV23b8/l5AgVShVsbGxwya9w+F4WAfBYJCmaZqme3s6AUCnyyfJDAAYG7v+4QfvLpqvHo/72PvvmMfHACAz88nc3DwA6O76icEJBoPsS1YqVQBgtVoA4ERTi1pNLiwsvF7z8uTk3SUSVCaTfXqqDcOw8fHrbza+wcKJSNOQKm7dOpUqjUm+pdEBwGazGQxD27c/m5aWLhSKvF5PCOd/W4VcvhkhBADDwyYuVTbyhwkAEELy1M2cepFQKGQWLuc/XAhmpqeZhUgk4kTAHB8AaKC5EIS2YRj2KLbrR5IAAVoZ1qKGbAIcx0tKy5l1IBDgghvaVlJajuM4G5D1XVl1gOlCXq+Hz+fnavOWf3Wjorxej1AoIsmMyqoDX3zeGuFW+NiiUKqamk+G6mAFQtN0/ZHam2HdAosM4ioICwSxBi+lUr0hMZFlo1KTSoVqcPAXp9MJAPHx8RqNznrTEv72MmKfmrJazUsRLCrfdVwmCKKvt7u56WMAqG94K3/nrkAgsLeiaFlbnIvXc3M+giC2ZmUnJScjQFlPb2OygIstJ4Irfd0Ve/aLxeIzre0hZf+VnlWr5HNft4/+ORLxBgybvjn3Fac75zhdY1iUVpeXtTUbAAxG/cDVn5mhYdUIViz/AsICd8aGKj+tAAAAAElFTkSuQmCC"
    m["dark_bg_brick"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACCElEQVR42mMUE9NioCVgYqAxGLWAIGBB5ujqGVhYWAsJC8FFGBmY5OTlGRgYHj18+J/hH0Hx169eHTly6NbN6wiV8FQUGBSWmJTKyMhIoZP//fs3dcqEXTu3oQSRoKBQXHwS5aYzMDAwMTGlpWfz8PCiBJGysgoLCwsDA8PsWVM3bVwPV21ja19eUcvAwNDZ0Xzk8EGC4qFhEXHxKezs7OrqGmfPnkb4gIOTE8J49+4dJc5//vw5hMHJxTUQqYiBgUHfwIibmwfOVVVVgzAMiBNXgYmjp6LQsKi4+CQqOnzRwnmrVy1DBNHv37+oGzJwA6FB9ObNawhj5YolVy5fwqpHW0cvIjKGgYFhxfIlV69gV6OjqxceEYNsIHocPHhw/8KFc1g18/BCk/bDh4TVDFBZxMDAoKCg+OXzZ6xK5eUV4QxcahQUFLFbICIiCmGER8SERxBwFCQm8AO4gdAgYmVlo27IwA1kgWXxpxDGjh1b79y+hZyh3D28GRgYdu7YepsIcRVVNQ8Pb2QD0ePg4oVzyIXX169fIAZdIFocYgHdq8wf379DGBISEpQYJyQkgmYgtCzi5eWbv3A5Ozs7VVz958+fhPiIjx8+IHzw+fOnWTOn/vv3j3LT////v2D+bIjpKHUyAwODuoaWtbWtqJgY2ZX++3dvjx09euXKRSyV/mjDa9haAACLMNQzWmW8bgAAAABJRU5ErkJggg=="
    m["dark_bg_broadcast"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEG0lEQVR42u2WbUxbVRjH//f21q7D8JatjJeuoJgsvJTWUpANOoYUQZ3igOlmNsZsNAYdIzo640A02ydjYjaNwwmKZGMDbOPLMoSuIiisAyasjMRFSikVOpc5aRn08nb9cDYFClqji184X84/z7nn+d3nPPc+z6FEoijczUHjLo8VwP8P4Pn4rF1k2vpE9v7iEqfTaRuyeuklRbXl4GtlFIWrV3/8G0B6+iOFLxX7+fkFBAQamhu9BBQW7o+MfEChSHCMjlqtlmWPSCwWv1i4D8Ds7KxeX+/9Oej19XNzcxRFFb5cHBoatmwEWm1pSGgYgKrKivOGr70H2O3DU1NTcrmCYZiwMPE3RsMSEcTExEllcgB9fZe/+FwHgMfjHdCWNujObkpWeTrdlKxq0J09oC2laR4Ava6uv/8KAJlcERUVvQTg0ce2ElFTXclxHICdz+arVJsFAkG8MtETEK9MFAgEKtXmHTt3AeA4rqa6kixlZj2+GMAwTLwyAcCQdZC8iEi0blvOdgAul7P+zCma5qkzskq0h0q0h9IzMmma11BXOz7uApCT+/SaNWtJ6MPDNgAJiUkkrD8BkvAIoXA1gIsXTcSizshkGAZA1UcVDsdo+ZtH9hW9kqJKTVGlFhW9WlZ+eHR05JOqEwD4fL46I4vs6uq8AMDH516JRLIAEBJyO/WDlp+IkEplACYnJ1pazqerM+UPxs8/H4VCmZamNhoNbrcbgFQaR+yWgQEiQsPECwC+vr5E3PztJhEiURAA27BtZmYmOjrWMwcxsXHT01N2uw2AKGgdMd749cYdh37/bangyERR1NK1yDk2RkRAQCAR1645AEjEEj6fb+7r9XTZZ+7l8+8RiyUAHA4HMQbe2e50ji0AjIzYibjv/kgizOYeAKuEwtQt6UZDU3d353zvXZ0mo7E57WG1QCAAYL78w6Lt5OgAMGSyWgcnJyeEwtVKZWL1xycANDU15ubtYBimYO/z/VfMb5W/npamlskUAHp6uo3G5uDgkD0FGgDT09OG5tu/fXzCQwDGx122IduCUsFxnGR9RHhEhL+/f2/vpevXf5m4dYth+DGxUoFAsEoovNDxvcUy0N7e1t7eZrEMcBy3V/PChg1RAOrOnDSZOkgt2JaTB+C7ttaO9rbFST7X+CUR+fkakqvTtZ+2tn7LsmxXp8kzB12dJpZl21pbTteeBEDTdH6Bhiw1nvvqj8eo+beKw0fejpPJAVRVfqjX1f2jzyhv+zO78zUALnV3vVF2cOlyffyDoyzLAthToElKSvbe+8aNybt2PwfA7XZXHD+2bD+w24fff+9djuNoms5+Ktd7wJPZuRRFcRx37Og7IyM//1VHsw5aXC5nUFCw7rM671smy7LrJeG1p2o8myC1crNbAfzr8Tu4YH3yVCL+/gAAAABJRU5ErkJggg=="
    m["dark_bg_broom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACgElEQVR42t2WT08TURTFz8x0aC3S1tS2yrzXQkusuqOZIGJN8C8IEeOuKPg53ABBEkITY8OKL2CEYFwogokRdSHCwuhCTQwLpfM6MSSWhtjCdCFx0TKSkkKnGTbe1Zub8+aXe+67b4bzek/jIIPHAUf1gFCoKRRqOijAifCpxPhEYnwiGAztrbRUB+i5fpPjOAAWi2h+BU6nqy16HgBjyeXlb+YDOjq7RFEE8Hzmqfk94Hm+o7MLgLa5+fbNvPkAWW7xeo8BmH/9cmMjZz7gWndPYfFibtb8OfB4fZGIDODrl8/Jle/mA7q7b/A8D2Bu7pn5kyyK4uVLVwGsr68vvn9X4S5uj8vO5zseu9Vns9mK/nh84fBJACylJFd+FJKapk09eri6+rOaSb7dd+fCxSu785T4KfHrj4IgPLg/Vo1FDY3BSkxoaGis5i7ieb6+ngD49PHD4MBdAK1nz7WeaZuc/GfIvZGx5ogsSZTnha2tP8YAHo/ParUCYIwVMkuLC0uLCzs1jLHmiFxTU+PxeMu1oaxF1F90WVWZ0+WS5RZBEHTTZbnF6XKpKisRGwAQQgsLRUnG44mh4dFYb38hE+vtHxoejccTipIsERsASHS7ghSTCAVAKCm+jhIAEqFqipWIjVgkUQC5XDaTWSunyWTWstnfuriaHugdLhcqYwD8gYAxQF2dw+FwAlCZsjcglWI79ZUC9FPBUvsAdAGh1Ahg+yZg+1WgCwjxGxg0afvYDQyO6MlotD06275TNjP7avexrqgCu91u9Et3qLbWQAWPp6c4cPbDxT1ut9t95KjCklpeA2Cz2vw0kM78SqfTBUFeyz+ZnjT8Pfjff34rjL+ETrrtXvNiSQAAAABJRU5ErkJggg=="
    m["dark_bg_calendar"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACvElEQVR42t1WXUhTYRh+vu8TdsILd+EP6qbOzRAvimC5tMmWZARmgoaBgxwlopCYFyFC3QUVJTqkDLrqQlEvisiukkic0o+FVJigmzVzXeimkLRdbOd08cmSeY7sRyl6r77zfO95nvP+nO/9SGZmCfbTKPbZdhNgjBmNpWlqtZJDmlptNJYyxnYjSU3NUNprtDVdbu80mcrGxp7KOjgcAzW1dQD59HE2kQg0Wg2AXI1WyYFvcTclI1FFLtDpysoqtNo8QklxcUl6egYAp3NC9mWz2QJgbW11fn5OEiW3e2F6yun1rigKVFfXNre0paSkJFzSYDDo6LvjnJyQSVGBTpckOwBBEDquXM3Kyo4gf+jKyys4u8Nx9+X4C1EMd3VfM5utAGqqT8rSPXs+DsDpfHX75g1KWV19Q5P9kiAIFuuJ0ZGh6Ag0mjwAkiRxdgCBX0EAwUBAMSGBQMRNFMNPHo9yPD+/QCYCQglfcHYAI8ODlJDXb6aVBHp6bh0zlY8MD/LHcHjrRcqojICgEgAQoKv7+nYWi7XSYq3cJe/2i81RiEp1QEZAq80HAEJ48yVjeZwqqgb+9bW9On/8fp9MBD6fjxf57JmqhKl5X/n8q//GaarXG/SGoniRWAUKC/W9joHevvuGooOxI39h4CiePG63q7OjDYS4FhdiR+IQAOByLSaAxCrAGGu0XQDI0OAjfgbsRJJK0aHDRxrO2wB8mfs8M/NWFklKYMntWln5TgmNJGEnEp+AJEpbjUWZKIY3NtZbW+zbXXci0R1Jt64XYliUaVOPZwkAIaSu/lzENY4/lrKqU6f5enl5WWYmZ2fn9N97qFKpkmz8UCjU0d7q8XyNvhdtbv784fUaj5qSGcuhUOjBQP+H9+8Ury05ObnHzRU6nSEy4GI0SZQ8nm/TU5ORb5cX+L8uv3tivwHmThNHoTOrXAAAAABJRU5ErkJggg=="
    m["dark_bg_camera"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAClUlEQVR42u1WP0wTURz+zphwvdYFe1cgXGUBCkNLK8shFAYUNVAwDhJ1wASIxJgYlBhE+RNEQkBQBybYUOpgFLAJgwvFwibQAcpk6tGWgrBQ747Fc2hSm2sxoReiMfy29373vu997/f93juCYQpxlHECRxzHBH+f4OSf0+npp5/2D7HZbNIsv8E/bn+wu7uTuoLGppaD0AGw2WxjU0vqCswWa5m9AsD37W3f+qoia8ov1NN0mb1idtblXVk6CISINZrBkFl//SZJkgoIAB2P2hIhzBZr37PBRHpJkpxvJsLhkFLBtfoblZVViVtwu+eSbtC7suR2z9nt5XqaLqXL41PyT/nVyyFlDTQUmYgSCGyMj40eJH98bDQQ2Eicj4eKrwEBQJZlR/V5xQKtVlfjqLVYbMYzObIMv//ryvKXjzNTuzs7t5sb4r+ccX06nE0BGI05XT19DGP4ffrmIrO5qOri5e7ODp73q2o0itL29PZH0QVB8HqXvd5lQRAAMExGT2+/RkOparTauqt6PQ1gwTP/YmRQFIUo673WNo4rpWmmtu6Kc/J16gq4knMAIpG9keGBKDoAQfgx/HwgEtkDwHFlqo4oMyMLgM+3JklS/LwkiuvrPgCZWVn/9m0aDAUBmEwFpEajKL7JVAAgFAyqIlhc+AxApzvVev+hVquLtUVs6PHMq3LR1Id3F6ou0TTDcaUWi823tkoQMBUURt25tbU5M/1elQJRFLqetIfDmwAoirKdLbbaiqPooVCwu7M9Zq0UFQDgef/dO83VNQ6uxM6yRgD8N7/H43a5piVRPPSLRhBE4n2iiNy8/Ny8/IZbTYdzkcLpamJf3E+i4O3kBAEijUxTiS5JknNyIsmLdvxf9N8S/AKciullxSpErgAAAABJRU5ErkJggg=="
    m["dark_bg_chat"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABgklEQVR42mMUE9NioCVgYqAxGLWAIGBB5lhYWts7ODIwMFJg4P8D+/edPHEMzmdETkWr12zm4OSk0Mnfv38LC/HDHkSUm87AwMDBwYkziCDgyJEDne0tZBhdXllrY2M/vFMRGhAXl4yIiuHg4MCj5sePHyuWLXn58jk5FoSFRbq4uBNOmP/+TZrYS04QnT5z8sePH/hN//Hjx+lTJ8kMohPHj4YG+wxAHBAMdyrEAf5wpzQOCIY7XeNgIDKatbV9Xv53SBArKCoWFlUoKSlTxwc/vn9nYGBgZGR0cfVgYGAwMDTu7JpIquk/fnzH6YPe3o609GxRUTFGRkYXF/fs3EIWFhYGBoZr166+e/eGyArn4IH9yHxGtGZLeWWNjY0DAwPD////GRkZGRgY1q9btWD+nH///lE5ozEyMv7792/WzKlbt2ykSU7++fNnV2fLqZPHqZyKnjx+wsDA8OHD++bG2lu3blCeTNHjgJmZ2dDQ+M6d2x8+vKdKPmAcbZsOuAUAK46WiX6fLYwAAAAASUVORK5CYII="
    m["dark_bg_chest"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACfElEQVR42mMUE9NioCVgYqAxGLWAIGAhqEJIWFhLS0dOTl5ERJSTi4uBgeH7t2+vX79+9OjB9WtX3717S6YFHBwczi7uLq7uKipqePTfvnVzz56de/fs/PnzJ1YFjFiTqb2DU3JKhqCgEJHh8P7du9mzph0+fICwBUxMzFnZee4e3hDur1+/zpw+ee7cmTu3b758+fLLl88MDAy8vHxi4uIqKmrGJqYmJuasrKwQxVu3bpw1Y+q/f//wWZCalu3nH8jAwPDnz5/Nm9atXbPq48cPeNzOLyAQGhrp4xvAzMzMwMCwYf2auXNmICtg5uYWhXN0dPWzsvMYGRk/f/5cX1uxe9eOnz9/4A+cnz9+nDt35vLli5ZWNmxsbOoamhcvnHv9+jX2ZBoQEMzIyMjAwNDV2XL9+lXi0+LVK5d7utsZGBgYGRn9A0NxpiIdXT0GBobbt29dOH8WPa4YGdXVNUVERRkYGF6+eH779i00BWdOn7x3946Ssoqurh5OC7i5eRgYGF6+fI5pellFjY2NPVxk+7bN06ZORFP27PlTJWUVXl4+AvlARETExtYeWURKShrZdAYGBncP7/v3733+/AlNI4FkunnrHqoUD77eLgNaFt24cXXjhnXIIhoaWv4BwQwMDBs3rGVgYICzb9y4hqzMPyBIQ0ObsAVv3rw+cvggisjr1xBDISQEnDt3+tzZM8jKrG1sySyub9y49uD+fWSRV69eXrt2lTrFNQTU11X4+AZKSkkyMDC8evli86b1P75/p6YF7969XbRwzmiVCQE2Ng42Wx1o4gNc1R5JAM0QFB/09XbY2tkzMDBSYP7/w4cOEq6TRxtew8oCAPjV5RKNab6gAAAAAElFTkSuQmCC"
    m["dark_bg_clipboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACmUlEQVR42mMUE9NioCVgYqAxYCGoQkdHLy0jW15ekYkJ4Zp///7dvXN7xvTJt27dwK+dEX8Q8fLyzZ67iJubB6vsx48f01Pjv379gscEZm5uUSwBx8QsKyuvra1jY2tvYGDEwMDw9OmTZ8+evoGBXz9/8vLxcXBw/Pv3j4eb+8+fP1++fCbWB/IKSsUl5YqKyiSF9bVrV3u6Wl+/fkXAAm5unslTZ4mKipERn0+fPM7Lzfj16ye+IPL08ra1c2RgYDh27MjyZYufP3+qpa3LwMDw7OmTpxhBxMDAsGrlsq1bN/Hz84uJS/Dx8b969fLu3dv4UpGikgqE0d/X+eP793NnT7u6efHz80tJy0hhOPnz50/r16/68vnLhfNnl61Yx8DAoKGhtWvnNnz5gIODg4GB4f///z++f2dgYPj69UtTQ/XNWzf+/v2LrOzfv3/37t5uaar98vkLxCaIOCcXB8n54NatGyWFOYM3Jw90UWFhaW3v4MjAwIhD/v+B/ftOnjhGvgWFReVcXFx4FBgamkaE+ZMfREePHPz//z8u2f///x89fJCiIJo0sXfSxN6hHMl5+cUurh6MjIy4gmj3zu2TJ/eR7wNrG3tcpjMwMDAyMlrb2lPkg/6+ToLJlCILThw/euL4URrGAb+AgI6OHnIo/f///8qVSx8/fKCOBZ2d/dIysmiCj588zkpPHCLJtLy8EGsQkW/Bu7dvIOlPVVX99u2bHz98OHrkEEFTZGTlYNrfErDgzJnTfv7BDAwMza1dFy+e//fvL+FQZmLW1taFsC9evEDAgvPnzuzZs9PFxZ2bm9vKyoak4D518vipk8cJN7xOnTz+5ctXQQEBfgFBPNkYuX5+9Ojh5k3rZs2ciln0Mg751jUAbk4ctvBE2cYAAAAASUVORK5CYII="
    m["dark_bg_clock"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEWklEQVR42tWWX0xadxTHD7vcPYAVuFwZahOh2qbFhwaIQghGpSXW1CbLykJtNNaHrlm7pDVN9se6lTTd1j1oVpeZrma2027FpeuyGaFrHa5Vp51a3dK13TrAORWVCyiKBSGwh6sMroDSrQ87Tz/uPZzPuef8vuf3o/F4IniW9hw8Y6Nv0C81lYVxMRznQShkJwing1hYcP8HgPSMDJVKLZMrhMJsyiuLxXx3oK/b1GWzTSWIQIvXAzabc+BgRUnJXjo9URKBQOCGsVOvb5ufm0sCsGNHbm2djs3mkD89Hs+94cHxcSthJwAA4+ICgVAizWMymaSDy+V876zu0aMHGwIUFBTVnHwDRVEAmJmZbmtt6eu9EwgEqMWl05XKwsqqah6PDwB+v7+h/lxvz22KG8JkplFyP/X2GTK6obPjjO6U1WIOBoNrUwsGg2NjVqOhg8Vi52zdhiCITKb4eXSEIOxxASw2+/0PGsgPb/n0YltrS2RoNpvzYeOFsn0v9vbc9nq9YczgTwM+n08sliIIkpcvM31/y+fzxtZB+cFKsu63bhq/vv4lJWWRKDczc3Nm5maRKJfy6vpX7UZDBwBwOJi2vCK20NIzMkpK9gLA9LSt6ePzMTSJIJRFpDVfbJqdnQaA0tIyPj89BkClUpM78krbpbUtXdf8fv+V1stk84tV6hgAuVxJ7si+3jtPNxV6en7weBYBQC5XUAGpqSyBUAgA94YHnyL9sOhGRoYAQLglOyVlUxQAx/HwAPg3o+3PMSsA0Gg0PA2PAmAYl1zMuZzrRtmt3hPZxkgjHA5ywcWiAaFQaLVmtHhxpyYnSDepNK/pQktV9WEGg0kdDLDy9xCEogBO5woZ43DjASwWc+2bJy3mPwAARVGNRvtJ82WFQhnpw+WuJO5wOKMAjtVPEwiECYpz//4vNSeOftTYMDfnIrV9vOb1SIcsQRZZD8fqwFgBuN3zVqsZACTSvMTzORgM3vzOcOTwoWvX2r1PnvT1/jPdUBSVSPIBwGx+vLi4QNXBQH8fADCZTKWycN0+Ly15PrvU/LJmX+P5+vBDZUERg8EAgLsD/TGE1m3qIhVQWVVNTtOkDEWfr6g8RKqh29QVA2CzTd0wdgIAj8c/duxEsoBXjhzl8V4AAEPnNzMzttjTVK9vc7mcALBLXfLSfu3Go+/XaPeUlgGA0+ls138R9zzweb0PH/xarNqNIIhYLMUwbHRkOOZpE1mZV187rtEcAIDl5eXT77w1NTWR6EQjCPvk5IRMpkAQJGfrtmKVesHtnpgYX4uh0+mFRbtq63Q7d4rJ6A3150ZHhjd06G/fLqqt03E42OqeWRoaGvxrfIywzwIAnsbLEmRJJPnkniEr8+7Z07//9jCJawuLxdaWV5SWlq17bTEavtVf/dztnk/uXkQan59erFLL5Yot2TnUyWF+3N//Y7epK3LPJA0IW0rKJi6elobjAGAnCAdhD2s1sdH+97frvwGez7YlCFqTagAAAABJRU5ErkJggg=="
    m["dark_bg_coffee"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC2UlEQVR42mMUE9NioCVgYqAxoLkFzNzcorjkxMUlU1MzGRgZnzx5zMDAwMzMHBOboK9vePXK5f///xNpAQseuYysXBMTM0tr2/BQPwYGBkdn17DwaAYGhitXLp8/d4YKQaShocnAwPDi+VMoV10Twnj+7Cl14uDhgwcMDAzSMnJsbOwMDAyPHj2AiCurqFLHgjNnTjEwMLCzs6upqTMwMJw+fRIirqOjTx0LJCUkIYyPHz8yMDBISEjBuB+oY8HpMyd/fP++a8e2x48fMjAw3L939+nTJ0+fPtm+bTPxFjAi52RBQSEtbR1GRkbi9f/88evcuVN///4lKpl2dk+QlJQiNSutWb184YK5RAURGaYzMDBISEqSltFu3Li+ccMaYowur6hlYGDQUNcuLa999vTx/n27n2FkESwWvHnz8sjhg8RbICIqaidqz8DAEBIaMWvmVLQkQM3CjoWFJTMrT0/fkMoWHDlyINDfY8a0yf///2dkZAwLi6K+D/78+bN168arVy8zMDBoaGrRKogYGRhJK66JB6ysrJ5ePto6ugwMDNevX8Vpwd+/f5mZmdlY2YkxFFLEMjAw2Ng42Ng4QNj///9fuWIpziB69eolAwODopIyMaWFiooKmsjv37+nTO6/cvkiTh9cunheUlJKVFTMxNT89KkT+C3w9PaDMK5cvvj+/fsnTx7t27v7xYvn+OJg+/Ytbu5ejIyMWVn5JXfvvH37BpfptrYO9vZODAwMjx8/rK4q/ffvH1GV/vt370SERZVVVLm4uW1s7J8/e4qZ9Tk5ucIjolLSspiYmP7//9/d2YrpapzFNSTqmpo7IOmBgYHhzZvX9+7e+fX7F4TLx8OnrqnFzg6N3nlzZ65ft5qE+gBuR2pGtrubJ56o/vLl8/Rpkw4d3E9ahYMMlJVV3D289Q2NxETFWVigUfX9+7eHDx+eOnl0+7atX758JrlGG22bDogFALVC+rV41hxbAAAAAElFTkSuQmCC"
    m["dark_bg_compass"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAE30lEQVR42s1We0yTVxQ/8LVlUKSvDwIkhlbeuomUQBssgVabrrz+QBLcAnHMPZS4GWUJDtkkxm2YTJYljmyoTME5WBZNeM6BLa9CERCWDXESKFDk1a8FykMK2O6PC1W+FgZmJrt/nXvvued33vc4eHjshle5HOEVL8oW+dzcGGwOG8c9wGLREYRBT8zOGv8DAC9vb4lEKhBG8ni+pKuBgf42tUqpqBsbG91EgsNGMWAyWYffTpXJ4iiUzZRYWVn5raaqtLRkZnp6GwDBwXuyc3KZTBbazs/PP+hsHx7WEDoCANgcnMvl8cPC6XQ6YpiaMnx5IffRo4dbAoiKijmVmUWlUgFgYmK8pLhI1dy4srJCdi6FIhJFpx1J9/DwBIDl5eX8S3nNTQ0kNoxOdyfpfvaz80h6dVXF+dyzmoF+s9lsq5rZbB4c1NRUVzAYTD//AAzDBILIP7q7CEK3IQCDyfzqYj4yvOhaYUlxkV3RJJj2+2qTyRQaGoZhWHiEQHGv1mRatA+Q/u77e/fuA4Da32tuXL+69WTv7e1hsVj+/oHOzs5UGq2z476dQvPy9pbJ4gBgfHys4LtvN5e45/U3Tn9y5tfbVR+fzEQnVwoLJifHAUAuj/f09LIDIJFIUUbeLPnRNqRoubruSEhMKvj+Wt7Fb8Tig05OTvtF0ehqeXn5ZvF1FHyxRGoHQCgUoYxUNTfaivb3DzidmXWjpOyDDzN27vSxnrepVVa6qal+fn4OAITCSDKAmxuDy+MBwIPOdlv1AwKDv86/LJZIaTQaACwtLS0+fYqu7t6tfrHouro6AIC3y9fVdcc6ABzHrQ3AVv34+ERHR0cA0GqHCn8oOJHxniOGoW3PX3++yDk0qAEABwcH3B1f14vYbA4ipqcMtn5HjtZqhzKOHQWAhMQkZEpNdRWJmdDrEcFh44MazXMLLBbLms8cSG+snrGKk8fGIUcpFbXkxgCrzy1gWWeBwbCKzGZxSG+s4jra1QmJSfLYOBRkVXPD3NwsiZnDWfWMXm9YB6BfM43L5ZHyHYkzP3t2ueAqMgUVcGVluW20fLg+yB/6tYaxCmA0zmg0/TyeLz8snEKhWBNJJotFxGvOzohYWlpSNTdUlN/p63tMkk6lUvn8CADo7++zGve816tbVTyeL51OF4mi6+vvoUOBcL+VQasdqqmuUipqbT2DligqxsXFBQDa1K12Ck2pqEOKpx1JR90UOdpkMimVdWeyTmUcO1pRfnsj6VQqLTXtHVQNSkWdnWY3NzfLZLICAoPodFec465WtwBAW1vrL2W3WluadZOTm3en4xkfhezjA0BlxZ3GRqX9qaK0tGRqygAAB6SypEMpW++mh5JT3pTHA4DBYCgrvbXhf2BaXOx92COWHMQwLDQ0jM1md3d1bv4lUKm04ydOJicfRvE/9/mno6Mjm/1oBKF78mREIIjEMMzPP0Askc4ajSMjw7YwFAolOuZAdk5uSEgokp5/Ka+7q3NLn35Q0O7snFwWi422CwsLHR3t2uFBQjcJALi7hw/Xh8+PQDmDPPPFhXOP/+7dxtjCYDBT3kqVy+P/dWypqS4v/fkno3Fme3MRWp6eXmKJVCiM3OXrRx68+vtaW1uUirqJibGXGbxseyoHd3fHcQDQEYSe0G1UEC8J8P+drv8BHZYC2EY+1mUAAAAASUVORK5CYII="
    m["dark_bg_contrast"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADCElEQVR42mMUE9NioCVgYqAxYCFSHR8fv5CwkK6uoYCAwLNnT2/duvH40UMqWCApJeXk5GpuYaWoqIwm9efv77u3bi9btujcuTN4TGDEFQcCAoIRUTHu7t4sLAQc8fTp4/a25ocP7mGVZebmFsUU1dTUbu/s1dMzYGJiYmBg+Pr168kTxx4+fCgvr4A19Ly8fb59/Xbz5nWiLLC1daiubeLm5mZgYHj58sWM6ZMm9ncfPnyAiYnRxsYeV0gYGZvy8/GdOXOKQBxoamoXFpezsrIyMDBs27p59qypf/78ITIhePsGPH/+fOPGtTiTKb+AQFVNA8T0eXNnTZ82kXjTISA5NUNOTgGnBZFRsQICggwMDLt3bV+/bhUZqZ6RkbGquh67BZJSUu7u3gwMDC9ePJ82dSLZOUtaRlZf3xCLBU5OrpAUuWTxfFJDBg1Ex8ZjscDCwgaSIo8eOURh8aCqoo5uAR8fv4KiIgMDw7mzpyl0PgMDAwsrq4yMHIoFIiIiEMa9e3epUsapa2qgWCAkJAxhfHj/jioWSIpLoVjw//9/WJgxUsWC/2hx8O7dW6hXBIWpYsGLF89QLHj7FmqBgoIiVSy4ceM6igWfPn28f/8uAwODkbEpwfKZIPj95/fTJ4/R88GJ40cZGBi4ublxF5nEgtu3bmLJaPv37YHkgNj4REh5RzZYsmgBFgueP3+2Y/tWBgYGMTGJ7OwCsk1//PDh5csXsJemK1Ysfv/+HQMDg7Ore1BwODmp8///9vYGnMX1xw8f2loafv/+zcDAkJiUmp1TQGJY/Z89c+rjx4/xVZlv3rx++vSJubkVMzOziqqao5Pr50+fnjx59O/fPzl5Bbzx/3/TpnXLly0hqlWhoaFVVdMgKCgE4X779u3MmdNMTAy4LPj///+sWVO3bNpAQrOFn18gPDLG09OHYLZ4/Phhe2sDWsgQtgACJCQkHZ1cLSyslJRV0Btef37funVzyaIFyGmGZAvggIeHV1hEVF/PgJ+f/9nzpzduXIfnVQK19JBvXQMAYf8SgRFNtpsAAAAASUVORK5CYII="
    m["dark_bg_corner"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABsUlEQVR42mMUE9NioCVgYqAxGPoWsCBz8vKLXVw9GBkZMdX9+PGjt6f9xPGjFPkAl+kMDAwcHBymJuaU+gBi+pvXr2/cvIbpg1WrllNqAQTcuHm1s71laEYyFmkWFhdXD3UNTQ4ODjSp79++X7ly6cD+Pf/+/SPTAhYWlta2Hi1tHVwKXN08bGztW5pq8diBL4hcXD3wmA4BpqbmDo4uZPpAQ10TwoiPC3/39i2arISE5Oy5ixkYGPR09fft3UWUD358/87AwPD92w8Il52THcLANJ2BgeHFi+f///9nYGBg5+Qg1ge9vR0W5lYrVyylVSo6cfwoGYXBMCpNxcUlCwpKLSytaWVBeES0s6t7cXEFsRbAk5OEhCSmrJCwMKRw/PEDqoyTi4OBgYGDk5PYfHDlyiVXNw8GBgZIescFbly/RmYcHNi/5/Tpk/iD5cqVS3t27yAzJ//796+lqdbewVlXV5+TixOzhrhx7eqePTv//v1Lfmn679+//ft279+3e8jWB7jSe0RUDGYNoaGuRR0LwsIiXVzccclCSkCKguj0mZPwtI9pOlqiYhxtmw64BQDqT5dVLkKkDQAAAABJRU5ErkJggg=="
    m["dark_bg_disk"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABvElEQVR42mMUE9NioCVgYqAxGLVg1ALKAQsyx9jYNCw8WklZhYODgwyzvn//duP6tRXLF1+7dhUuyMzNLQphubi4l1fWiomJs7CwkOdYVlZWSUkpJ2e3+/fvPX3yGCLICMnJHBwcCxev4uLi+vv37/nzZ3/8+E6GBTw8vPr6hoyMjB8+vE9KiPr9+zciiJSUlLm4uBgYGFYsX7Ri+VKyQzwxKTUoOFxAQFBZWfXGjWuISBYSFoEwnjx5QkmU3rp1E8IQFRUbiFSEDPgFBFRV1c+fO/P37180KWZmZkMjE7SU9vzZ07t375BgQWdnv7SM7KqVyxYvmocmFREZGxEZgyb4////gryMgc5oyKC8vBASRJhSK5YvvnnzOmYQ3bt3V1JKmlgLPn74cOb0SaxSf//+xSU1cIXdm9evIQxVVTVKjJOVlYcw3r57gxJEd+/e+fDhvYCAYFBwuJKy6pcvn8kwnYOD08jIhIGB4evXL3fv3EYpixgYGMzMLauqG5iZmSkMk////0/o7963dxd6afr06ZOLF84LC4sKCAqwsrKSYfSP799v3Lw+ZXL/8WNH4IKMo+2iUQtGLWAAAF+bl8wfp8TfAAAAAElFTkSuQmCC"
    m["dark_bg_exit"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABgklEQVR42mMUE9NioCVgYqAxGPoWsGAKCQgIdnT1S0vL4NH2////Pbt3TJrYS44PtLS08ZvOwMDAyMhobWNPpg+YmJkhjBs3rr958wqXHw4e2E+mBXCwccOaI4cPjiZTyo3Iyy9evWazi4s7rSywtrHn4OTMKyhxdfOkiQWzZ079//8/IyNjbl4Rph1UsGDPnp2TJvXC7fDy9iM2mcIBv4CAjo4eIyMjLgU/vn8/feqkmbkFIyNjRmbu79+/d+/aToIFnZ390jKyRHoI4o+7d27du3d3gAo7TFBeXog/iBgYGBwdXc3MLSDl4ORJfRDnE2vBxw8fjh45hEeBi5uHqZk5xPQZ0yfDI4BYC/ADFxf3vLxiRkZGiNuRTadOHKSmZ+MynToWHD1y8Mf375Mm9GCaTp0gmjSxF0/VNiwrfTjwDwixtrHDVWUeOnDg+PEj5Fjw7+9fCENDQ5OBQROXTiMjs+OhR8gJoqvXrjx98hi/tv///x85dICoomm0bTrgFgAAZn6STVMS75cAAAAASUVORK5CYII="
    m["dark_bg_eye"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEbElEQVR42u1Wa0ybZRQ+5dKP0NIbvY1SvlIqjJYy7Eo3xQ2K7KfBRecSFyMOhsRpTBzLAMetVIYOjf5wk42p+6G44UbcTMw2LgUHXSkEndwKCK2BtrAMeqEMSlv88ZKOIQO2ZPEP59d5zznveb73fc57zkdgs8XwLCUAnrFsAfz/AEEbRkRG8l9M2ZuQIMUFQjKZDACu2VmjcbS392777baJifH1txPWKVNBdHTWO7kymZxAIKwZsLS01N2t//67WpNx9MkAgoOJbx5669X9B4KClo/odrtNxrGZmWkAoNMZuCCaSCQil8fjuXrl0k91PywuujcFQKczSsrUIlEsWvb1/nXtlytdXXq3e8EfQyRi8mRFZuZrYkkCsgwPGVTlJ222mQ0AIiJ4KvWnHA4XAOwztnPnv25rbUEuCoUahQsAwGQcczodyJiW9nJO7ntUKhUArFZLaXGB2TzxWIDwcOZn1V+x2RwAGBwcUKuK7XYbsr+dlZ2mzPCToddpa2rOTE5aAIBKoxWXVMTFxQPA1JT1eP6H0/fv+3MGkkgspIWEhJyq+pzHiwQAvV6nKvt4bs4FAHw+/4svz8Ztj19JNS+Sr0zf16nrcDgcC/PzrZpmoVAUwYskkchJSbLmplter3c1wPsffPS8TA4A/X29FeXF/hs/UVgSFYWjM9VfruvS68LCKEwmC8MwHI9uarwJAF6vV9vRLk1MYrHYdDqDTg/X6ToeAVAodmcdPgIA9+5NFRUce/BgDrlZbE7uu0cB4O4fPUWFx4aGBoeHDU2NNyQJUg6Hy+ZwGxtvzLlcCKNTp01NSw8NJcXEiEZGhswT4w9f8uGcPFTX1acr/QQCAB6FI6W1rcXn8yHd5/O1appXBQCAw2GvPl25tLQEANk5eWu3ise9qU0K4T8Jl9cXzteg7Pn5RRQK1e82/WNCilKZERAQuLwnIFCpzFgVAABUKi3/RCH6xAu13zzCgdk8zmFzhDGiUBIpXpzQ1tqCymDO5UqQSDncbWwOR7ZTHhxMjI3dnpt3VCyWIGKuX29AiTAMK1NVRfFxALh187eGq/Wrq6inpztZsZtOZ7BY7JgY0R1tO8IwGAb2pioxLITJZMmTd8mTdzHDmejGKz8pQ4RhGFZQVJqYmAQAo3+PnKpUrVGmXq9Xp9OmpOwhkcgRvMgdSTKdTrswP+90OjSaJhqVJhAIVz40tbrUarWg1lJWUZUo3QEAk5PWk0XHZ2ed67WK8ooqLncbANjt9tpzZzSaJuQih5EFuBAAjKbRWefsMjfp+3KO5CHaLBZzaUmBxWzeoNnRaPSSUvVzsXFo2d/f9+u1hs5O7cLCw2aHYZhC8cIrmfvj4yXIYjAMVKiK7TbbZtv1GwcPvX7goL9dezyesbHRmelpAGCEMwQC4UrXz/V1ly/9uLi4+GQDBxcIs7Kyd8oV6wycrs47Fy9+azKNPc1E87Py0p5UsUSK4wIKhQIADofDZDL29f55+/c2i8X89CNz67dlC2Bz8i+zYsHFE64vhwAAAABJRU5ErkJggg=="
    m["dark_bg_eyeoff"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAFB0lEQVR42u2WW0xTdxzHf396PS0Wastpq4i26nCAbYHSUhGGG0oUIlu27JLsYTNu0QeZ1y3TmIhuXpbJjLrN7WlvSzaXZRhlAqNSLrWACshUpC2Xnqr0QltZa4v0/PdQLVdFjb4s+z2d88///D/n+7t8z0EkmQYvMuLgBcd/DFD+yY5fT58pKip+jgAGn58Uu9m+83OCx9PlrnC73Tar5bkA0MQuKioqLt+6EyGEMT5xvLK2pjq6LpPNe/W11Uplplyh4HIJn8/roOydnR1NTQ2UffApFNhsVpfbpdPpEUJand7v9/f29hAE79SPP2VmaZJIksViIYQIgiAlUqVSXVpalpaW7qAoj8f9RAAAsFktLrcrV7cCIaTRaP1+f3+f7fU33mKxWKFQ6Mb1axZrbzAYEAgEDAYTAKSyeWuK1yYkJHZ1dUYikekA5vSlWw4qNBricrgIoU2bywFga/kmqWxe99XO+/fvR/ewWOxsTU5Z2ZsZy5UIoZLSsrT0jAMVe10u5ywKMpar9lUc4nK5AIABR3U4HFSj0UDTdGwbTUcoyv5X3Xmr5aZSqSYIQiicm7eyoL3NPDJy95EAhWLxgS+PEAQBANXnzlSfO6vV5cZy1dvbM12uw0HV19e+lLqMJCU8Hj9Xn9fS3BgMBmYACAQJBw8fTUhIBICqP3774dRJm7U3VvOcHB2DwezqujKdEQ6HjA31cvmS+cnJPB5fpcoy1NeOjY1NBezctTs19WUAMBobTp6ojNX8n0AgO1sDgDLSMx6lg6ZpU0tjerqSlEgShUKRSHzxYvMkQH5+4TvvvQ8AgwP9+yv2xPgAIBaL8/MLAQAemyuaplvNpvyCQj4/XqFY3NdnpSj7uFV8sGEjAEQikcrKI+FweOKTfH78gyMwRght2rxlXcn6GVt+ZOTu0a8PYYwBYONHmyd5EcbRV0QcNnvKY3fu3I5eXO28jGdjPDhoehe5nM78gkKEkEqdaaivGx0dFzHscRcXryMIgiSlLS1NKQtSEEI5Gi3G0N3dNfGs+Hj+vv2H58yZAwDHvvnKQdnHARQ1KJXK5IrFfH58auoyY8N419M07XI78/IK4uLiUlIWAkJRsUql2u/3xerBZDJ376lYujQVAAyGutO//Dy1izo6Luu0+sREISmRyuVLTC2NMcbg4IDL6czM0jCZkyZ/Ys237fhMr18JAHbKfvCLfbGZHweMjY21tbfmrSzg8fjzk5PTM5TtbeZwOBTzwdqaPz0et8/ns1huDg70yxcpYjPoGXZv2/YpAPh83r27d3m9wzNPcjAQaG8z5+rzeDw+SUpWrSq6ddsRTSUAhEL3em5cv2hqNptNJlNzbAY1Gu3Q0B2v14sxffjgfvtkA5/qRSMjd1uaG5cr1ULhXIIgCl5ZpVJlBu8Fh4aGJpolh8MhSYlCrhAIEhBC2RptTU31yeOVPp/3cR+cWLDZnA83fFxSuh5FSwowOjo60N8X9X2RSLxwkZz9sKExYAQIY3zq+xPnzlbN4qbRiEQil9pb29tak5IkUpkMIcRgMEQicfKClOQFKSKRmMFgAADGuOPKpZqaapUq81GeODPgwQQMey4Y6owNBr/fS9OYzeZwuVyMsc/r7blxrbb2/HffHquq+v3a391ut1v7sB4up9Nms86SomeI1WvWbinfjhAKBALvvl32RAqeKmxWi8vpVKuzjI0X2sym56/g/3/TZ45/AX58Rh9SwjIcAAAAAElFTkSuQmCC"
    m["dark_bg_film"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACSUlEQVR42mMUE9NioCVgYqAxGPoWsCBzjI1Nw8KjlZRVODg4yDDr+/dvN65fW7F88bVrV+GCzNzcohCWi4t7eWWtmJg4CwsLeY5lZWWVlJRycna7f//e0yePIYKMkFTEwcGxcPEqLi6uv3//nj9/9seP7zY29gwMDG/evL5x4xoeQzU0tERERBkYGI4cOcjDw6uvb8jIyPjhw/ukhKjfv38jgkhJSZmLi4uBgWHF8kUrli9lYGCw2WrPwMBw48bVzvYWPBaUV9bY2DgwMDB0tjczMDAkJqUGBYcLCAgqK6tCXAaNZCFhEQjjyZMnlETprVs3IQxRUTH6piIuLh6olytqyytqyTBo89Y9yFwuLm4UH4iLi1HX4WLi4ig+ePDgIYRx48b1N29eMTAwQFIR8eDIkYMMDAwiwiIamtoMDAwPHzxAseD//78QxsYNa44cPghPRcQDSCqytrGr0NRmYGD4///faGE30oprRkZmCMM/IMTaxo4Mg8orayHJFGYgE4oFCgrysNJRk4FBkwwL0PKNvIICwyGkIHr58hV1Q+bVy5coPvj27Qs0v3Q0QzIaWtlCEPh6u0AzWmUdAwPDt29f6ZuK3rx+DWGoqqpRYpysLDQu3757g1JlsrKyzVuwVEBAkIGB4cKFc1++fCajyuTg4DQyMmFiYvr69Ut8bPjPnz8RFjAwMJiZW1ZVNzAzM1MYJv///5/Q371v7y70VsXTp08uXjgvLCwqICjAyspKhtE/vn+/cfP6lMn9x48dgQsyjrZNB9wCAMDFvg1Oys/BAAAAAElFTkSuQmCC"
    m["dark_bg_finish"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABy0lEQVR42mMUE9NioCVgYqAxGPoWsKDxraxti0sqbty4vn3bZgYGBk4ubilJyXv37v///5eBgUFcXIKBgeHlyxcMDAyMjMxKSorPnj///u0rRO+PHz/Onzvz9+9fZAMZ0SJ56rQ5cvIKZLt3xfKlS5fMxxdEXNxclASIjKwMgSCCg86OZgYGhvKKWgYGhhs3rm7csE5DQ8s/IJiBgWHjhrU3blzzDwjS0NCGqywrr2FkZCQhko8cPnjk8EEI+82b10cOH7xx4xqEe+PGtSOHD7558xpT5QCkIvRIXrpiDR+vANnGXb92pay0AJ8P2Fg5KHGvkJAIgSD69v0bNGSPHDxyBBYHr18fOXLwxo3rsDi4fuTIwTevX6Oo/P+fgYHh8eOHBCz49/cPNBW1N3e2N0NNvHm1s71544Y1EO7GDWs625tv3LyKrPI/JK/9/DHQRQUclFfWwtkaGtrllbUiImIQrn9AiLWNnYaGFrJKrJkAnwU2NvZwtoiIKDJXQ0OTgUETq8p//wjlg1evX5EdGj9+/DhyaD8BH7x7+wbC8PV2Ga1wRi0YtWCoWvDk8RMGBoanTx7TqspkZmY2NDS+fefWxw8faGLB0IsDALiss0c3qWk8AAAAAElFTkSuQmCC"
    m["dark_bg_flag"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABYklEQVR42mMUE9NioCVgYqAxGPoWsKDxraxti0sqbty4vn3bZiKN+P///5Urlz5++IBVlhEtkqdOmyMnr0CqM58+eZyRnkhkEDGSE9DMzMQG0aPHD+Xk5RkYGDo7mvEbyszMnJVdwMXFxcDAMGfWNGItYGD4B6GOHD6I34LQsAiI6ceOHj516gSVU5GomHhYeAwDA8P3799mz5pK/WSakZHLwcHBwMCweNG8N2/eUN8CbR1dBgaGv3//Hjl8iCYZbdPGtZB4TkxKpYkFq1ctf/zkMQMDg6OTq4GBEfUt+P3797TJE/7//8/AwJCZk8/KykZsMmVn54QwyitrCVrz/ft3Li4uKUnpsPCopUsWEFVUzJ67REJCglQPffv2LTzUj6ggevf+Damm//379/Ch/cQG0bu3UAt8vV1GK5xRC0YtGKoWPHn8BNIMoZYF6IUdMzOzoaHx7Tu3cDWkKLVg6MUBAMa9cJQstsrQAAAAAElFTkSuQmCC"
    m["dark_bg_folder"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABdUlEQVR42mMUE9NioCVgYqAxGLWAIGBB5piZWVhZ2bJzcmAo+3/k8KGjRw5RZEF0TGJEZDQudZaWtp8+fbp86QKZQSQmJhEeEYVHHTMzc3lFraiYOJk+UFZWYWRkZGBgmDF98tYtG9EUpaZl+/kH8vPz19Q0rF69Ao9xP75/v3Ll0o8fP9AtYGZhhjA+fvyAqW3+vJlKSso6unpKyqrlFbX4nfzx48eOtsYrVy6RkIr+/PnT0dH0+vUrYhTz8/NXVNRxcHBgSUX43PXhQ3Fhjpa2DiQkcacFazt7J35BAS1tnXNnz5BgAQMDw/v374hJqXb2TgwMDFxc3KNFxagFoxaMWkCqBf///4cwGBkYKTGOkRHdQGhh9/r1awgjNj7JysaWbAtUVNQgjFcvX6JYcPvWjStXLuno6ElKSklKSlEYLFcuX7xz5xa0KuPmFoWwTp48KiAgKCkpxcrKSrbR379/O7B/76SJ3b9+/YIG2mjbdMAtAADteXGUjvTryAAAAABJRU5ErkJggg=="
    m["dark_bg_gamepad"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADmElEQVR42mMUE9NioCVgYqAxGLVg1IIhYAELGl9BUdHCwkZGWpaZlZkkg/78+fP0yaPjx449fHgfWZwRnpN5efly8oqsrGwoce////8PHz40fVr/l89fICLM3NyiENM7u/t1dPQoDBBGRkZ5eQUzU4tDh/b9+vUL4YPK6gaI2x89fLBgwZyLF85zcnGqqqidP3/279+/uIyTlZVVUVE/ffr4ly9f2djYDQyNEpLSZGVkGRgYDh062N3ZDPWBgqJienoOAwPDw4cPykryHz64//fv34kTp/v6BzEwMF6+dAGr6e7uXo3NnZZWNp5efgcP7v/86ePTp08O7N9rbmnNz8cvJyd/7OiRjx8/MDEwMFhYQMN94YI537595RcQsLaxk5aRZWBgMDA0NjE1Z2bGEuF2do7fvn75+/cfNze3sbEpRPDr1y8L58+GhJW5hRU0mUrLyECkL108z8DA0NnZX1FZBxHR0NCsb2iNiIzFtODh44ecXNw/fnxnYGAwt7DKyy+Wl1dkYGC4ePE8RIGMjAw0mbKwQB348+dP4uNz8cJ5nz6+V1XV1NLR1tPVY2BgMDYxT4yP+PH9O0QBKxsrlnzAwMBQXl6oo6MH8cSNG9d37dquq6NXXlmLpuznj58rVyzZumXzshXr3r57w8DAICwkws3N8/nzJ/SM9vv3HwiHg5Pzx/fvHz98OHrk0NMnj6VlZC9fuhgYGCwrK4/VE6qqasVFORfOnzUwNGZgYDh39sznz5+4uXkgsr9+/oZa8PjRA4iQjbXdnj074f5QVVGztXPEZToDA4OcvEJ6Zm59XZW+gSEDA8PFC+cZGBisrG0hsg8e3IdacOjgweiYRGZm5uTUjBcvnl+5comBgeHL58/qGlpOzq4MDAyvX7/Kz81A9jsvL9+kyTNFREVdXNxfv3q5YvnSf//+MjAw6OoZJKdkQEqOI4cPIDJafEJySGgkRPPt27fevnmtoqomIiIKUVpZXnTjxjU052tqard19LKwsDAwMLx5/frOnVvCIqKqqmoQ2RXLly5dMh9RVFy+dElISEhFRY2BgUFYWFhGVo6Li5uBgeHH9+9dXa0XL5zDDJ83b14/evjA1MyChYWFi5tbRlZOWFgYIrV168aF82f///8fpbCDZCtf30BNLW1ubu5Xr16ePn1y3ZqVb968xpNYRcXEg4PDTEzNRUXFvn79cv3a1c2b1l9AchDjaLto1IJRCxgAbnFUZI6wjbwAAAAASUVORK5CYII="
    m["dark_bg_gauge"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADV0lEQVR42mMUE9NioCVgYqAxGLWAIGAhRpGUlLSWlo6UtCwfHy8DA8Pnz5+ePnly7dqVZ8+eUmQBGxu7h6eXh6ePrKw8VgUPHz7Yvm3zrp3bf//+hcsQRlzJ1NzCKiMzV0RElKAbX79+NX3apNOnThBrARMTU2JSWkBgCIT769fPY8eOnDl98t7d2+8/vGdgYBAQEFJWVjE1sbC0tmFjY2NgYPj////6dasWLpj7798/AhYwMjIWFJY5ObtCtG3bumn58sUfP3zA6joBAcGo6DgPTx9GRkYGBobdu3ZMntT7//9/ZDXM3NwogRAZFefnH8TAwPD165fmprotmzf8/PEDV+Cwc3D8+P794MH9pqYWbGxsysoq//79v3LlEk4LNDS0CovKGBkZv3//Vl1Veu3qFTxBLyAg2D9hmpe334vnz5csmm9v78TCyqqjo3fu3Jm3b99gyQeMjIxp6dlMTEwMDAyTJ/bduX0LX+JjYSmvrBUVFYNovX375qRJfZD4S0vNxJ7R9A2MVNXUGRgYTp08cfjwAfwpJyU1U0dHj4GB4d69u2tWL2NgYDh8aP+Z0ycZGBjUNbX09A2xWODm5glhLF++CL/pjk6u3j7+kBzX1tLw8+dPmMYlEIaLqzu6BUxMTIZGxpC8gz9wlJVVcnILGBgY/v79297W9PLlc7jUrZvXHz95zMDAYGJiBklXiJwsKSnFw8PLwMBw6eI5XEabmVu6unoYGpmwsbEzMDDMmzvr8qULaGouXTgnKyPLy8snISn5/NkzhAUSEpKw3P8Qq+nePv4Zmblw7u1bNzdtXIup7PGjRxCGuDjUAmgQcXJxQRhfv37BakFYeDQyF1cR8vnLJ6iBHJwocfDnzx8Ig5WFFWuiFBAQQBbhFxBgYcFSULKxssEM/Itiwfv37yEMUTFxTG1//vy5d+8OssjdO7fhbkIGcO3vP7xFseDRwweQckpDXQOr36dM7v/wAeqIDx/eT53Sj1WZuoYmJIE9fvQQJRV9//7t9u2b6uqaegZGWHXevXM7PTVBT9+AgYHh0sUL3759xaoMkvtu3boBzxyIjLZ+3eqfP38ePXIIVzL99u3rieNHTxw/ist0BgaGo0cO/fz5c+OGtYQrnNFWxagFI8gCAMQJRCnjwUMmAAAAAElFTkSuQmCC"
    m["dark_bg_gem"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEf0lEQVR42u1We0xbVRj/3bZ3tGUFeoFSCrTlOdnkuQHDQXmkmw4yl2jUiHGJ0bE4MlEECQ+dwIayh0UmMGCTJUs2zaIGFWeUDeQxWIHwLIk8tzHGQ1aEKS31lusfN9EyGbCExZj45fxzzv3O9/vOd87vdz9CItmMR2kcPGL77wPwll2NiIxKfjONz+evMYrRaCwqPNHQULemEzg5Ob+R/PbaowPg8/mHklOkUud/fuJaWzsuAeRw3z2cJ5O5AOjt6bpxY1jm4koQhF6vb2/X3rp1kx2ijTYCgYBhmFZty8yMXuIkJUnS22fTlZofGYZZCeC55xPU6l0A+vp0mRmpJI/cHr4DQOWn5ecqK5oa69mxYFoICQkjCOLSpYtnz5T5+QVInJwcHSU0Tet0PQ8skaeX94sJLwMwGgyFmoLFRXNIWDgAhmFatc2WntdbrrGZhoaGLy4uFmqOz8/PA0h4aZ/PJt/lAUhyQ0pKOo/HA1B2+pPxO3dIkgwKCgYwMjw0PT1tue3u3emRkWEAwcHbSJKcnByvKCsGwOVyU1Mz+ALBMiVKS8/w8w8EMND/c09vl1yhDA0N37otFMDg0IDZbJYrlJZDKnV2cXHlkaTJ9IeYomgz7eDg4OAgEYlEMpmsqbGeDUuwUqFSxaSlZ63j8z9ecLS+vvbvEt139etPtIaGOj//gN1xewDMzc2eqzxrMPxOUdT+xCQAAwP9X37x+X07n3n2BW9vHwAV5cV6vZ5vJdj3yqtiOzGAy999w6a/hMmlJUXWG21UqigbG1u1eldWZipN00/FPe3m6ubmJm9r0xoNBktmJSenAhgbu/111VdcLjf3SAEbvbm5sbSkaJlXxDDMx5pjg4P9ADZvefy1xNcB1F2tYcNtD3vCMv3w8Aj2qVy98gOA/QcO+vsHAhgZGfroxIeWBV/CA5NpIf9ozuzMrwDi4/fujttTW1vDesfE7rT0jIlVszn9VFerVj8ZH78XwL17c/lH3jcajStp0S9Tk/n5h2maBpB4IEkqdWaZGRS81d7egfWhKPuAwGAAut4ee3sq6dBbAGia/iA/d2JifHWx6+vTFZ/SAODxeBmZ77W3tQIgCCJSFc06REXHcjgcAG1t1zMzc1hulpcV93R3ri52rA0PD9na2fr4PGZlZSUWU0KhgMvl2dmJv7/8LYCDScliMWUymSiKkspkAKqrqz67cP7hfjgVZSXdnR0AFArl3G9zADw8PJXu7nK50t3dE8Ds3Ky7hxeAPl3vmfLSB8VZ/gTsBWq1LTsiVCKRSMi3BgFWBD09vXx9twCwFloDmJqazM56x2CYf2gAACaTqaOjPTZ2J7mBZAACkEilCqW7UCBkp0aDITs7bXJiYgUmrwTAsnp09GakKpogCABCgVAoEAIgAIZhNCcLurs6V5aKVQAAjN0eZRiwPLK0ixfOV1dXrapFqwMA0Ol65HKlXK74a+VaU8Pp0lPr1rYwDFOoOabX69npzMyMRnNsjQLMWXtjkpebTZtps5nOy8myFL6Vjfi/N/3XAf4EwU692N84LcoAAAAASUVORK5CYII="
    m["dark_bg_gift"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACS0lEQVR42mMUE9NioCVgYqAxGLVg4C1gwSMnKSkVE5csLi724tnzfft3nTt7Bi5lbGzq5OwqLiH58uWrxQvnvHjxHJchjLiSKR8f/5x5izk5ueAiO3dsnTF9MgMDQ2ZmnpuHF1z827dvKUkxnz9/wmoOMze3KFYJVzcPC0sbBgaGly9fcHNzMzIyqqiocXFxGxubeXr7MjAw/P////Xrl9zcPKysrK9evbx9+yZpcfD/P5Sxds3KspL8Dx/eMzAw+PkH+vj6MzAwvH//rrQkf+2aVTDF/4mKA2ZmZnUNTSEhYQYGBnY2dgaG/wwMjFnZ+Z8/f/r+/Ruyyt+/f9U3tPDy8kHM5+TgtLG1Z2BgeP369e1bN//9+4slDjg5uVrbulXV1ClMNteuXqmrLf/58yd6EPn6BVJuOgMDg5a2jrdPAJYgUlBQhDA6O5oxtXFz8xjoG9jYOTIwMBw5tP/CxQtfv37BVFZeUcvAwKCsrIzFAkaYZ44cPojVaV+/foFYcPTYEVxqIBYwMTMNRE5+++YthLF56x78esoraiEuxQXgRqH4YPu2zT++f6fcyb9+/dy5Yxv2okJGRramtlFaRo6BgeHIEfRQFhER09DQZGBguHHj+ps3r9BkbWzsGRgYnj590tbS8OjRA+wZ7cmTx/cf3INY0NmOnpZsbO01KmoZGBg2bliDGck2W+0ZGBju37+DbPpohTNqAW3rZDz5mWBOxueD799+UOLen99/EvDByhVLGZkYOTg4yDD9x48fK5YvIbZVMZqKYAAASHzQCCS6RrcAAAAASUVORK5CYII="
    m["dark_bg_globe"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAFCElEQVR42tVWa0yTZxR+2q8tW4v0Yu/gpeBcwRUENq0IA6oEiSTLhAUhmOkf1LllOpNdCJn8mJdNcTObbNFMl+k2XDIXp1zmkIuoqBtrRwdmuoLTQltbUItFeqHdjxdL+62iJvpj59fJeZ+c533P7T0MqTQJT1KYeMLCekhcTAxfNF2k0aQgEOg2GoeHHCMjzsdAoFAqdbq8hdoMlSqBdtTXZ7pw/mxrS7PFMjiFB8b9ciAQCFeWlefnL2exprqEz+draqyvqzt0+9atiACKx5P815qYOG/7hzXJyfOZTCYAl8tlvv6PUDQ9CPjbdDkq6ikOh8NkMuc+q87VLb3U2+Nw2B8qyVlZOVu37xIIhABsNuuundvKy4rG3B4AHo/b4/EAGLs7Vl5WVLNz+40bVgBCoWjbjprMrOwHEyQmztu0+R02mw2gof74uorV7W0tvOhotToRgEGv7+42AEhKeo7L5bW1nVpXsaap8QQANpv91uZ31eqkqQj4AkFlVTXxfuDLfZ/X7vH5fADS0xeQWF282HnxQicAJpOZlvY8AK/Xu/ezTw4e2E84Kquq+XzBfQlKy1aRyPxysvHHo98H7bNnq4hi7DYYuw1EV8XHBwFHfzjS2HCcxKqktDwygUKpzM9fDsBqtdTu3RMKiouNIwVjs1mtVgt5VlzczFDM/n21JB8FBYVyuSICgU6XRyry8KGDxMUkwYxZACyWgfHxcZ/PZ7NaAMTGxoVivF7v4a+/AsBisXJ1eREItNpMUpFnz5ymJUoskQCwDk40FOksiVRGg3V0tLlcdwBotRl0gpgY/myVCsDvXb/Srs9isUjaXXdHiWV01AWAw+FQFEVrOr3+NwCq+ITo6Glho0IsFhPFH/DTyjkqKoooQoGIHAn4QmLJzlni8bhDwX4/AwCDwRBLxHfujEyOisLCl9auf+MxDtEvaj+trz82GaJA4DFP6QACYSHq7TVOJOp027lzHbQQbdz0NoA/DPqmphMACpYVJs9PBfDx7o9oIVqc+WJmZjaAnp4/wwiGhoaCoDMd7bQkE4Kbt4bJ0aJFi8lRe9up8fHxcIIsAIFAYOje4JsIkdN5u7/fBCAt/QXafPb5fF6vFwDvaS6xcLk8AB6Ph+adzWanpS0AYDJdIRkO64PznWcB8Hg88sZQcdjtAORK5UTPK5QA7DdsNFhmVg6XywVw4XxnhEZrbWkmHbDq1TWk8INiHrgOQKGIpSiKxWLJ5AoAAwPm8OtzyletJi9ubWmOQGCxDDY11gOQSuUbNmwMI7h+jSRDJpPL5QoSQ7P5WiimYu1rUqkMQEP9MZvNEnma1tUdunlzGMCSvPwVRSVB+9Wr/UTRaFI0yfOJ3t/XFwQUFZcsKygEMDw8fKTu2/t+me6xsUu9Pbm6pRRFpaami0Qig77L7/c7HPaXV7zCYDAYwIyZs5TKWL/fX7t3j9vtZrM5619/s7h4JUn7lvffGxw0T/UnOxz2gQHzwoUZFEXNeWZuri5vxOk0ma6kpKRKpFKJVCqTySmK6ukxnvy5ITtnSWVVdUpKKvG+u2aHQd/1UFuFWp1UWVUtFIruTbdRq2UwPmHO5M5iuiJXxJKaIZHZ+sGWy39deoS1hc8XlJSWFxQUPnBtaWz4qe67b5zO24+2FxGRyxW5ujytNiP0+sFHdHaea21pDq2ZRyYISnT0tOliSbJGA6DbaBxy2IO9OrUw/vfb9b/PQvc5obq8VgAAAABJRU5ErkJggg=="
    m["dark_bg_hash"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAB2klEQVR42mMUE9NioCVgYqAxGPYWCAgIzpi1YMasBQICglgVWFhar16zOS+/mEwLDA2NpaVlpKVl1NTUsSpwcXHn4OS0d3Am0wJxCUkI4+27t1gVSEhIMjAwvH37hkwLxMTEIYyXL15gVyAuzsDA8OrlS3J9ICbOwMDw/fu3L18+Y8ry8vJxcnIxMDC8evWCXB9ISDAwMLx88RJHAEpAGK9evcJlAgsaX1lZRVJKGs4VERFlYGD49/+fja09pmZlFTUIQ0hICK7gx48f58+d+fv3L4TLiFxUKCkpT5g0g5GRkcK0v2L5kqVLFtApozGiFXbIQaSnZ+Dp5cvAwLBmzcq7d25hag4Ni1JSUv7z509vTztcEC2I0OPg7t07d+/egbBlZOQgjCOHD9y9cxvTgoiIGAYGhtevXx05fJCcVER5JiBgAeWZgJAPKM4EKHHAzMxsaGTCwcFBSSZ4/uwpPArRU1F0TEJEZAyFifL///8FeRn37t2lX4WD8AFaEJGXCTCDCBEHf//+PXP6JJxLlUyAL4iokgnwWUCVTIDXB9TIBPgsEBISZmBgePnyOXZZQSFYAD4n04KDB/b++P59z56dWGVv3rrx9Mnjp08enzt/hrTierTpSH8LAMb82vb9zws0AAAAAElFTkSuQmCC"
    m["dark_bg_history"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAETElEQVR42u2WW0yTVxzA/+f0RjWRtkC5RKDFPW2TUpCV3mg7SVyyLVlWwhIVrGO3CGOybjHuQZPNJaJjc3h5cMRitmTDlGzZFLkYkCKypxGKFV0CvXArgwJioYV+7dnDh02VljoSsyzZ/+k75/y/8zvn/K9IKHwenqVgeMby3wcwIwc1HxnVam19/cnf+/vCkynCVI1Gm5srzczK5vH4APBgccFpd1itAz03u2ZnZzYGoEgj/3q1EyHUa7l5qu4EvbXBUKlSazGOftFQKGSxdF82NW6AeewGCCEAQBgAQKN9uar6MJe7hV6iKMrhGPXMzgJAUnKySJTDZDIxxlrtbplMfu7sN5ae7viAsOhL3zpgeIfmOR32FnNzf/8tv98fVkjgchUKtV5flpUt4nK3fPLpZwJB0i8/m9dvxdi6NSU82LuvAgAQZmg0OoRQKBT64XtT/Vd1dvsIRVGRv1EUZbePtLddCwSonTslGGOptGBiYtzpdMQHJG5LpLc4ferLtutXCSFrqgzG/nKDRCK13RmiJwkhNtvQxPiYXKHCGOfn7+ruurG8vBwHsOa/GKvUmr37Kt7Ul42NOcfHxwoKCquqa194Mff+veHJyYmwpsvlCIVCEomUxWLxeYLbt3tjx8Gjw0ZKQkJC4S4Z/e5hAzyh02L+yeV0AIBao01JEcY0cktLs6pYO+5y+fy+8KTf779y5ceNnT0YDJrNzR8bj2CMizW6FnNzdECTqbHJ1Li5iO3vv0VRRiaTmZsrjQQ89kR8vqDwpSIGg7EJgN/nczhGASBbLIppg7rTZ44dP7G/3LC5S9BhmLiNFxOQlpYOABkZ26MnhmCQ/jj49nt50oLNZNPFhQd0JoiqeveubXraDQBCYernX5ys/rA2nEhoESQlA8DDxcWYAOeYAwDE4h1sNmc9YGFhvqb6/bb2VkIIQmjPK6+ePX8xkccLe7NIJAYAp9MeEzBkHQAANpstk8mjXmJ5eel8w9fHjx2dmfkLAFJT03JynqOXZEUKFosFAFbrQMxI9ng8r73+BkIoPT2jo72VRIs7AHBPTXZ2tAEg2x3rjc42QgjGDKPxKI/PJ4ScaziztOSNDvB6H4pEOZlZ2XyBwOfz3Ru2xTJdIBAYHPzDOjhAH0JfWqbV7QaA3l5LR/u1jUqm6dJFOi0fMFQWyZVP4ycKpbq8opIOhcum7zbKpgDg9Xrn5maL5EqMsVJZvLKy+uf94VhvhTFDX1p2qOowXfIavq232axxAABgHx0JBAJ5efkYY2l+gUwmX/J63e6p4KM4AAAOh6NUFdcaj+h0JQghQkiTqfF6629xanKklJTs+eBQDYez5q+rqyv2kRHPnIcOFLF4B5vNDieJCxcaurs64xf9JyQ9PcNw8F25QkXXzvVCCOnrszRdapyennqqriIWRqPVSST52zOz6LZlfn7O5XRarQOWnm63e+oftC3/t47/CuBv4h6275f2wCoAAAAASUVORK5CYII="
    m["dark_bg_hourglass"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADsElEQVR42tVW7U9bZRT/Pfdyb7m9uDKyFz+4zI31hfJSu3V0OhmvEpOOgMYphJawbMPsxRBj4mKMsmRU52TOOaN8YJE4yIwzGwwYumH2DyAVGeO2ZUrbDdzWdhEFZsu99cNNZlVobXExe7495zznnOec33kjq1bp8SAPhQd8Uhak0jRt3Ghau/ZxALdu/RxDfvXqRwF4PBOOoUFRFP+tgeoaW3WNNaGffnGms7Pjs/8hRGRBkGmaLi4tb2x8DYAgjHV3fbWgcGXVCzpdFoATx1uuXLmcQIhEURy41G+xVGzYoNFqdb9OTw8PO/72xmAwarU6AOPjroGBrxfzgOb5lYvx/HduFxWXEULMW7ZO/PTj5OTN+yyTKf/gG2+zLAvgxIfvT01NJmNgamqS53mdTs+ybGFRCUCEsVGKol6qth545VVZ+/lzZy/29SSMwZ85QFG11vodL9YQQgD4bvgArHlsDYBIJHL2yzOdHe2SJMXQEMsDWcsPww6v12My5acwjGqZSrVMBeDe3Nyxlnd7e7oikchSK5nn0/T6XFahiCYqUlPN5ifT0h6JKx7HgzyD0f5OyxPGjXKInM6xQMC/YsVKQsi6dZklpeXXr7tvxyz1WAY2bdrcdMjO8zwAv//Oxx8dP9XWevlSv8/r1eqylEqe47jCopJxtzNGFi0KMssq2k6dXp6RAaCvt7u9ve3e3Nx9birH1e/cbbFUArgbDO7eZQuFfk8MA7VGI2vvuXCu9dOT0dplkFs/OXmh+zyA5RkZao1mCe2aUDGSOPl54Ha5AkE/gIqKqn37GzlOGc3lOOW+/Y3bKyoBBIJ+t8uVMMiiKHo8EwXbiiiKUqu1JWXPBIMBr9dDCNlWWPxW0+G8PCOA+fn5o0eab97wJVnJOTmG1w++KYMBwO1yAlBrtPL1bjB49D371avDybcKAEolX2uts2yvomk62r++3q7Ojs9nZ2eWWsmzszOCIIRDoWhiOBQSBCGu9viVTFGUrW7Xnoa9DMMA8Pk809O/qFTpKQzz1NYChlGMjHwfux3FMbCnYe9zz+8ghEiS1HG6/YNjR/ov9obD4dxcA0VR2dk5PK8c+m4wSQOmzeaGlw8AmJn5zd7c9O3AN5IkSZI0OjridI7lm7ewLKvV6d0uIXoWJYCBzVYvd+zmw02Oob980zE0aG8+JAfHVrczmb2ouLR8faYagCBcS09Pf7qg8J/PBOFaVlb2+kx1Wdmziw39hdO01lr/8O9F/9XqSB767foPLtd0poj6qO4AAAAASUVORK5CYII="
    m["dark_bg_idcard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADCElEQVR42u1WS0wTURQ9M22ADAspSjek0hYKURFpQyEIFAQlKHHnj4CfhcIGA4h8VFyQEBMg8hNJdGWiJkZjAMUYISDURIHyK0gTwIC0hVIoLSDCBjouhrSlxlBK2RjO6s7Ne+e8uffMu0NwuYexmyCxy9gT2BJsS0QQRGRkVPDREI73fqfp5mZn+/t7+/t6rLSMi9hs9t2iYqk0wiWnbm35VFPz0Gw2A2B5evoAuHAxNel0sqvKIvQPWFpaGB0dsZZIFhsHYNG0UFiYo9VqnKYWiYJKHpRTFHUq8UzT+0Zrk319eQCGVUM7YQcwNjYyMNAHgM8XbGoySZIAzPT6JgOw2X58AYfjrVGr9Xqdgxpm85qFcJOL7BAYdCg7J4/HO8g8yuUdjx9VrKz8dt6mttjn5VV0v5jD8bZkZLJYAnRZaQmAqGjZrdwCNzd3u11trS2VFaUOfWgyWTzD3t7eWl1ZrtFqAMTI4phkmDTib3YAx6NiHH0Dvh+fCepqq1dXV0ASWVm3AfAFQpPJ+PrVSwKEu4edBv1F3uGogGHewATS8AhFd5dYLN3Iz80B0OmmqyrLdtSDHkXnpZQ0kiTz8u9ZkhqtZmpKC4DFYkkk4e4ebhsnp2nV8HeTybgNgYmJ8aFB5bFQsdV86/THpgazeR1A2uVr586n2K7X6abTr19x9DYlCCK/sMiWHQDJIm5kZMbITrjApgkJiZGR0QCWlhYb6t/o9XqJOCz+ZCJBEJk3cwaV/S+eP1MNq+xKtA2BpOSzANbW1u4U5KrVPwHIOz7P6GdS065SFBUbl/Cu8a1C8c35gSMU+AMYVA4w7AyamuqZwN8/wJmJxtzdJMkGYDDMARgfH7Ndt/xrWaebBmA0GrZgJFgWQmuJ1JOTfIEgNFQiEgUW5GUHiAL7ehV2O/+VtwWPxzsSHAJAo1FvEmhu/pCekUlRVEVVnUtmjryjjQk2JtqPsVEfLlcoDHAJe3dX59MntTRNW2cyA7EkTCIJO+Dj4zS1yTivVA50dX61H/p7P17/s8AfUaMWQZnxJ/0AAAAASUVORK5CYII="
    m["dark_bg_image"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADF0lEQVR42u2W3UtTYRzHf8/ZCdQJ6nCmbWPtRRLJtyzFu8KmuS2zP8CbyEzQXSwjtYsISitrDmcKvVwkYQbhndYso+k0FSKZcxaU5tycL1Mhs6nsnNPFI2vMpWxOIuh7cXie3zl8P+f3vPyeB8XFJcNeioA91r8PIH2BBIvPF/D5fILFCsiIpqjJyQmHY2Y7gPCg+FLlFZFIEvT/Wixjd+/cXFiY90SQZxWx2ZG6+w+43LhdjondNq2quLixse6bQe5JGXYfGDAa+wwMQwfkixAhlysPp6Tx+ILjJ3K79V2+AJFYihsNmttrLpf3rAAATVM7MkY+fmhr7wCApKRkP4CwsDAAYBjG4y4QCM+XlKWkpgGAyTTy6GGLbdq6DWBl5TtuhEeE/XEVeRQVFX2jtp7D4eBuZuYxiUSqKi9dXl4KzT5QKAuxu3nUZDabACA6Oib/lGK3++D3khWKAMDtdl+tuYwQvOjoJElSJBKHDLC4uAAAJEkqTxcRBCJJEgCczvmQAfp6DQplEUEQJRfKcISiqN5eQ8hq0fj42LO2VmAY3F1bW2tpbvz8yRIyAI/Hl8sLAaFNnsXc80bv/YFEmiiRJgYJ4PH4dbc0MRwOANA0DQAZR45W11zDMwEAsryCBm1zg7ZZllcQMMDbfXjovaq8dHlpCQCysnMwQ5ZXUKFSI4QQQhUq9fYMPwBv97ra61NTk9VVag/jnqYJuzMMwzDMjgxiS81C3u5utxsA7HabhyGWSLG7rlGja9TsyPCtRVje7ptF2G6rrlLj5LD76+6X+BVOqEKl9gtgsdlc3CouPhcZGenX3VPLBgf7I8Ijnrc/Nbx7i4MTX784nc6s7ByEEH4CgNX6rd/Y65vB3Kxjf3w8ADTpNFvdsRyOGa223ieIU8F54Mi6a93PEPUZDanpGQBQWVnzSt8V0IHjcv3U6zvz8xWYQVGUH0DPG33hmbMCgTA1PQOTghaL3OdnDmiaHh4eOpSUHBvLDdp6bnbWPGpqffJ4dfWH76HvUULCAZFIHMS1xTptnbHb8M73c6v4f3X8W4BfQ/VLc3OQTzsAAAAASUVORK5CYII="
    m["dark_bg_key"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADFUlEQVR42mMUE9NioCVgYqAxoLkFzNzcotQyS1JSKiUlg4GR8cmTx3BBRmrFgbS0THtHn6CQ0Ldv38JD/agcRHDTGRgYzp45ReU4kJKSbu3ogZh+5syp/r5OalogJSXd1tkrLCQCMb2tpf7379/IClioFTKnTh5vb2v88+cP1ZIpsun//v1btHAepunkJ1MZGVm46QwMDIyMjJaWNqdPn/j06RMVLJCRkW1r74WHzNOnT6RlZDk5Oa2t7U6cPPrl82eKLEA2/d7d27U15UcOH1RSUobYwc7GfurUccIWsLKymZqZu7t7Obm46esbioqJv3v79vv378imMzAwCAgKvXr16s7tW8eOHpaUkBKXEF+zZsVTpGyMPSfb2jkmJaeJiKBY/OfPn4MH9hoZmcLdrqikwsjI+P///472pmNHDxNbFkVGxWVk5nJxcaOnNiYmJSUVTk5OSLjX1pS/evXKzNySkZHxx/fvJ08ex2UBC5rbo6LjGBgY/v79u2njut27djx//pSPn9/UxDw+MZWXl5eBgeH9u3eQ9L571/avX7+YmlmsWrkMT5whgoiVlW3WnIUiIqJ///5taa47c/oksjpxccmJk2dyc3MxMDBUVhRfuXyR5PrAyNgEEu6bNq5DM52BgeHly+cNdRUQtpubBzkVjra2LoSxZ/dOrEpv3Lj2+PEjBgYGbR09ciwQEBSEMJ4/f4pL9fNnTxkYGAQFhcix4Nu3rxAGLy8fLtU8vHwMDAzfvn0jx4KHDx5AGKam5liVCggIqqmpMzAwPLh/jxwLTp44BikOI2PiBAQE0VMbI2NaejYLCwsDA8PhwwfIqfS/f//Oy8uroaHFxcllbmF15/atN29ew92em19iZ+fAwMDw/NmzKZP7/v37R6QFKEUFKytbW0evhoYmhPv48cNnT5/y8vGrqalD3P7j+/ey0vz7pAQRSlHx79/fw4cPSElJy8kpMDAw8PMLyMjIioqKMTExQdxeX1dBkuk4my06uvpubh7aOnpCQsJfvnx++ODB4cMH9u7ZibXOIseC0bYpPS0AAO9bKSHA5fwFAAAAAElFTkSuQmCC"
    m["dark_bg_keyboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACoklEQVR42mMUE9NioCVgYqAxGLVg4C1gQeMLCQsrKalwcHCQYdavX78eP3r4/Pkz7BaIiorlFZQYGBhR6OQjRw5OmdT/9esXCJcRkg94eLgnT50jIiJKlWB5+OB+YUHW79+/ET6IikmEmH7p0oX9e3f/+PmDDHPZ2Nj9A4KVlJTlFRRDwyKXLV2EsEBfz4CBgeHVq5cNdZUQm8kDp04dmzF9Ab+ggLmFNcQCaCqSlpFlYGC4c+c2JaYzMDB8+fzl6vUrDAwMCgqKKMmUiYmJgYHh37+/DAwMAgKCM2YtmDV7kaCgEAMDg4Wl9eo1m/MLSyEq8/KLV6/dYmVti6kSAv79+wM3EHs+UFRSlpaWkZSSUlZWYWBgMDUx5+DktLG2g8ha29hzcHCYmVpgqiQqHzAwMFy6eH7VyqUMDIznz59lYGBYtWo5MzPzqVPHIbL9fZ0W5lYrVizBVEmsBX///l28aD6c+/Ll8wkTuuHcE8ePnjh+FKtKEooKZWUVZRVV4uMWj3osFigpKfdPnN4/YZqKqhoxpuNXz4Jfs4CAYEdXv7S0DFbZp0+fVJQVklbYMTAw3Lt3tzA/k4GR8e6d24ZGJrhMZ2BgkJaWUVRSPn/uDFw9Tgv+/fvHzMzMzMwM4d69ewc5RUnhsOPZ0yeXLp5HVs/AwMDEyAwxEMWChw8fKCkpa2no8PDyfPn8BVeKIghYWdlU1dQZGBiePH6EYsGJ40eVlJT5BQXa2/s3bFj98+dPMsoJDnYOZ1d3UVExBgaGixfPoRTXrKysff3TFBQVqVJcv379Kicr9du3rwwMDMzc3KKQIDt0cL+YuKS8vAKFpp85c6q1ue7Tp48oPoADcXFJeXl5NnZ2Moz+8f37nTu3P3x4jyzIONqyG7WAYgAAyjL4GzYEJk4AAAAASUVORK5CYII="
    m["dark_bg_link"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD5klEQVR42u1WX0wTdxz/9kq863rXMuz/axfnHrawyVzmqMUNZpZNH/a2YQQzs8f9yRKHzGoRvHUKTIFI3Ja9jgkImZhIxIHCBibDERm1VLPtAdsKd1Dao+1Vu1Iu3cPNepxFaCNv+z5dvr/vfb7/P7+fTKcrhPUUBNZZ1t1BXu6hIXITSebnPx0Jh2l6muf5J+YAw7DyPRW7dr+rVqsFTSzGDfT3dXd13rsXkxjLsm2yRqN1njhpMVsePZqbmz1We3hmZlqslCuV2qzQG75uIU0kAEQWwgMDl4aHh/x+n15vVCgUOI5ve806eHUgmUzm4gDDsKaWb4xGEwB4Jm/a7Qeuj/72919/TkyM9/986dnNz5lMJI4TCCJ3ucZzmaKNGzUCutvtoo45YtzDcsfj9082HmdZFgDefmcXgshzyYDjomwo6PVOffdtayKRkJwuLSW1Ws3zLxSiKHZtZCgajWYxRRaL5dVtVoPByPNLd6amUBR71AEABAIB4QPHVWsdU3V+/iefHrDZdshksrRycTFx/qeurnPtktkXCggAkUh4TT3QanVNzWdKSl4XowPAhg1oReX+qmqHWEkQqtKynQDAsizD0KtnoNXq6hubDQYjAPi8dzraf7h9+xaKYsVWW+W+D3CcKC62po1RFHXUUAShAoDLfb2pVGoVB2J0t2vC6TyaLnrvxZ4/xsfK91SOjY2m0evqjr+0pQgAfD7vhZ7uVTZZo9HWNzYLBb3lmaQoxz/x+EqJCuhFW18BgNlZ5oi9KhicfxwXCbv6X+xul5OqyTgwafTaB+iBwNxRxyEJunQPMIWi8dRpgQnE6CU73njv/b1+v5fjOLFxXe1XL4tiDwTmVmHT8vK9Aot5Jm+KY/+8yo5hmHW77Vzn2bHfRxOLiRcLt1Ts22+xPCOgOw4fnJ8PZMzyYQ8QRN52tlutVkcWwh99/KGYCb6w15aWlmX8n6HpGkf1SujL9sBEkgK/D48MitEBoKWpvqO9TdKMVCp1beTX6oOfPQZ9WYlUKlWa1iVGPM93drT1Xrxg3W7btGmzPC+PoekbN64zNJ3FlZmOWqPRZTRNJhdNJnL6rr+/vy+XO3lm5i7HcQRBlL35VmfHj/H4fem8UyeKirYCgMfjllxba3pV8Dx/9cplACgoKDhkr1EonhLzDPVlg4DOMHQoFFx7Bss2WanEW898r9cbAGBhgR0Z/iUUCur1htKynQLPZNzVLBwAAEmaKWeDsMkS8fm8VN2RrNAz3GgcFx0avCKTIWazGUUxQcmybM/57tbTpzgumu0bZ8VnC4LISdKkUChjMY5haDEDPxkH/z9+H8i/czWuSpjbEy8AAAAASUVORK5CYII="
    m["dark_bg_medal"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEFElEQVR42t1WXUybZRQ+pS2h/ZpRlrZJ/2jpSpZQPpgJUJoZ6X9LC2MXjq1Kol54p07HjMG5G0LiMqOJU6N4ock0W2Jioqx/wCiOoIXVKqX8qIO26iz0ZzAiSzrbfp8X70qIXYst7sZzdd7zvOc833m/c877Uni8BniUUgGPWIoRUKnUlpa2aja70IZqNrulpY1KpRYLgmHcQthTTz/zwouvqFSPO50jJEnm0797abjr2HEASnB+rpwMKivpAMAXCJRKVT6qVKr4AsHOtnIIRt1O9OEWa08+arX2AABJkuNj7jIJotE/AoEfAaD5yGO1tdLdkFgsxpuPAEBg7ofbt38vv4qc9hGkmMzW3fZOaw+FQgEAh2NkX2U6O+uNx2MAYDCaGAwmMlYxGFqtAQCSiYTv5sy+CAgiOz7mBAAGg9mh1iKjRqPHMAwAXC57Npvdb6O5nI50Og0A3d3HkcViOQYAmUxmbNS5p3uxPkBy/35KIqmTSKTVbHa9/HBHh07R2AgA305PTUyM7ZeAQqHo9Saj2VpVVQUAQpFIKBIh6MCB6q2trUgkVD4BnV55pv+1k6f6UPR/CIPBUKmO8gXC732zBEEUCkIr8u2nT599okMLAOl02u12fDM58duvYQColdRpNHqT2UKn09VqHQC8/dabJWeg15tO2voAIJlMnBvon7g+evfu5ilbn0KBT93w+HwzvpszrW3tTCYmlcpisfVweLUEAhqNdu6NQSaGpdPp1wfORMJhADB3dj373POKxqaNjY2VW79sbm4G5+cMxs6Kigq5vN5+7av8gViwTBsUOIfLBQCX046i19QcPNFrQ+iJXltNzUEACIVW3S4HAHC5vAYFXsI/wPFmpEzdmOx/daC1VYlhrB2Uy+Vd/vyLe/e2fb5Z+7WRru4eAMDxpocO7YdnwOU8OLdsNq1W63aip1KpVCqFdAxjqdW6bOYvtORwuCV0MpE7zWg06vVO79iHBs8PDZ7fWXq902tra0gnCbIEgjt3kkgRiWsvXhjy+31oqdUZtToj0v1+38ULQyJx7QOXjWQJBPO509Ro9JlMJhxayREYtDoD0sOhlUwmo9Hoci6BEgiWFoOJRBwATGaLTHaIzxfm7+HzhYfk9eieiMdjy0sLJfQBSZLb23+2q45SqdTWtvbY+rpUWpdKpUa+/nJ5ebFOJqfRaJHw6pO9NhbGAoDhjz4I5bL8t50cCYf4AqFUKmMyMbFY7Pf7Pv3kY4/n+sLC/K2ff8JYLKVShapr0jN+9crlgiOnyMuOTqe/9PJZNG0KyaRn/L1L76ALo+RpShCE97vpWGxdLq9HV9huicdjwx++f/XKZ0VG6R4Z7H5jNShwHG/icHgAkEjEg8HA0uICQWT39KX8rx+//4n8DTm+fvPKUuG/AAAAAElFTkSuQmCC"
    m["dark_bg_monitor"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABnElEQVR42mMUE9NioCVgYqAxGPoWsMBZIiKiScnp2jp6QkJCZBv35vXr8+fPzJ83+/PnTxARRkgki4iITpoyi5eXlyqufv36VX5uBsQOqA+SktMhpt+7e+fZ86dkGy2voCQrIysqKhafkDxlcj/CAm0dPQYGhnv37hYWZP37949sC1hZWSdPmSUtI2tsbIYSyZBwf/bsMSWmMzAw/P79+/6DuwwMDCKioqP5YNSCUQtGLSDVgjdvXjMwMCgqKLOyslJkHBOTjLQ8AwPD+3fvUCqcM2dPe7h7ScvITpwy6+GDe1g1MzIwycnLMzAwPHr48D8D9jJRWlpGQVGRgYHh4qXzKBUOHx9//8RpYmLiVAmWz58/5WanvX37hoGBgZmbW5SBgeHnz5/79+3h5eHl4+fn5uYm2+j3796dPHmsvbURYjrCB8QAG1v78opaBgaGzo7mI4cPDr5WBS6grKwiKSXNwMCgrq4JEYEznj97evfuHfzaCQSRkpLyhEkzGBkZscr+//+/IC/j3r27AxlEhCMZHkSYgApBNATKIgDinIJv11PVhAAAAABJRU5ErkJggg=="
    m["dark_bg_moon"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADU0lEQVR42mMUE9NioCVgYqAxGPYWCAkJ5+QWrl2/tbConDwLGPFEsq2tQ3ZuITc3NwMDw8+fP0OCvMmwgAWXRGhYRGxcMiMjI4R74thR8nyA3QJ3d6+4+BRkkbPnTlMtDuTkFNIzcxkYGP78+XPt6hWI4KNHD6hmQXpmDisrKwMDw5zZ069duwwR/PbtK3UsUFPX1NMzYGBguHL50ratm37+/AUR5+Lkoo4FTk4uEMby5Yv/////8sVzCFdGVo46FhgYGDEwMLx/9+7ypQsMDAy3bt2AiBsZmVLBAjY2dilpGQYGhuvXr/7//5+BgeHp0ydPnzxmYGCwsrbl5eWj1AIBAUFIwn/58jlccPv2LQwMDBwcHDGxiZRawMQEzVZ///2HC+7YvuXN69cMDAyeXj5WVjYUWfDlyyeYVwTggj9//pw6pf////+MjIzFpVWk2sHMzS0K5/z69dvL25eDg5OZmWXb1k1w8WfPnv79+09f35CZmdnG1l5QUOjWrZs/f/4g2QIGBgYVVQ15eQUBAYHDh/Z/+vQJLn716uW/f//o6RkwMjKqqqp7+/jLyslzsHOwsbGxsrJKy8gZGhiFhkcWFZdLS8ueOH4UZ2lqZWVTWd3AwMCwe9f2SRN70ZxjZGySk1skKiqGx8k/fvwIDfbB6YNnz57aOzjz8vIqKipfunju9evXyLLPnz/bvm3Lp08fxMTE+fkFsFqwc8fWM2dO4asPLCytq2saGRgY3r17V1FW8Pz5M6wGSUpJqaqqi4lJcPPwaGnpaGlpMzAwfP78OTMj8eOHDzh9wMDA8OTJY1FRUWVlVU5OTmsb+9u3b7x+9QrTgi+fPz98+OD69asKCoqurh6MjIz////v7W6/c+cWvkiGlv5nT6uoqklJSXNycjq7uIuLSTx9+vTTp4+omYbJyMikqKjc1d0TYvrsWdP37t1JbJXJwsKSmZnn5uEFF3n8+NHdu7ffvnnLwsIsJi6uqaktICAIS98/p02duHfPLtLqZAYGBjNzy+TUDClJaTxqzpw5NWfWtKdPn5Bc6cOCgtnUzNze3klLR0dYSAQi+O/fv6dPH58/d2bf3t13794hs1WBCTg4OAQEBP/8+fPx44ffv39T2mwZbTrSxwIAW3En9LuuaH4AAAAASUVORK5CYII="
    m["dark_bg_mute"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACkElEQVR42mMUE9NioCVgYqAxGLVgSFkgr6A0a/aiGbMWCAgIUt8CXT2Dzq5+SSkpaWkZLS1t4i1gIUaRrZ1jYVEZKysr1FHMzNS0wNcvKDUtk5GRkfpxwMTElJqWmZaexcjI+P///wsXzpFhAYoPLCyt7R0cGRigjhUWFtHU1GZgYPj9+3d/X9f///8MDIzQ1FuYW61cufT582dQ41hYIqNiGRgYli1d9PfvX3QLiosrODg50Zzw9evX1pb6y5cu2Njao0kVFpVzcXEZGZtWVhQ9ffqEhYWlsqrezNySgYHhypXL58+dQQ8iTNPv3b1TXlZ4+dIFrN4/e+YUAwODoJBQe0efvLwi3PT3797dv3cXZyQfOXKgs72FmPDt6+1gZ2c3M7cUFBKaNGUmExMTxPSqyuIPH95TISf/+fOnva3x1MnjkBQBN/3Jk8fULCr+/fsHZzMyMTIyMlGtLILEqoWlNdwaAQHB1rZuaWkZfBbY2Dhs3roHgiZOmiGvoITLgsKiMnis5uWkQ8IKEuf8AgJYLPjx/TuaEUrKKp1d/bp6BlgtMDG1gIf7w4f34fEhKCSkpKQCUcPMzS0K1/D48SMmJsZHjx5C0NevX0VFxdjY2OzsHZ8/f/b//38bG3sGBoajRw49evSQgYHh6ZPHv37+nDCx+9nTp5BQOnb0MBMT09Wrl/fs3vH//38GBgZGPJU+ExNTckq6n38wAwPD////L148D8nJnR3NRw4fJDKeUHyABv7//3/u7JkvX74YGZswMjJKSEhCxOE+oE59sHnTuu6utt+/f9OwRjt8aH99XeXXr1+gCf/vX+ItwBdEyODVyxenT58yMDL69PHjsuWLf/74QaQFjKMtu1ELKAYA6fgJYc6vnb8AAAAASUVORK5CYII="
    m["dark_bg_news"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACjElEQVR42mMUE9NioCVgYqAxGPoWsKBbyMQsIyMrIyPDxMxMkkH//v69f//e8+fP8Fkgr6BUXFKuqKhMtnuvXbva09X6+vUruAgjPBVxc/NMnjpLVFSMwjB5+uRxXm7Gr18/0X3g7OIKMf3YsSNHDh/8//8fSeYyMjJ5efno6OpLy8g6ODrv2rkN3QJFJRUIo7+v88f372S4/cL5s8tWrGNgYNDQ0IJbgEhFHBwcDAwM////J890BgaGz58/QRicXBw4UxEc5OUXu7h6MDIyEjT3////u3dunzy5j7R8YG1jT4zpDAwMjIyM1rb2xOYDOOjv67R3cGRgIMaO/wf27yPZghPHj544fpT6ORkO+AUEdHT00ELpx48f58+diYiM9fH15+HhhQg+fvJ42uQJV65cJM2Czs5+aRlZTPHt2zZ7evkii8jKyCalpBcVZJFmAS7Axy8AYdy4cf3Nm1ca6lrCIiKqqmokB1F5eSHWIOLk5La2tmVgYNi4Yc2RwwfLK2tsRB3IiYOPHz4cPXIIU9wGd4okzQILS2vMZPrjx487t29BMhelFhQWlXNxcWGKCwuLQDJXeUVteUUtRPDPnz8k12hHjxzEdOaPHz9279757ds3NPHz58+S7INJE3snTezFKvX82RN3Tx8ebm4I98njx5s3rSdswc/vPyB+5+Hh/fLlM55gvXP71p3bWIo2Tk4umFE/sVhw4+Z1Z1d3BgaGysq6HTu3kVHh2Ns7Qti379zCUmWysrJOnDxDVlaewsLn1auXOVmp379D44mZm1sU2iz49+/UqZPqGloiIqJkm37v7p32tqa3b19j8QEcSEpKKSoqkdFsefT40bOnT/79QwlbxtG26YBbAACl2O0rRkc4qwAAAABJRU5ErkJggg=="
    m["dark_bg_octagon"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACUUlEQVR42tWWz0/aYBjHn8p7oHqg1M1DWxanbofBdpsgVZIa/UN2WrLbfgXKsqHJLHJQTvtrNJAYpbZw2sofsICHeYBCLxJq2eElOJpaahcy956avG8/n/R5+z7fl1hYeAbTHDMw5YHcpykqHI09JwjCcXYwGGja946u+xRwXETKH4Rp2mVNu9USM+8uLpq3LQjMzT30TQcAkiR5PqWqsmF0HRcQjpv8J11VzsvlI8eXN4Wtl/E19+9wEDAMu18oYnqtqkh7O/1+37m+CKUznxNrPADoejub+dBo/JxQIoZhpcIBTc9PpAOAZVly5XRx8TEXeRQMkvx6qlZVu93OrQJMn6cfAECtprrTPTpuBHb619xEuhfHUBAKUYfFb7gyqiJLezumaXo/TdixtLTMcpFgkEwmN0qlo17v6uYkR6MxvKtVRc5Lu3ei42GaZl7aVZVzAAjTdDQaG2sVM4EAfiiVj33QR47RDz0C/uteFKKoWOzFtHoRABQKRZaLuCxoNBtvXr+6x+06nX47sUR/Jejo+tnpyb1OtKHAur7GD4KwjRDyWW6ENoUtG3AoqNe1dqsFAKvxhJjN+XAghMRsbhQP9bo21ot6vStFqSTXN2bJWZaLrDx5Wjk7sSzLOz0jfoknkjgYPokfLy9/2bupYRiqImMHw7DLK14dNrotdsbywIdjYqjZE+1ODi+R6Rz6LMvl9w9HDbxUPnYUCML2ajyBdzUrvm82G15vFTaH+3Chu92LDKOrqjLPp0iS9E13+wKP7bqu/dD1tguB+O9v178Be8Rg9ITtSiQAAAAASUVORK5CYII="
    m["dark_bg_palette"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAE/UlEQVR42tVWaVBTVxQ+LxJTIAtJIFJIZEqwLVCxbUAWQUNBqRkY7eJURiyoaG2VaVlGmNapnQ617TjdxtYFB5exVgeLECAMCJXBCmFxQqEoQiAPGgiPaEITVrO9/ngRAiQS2vrD++u+d88937ln+c5BOJwgeJKLBE94uTgpx2KzfZ7lMjwYCILodLoRDFOrsf8BgMtbKRIlhkes43BWzDvSjf4ta2u98VtNe3sbjuOONCCOYsBis9PT34+O2YAgyOONUPT1nik42dnZvgSAsLURWdm5VCqN+NRqtTJZK6pQjGo1OOBMJpPH8wsJedmXyyMEcBwvE187d7bAbDYvDvBa3KYPP8ohkUgAMDDQf+nieZVK5cXx6um+p9frbCVXrXr+7W3JUetiiM+W5qYvj35mMplsZZa5u3vNs/1Q7ickEgnH8eLiomNf58dv3JSVnSuMjdssSuru7lKPYADg789/JznFnx9QVlrc0tIkEIRRKBRfLneFt7e08ZbDF7DZnj+eOEOl0nAcP3XyeKWkjMfjnTh1bkagH0UzDu7l8wOOfXOcTCYDgNFozM48YDAYjn71LYvFAoAfvjtWW1ttvw72pO8n/F5cXFQpKQMAr7nJ48XhAEBc/CZCOwCQyeT4jQlDQ4P5nx8mnJO2e5+rq5sdAC5vZXTMhkd+t1rdK5dPTEzMyLS3tznKJbm851pxEQAwGIyE10V2AESiRCIjL108PxMovV73Rf6RfhSdnJyUSm+d+Ol7AKi5XmU0GgkBg8FQU1NF7EtKih4+fAgAsbFxdgotPCKKyMjmZikAbE/emZi0FSx4hUSccXCvrbEoqsjK/CAhIREH/Hq1pB9Fif/jY+MyWWtkZPRz/gFUKm18fGwWgMVmczjeACCTtVosZqEwbkdKKnG0IyVVpRq8WV9ni9GPoqdPHV/oqHtdXZGR0QiCrPTzu3unc9ZFPj5cq3UKBQCsXr3G9tqakFecpCyN5j6xYdA95sSATrMW7eioFgDuPxixvTbiHK8BANnFml0mk9k+XRPEUyYuVfT1PqIaeXlZqZMALwQFExsMG5wTZL1+zPo0BhMAJicnsjIPBAYGA0BX152FDGN3sdmewvWxAKBWY4ODcwFUw9ZvPj+A2JjN5s7ODucbi7s7Ne/jI8+4ugKAuLRkhsCtAFqNRq3GOBzvVwWhJNIyi8XsvGoWiy0IXbs9OYXoGfKe7kqJ2E4dSBsbtmx9i8lkRURGNTb8/hiNiUlb0nbto1AoC4+Uyr/y8z+1JdTZIFdXVRDvStmZ5uLisNMJBGHv7c9YqN1kMlVKynOyMrQajf2WqVQq6+tvCIVxPJ7fu6l7zhaetgtAFDwA3L7dMj09BQAT4+OoQtHU1KDRPFikJ58rLBAIwmg0+htvblOrsYpy8cILGGatibt3Oq4WXVk0QnMaztTUVD+qiFkfSyKRQkPD3dzc/uz4w2KxzPHy4MDmzUnLly9neXpJKsRLAwCA4WHVCIaFR0QhCPJiYFBMzAadTjc0pJxJO4PBEBQY7MvlUd2pVy7//G/Glrq6Wr1el5WTR6czfLm8Q3mHiQlFoejTajU0Gj3opRAAsOvxJYwtTCZr1+69wth4R2PLhfOFv169vGQXzazp6SmptOFmfZ3RaPRgMGmP2JAo8orykl8uXXjMvLX4C+YtDw+mL5fLoDOMJlOvvIcg3f/koqdmuv4HIPsPkwwxRBQAAAAASUVORK5CYII="
    m["dark_bg_pause"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEZElEQVR42tWWb0xbVRTAT3nvkUAZfX19rRRZaMefsZnAWv60a0r4Mwk2w5AwEuacWTBx2cwWs/jByNCRZer8MBJiZAQVdWRaPxmFgXETlD+jG3Rlzo05LEUo5U9fC7SFtPTR+uFBUx6lK+I+eD7de98993fueeeeczgi0X54lhIFz1jQCPfFx/MIAUGSIvD7rRRlt1FOp+M/AIgTE4uLSxRKlVSawvo0Nma8o+vv7ro1PW0JcwJnq3+A4/yjx46Xlh5G0XBG0DT9U+cNrbZ1cWFhG4B9+16oqa3DcT4zXVpauqcfnJgwUVYKAAgBKZFI5dm5XC6X2TA/b//wUt3jx48iAuTnF557+x0MwwBgdnam9VpLf18PTdNs56KoWl3w2olqkSgBALxeb/2Vy329v7G2IVyukGX7+fcuMqd33Gi7WHfeNGb0+XybTfP5fOPjps6ONh4PT01LRxBEoVDdHzZQlHVLAA/HP/q4nrl4yxfNrddaQh7Nwgze1Xk8HpksG0GQ3DxF1y83PR53aED1629kZh4AgJs/d3791eeRB/vIyEM+n5+WtjcmJgaLjtYP3Q3x0MSJiaWlhwFgZma68dOGYH0ejufk5CEIsmYUguTk5PFwPHjPZ82Nc3MzAKDRlCUkiEPcoLy8IjNLBgBNVz8xjRmDlRsarr5cXgHAefD7MAAce/XEmbPnFIqD7e0/BPvK6XAcVKmjoqJcLtcfD+6zb6BUqpmI7O/rYXng+aTdAJC0O4mZMgNmMVh6e39dWnIBgFKpYrsoPp4nkUoB4J5+cHNERig0TRsMQwAg3ZMSF7drA4AkyUAC2Elq+3vcBAAcDocUkhsABCFgBgvz9p0AKJuNGQiIjQC/37/uM85OABxYU/eDfwPAbl8jE3zBTgACwZrhNpt9A8C2fjWJRLoTQLIkmfGHbT1hrAEcjkWTyQgA8uzc8Pk5jGAYJpfnAYDROOpyOdnvQDfQDwBcLletLmBpTpknAcA8aWamzIBZDBZ1fmFsbCwA3NENhEjXYnFiY1MLiqJzczOnTlZ7vd7gVJGWmm4w6FdXV5lUIZNlj/71JLjIYFh0U/OXItFzNE2fOlk9OzvNThUulxPH+el7M7jcOFIg1OluB5Q9brfFMhWINL/fb7FMedzuYPNPv3k264AcANrbvu/p6Q7dVWi1rfPzdgA4VFJacaQqcu8fqax6SVMGAHa7/TvtN1vWA4/bPfLoYVHxi4wTCIIYNujDlwQMiz595q3KyqMAsLKycuH9dy0Wc7iKRlHWqSmzQqFCECQ1Lb2ouMTpcJjNE5sxKIoWFB6qqa3LypIxp9dfuTxs0EdU9DMy9tfU1vH5BDNdXl4eGhqcnBinrHMAQApFyZJkuTyPiRnGMx9cuvDkz5FttC08Hl71ynGNpuypbUtnx4/ab687HIvb64sYSUgQFxWXKJWqPSmp7MbLODowcLu761YgIv8NICBxcbsEpFBIkgBgpSgbZQ281aekv/99d/0PMaS7CZq+5wsAAAAASUVORK5CYII="
    m["dark_bg_pen"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADZklEQVR42u2WS0wTQRjH/6ttiZS2sAXa2hZpC1RQBN8x8QEYD5oYYzTx6MWYaDAxngiobdl2+3BbIz4TjRc9mmgUeYqRUoJRUCK0FF+X6kVIhINQtw88DBLBKrZojIlzmp2d/P7z/b+Zb4bKzS3Bn2yL8IfbvyAglcqUSpVQKEr4V7AQtEq19Gj18fLyNQDC4fD9xrs3b1yPRqPfzlksFuekRtdotHbnWZ1OP71SgaCkZIVCoejp6f4NFmm0eazDTdM0gEDAf+f2rfGPYwAqq3YYCgoXGsHq1escDk6cIQHwuKe73lLX1/skFAptq6gC8P79u2AwkHoEeXn5J09bhKI0AK/fvHQ6GGI6RU2RCVNTU6lbtCxfz7KcSJRGPg36wsqqHQDUak31sRNkcOBFf4oW5et0NpaTZWYCePVymKblFEVt2LgJwOEj1TQtB9DxoK25uTEVAZ1Ob2M5mUwGwOfrtJhqR0Y+bNi4iaKolaXl6enpAHp7n3g4ezweT1pArzdY2TNSKaE/4lz2WCz29s1rnufLytdSFAD09T1lreZIJJL0QTMYChibSyKRAvB6Oz2cPRaLAcjJyd25azehj46O2BhTJMInXSq+pXd5H3k4doZud3oUCiWA5896Dx86mJA+TwSGgkLG6pJIJAC8nQ/dnDMejwHIzs5hHW5C73/eZ/3B2ucRKCgsqmechN7R3trQ4CbZI3SlUgWgv/8ZU3+a5z//ZJWCH9EZqzMjQwKgva3lwnnPV3o263CrVEsB+AcHbMw89MQ5KC5eYWO5r/TmGXpWFl1vdRF6wD9oNteGw+F598jcCLRarYWxL1mSDqClufHSxXPk6NNyOWt3q9UaAIMDLyy/Rk8gsHlLJaE33b935XLDNJ2Wsyw3TR9Mgp7AolWrygDwPH/t6mVCz8qirXZOrdESZyzmul+nzxUQCoVFxmIAwWCA7DxZZqbV5tJqtACCwSGzqTY8OZlUfZxlkXF5iUgkIi6LxRkVFdv37N1HshoMDplO1UxOTiRb3mcJlJaWkc7adev37T+QljZdloeHh0ynaiYmPqVw9wm+TwAAo7GYdKLRqM/XeeXS+dTocwWKjMtn+qF3ofbWpocd7ePjYwt5ecwS8HV5N2/Z2t3d1dbS5PcPzLn8UmvU/7fpXxf4AhxRW5GDpbXpAAAAAElFTkSuQmCC"
    m["dark_bg_people"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEKklEQVR42u1WXUybZRQ+38cHhVIYbWr/aGkpDjLGAEVadO4H2o6gYhTKYIsu6sUujH/ToFEiFQZ0xqkhixqjF0t2MXVgdOqFyVTWUX4HFIQOyk+h3egPk07aUghtPy9eVtry0xqzeLNzdfK87/c+7znnOed7MRYrG+6l4XCP7T5BRCO2ZcZjiktkEuljovR00k/Ozc329nR1/PGb3+/7VwTYlipKSKDWq07n7MsLw0dGdE2N9R7PcvQEMYmJD2xGa9+pK3hEAgA+n2921uhwOJKTd+E4zmZzuDyetlODtrHZ3LInyhWlZVlZ2RgGVqslqgjE4ozWc18CgPmmuaH+PZvNAgAcDveDhpZUvgAAXnvlpNE4U/70My+8eDIuLi7wYW9P14dnTq+trUWIQK4ozct/GAA+OauemjQg0OVyWW3Ww4dlAGC3W3E8pvbtOoIIKSGfL6BSqQMD/RFURGcwkWOcmQnGp6cm1zfQmc+feAnHcZIkWz/9SFnx5Kk3XrbZrADwVPmzdDojAoFneb2GKSkpwTiDsf7l8vKyWJwBAMPDQ1eu/Lq6ujo1aWhv+xYAMAxDSzsRTIzrkaOsqsEw7K5q8QrlMeQbDDf+Ux8MDl6ft9zicVMPHiphszh9/b0AIJEWZWXtQZUfGrw+PT21N2dfXt5DiiNl1651pAmEyqpqACBJcmZmOnIfPLg7s7nlLJVKDcPdbnfdu2+h01vUH+N4eAJ+/KH966++iNwHi4t/dWk1bDaXw+WiU7xeb39fj1rdYDLNAcCC3e50LuXm5cfEbOSgu7vz889a/X5/5Ag2MkgQfIEAAG6azV6vN2yVxeIcOHgoNVXgcCzqdIN/juiiHRU0WqK0aH9m5p7kXckB8I7jjsEw3tfb7Xa7AiCXy6uuec7v901MjGs7NS6XMwIBQRBVR49XVB6Nj4/fMqYVj6e9/bu2SxdRQK+fqpXLSwNLFy6c/+ny9yRJbl2DhARqQ6NaJj8S1qIhN4iNzc3Nz96b06XVeL1egiAk0iJUCSI2tqCgkEajBTfzRgQYhr2vaioslAKA0+lsu/SNtlODBhFa5XC4+x8/UKmsodGS0ORpblKhy9LpjBKZ4tjxExQKBQDOqBsDA3EjguJiubKqBgDmLbdq33x1YKAvONcA4HI59foxjaZDIn00KSmJzxeYTSaTaRYAVlY8N/Rj+rGxEpkCwzChSPTLz5fDO7mishrJsblRdfv2wnYpWrDbWppVPp8PAFBzBWx0dPjq1d8BQCAQ8vmCEAIWiyNKTweA7q5OdKkdbNZo7OnWAoA4YzeTyQz5I+mGkMPjpYYQpAmFyBkeHopmwozclXyaUBSisdUV5MRRKCEEAVGG5X07W1r6OyC8qF4VAeUGS3gH227b5nPW9a4fG7VY5pETDcF2+zfj2P236f9O8A8DyrD/F6sPNwAAAABJRU5ErkJggg=="
    m["dark_bg_personplus"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADLklEQVR42u1WyU9TcRCeVx5JW0pZUruwCAUBQUQT6AJUkUU0GjWBllb0H+BAZAlBRKgg4MWriTFcjYblP9AATVv62CFSsSwtLVAQkiLQ5dDFwysFSysPCfHCnCaTmffNb+abLw9hMjPgLI0EZ2znAMcaGhSZFFJYVMwX5CVyuR63Z3nZgGnUgwNf3W7XiQCQgCyiUKit8teZV6/5xWdmpjraW+12G3GAkLCwC0ejDY3N2Tl8AHC5XAaD3mKx0OkRJBKJxWJzYmJUSsWpRpSUlJyXJwIA04qprfXFxoYZANhszqu2rti4eJGooIf7Ua9f+vclZ+fwcKf7wzv86wCwvm7u7n7vl+AzFotTU9MgzM0nBBAVzcAd/dIfbS4uzHsTohh+JVLZk+Lbd+rrnxMCsNu8O4yMjDwcj46Oxh2bzX/JFCoZAMgUCiGAH3Na3BFLZAiC7LOWVCZ+jPs63fdTLXliYmzNvBrDib1ZUMRiskdGMQDgC4Rpaen45icnxvC5yyqfkslkALic5uV6Y1MLAAB4hgYHNMOqoHdwKSW1s+stlUr1i1ut1uam+sXFBQCorq4rvXsvWOM2m00qeRhUKhbmdbXPqkYwjcvlvVun04lp1LU1VfjXAWB0DHM4HAHLPR6PSjn0t0s+mCCKxsXHA8CKyeR0OoOlNTa9FIluAcCD+yWEtIhGCxMI81NT0+kRdF9w27Kt082NYMNW696/LxlFUUlFZVl5Bb69I/bIYbf39/f09X46/CCP2zuZY7SIQqG2tb8pLilF0aAqi4aGZmVdz7iSqVYpfBgut4vPEw4OfMGw4aBqiiBIi7yDxxMAwO7ubl/vZ5VS4ZMKBEHYbE6+6Ea5WEajhQMAplF3dsgDdh34BYWFJWKJDADWzKsNddXj4yN+s97b29VqZxWKQb4gNzw8PC4u3mQ0Go0GomJXVi7F6djZLt/a2gxWsPlzo6tTjtNXLJESVVMmk53I5QLAsFp5bFMGvR6/0qTkFAaDQQjgYkIC7kxPTxIh38zM1H5hIiEAHykJcnxn55ePeIQAfGQ4lhUnSjs4NO3sN7N5DXeIlBHPR87/Tf87wG/wL0LGQoZ0PAAAAABJRU5ErkJggg=="
    m["dark_bg_phone"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABxUlEQVR42mMUE9NioCVgYqAxYMEjx8jI6Obu5eTspqSkzMHBgSb758+fRw8frFm94vDhA3gMYebmFsVlenlFbUhohKioGAsLFncwMTEJCglZ29hxcXGdP3eGZB+4uXla29gxMDD8+P79ypVLP37+QFPAxspuaGTMysoaEBhy5cqlkyeOkWaBk7MbAwPDjx8/Cguynjx5jFWNlrZOW3svMzOzr28gLgtwRrKSkjIDA8OVK5dwmc7AwHDt6pULF84xMDCoqauTnIrYOTgYGBh+/PiOP5F8//6VgYGBk5NrwJLpqAWjFoxaMGrBqAW0rvSRgbi4ZERUDAe0kvixYtmSly+fU9OCsLBIFxd3OPf/v3+TJvZSFETfv39nYGDg4uSGcE+fOfnjB7Te//Hjx+lTJyFsDnZOSMOAZB/cvnVT38BQ38BQR0fvypVLJ44fDQ32QVMjKyuvo6vPwMBw795dki3YtGmdvoEhMzNzc2vX+fNnf2I0Wzg4OHV09CCxsmfPTpytNzxt06TktMCgMIKhfPjQge6u1v///5PWsmNgYDh//uzDh/clJKT4+PiYmZnRZH98/37j5vXlyxcvXjQPX/tzyLeuAbt+k+VAPWZfAAAAAElFTkSuQmCC"
    m["dark_bg_phonebell"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADA0lEQVR42tWWa0hTcRjGn7Mzz9At5oSEHcML85JCXiCnpqIF3lDRSkor80sUiEIa0ZcuJFFKqWkaaUIpmZphkJgOuiimJMrmZmlG3hK0L/ahzRvb2enDMZXltNkJ6vl0eM//5cf7/i/vQzg7++FvSoC/LOGG0ZDQfakH0xQKT3t7B4tf8/OGkeEPLS3NQ7rB3wEQv7YoPSPz+ImszdPMZvPdyjJVR5vNFSgUnhnHMgGYTCatVrO4uGCxQCLZERAQJBAITp/J1uk0szMztgGClSECgQBA4Y2Cvne9G+bExSfm5OZRlCg8PPJpc5Ntm7zLxY37GOjvs5bz6qWKZVkAHh6K1aBM5lRdU1ddUyeX05sBSLuVCMMw1gAmk2klmSTXeuvpJZfTcjl98VIBRYn4PKYymVOwMlSnHdSoBwC4urkfTjvKJ6Do5u3LV67lnTtffKtQr9cDSEk9JBKJeL5oERHR/v6Brc+fARCLJXuDQ3gDFF6/ym1YUnJqd3cnF/Tz28MbYHx8TKfVAPD22f11dsZoNAKQ0zSfLZr7NgdAKBTa2VFLS0sAKDuKNwBBEN5ePgAMBj3DMBKJBIDe8J03QFJyiqubO4D+/j5fXz+CIAB8mZriDXAy6xQAo9HY3NQQF5/IBdXqAd4AvT3dy8vLd8pLpFJpRGQUgMmJiU+jI5vNA5tUWlJUWlIkkzmVV1Rx/amtreEeKz4vmsLTy9FRBkDV0bb+oRTyBdCoB5qfNAJ4XP9w65G5DTEMU1db888M/VWFhoVHRe8HCAAA2/nmtbUxt01AXv4FB4c1YxEUFJx+JOWPfBFjNK+QhUIAPW+7Vg8cy7I93V0AyJ+DzGx96lmtYHJqLAoHAMTEJrS/aC0vKy4vK7ZYo1SGced9enrKZl8kp+mKyvsUJWJZVjuoNswbLBIc7MUBgUEkSTIMk382e3x8zGbjFRObkJObx5mXTVT/6EFjQ/2WFZBi8U7LATL2+f2QjqZdpI6O5DrfwGlhYWH043DVvQqVqn2b1vE/c9c/ABA9BEYs4LfGAAAAAElFTkSuQmCC"
    m["dark_bg_playcircle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEwklEQVR42tVWa0xTdxQ/5bbEcpG2txcCJIZWHoKLQkuAhpQA1Q6JfJniwAVkuA2jUcnGEjcEJcxtbhksM8PMbkMEJ50s2SIT5niU8RDkVYhRnKzAEHn1tkB5yCvcffhDhUtbYZkfdj7de//nnt/5n8fvHJaLy054mWIHL1nYG9RzcuIRQoIkXYCm9RRlNFCTk6b/AMDN3V2hUIbIQsViT8ZRT4/uXlODprpyaGjQhgWWtRzw+YL4NxKiovaz2bacWFxc/K38tlpdNDE+vgkAP79X0jOy+HwBep2enm5va+nv76X0FAAQQlIkEksDg3AcRwpjY8ZPLmQ9evRwQwBhYRHvpp3hcDgAMDIyXFSY31Bfu7i4yAwumy2XhycmJbu4uALAwsJCbs7F+ro/GGoYjjszfD+bmY2sl90uzc4629ujW1paWu/a0tJSX19veVkpj8f38vbBMCwkJLSzQ0tReqsAPD7/089y0cXzv1cVFeZbNM2AaWlumpubk0gCMQwLCg6prqqYm5u1DJB89J3duwMAoOL38msF32282Lu6HggEAm/vHVwul2Nv39babKHR3Nzdo6L2A8Dw8NDlvK9W/386Na3kp9IjSW9v4XKtYXyrujw6OgwA0dExrq5uFgAUCiWqyOtFVxkp3avct4XLPfR6vEp1LVKhZLFY6wEWFhauFxag5EcqlBYAZDI5qsiG+lpmqa1YFBDEe2lnPv/ikre3z3qMurqa6ekpAJDJQpkATk48kVgMAO1tLesrEsnExAQ68vX1y/ky73Tq++ZGMTedVtsKAOLtno6OW9cAkCRpJgBrUb5/X3vqZIq2vRXdSfnqvm9UBa8dOIRhmFnn775edEo6k2sACEKIHsbHjDaqZeBJ/7nMDz7KzkT8g+P40beOxR8+YlagDAb0ICTWAtA0vRIz1osp3s5ubZ7p59kC1soneg2bGo3LyIRAaMP0tm0eKcdOBEgCzRxVfKOw9NYvZgWhcNlxg8G4BsCwcjWRSGzN+q5dkktfy1Ep0zRdcae8sCifQaIeIg90alghjGUAk2mit1cnFntKA4PYbLbFQuLxeOa+VV3J+6v7MUOBw+FIpcEAoNN1T01NMgdOU2ODWOyJ47hcHl5TU7X6T5qmUdDHjMar+aqamqrnOVsl8rAIBwcHALjX1Gih0TTVlcjxxKRkxKZmqbhT/uzZTMlNdUpKkkZTadE6h2OfkPgm6gZNdaUFspuamuTzBT47fHHckRQ6NzXdNSs1NzeW3Czu7Gy31oMAcPzEKf8AKQD8Wvpzba3G8lahVheNjRkBYI8y6sDBuI2z6cHYuH3RMQBgNBp/VN+wOg/mZme7Hj6IVOzFMEwiCSQIokPbZnskcDj2x0+mxsbGA8D8/Pz5cx8ODg7YmmgUpX/6dCAkJBTDMC9vn0iFctJkGhjoXw/DZrPDI/akZ2T5+0uQ9dycix3atg0NfV/fnekZWQIBgV5nZmZaW1ue9PdR+lEAIJ1dPEQeUmkwqhkUmY8vnH/8Z9cm1hYejx93OCE6OuaFa0t52S118Q8m08Tm9iIkrq5ukQqlTBa63dOLuXjpuhsb72qqK0dGhv7N4sUQR8etQtLZmSQBQE9RBkpv7lXbwvrfb9f/ABJq63OhJfjxAAAAAElFTkSuQmCC"
    m["dark_bg_plus"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEfElEQVR42tVWXUyTZxQ+5WsJpUjbr18b4IaWf1wifu2gDSkBOgkherFlTGBClCW7cNmyLLtYhmwS45zbIsku5oXb0PETuVjiMiYsguD4kSKFgq7WqqWMIVD6tUD5sR/928XLT/laK7J5sXN1Tt73Pc95z3nP8x6WRLIfXqZEwEsW9i73xcbycRFOEBLw+20U5bBTy8vO/wAgPiFBoylSqnJlsmTG0sSEeUg70NPdNTs7E8YD61k1EAiE5W9XFhcfZrPDBeHxeH7vuN7a2rS0uPgCAJmZr9TU1gkEQmSurq6OjgxPTVkoGwUAuIiQSmVyRTaPx0MbFhYc587WPXhwf1cAeXkFH338CYfDAQCrda6psWGgv9fj8TCTy2ar1flVx6slkjgAcLvd9RfO9/f9wdiG8XhiRuynPjuDvLdfbztTd8oyYfb5fMGh+Xy+yUlLR3sbny9ISU3DMEypzB0f01OU7ZkAfIHgy6/q0cUbfrzU1NgQ0jUDZviOlqZpklRgGJado+y+2UnTrtAA1e+8e+DAQQDovNHx05UfmJfFsMqqE1lZpOHPe36/P3DJaDQIhcLU1HQul8uJjBzR3QnRaPEJCcXFhwFgbm724nffBgdLkoqjZceOlh0jSUXw6veXLs7PzwFAScmRuLj4EAAaTRF6kc1Nl4NLCgBRXC5DCRS3293ceAUVv1BTFAJApVKjFznQ37s3Vujru7W6ugIAKlUuEyA2li+VyQBgdGQ4ZPi7EY/Ho9frAECWlBwTs28HVRAEsUUAgVUl5a9GRUUhMz09k6EAgMvl0o/qvF4vMv+atKjVBSwWixATKyvL2wA4LkLK4oJj63B5RVV5RWVwpK+/URpotl5taWm+jHTKbkeKCCcmLZbtFG0/uwjWvyFnFmwc94N/R4ocjg1kXCgKCK3JZDIGpgjF/su1n00mY2CKto6IRBupttsdOwDsm1eTSmVbu71er254KDhMk8kYzDlIEqWJKB/2TcLYSJHTuWSxmAFArsgOz89hhMPhyOU5AGA2P0IV3tEH2sEBAODxeGp1/t4A1HkF0dHRADCkHQzRaD3dXagDqo5XIzZliOvpU4ayM/zIyqoTqBt6urtCkN3KyrJAIExLz+DxYgiRWKu9zXBhtc5FRGAGw73OGx0MsgOAk+99kHVQDgC/tV3r7e0JzaaPHz8s1BzicrlJySk0TRuNhkAXfr//7rj+7rg+2PubpWWlb1UAgMPh+ObrczRNhwagXS7jfUOh5hCGYSSpwHF8TD8S/kvgcCJPvv9haWk5AKyvr5/+/NOZmelwPxpF2Z48mVYqczEMS0lNK9QULTud09NTwTBsNju/4LWa2rqsLBJ5r79wfkw/sqtPPyNjf01tnVCII3NtbU2nG/57apKyzQMAIZYkShPl8hz0ZlBmvjh7+uFm9+1qbOHzBWUVlSUlR547tnS0/9p6tcXpXHqxuQhJXFx8oaZIpcpNSk5hDl7mR4ODt3u6u6zW2b0MXgyJidknIsRiggAAG0XZKdtWrz6H/v730/U/iH/WMSKDxQgAAAAASUVORK5CYII="
    m["dark_bg_power"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADCklEQVR42uWWXUySURjHn9PrbFP5CM0PRGTiTYA4FDXXNEkEsY8tN1t3+THNsshRF23NC50Xba2cXeStmxeZH3jVh6uLNpvNzzFUPiIxTHSSgjgTEIwu0M2Q9+Vl063WuTrv3vP8f+c8z/+cPSgxkQfHOU7AMY/IAFxuJpebGVFIFPmlGRncjs4uAGhWNprN80d/AmYqCyGEEGKmsv7ZGhwZAMOwJqWqu6dXLM4njheL87t7epuUKgzDIgDcVd4vl1fEMxKKiiXEgKJiSTwjoVxe0XSnmSxAJq8olcoAwOnYUA/2EQPU6n6n0wkAZTKFVCoPD4ijxFXX1AOA1+ttbX1ksSwQAyzfzO1tLT6fDwBq6hpiYmLDABSKSxQKBQAG+l+aTEYyZTQYdOrBVwBApdLk5RfDAEpKpADgcm0PqQfIW2VI3ed2uwFAcqGUCECnn2KncwBgcmLc5domD9ja+jk1OQ4AHE4GlUrDBQTUAUCv1x1W+bW7GzQ5OIxGPQAghNjsdNy3iEqlBiYOx/phCZ1uzmpdCkwO/3XY7fs2oeACdn17W4vCQjyCGxuOxoZqvCxhUVjI8/2RonX73saTU5iRPgnJySlBIiEAi5aFgKOzs0WRAoRCUeD2LFosuAC32z2j1QAAX5DFYqWRV2elsc/w+ACg1Wq83h2iezA8/CZghpraBvKA2rqbCCEAGH77OsxF+zz6yTz/FQDyCwovX6kko361siovrwAATKYvY2OjwcWPjT198Nvv95tMxlKpHMOwnFyxx7NjMOjwpBFCVdeu36iuRwh5vd72thb7vllxAQFH22y2s4XnEEIiUS5fIFxZtq6t/QhaxuMLVKqHZTIFQsjv9z97+lijmQ6xCby+qPi85F7zg+jok4HP5RWrfnZ21bYKAIlJSXxeVgpzz8oej6ez48nIyMfQpyRovNhszq3bSkGWkKAAWq2m68Xzpe+LuGkM29kJBNnSMrkoR8xgMA6mcWp64sP7d3OzM8ThiHzrSKPR6fRTAOBw2Dc3nSSj0H/Wm/6NgN/dsQcUqBub9gAAAABJRU5ErkJggg=="
    m["dark_bg_puzzle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACmElEQVR42mMUE9NioCVgYqAxGLVg4C1gIUYRDw+vpqYOA+P/69evfPn8hcoW+AcEx8UnsbGxMzAw/Pz5c+GCuZs3rSPeAmZublE80g4Ozjm5hczMUHewsLAYm5g+efzo0aMHRFrAiJbRJCWlwiNi2DnYIVxtbV1BQaE/f/4sXjSfiYkhOiaRhYXl3bt3165dhij4+ePnyhVLnj9/RmwQhUfEOLu4oQmeO3tm3dqVDAwMWpo6puaWQkJCNjb2yAom9HcRm4rYOdjQRH79+rlv3y4Ie+++3b9+/SSohahI9vV2wRQ8euTQ0SOH4NzNW/cM4oyWmJTKzs5OjBFaWnq2do7EWvDzxy8IIyg4vKGxjYmJGY/RkPgQEhIqK6/28w8kKh88fHifm5uHX0CQk5NTTFzi6dPHDx/cx2XB06dP2NjYxSUkmJiYtLX1tm/b+OvXbwIWfPny+cTxoydPHvX1C2RgYPj69evJk8dwWfD40cNDB/f9/fvXwMCIhYXl6pXLz549JSoOmBhJiHwmJqji////E06mklJSkZGxhkYmEO7582fxGG1lbevi6mFkZMLAwPDj+/cbN64TkZPDYxydXCHsSxfOI6d6TFBUXAFPaQsWzPn69QthC+DZcs3q5cuXLfn37y8zM7O9g7OengEDA8PFC+cOHtz/799fqGJ2dgYGhvfv3s2cOQWXU3Dm5IUL5jIwMHBwcjY2tmtp60AEnV3c3Ny9Guorf/5EFBhXr13C41ECkRkdHQ83HQJ0dPUio+KpUOEglzPv370rLclnYmLs7J4gKCgUHBIWHBJGZlEBz8nI4Pz5sy9fPn/+/Nn5c1gSFVYtOH2wcsUSBgYGeIUDr1Ig7BXLF////x+XLFE12mi7aBhaAADCFPR7HUVa7wAAAABJRU5ErkJggg=="
    m["dark_bg_receipt"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACaklEQVR42mMUE9NioCVgYqAxYEHjMzMzGxqZcHBwkGHWjx8/zp878/fvX3wWRETGRkTGkO3eFcuXLl0yH18QycjKUBIgmNpZcCnt7Ggmyeiy8hpGRkbCcQAHRw4fJNUCaqYiKyubgoJScXFJklMRMcDVzTM3r4iRkfHv37+TJ/dROR/ATf/////Zc6cpzWh5+cWr12x2cXHHNH3ypL5jRw9TGkTWNvYcnJx5BSWMTEwMDAzIpu/etZ0KRcXsmVP////PyMiYm1dEhumEfbBnz05GJiaI0QwMDKSaTlQqghiXm1fEwMBAqunEJtPdu7bfu3ubgYHh7t07lJamuAAZRhNlgYWltb2DIwMDIw75/wf27zt54hj5FhQWlXNxceFRYGhoGhHmT34yPXrk4P///3HJ/v///yihMpGADyZN7J00sXdQ18nD2AImJiYjYxMRERFkQWUVVWUVVWQRERERI2MTJiZmkiO5s3uihobmz58/VyxftGH9Wg4O9qTkDBdXDwYGhj27d8ybO+PHj5+BQSHhEbHs7Ow3blwn2QINDU0GBgZ2dvb4hFQHR1c+Xj5BISF4rWBiYv7p8yd5eQVkxSTHwc3r1759+8bAwCAvrwAx/eXLFy9fvmBgYBAUEoKY/u3bt5vXr5GQD548fsLAwPD169f5c2fu2rVdSEg4LT3bytr2////mzdtWLxoLgMDQ2xcsq9fACMj47FjR2bNmPLu3VtXN8+k5HRubm6IdmTAiNb4ZWZmNjQ0vn3n1scPH+CCauqaP3/8ePjwPlxEXl6Rg5Pz5g2E2/kFBFRV1M6fP4vWdGQc8q1rABjH6cA1SbLRAAAAAElFTkSuQmCC"
    m["dark_bg_refresh"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD70lEQVR42s1WbUwbdRh/7nrQowhbO7qJSyrjQ1uu14GslDgodKNOE1yMIJ0CsjglBJlb5szwbZnxi9scm2RuiCSNYnTC0kVj/OZGaWUwXta99OUy3YTCnFtLr5tLdu16PT+cMRXaHlOb+Hz63//+v/vd8/L/PQ+yciUB6TQU0mzY0o9mZoqXLV8OACGavn8/8p8RkNri6g01xdqSh/PzEQQBAI7jbvz266ULTpvttNt1OTUcic/Bjp27DQZjV9f+sdERAFCpida2V1VKdQo8RXn7eo9duUIlOyDKzpb/9fDO3vczMjIQQM6edZi3NO1+40153p9v/f5bTufE+alJivIE5v0SSbZEkg0AeXnyJzY9FYuxHo9LOER8BBAU2tq319Y+w29OnBs9efJrr9e9AEkQmgZzo66sHEXRF1u2SaUrej85KuBBY1MLALAsq9c/DgAMwxzuOvBFvyUQ8C9G+v3+YduZubnZdTo9hmFKlZph7lFej3CZFqwpBIBwOLxvb6fDPpQ6hw770Hv73opEwgDQsvXlRwsKhQkQQACg53i3x+NeSiG6XZd7eo4CAIZhL21rTVVF333/w2I8wzBdhz7g6yppLSLI/oMfEYQGADraX/H5ppN4wHGLwTiOl+nKUzvBcdwp6wC/NlRVJ60iq3Wgsso4O+NjwvfiPRgcPCEYqKnJcYZhcBwntcVJQ/Qv7eCh7qIizW061Nz8XFrEjg4GAeCh3Jx0qandPhQOh4dtZ5KGaNfrnRWVVUcOHxj50Z6WfrBho0ksFlcaqtPVcO7e/R0AZNIV6Wo4sz4foSHXFBZiGBaNRlMjV63Kf76xGcfxuBuTpVAoHI7hzyx9iQlcrouEhszKkpSW6sbHx1ITmM0vmExPLt6vrzPHE6B/L4NhflFXv0XQ94nJcwzDJNSNpDmYmb7mPD8JABpSm/Dv4m1sdKSh/unNtabNtabuIx8udaqwWHr56Ld37CA05FLSqF1b0t6xEwA44AQaDgCEQqFIJPJY6TqRCDMYjDdv3piZmU7x9Y01m/Z0vp2ZKQaAX65dlUplAHDiq/6kBABAed25ucuUKjWGYRUVVUqVOhC4FfD7F+gzqS3e/tquZ+saRCIMAL79xsqyUYWiYAFB4rHl096PaTrY1LwVRVGdTq/T6elg0Et55ucDACDPkytVRTKZjD/Msmz/55ZT1oE9ne/y0i08F3EcNzjw5QXnVGtbh1pdBABSmWz9+sqE7ayv7/jVn3/itaisrNzhsD2YXBMa0misIdeWrH5kNYqiABCLxa5fn7t00WkbOk1RngcYvAQuPYbl5OQiCHLnzm3Be/5PZtNoNErTwf/ddP0HVFV01sCCw3MAAAAASUVORK5CYII="
    m["dark_bg_rocket"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEAUlEQVR42s1WXUxTdxT/3d57S2mpQEth93byURBqpbAPgbV8LGwQa3RzLDA1bhlmMjeTPcy5DTSyCTh8Yk+YDJPNiYgE3OOiU7YsGQGEwABdNmnB2t4SysdMwPYmXHr3cIUXpVDAZP+nk/P1+59z/v9zDhEba8KzPDI84xMagMGQbDAkh2RCqlS6tegRBFFatv/Lqmrb7r3yMMXw0OBmAshksk+Pf/FWSRlBEARBmEzputi4vts9oihuDsCRimO23XsA8H6/IAgUTRsMKUqlcmCgfxMACl8rLj98BMD8/FxV5fHOzl/yCwrlcrnRaOI4l9N5f0NF1mi0Hx49BkAQhLra6rExh8M+WldTLQgCgI8+/iQqKnpDEbz3/gdmcyaA1ivNv/16U2J6vZMURaWbM8LCwmQy2WDQRFFBZGr1luJim+Txp2vte9/Yl5VlESH23e7paG8tKtoVo9PZbHvarrbMz8+tJ4LCwtetufkArrQ0v7mvpOTtdxiWZVn9zqyc55jnu7p+f+nlLIqmPR5uzGFfTw2yc6wARFGc8Lhz8woA8DzP8zyAgoJXOc4tPdOs7Jx1Fjkt1QjAbh+N0cVKnLO11d+c/VqidbrY8TEHgLQ003pqoFJFREZHAXA6x2empyRmWdlBGfn4TtPTU07nuCE5RaPRKJUqn+9RaBFoNFqJmPJODo8MTXg8ADJeeDHdnAmA49wjw39OTk5KOlqtJuQUURQpEYIg8H5/zZlTd0aGRFEURfHOyFBdzWme5xcXF5c6FRlyikSIS42IBOB2u6oqPwsPVwLw+31LImLVVrEiwOzMrEQU7bIlJCY+VWdbmvGx8uxMyACpaUZABIg4XVycLi7oLUXjdlN/X28IH21Hurn6q1qSpNbW8wmrNe/u3ZEpr/cpsidncmJSUv25hogINYCrrZdbLl8M4vvQu4cPHDwEwOfznTp5wj56b5UIWFZfX9+wJTISwOBA/4Wm84KwEATAPnovJWUbw7A0TVsseT3dXXNzc8EAyssrdpjNEs0wbGnZgRit7hWL9cTnJzm3y+V6AMBqzWv4tpFh2J05lsqq0wyrl/QVCoVCoejt7Q4GICNl2dkWiqKWRzHD6uPjE8OVSnNG5o3rP9O0/EztuQi1mmH08fEJcrl82Zbn+WvtbW73g1VqQJIky7LxCUlbtyawen131x+pxu2lpfsBdHS0AVim//n7L2tuvofjXC6n03l/wsMtf71gAE8epVL13YWLUVHRCwsLAGiafvjw36MV5Sv1n5D3Ip/vUfOlHyTXNE0DuPTj92vxHsLidevm9eWpMuawd966scmbXSAQaGpqlJpdU1NjIBBYoyER0vKbnJwCwLHygNwowP9xu/4PNBxyEs2owgoAAAAASUVORK5CYII="
    m["dark_bg_scroll"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACcklEQVR42mMUE9NioCVgYqAxoLkFLFhF1TW0IiJi5GTlHj9+9P3nd2IM+vnj58UL5w4e3P/v319kcUbMOAgLj4qJTWRkZCTDvVcuX2qor/z58ydchJmbWxTN7SWlleSZzsDAICYuzszMeuHCWZxBZO/gBDG9r6dj//49+I0rLCq3trHr7+s8euSQpKRUZ/cEQUEhJyeXBfNn4YxkQUEBCOPAgb0E3evo5MLOzm5lbc/AwPD8+bNrV68wMDAICAoSjmQGBob///8TtADiVzs7ezs7ezRBGiZT5BjG5wNYiAlpaesgO+r////Xrl55//4dXOTNm9c3blyDyx8+dJAECzq7J0hKSqEJPn/2LC01Ds69ceNqZ3vLIMvJcFBeWoA1iKhmwfv3744eOURDH1hZ29ra2TMwIKe8/4cPHTx29DB1LCgsKufg4EATNDE2J94CApGMadD///+PEm06YR/093X293UOkQqHmZnZyMhMRARaetvY2uOuW36dO3fq79+/pFkQE5sQEhqJyAEVtXi0rVm9fOGCuaQFkYSkJPEeR1OsqqqmqqpGbCSvXr3i5YvnX79+wZ63MXymoqLe2z+VgYGhuDD79u1bOC349fM3hLFx/ZqPHz/gyRlsbGx8fAJCQsJQ30hAfSMgKIQviG7evA5h5OQWCggI4rLg1s3rDAwMurr6NbVNyOJ//vy5dfMGlkoJ3qrg4OScOm2OmJg4eclx8+YNs2ZMwRRHtCr+/Plz8cJ5E1Mzbm4eUk0/euTQtKkT/v37h88HUH9wcNg7OGtp6bCxs+FvZr3/8F5cTPzjx48nTxy9cOEcznp7tPFLCAAA6mDcUMaL1ZEAAAAASUVORK5CYII="
    m["dark_bg_search"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADN0lEQVR42u2WSUxTURRA7//9fCHQkliEDrBhSkATRAmltQ3EKBA2SlF0x1AG3bBxR0yMLNCFGoEYiSTiwqgYQIMIRJcCZVDaYhygZej/bT+EghKKBu3nuXhCkDA8IixMvKubN9zz3r333fuo8PBE2EuhYY/l3wcwW80xjFar1+r00TGxcnkYAMx6Z8bG7H3mXrO52+/3kwCozYKsN6QXFpVGRCg2nBUEz4PGht6eN9sCJMHBB9Z7jZYUm8pLSi+GhITgEd7F20c+ezxuEaFQWSgASKVSgyEjKCjQZrMghHbmomJT2anTeQAgimJXV/uzlubpaWF1VqFQGvPyM7NyJBJJrjEfIdR4v2EHN9Ab0k0lFwDA51uounq5o71tcdG3doHP5xsc7P/08YMmTceybELiocmJcZeLI8oihmEKi0rx2a9VV70ftm62zWazXK+uEkURAIqKyxiGIQJotXoc1a6u9mGbZevoWa1Dr191AoBSpUrTHiMD6PRYed7aTJKCrS1PsaJJ0xEBomNiAYDnuakpgQQgCB63iweAuNh4IoB8vxwApsms/2ZMCQCAnyFxqaCoHZQaigaA5c2fwh+Aua9zABChUJIDIhQKAPgyN0sEcIyOAEBUZJRSqSKxrlSp1OpIALA7RokAfeZerOQaz5IAjGfOr2zsIQKYzd2C4AGAzKycpKTkra0fTj6aeTIbADyCu7+vl6hULC8vz856DYYMmqY1aTqHfXSzfE0+klJZeYVlWQCouX2D55yktYjnuaCgwISEgyzLpmccl8vDXDzn8y2s9XtBUanJVI6tI4RsVsv4mGMH/YCm6YJCkzHv3OqI2+0SPG4AUKrUOKpYEEIURSGE6mpv4bJB1A8QQlbL0OTEeGxcvFQqBQCZTKZSR6rUkTKZDK/xCO7ampsW6zuNRktRVKpGOz8/b7ePEAGwuFxcZ8cLp3NC/ClKAph9Aazf7xempyxDb588fniv/g7HOcfHHDPeGcxISUndkEH9/b/oRGZ2RcUl7Kv6u3UdL9uIbkAuW99jFwCY4fV6U1cYTuckz3O7CVjH+L74bWDAvMsAzHBOTvxYWmpqerTayan/n9/t5BdHgmEIRuuHHwAAAABJRU5ErkJggg=="
    m["dark_bg_server"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABoklEQVR42mMUE9NioCVgYqAxGPoWsKDxXdw8goLCpKVlmJhIs/vfv38P7t9duXLZsaOHkcWZublFkU3Pzy/h5+dnZGQk1aWMjIyCQsK2tg4PH95//PgRdh8EBYUyMDD8+vXzzJnT//79JS0omFlMzSyYmZnDI2KQPYFigbS0LAMDw5nTp9rbGskI7praJnMLK3l5BZxxAAn3f/+hbldWVmFgZLx75zYDAwMzM7OhkQkHBweaoT9+/Dh/7szfv38ZGBh+//kNNwRnJMOBkpJy/8TpDAwMRYXZd27fioiMjYiMwapyxfKlS5fMHzTJFA7u3btbmJ8JD6IVyxffvHkdVxARa8G/f/+YmJhYmFkh3Lt378Cl/v79e+b0SfyOZWZmhhiC04KHD+8rKiqbmllU1zT++fuHpKBgZmY2MTFnYGB48uQxTgtWLF9SWVXPzMxsYWlNdqCvXbMSZ05+/PjRw4f3JSSkBAQEyCgqHj18MG/urP37duNLRVzc3BwcHGQUFQwMDH///vn58wd60I2WRaNl0WhZNFoWES6LGEfbpgNuAQBPdQergKYo1QAAAABJRU5ErkJggg=="
    m["dark_bg_share"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADuUlEQVR42mMUE9NioCVgYqAxYKHcCF5ePnkFRQYGhgf373358pmaFnBycsXGJXh5+zMzMzMwMPz582fb1o2LFy/48f07XA0zN7co2RYUFpW6uXsxMUHDmYmJSV1DS0pK+uiRQ1SwwMzMIi4+mYGB4eXLF0uXzD939rSsnBw3N4+cnMKdO7eePX1CaRAZGZtCGC3NtQ/u32dgYLhy+dKkKbMYGBgMjUxOnzpBaSri4uaGMJ4+gTr2CYzBA5Mi3wJpaRk1VTUI28cnAMJwcHSGMF6+fAFXyUhqRhMUFIqMinV182RhgQbv////r1+7ysDIqKmpxcjI+OvXz7yc9KdkxAEXF3dgUGhAYAgHBwdE5M3r18KiooyMjFraOnDLZs2YCjcdiwWsrGyOTi7KyqoMDAx37tw6sH/v79+/WFhYnF3cY2ITBAQEIcpev361csXS3bt2aGhohEXEqCip/mf8f+fO7ZXLl9y4cQ3ZQJQgUlZWqaxuEBeXgIu8ePF8+7bNHh4+klJSEJHPnz+tW7ty44b1v3//IsbfCAs4ODknTJgmLSOLS+mPHz82bVy7ds2qb9++klMWubq6Q0w/dHDfrFnTGBkYi0sqDAyNISG7c8fW5csWv3v3lvzSVFlJFcKYPm3yxw8fPnx439PdDhE5fuzI1CkTyDCdQD5gZKRCcY0oi0RERU1MzBkYGMTEJW9cv8rJyVVYUikpIcnAwCAjKyckJHz3zu3vSMUkkQApkjk4JkycTvVIRvjgz58/V69eNjA05uXlhUs/f/Zs9eplEuJSvLy8LCws2jp6Hp4+jIwMt2/f/vfvL2k+gGc0e0cnFWXV//8Z7t65dfDgvt+/f0MyWnRMvKCgEHpG09SMiIhRVoGov71yxeJr167is4CcogJJzf///6dNnbhj+xZyKpzfv39fvnRhz+4dHBwciorKTExMXNzcjAwM////v3r18qtXL0VFxRgZGQ0MDI8dPfzp0ycya7QfP76fPn3yyOEDhoZGfHz8DAwM8+bOnDq5f++ena9fvbKwtGZmZvny5cvlSxcoqg+ePn1y6/YtCHvrlo0QxsGD+yEMcXFxKrSLvn2FJlZpGRkIQ05ODsL48vUrFSp9RiYmewcnBgYGExMzBob/aupaqelZ3Nw8DAwMK5YvfvbsKaUWPHv6RFpKRkFRkZubx9jYzNjEFGL6kSMHV69cRp120bnzZzjY2ZVV1CBNoz9//mzauG727Ol//vwhv07GBDw8vAqQpuPDe18+fyGQk4de6xoA4Plw/1boGwYAAAAASUVORK5CYII="
    m["dark_bg_shield"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEIElEQVR42tVWa0xbZRh+zumZvXIZHR09hWAX0DHG0DiBDuhKT4E51P3xwmZCYkxcoj+MmcsASxkX527JNmOWmLg4p4Dwc3MqG61jDAoCC1oKbM6UCqFgKfdY6Errjy710LVcNmbi++97v8vzvc/7vN/3EhLJNjxJI/GEjVr9UoIgEhISAdy797vX611PALF4U46ayc3fS0tlAMbt9hvNhsYfvx8dta18rWVysGHDU+kZCnWO5oUX00kykEyv19vf32fQX2tuNsw7nWsAIAhiW/J2hsnPylby+QK/3+n8+1bLTQBB/Xp9Y5+592HqlgCEh0fsLXhVrc6V0jT7pr/92qPXX2trvbmwsACAy+XuylQyTN6O1OcIgvCvtI2MGAzXf7h6eWZmOjjA+S++iouNC9igb2q02/8KGn50tITR5AdcaGh46L2DbwcHuHK1CcC809nS0hwq5KDq8lGanb2bx+cDeKVAs5yKuro7Pjt3evXy9Xq95l6TudfEF/CyslT/daE9OoCUpj/48HCGInPdKpltUWJx9SenJJLNCkVWoXHfOkcgFIoqKo5LJJsBdHd3PRZFEZGRO3emcTgcdnlryyqflssB9PWZz505+VgUnThxRhYb19HedvzTSrfbTZLkoY+Kt6fsADA0ZK2q0LpcC2uIYH5+HgCPy2eLHEB6xq6S0nKKot49+H5mlhLA+Lhdpy2em5tlb+fxBL4yCgkwPT0FICJyo99TXVk2OTEBIC1d8fn5Lwte3gdgbm72qK50fNwemPmNUQAmpyZDAjgcDgA0LfOTPjw8VFpyyIchk8UCcLlc1VU6q9USyDVFxUhpABMOR0iAXlMPAKFQuDXp3/eDjeHxeE6fPGbuNT3M9dakZIFAAMBk6mH7OUJhtH/gvn8/N+8lABwOx2hs9ftnZmba21sFfEH9dzVG462gySwqescnrYsXLzhY7C2JYGCg3zpoAbBbxcTHy9lTNtvI2bOnQp0ul29RqnIAWCx/3L3TH5Iij8dTW3sJAEmSJaU69q+yjPF4vMNHPvZ9DDXffh3wAC+hyMd4QuKzMllseHiEXL7F2Na6uLi4zOlcLre4tDwpKRnALx3tdbWXAhYEAgDo7urMVqpEIhEti01JSb19u9MZ4ssVizdpddWpqc8DGBsbPVpe7FpwrQzgcrk6O9vT0hUikShaItFo9kxNTVoHLezYSZJkmDytrtKn3dFRm057JECgK3QVUWKxtqwqMfEZ3/BP62BDQ21bawuAzEzlG4UH4uLifVN37g4cqyqfmHCsuW2hKOrNwrdee30/RT14smZnZwGEhYU9kLXb3VBf21Bfs0yeiBV7UylN7z9QpFIx7AbC4/E039DX1X1jGxl59MaLbTExUkazJ0fNAPjZoG+6/tPYmG01G4n/fXf9D3S6oAUjDcm/AAAAAElFTkSuQmCC"
    m["dark_bg_shuffle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADCklEQVR42mMUE9NioCVgYqAxGLUAApiZmU1MzPgFBDClWKhiQURkbERkzPt376oqi588eUyLIGJkYGAQFBJqa++VkZFF8Rw3tyjlxl+/dkVBQVFGVo6Tk9PG1v7M6VOfPn2E2gzJBwICgh1d/dLSMsjafvz4MXP65D17duIx2sXFPT0zl4ODA1nw799/eTmpjx49RASRopIymukMDAwcHBx5BSWubp64THd188wrKEEznYGBgZmZyczCCiWIXr96ycTE9P7D+0ePHkLQ82fPpKVlGBkZzcwt37x5c+/uHUzTc/OKGBkZ////f+rk8VcvXoiIiDIzMzMwMDx9+qSvp+vfv7+IIMLufTePvLxiiBEzpk/etnUTLqnz5890dk4QFBJiYGA4dfJ4e1vjnz9/CEfyvbt33rx5Y2ZuycjIaGJiBveHlbVtcUklxPTJk/p27tiamJCqo6uHaTrhVIRsBzysAgJCVFTVIKbv3rWdgYGBkYnR1Mz82JHDPd1tyKYTCCKswT15Ut+lixciI2NOnTp+7NgRwpmcmHxw7+6d129em8P88ezZk8WL5z9+/IioUoTIjIZsh4mJ2cePH2/fvkk1C6ysbIKDw/fu2f3w4X3MOKfUAlc3z+KSSiVlFQ52juXLF2PGOQMDg4Wldf+EaYqKyidPHvv37x8JFiBH7+rVyx8/foQ1XQUGhqprasnLKygpqRw7egjZDnwWoOWmfXt3Y43zjx8/7tu3y8bGnpOTU1pGRklJ+djRw3A7oMmUmZk5KjpOCqk4YmVhhTgTOb3jKSpYWVh19fRZ2dgYGBiePX2SnZX2588vhA8MDI1zcovk5BTgSEZGFo/paHlQRkZWUkoaUhAxMDDw8vH9/PX92tUriNL0/r27T58+QTPix48fkyb0YDUdAnbv2j5pQs+PHz/QxP/+/XfyxDEScjJBwMLCUl5Ra2FpzcDA8OHD+6qKksePH1KzygyPiIWY/v7du8ryIrjpVKyT/0NMx6z0qRNEzMzMhobGt+/c+vjhA3prYLRtOuAWAADMWJnmmPGY4wAAAABJRU5ErkJggg=="
    m["dark_bg_sign"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABZklEQVR42mMUE9NioCVgYqAxGPoWsCBz8vKLXVw9GBkZyTDo////+/ftmTih+9+/f8jizNzconBOdW0TeaYzMDAwMjIqKikzMPy/fPkiTh9ATH/z+vWNm9dItcDIyJSLiysiMvbu3TsnTxzDbgEE3Lh5tbO9hVQLzC2sqmsaGRkZi4orSoqyHz9+TOVIPnni2M4dWxkYGLi4uAICQqmfikTFxK2sbSHsCxfO4QsiERFxG1t7rKaIi0swMDC8fPkCUyo0NJKPj5+BgWHTxvWHDx9AxCtyUbF56x4K/XHl8sWa6rK/f/9iD6KnTx5TYvqrVy872puRTUf3Ab+AgI6OHq6soKGh5R8QzMDAsHHD2hs30NPx3z9/r169/OnTR3w5+eOHD0ePHMLjRn+GYAYGhhs3rh05fHC0NB21YNSCUQtGLWDAV6PhAs+ePvn//z+EQUJzhqTGr7KyCgMDw927d2hlwWCMAwB323VZS2S09QAAAABJRU5ErkJggg=="
    m["dark_bg_skull"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD5klEQVR42s1W7U9aVxh/rjibAgNxveCyArVqZWgtmVBdZzUdvqTN/gFp5h+wlzRL7OraMUftNMuWLc2Wflqy1UVcXz60mSu2Zmu6GUWrKCKWNrW8CNjJRdiEexEu3H04Gdl4N7FJn0/P/d3nnN85z3neMKFQDs9SiuAZS3GBdlwuRyKtEAjKmEQi+FfQ5bSHQuEdICgp2aVu61C3dx6orsEwLIkzDPPokW38zthvv47HYtEcO2A53kCpanzn3VM4Lsyxfn396aVvL87N3d82QZemu0vzNjp1LBabN81arUs+3zqGAY4L5fKDrzUoi4uL0W30wz/8NDK8DYIuTbfmZDdabLg1OqIfCgYDKTZlZS9pTnZ3dJ5Ah/hx6PurVzJwsDgcPN0z773/AYZh0ejW4IDu5o3rkUgkfSVFUTMzRofd3th0hMVi1dcrHj58sLbmzUNQUrJL1z/I4XAZhhkc0M1MT+WOArfb5V51Nh9txTBMLq8z3Po5kUjkygN1Wwd61THDaN7dkUxOTozfNgCASFR+7M32PImmbu9Er6ofHio8m4b1l2maBgB1W2euPOC+yD1QXQMA86bZYDDAYrGOn3hLpXqdAeb+jHHMMBqPxwEgHd/w+xcWTErlYZnsVTabQ5LhzARSaQUKCat1CQBOf3jujeYW9KuhQSWvrf/i8/5s+LJ1Uak8XFRUJJFIbbblzC7i8/hIIYh1mUye3AVJS0trjUyeDSd8BPosFQgKKhUV+yvTwf2ZQIRTJJm/miazSSQS+QlfujVB+LLh5S+XIz0QCGQlcDgc6BkVhxoWLeY17/+yxuNxWxYXsuEKhRIAaJp2Op5kJSDJsMViBoCDhxTiveLzunNLFjPDMAzDLFnMF85rI5FIhKLScYlkn7y2DgDM5vmUtE+tRUpVY9+nnwGAy+k43XOKJMO7d7MBgKJSXZzE2WzOl199IxZLAKDvk17T3GyuUuH1eqqqql/ZK+aXltbW1U8bJ8PhEE3H0v1O0zGajvF4/D7dQGVlFQBMTU1cvaLPX+zmTXNNTUd4PD6OC1taj/1+724kQmWMEIGg7OuLl6TSfQCw6l690K+NRqP5e/Lm5t9nz/bY7SsAgONC5NyMIq+tQ4Xrycrjjz/qCW2GCm36G35/8rL/7ZSpzeTfX9eujWxs+J/XqeJMr/ZMr3bn56Ktra3Cd8lhnCGKkPz5dI3FeiEQ8LtcTpKk9uzBAcBme0AQRFK32ZZdLue00Xjn9i8Mw2zPRfF4fOjyd0hvPtoq69UCwM0b1wEgqU/8cW9nJjuvx40O6PW40aiR1PMKVuDwi3J1ZeVxir5jBM/vdP0P2NHarlqp+EIAAAAASUVORK5CYII="
    m["dark_bg_sliders"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADHElEQVR42mMUE9NioCVgYqAxGH4WWFhar16zOS+/GFOpgIDgjFkLZsxaICAgiCmbl1+8es1mC0trAhbY2TlycHK6uHpgGqGlpS0tLSMtLaOlpY0p6+LqwcHJaWfnSMACRiYGBgYGRkZGTCO4uLkgDE4uLkxZiBZGJnLjwNcvKDOzAMLOys738w+kZiRb29ilpWexsbNBuGxs7Klp2VZWNlSzwM8/mIGB4devX5MmNk+e1PL7928GBgb/gBBi9LIQo0hBQZGBgeHMmSNLl0xnYGAwMbW2tHRUUFSimgVv377m4pJXVdWSkpJjZGRUVdFiYGB48/oV1Sw4cfy4rKy8qKjE+o0nEIInjlEtDpYvW3jlyiVkkSuXL65YvpgcC9jZOSEMZmZmuODv37+rK0s2blgH4W7csLaqsgQS1SRYwM3NU15ZY2pqDuFOnjpLVVUdLvvv378bN65C2DduXPv//z/J+SArp9DGxgHOlZWVr6lr5ucXoE5hJyQsbGdnz8DA8OD+7ebGwl07NzAwMAgJCdnZOxBjioqqGoQhLS3Lw8uDxQJISmdgYFiyZPqWLSs72suh4vKEE3tIaHhf/1QIW1FReeashcoqqugWvHn9BsIwM7Pj4uKxtXWFir99g990VVX12Lhk5MKRj4+/tKyaiYkJxYInTx4/ffqEgYHBzT1g/8Fbjc1TGBgY/v79e/r0CfwWmJqZQ8yqqcpwsFOBhK20tIy0tCyKBf/+/e3uav306SNyslm4YM6d27fwWyAsJAJhHD267/v3b6dPH4ZwRURF0VPR3Tu309Pi79+/C+EW5GWsX7eaYAQ8fHQfwqis6vL1i4iJzYKKP7iPJaN9+fzl6dPHEPb9+/eIST8HD+x/9+4dJGxravvk5ZUZGBiOHDn47t1b6lT6Hz9+aG2ue/TwAVzk0MF9kyf2UbNVcevWjdycdAj79Onj3V1t3759xWnB/38MDAwMWEuCf3//ojGQUsRfiJYf338SKOwOHtz3/fu33Tu3Y1pw9dqVp08eP33y+Oq1K5iyu3du//7928GD+9AbA6Nt0wG3AABvyBfrD6D7SgAAAABJRU5ErkJggg=="
    m["dark_bg_sparkle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACwElEQVR42tWWTUwTQRTH35RtLVmpp5Z4klBqKTf7CbHddsu3QEjApJBIPGnkAhoPkigxJnjQC+HURBMT5UREIwppoNDd7mL4qOVIKQI3JcDJlpW0XVgPS0oDCla3ROc0MzuZ387/vf/LQxpNGeRyyCDHIzuAVlui1ZbkCqDT6fsHvP0DXp1OnxNATX0DQgghVFPfID1ALlc47IQ4d9idCsUZiQG28gocPyvOcRy3WG0SA0iyKnPpdldLCSgoUBlNFgCIRhaj0QgAGE0WleqcZACni8QwDAAoaooKTAIAhmEOwiUBQKU619jU3NLqAQCe51mWZhma53kAaL3qaWxqPvEd6KelQi5XWG3lbne10WQR/x0AZmc+Pu57CAD3Hzwqr7gsbvI8vxAOBQL++bnZVCp5MqBEd7G2vtFhJ9I5I94S/jT//Jl3Y2MdAAoLz9+42WkyW9NsAOC4bXaaGfeNrnxe/iWguFjbP+CVyQ50i0YWKXqKCVLxeOxo5AknSboq9YaDG/b29u50d66trZ5esTtdiU4jyEfTlHC6Wlo9arWG5/nrHR4AeDk4hGHY1tbm2zdDTJCOxb4dc0MejquP+ZxIJJaXo7u7vNlsk8lkW5ubF4qKrLYKABh89WJsdCSRSEjg5CBNieYiyUrSXbVvOoaWrFTE47GFcAgA9IYyvd4AAAvh0CFlurrvvh7+kI5N1mlKUZOZy0DAf+hAVXWdMj+fIMhD+9hvAuZmZzhuW8xdjuNC83P7MczLu2Q0K5VKhBAAqDWFdodz/euX1dWV7ACpVJKdZupqrwAAOx1MJvdj29be0dZ+LX2stNRQ2tMrCMLtrluin7Nw8oRvTBAEQRAmfGN/7uQT2xYASD8/U6J7Pb0AsLQUGXk3nCkRkqqzez/qRwixDP30SV9OOjv/uG9n53swGPgrif7/3vRfBPwA/Qwuyh+wRZEAAAAASUVORK5CYII="
    m["dark_bg_speaker"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADNklEQVR42mMUE9NioCVgYqAxGLVgSFkgr6A0a/aiGbMWCAgIUt8CXT2Dzq5+SSkpaWkZLS1tZClmZua4+JS4+BQWFhZMjSzEmG5r51hYVMbKygp1FDMzsqyhkUloWAQDA4O0jExne9O/f/9I84GvX1BpWRXcdExw987t9+/eMTAwWFnZBAWHkxBETExMqWmZaelZjIyM////v3DhHFrImJpZCAoKvX//rrqq9Pv3bwwMDJFRseLikjiDyMLS2t7BkYGBEcIVFhbR1NRmYGD4/ft3f1/X////DAyM4IpjYhNCQiPfvXtXUVbw+PHDeXNnZecUsLGxBYeETZs6EbsPiosrbGwcbGzsIQhi+tevX+vrKg8f2o/Vl0JCQqVl1UxMTLt2bn/58gUDA4O9gzNyeKJYwMHJiab/3t075WWFly9dwDR66ZKFly6cZ2BgUFVTNzWz+Pfv7/59exkYGLi4uNTVNfGloiNHDnS2txCM/D9//sycOXXq9DmQsD154ti1a5chUopKSleuXKJCTn706MH79+8YGBhkZOQYGBjevH4JEUfOiZQWFYyMjJiCyDmBIgvk5RUhjn36+BEDA4OIqDhE/OPHd/jiwMbGwWarAzyS+/q6Hj64h6UMYGHJyMyBsI8dO8zAwKCjowvhPrh/H7sPfnz/jmaKkrJKZ1e/rp4BpgXRMfE6uvoMDAw3r187c+YUMzOzvYMzJFnfuHENuw96ezswMxo3N3djU/uE/i60QgYC3r17193d/u/fPy9vP3FxCQYGhoMH9v358we7BSeOHz1x/ChyUZGcku7nH8zKylpSWnXx4nlkxUsWL7h27eqd27fev38nL6+YmJjKwMDw69fPtWtWopQo3NyiuOLw////586e+fLli5GxCSMjo4QEtJA5euTQo0cP/////+zpkx8/vgsKCnV2T+Tl42NgYFi8aP6Z0ydJK003b1rX3dX2+/dvXAqUVVSFhIQYGBiOHDm4ft1qNFl8PkBkqIcPrl27amFpxcbGxsDAcPjg/sePH8FlX758wczMeu3qlVkzpvz9+xc9oxDf8JJXUKqqqf//9195eeHHDx+IzYmjLbtRCygGAHKNKh3+KP9TAAAAAElFTkSuQmCC"
    m["dark_bg_stop"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABT0lEQVR42mMUE9NioCVgYqAxGLWAIGDBLsrCYmvroKqmJigkTNCIb1++Xr588dChA//+/cWUZcRMRTIysuUVdQqKiiS59NKlC92drR8+vEcTZ+bmFkVze3NLN6mmMzAwiItLqKmp79u7m0AQ2do6QEw/c/rk1Cn9b968IWi0mJhERWWtqpq6jq6+qZnFqZPH8UWyqpoahEGk6QwMDK9evejv64CwdXX1CaQiQSEhCINI0yHg8ePHEIaIqMhoRhu1YNSCUQsot+DN6zfwWoF4U0RFxSCM9+/eEbDgypVLEEZBcbm4uCQxpouIiGbnFkLYN2/eIFCjMTIyNjV3GBgakxEa9+7dLS7M/vPnD74ajYGB4fy5syqqauLiEqSZfvdOZ0fzx48fCdfJDAwMTEzMtnb2OnoGPNzcBI1+9/bNzZs3jh09jOZ2fBaM5oNhZQEAYq9m98kPy+UAAAAASUVORK5CYII="
    m["dark_bg_tag"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADMUlEQVR42u2WS0wTURSGz9CJHV4JDC3Q8pQUgsgblCmFCqKElSTKAoMb12o1QiKgJjy0pVFYEAMuiCZiUNyaIGIFiqUvixSRoJSXaUEIRQKFCLHpuBhsjAx0hoSFiWd15s45/zd/7rk3gwQHJ8BBhhcccPz7ANSdEWJJeUUVhmF7N8x/m6uvuWWzWVk7kErzPaoDgFAQJlc0hodHsHaA/GZpNOrdqkNCBLGxcYE4Llc0VleVM/GB7lxSKup3rUbRG5W3CbEkEMcVyqbqygqr9es+N5nH48uuVjxoaauta0hNTacWnU6nsqFerxsEgICAQHnD/YiIqP0AfHx8Fcqm04VFUVHR6RmZdXeUySlp+2PQAwixJDRUAACLiwskSSIIUlx8zv2WFYMegONBVPKo7aHdvgQAPD7/zwLmDHrA5OQElVTdrOHzgwHAMvH5rxqGDHqAeXio9+0b9+Pi4kJ7++OdZUwYHF/fbe85udLIyGgAeNbxBAD0usHx8bE5m7W/V9Xa0ryxsUH7KS6XS6fVREcfDo+IxDBvSY7U9N64trbK6C4yDw+96OxQqV5vbW3tUUb5MBp0lI+78nsCgZAGQLq2k9LzZWxvNKfTqZDXTk9ZACAQx0tKSmkAAwN9LpcLAMouXLx0+ZqXF4cV42RB4eEYEQCQJGkyGWn2wGazzsxMZRHZKIqKYuPi44/o9Vqn8ycT9VOFRVdk1xEEIUmytaW5r09FAwCAOZvVbB4mCAmGYQKBMDk1zWDQbm1uelSXycrd6q+6XtJPERXLy3adVpOZmeXv788L4mVLcodMRofDsT91GgAArK87NBp1UnIKjgf5+fnn5ReMfRqlzjNbdXoAAGxu/lCre2NiREJhGJfLlZ7In52dnp+zsVXfFUBNnuZdfwAeJBLFoiiaK81bWfk+NWlhpb4XYHvgjHoASEpKQRDkeJb4EJc7Yv7AXN0DgIrR0ZG11dX0jGMIgiQkJCYeTTpTfJZSb25u7Onu2rvdMwAALJYvs7PTBJHN4aAhoQK3uqqn22MvIwB1DEc/jhBiCZfLZa7OAgAAdvuSQa/1xrw7nz9V9/cy7EL+//x6il9684sYF1JLQwAAAABJRU5ErkJggg=="
    m["dark_bg_target"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAGBklEQVR42tVWa1ATVxQ+u9mIS4A8SCIPLYSEp61gHCWmsWgqIorjjC+0ajs4IwUqdazttD5aqbWWtoqtT6TWap1apVVrQWIpj4A8AgSI9YFVEpAKiNkECMEZzLrpj4uMpIraqT96f929e+75zvnuPd+5mFgcAc9z4PCcB/GUdl5eXIG3QCgUg9Nppiirherrs/0HAL5+fmp1bLRCKZFIXX6ZTMYaXWVpSVFnZ8cIHrDHnQGPx1/62oq4uLkEMVIQNE2f15w7ceJYb0/PMwCEh4/fuDmDx+Ojz/7+/ob6ura2FspMAYDAWxgYKJFPmszhcJBBd7d1+7aMa9euPhXAtGnT161/n81mA0BX1+1j3x+urCinadqVXIJQqWJWvpEkFvsAgMPhyNqZWXGhzMWMxeGIXGLf9OFW5L3gXN7WjE0tJiPDMP8MjWGY1tYWTUEel8uTBYewWKzoaOVFQyNFmR+bAZfH27vvG8TM4W9zzpzOReuBEsmsuLlRUXKRSAwAZnNXY0NDYaHmZqsJGSxYmJi0ajXiKv2t5N7enkdnkLRq9YQJUQDwe6Hm6JFDAMBms1NS09PfXh8aGs7lcgmCIAiCy+WFhoXHz0ngcnkGQwPDME1NV/h8fnBwKEmS7FGj6vW1jwDw9fNbu/Y9HMdv3+7M+GgDwzBsNjtj62cqVQyGYQBgsVJXL1/q6Gh3I0e7k+4YhoWEhEWEjy8vL2UYxmBomKGeyeF4SKWyMm2x3W53BZg/f8GEyIkAkH1gT4vJCAApqekqVQxynbUjc//er7Ta4jJtydlfTplMxpdejCRJcoyPr6enp15fyzBMn802VanCcdxut1++dNFVKhQKFbqRlRXliPfZ8QnI+7vr1tToqpxOJ7J0Op266sp31qV1W60AED9nXkCABAAuXND299sBQKFQumqRlxc3UCIBgIb6OnQjZ8XNRczs3/s1RVE4zlq6bPnBQ0ezc44sSVyO4yyKog7s3w0AOI7HzY5HRdfYqAcASZDUw8NzGIBQKBwSADSJipKj8OtqdQCwJHHp8hVJfr7+/v5jV76etGhxIgDU1FShJKImTkK7bra2AACGYUKRcBiAQOCNJj3dVjQRCUUAYDIaETOvxKgfvt0xMWpUCkZTMwCIhGK0TlksaOItGA4wxC/g2LAywbCR1RAZMA+2YzBo7wTnMACrdRBZwB9MxUyZAUAaJEMutKXFD/vVaosQ+0hlKfOdwcC9BwO3WKzD5NryILXAQAmaNDbUjxv3Al8giFYoddWVP/90EgDU6lgGoKSo8PSpXABQTH1ZIBAAgMFQj3YFBAYgPiwPBGMQwGbrbWkxSiRS+aTJBEHQNF1YqEmYNx/H8bS0tc03rlOUOffk8dyTx4eSEInEb6ako5P47bwGlb1cPgUAjMYbdnufax3oqisBgMPhoOK62WrSaPIAgC8QZO3aN3WqCscHjXEcVypVO7L2ovALzuW1tbUCgGradHd3dwCo0VU/Qux8ff32Zx8mCOLOndspyUkOh4MgiI8/yUTqBABWq9VkvAEAUlkwny9Ai38YGrds2UDTNJs9KjvnO7F4DE3TKclJXV2drlJht/fxePyQ0DAOx0PoLdLpqhiGKS8r8fT0lMlCMAwjSdLPf6yf/1iSJBEz+flnd2V9jgozNS09MkoOAPl5Z8rLSx+tps3N12eoZ5IkGSSVDQwMNDVdYRhGr6+trqq4f58mR5Nubm40TXd0tJeVFe/ZvaukuBC1ioWLEhctXoay/PKL7QMDA4/taGFhEdszd6KGc16Tn3Nwn8PhGKEO2OxRyalrZsfNAYB79+5t+GD99T+bRupoFGVub78VHa1ksViy4JAZ6tg+m+3WrbZ/NjWCIGKmv7pxc0Zk5ETkPWtnpqGx/qmaflhYxMbNGUMneffuXb2+7q+2VlRQQpE4IDBALp+C7gxi5tNtW1xif8KzhcvlJS5bER+f8MRni6bg1xM//mCz9T7buwgNHx/fGepYhUIZJJW5PryMN6qrq0pLioZu5L8BGBoeHp7eQpFIKAQAM0VZKPNQrT5BDf/3r+u/ARwdg9lMJJB9AAAAAElFTkSuQmCC"
    m["dark_bg_trash"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACZElEQVR42u1Wz2sTQRT+xpT8kO5svTTEpNHa6kEUUTy0RI1aQ/0PmpIK4sleNBJKcvHkxV7qoYgXQaim9T+oNaCeJRpREH9UDybVa3Y2lhx2Mx4muw1lN7vbUETwnd578+Njvu+9mSGDg0exm7YHu2z/PkCf4wyfz3fy1OlgMLgt32w2K2/Luq73CpCevpKenrEcerpSLD551CtFsaHYDoY8nMC0+bt3TD9fuO1yFensgxs3c5dSlwkhO5aUc15aW11cXLCmKHEm2cvuAAghibNJW4ruLcwnz18YkPcdO34CwPdv6z9/bThuuj8SPTQyCuD9h3dMqb96+cKWImHx+MH7Dx4CWFleWi4uOQJkZq6KMpu9fq1W/eFcRarKhCNJshtaJCptW+gMwDkHIMttgLHxRDY7Fw5HRBgOR7LZubHxhAjFNM55Q1VdAWiatrn5G4BEqcjkcoWJ1ORUOiPCqXRmIjWZyxVESPtlAI1Gw7KrrRuNMQaA0vYJgqEQgNDe9m0hHJEEQOUBAGqDeehkxhQAVKKuNJAlAEzxBsAAUNkdQD8FwBTFA4DKGAC/PxAIBLrvHgyF/H4/AKYqninqlMHOqFHKKvN0AqOiqewAIBs0WjaBLYBiECo56WyWsuJJ5K0TUApgo1YFUKvWRFI4ItlBEfPwHpg1J7o0n791ePRIpfLGeMgef/708ev6FwCSIZKdyH3dRRYUKfV6ufzaHNV13QzpFkVeAEyKziUvDsUPdNFgeHhEOJYXUTcAzjkhJBqNRaPOD2+r1fJWRZqmldZWxZ3q5pl8Xnpm938h//+mfx3gD/Jv5PwgXaV4AAAAAElFTkSuQmCC"
    m["dark_bg_trophy"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACz0lEQVR42mMUE9NioCVgYqAxGPoWsOCRs7axKyouZ2Njx6Pm16+ffb2dR48cIscHVtb2+E1nYGBgY2O3sbXDo4ARORUJCgp1dk+QlJRCU3TkyEGsmm1s7NFEnj9/Vl5a8P79O+xBZGfviGk6AwNDZ3szdgu2olsgKSlla2e/aeN67BZIS8tAGCeOH/3z94+GupaIqCge7////5+RkfHN61c3bl5nZWE1t7BiYGCQkpLBGQc/f/6EMJYsXtDZ3nzj5lVi0smNm9c725uXLV0IM+QHTguuXLkEYcQnprCwsBCfFllZWWPjk6GGXL6CM5meOX3y0cMHcvIKpqbm06bPY2AkynRlZdWp0+dCIu/B/ftnz57C6YO/f/+2tzdB0oCklBQ8wtnZsSRWDk5ORkZGSMRCVL5/966rs+nfv7/48sGTx48K8jJ37Nz27ds3uKC+viGmBQYGRnD2169fd2zfkpeb/vjxY3z5AMVmJiYtbd32jl4GBobHjx+VFud9/foFLsvDw93TO0VaRvb///9VFcXXrl359+8fVnOYublFcSXBV69eysnLy8kp8PPzm1tYvXnz+u2b1yysrCam5mXlNdIysgwMDIcP7d+wfs3///+JysmYgIeXp7Nzgpy8AlbZhw/uV5QXfPnyFY8JOH0AK8t+HTq4X0JSQlZWHhKlcP8dPrS/o70Rv+mEfQAHcnIKEZExtnYODAwMhw7uW7F86ePHD6lZHzx69ODYscMQ9vHjR4k0nR4VDuEgEheXjIiK4eDgEBER09DQZGBguHHj+ps3r378+LFi2ZKXL5+TX6NBQHhEtIuLO7KIhoYmA4MmAwMD43+GCRO6KQ0iTi4OXFLsnBwU1clowNfbBc7etGU3cqodxJGcl1/s4uqBy7H////fvXP75Ml95PvA2sYeT1AwMjJa29pTFAf9fZ32Do4MOKue/wf276NOUTGC26YAiBv6YCURZv4AAAAASUVORK5CYII="
    m["dark_bg_upload"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABsklEQVR42mMUE9NioCVgYqAxGFEWyMjIzpyzcOachTIyssTrYubmFiXS9Lb2XjExcV5ePmtru9OnT3z69IlqFkBMFxQSgnA5OTmJt4OwBWimk2oHE/Gmv3/3DiIIYQgKCbW19xKMD3wWSEvLwE0/c/rk/HmzIOJz5844cfwoxI72zj5ZWXlyLBAQEGzv6IOYfurk8daW+t9/fkOk/v7929nRfOrkcYiy1rZuAQFBki1QVFKGm97e1vjnzx9k2T9//rS3NULsEBQSUlRSxmUOCy6JSxfPr1q5lIGBYfmyxWimI9sRGRULUUyyBX///l28aD7+CPzz5w9BNaOF3SCzgF9AwMTEjJmZmTyzmJmZTUzM+AUEcKaizs5+aRnZFcuXLF2ygAwLIiJjIyJjnj55nJGeiN0CaRlZBgYGGVkZrPqfPX3y//9/CAN7wSUrCzeEcD7ABPfu3S3Mz4Qw8CiDOIIcCxgYGO7evTPoUhEWH4iIiNvY2pNhlqiwKFEWaGhoalTU0iQfPH3ymHITn6CmMUbkpiO/gICOjh4jIyPZpv/////KlUsfP3zAbsFoYTcgFgAAlZ2lPHs1xcYAAAAASUVORK5CYII="
    m["dark_bg_video"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACBklEQVR42mMUE9NioCVgYqAxGLVgBFjAgszh5uZxdnFVUlRh5+TAr+3/v//37985euTws2dP8atkhOcDeXnFhsY2EVFR4l338+fPif3dhw8fQBZUUVX7/+/f3bt3UCxgYmLunzhNSUmZ1BD48eNHbnbqixfPGRgYhIVFklIy7ezs////X5CXce/eXUQQSUvLQEw/fvxIX2/nj+/fCUQdE3NwSGhcfAoHB4edvdO6tSs9vfxiYhO4uLgYGBgYGRmlpGVQLJCVlYUwDh86SNB0BgaGf//+rl2zOjYumZGRUd/QyMHRSVZWHl8qYmJmhsbe/39EBs6/f38hDD1dfYjpP75/P33yODWTKSMjI5x9+NCBjPTEffv34Eum5IGfP382NdZcunieVhnt8+dPuEwfIkUFLy+fnr4hDS1gZ2dvbesuK68RFhYhUBaRCv7//w9PSLZ2Dqam5pcvXcDug39//8JSHrF+YmKCZp1Lly8+fvyQgYGBg5PT1NwSuwUPHz6AMLy8fHh4eYgx3dXVHeL8K5cu5uWkz5o57du3bziD6Nmzp1euXNLR0dPR1V++YgPxofTnz5+jRw79+fNn86Z1x44eghd2z54+QS+uxcQkGppacRUpuEyfOWPKju1bCBfXEMDBwWFr56ipqc3JxUmwwnn06OHxY0cePrxPbIUzWumPWjBoLQAAUoXEJRJxpBMAAAAASUVORK5CYII="
    m["dark_bg_warning"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADe0lEQVR42u2W31MTVxTHv7mb0EBkslkwCDgKghgDok6dcYYKVFBorU6hmMSEHwYx4KC++L9AaBYjUoP60PoDREBeKj+iIEUQfGiVqmhFHgqEpGjYzfZhdYjhhwhh+tLv09k9Z+dz755z7zkStVqLtRTBGmvNAdLlh1IUZSosAdDgqOd5PviAw0fy9IZCAC6X68b1n4P8i5RK2mgqFm2jqVippIMMKCo2KxTrRFuhWFdYdDyYgLj4+JzcQwDGx8fGx8cA5H7zXVx8fNAAZWWnCCEA7OdtF+wsAEKIpfx0cABpX6Xv2v0lgMePh7u7Ojo7fh16NAggNXVXWtq+1QKkUqnZbAEgCAJrqxIEAQBrq/L5fABOnDwlk4WsCpCXr4uOiQHQ1tr85I/fxZcjI0/b7rQAiIra8H1ewcoBNK3S6Y0AZmb+cVy6SNOqGltdja2OplWX6u0ejweAwWBiIiJWCDCXWsLCwgBcbvhpYuJvrTY5NnZjbOxGrTZ5anLy6hUHAHloaHHJiZUAEhK3ZmUfBPD69V9NjdcBEIp6/w1FAWi8+curVy8BZGfnJCVpPg8gkUgslkqJRAKA/dE6Ozs7P4bjOHttzfvgitNi8HIBGZn7k1N2ABh42N/b61xsdT099/r6egFoNNszMvcvFxAS8kXJ8TIAPM+zrHXpIqllrRzHASgtK5fL5csC6PTH1OooAM3Njc+fjSwNeDn64vbtJgARTOQPBfpPAyIjI/PydQDc7unLjnp/19uZmQBDVIOjzuWaAlBw1LBeHRXYRRSK9f7PZ86eS0hIFK+doaFBf9ebN2OEkOHhR3faWsQjLcrr9Xq97/bs2UtRUoaJ6Oq6u+gONBrtvvRMAKOjL1pbbgWshef59vbW9vbW+e2s+VbT82d/AkjP+DolJXVhACGk/EO11bLVYur8tWlTXLXVXm21b47bEuDy+XibrVq0LeWV4tUbCMg6kLM1aRuAnvvO3/oezE+XXC6nKEoqlS5YLYMD/T33nQC2JCRmHciZO1LiXBQaGlZjq2MYhuO4M5UnxSM6Xyk7dhJCBgf6F/RGR8dUWc/LZLKpicmKCrPH455r+jq9iWEYAJ5pd1FJ6dKl+e2hw4u5PB43TauUKvqo3njxAju3g4Yr18LDw4M4Drnd00ZD/lwOnF0d/pW3SgmC4Ozu/CgH/8+m/yHgX4oeMk33/ZZyAAAAAElFTkSuQmCC"
    m["dark_bg_window"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACEElEQVR42mMUE9NioCVgYqAxGPoWsKDxhYSFlRSVOTg5yTDr+7dvN29d//L5C3YLODg509KyXN08KXHv////N6xfvWjhvD9//kBEmLm5RSGsrOx8Ck1nYGBgZGTU1NRmY2O9cP4cVASSTIWEhBcsWsHIyPjixfOVy5f8/PVTUkr67ZvXP3/+FBQUZGBgeP/+PUHTubl5YmMS+QUF/v37Fxsd+unTR0QQKSkpMzIyMjAwrFy+ZM+enWHhUbGxiQ8f3O/qbC0uqWRgYCjIz3r44B4xPsjOKWBiYlJTUz9z5hTCAnis/vj5g4GBgZubG+IiDg4OZmZmRkZGDg4OYoLo8+dPEAYnJxf2VKShocXAwPDg/v0Tx4/euHFNTFx827ZNTIxMoqKioqL2BC1Q19DCnkzFxCQgDP+AYH+GYAjbwtIars7Ty5ek2BYTE6dvRnv16gWEsXHD2hs3rpFtnLqGVkBAMAMDw6tXL7HHwY0b144cPkhJRmMICB4tTUctGLUAqwXfv32DMHh4eCkxjpMDWip///EdJSffvn3r379/TExMMdEJ//////r1Cxmmc7BzRETFQvLz3Tu3USz49Onjxg1rAoPC+AUFcnILKQyWXTu3vX//Dr1Ovnz5Ijs7u4aGFqRqI7ss2rlr+9zZ0+GVPiNa05GHl0ddTZOTi4sM03/8+HH3zm2427FbMJoP6G8BADdusGkASMJ/AAAAAElFTkSuQmCC"
    m["dark_bg_wrench"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC/UlEQVR42u2WXUhTYRjH/+dMXOrZUtRxgvzIqWgxRVGblJuKRoSgiZJgRRolIZREVoTSRQRZGESB0ZcFhRdqHxdBUahgF6lLsJlzfg0jL9Tp0rMz9+HOujgxzUXb8HjXc/Xyf5/39395z3ne5yVkst3YyiCxxbHlBgF+74gkFYrUlNQ0mqZnZ+dePG91Op2CGaSlZ5yqqY3aGeVWRka0moE+YQwOl5ZXVZ8mCGK9aF2xCvMNcnJyq0/WEAThcrm6uz70933mdaNxTgADSkKdqT0LgOO4W03Xbzc32R02AC6Xy2icF8CgsPCQRCIF0NHe1tvbAyAyPBKAyWRaXV0VwCBrrxKA3W572dnOK0HBwQA4zilMHURHxwCYmJhgWTOv6PWjACIiIml6x/pMmYzOzFKKRCL//iKxeBsANx2AVjtUeOAggGPHq7q7Ps7M/MjIVKpVuYlJyQRBdLS3PXv62A+DpSWTTEbTNO1WhrVD/EClzlep8zfkh4WF+3FEJCkyMwyAqKgYmey3x/z83JvXnSsrlr8umZn57usRkaSo7nx9nDwBAMMsWyyse+rRw5bWJw/k8YkKRUpMTKxW+7WoqDhOHg9AM9DvkwFPz8sr4OkNV+rNZmZ9gtPpHNPrxvQ6AJVHT/D0Ye2QwTDl3cCTPjU1yev5+QWMmRn8MuBwOADI4xOOVFRmZ+8HYLPZ7rfc834X/YPu1h0Ox8KCkaIoipLwq+x2+80b16anDetRhGdH84XuGQbD5N07zePjY15uU1/oDLP8/t3b2F3y0NBQq9U6PW3Q9PcNDmo4jvNyXZOk6FzdBZ7CsuarjZfd9A2650699wMf9+7W/e7JZeUVgtPXDEiSLC4pBcCyrID0NQOJVCqVbgfwqbdHQPqagYVl+daRlLwnKCg4ICBAEPofdVB/qVGlUvOnxHFOvoVtkg5AFBISyY9Gdd+Uyn0SiSQwMFAsFgNYMv1sbLi4GfrGSqaokOKSspTUdJIkdSPDr191LC4ubPJlR/x//HqLX0zHiwVt3aihAAAAAElFTkSuQmCC"
    m["dark_bg_zoom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD2ElEQVR42u2WX0xTZxTAz/3jXRu5NVmdtLflBasGt4dVCKVdG4hZ3LKXSXGAcSiloO7Fl70ZEzMe3B62ZWrMiCZjyXTqgn/iGBB9WlSqwrgtBrvS8qf33t7bhsIkFsGtt98ePmg6onLJ8GHJztO55zv3/s6f7zvfJTZt2g6vUkh4xfLfB9AvW6Npp9PtdLlLN9uMxo0AMJ2eGhuL3gv0BwJ3stmsFgDxoia7PdXNvrbiYtNzVxVF/r7zXP/d2ysCqPXr31heNZJq8R9qbfukqKgIW0RJjEZ+l+WEitAGwwYAYFnW46nR63WhEI8QWl2JWvwHP9xdBwCqqvb1dV+70pVKKflVk8nsravf9d4HFEXVeusRQp3fnVtFBm5Ptb/1MABkMk/aPzvW031jbi5T6JDJZAYG7ocfjTiqXAzDlG1/a3JiXJIETbuIpulmXxuO/fMT7Q+Hg4tRUFTTfl/Tfh9FUdgSCvFfnGhXVRUAfC0HaZrWBHA63birfX3dwyE+b7fby+sb9tU37LPby/PGYHDo1s1eADBzXJXzHW0Alxsr1692Fdp1ev0yBcvVKz9hxVHl0tTk0s02ABBFIZlUcGXsOyp0Ot22bWXYASsLCwv80KCqqooiJyTRYi3ZYtuqCWB83QgAqeTinmnc29S49+NCh921e7By6eKFC+c7AUBJKhZrCT6GmkcFQaxi1BAkAORefBT+kcHM4xlObyk2mZfC/CESCeMS4divX+uKRMK4RNin2GQCgD9mpjUBYqMRzmwpsZaYzZyiyKqqDg7cL3SIRMJ3bv+afzRznMViBYBobFRTie4F+rFS6/2o0L4wP79MweLd07j04l1NJ1mWpeqanSzLlpbawo9GUqkktqdSSZKkRkYe3rrZm588b9vLW1sPEwQhK4mzHWdyudzKgFwuNz2d9nhqSJJ0VLli0VG8XxFCwyF+uGCu2XdUHD16nGEYADj5zZeiENc6i0RR0Ot1ZWVvMgxTXbPTaNwoiUIm86Sw7gd8bX7/Ifx1hFAoyI+PxVZxH5AkeaDZ761ryFsSCUmREwBg5iy4q1gQQgRBIIROn/oajw1N9wFCKMgPTU6M27ZsZVkWAAwGA2excharwWBY7JaSOHXyKz74m8PhJAii0uGcnZ2NRiOaAFgkSejt+Tken1D/Uql19GvrmGw2q6SS/NDgpYvnz3acEYT4+FhsKj2FGRUVlc9lEP/+v+jdXe8fOfIprlXHt6d7frmhKQPt8vI81gCAGel0unKJEY9PiqKwloBljPm5pw8eBNYYgBnxyYk/nz27fPnH/E1O/P/zu5L8DSiQtm0a0DUBAAAAAElFTkSuQmCC"
    m["dark_side_broom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACeklEQVR42t2WzUsbQRjGn8xmyUe7Gwwb0Zltk4C5Jqw0tQpVwa/iNWr/k3qQQqkIwWPx0tJ/wJggXkoberHtRQMVe2h78FLdmYOHGITUTQ/SQ9ZVrIluWC+d087LM/z2fd6Zd8YXjz/GbQ6CWx6dA5LJRDKZuC1AXyqVX87nl/OJRLy90t8ZYHr6ic/nA+D3y95noKrqwKMBACY39/b2vAeMjY/Jsgzg/bsP3teAEDI+MQbAsqzPn754D+jvN2KxGIDNzc2Tk9/eAyamJpsf5fJH78+BFotlMmkAP77/PPi17z1gamqSEAKgXC57f5Jl2T86OgLg+Ph4e2vrhqt8bZpdd3d3bi4XDARtfzQtleoDYHJ+sH/QDFoNq1QoHR4ednKS557ODo8M/xvXGdMZc6YSkVZerXRiUfy6PmPL4vc76UWEkJ6eHgC7u9+WFpcAZB9ms9kHxbVzQxaeL2QyaUopIeT09NQdQNO0QCAAgJu8GalsVyrblYsabvJMJi3LsqZprcrQ0iKm2y4LIdRIxDAMSZJs0yXJMAw1EhFCXBK7yICdldE0+cvFF5TS4lqpsFoAkJvJzczmhBBvXr91xDtfd9xlQBm1M+CcUgqA6b1n/9sLgFIqOL8kdmMRZQDq9XqtVmulqdVq9XrdEbsD6PcYAM5F+z0qTO6IXQAU5a6iKE1/2gO4EAAURVFVxQWA6bq9/lrAeRmYC4DTCczrAI6Atajz1du0l9rq+flnTnBwcGiwOHRRViiunu866iaDcCjo9qYLhUMuMlhf34CPhO+Em9NotCvaFTVN02o0AAQDAV3Xq0fVavWoKfhjNTbWN1zfB//74/eG4y+W5b3+l3sPYQAAAABJRU5ErkJggg=="
    m["dark_sel_broom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACiUlEQVR42uWWz2vTYBjHv0nTX2vWJm1N0tKO6dBaumotReYGRXeYIsz9AR4HehmIF8Gb+AfMs9Cb4EUQdFB0yNxh2INuHZYyHOLGnDbpdE1X17XdoB7ahjLXtSnZyef05nm/eT883+d5SYiRi49wkkHihKN7gKfP4elztJVR3Z3ed4a793ACwPTjlz++/9YeEB0dJAgCgI7SaW8R3Wu6EDkNQMrkNtay2gOGon6K0gFYmEtr32SSJIai5wGUy/uLia/aA/xBr93RC+BjYrVUqmgPGL4aqC0S8yva3wPWQfsCHgDfVsXM5rb2gJFrAZIkAHyYT2t/kyk9eXn4HIA/hdLn5Fqnbx2zZ3f2jt0KGw362iNjp2mrGcDu7t7tydFaslzZn329tP2r0A3gxkQkcuXsv3leYHmBbRpc8nnsfTcWub32Tkxwe+zdWESShJOzAfiS3nz6JA4geKl/MNT/dmZRMeTu/Zu+gIfjGYIgqtWqOgBjpw0GCoCUkWuZVHI9lVxv1kgZ2RfwUHod66BbtaGlRbyr7vKWJNNWsz/oJUlSMd0f9NJW85YkHxKrqIBzMbWF+FOeejDOCczszNKbV58AjI2Hx8bDWVF+8WxBEa+kNtRVoACyoswJDADOZWts2QBwApMV5UNiNRbxDIC9YqWQL7bSFPLFvWJZEasEuJnmDreKbEZWxCoAFovRQpsAbIntAGIegIU21fSdAjg32xjE3PEARdCqDUcDBKGultpVoAj4FoCjx9TZAExOXVeSochAKDbQLJuO3VHWp3g1FZjNerVfOlOPQUUF7+LLAGFuvGNje6w2i5TJVcoHAAxGinexO/ndfK4+wZXywVx8+cijiP/457fD+AuBUbxvdgG1iAAAAABJRU5ErkJggg=="
    m["dark_side_chat"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABeklEQVR42mOUl7dloCVgYqAxGLWAIGBB5piamdrYWlFm67/Dh46eOX0GzmdETkWLlizk4OCg0Mnfv3+Pj03AHkSUm45pCAumiuPHj/X3TiTD6MLiQktLi+GditCAmJhYcFgwBzu+iPnx88faVWtfvXpFjgWBQYGODg4E3fj/778Z02eSE0Tnzp37+fMnftN//vx57ux5MoPo9KnTsdFxAxAHBMOdCnGAP9wpjQOC4U7XOBiIjGZhYZmR+QMSxHLycjm52QoKCtTxwY8fPxgYGBgZGR2dHBkYGPT0dZtbmkg1HWIIdh9MnjQlMSlBRESEkZHRwdEhPSONmZmZgYHhxo2b79+/J7LCOXL4GDKfEa3ZUlicb2lpxcDA8P//f0ZGRgYGhs2bNi9dsuzfv39UzmiMjIz//v2bP2/Bzh07aZKTf/78OWHCxLOnz1I5FT198pyBgeHjh4+dHV137tyhPJmixwEzM7Oent69e/c/fvxAlXzAONo2HXALAKnHl8+oJMlsAAAAAElFTkSuQmCC"
    m["dark_sel_chat"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABhUlEQVR42mO01m9goCVgYqAxGLWAIGBB5ugaKhiaKzMyMJJt3H+G/+dO3Lly4SF2C6JSHNnZWSl0sqaOXGXOfOxBRLnpDAwMbKiGsGCquHDm7qIZe8kwOj7DRd9EaXinIjQgJMLr5mfEzoYvYn7++r1r07l3bz6TY4GLl6GZlTrhpPn3/8qFh8gJouuXH/36+Qe/6b9+/rl26RGZQXT5/IOK7HkDEAcEw50KcYA/3CmNA4LhTtc4GIiMpm+sHB7/GxLEkrJCUUmO0rLC1PHBz5+/GRgYGBkZzGzUGRgY1LSkc8v8SDX918/fOH2wbM7+gEgrQSEeRkZGM2u10Dg7ZmYmBgaGe3defP7wjcgK5/zJuzgtuHz+gaG5sqAQDwMDQ3iCAyMjAwMDw4FdF7esOfXv338qZzRGRoZ///6vX37s6P6rNMnJv379WTxr71Wk2pU6Frx6/pGBgeHzp+9zJ+98dP8V9ZPprs3nHt57+eThm8+fvtMkH/z79+/65cejLTt6WgAAkoqglfSeCMgAAAAASUVORK5CYII="
    m["dark_side_chest"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACeElEQVR42mOUl7dloCVgYqAxGLWAIGAhqEJQSFBDQ0NGRlpYWJiTi4uBgeH7t29v3757/PjxzRs3379/T6YFHBzs9g4Ojk4OSkpKePTfvXN3//4DBw8c/PnzJ1YFjFiTqY2tTVx8rICAAJHh8OHdhwULFhw7dpywBUxMTKmpyc6uLhDu79+/z509d/Hipbt37rx+/ebLly8MDAy8vDwioqLKysoGhvqGhoasrKwQxTt37pw/d8G/f//wWZCQmODl7cnAwPD3799tW7dt3LDp06dPeNzOx88fGOjv4enBzMzMwMCwZfOWRQsXIytgFhCQh3O0tLVTUpMZGRm/fPnS2ty6b99+XCELBz9//rx44eK1a1fNzMzY2NhU1VSvXL785s1b7MnU28eLkZGRgYFhQv+EmzdvEZ8Wr1+7MWniZAYGBkZGRm9fH5ypSEtLk4GB4e7de5cuXkaPK0ZGVVUVYRERBgaGVy9f3r17D03B+XPn799/oKioADEEuwXc3NwMDAyvXr3CNL2gqMDS0gIusnvX7tmz5qApe/HihaKiAi8vL4F8ICwsaGlliSwiISGBbDoDA4Ozi/ODhw+/fP6CppGojKampq5WpE6ghGFiSk1NGaxl0a1bN7du2Y7qJ1VvH28GBoatW7YyMDDA2bdu3UZNhJ5qauqELXj79u1x1Ez/9s0biKEQEgIuXLh48cJFZGUWlmZkBtGtW7cfPnyELPL69eubN29Sp7iGgLaWNg8vDwkJCQYGhtevXm3ftv3H9x/UtOD9+/fLly4frTIhwNLSynKNFU18QLBwJgagGYLigymTp1pZW1AWbv+OHT1BuE4ebXgNKwsAloLlTgOCSFgAAAAASUVORK5CYII="
    m["dark_sel_chest"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACd0lEQVR42mO01m9goCVgYqAxGLWAIGAhqIJPgEtRRUJCSlBAkJuDk42BgeHH918f3n99/vT9gzsvPn38RqYFbOwsplbq5jbqMvIiePQ/evD69NGbp4/e+vXrD1YFjFiTqZG5in+YBS8/F5Hh8OnDt40rj50/fY+wBYyMjKGxNhZ2mhDun99/r116dOPqkycPXr17++Xb158MDAzc3OwCIryy8qKaurKaurIsLMwQxUcOXN2w7Ni/f//xWRAQYWXnosPAwPD377/Dey/v237xy+cfeNzOw8fp7Glg66zNxMTEwMBwcNeljatOICtglpNwgHOU1aVCYmwYGRm+ff05q2/bySM3cYUsHPz6+efm1Sd3bj7TNVRkZWWWVxK/ff3Jh3dfsSdTe1cdRkYGBgaGRTP33L/7kvi0eO/WiyWz9zEwMDAyMti76eFMRcpqUgwMDI8fvL517Sl6XDEyyCuK8QvxMDAwvHv9+fHD12gKrl9+9PTRG2k5EWU1SZwWcHKxMTAwvHvzGdP0uHQXfRMluMixA9fWLDmCpuzNq0/SciLcPBwE8gG/IBeyWQwMDKLi/GgiFnaaz568+/rlB5pGojKagrKEgrIEgRKGiTEkxmawlkUP7r44uPsKqp/E7V11GRgYDu6+zMDAAGc/QE1p9q46mF7HYsGH918vnkHJ9B/ffYEYCiEh4ObVxzeuPEFWpm+iSGYQPbj36tmTd8gi799+uXfnJXWKawiY1b/N1llHRIwPko4P7b3y68dvalrw6eO3retOjVaZEGBgomwwR5kmPiBYOBMD0AxB8cGyufsNTJUYGRjJNv0/w/8LqBUn42jTcfhbAADh4ekgX08XFQAAAABJRU5ErkJggg=="
    m["dark_side_clock"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEU0lEQVR42tVWX2xSdxQ+9HIfYAgXkCDGcqvNsA+zUgsqjYU2oWa+tM3oOqJ7MIv6oHNZMjrj09Zki67qYqxLZrZlZmvTdmkbrS/bpTYbraWjWpEubtplQFkLpeVCgf5hXGAPFwhFYMXNh523e3/nnu/cc77vnB8Dx2vhRVoJvGBjbtKPy92C8flCoRASsET6AiQZCoX/A4BtErFGo1YolTiOZx05HI5Jy+Soaczj8RSIwMjXAx4Pa2l9TavVIghS4PtYLGYkhvv7B4LLy0UA7N4tM7QZeBiPflxdXbU+tLpcLt8SCQACoUAqLZVXydlsNu0QCAQud1x++nRmUwA1NaozZ8+gKAoAXq+3t6fPPD4Ri1HZxWUyVaqD+qN6kUgEANFo9HrnZ+Zxc5YbgmF4Vu5t59ro6MQPxMULnzgcjkQi/mxq8Xh8dnbWSBBcHq+8fBeCIApF9S/T0z4fmReAy+O1t3/IfokNAN9+09Xb0xuPxzO70nHp4pEjr5rHJyKR9TTM1IOpSOSvyr2VCILsq97304+mSCSSWwevt+rouo/cHbkzdCcr5YoKmWS7RLJdUlEhyzoauj1kJIwAgGGYrkWXW2jbJGKtVgsACwsLX37xVQ5NpuhUkotXN7++ubi4CAANh7VisTgHgEajphnZ1/sdRVHFKjYapfp6+ujmqzXqHAAK5X6akRPmieebCvfumVdWVgBAoVRkA3C5W3BcCgDWh9bnSD8lOspmewQAZWU4h8PZACAQCFIDwPlvRtus0wUADAZDIBRsAODzk88Bf+Afo9TX12W2MdNI0p/MmL8RIJFIJJVdwsgX1z0/T7vJq+SfXr1y7M1jLBY7ezCkvk5AYgOA3+9P/Qo/H4DD4Wz/oN1udwAAiqJNzY3XOq8eOLA/0yddajIVMA2Q1LdUWlqgOI8f/3r+3Pkbn99YDiwDAA/jnX77dKZDqXQHXQ9/amAkAYLBkNPppH+fySy0JOLx+N3hkXfOvnv71tD6+nrmdENRplxeBQB2uz0cDmcvHMvPFhzH2Wy2SnVwdHSscJ/X1la7u7q7u7ozX6pqalgsFgDctzzIIbRR01gsFgMA/VE9ijKLJSiKom/oWwGAoiiTyZQDwOPxGIlhABCJRCdPnSwW4Phbx+nFQHxPeL3e3NO0v38gEAgAQF19XWNT4+ajNzU3NjRoaTYODg7m3QeRSOTJb09q1bUIglTurcT4/GmbLXMl5KzMiVMnmpub6KX28UcX3G53oY3m85Fut1uhqEYQpLx8l1qjDodCc3Pzz8IwmcxDtYcMbe/t2fMKHb3z2nXbI9umlr5M9rLhfQOGYSnOrE1NWef+dC0t+gBgq0hYKt0hl1fRnKErc6njyu8zM0VcW7hcrq5F13BYW1gWFEUZCWKgfzAYDBV3L6JNLBarNWqFUrFzZ1nWkf0P+6TlvslkyuRM0QBp43A4fKFgq0AIAEukz+8j01otbIz//e36b53buKI9HD0+AAAAAElFTkSuQmCC"
    m["dark_sel_clock"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEUElEQVR42s1WW0xbdRj/OD2wXk9vFJqWcu8orFsLLSFlInMLZBhcdGRxMZq4xSeJTyYafTAmGn3wQRMzExOiiXEP0xAWxYE1kTEVaCiwDixYtgZoy81eTlvO6YXTUx9OgdKV2s4t8Xs6ly/f75/v+36/37/otO59eJKBwBMONM88Hp+NibkiER8giQeIUIAgiNhjACgtw4wmtba5WlEhzfjlcfkW5lZmppa926EcFYqOmoEA43RdaDF1NLJYudqYSNCT44vm4dmdUKQAgJq68lf7uwUYh3mNRuJL867N9QDuJwAAE3MVSonmpIrNKWESwkHy62vmFed2XgB6Y91Lr51BURYA+L3hW0PTNqszkaAzm4siOkNtz8VWiVQAABSVuD4wZrM6M9JYlfIzGWe/+kY3U31izD7w+ajH5Usmkw8fjaaTGx7/xLidL+CoqmUIgmj1Vct2Dx4gjgTgY5z+t57jcEoA4IfvLbeGpmk6mT6VN9/r6zintVmd8Ri1D2O/txaPUw1NFQiCNJ2qtE464nEqOw+6L7Qwfbf8tnT7Z1vmYOrlsnKhrFxYUy/P+DU2apu4bQcAgZDb1WvITrTSMszU0QgAvr9Dg9d/zzIupCjjIT1u3pjw+8IA0N7ZKJVhWQCMJjWzkSM3rRRFF8pYapceHbICAAtFjCZ1FgBtcw2zkfdmnI+mCnPTDyJkHAC0+qpMAB6fraiQAMDSvOsRjr9Pur/sLgBQqEq5vGOHAERiXkoA3L7/Im2b7gAAFBWBUMI7BICJuClO4pF/rdL2VEP6GNMDx1MkEAoPAxww6Wjh8W4FGcZptKq3P7jU29fGZpdkbtrBfiUP1QvtIWNC7lEAHpfvi0+GPWteAEBR1tke3TsfvXiqpSY9RyhKHTyIk4cA9t8VSkmO5jxwbHz64dB339wJhyIMty9f6UxPkCvFTD+Ce4KRAiB2outuHwBoTqpQNJc+03Ry6s7Sx+/e+HXEFovtpqsbWoxoTqgAwLPmJffs6MBw5mdXFBVSNqdEZ6idsdzPPedoND48aBketKR/1BnrGAFfuLuahWgzU8uMJvdcbEWLC/ZqtJj17POtAJCgaOukIwuAdzs0Ob4IABKp4NLLTxcK8MLldrGUDwB/jP3p94azq6l5eDYcJAGg9fTxZ87r8q9+9rzO1NkIAKEg+ctPc0f6QTxGrdzfNJjUCII0NFVgQq5j0Z1uCVk70/dKx7kePQBQu4kvPxvxbgVzORoeILY3g1p9FYIgqmqZ0XSc3Ilub+IPw6Ao0txWf/X1brVGwVT/dmDMYXfnZfrVtWVX+rsFe6SLRuKLC+6tdT/uIwBAJOXJlWLNiQPTDwXJr66Z1/I0/ZR9CthdvYb2zkZWTlokKHpi3G7+cZbYiRZ2L2JCKsOMJrVWX6WsLM1UjlXv/N1V66QjfWcKBtgPLu+YUMxjVB0PEMEAQT6Wq+N+kESMJGIbbv//7nb9D2mUwgFcqBcmAAAAAElFTkSuQmCC"
    m["dark_side_film"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACRUlEQVR42u1WTU8TURQ943TSr8WUTieSWNqOhHYj0oSYdExEXGNKNEQXaqIuZGk/+BtYTYymPwEYXMkP6EIHWSF1AVO0tph20Y7IYtpJsI6LmY4dFg20gDFyV+e9xT3349z7HhEMXsNJ2jmcsP37BLbOQzQavT1zi+M4u93eg69msylJheUlYXNzy7wkPZ6gjiZvTCbTCZZlbTZbb8FSFDU4eH7i+kSpVKpUKpYMHA77o8cPCYJotVobG3lVVXk+BkCWZUkqdHEaDo8wDANAFFfdbvfo6CWSJGdnn3xcX9/f//mHIBQKOZ1OAMKSsCy8AcALCwAkaSsz/6ILQTL9lOevAsjMZwDcf3AvPh2nPTTHcXpkRpMHvF4dVCrVflq6vf1ZBz6f73RV5HK5jJRTiWQq0YOjRWGh8+hyuS0ZsKzveAP3sawlg3L5mw4kqSDLMgBdRYc3UVwFwHgHwpEIgJ3yjoVA037pYOXtivheNFV0eNNVFONjqUgEgKa1zpbd/7auCcJgmro5FTuiQNtLKanLtO2QtBAEAn5zOwIjPRAcmJuhwBDedZSoVqsfb2XqtZolg0ajYczLs+f6oC0ecdDuzNw1Bi2dBNBoKKerIrlulGh4+GI/7vz+Czr4vrtrKVGx+HXvxx7toePT8RDHKYrS7nlEl0eXJ9NUkcPhGBu7DEBRlOKXoiEn82c3fmV8bi5NkmSfNdE07dXL17lc7uCvolqpfsrnGS9De2iKonpwrapqQSpks9m1D2vmJXH2N/3rBL8Bbsa4jDBXMLsAAAAASUVORK5CYII="
    m["dark_sel_film"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACO0lEQVR42mO01m9goCVgYqAxGPoWsCBzNHRkXb0NpeVE2NhZyDDr54/fD+6+3LX57P07L+GCzHISDhCWmbVaXIaroDAPMwuZ3mJhYRYR4zO1Unv2+O2rFx9RfMDGzhIQYcXIyPDv37+bV5/++vlb30SJgYHhw/svD+++wmOovLKYgCAPAwPDxTP3OLjY1TSlmZiYQuPsblxd+uf3P4QF0rLCHJxsDAwMuzad27XlHAMDQ9+cNAYGhgd3Xy6asRePBXEZzgYmPAwMDAtn7GFgYPANMXf00Ofl45SRFXlw7xUikvkEuCGMly8+UBKlD++/hjAEhHjpm4o4udghjPgMF/IMggQpHHBysqH4QEiYh7oOFxThRfHB86fvIYwHd199fP+FgYEBkoqIBxfP3GNgYOAX4FJQkWBgYHjx9B2KBf/+/YMwDu6+BFGK5mWCAJKK9IyVElQkGBgY/v37P1rYjbTimokJapO9q54BiQkUOYfyC3DBDGREsUBSWhDCUFAWY2AQI8MCtHwjIS2EEkTv3n6hbsi8f/MZxQffv/2E5xfyMlpRyixoRst0YWBg+P79F31T0cd30CCSUxClxDgJKQGogR+/ogTRk8dvP3/6zsvH6eihLyUn8gMWYgrK4vgLcHllMXgqYmNnVdeWYWBg+P7t19OHbyDijPCWnbaBfGKWKzy9kg3+/2dYPv/AmWO30FsVr198vH3tKb8gDy8fJwsLMznNlp+/H957tWrRocvnHsAFGUfbpgNuAQBpybQ86vuzoQAAAABJRU5ErkJggg=="
    m["dark_side_gamepad"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADlUlEQVR42u1VX0wbdRz/dncSetAOWl+4a6/J3QBb/tn17/DPZlxmdJrMzMwphgWyDebbNGYOHAN1UbeHsb1O5gutWzJ41e6BkBUKMjtDe4eBCYl3bRdriyn9wxUo58PvhAkj0Sx7MPJ9u+/3e5/P9/9PZTK9AE9SdsATlm2CbYL/AAG+4Zs20U6Hk6QqMBz/V0ArKyuxaPTuxI+CIDysV61tskZTerK9zeVyPk68siwHAuNfX7uWzWSRBisrMyH0ns97LGbzYxZEpVLRtNFms42Oji4vLa+X6GR7m4EyAIAoRjz9Hi7MFavVLMOEQqFCobAVHEVRLMsEg8FsNldUVFTXUNf0XpOBooxGw/ETJ65c7lUyoE10a2sLAIiC+ElnlygIhULhq0tfvnbwVQDgef6R6Pv3v9x5rsPpch545cDISCCdTj+IPfDf8dudDq1WazQaJn6YSKVSOwDA6VDq7vF4Fxdz2p073XvcJEkCQH1DvXW3FcOwzQSNzzXmstlCYZUgCOuzDUiZy+W8/V5UK7vDroxpBVWBzDzHA8Cnn3V/8OFppKmqqjzb8fHhtw5vJhDFiJog8nkJAOxOR/upNpqmAYDjOORAkhVKD3Bc2YZ8Pv/P+/mt98bCQmoXW/mMpbrGYgYA627rqbb3pUUJOTxVhD9iDwCg61y3xWJGSczM3B8aGrKYLaf/ymlNlqT8wMDgbd/tvm/65v+YBwBdua6khEinMxsXbXlZmZNidbG0KC2kUuNj47FYjCRJnudff+MgGrDNwuxiO892hCdDdQ31ADD502Q6nSEIQolgaUUhiIgRpHK73MPDw2t5sAzT+HzjVugAYDQaWo63XrjwRW1dLQBwYQ4A3HtcyCr8KigEgdHA20ePYBh2rKU5Hv9taupnAMhmMpVVlXv3vggAiUTizEdnHs5doym9eOmi/mn9S/v2JeK/D9waXF1dBYCa2prmY83ocowFxtZPxbtN7xx68xD6eXZ2bj6ZZFhGr9cj1+6u7pmZ+xvCr66uOt9zHsdxAEgmknNzczq9nmUZZB24NXjzxs31U8HzU+VlZQzLAIBOV05RFCqlJEm9l6+Ew9zm+iSTSVGI2Ow2HMcJgqAoSqcrRyafz+fp98qyvE4gy3IweG96erqkpFSr1eA4Ho/H/XdGrvZenf1ldqseRKNRv38ExzGtVqtWqzOZDBfirvdd//47H0L/2zXdftG2Cf6/BH8C5N5d321lkvsAAAAASUVORK5CYII="
    m["dark_sel_gamepad"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADk0lEQVR42u1VXUxbdRT/9ba0vWtnb8na3gtc+gWFAYVaEd2IDYno3BQxbPMjmtQXjZolRs2ML8avGJM9+BH1Yfq46RNzyza2ZUpczFCpo3ObZaW0wD76IWDbjV7ae1tufbhXWVhJNMsejPzf7jn/e37nd87vnL+iu+Nt3M5D4DafNYA1gP8AgGrFN8NWuz12s8WgVP077NKSOJfMXjg7k4ynKwPodJqdfl+7134r+W7p7/z1zNTg/h/ynCBZlPV0jxR91xuPOl3MLRZEoQBTa2ztsAYD0VJxaZnBTr/PwhgBpBKZo4OjkxfjGlLNWjdMhOKiKK4WzsJQrNUUOn8pvyhUVSldrXWP7LjHQlN0jXHHM759e7+TGTBs9cBT3QCS8fSnHxxOxtOiWH71zQFfrxtAdCJRMfqm+5qff2Wb22vv7mkJBqJcjp9LXQv+NNnmten1WrrGeCE4nVvIEwDcHrnuQwcChYKgv4Nsv8thpikArpa6je56gqjQcE+Xs7AoiGJZS6qb21jJmM8LQ4OjUq1aPVZZpibaILmj4QSAXa/3Pftir2SxOc3PvfzQg33emwFSiayGVAt8EUCbx/aE38fUVgOIhGXGUooqAEqlQjIJQumf9/PYwQC3kGdtZkeTpaGJBrCxvf7d3V8JhaIs0CqiwhwA+GzPEUcjI5GYic2OjoSdjYz/hd4V1wS+9O1QcOT70Huf+K9lOQAGSkeSao7jV85BqSTrRK2tEgrF3PX8+bGp2VTWTFOxiUTPA25JYDcf1m76+P2DkfGrrpY6AOHfrnIcT5JqefSEv2T6eyIj983rCPw48TcP1rrhzrsbVosOgK4xDjzdvfej466WWgCR8TiA9k5ZMol4RgY4G4htfayTIIj+J+/9Y/56LJIEsJjjrQ5L5+ZGAJl07sN3DtzIXafTvPbWdqpa37W5KTOfO3kkWC6XATQ01/Q/vgnAUkk890sMgEJ69B/e3nX/Vo/085WZuWyGY20myqiTrn6+5/DM1OyK9O1Oy0u7+6SVlU3nrlyap4w61maSvCePBk8cOrO8KqLhhIFaV2c1Sb2yMJSWVAPg+eK+L4YjFyvMWjbDpeLp1g6rUkVoSbWFoQyUTnKdPhUaGgyUyzfsIgChc5enoylynVa/XqtUKdPzC2M/R/d/OXx5em61HsymsmOjkyoVoV9ParTqRY6fHI9/8/XI6eGQFH25RGsv2hrA/xrgT804Vr0tYt7WAAAAAElFTkSuQmCC"
    m["dark_side_keyboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACoklEQVR42u1W309ScRQ/l8sFFm33moTeu7j3e6Xli9IGodDWlq+1NnvJPyFovbRW86VGtRD1ISLN+ZjV+qX4kM9ZLWcTnEWy5QvXxlCGPGQKKOhdD9cBJhBCrhfO27nncz+f7znfc77fL8ZxZ+AgTQYHbDWB/y8g/8OvO1KHEFKpVBVwpTPpSDgSjUYLC2g0GtsVm8HQWuWSp6c/Dw8NJ5NJycUpigMAtfqQq6+H51H1NdHpjplMxsl3k6Io5jK41NVVX18PAMH54If3HzfTmxVQKwjF+QvnEEI6lu282Pnm9WhOoKW1BQBWVlac952ZzFbFy/fP+t3uByRFmtvMksBOFzEMDQChkFANOwAk1hPfFxYAgGXZXW0qk8kAQKoaSVIPPW7PgIeiKAAwt5lHnj2xX7VLSJv98tPnI+2W9r1IyURxK0tYeA44xNIM3djYwPM8ABiNRpVKZbVYpKj1tFWpVJpMxr3IsuZA2mfvmBfDsEAgAADj3nEcl836Z6XowKNBs/nU2Kh3L7Jcge3t7ZcvXmXdWCz2eHAo6/pmfL4ZX0HkPo4Knkd8E1/+3pbAFxBAiHP1uVy9PU36pnLYS+PlpX8mSeruPQfN0AWjy0vLt2859nfYAcDi4o/um92AYUJIMJw0FGMHAJqhOcQGvgay+KICoijiOI7jOxUThMX8jqIZpkgGS8H5YD4eAGQYnh2pnEA4HEYINZ9oVh9WJ9YTxTrqr0YQhP64HgAikaVdAr4ZP0KIpEjHHcfE24l0Ol3BOaFUKjs6zmo0GgCY/7YzGZj0bCEIudPVw3HsP7nF4vH49Ws3Uqlk7j4QRXHq09RRbQPL6qpkn5v70t/bv7b2a1cGWdNqtSyrIxSKCqg3UhuhkLC6+jP/I1Z72dUEqrbfpQL3MG2T5ocAAAAASUVORK5CYII="
    m["dark_sel_keyboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACsElEQVR42u1WXUhTYRh+ztkf0/24czY3d3amM0JMp5l5JaQQQd0YeJF2VXlbN15EGAiB2M+VBHrThdGV0EWClKIYWFAgWcNsTJnIptvy57iVU5bHdU4XR9TpNnVDuvG9e/kenud7v/f9nu8jaisf4SSDxAnHqcD/F5Dvy3V5OQxrVKrkGXDF43+XQhFueS25gIHS3LhdV3KOyXLLkxNzr199jMV4KZXZLfUA1DnK1vZGm53O/kwsVkNZhX3807QgiLsVXL1ek2fIBTA7HZr47N3ktzKgVijldVecDEtbbNTla1XDA193Bc6WWgFEVtdfPB+MbwkZb9896WvraNLo1OVVRZLA9hTlW/QAFvwr2bADiG3wc7OLAAoYKmFMCYIEIAoiAK1O3dbZ9PBxs1afA8BZVfSk505zS52EbLp16WlPS0W14yBSCkEQAJAkkfIeWFnaZNYb83VSz0uddpVKUVldLK1WXixWquRlFYUHkUe6BwC8ntDoOxeAGXcQwOigSyYj3ZN+abWvd6z8fNHI228HkUcVEARhsP/LThrmon0vx3bSKZdvyuVLijyGVdjsNFNoPHpv0+CTVMCwdGt7I4Cuzv6AjzuUPT3+EM/R6tT3HjSYzPqkqytLv7ufDRzP7AAEF1a7Ot6IBBH0cyVltlTsAExmvZWlZ9yBHXxKAVEUCIIkZdstCcyv7p2oNBV4PaG9eAAkQQKQjGhX4GcwwrC044xZnauMbfCpJupw91fIWIcJwPLirwSBHy4fw9Ianfru/YYPI995Pp6BT6hU8praEgOlAeD1BBME3g+5nBccVhtltVE3W+qzdOxIeH2ofyLhPRAE0TU+S5l0BYwhS3bP1EJv9/DG+p9tl9v38aKM2gLGIFdk8mTym1sBPxddi6Ub0zAXDXPR02/LqcBx4h9QdQJRzAfK2QAAAABJRU5ErkJggg=="
    m["dark_side_palette"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAE8ElEQVR42s1WbUxTZxQ+986mVPotNXLp0naaNgoJhdFqkQpsUN10iwuIc6Am7s8WFZmbiRKX/TJbULfs76YsCk5gMyJYpEV0Y5CMgpMGLSoCvVUo9hr6QYWyftz9eLtaoAVcNNn5de69577P+57nPOc9mESihVdpOLxiW7bEOIFQkLwqmcvjYhjm8XgcTxwURb0EgBRxik5XkKVSiUSiOZ/cLrfZbO74vaO//w5N0/FWwOJxIBAK9u7do8nWYBi28CZGRqznfjpnsVheACDzzcyD5QcSExPRo9Pp7DObSSvpmnDSAHw+TywWp6alEgSBAmiabtG31NZcCAaDiwPk5uZ+uv8THMcB4JHtUX1dg90+niRaMfTwocczGR25evUb2z/Yvn7DevR4q/ev06dOBwKB6JjX+HzJnL1XfHYIx3GappuuNH/37ff5b+UeKN+v3aQt1BUODg5SDgoApFJJ0Y4iqUyqv6rv7b2lVKYzmUyCSBatXGnqNsUFEAqFX351nMlk0jR99kx14+VGgkguryhHNDAYDJlM1mZsk8mkJ74+IZfL16xZk5efd7VZ32a8vkGznsViSSQSinpqtVpj62DP3t0o701Xmo0GIwAkiZKiA0SiJADIy89lMBjoDYPByM/Ps9vtVd9UoeSU7S5NSGDFAEgRp2iyNSjvdRfrwxUyPDw1NRWJ6e+/E6+WhoaGm5uaAYDL5RYUvh0DQKcrQKmor2sIBsNEeTyTJ6tOkaRtenraZDL9+MMZALjR/pvf70cBfr//xs2byG9qap6ZmQEArTYnhtCyVCpUkb29vQBQXFy85d3NdIg2GAxHPj8SvVmSJI8drSwoKKBpur293Uba0Ptn3mdms1mtVktlUjab7fV6nwMIhAKk1T6zORQKabU5JR/uQJ9KdpbY7eNdnV3RGDbSVn22en6iHtwfVKvVGIaJXxffG7j3PEXJyWHJkFYSANalpkb/lpaWtsSWNTExgRwuhzuLAw47LFqX0wUAT5/OamQOh2OpvXNZOCURSc9t14jnFn3ryIj130IaudbSukQAuUKOnPHx8VkkT056kcPj8gBgenqq8milQiEHgPv3H8zvMDFNKBTm5GwEAIqixsbGZgHYx+3IkcmkkTNaLANLv1iWL19++IvDCQkJAKDXt0QaeBjAOeGkKEokEqVnpOM4HgqFlr60QCDIyFQWFRehOhx6OGS4ZoyhA1O3aeu2rXw+X6VWdf/ZvcCKW97ZXFpWymQy538afTxaVXUyotNZJF9va0fn2rmrJFIM802pVO77eN/81YPBoNFgrDx23DnhjH1ljo6OdnZ2abU54hTxro921ZyviQmgUmch5/btPp/PBwBTXq/Vauvp6YmIIO6dXHu+VqlM53A4772/jaIcrdcM83948iSsiQHLQOPlxkUZmnUf+Hw+G2nL3piN43hGZgaLxbp71zKH8Mejj3W6QgaDIVghNLQaXgwACYRyOLJUWRiGyRVyTbbG4/aMjdkjZef/269QKAiCSExMvPTrpf8ytnR0/OHxTB48dIDD4RAEUXG4Ak0oVivpdDrZbPbadWuj287CFnds4fP5ZbtLtZu08caWny9cfGEOos3n85lMPV2dXYFAgMfjsdns6IpsbWltaPhlgXlr8RPMMR6PT6Ss4nK4/kBgeGjY5XK95NnU7Xa53S6A/990/Q8BjxUj/aa2PgAAAABJRU5ErkJggg=="
    m["dark_sel_palette"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAE5ElEQVR42s1WWUxjZRQ+F0qX25YWCm2BUgo07HuhrMoWcEYZQUMmZsYtcTTOkw8++jIPzpvJRKMxPjiJ0UyMM0EicQYQrMMOMixTyipSKKXQ5dK9pbS9PtzaaeEWOmYm8Tyd3vvf851+55zvP0h96Q14nhYDz9koUZ6L56LJfA6TzUAQcNjdmMGGmWzPAECQwq1rKigqkyTwWCde2a2uVdXu7OT6xooWxyNGQCLVIJ6Ldl2uLa3KRpBzctTuGHt/nNxc1z0FQEGJ+Oq1ZgZKI35aLc5VlWZPg9nMDj8O8RyGICVBmpfKF3KJAzgOI0PKvrvTfr//fIoq63LeeLcxJgYBAJ0W6++dNeqt3ETWzpbeYXeHnkzPSG59uaxElokg0NhWnMTnfPf1oNcbhhErFjadyP2tD1pjYhAcB0X/4vffDMsbcq681yKrkdY15m9v6TGjDQDS0nltr1akZfBGflOqFnfyikRUKoUv5CQksZVz6ogAHC56/eNXqFQKjkPPnbHh+wt8IefN91uJMlDiYtPESRN/LIvEvI8+6ZJkCcQSvrwh9+Hg48mHK6WVWTR6XKqId2iyaTUm8jnovFxL8K7oXxxXLAPAieZJ5LEAoKo+l0KJDVBMiZXX5xoOLN9+MeDz+gGgo7uGRo8jARCkcEursgneH/T+STzUqI1ulyd4Zn1FG6mXNNsGxcAiALDY9JoX80kA6poKCCr6e2d9vkChHHb37a8G93Yxt8ujnFff+2EMAKZHV71eH3HAe+ybnlgjfMXgosfjBYDKailJFxWWZRAdubSwDQDtl2QNLYWA42MK1Wc37oUmu7eL3br5c+0L+TgOU2MrOg1GPHc5PGuq3eJySao4CWXSnI6jJwDxXDSRxwaAVZUGx3FZtfRCp4x4daGz0nhgmZvZDMXQabCeO+OniVJvHhSXSxAEBKkJWxv7TyhKFgRGZk+DAUB2bmroZ9K8tCgly3LoIBwWix5WAyYzMLQ2ixMAzJg99LModQ0AKJRAQJ8PJ5drQnhGhpa0O8aA1GwbR4eXogTIkAoJx2SwhBU5qAFMNgMA3G7PrU97M6UCANj66+C0wpAah4tWyLOJf6zfN4cBGPQBQJE4iXD8fn8kgSQ1BoP6zvV2Gi2OICAo4AEAq9mJmWyJPHZekQhBEPwMgT8t7Bw0vyS9vUNGjP2O2jD+u4pkDpRz6sa2YjYHLa6QPH60dUbEhpbCju5qKpVEiQ905ttfDgTnNKzIUyMrROIXuyqDzXDa8orSX79Sfzq6z+efUCx/frPXanaS3wcHOvPczKasWipISbj4mrzv7hQpQFFZBuGsKDWeo2MAcDmPtDvY0sKWJTw0yYXT99NUXqGIyaI3v1RyaLKNhVAZNJMxMBN/b+iG7y+cW6Gw++Do6Fi3i5XLsxEEyS8W0+lxm2t7fj8ezvJhfVMBJS6Wk8AcJ8vgLAAAMOqtmMFWWCZBEESSLSitzLJb3fp9S7CvvMe+TKkgWchFUepg39x/WVtmpzbsdvfVa81MFp0v5L79YSuxoWg1JpvZwWDSs3JSAMBy6IymiSOuLWwOeqm7WlYjRSLsLb/2zDx1DULNc3SsnFfPz2x6vX52PAP9Vw2JIR8dWhr45VE044hEufyy4xnJQg6LxfB6fZptIyG6z3I3tVldNqvr/7hd/wMcBxFfpwoPLgAAAABJRU5ErkJggg=="
    m["dark_side_people"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEHUlEQVR42u1WXUxadxQ/93KtIFqwDSAX6KWuJH4utmCdsyBsa1OXVKB2SbO1e2+yxO2llXSd7cMSOz+67DNZ+rDtqXtph5nptpc2sSpfVlR0Mi2fUgU00ggIKVf28DcU8QOXpdlLz9PJOed/f//z8Tv3j1GUEl6m4PCS5RVAXiF2RMZxpUqpqFccoiSwDj6/32axDQ4Orq+v/ysAbNspYjJZHYbLVdVVOfYpx9TNru5EYm3vAAwul9pqbf+k/ejROgCgadrn80UikZKSEhzH+Xx+mbDMNGJCYXw+/+Spk5p3NDKZDMewYDC0pxJJpVRDw3EAmA8Euj7vCoVCACAQCAxXO0iSbGx84y5Feb3elndPX7h4oaCgAJ3S63VWq+3LvlvPn6fyZKDWaGpfrwWAr7/6xvXEhYyxWCwYDCmVJwAgvBRi4Hj7x+0Esel+IhFZVMSyj43nmaLS0lKkeD3ebLvb5d4I4B44//55HMfT6fR3335/8YMPO64YUKKnW1q4XG4egEwPORzOZuCNk2tra1KpFAAmJx0PHzxMJpOuJy6jsR8AMAxDrt0AZv+eRYpOr8UwLDO1rTrdRsDs7H/igd0+vrC4ICwTNp1o4vN4o4/HAECukMtkR1Dnx+0Tbpensqqitrbmrbc1w8MjYpFYp9MCQDqd9ng8+XlQ/lp55/XPWCxWjj0ej9/ovOF2eyqrKjqvd+J4bgEGfhv46cef8/NgZWXFbDLx+QKBgI++QtP06Ojjvt7eeX8AAJbCS6ur0ZqaagaDkTllsVhu/3A7h+rY7v8DgiBIEQkATwNPU6lUjpfH473Z1EiSokhkZWJicsoxtdddxGYXKerrZbIjJfv3Z4zPIs/m5uZsVls8HkeWcDhsNlna2s5yOByhUOj1eKPRaJ5dxGAQZ9v0rdozhYWF22InEol+Y/+9u0aaTgHApY8uadTqjOvOnV/uD9xPp9Pb94DJZF29ZlCrm3MomlO06prqysoKs8mUStEEg5Ar5KgTBEHU1dUVFxdlk/lFBhiGXem4fEx+DACi0eiv94ymERPiJ/IKBIKGxuM6nY7NZgOA1Wrr+aIHXZbL5TarVefeO4fy7uu9lVmILzJQqZRavRYAFhYXPjVcs4/ZY7FY9t2j0ahzxjk0NKxQyIuLi0UiMjA/7/fPo+I4Z5zOGaeqWYVhmISS/PH7n7lMPqNtRePYc7N3eXl5pxIthcPd3T00TQOAVqfNdk1PTz96NAQAYpGYJMlNADwej6IOAYDZZPb7/buz3+f1WS1WADhcfvjgwQPZLsekAykkKdwEIJaINyK2m+WtkgkTSyTZ9mQyiZSCffs2ATCZzMze3wvA6uoqUrauk+1fFZnJzR7hXWSnsK3f2Zj3mb9mgotBpOwFYKf4rXbs1dv0fwf4B6g8sJsXKN30AAAAAElFTkSuQmCC"
    m["dark_sel_people"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEFklEQVR42u1WXUyaVxh+zweC4j6QXwERlBa0xQq12qqdmcV1VTu3LGmy3exmP70wabZku9jlLpbsYsmyLF2bZVltll20ybLULJmdte2WpmvjpIL4V0tB5Mcf/PAHBT6E79vFsRRQB8vS7Kbv1ZP3fc953vOe5/yg4+ZP4VkaAc/YnhPkNe5eAYRQY4vBZNGpNBJgYT4QHrd7bfcesSz7rwjQririFxe9d+7Uvhp1jt81Hfz+/G90fKtwAo5W2b7T+/bZjgOHtADAMEzQH46sx14gixFCEhkpV4gcI26cJpGRre0Hj7XV6KrLEQIqFCmoRRWV0vqGagBYXFj97quB8HIEAKRy4fsfdCqUZeZGvVojCfrDbR2mnjPN3CIOHtXRbRm3z/7w7VByi8mzybWHKjHov/Innh0AqNB6/9X76YR9RtXrb7amZ8dWZ6nqOdOcX0VCUSkGAV840++fW04ndL/RRBCIZdkrfb9/0nvpy89+xqW8aDWRIkEeAjqewIAkizP9IlEJBvF4Qq2VAsDMVHD47kwikfTPLt+67sDaq6iU5iHwuhcxsHZbEHqSR6ATXYcxnnMv/adz8HDCH1pakytEDUf3S6XkxNgcAJjMOp1egXf+4YQ/4KX0RqXxgPpYW83oX26lSmztMgMAy7IBH5X/HGiqZL0fvVpcwsvxx2OJC1/84p+j9EZl78c9BIFyEv644ey/ei//OVhfjTpsbolMKFOQCCEASKWYyTHv5Ys3FoKrALBCbWxu0IZaNYfztMnO0dmffrzDMGz+FTztIJeQq8oAIDS/mkwyOVGJlLQ06eXKsshadGYq4JoOFnoXlQh4dZYqXbWiNENIkfWY17M0affGYtsyC1ORsQeek6cbSGGJTCEK+qjoJp3nLuJwiJdPHz5xyszj785N01u3rztu/mpPpRgAeOudl4621qRDA9dG7gw5M+/DrD3gFxed/bC76biRwyX2bhpnf61ab1A6bO5UiiEIjsmsxTvB5XJq6yoFpfzpcd8uK0AI3j3XebBeCwDRTfrmgN0x4k5fFQiBVC6sP1Ld0WUpEfABYNw+2/fNIC6WFAmaWgyvvHaEx+MCwOWLQ2M2d+4KGpsN1i4LAISW1r7+/Nq00xeLJjJrj27SHtfi6PDjOotOUMpXKMuW5lcWgisAkKC3PK5Fz6OFxhYjQkilEd+9PZl7kts7zViOfecHV8Obe7Vohdq4dGGQYRgAsHZaMkOPZ+YfDLsAoFwlVihFWQQSKanWSADAafPgov7B5n1h5+gsAFToZCJxadaLNBXAQF6eTVCuFmMws5uWd1pa8qoKcbbGkttaKOJmEaRFGYvShRBsROJPBvIK+lWklVvgk75X2s55tgv3uBao0DoGhRDslb/Tj57/Tf93gr8Bz6SoqkUBsmsAAAAASUVORK5CYII="
    m["dark_side_phone"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABwUlEQVR42mOUl7dloCVgYqAxYMEjx8jI6OzibGdvp6iowM7Ojib758+fx4+fbFy/4dix43gMYRYQkMdlemFRgX+Av4iICAsLFncwMTEJCgpYWFpwcnJevHiJZB84OztZWFowMDD8+PHj+rXrP37+RFPAxsqmp6/Lysrq4+tz7dr1M6fPkGaBnYMdAwPDz58/K8oqnz17hlWNhqZGfUMdMzOzp5cnLgtwRrKCggIDA8O1a9dxmc7AwHDj+o3Lly4zMDCoqCiTnIogsfrjxw/8ieT7j28MDAycnJwDlkxHLRi1YNSCUQtGLaB1pY8MxMTEgsOCOdg5GBgYfvz8sXbV2levXlHTgsCgQEcHBzj3/99/M6bPpCiIIHUZFwe0qjp37txPWL3/8+fPc2fPQ9gc7Jz4Kz6cPrhz566uro6Ono6Wlua1a9dPnzodGx2HpkZGRkZLW4uBgeHBgwckW7Bt2zZdXR1mZuaauppLFy/9/PULTQEHB4eWliak6j6w/wDO1huetmlsXIyvny/BUD529NjECZP+//9PWsuOgYHh0sVLjx49FhcX5+XlYWZmxoyk27dur1m9dsXyFfjan0O+dQ0AIPCUklyegugAAAAASUVORK5CYII="
    m["dark_sel_phone"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABxklEQVR42mO01m9goCVgYqAxYMEjx8jIYG6raWKlKiMrwsaOrvLvn38vnr3bu+3ihTN38RjCLCfhgMv0uAwXZ08DQSEeZhYsHmViYuTj59I3UeLgYL159QnJPrCw0dA3VmJgYPj58/e9W89//fyDrpOVRV1bmoWF2d5N7+6t51cuPCTNAhMrNQYGhl8///Q3r3v14iNWNYqqEtmlPkxMTLbOurgswBnJUnLCDAwMd289x2U6AwPD/dsvbl17ysDAIKcoSnIqYmNjZWBg+PXzN/5E8uPHLwYGBnYO1gFLpqMWjFowasGoBaMW0LrSRwZCIrxufkbsbKwMDAw/f/3etencuzefqWmBi5ehmZU6nPv/7/+VCw9RFEQ/oVUVG4R7/fIjeL3/6+efa5ceQdjs7KyQhgHJPnj84I2qppSalpSymuTdW88vn39QkT0PTY24pKCymhQDA8OzR29JtuDQ3suqmlJMTEwZRd43rz35/Qu92cLGzqqsJglpkJ06dpNkC65eeHhg10UHN31mFiYtPTk8oXzh1N1TR26S3LJjYGC4efXp86fvhEX5uHk4mJjQY+vnz98P773atfnctvWn8bU/h3zrGgA+pJdsQ0S4rAAAAABJRU5ErkJggg=="
    m["dark_side_puzzle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACkUlEQVR42mOUl7dloCVgYqAxGLVg4C1gIUYRDw+Purr6f4b/N2/e/PrlK5Ut8PbxjoyKYGNjY2Bg+Pnz5/KlK7Zt20a8BcwCAvJ4pG1tbdIy0piZmaHOYWExMDR4+uTp48dPiLSAES2jSUhIBAcHsXGwQ7iamhoCAgJ///5dvmwFIxNDREQEMzPz+/fvb9y4CVHw68fPtWvXvXjxgtggCg4Osne0RxO8cP7ipo2bGBgYNNQ1jE2MBQUFLS0tkBVMnTqN2FTExsGKJvLr16+DBw9C2AcPHvr16xdBLURFclhIOKbgieMnThw/AeeuWrNyEGe0mNhodnZ2YozQ0NC0srYi1oJfP35DGH7+fpVVFUxM+LwIiQ9BQcGCwnwvb0+i8sHjx4+5uLn5+fk4OTlFxUSfPXv+6NEjXBY8e/acjY1dXFyMiYlJU0tz186dv3//JmDBly9fTp86febMaU8vTwYGhm/fvp85fQaXBU+ePDl65Ojfv3919XRZWFiuX7uBmSGwhwAjKZEPD8b///8TTqYSkuIhISH6+voQ7sWLF/EYbW5h7ujooG+gz8DA8OPHj1u3bhGRk4OC7eztIOwrl68gp3pMkJObDU9pS5cs+/btG2EL4Nlyw/oNa1av/ffvHzMzs42NjY6ONgMDw+XLl48cOfrv3z+IGojpH959mDd/Pi6n4MzJy5YuZ2Bg4ODkqKqu1NDQgAjaO9o7uTi1t3b8/PkTrvL6zWt4PEogMsPCQuGmQ4CWllZIaAgVKhzkcubDuw81NbVMTExNLY0CAgL+AX7+AX5kFhXwnIwMLl6+9OrVqxcvXly8eAlLfsamBacP1q5dx8DAAK9w4FUKVHb1WoZ//3HJElWjjbaLhqEFAHdT9No+pNkDAAAAAElFTkSuQmCC"
    m["dark_sel_puzzle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACeUlEQVR42mO01m9goCVgYqAxGLVg4C1gIUYRFze7grIEA8P/+3dffP/6i8oW2LvqegWasrKxMDAw/Pr1Z+vaU4f3XqFaEBmbq/iHW0JMZ2BgYGNjCYy0MjRVIt8HImJ8rt5GbOxQcSVVCQYGhr9//21bf5qRkcEzwJSZmck/wkrPGGrHr59/dm899+bVJ2ItcPU2MrVWQxO8ceXJ/h0XGRgYlFQktPTl+fi59E1QPLF8/gFig4iVnRlN5PevP6eP3YKwTx27/fvXH4JaiIrkopRZmIKXzt67dPYenNs3J20QZzTfEHM2NqJyiZKqpKGZMrEW/P75F8Jw9NBPzfdgZGTEYzQkPvj4uWLTnO1cdLCqYZaTcEDmv3j2jpOTjYePk52DVUiE9/XLj8+fvsNlwasXH1nZWIRFeZmYGJVUJY8euPrn918CFnz7+vPy+QdXLjywddZhYGD4/v3X1QsPcVnw8vn786fu/Pv3T01TmpmF6d6t55gZAnsc4A8ZXIr//ycuJ7v5Gqtry0C4t649wWO0nrGimbW6ho4MAwPDz5+/H959SVRONrFUhbBvX3964fQ9PBZEJTvCU9qWNae+f/9F2AJ4tty7/cKuTWf////PxMRkZKGiqi4FsfLsyTv/YWEBMf3Th2/rlh9DzoBE5eSta08xMDCwcbCm53sqqkpABE2t1cxtNWZP3P4LqcC4d+c5LtMJ52RPP2O46RCgrC7p5mdMhQoHuZz59OHbpI6NTEyMueV+vPxcTh76Th76ZBYV8JyMDG5de/Luzec3rz7dvIolUWHVgtMHu7eeY2BggFc48CoFwt615dz//zhlseeS0abj8LcAAEJz6bbXYt3DAAAAAElFTkSuQmCC"
    m["dark_side_share"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADq0lEQVR42tVWzVMTZxh/3t3QfOyiq8SEQEhINAE7A5tYaC+JFRC1M+pBFAbbaTs9VsYenP4NRZwenJ5EqtD2IDUxLRWUgmBtIuiMDDoTCbTZDDmwfKxDaRIIbML28GJgOrXWTTz0Pf3meZ95fvN8P8hsdsPrfAS85qfI3kR+Pl1iMgNAdHo6Ho/nkkClUjefbjx0+DBJkgCQTqf7b/Vf6+5OriQzOiTDmGUTnGn5tLaujiA24kwQhM1uKzQYRkdGc0BQVfVW8+lmAJifn+++1j0+Pm40GimKKikxhsMcz/PZhoh1sBi0nb8QnY4CwNPgxIUv2wCAZdmxR2PZVpFao8GAn5nBYOY5oChNtmVqMBj27LZifOTIexi497swWFiYl19FDMOcajxZW1eLKwcAPvjw/ep3qgBQWZkdANbW1u794pdDoFZrjh0/euz4UaVSiSXPhGc7tQUIofLyciyRJKnzSmcmw/9AkJeXt/9dt8ViAQCO43695xdFkSQVNbUHmpoatzPbsZogCDe8vqE7Q3a77UTDiQ39SMR73TM19dtWg2jrLLJYSs99fk6n02Ukc3NzAz8PHKyvLyzUY0ksFuvp6em7eUsUxf/i9yaBSq1qPf9FUVHRi1RXV1d7b/b++MNPKyvLcmZRTc0BbD3gD1y92oUAnT17poKtxJEdHLzj+d6zuLgof5riOALA1x1X/lxaWlr64+LFr7Dk4YOHly9dlmH9JX2AEMp+1m7OogJtgXOfEwC0u3RTk5Nqtbrlsxa9Xg8AxcXFO3buiHCRZDL5qgRbkqxStra15jzJmx6kUumJpyGWraRpOvM9Ozvn8/n0+kKaphUKxd4399YfOggIuDC3vr7+ah5kGs3ldlmtFkkCjuMCfr8opnCjNTadYhjm741WZm842WC1WiRJioQjXq83FJr8NwI5o2KLjiRJHe0dAwODchZOKiUGg8HhoWGVSlVaWkoQhEajQQCSJIUmQsKCoNVqEUIVlRWjIw9isZjMjZZMJscejd0P3GfZivxt2wDg22++a7/Ufnf4riAI1W9XkyQZjyeCwWBW+4Dn+d/DHMb9t29jEPAHMNDpduXgLlpZ3ihWw/PKNhqLMUgklnOw9BFCLrcLAJz7nACSzWb/+JOPKIoCAM91zyw/my0Bz/MGg8FkNlEU5XA6HE4Htj4yMuq74cvNXfT4yRPlG0rrbis+jdLpdF9vX1dnVyqVktMHL3o0TZtMJQAwHY0m4omXdPL/77r+C0ZKbGTdfrfTAAAAAElFTkSuQmCC"
    m["dark_sel_share"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADrklEQVR42sVW3U9aZxh/3nOAw8cACxyEeUCsVMHPlNqhYU01TW221Gxt2ouuvViWbRe7XHa7pP/ErpbdbF27xabfcXESu0moHxWc2ll1yESZVDlQQT7k8+zipWiWbosHmj5Xvzy8PL/zPO/7/J4HOTqvwqs0Al6xCSoPIZNROkYNAKFgJJXMVJOAEgvfPXfc0ddCEAQAFApF9+jvQ3ens7u58hnSqOvlTXDpo97uExaEUKncBKpvrKW1ytlpfxXuoLXTaHvLDABRdufWdfftG+5oZAcAOrsOt3QYq1AiS5sBg2++Gg6tRwFgZSn0xdULANDcaliYW6s0A0oiwiD8bBuDrc0YBhKpqNIS0bXKepMG47f72jA41m3GIMrG+ZdIrpSeGbDZT1hIsvRxAxe724+aOAQNjToAyGXzngkfHwKxWNR7pqO3v0NElf61HU0oVXKEuIYjOuzhOLhz41H4Ra1eQiAQkl09RxiDBgDW18KeCV8+VyBJ4rij+Z33u+QKCT72PJoYeTAz6Vo0NWpPn7UxRg0HEAywI/c9q/6t/QHRfi1ijOoPP+tXaeRlTyQcf/TL056TVo1WgT3JxO7D4dkx55N8rnAwqRCJhVc+PbU/OgCoacXARTvG2Ux+zDk/+tPs7m6WjxbZHU1aXQ0AeKd8d34YRwCXP+5ramEAgOO4ibHF4XueeCzFX00ZI43Bre/diXh6J56+9vUo9sx7Vwe/c/GI/j99UBaZSmxP7GpUMmu7EQAOaRSrvmeUWPjBJ30aWgEAWn2NskYWDLCZTO6gBHuvSEQJPv/yPL6Glxq/S97LoFAo+pdDza2MVEaVf2a34s6hGTWtkMooUkAcbtL3nLQCgvUAWyxyB8ug3Gg2u9lQr+E4CAbC3ilfPlcsNdp7x+RK6T8bzVzbf9bGlM6zIw88f/o2/4uAj1TAXiocBzevucZ/fcpnouXzBd/SxqR7iaIEbxrUBIHEEhEC4Djw/xF6HkkcUskRgiZr3ZzHn0xkeI7MbCa3MLf22+MVS2ud7A0JANwbnBj81vXYvbwd3Wk7aiJJIpXM+pY2KpoH4c1YYJXF2P3wCQbeqRUM9usN/4mWSZceK/3iZev0JZBOZauwVSCEbHYzAFjbDQBgbNCeu+TAw/Ln+152K1YpQXgzRmuVekYlkVKWNoO13YCjz077nUMz1dmLFheCIqGAMdEEgXCrupzzt38cL+SLfPrg30wqo/R1KgDY+CuSTmarv5umkpmV5dBr267/BkRpcipkXFjyAAAAAElFTkSuQmCC"
    m["dark_side_sparkle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC80lEQVR42tVWS08TYRS90ymkGWzDAtgQ7LvsoNMWZKYwBKgBgikm4EYWxAVBVwKRx09oqv/BYIy6lUgisRQZ2plG+mJJC4grpHRFKaSdTsfFkFopBotTomf1zc2Xe+aee+7Nh6jVXVBJyKDCKI9Aq9VotZpKERgMepfb5XK7DAZ9RQh6HX0IgiAI0uvok56gqqqKIDrEM0kS1dXVEhPY2mw1NTXiGcMwi9UiMQHV9YubuylKSgKl8lYr3goA8e1YPL4DAGaLWaVSSkZg77TL5XIAoGkfvU4DAIqiBElKQKBSKQcG+53DTgDI5XIsy7AMk8vlAGD4vnNgsP/KOtDaWvWlnmm/0z429nBicsJqtWIYBgChYGjN+zmTyep0usbGRgzDcAs+dG/IoNfzef7w8DCfz5emQi7sIp1e57jrIIiOgmfEf49EoosvFxOJBAA0NDSMPxrHcbOom4h0Os2yAc8nz97u3m8JNBq1y+2SyX7qFt+O0Rs+xu9PpU5KO0/a7VRXp7HZVAjm8/mFuYX9/W83t+xuVqLiJltt1m6KMlvMKIqKwc0vm8/dLwBgdu5ZW3ubGOR5PhqOrtN0KBjiOK40lfzSujiOC7CBABtQqZSknXQOO+vq6nALLpoSt+AAkEwml94vMX7m+DhVtk0LyGSyOzu7PM/jFlwmkx0lkk23m2w2KwC8ffNu5eNKJpOVYJL9Pr84XBTVSXVTojIsw0i2KlKpk63IFgAYm01GowEAouHoBWUeP5l89Xqx0JuybUpvbBR/rtP0hQs9vT0KhcJuJ/+oyaUIbgbT6bTo3dPT03AofN5DFG1pbVEoFAiCAEBdfT1BEt8PDr5+3S+PgOM4lg04HH0AwDBsNnve25HRkdEHI4VrJpPRNDMlCML87Lw4z2VMstezKgiCIAhez+r1J/nKZwsAFMovlmh6ZgoAYrH48ofl60gkojh1YZIj4QgATE0/RRAkeXTEMmxFXnbe1bWzszOfz/9XEv3/b9N/keAHDdU7KzX7/0wAAAAASUVORK5CYII="
    m["dark_sel_sparkle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC8ElEQVR42tVWS0wTURS9b6alxZZEKMLCttP0E/qhtIXymYASCCG4IBI2GDaEnYkL49qYGI1xp3HB2q1sDKw0mkAaNUPp1P6AYtpp+sEFSFEDhUI/42LKpIEIFAejd/Xey5133jv33DMPddsewkUGBhcclQEo1QqlWlHRJ6Kzp6o1V+7eHwGAF09mkvFvwt+gs9eEEEIIdfaahKdIJMbtbVpu7HBqxWJcYACLjai+VMWNpdVVphZCYABnl6F82k4ahASQySTGZhUAJJj1RGwDAIxWlUwuFQzA0anHRRgA0FSUpiIAgOOYvV0nAIBMLu3pt/QN2QCgkC/6acbvYQr5IgD037D19FtOvYfod5oxtxDtpMFoVeF46RAroWRmJ8sNrA5NbZ18dLz75hi5Gkp5qMhKMJHPFU4HUGrqyV6zvU3La4Y7e3gpOTtNcdPZaQohMDWrcRGG45jFTljsxN7ugd8bo1wra/HN8g1RudldVSnuPRjFMMSvJJh1eiHqX4xmMvvHK2/v0Du79ISukV8sFtnnj19/TaX/ntmhI3Z9AkUzr6itzW0AqKuvGblFchTxOWei6OQih3zxl1PvAGDyzqDVoSlhF4qVFZmLfK4Q9MaC3phMLnV06PqGbLV1crNVzYnSbFUDwPetnfm3Ad8iw0nrnHad2cl+nFsGgNHxblyE2Z06QMAxM/cm8Gl+WZhO9rmjXHM5Sb2TNHDM+D2MYFaRyeyvLqUAgNA1EtoGAFgNpY4wMzZx/enUJF+bimVKL0TKpx4qciSho6dJIhE7jhnUWX+Zy4HE3u4Bp93s3kE4mCgdEMOaLMoqiQghBACXFTU2pza98XMtma4MIJ8r+L0x8poRAHx0LHeoyMHh1sHhVj5No2vQ6AZYln32qNTPFXSy2xVmWZZlWbcrfP5OPvXZAgD89cspmrg9AABxZsP1Pngeirgo3/rQ3YrhUBIAWJZFCP1Ibwfo2IW87Nwfvuxnc58Xo39E0f//Nv0XAX4BD9k1CKXOVtoAAAAASUVORK5CYII="
    m["dark_side_target"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAF/klEQVR42tVWe0xTZxQ/9/ZWWqjtpS1iJ7a8ycZjJbYICGVLC3tGEIwwdUsUzDbN/pngpiYzJnM4H4kiJlNRJ9vclqhM3ZxSIaMPwLbjUZwTnXChcyByW6RFg9ze7o8PiHQIusw/9v313e9+5/zO+Z3vPDCFIhOe5cLhGS/iCe8JhXPJ4GCJRAI+GHTSQ06n2+35DwDmy0KzsjQqtVqhUPj9oijKarEaDab+/v4ZNGCPi4FIRC5fka/T6TgczgzyXq9XX3v51KnTw/fuPQVAXFxsaVmpiBShz/v377e1tjkcDnrQCQBiiVguX6hMVgYGBqILQ0NDe3btuXHj5hMBpKenbfhgA5fLBYCBgYHvvv2+qbHZ62X8ySWItLTUopVFISEhADA2NlZ54GBTY5PfNQ5JKvxsL/uoDGmvvVS7s/xziqJ8PvafprEs29vbq6+tFYpEUVGRHA5HpVp0taODpp2P9UAoEu3duxsx81X11+fPnUfncoVcq9UmJSVKQ6QAcHfwrr2to66+3tHTiy4szV26+u1ViKvSD8uGh4en92D1O6viE+IBoL6u/uQ3JwGAyyWKS9a+9/67MbExQqGQIAiCIIRCYUxsTE5Otkgk7LB3sCzb2dlJkmRUVBSPx+Ny57S1tk0DMF8Wun79ehzH79y5U75jJ8uyXC6xZeuW1LRUDMMAwOlyXv/9en9ffwAvgM/nYxgWHR0dFxdnNjeyLNtht2uyNEFBQRER4SajeWRkxB/gjTdfj09IAIBjR49TFAUAxSVrU9NSkeoDFZVHDlUZjSaT0fTTjxcoiop//gUenzcvdJ5AIGhtaWVZ1uN2pyxOwXF8ZGTk2m/X/EuFSp2CXmRzUzPiXZetQ9q3frzVZrX5fD500+fzWS3WzZs3DzmHACA7J1sulwOA2dyEDFepVf61SCicq1DIAaCttY1hGADQarWImSOHq2jaieN4wfL8/ZX79lfsyy/Ix3Gcpp1VVUcBAMdxre5lAPB6Gbu9HQDCwxUCgWAKgFgsnigAPWiTlJSIzG+xtQDAsvy8wqJC2XyZ7DlZ0VuFuXm5AGCz2ZATiS8mIaneHgcAYBgmloinAAQHj38PuYbQRiKVAADVRSFmlmQuefR1Z2RmoFTo7qEAQCqRonOn0zVucfBUgEl+MRybkib4LPUc8xOfkPaBbwqAy+WacCUYbehBGgAiFOEoEsYG06N6jQYjYl8RrgCAwUHaj2rnhEJiAmA8v+XyhWjT3m5fELaAFJMqtcpqsZ794SwAZL2kYX0+wy+Gc2fPAYA6RY0M6mi3I6mF8jDkkGuiYIwDDA+7e3p6FAqFMllJEATDMHX19a++9gqO4+tKSrpuddE0XXOmpuZMzaQTUql0bfEaFIm6unqU9kplMgB0d3d7PB7/PLBcsQBAYGBgWloqADh6evV6PQCQYrK8/LOUlBR8Ih44ji9enLKj/FNkfu0lvcPhAIC09HQ+nw8ANsuv03Q0o8GUX5DP4XCKVhY1NzePjTEnjleHLQiLT4gnxWTppo0ul4vqpgAgIjKCJEkkdbXjavWJagDgcrmFRSsAgGEYg8EwTS3yeDwikSg6JjooKEgikVitNpZlzSazQCCIjIzEMIzP58tkMplMxuPxEDMXf750sPIgSszidcWJiYkAcPHCRbO5cfpqequrS5OVyePxwiPCR0cfdnZ2sizb2tJquWL1ehkejx8QMIdhmL6+frPRdOiLww0NDSzLAkBu3tK8ZXnoNVbsrxgdffjYjhYbG7Nt+zbUcPT6y18eOz42xsyQB1wud03xGp1Oi5ratk+2/3Hz5kwdjaadfX19KtUiDocTFRWpydJ43O7bt/9Clvq1zIzMjNKyjYmJCUj7gYpK+8R7naXpx8bGlG4qnYzkgwcPWlrabv/pGLxLA4A0RLJQHqZUJqM3g5jZvWuvn+2zjC1CobBgeUF2jo4gZpqdGIbR19aePnVmeNj9dHMRWqGhoZosjUqtiogI9/vV3dVttdgMBsPAwMC/Gbz8lkAgCJaIpWIJAAw6aRftnMzVWarh/366/huJ3YQKz47mWQAAAABJRU5ErkJggg=="
    m["dark_sel_target"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAF2klEQVR42s1WW1ATVxj+d7Mx982NBEgIBDA0gVAIhoEIilplFLWjaMcZfGh12j7odOxLO2P74ot98aGdaX3pMHamXmqtVkerY6mKKHJRINBAwk0mIQkgkitsuCW7fTgBJSKDnTrT87Tn7Nn/8v37/d+PlRWcgLe5cHjLi1jlPYGQS0r5EokQgAkGqHCAoqjZ/8BBkpI0W3RGk1aVJk945XX7uq3O9paBifHwChaw19VARPK2vV9k2WBgsVaCMRajmxscdX90TIWn38BBZnbyR0crRSQPbWem53pt7rGRQNBPAQAp5avUMn2+hstbgy5MhiI/na5zDo2vykGhObvm400EwQIA/8TkratPutqGYjE6EVwCL1iXtaO6WCYXAUA0GjtfW9/VNpRwjZWesikh9sOfVSLrTfX22u9ve90+hmFeDY2mmVGvv6nBLhTxNFoFjuPGwowBuzcYoF6bgZDkfXFiP0Lm+m+t9//sQuepGllpuSEnVy2VCQEg4J/s6/G2NvaOevzowubtBbv3lyCsTp24PDU5s3wGuz4o0b2jAoDWh703rzwGAIKNV9eUHfhwY0aWUijisgicReBCES8jS7m+wiAieQMOL00zzsFnIpKn0So4XDbBJnq73csQLUlJWjYYAMD3PHzlfCOy/umxqvWbcjEMA4BQkHLYhh224VCQAgAMw8o2531ybAdB4ABw7dcmv28SANZXGOQKcpkMNm416vRqAPj9wiOv2wcA1TVlBeYsZPpCbf3lsw/bWwY7Wgcf/GUbcfuyc1I5XLZcQfIFHIfNTdNMZGo2vygTx7HpyOzTvtHEDIymTPRH/t0+hHC3VBiQ9e9OXuvudC1WmmHAZnV+e/JqOBgBAEtFbqpaBgDWJ0+nI3MAYCzMSIRIIOSq0mQA0GtzR6M0AJSWGxAyl881hgIUhmGVu4qOf3Pg+MkDW3eaMAwLBSiEJI5jpRv1iHR9djcAqDRJfAFniQOJVBBvAB4fesjJVaPw7V0uANi207R9j1mhFCuSxVV7i9+rKgSAni4XSgJdBoAxTwAAMAzEMsESB6SEH+dkMM54iUwAAN5hH0LGVJL98t9dVLIWUQFVSyITovNgME4CsXipgxdMWtp4EEor9TIMAIChmZe3yOQSe+EFz6Q4ngpqO2qNHH3T3jL4st32lgGEvkojB4BF9ool8cBDwciSdr24V6ll6KGvx5OcKiElfGOh1mZ13r3VCQBmi44BaGvqr7/dBQBGkxYF1N/jQV+lqKUIj9CCy7gDampmxONTpcn1+RqCwKNRurWxt3xLHo5j+w6Wu13Pg37qzk3rnZvWxSSkMmF1TRmqRMvDXkRMfZ4GALzDE5EFOXoBua3DCQBc3pqCdVkAMOrxNz2wo/p//tXefJMWx+MA4zj2blHmsa/3oPCb7tvHRgIAUGDORg28u9O1jKK1twxs3WlisfAd1cVdHUPRefr6xeaUFOlavYqU8A8drQyHIt7hCQBIS08SLZRqwOG9fqkZAAg2q2pPMQDEonRbc/8yrSJCzYpIXnqmksfnSKTC7k4nTTPWx4N8ASctQ4FhGIfLViSLFcliDpeNkGm8Z//lTD0i5r6D5TqDGgAa73Zbnzxdvpu6XRPmUh2Hy1any+fmos7BZzTNOGxuW4eTpmkOl81eQ8Ri9MR4uKNl8NLPD9qa+2maAYAt2wsQ9cKhyNkf783PRV+raNos5ZEvdyPBaW5wXL34KDpPrzQ0sFl7a8osG/QAEJ2P/XDqxvBS4UxUtGCAGh8LGQszcBzXaBVmS05kamZ8LEjTzKuSaSpZe/hIpU6vQtbP1db32z2rEn1tlvLQ0crFSs5Mzzm6Pc9G/EEfBQASuSBFLdXnvRD9cChy5nTd8CpFPy6fIu62XevWVxhYxIpjS5RuarDX3eigpmbebC5CS64gzRadsTBDnZ6UOHi5Jmydrrbmfv/E5L8ZvBIWX8ARSwWoqwcDVChARf6T0XFxRajZCDW7OEb8j6brfwAfQ4CW6Qww4wAAAABJRU5ErkJggg=="
    m["light_bg_alarm"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEZUlEQVR42t1WW0yTZxh+/7ZAK4f+hcqhgAciGYMKA/5YncFBFubSYAL0RjKjhAvhwrjElFPCQuQGhEnM8IZNHReOEGujFzDaxQuDGAVKFWuZoqYM1tJ1Pz3ZA9C/7S4++Dfg72HJvNl79fU7PM/X93ve538xr9cHHzJY8IGDmcDvD2i18w7H+2ggHI73Wu283x9gXOXsnqIoqq/vlkajE4lSBwa+iUjQ0XHNZLIQxOHm5gYOhxPhH9DoAAAQjC4NQQDQaHR9fbcoigpHQFHU1as/InQcT2xpOR8NfHt7k0DARxxXrvywsbFNNdg/VdTfP/T48SwACAT8y5cvZmamohRPT+s0Gp3JZFlddQBASgpfJEojCLFEUpiUlAAARqOls/M7m80BAMePl166VM9McOZMs9e7RqO73d779x+MjT1cX99gvHtcXGxVVXl1deWePVyag8fj3r7dx0wwNfVCo3khk32Zni5cXjb39AyazeRmKlms7OwMoRAHAJK0Ly+vBAKbssnI2NvW1piVlWY2k0qliiAKJZJCZgI63r1b6uwc8HrXAADHk2Syk2VlJYmJCfQGp9M1OTmrVP5itzsBgMfjdnVdzMnJ3g3FQGCzOVpavrVa7QBw9OgnFy58xeNxGVPk9a5dv/7T06fPASAlBe/tbcbxpMiFduPGXYReUSGRyxtodL8/MDw8Ojw8StcUj8eVyxvKyyUAsLpqv3nzbuRKXlhYnJqaA4CDB7MaG09jGEYvzc29UirVSqV6bu7V3xnAsKam0wcOZALAkyfP3779LQKBWj0ZDAYBoL6+NiZmW1mur6/vGKCIieGcO1cDAMFgUK1+FI4gEAhotXoAyMpKF4tzo3e0wsKPRKJUAJiefrnDlLYRmM2k0+kCgNLS/H/rmqWlBQDgcrktltWQBFarAw3S0vaGwXI6GVyWPkKDMBAg4QMAjxfHVLdxWzJTjoyM7UhFfPym2Dweb0gCHE+kLX43QVFRXmXlp+ipFApVR8c1ZD5b1eNEA2R8zARCoQANDAbjbgI2m9XUVCeXN6DLLiwY7twZp1cXF3/fAsFDEggE/H370gFgdvalz0cxPsCxY8X9/e0FBYfYbFZ+/iE06fNRWu08AOzfL9pRzDs/QEeOFC0tmV0uj0r16NSpCkYOoTC5q+vrjQ1fbGwMmhkfn3C5POh4hEKTSj9DL6xQ/Lyy8mcYLdHoJpNFoVAh55BKT0Qg4PMTa2u/AAC3e627e5Ak7eHlT5L27u5BpByZ7CT6/kQwu5qaSoIQA4DR+Edra+/MjC4U+syMrrW112SyAABBHK6u/jwquwYAj2etp+d7vf4N+pmXl1NWRhQU5CKZkaRNr38zMTHz+rUBbRCLc9vazjO6Ohaqs6Mo/9DQPZVqAnlfqMAwTCo9cfZsDYfDZt4QvnU0GIwjI6PPnjH0VWw2q7g4v66uCnl1yBtE05u6XG6t9leTyWK12gAgOVkgEqWWlHyckBAf8Sz2P21+/8P4C7gM83/i0Tz8AAAAAElFTkSuQmCC"
    m["light_bg_battery"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABw0lEQVR42mP8/v03Ay0BEwONwagFoxZQDliQOT9+/Hzw4On79x9JNYWDg11dXZGLixOfBfv2nZg3b+337z/IcykjI6Ovr1N0tC8LCzMWCy5dujlt2rL///+THRT////ftGkvExNjbKw/FgtWrdr+//9/Zmam8HAvKSkxUk3/8uX78uVbPn78vGnTvsBAFx4ebnQL7t17wsDAoK+vERzs/vHj57t3H+vrazAzMyGz8dvx79+/WbNW/vv37+bNB4yMjMrKsvz8vAgLfv78ycDAwMHBwcDAUFMz4dmzV6GhHhER3shs/Bbw8XHD4/LEiQtSUmKTJ9diT6bPnr1iYGB4+vQVGptI8O7dR7jG0ZxMpgWQZCotLYbGJhIICfHDNSJSEScn+/fvP798+crAwNDSUgBJmmhs/ODbt58QhqOjhbOzpbKyLIoFqqoKly7dvHz51uLFG1VU5BgYGE6dugjXjMzGCr5//7lmzXZIgaGiIisgwIee0aKifK5cuf3v378NG/ZQEuKurlbIpiPiQFVVoawsBTmLk1HYubpaxccHoosjN1v+/Pl7797jt2/fk2o6GxubsrIsmtuxWDCa0UYtGKEWAAAhWbj6evPQpgAAAABJRU5ErkJggg=="
    m["light_bg_bell"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACkklEQVR42mP8/v03Ay0BEwONwagFBAELMYp+/Ph5/vy1W7cevn37gYGBQUREQE1NwcBAk4ODnVILfv78tXbtru3bD3379h1NiouL09vbISjIlY2NFY8JjHiS6YsXb9rbZz558gKPfjk5ycrKNDExEZItePPmQ2Vl77t3HxgYGPj4eLy9HczM9KWkRBkY/j979vrkyQvbth369OkLAwODiIhge3uRkJAACRb8//+/urr/5s37DAwM+voaRUUJPDzcaGo+f/7S17fg0qWbDAwMWloqTU15jIyMxKaiw4fPQkzX0FCqrEzHNJ2BgYGXl6eyMl1NTYGBgeHatTvHjp0nIZlu23aQgYGBmZkpJyeGlRVnQmBjY83JiWFiYmJgYNi69QCxFnz8+PnOnYcMDAyGhtqSkqL4k5m0tLihoSYDA8OtWw++fPlKlAWPHj3///8/AwODnp4aMblEV1cNEm0PHz4jygK4QwQF+YixAJ5+Pn/+SlpRgTVVYDGCiRGe9kZL0yFiAda4IgYQFcl//vzdsuUALKOyEWMuXNmWLQf+/PlLoD5YtmwzpBTi4eH+9u378ePnCVrw589fHh7uL1++3rx5f9myzXFxAThL03v3HpeVdZMdRJCs09VVqqQkiz2IKDEalyHo9cGdO49ev36Lpuf27Ye3bz+0tjbk5+eFlIZHj55XVZVXVZVHUykqKqyiIkdslQkHUVHFP3/+cnAwz82NYWBgmDRp8cGDp9jZ2ZYt66VOq4KTk+Pnz18XL15//vwNA8P/ixevMzAw8PBwUa3ZYm9vunHj3vfvP+XkNCIJmlEtJ4eHe2lrq6DVAaGhHkSlKyJb1//+/Tt69NylSzcYGBgMDDStrIyILMwZad18BwClygxFIEVKNgAAAABJRU5ErkJggg=="
    m["light_bg_bellring"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADu0lEQVR42uVWXUhbZxh+jp4k/hwTY6ObylJnTVRC1SxryirTSBmzejNKXaGU3pVSmkJxzDaslG0XFipWakB708FYCQPrRanoFliJtrFTsJmF2cWktXE0psnR+BOTHk3z7eKMrB7/zn5kjL1X3/nO+z7v9/6/VCy2ip2kFOww/RsKhocfWq03AwFWPEogwFqtNx88cK3/RQu+7979savLRgihKJjNx0UquHXrO4djZHBw1GxeNZmMmypwu6euX/+WEEJRlMGgS96/fMm5XBOTk77Z2XkAKlW2VltUVVWelibjGQwGncMxSgjp7rYVFuZpNEVJWSqZRaur8ebmVr8/BODkyY/r698HwHErvb32gYGhaDQmeHVGRnpjo+nw4Q+kUgmA/v6hGzd6ABQU5HV0WGiaFsbAbr/Po9fUvMujBwJsS0tbb+/369EBRKOxnp6B8+fbgkEWQENDTXW1AYDfH7TbnUILCCGnT38eCs3JZLLu7ksKhZxl5y2W9rm5eQByOdPYaDIaKwsKcgHi94dGRn7q7x9aXIwAUKmUly835+Rkh8MLZ858yXEreXmqrq5LFEX9YYHbPRUKzQGoqzMqFHJCyNWrX/HolZVlVuvFI0c+VKvfpOlUmqbV6vympkOdnZ9VVJQCYNlwR8fXhBClUlFbuw9AMMi63VNrXCSR0BRFURRVV7cfwL17YzxHWVmxxXKKYTLXuygri7FYTmm1RQAmJrzDwy4ABw++x+NIJLQwyE+eTAPYs0cN4MKFdo/nWWpqyrVrF/Pzc7dI0OfPX5w715pIJEpL325tbRbgrEnT5NXCwpLX6wOg1+u2RgdQWPiGXl8+Nvbz5OSzSGSZYTKTOJtW8vT0DCEEQEWFVkyV7d2r5dPE5/OLahWRyDJ/UCrlYhTk5GTzh6Wl5T/X7Pg8276dpfzOxtv9f2jX/30FG8ZKDIkKcjz+qq/PwZ+lUqkY3CRbX58jHn+1zUSz2e7wXYhhMqPR2IZTcP2bGCYzEll2u6dstjsnTny0JtdfX1uePv21paXtL7uIL50rVz4tLn5rYxf9HejNQCjB4uX1TodCswIZj8fn8fiqq/UKRRbfDZ1Ol0azW6PZLeDMzd1VUqLeSsGGdOzYJxy3YjLtP3v2OIDOzm8GB0dlMqnN1r6tLC3G6vT0NI5bGR9/PDPDAmR8/DEAhskQIytKQW3tvtu3fwiHF83mL167NP5jlXz0aINOVyKYAU1N9aLySuR2nUgknM6Hjx79AqCqqvzAgXdENnNqp9f33wAYDZZztqS2XgAAAABJRU5ErkJggg=="
    m["light_bg_brick"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACBUlEQVR42mP8/v03Ay0BEwONwagFBAELMufKldunTl18//4TXOTfv/9PnrxgYGCQkZFgYmIkKC4qKmhpaaiqqgAXYYSnok2b9i5atPH///+UhgkTU3p6hIuLJUoQffjwacmSzZSbzsDA8O/fv3nz1nz58hUliO7de/L3718GBoakpBBvb3u46uPHz/f0zGNgYCgpSbK0NCQovn797iVLNv38+ev27YeGhloIH/z8+RPCEBLio8T5EhIiEMaPHz8HIhUxMDBcunTzy5fvcO7duw8hjIsXbxAjfu/eIzQDoakIEnZUdHhMjF9goCsiiFhYWKgcMjADoZSIiACEERrqqaWljFXPtWt3Vq/ewcDAEBrqoaWlgkPN3dWrtyMbiO5weXlJPT11rJq/fv0GUyNFUM0AlUUMDAwPHz7n5ubCqvThw2dwBm41z7Fb8ObNBwgDEoL4ASQm8AO4gdAg+vPnD3VDBm4gC1oWd3OzVlKSQ85Qu3cfY2BgcHW1UlaWJyh+796jXbuOIhuIHgd6eurIhRcPDyfEIH19DWLEjx/nhFhA9yqTnZ0dwnj58i0lxr19+xHNQGhZ9OXL17S0up8/f1GpnGCeNauZn58X4QMeHu6kpBAmJiqEGCMjY0yMP8R0lDqZgYHh1q0HJ06cf/36PdmVvqAgv7m5vra2CpZKf7ThNWwtAADyefREZKJ3KwAAAABJRU5ErkJggg=="
    m["light_bg_broadcast"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD5klEQVR42u2WXUyTVxjH/6cU3qCdOFhZiw3GjWxARaLtqEkRaNn4MBarBrbwkd5oXLiBxEsTExP1slcLc36FKCyDGWAQIXQrFdibivDCinSyzREDhUJxikipbz/e7uIY5cuty2ayC87N+89zzvP8zjn/95wc4vMF8CabCG+4bQL+l4DOzt6amvMsy0VehWW5mprznZ19fw+w2QauXr3pcs12dfVHDujq6ne5Zq9du9nXN/hXgOnpuUuXmgBERYkMBn3kAINBLxKJwuHwxYvfzMx4Xgu4fLnZ7w8AqKoyajR7IgdoNHsqK0sA8Lz/ypVvNwY4nQ/u3fsVQHp6yqFDeQBCIcFsri8vP2W3j6wvarePlJefMpvrBUEAUFKiT019D4DDMT4+PrEBoLv7RyoqKgyEEABNTbdYluN5P8c51wM4zsnzfpblmpu7ABBCKioMtMtiYdcCgsHQ8PAYgJ07k+hEPJ7HbW1WABLJ1mPHCgVBsFrtZnO92Vxvtd4RBOHo0QKJZAuAtrYfHj1aoEtXKGQAhoZG6bJeAaamZnw+HsC+fUoa6emxh0IhACaTUSZ759y5L+vqvmZZjmW5urrGCxe+ksullZWHAQQCwZ4eO82i6V7v88lJ9yrAS+t37VJQMTb2G4DYWCYnR2213nE4xlfuz8jIzzbbQG7uRwzDvBy8Mt3t9qwCLC4uU7F9+1tUzM8/BqBQyMRi8f37v6/3wOl8EBMTrVAkAvB4/qDB+Pg4Kp4+XfovrwpCXohwOLzxQdu2bSsVCwuLVEil8QBcrtlAIJienrK+qFKZ4vcHXK45AImJCTT45MmL9Lg4ySpAUlIiFRMTLip27/4AgM/H9/UN6vWavXvTV1ZXqZQ6naa3d5Dn/QAyMj6k8YcPp6iQy9+lQkw/yclJsbGMz8cPDzurqg4DyM/f39pqCQZD16+3paW9f/r05zbbwOjoLwAyM1Pz8rLc7vmGhu8AREeLdbosWmdoyAlAItmSnCxbtYKoKJFanQFgctJNLZVK443GjwEsLS23tFgIIXr9/tpaU22tSafTEEJaWixLS8sAjhz5JCHhbWr79PQcALU6QyQSrTW5sDCbisbGDupVWdlBrVbFMDEqlXK9ByqVkmFitFpVaWkRtbehoZ12FRRoX/m/8lVx9uwXdBNMJmNJSf4/+pFaW7+ngMzMtDNnqje+TY8fL2OYGAA3brTfveuIvPrAwE+NjR0AGIY5caL0tdf1jh2JJ09+SggRBKG93RY5oKPjdjgcJoRUV38ml0tXdonXDM3NzfJ6n3d39xcXH4gcUFx84Nkzb1FRTna2eu0Z3HzZbQL+dfsT0gaPhgY1JiYAAAAASUVORK5CYII="
    m["light_bg_broom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACf0lEQVR42t2Wv08aYRjHv5KGUyQUYwP07ghDHWqaaBPTshhMmpRgOhhMME52NengxGYcHJ269B9wMjI0Dkaipob0R6QhBExjSBgowp16KBY4ofS4uw5nr8QWypFj6Tu975vvm8893/d5nvf6ajUBvRwG9Hh0D8hk8plMvleAdPprMLgWDK5lMkx75Z3uANvbEVmWAYhiQ/8IymX+8DABgKYdIyMu/QF7e58EoQFgetqj/x3Isry//xHAwADh8TzRHxCLfeG4IoCpqacmU7/+gN3dD8rE653Uvw4KhWIikQIwOvrA5SL1B4TD7yVJAuDzTepfyYLQODiIArBYzG734w5P9bVpdhx3sbkZrtd/qP6k01kAFGVzuShlkyCMc3M+m+1eN5W8sbETiXz+c59hOIbh1KUoiktLL7uxKJtlOjHh5OS0m14ky/LpaQHA+PjDlZVXAKLRo1jsKBD4bcjq6ptkMsUwnCRJBoNBG6BQuFTcp2m7suN2j7ndY80amrYnkylBEC4uiq2uoaVFudy5MiFJe6lUicePRVH6ZboUjx+XShWStN8Sa4iAZW/OOJ2O5eXXLMsFAr75+RcAQqGdUChMkrbFxXlVPDHxSFsEDHMDoCg7y3JK8qhZBIBlOYqy3xJrAOTz5wAGB/utVksrjdVqMZtNqribCCjqfvscJUkbgFzuTBuA56/LZR4ATdvaA5Qc4/nrSoXXAFC/iCQd/4rA0WxppwBVrRZB+wiaU6CjZre+/nZr652mTj4z82xhwd9pBNXqd60vXasjfy+02dnnsoxqtaYsLy+/XV2VnE4HQRAA6vV6Lnc2NHR3eNiqCIxGo9/v1fwe/O8/vx2OnysmE+KrbWoPAAAAAElFTkSuQmCC"
    m["light_bg_calendar"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACmklEQVR42t1WTWgaURCeXUPES4zGNGpVqoUQemhRQiXeAqUp5JCDpgkIhUJOIV4SLD2kvRYqQume0x6Ch2AswUJboemhETFBbNpADh6y4s/GWKFIDmEt+14PL4iYt+JPQku/k35v9vt23gwzy5yd/YarBAtXjFYGkoTS6cNq9VQuoFo9TacPJQm1EOlrcRYOfwyHPxmN1zjuGTVgdfWVIJRnZx/Mz093k0GxWAYAQSjLBZAjEiYHpqnI2aywt/e9UDjBGGUy2UrlFwC4XHbqw4nENwDQ6TSjozcYhrXZTE7nHYNhWNYgFvu6tvZOkqSuS6pUKn0+78SEnXJF2azQozoAiKLIcaFyuUIp8u7uPlFfXPROTt5lWTYYfJtIpAEgEuGocm63DwBcLsfKymOE0NbW51DovSiKOztpt/t+cwakVgzDEHUAUKn6AUClUsq9LzkiYSzLzszcI3wuJ1AywPi8nYk6AHg8Uxjj8fHbcgY+36NU6ofHM0X+KhTnDyKEKQaiKAIAxjgYfNOoEo+n4vFUi3tfX482MbWaSDHI50uNzdcLcrkTShdpNOrLmj9a7QAlg6GhQVLkzc3XXUuTvtJqB/+NacrzBZ7Pd8q0a8DzRb//pd8fODrKt8/8hYUjuw+s1uuBwBMAbLWa22c6WzhWq6kLpl0DSUIbGx8A8NzcNJkBF5merujgIBOJxABgbOymw3GLyvRYA6PROIwx2GwmOaYzA4apz0LEsqxaPcBxzxtDLzJNQKg+jxlKm1osBjJNo9Ev9dD2gRDa3k6S3ybTCGUnl0qV5eUXoljrtfH7FIHAU4tF35yBXq9bWvIqlf09qi8sPKyrUz5bjo9/JpP7PF+sL7g2wTCs2TzidNob1SkG/9fH76XgDxOLORgFcMt5AAAAAElFTkSuQmCC"
    m["light_bg_camera"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACi0lEQVR42u1WTUgbYRB9kdbdDQFJiek2ErGHLD0kEvBgbOjPRRrFi2i82B5ykgbjVZBQIwSPHlzaHnPQkwSkoGghIG1J1YDgmkDrGtr6E2rialow2ZgetoeFNGxiwWylpTjHmd038755M9+nEcUfuEyrwyXbVYK/n+Da78PZ7PfxcTaVSleNNjXdnJjw6fUNtTMIhebPQweQSqVDofnaGcTjfDS6AcBg0DNMiyLK818EIRuNbnR23rXZmPNANKVBy2SEubnls7OiAgJAIOCrhIjH+UCArUxPEPUDAy6j0aBkEA6/XllZryzB6WyrWqDNxjidbdHohiBk5Tp+nXudxusdVPZAFIuVKCZTo8fTex59j6fXZGqs9JdDlfdAAqDRaMLhacUPuZy4tPR2a2t7f/8rgObmW62td7q67uv1DSz7rPzLvj7fxWQKYG/vcHLy5dHRScmTSOwkEjuRSHRs7KnZTKsatHy+EAw+l9EpirRaLVarhaJIAJnMSTD4QhQLqgZtYWHl+PgbAIfDPjw8KEPn8wWWnY3FOEHILi6+6e9/VDuD9XUOgE6n9fkey+gAtFpyZOSJTqcFsLa2qeqI0mkBAMO0kCRR7qcowmJpAXB4ePRvb1OaNsgjLYpniubz/CcANN2oKkF7ux3A6Wl+enomlxNLY8GyM7lcAUBHh12Vinp6HkYi7wUhG4txQ0PbDHMbkHj+s0zIaLzR3f1AFQOKIv1+r7y5RLHAcR847qOMTtMGv99bklaNDACYzfTU1Ojy8rvV1c2Dg7TscTjsLtc9iiIufKNJklS5TxSWTO4mk7uzs68upiKCqP9T0iTJ61UYuN1dkoRisagSnSDq3W5XlRvt6l303yb4Ce0hA7xitxPNAAAAAElFTkSuQmCC"
    m["light_bg_chat"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABf0lEQVR42mP8/v03Ay0BEwONwagFBAELMufkyUtHjpxlYPhPgYGMtrbGZmZ6CD5yKoqJKfn+/SeFTubkZF+ypAd7EFFuOgMDw48fv3AGEQRYWRkVFyeSYXRv77xjx84P71SEBl69erNq1Y6fP3/hUcPOzhYW5iEmJkKOBWvX7t6//yThQGBizsqKJCeIjIy02dnZ8ZvOzs5uYqJFZhCZm+stW9YzAHFAMNypEAf4w53SOCAY7nSNg4HIaMePn582jQMSxA8ePJsyZdH9+0+p4wNOTnYGBob////v23ecgYHh4sUbNTX9pJrOwcGG0we5uXHz5q158+b9////9+07MWPGir9//zIwMGhoKAkJ8RNZ4djYGKPw0Zotvb3zjx07x8DAwMjI+P//fwYGBj8/57g4f0ZGRipntP///zMxMSUlhXh62tIkJ7OzsxUWJpia6lI5FUlLizEwMAgI8FZWpquoyFOeTNHj4O/ffxcv3lBWluHn56NKPmAcbZsOuAUAiaKNjg/O+UMAAAAASUVORK5CYII="
    m["light_bg_chest"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACXElEQVR42mP8/v03Ay0BEwONwagFBAELQRXv33+8cePeo0fP3779+P37dwYGBk5OThERAVlZCQ0NJUFBfjIt+PHj5/79p/bvP3737mM8+lVU5B0dzR0dzdnZ2bAqYMSaTA8fPrNgwfoPHz4RGQ6CgvyJiUHW1kaELfj379+sWSt37z4G4bKyshobaxsYaKqoyImKCvLwcDMwMHz58vX163d37jw+d+7a+fNXf//+A1Hs4WGbkhLKyMiIz4J589Zs3XqQgYGBmZnZ29shMNCFj48Hj9s/fvy8fv3ubdsO/v37j4GBwdfXKSEhEKcFV6/erq+f/P//fx4erqqqDHV1RSKD6Pr1u+3tM75+/cHIyNjSUqChoYQ9mW7ZcuD///8MDAxFRYnEm87AwKCpqZyfn8DAwPD////Nm/fjTEVXr95iYGBQVpbT19dAM+L///+3bz94+/YDAwODmJiwsrIcmgJjY21FRZn7959cuXIbpwVfv/5gYGAQFxfGNL2vb/6xY+fhIu7utmlpYWjKJCVF799/8uXLVwL54O3bD8ePn0cWef78FbLpDAwMu3cflZeX4uPjRtNIVEa7efP+zZv38Qc6JDUP1rJIXV3R19cRzU+QtAERh7PRUtrmzfsxvY7FAmFhQUtLQ1QRAYihyEnQwEDTwEATWdmxYxcYGO6TE0Rqaory8tLIIqKiQurqStQpriGgtjZz69aDL1++gZju7W3PyclOTQsEBfljYvxGq0xYYjh37Ng5mvgAV7VHEkAzBMUHeXmxR4+eZ2D4T4H5jNbWhoTr5NGG17CyAADRze10rf7HDwAAAABJRU5ErkJggg=="
    m["light_bg_clipboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAChElEQVR42mP8/v03Ay0BEwONAQtBFdeu3Zk7d82jR8///fuHcBcTk5KSbGpqqIqKPH7tjPiD6MuXr1lZDV+//sAqy8fHM2VKHTc3J8k++Pfv35Mnr54/f3HnzmOI6VJS4jw8XHAFnz9/ef789adPXzZu3KOsLCsvLyMhIUKsDx4+fDZp0qIHD56SFNYaGkqFhfEiIkIELPj69XtRUfubN+/JiE8pKbHe3go2NlZ8QXTgwCmI6RYWBlZWBg8ePFu3bhcDA4OkpCgvLw9aEDEwMAQHu8nLS+3cefTq1dvPnr06dOiMi4slPgvu338MYeTkxHByshsYaO3Zc+zTpy/Pn7+GmIgMeHi4/f2dubm59PU14uMrGBgYbt26h2YBej74+fMXAwMDIyMjJyc7AwMDNzdndXWGqqo8MzOKSiYmJkVF2crKNG5uLohNEPHv33+RnA9UVOQ7OkoGb04e6KLi5MlLR46cZWD4j6sgsLU1NjPTI9+CyZMXf//+A4+CCxeuL17cRX4QWVkZMTIy4izIGBmtrAwpCqKsrMisrMihHMnTpi3ft+/4////cQWRs7NlZmYk+T44duwcLtMZGBj+//9/7Nh5inyQmxtLMJlSZIG5uZ65uR4N4+Djx8/Xrt1BE9TSUuHn56WOBTU1E549e4UmKC0tPmlSzRBJpi0tBViDiHwLBAX5Ienvzp1HKipy/Py8lpaGBE158uQlTDsfAQuMjLS3bj3AwMDQ2DhFT0+diYmRoOn//v2H+1JXV42ABQYGGo6O5vv3n/z27fuJExdICm4TE11TU13C7aL///9v3XrwwIFTDx8+RW4u4kwnTEwyMuI2NiYBAS5oVTfhpuMQqDIB58L8j4ggEKgAAAAASUVORK5CYII="
    m["light_bg_clock"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEDklEQVR42tWWT2gTWRzHf7OZYZs2f02M0VpNZPUQUTdlU0mk5tDCFBRbpDk0kJWCCh404mHDgqwQCot6cG0v6opCqowEFxtEthgrBGzcRjClh9J6MEnZNrTNJJM/JtJMzB5eNptM00njrof9nebxfvP9zPze733fw3K5PHzJ+Aq+cOCbzEunMzSdoukEhmEKhUyhkIpELf8BIBqN+XyBN29mwuFFzpRW22owHDSbO9RqJY8CttEaJJMpt3vc6/UXCgWe9wUCAUke6e/vkUrFDQDm50PXrv3KMGk0bG4W6vW6Xbu2KxQyAIjHmUgkGgzOZrM5lCCTSRyO0/v2aTcF8PvfDg+P5vMsAKhUSqv1mNGox3EBJ41lWb9/mqKerqzEAYAgcLv9e6NRXwcwPx+6cmUYqff0dA4OnsRxvnXK59l79x4/fz6JGE7nBc5/VAGSyfSlSz+jypw61XfiRBdnVS5f/gUAhoYuSqWSyimPZ8LlGkO1unHjR4lEVHsfuN2/I/WuLhNHHQDm5t4vLa0uLa3Ozb3nTPX2dpFkJwAwTMrtHq+90aLRmNfrB4Bt25Rnz1rWV+PTpyLnoTIGB0+qVFsAwOt9tbxM1wD4fAHUkQMDx/jrXjMIAh8YOA4ALFvw+QI1AIHADOpIo/Hbz3MFk6m9paWpLFUFSKczkcgiAOj1us/4/JIr4IJDh3QAEA4vZjIfqgCxWBI9aDQ7/o217d69AwCKxWJZsARIJEpjuVxaV2Vi4o/KZayM8uuJBFMFwDDg6RAUarUKwzAACAZn7fah0VFPNvtxXVbxb0GsClAmM0xyI4BW2+p0XtBqd6INPDb24vx559TUdGVOPM6tRAmgUJTGkUiUpzg63TfXr/9w7pxVJhMDAMOkR0YeViYsLETR55cFSwCxWKTRtKLfZ1mWz98xrLvbODLyU19ft1D4tcnUXulLweAsAOzZs7N8HP3TkR0dB8PhxWw25/dPHz36Hf86Nzc32Wy9Nlsvx4ZzuY8AYDAcqLHRzOYOgUAAABT1FLlpQ7G2lqeoZ2g3mM2GGgC1WkmSRwBgZSV+586jRgH37/+2uhoHAJLsVKmUtd20v79HJpMAwMuXUx7PxObVnzx5gY4EuVxisZAbXlukUrHDcZogcABwucZu335Ut1Zra/lbt6gHDzwAQBCEw3FGLBbVOTJfvw7evOlC0lu3brFaj5tM+vUGxbLs5ORbinqGKkMQhN1uq39konj3LnT16l2GSaGhUNjU3r6/rU2tVMoBIBZLLCxEg8FZ1DOoMg7Hmb17NQ1cW1KpjNs97vW+YtkCv4OSZKfFQnIqUx+AYnmZ9vkCgcBMKPTnOudoO3z4gNlsqOyZhgHlyGQ+0HSSphkAaOjqiP3vb9d/AUDTvMPipM8QAAAAAElFTkSuQmCC"
    m["light_bg_coffee"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACtklEQVR42mP8/v03Ay0BEwONwYBa8OrVm6lTl5w8eQnC/fv337JlW5Yt2/L37z/iLWDBIzd79upz564dP37R3LybgYHhwIFTa9fuZGBg0NJSMTDQoIIPbt16wMDAICEhCuHevn0fwpCUFKVOEMnKSjIwMDx79vLXr98MDAyyslIQ8Xv3HlHHAiMjLQYGhp8/f92585CBgcHISBsifu3aHepY8PLlWwiDl5eHgYHh5cs3EC4fHw+1fKDNycnu4mIlKyvBwMCgqCglJSUqJSXq7m5LvAWMyDn5w4dP16/fJSmZs7KyGhpqMTMzEZVMq6v7X7x4Q2pWCgpyi472JSqIyDCdoC4sGU1NTdHPz5EYo3t65jEwMNy8eb+vb4GUlKi9vRlmFsFigYiIoKWlIfE+ePv2/dGjZxkYGNat252cHOLubkOrwu7v37+zZ6+6fPkWlS2wsjJauXJCWlooIyPj////163bRX0fsLAwu7vbaWoqQ6KEVkH0//9/0opr4sHv33927ToKyaTq6oo4LWBmZvr79x+k7CQI4MqOHTt37Ng5aMHAyBgS4o4ziERFhRgYGB48eILVs2jg3r3HGMUGS0ZGpLa2Kk4f6OqqvXjx5s2b9+fOXTM21sZvwc6dhyEMbW1VAQE+aWkxBwdzcXFhfIXd/fuPS0u7////LyIi2N5eJCQkgMv0o0fP9fcv+P//v4yMxIQJVYyMjESVRYqKss7OlgwMDG/evK+s7Dt9+jJmWH3//mPFim0TJy78//8/IyNjcnIIHtPRfQCJuqamqfBCW1hYQFFRlo0NGpKfP3+9devBz5+/INz4+EA/PycS6gO4HfPmrdmz5zieqObh4UpNDbWxMSGtwkEG9+8/2b372KVLN169evf371+IICcnu6yslJmZrqurFQ8PN8k12mjbdEAsAACZlxFcKDo0iwAAAABJRU5ErkJggg=="
    m["light_bg_compass"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEdUlEQVR42tVWX0xTZxQ/pfdmw1FaLNZOAUGiiWyixRXSMryLxBZSo4uCCc02A1FfTFbjHuo2ExOTbdFkkfJgJEOTMZOabkaJqRA6DRfhGi+Ga3jAoCG0DU2HtvT2D1ToLezhKx29txRY5sPO0/3ud77f+fP9zneOKBqNwbuULHjHgq1RLxyO+P0hvz8gEonkcplcLs3J+eA/MOD1+kiSHhoacTo9vK2Skq1qdTlBVCqV+RkQRCvdQTAYstl6HA4qHo9nOC8Wi/X66oaGOqlUsg4DY2MTV678wrJhtNywIVulKisq+lAulwHA9DTrcnkZZnR2NooUZLJcs/nkzp0lazJAUcNtbb/FYhwAKBT5RqNBo1FhmJinxnEcRT23Wu+/fj0NADiOmUxfaTSqVQyMjU1cvNiG0Ovqapqbj2JYpnuKxbibN//o7R1ENi5d+poXR4qBYDB87txPKDMnTnx++HDtGjnW1fWws/MeytXVq9/m5uakrwObrRuh19Zq144OAEeO1Or1NQDAsiGbrSd9oXm9PoeDAoDNm/NPn27MjPjixbjF8qvR+M21a1b0p7n5qEKxEQAcjoGpKX8aAyRJI0Y2NRlWynskMmO395lMP1y40Nrf/2xubp6ihtEWjmNNTYcAgOPiJEmnKTSaHkGM1Gj2CqHHx912O0lRTCyWQorKyvLkt1Zb0dFhm5l5S9Mjx4/Xp0QQDkdcLg8AqFRlQvdfvXKeP/8zSdIIHcfx7Oz30NbBg9p/nMXEe/aUAYDT6YlEZlIM+HxB9FFcvEXofnf344WFBQAoKFC2tBxrbf2O4xLLXbtKl2tu27YFABYXF5OACWcDgcQ6L08qzDtFMQjOYvkeAOz2PhSKTlfNU04eDwRY5GsiApEoobGwsMg7Q5JDPLilssIJQi2IdnEJUJQSQdIyywZ5J5Jw+/Z9bLf39fYOTk7+BQBarUr4Yk9P8zORMCCXJ9Yul5fHdwSHYVlnz/6YpFBWVlZ9fY3wttxuL3I/CZgwIJHkFBdvdTo9DDPKcVySSKj0ACAanVviO67VqgwGorS0SPguMcwoAGzfXpAMDlvOaKfTMzsbpajn+/d/srw4kBQUKHW6aoJQr9TLKGo4Gn0LAGr17jSFRhCVd+70xuNxq/W+RrMXxzFUOwMDz6qqynW6T3mM5Mn8fMxqtaNqWH75Ka/pjRu/P3jQDwAHDlSdOfPFupp7e/ttRAeD4bOWlmPpX9OGhjqZLBcAHj162tX1cO3od+/+idDz8nIbG/Urji1SqcRsPomS09l5r739Nuo8mTNz/br11q0udP9m8ymJJGeVlvnkCWOxdCLoTZs2Go2HtFqV8IHiOG5wcNhqtb95g1ombjJ9uXrLRPLy5cTlyx0sG0LL7Oz3Kyo+KixU5ufnAYDPF3C7vQwzijiDMmM2n9qxo3gdY0soFLHZehyOAY7LNLZgmFivr2ls1PMys7oBJFNTfpKkaXpkYmJSMHgVVlXtJgi1QvGvBi/hm+r3B/1+FgDWNTqK/vfT9d/yTwEieE3xsAAAAABJRU5ErkJggg=="
    m["light_bg_contrast"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC4ElEQVR42mP8/v03Ay0BEwONAQuR6j5//vL27aerV299+PBZSkpMRUVeVlaCChY8f/7m4MFTp09fevDgKZoUKyuzgoJsRISXgYEmHhMYccXBx4+fVq3asXv3sb9//+J3hJSUWHFxsoKCFAkW3Lx5v6tr9ocPnyFcLi5OQ0MtBgaGo0fPYjeFkTE+PtDX15GoIDp27NykSYt///7DwMAgJiYSFeVtaWnIwsJ8/Ph5XBb8//9/wYJ1r1+/TUoKIWDBzZv34aZ7eNgmJgaxsBCbELZuPSgqKozmDybUcP/c1TUbYnp8fEBqahjxpkPAwoXrHz16gdOCVau2Q8Ld2dnKz8+ZjFT/////np452C14/vzN7t3HGBgYxMVF0tJCyc5ZT5++vHz5JhYLDh48BUmRkZHepIYMGli+fBsWC06dugRJkZaWBhQWD/fuPUK34PPnLw8fPmVgYDA01KLQ+QwMDL9//3n27CWKBW/efIQwcGVIUsHNmw9QLHj/HmqBoCA/VSx4+fINigWMjFCJf//+U8UCRpiJTGgO//DhI1UsEBcXQbFAWBhqwcOHz6ligZqaAooFvLw8CgrSDAwM589f+/PnD4Wms7KySEmJoecDMzM9BgaGb9++Hzt2gUILlJVlsWQ0e3szZmZmBgaG5cs3Q8o7skFUlA8WCyQkRNzdrRkYGF69ejdr1gqyTZeTk9DWVsNemoaEeAgI8DEwMOzbd3Ljxr3kNFKYGIuLU3AW1/z8vOXlKaysLAwMDIsWbZg5cwWpYZWcHCIjI46vXaSmppifHwexY9euo7m5zYcOnSYyXXl723t42BFV6d+6db+zc86HD58gXE5ODiMjbTyVPhMTY2JisJeXPQnNlk+fvqxatWP37iN//hBotsjIiJeWpqKFDGELYGXW24MHT506den+/SeYuUlZWTYqygc5zZBsARx8+fL17duPV67c/vjxk5SUuJqaAjyvEij1hnzrGgBAvCTGqBQmSQAAAABJRU5ErkJggg=="
    m["light_bg_corner"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABsUlEQVR42mP8/v03Ay0BEwONwdC3gAWZM23a8n37jv///x9THTs7e35+nLm5HkU+wGU6AwPDz58/z527SqkPIKaLiAiqqSlg+IAtONiVUgsgQE1Nsbg4cWhGMib48+fvvn0nbt26//PnLzQpTk52LS0Ve3szRkZGMi348+dvQ8Pk69fv4lKwd++JY8fOV1am47EDXxDt23cCj+kQcPbs1YMHT5Hpg9u370MYc+a0CAryo8m+fPk2K6uBgYHh6tXbDg7mRPmAk5OdgYGBk5MNwv3xA1oOYprOwMAgLi4MCZkfP34R64Pc3LgzZy6FhLjTKhWZm+uRURgMo9L01as3U6cuOXnyEq0sWLNm5759JydPXkSsBfDk9PLlW0zZ9+8/QgpHdnaosu/ffzEwMHz//pPYfKClpbJ37wkGBgZIescF1NWVyIwDe3szY2Nt/MGipaXi5GRBZk5mZGSsrEw/dOj01au30TwOCRl1dSUnJwtmZibyS1NGRkZ7ezN7e7MhWx/gSu+rVu3ArCFu3XpAHQvWrt29f/9JPKFKaRAZGWmzs7PjMt3JyRJFZLRtOuAWAAB6/Jkt6cq32AAAAABJRU5ErkJggg=="
    m["light_bg_disk"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABo0lEQVR42mP8/v03Ay0BEwONwagFoxZQDliQOefPX1u7dte9e09+/vxJhlmcnOxqaophYZ4aGkpwQUZ4Rtu378S0acv+//9PoZOZmZlKSpLNzPRQfPDjx89589b+//+fmZlJX1+Dg4OdDKO/fPl2+fKtv3//zZy5wtBQi5WVBWHBgwdPv3//wcDAEBbmFRLiTrbzFy3asHHj3g8fPt+//1hNTRERye/ff4QwpKXFKAkfVVV5COPNm/cDkYqQwcePn+/ceWRgoMnMjO6Iv3//Xbhw/devX8iCEhKiiooyJFhQUzPh2bNXwcFuUVG+aFKrV29fvXoHmiAjI2N3d/lAZzRk0NJSAAkiTKnQUE9VVQVsQST94sUrYi3g5+c1NtbGlZVwSQ1cYScsLABh3L79kBLjnjx5CWEICvKjBJGCgoyAAO+HD583btx7//4THh4uMkz/8ePnhQs3GBgYuLk5lJRk0Qu706cvd3fP+fv3H4VhwsjImJMT7eBgjm4BAwPDzZv3V67cfuvWve/fySyuFRVlQ0Lc9fU1sBTXo1XmqAUj1wIAFQigATnSjHAAAAAASUVORK5CYII="
    m["light_bg_exit"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABfElEQVR42mP8/v03Ay0BEwONwdC3gAVT6OPHTzU1E549e41HGyMjo5OTZVZWJDk+uHHjHn7TGRgY/v//f+zYOTJ98O/ffwhDTU1RREQAlx9sbIzJtAAO/PwcLS0NR5Mp5UZMm7Y8JqZk//6TtLLg2LFz37//nDp16d69x2liQVJSMCMj4////6dPX45pBxUscHKyyMyMgtuxY8dhYpMpUt7+fO3aHTwKuLjYjY11zpy5/P///zlzVrOysjg7W5JgQU3NhGfPXhHpIYg/lJTkFBWlB6iwwwQtLQX4g4iBgeHAgdNnzlyGlIOZmZEQ5xNrAT8/L/4yY+/eE2fPXoGYnpISCo8AYi3AD/btOzF9+rL///9D3I5sOnXiYN68tbhMp44FVlZGnJzs2dnRmKZTJ4iysiLxVG3DstKHg02b9h87dh5XlWlra2Rmpk+OBUxMjBDGrVv3b93CqfP8+WtLluiTE0QaGspSUmL4tTEyMlpbGxETRIyjbdMBtwAASreNFeBKEjoAAAAASUVORK5CYII="
    m["light_bg_eye"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEDklEQVR42u1WXUxTZxh+utKS0T/QUmiZPaDQQIrJSNkFC3VmLo6EKCrOG01AsFxsNxS5gCPuwp+jF4pcuYkBUfHCMEJwmmzJSLAXhgFWklFbUwhtsUVaVkpbftpKu4sPj6xhgCZkN3xX57zf+73Peb/veZ7vcBYXI9jK8Qm2eGwD/P8ACRtmOJ3ugYEXJtOYw+EKBhcBCIVJSqVcrc4pKvpcoZCtv5yzDk1tNldnZ+/IiDkWi629mMMpKMg7daqMohQfBhAOR7q6fuvt7VteXiYRHo9HUYrkZDEAn89vt7sikZWFXC73yJFvjh//ls/nbQrA5/MzzM/j45PkNS9vz6FD+wsK1KvXh8MRo9H0+HG/2TxOItnZFE3XSCTiDQCmpjwXLtx0u2cASCSiqqpjxcWFZCoQCDocUwAoSiEUCkjQYBi+c6fb7w8CSEuTnj//vVye+p8AXq+Ppm94PF4AKlVWY2ONWCwk8c7OXw2GIfYwCgvzq6vLZTIpgLm5wJUrrVarDYBMtoNh6lJSJGsALC2FaLrZbncB0GjU9fXVZE+czmmabg4GF+J6FwqTGKYuIyMNQCgUvn69/flzE4DMzAyGqUtM5Mfr4PbtLlI9L28PWx1Aa+tDUl2lytLpTuh0J1SqLADB4MKtWw9JTmIiv76+Ojd3NwCbzdnW1hUvtKGhv/r7/wQglaY0NOjY6h6Pd3TUCmDvXhXD6EtKtCUlWobR5+fnADCZrGQ/AfD5vIYG3c6dyQD6+gZIN+8B7t3rIbyura1gDxDA5OQb8lBcXMjhcFj6a7VfxCUAEImEen0lSevo6N4Sq4hGY2t7UUXFMQCxWKyl5W4gEGSnd+1Kf0fHwWg0+q5K1GAYjEsA4PcHW1ruEqZVVpavyLCp6UcACoVsZsY7MeFcWFiyWCa02kIulwtAIPjUbB53u//2eLwjI5ZIZHlszNHe/ovFMkEOprR0PykUCoUvXfrp9es3AA4c+LKs7Ot4moZCYZputtmchKZnz1YRqrlc7nPnbhAprR5isfDyZT0xu1AofO1am9H4EkBW1mcMU8fS5F9Cm52do+lmt9sLICcns7GxRiIRkfj9+4/ihHbmzHepqTuItVy92mq12gHIZFKGqV1baKxVXLx4c3p6hnzj6dPl+/atWMX8/AIRCkUpBIIkEnz6dLCjo4f0l54ubWr6QS6XbmB2c3N+hmkdG7OT19zc3aWlX2k0+aw4yZ4MD48+edL/6tUEiazueFN23d39e0/PH6xdJyRwKSqD9D4767PbXW/fvp86evRgeflBHi/hwy4cu9314MEjo/HlOheORqM+efKwUin/mBuNPZVnz16YzeMOhysQmAcgEgmUSoVanV1UVJCeLv34K3P7t2UbYHPjH+V45wkaDwvBAAAAAElFTkSuQmCC"
    m["light_bg_eyeoff"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEZElEQVR42u2WXUxTZxiA39MfOjqgvwyhUMrP+EmhYGVIBZTYGEzkYotzicyYEJEEjHqzaEwcaTQmuiuFCWHThKWsZuFiW9DITYXESKVKIaWl2w6kBcYBW6yUtp620H67OO5YsIAkcrPsvfrOm+/7nu/9PS9Gkiuwk8KAHZb/GKCj496JE98MDAzvFGBoyESSwdu3f9brDR8KgEVn0aNHTzs6dAghDMOam4+r1SpKv7CwODhotFj+cjj+DgRCPF6iRJJSXPypSqVMT0/ZBgAA9PqnnZ1vGI2Nxw4fribJwOnT35JkIOb5kpKC+vq63NzMjQDMy5dbo7+zs9NFIsHz5xaE0OjoRFJSgkwm6esbWF1d5XA4BQVZOTnS+PiPfD5/OBwBgBcvFvV6w/Kyt6goj8lkbm0BANhsU1evdgaDQQCg7CgtLVxYWJTLc9lsFrUnFFoZHbU9eDBgtU5SGplMculSk1gs3AJgteLXrnX9ezsgBLSvYnrg2bPxrq5fXr3yAIBIxNdozqalfbKhi+z2uStXvg8EggBQW1t96FDVyMhbX8V0tESSUlNTjuPTLpebJANGo1mlKuVy42MAvF5fa2vb8rIPAI4cqWlsPJadnUHHw2SyRiKouDjvXQaHE1ddXeZwEAThJMnA+Dh+4MBnLBZrPeDmzW4cnwaAyso9zc3HMQyjYs7lxo+N2QBgYmKSx0uMaQeTyaioKLHZplwut8fjdbs9e/cq1hTakycmo3EcAKTSXWfO1FO3UyIW8+n1nTu9/f2PYwaDzWZduNCYnCwEgMHB4eFh8xpAT8/v1EPOnTvJ4cRFn/T7SXqNENqEkZDw8fnzJ6nHdXf/uq5VMAAAIQgG12dtSoqYWigU+RiGbc6INn0NoKHhcwCIRCK3bv3k8/mjdxQUZAkEPACwWHCVajeGMShGb2//urtevybb2rQIIQBoaPhiTZAlkl1Op9vhmPP7SRyfrqraw2S+YTMYjORkgcEwhhCanZ0HQJTeYsGjY766Gr5x48epqRkA2L+/7OjR2vVZpFDkj4xYPB6vy+V2OIiKihKakZGRKhYLzOY/w+Fw9JOj66O9XWs0mqnKuHixia75twA2m6VUyg2GMZIMEIRzYmKqrKyIDnhWVrparRIK+Xx+Uk5OplSaOjMzT9egSMRvb+8BAD4/UaM5KxAkbdgqCMKp0bS/fLkEAAIBr6npq/JyRcx4RvfdU6e+tNtnHY65lpavZTLJFs1ucdF9/foPdvsc9VlYmFNXV6NUyuPi2PSeYDBkMll1uvsE4aR7Ysx+hcUcW0KhFa32t4cPH1MpAQBsNjszM00oTAIAt3t5eppYWaEPYgBoIwa2yVw0OTmj0903m/+gMe9mvUKRX1SUp9P1Rf+j3hdAR2VoaNRqxWdn55eWvBiG8XiJUmmqXJ67b58yNTUZAPR6Q2fnPYrR0lJ/8GDFNgDvKTSDy43Xar+j9awPNT2o1SoGg3H3bm9l5e7tuej/0XGnAf8A5vogSY77MGUAAAAASUVORK5CYII="
    m["light_bg_film"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACLklEQVR42mP8/v03Ay0BEwONwdC3gAWZc/78tbVrd9279+Tnz59kmMXJya6mphgW5qmhoQQXZIRH8r59J6ZNW/b//38KnczMzFRSkmxmpofigx8/fs6bt/b////MzEz6+hocHOzHjp1nYGAQERFUU1PAY9ytWw/evHnPwMBgZWX45cu3y5dv/f37b+bMFYaGWqysLAgLHjx4+v37DwYGhrAwr5AQdwYGhmPHchkYGNTUFIuLE/FY0Ns7H2JBcXESAwPDokUbNm7c++HD5/v3H6upKSIi+f37jxCGtLQYJeGjqioPYUBspWMq+vbtBwPDfwYGxp6eeeQZFByci8T7/+3bDxQfvHz5loGBkXruZnz16h2KD+TlJSEMNTVFEREBBgYGSCoiHlhZGUKC/tatBwwMDHJyEigWMDFBveLn52hpaQhPRcQDSCo6fvw8JJDhBo4WdiOnuP737x+EsWnTflITKKxQmodcQsANhFrw8OFzWOl4/9YtclyK5qxHj16gBJG4uDADw3/qBcx/MTEhFB9wcXFAioqSkiRIRkMtWwiDtWsnI2U0Ri4uDvqmImFhAQjj9u2HlBj35MlLCENQkB8liBQUZAQEeD98+Lxx497795/w8HDB4xySPPBUmfBU9OPHzwsXbjAwMHBzcygpyaJX+qdPX+7unvP37z9KS2pGxpycaAcHc3QLGBgYbt68v3Ll9lu37n3/TmazRVFRNiTEXV9fA0uzZbQsGigLAOI+2+GcKV4VAAAAAElFTkSuQmCC"
    m["light_bg_finish"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABqUlEQVR42mP8/v03Ay0BEwONwdC3gAWNf+LEhYkTF6mrK7m7WzMwMHz9+uPlyzcKClJMTEwMDAwvXrxlYGCQkBBmYGD49+/fgwfPxMVFuLk5IHrZ2NgMDDSZmVEczYgWyYWFrY8evSDbvSEh7pGRPviC6Nu3n5QEyLNnr4iNg5KSpJKSJAhbTU2xpCTJ19cRwvX1dSwpSVJTU0RWycjISFokW1oaWloaQtgiIoKWlobq6lAT1dUVLS0NRUQEMVUOQCpCj+TExMpPn76QbZy6umJbWxE+H/z8SVEkv3//mUAQcXFxQhhWVoZWVog4sLIyhMeqmpqilRUiDpBVysqKEbCAmZkZwiguTiouRqSi4uIkPz9oKvLzcywuRqQiiEpIKmJnZx/oogIOenvnwdm3bt3v7Z339u0HCHfz5v3Hjp2/desBssr///+TZsGxY+fh7Ddv3r958x7OvXnzPi6VjIxMBIIIHnU4wH8Ghv+45NjZ2W1sDAn4QEhIAMJYu3byaIUzasGoBUPVAmlpMQYGBikpMVpVmX///rt48Yaysiw/Py9NLBh6cQAAbhWHsExAygEAAAAASUVORK5CYII="
    m["light_bg_flag"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABYklEQVR42mP8/v03Ay0BEwONwdC3gAWNf+LEhYkTF6mrK7m7WxNvipaWCj8/L1YpRrRILixsffToBanOlJISmzy5lqgg+vePnHD4h1sbehDJyUk9efKCgYGhpCQJv6F//vydOXPl9+8/GBgYEhKCiLUADiwtDfFbsH79bojpFhYGpqa6VE5Fr1+/W716JwMDAycne1JSEPWT6Zw5a37+/MnAwBAV5SssLEh9C65du8PAwMDMzGRlZUiTjObj48DAwPD3779FizbSxIKgIDdpaXEGBoaDB09dunST+hawsrKkp0cwMjIyMDDMmrXy16/fxCbTX79+Qhi9vfMIWsPBwf79+4/nz1+vW7crIsKbKAseP34JYRw7dp54D23ZcgCXBehBJCjIR2pwMTMz2dgYERtEQkICEMbatZNHK5xRC0YtGKoWSEuLQZoh1LIAvV309++/ixdvKCvL4mpIUWrB0IsDAGi+cQzXr50dAAAAAElFTkSuQmCC"
    m["light_bg_folder"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABbklEQVR42mP8/v03Ay0BEwONwagFBAELMuf06cunTl388eMXhjJGKysDS0tDiixYvnzLmjU7cak7efICLy+Pjo4qmUH06tW7tWt34VH39++/3t55r1+/I9MHDx48/v//PwMDQ0pKmKenLZqiefPWbN168NOnL52dc4KDXfEYx87OrqWlzMHBjm7B37//IAwBAR5MbXFxgQ8ePL169c79+497eubhdzIfH09pabKWlgoJqYiFhbm4OElERJAYxZ8+fenpmffjx08sqQgP4Ofn7ewsuX79Ln5lJ05cPHLk7MePn2/cuGdgoEmCBQwMDAICfMSk1CNHzjIwMHz//mO0qBi1YNSCUQvItuDfv/+UGPfv3z/sFQ68KF62bPOJExfItuDu3ccQhqioMIoFKiryWloq167defHizYsXbygMFm1tVWVlWWhzAd50/Pr12/z5606cuPD9+0+yjebkZLeyMkxICOLi4kS3YDSZDpQFAME3h9BZOGUzAAAAAElFTkSuQmCC"
    m["light_bg_gamepad"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADY0lEQVR42u2VXUhTYRjH/2ezzXPOQpuunMmJrJalbmhhqEUUQQOjvGiROKqLILroS4OSpBtXEjWxm5K+ECQsBEOSgoyi6ENd046tnLOja7aVSy1pZ6flNrs462tZFNVF5Ht3nvd5n9//ed7neQ8hCGP4m0uCv7wmAZOAfwAQE/XtdHosFtbt9oZCoV8LFCOdOTMpJ0fLMOov7cSnSfb5+JMnL7S2PvwdvQRB5OVlb9u2gaaprwA+H3/gQPXz5y//SFkYJslk2iMyIoCjR8+K2hkmyWgszMzUCMI7jhvQ6dKk0u/ek9s9yHGuxYszKIp8/36MZe11dU1u9yCA/PxFJSVbIgCn01NaWgmAYdSHDpVQVCyAHTsqPB6vwaDfuLFgwugtLfdqauoBUBRZVbVfpVIC4HmhrMzsdg8SBFFVVcYwagkAi4UVzxiN6ygqdnT07f37nR6PFwDL9litj0Oh8LeAu3etNB0rlUr9fqGzs1s00jRpNK4FMD4+brF0RdpUjAUgI2MegPLy6mPHzokWh6P/8OGahoar3wJSUtR+f0AmkwF48ODRiRP1LtcLAJmZ8z8W0Btp02AwIlAul/38TRYXr4mPn9rb67Tb+2w2B4CODtvp0yaSlIsOY2PBCeYAgMm0+8mTp2ISGs3slStzu7ufms3notxkMpnBoNfrl27evF+pjAcwMvKG5/0KBR09aDExkT4RhABJyuPipubmZiUnT/d4vOnpc5ubb3yvffv6nlVW7tXp0ljWDkCnW6BQ0DwvfFQwJQJgmGTR1Nr6cMWKJZ/y4LiBO3c6fjAcLtfLM2caysu3d3U5AGi1GjGIuDtrljoCyM/Pqq9vDoXCtbWNM2YkLFw4F4BCQTsc/bdutQFITJxmNu/7Mnefjy8tPTI09PrmzTaVSmkw6CUSCQCbrbe29pL4cuTlZX0etPPnLzc2XhMPz5nDJCTEcdzA8PAb0bWiYpdGMztKfk9P/8GDx4PBkKggNTVleHiU41zi7vr1q4uK1nwGhMPhU6cutrTci4pCkvKdOzfl5GgnLFF7O1tdXRcIBKLsev2yrVsNBEF89dgBYFn7lSu37XbO73+nUimzs9MLC1clJsb/oFlfvRpparputXYPDY1QFJmWllpQsFyrnT/Bazr5R5sE/L+AD4sAZ4yHHYvIAAAAAElFTkSuQmCC"
    m["light_bg_gauge"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADNUlEQVR42u2WSUgbURjHvyxmT42SWmMYbWK0gkZxgbi00BoQpS5UCC6gF4sYKb2IOVYvnip4UKgHtXooNEqgIDQSMShKtYpClBqMSiwucYm10bhOzPTwrMY4SYTiqb7TN2/+7/t98+b/vRnK8TEOdzmocMfjHhBw0G8jstl2zObljY1tp/MQAPh8XkREWFycVCR6+E+AszN8cPCbwTC2trZJKoiMFOXkPFMq0xmMIF9JKL5sOjk529HRt7v7O2CNQmFIdXVJamr8bQEEQfT0fOnvN6JLBiMoPT0pJSVeKsUEAj4A7O0dWK2r09M/JiZMOI4DAIVCKSzMrqgoolAoAQAEQbS1fRoe/o6W5eY+VanygoP5pNU5HPta7YDBMEYQBAAolelqdbkXwxvQ26vXar8CAJfLqqurSkqK87M5DsfB8vIqALS0dB8dHQNAaelLlSrXp00tFmtf3wAAsNnMxsa3gbLvazTvm5o+WCzWhoY3bDYT1be4uEIOIAiis1PndrsBoLa2XCrF/GR3uc6bmz/a7XtooUwWqVaXAYDb7e7q0pEDZmcXlpZ+AkBamjwzM8W/c7q7dfPzSwAgkYiLi3MAICsrFRnJYlmZm7OQAIaGJlBQUpLnP/vIyKRePwoAPB5Xo3nNZDLQ/OXuG43j3gCCIEwmM+od/5tjta61t38GABqNWl9fFRYmvLwVE/NYLH4EADMzZuSrq0622XacziMAkMuf+Eo9NTVnNI6bTAtnZzgAVFa+SkiI8dIkJsaur285nYebm7sikfAKsLVlRwGGiUiz6/WjHR29HsVG5ec/vynDsHAUbG/bEeBii05OTlHA47FJATrdgOflzs4eqYzL5aDg9PT02jugUmkowHEXmSldDofTc2Z/3+lynd9U4vi5V8ILQEjIg7+l/SI5cul0iUTsOSOVYnQ67abycnloaPA1AIaFU6lU5GLSZ1ery9BJBwACAb+mppRUhpbTaFRkp6uXzGazoqMjFxev9YjnkEiw1tZ36K5cHsvhsEhlqPtksqjL5rhqtKKibCaTkZGR7MumHA5LoUhUKBJ9ZQeAjIxkJpNRUPAi8Afn/q/iHvAfAf4A8tU3LA5Pv7MAAAAASUVORK5CYII="
    m["light_bg_gem"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAELUlEQVR42u1Wa0yTVxh+TvvRi3Ip5abMbWh1QJENBBrkIsYsocRkibPA4jALIGHRRucUoiZGYvilSwwwSIwDjZlkEjISfmw0biKWpoSWESgNMMZKuhYszFYuy8dnabsf36gVKqLBLEt2fp1zvud733Oe87wXQtNOvMnBwRse/30HlN9drba/ru4OwzDrtMLn85XKIxkZe9Z1g+npP+vrX8E6AIZhGhqabbbHqz+RFSpyu90XL9aMjPwOICFhl1Ao0OuHAI9IFCyVSryw4eFxh2MOIKmpCTTNGI1jAGJjt1dXf8HhcNaiqK3tHms9Lm5HVZWyq0un1xsAFBTk5eZmeWEdHeobN1oAz969yTk5aZcu1RqNv42Omtra7h0+nPtCikymP1pafgQgFPKVyqMcDkevHwJACElNTfBFymSJhBAAOp2BEKJUfioUCgDcvfvD2NiEfwdPnzpra28vLbkAlJbmb90a7nQuDQwMA4iJeSssLNT3N7FYFBMTDWBgYNjpXIqMDC8tVQBwudw1NbdpmvFDUV3dt2bzIwA7d74rEPC02v7JyWkWKhaHaLX9K8gUi0Umk5Wmmfb2n6OjIwUCXmzs9tFR09TUTEND85kzxc89cnd337VrtzZQ/qdPf5aVlfqMIkI2POLIcxRlZiYbjZkqlQZAcHBQUdFHmzbx7fa5pqZWABLJO4cOfbhKbz+Nj5sBlJQoxOJgmmaam9sdjnkAubmZWVkpK9+grKxwYWFRo+mbm5vv7OypqlJSFKVSqa1Wm8ViS0qSCoV8L3hxkamvvwMgOjri4MEcl8t9+fLXrHWZ7IOyskI/KmLVJpG8zcbRzZvfA8jJSWMDVacz+B6/t3eQff/9+9MBNDW1Dg2NsXo7deooq2A/ccDjBVRUHAsJCWJDSaXq3rcvjUU/eNDri2SXhJDs7D337/d0dKgBBAZurqwsEwj4a+WiiAhxZeUxiuICaGxstdkex8dLAAwOjtjtT1iMwzFrMPwKQCqV2O1z169/B4DL5VZUlEZFhb082cXF7Sgv/wSAy+W6erUxOVkKwOPxaDS/sAC1us/tdgNISUm4cuWb5dhU7N69a7314MCBdLk8G8DCwl9qtY7HCwDQ1fUPS+wkICBAre6bnZ0HIJdn+2aqdRWckhJFYuJ7AMzmqcDAzQBMJuvExKTZ/GhiwgpAJAoymSwA4uMlxcUfv3JF43I5Z8+WbNkSDsDL/sOHvZ2dPex8Zsbu82bUC+Nt7a7CYrGdO/cVTS9688+yPw9AhEJ+dfWXbNZ7zZq8bVvUyZPPdG23P1m+DSGEHD9+ZG3r6yr6Mtn7hYV5q/cLCvL8FuHX6SoUCnlGRpLPhic9PSk/X75hbQsh5MSJotDQYHYZGhqiVBb55oMN6IsEAv6FC59TFIeiOOfPl/smvpcc7v/e9F938Df2gKKnwC1NUgAAAABJRU5ErkJggg=="
    m["light_bg_gift"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACOUlEQVR42mP8/v03Ay0BEwONwagFA28BCx65Fy/eLFu25dWrtxISIg4OZgYGmnCp8+evHThw6uXLt2JiwtHRvuLiwrgMYcSVTD9//pKZ2fD9+0+4iKurVUpKGAMDw+zZq/bsOQYX5+TkmDGjgYeHmzQfHD58DmK6mJjI69dv////v3v3MTY21v///0NMZ2RkFBUVfPXq3ffvP44cOefhYUtaHDAyMkIYAQHObW2FAgK8DAwMW7ce3LbtEAMDg4AAX1tbkb+/C5piAkH09++/W7fuf/jwiYGB4fXr94sWbfj//z8DAwMfHw8HB9urV+/gKsXEhH78+PXp0xeI6XFxAaKiggwMDMLCgioqckxMTFgs+P79R0PDlDt3HlKYbDQ1lWtrs9jZ2dCDaNu2g5SbzsDAcP363R07DmOJ5IcPn0MYJSVJmNq+fPl++fKto0fPMjAwWFsb6+qq8fBwYirr6ZnHwMBw795jLBZAgpuBgcHS0hCr03h4OCEWWFrq41IDAf/+/R+InCwszA9hBAfn4tcDCQc8AG4Uig/c3Gw4OdkpdzIbG6uzsxX2fPD06auOjpnPnr1iYGCwskIP5bdvP9y8eZ+BgUFdXVFYWABN9tix8wwMDFJS4qWlKXJyEtiLCmlpMQUFGYgFxcXoaen48fMQC3x9HTEj+dixXAYGBgUFaWTTRyucUQtoWyfjyc8EczI+H3ByslHiXg4OVgI+CAlx//fv/8+fv8gwnZ2dLTTUg9hWxWgqggEA5JLQm61pJqAAAAAASUVORK5CYII="
    m["light_bg_globe"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAE0ElEQVR42tVWXUxTZxh+2nOOKFBa1tJWQENhKCqCbC0Kir3AeEi2qDGwjWSTkAheGbzrjcG7LeCVeOMPk0RNMM0WZ5ZFpZtJw59rGZ2CRHCO6obQ9lT6J0XP6WEXHzu0HaIkerH36vt5z/t8533f5/k+WTTK432aHO/Z6Lf0C4cjfn9obOwRINu27UO1WpmenvYOAKanObvd4XTed7unkrYMhhyTqcRsLtfrNStEkL2uBsFgyGq9ZbMNxGKxFb6nKIpld9fW1iiVilUAjI9PtrdfDATCZJqauk6nU09O/i05FBRsmJ7m5uaiZKpSZVgsRzdtMrxVkQcGhk+d6iDRtVrNiRMNXV3fpKSsAbBmDcMwDICUlJSurq9bWhq02g8ABAKh1taOwUHXm2swPj7Z0XGF5wUANTVVjY2HaZoOBsMTE24AJSVFohgbHh57+PDPaHR+715jRcWOS5e+6+np53nhzJnLarUq6T/kiXkPt7dfJNEbGg41NX1G0zQAl2tMFEUARmOx0bgdgCiKLtdDAAxDHzv2xZEjhwDwvNDW1hkKRV4LYLXeJJmprq48cKBaWn/69BkZFBcXFhdvImO3e6kkBw9Ws2wVyZXVemt5gOlpzmYbAKDTaZqb6+Kdpqa8AGia0mrVOp2aoihpUbLGxsOkHjZbn8fjXwbAbneQjqyv/4RkJg7AA0Cvz6IoOU1TOp0awLNnnngfhqHr6z8FIAgxu92xDIDDcZ90ZEXFjqTKc9wsAIlQ69dnAfD5ZpPcKis/SktbK4VKAAiHI0+eTAEoK9uadHxBEEjZU1PXkpV169YC4Hk+FhMTOpKmSku3AnC7pyKRFwltynHBReLJkNTOL18uMjEQCJOtYHCRgL29TsKPJd7KZAAWFhY4LkjEapHJN2/2dnZa36GINjd/zrJ7llIkl8ver1xv3rxIvz17Pt61qzQpRWfPXgFQUrJ5//7dAG7f7hsZmQBw/PiXSSkaHLzX3/8bgKKi/AQAtVpJBgsLqKgoSyoyAVCpFGTr7t17ZKuqykRR8kQd+51UQgq4uK1QpOfl5RBVEAQhsTdohqEBzM3Nk5VodB4AwzBJ0XlecLnGAOTn50rX0ZJHeXkJgLm5KDlFvGk0mQBmZrh/Oe8DkJWV+V8ZJtgm0/ZliGY2lxMN6O7+kTS+ZNnZWgAzM75YTBSEGFGC7GxdvM+rV3x390+EDWazaRkAvV7DsrsBeL3PL1y4Fv9xbq6OaIDX6/d4/ERRcnK08T5dXd/7fM8BsGyVVqtZXk1ra2tUqgwAd+78euPGL9L6xo3ZZDA6+mh0dIKM8/JyJYfr13/u6ekHkJmZUVfHvlaulUqFxXKUlPTy5R/On79GcmU0FsvlcgBDQyNO5wgAuVxeVlZEMnPuXPfVqzdI2S2WJoUiPeHSPnmyNX6uVmfm5OiczhFRFB8//stud2ZkpBsMuaOjjzhuluNmvd7noihu2VKwb19lb+/Q6dPfEk4wDNPS8lVp6Za3uvQnJibb2joDgZCkbnq9Jv7SNxg2zMz4SM+QzFgsTYWFeat4toRCEav1ls3WJwgrPVtommLZqro6NikzbwYg5vH47XaHw3E//vjST+zcud1sNsX3zKoBJItEXvj9wQcP/gCwqqej7H//uv4HOfoTLUjMkNIAAAAASUVORK5CYII="
    m["light_bg_hash"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAByklEQVR42mP8/v03Ay0BEwONwbC34OPHT7m5Tbm5TR8/fsKq4OTJSzExJdOmLSfTgosXbz579vrZs9e3bj3EquDAgZPfv/88dOg0mRa8fPkGwhAREcCjQFiYn0wLXr9+B2GIigphVfDq1VsGBgYxMWEyLXj16h0DAwMnJzsPDzem7JcvX79//8nAwCAqSpkFYmIieGQZGBhERQVxmcCCxr9//8mLF6/h3Ddv3jMwMDAxMRw/fh5T8507jyCM9+8/wRWwsbEZGGgyM0OdzohcVNy//7S0tPP///8Upv3QUI+ICG86ZTRGtMIOOYguX769c+dhBgaGgAAXFRU5TM1r1+68f/8pMzNzYWE8XBAtiNDjQFFRRlFRBsJ+8uQFhGFjY6SoKItpwerVOyAxbGlpSE4qojwTELCA8kxAlAWUZAKUOPj799+FC9d//fpFSSaQkBCFRyF6KlqxYisk0ihKlIyM3d3liorS9KtwED5ACyLyMgFmECHigJmZydhYG86lSibAF0RUyQT4LKBKJiBsAYWZAJ8F7959ZGBgEBfH7sC3bz9AGLgUELbAzs6Uk5PdwcEcq6yamoKUlJiUlJi+vgZpxfVo05H+FgAAwjzs+S2o6wkAAAAASUVORK5CYII="
    m["light_bg_history"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD+UlEQVR42u1WX2xSZxQ/94JAmw1rS0pbVtA9dH0Q7dqGxoIxmcUlW1rAaxzW0vli0yzp0pAlS6ZvJiZLJDU+NBizLa4UyZIKpW6JlmliLZFgUSAmupdiLR2tYLF9uKVwv7uHr7mhyAU1McuS/R4I9+N858f59zuXoOksvE+Q8J7x3ycQ5j+Mjl7z++eGhvo7OvZxhy9evJydDUUiTxcXE+n0OkGAVPphY2O9Wt108GC7TFZVmoDIL/KxY9+yLKvVtlmtp7Brh8Pr9z9ECBUPnyR1utaTJw0laLZFwLIs9zkz8+DyZRdNZ7bshAKVqqGmZhcApFKrsdgSwzAIobt3HwSD0cFBs07XXp6Ag9vtGx/3YiaVqsFo7NJo9kkkYs6ApjOBwKPJSd/CQoKmMxcv/rq6utbd/VmZFFHUEAAoFPJ4fBlnwGz+0mTqIsnivcAwyOOZdrn+QAgRBDE83P96HEVuYu9CocBqPUVRRzjvDIOczhtO5w2G2SqJQEBS1OfDw1+TJMmyrN3uSibTb9qmuRxz4cLPFDXU2/tdIBABgHD4ycTEzYmJm+Hwk3xLrbbVbP4C583hmCxFQBDE60yZTCYUeoy/cCcFNkajXqmsA4DZ2VAy+ZK3yAbDYb8/pFDIKyok3KFYLKIofelmFwhIo1F/6dIYQmhmJmQydRUnsFgMFovh3SZWo9kvFDpzOSYa/SufYFuK0um1ubnHXA3fChUVYpWqAQCeP/+btwZnzoycP293uX5/tyDwGK6trfMSLC+nAGBpaYVHGLZa4OpVT0EjbZcD/i6SSj8AgFQqXfRmc/PHtbUyrFHnzo3a7ddoeiPfAF/ETooTNDbWAUAsFt/cLLLmdu6U2mzf6/WdBEGwLDs97bdaf3z1aishGxuZhYUlAFAq63kJ1OpPACCbzQaD0aJBVFZKBgdPnD37jUy2CwBWVpLz83H8UzAYzWZzAKBWN/ES6HRteNbc7mm2IJd5aGlpHhn5wWTSU9QR7A4h5Hb78KhqtZ/yEtTVyTo69gPA/Pzi1NTtEg1TWSnp6+vp7e0WCEgA8HpvP3sWB4DOzlZcJ14t6u83isViAHA4vFiCyuL+/Ufj41N4FPr6esqInVxeMzBwHGunzfaT1/tniVwhhDwen832C155AwNf1dZWl9oHHK5fv4X/FADs2fPR0aP69na1SLQjTwE3g8GIx+PDRSYIwmIxGAyHyyycfNy5E7hy5bdMZhM/ikQ7du9WVFdX4X6PxeLZbJYTidOnjx86pCm/9AuQSCTHxiYDgTBflgiCOHCgxWLpKSjsmxJwNPfuzUUiT+PxRDq9DgBVVVKlsn7v3iadrk0ur3mL15b/Xx3/FYJ/AM8Lvr3A6fdhAAAAAElFTkSuQmCC"
    m["light_bg_hourglass"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADWElEQVR42tVWXUhTYRh+zs60/UD5Q6RUpkw7lRGTIIooS41ZM1cuQh2RSEnlTd0oYhRdeeFFdKFIoCj+DbQfzeVGYquMRaGTzJ+ma6ZFdqEz0c50nnO6+EjMzNpRCd+77+99X57ned/vpVjWi9U0CVbZpIvuchzf2dk7NPQFQEhI8BLvR0ZGAYSFharVO2la8q8B6uqa6+rMPmV65owmLS3pP0BELUoyx/FW6+vi4moA27dHJCcfXfRxY+NTh8MFIDvbEBu7zweIaFoSH7/fYnnudA739w8qlYo9e5gFd96+fd/fPwhApdoaF7dfjIoIpoIgFBaWdnT0zD/q6OgpLCwVBAFAevrJJZzQ16/f+NNZaOhGlvU4HINe72xbWzsAhongeb6+3lJSYvR6vQB0ujiN5pDPHMyZIAi1tU337z8hyW7evAnA589fAVAUlZJyLC0tiaIo8QGI2Wz2oqJqlp2e25HL12VnGw4ciFmBSp6aYnt7ndPTv+Th8cy8efNucnJKpEznrKvLcedOhds9QZZRUeEAiHgABAauv3o1Y/fuKJEB7PaegoK7HMcBCA4OyMg4TTCx2ezl5Q9GR8cB0DSdl5cVE7PL5wAzM94rV2653d8AHD9+yGDQyeXr5k5ZdrqqqsFsfgEgMHBDcfFNf38/3zhwOoeId632yIULZ+d7JyRfvHhWq40F4HZ/czqHxJPM88ISIhbZrgGoVGFBQQFjY+PNzc94nj93Llkul82DyFNZ2WixvAAQFBSgUoWJIbmzs6+goGR2liNezp/XHTy4F8DLl+0VFQ1jY+MApFI6L++SWr1DpEy7uwdu3y4nZACIjNwGYGDg40+Zbrh2LSM6OnJZlfz9u8doNJnNzzmOn99uExMPp6ZqFQrZcitZoZAxTPgCFfr7+zFM+F+9/1Ozq65+9PBhCxHMli0hAD59GiHN7tSpBIPh5LKaXVnZPZPJCkAikaSmntDpEgA0NLQYjY95nidVkpmpFwlRe3s38a5UyvLzL+v1GqmUlkppvV6Tn39ZqZQBMJmsC/4iHwLU1poIFLm5WQuEqFbvyMnJIuDU1DSJmYus1tcu1zD5xSYmJm02++/XGCair++DyzXc2vrqT5/+4hwYjaa1Pxet1OhIrfnp+gfpgoqyBTz4fAAAAABJRU5ErkJggg=="
    m["light_bg_idcard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC3ElEQVR42mP8/v03Ay0BEwONwagFBAELnPX///9Tpy5evXr3/fuPZBsnKiqop6dpYKABF2GEpKI/f/52dc0+e/YqVVzt5GSelRXNyMiICKL163dTy3QGBoZ9+05u334YJYiOHDnLwMDAz8/b3FwgLS1GttF37jxqaJj8/fuPffuOeXnZIXzw7NkrBgYGTU1lSkxnYGBQUZHT19dgYGB4+PA5ig/+/fvHwMDAxISSqP78+fv48bN37z7JyoqLiYkQmy6ZmOAGoqQiNHD79oMpU5Y+efICwrW2Ns7IiODi4iA/mSKDjx8/d3TM/vDhE1zk6NGzDAwMRUUJDAwMx4+fnzRp8a9f6IWYg4N5bm4MURntyJGzENPt7ExycmKkpcUhdkAEz569imk6AwPD8eMXiPXBo0fQKEpLC+fk5Pj37/+0aUsZGBgePHhmYMAXEuLx/z/Dr1+/UDUxWlsbEmuBsLAAhHH27BVjY52LF28gi0tIiGAGBWlxYGysvXr1jn///vX3L4QLSkuLQxLx37//zp+/9vs3IpQ0NZUFBPhIsEBeXlpbW/Xy5ZtwEWZmRg8PO0gSXLFi67p1u5DVS0iITJ1aT2xp+v///97e+cimMzAw/P37f968NZC0RGky3b//5KlTFxkYGPj4ePz8nERFBS9evLF//6n///9Pn75CV1c9IsJbXV0RLYhIsGDXriMMDAwsLMyNjflychIMDAw2NiZiYsIrVmz7/v3HoUNnfHwcTEx0yK9wHjx4ysDAoK2tBjEdAry87CGM+/efkFOjIRcgkLSorCyLrI6bm0tCQoSBgUFIiB+/iWjFGjSIZGUlHz58evHijbt3H7W2Ft69+9jAQBNNJy5xZPD06ctr1+4wMDDIyIij1Gjbth2cO3cNFaviqCjf4GA3RBB5eto5OppTy3QTE92AABcUH0DAhQs3Lly4/vbte7KNFhTk19FRNTPTQ6/0Rxtew9kCALHwHzNNl2DLAAAAAElFTkSuQmCC"
    m["light_bg_image"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC30lEQVR42u2WT0gbQRTG32w2Rq20/kk1GtFaJIpatG2oiXoJGui5B0URlIKHoJUqBHIQ0SD0EAJiD7k14MWTvWkaJSABGyiCaNDSCF1j4hqCNNZWgnaz08O06xJjbEykFPpOMx+z329n9703g6LRH3CTQcENx78PoOPmPM8Hg+GDgxDP49TelEKVleUKhTwZwO9nZ2Zmd3f3r/2+tbX3R0b65PJCQUFCFp2cREdHXx0eRtL8JmVlxVarKStLGr+DlZUPxF2jaWppaaKo1H4Pz/NO5+rW1g7Lht3utY4ObTyAYQJkMDTUm5MjEz8JAH/Ca2ys7eszAYDP9zkB4PT0DAAQQoJ7IBCy299ub+8AQEODqr//WXl5SRJAXt4tMohGzy7NIiGOj79PTr6ORI7JdH19m2ECVqspP/92ZurA4XAT9/r66rq6agA4Ovq2vPw+3ToQYm/vAABoWjIx8QJj6OkZ5bjYNTL4UkBRUT4AcFxscdGNMc9xMUHMDKC19ZHD4eZ53m6fJ4pEQrW1Pc5YL6qpqersfCpMZTLZwECXSnUvYwCWDTudq+IeoNM9ES9gmIBQOikDWDY8Pj4TiXwVSmxj46PF8objOLLA5fIYjRaj0eJyeVIGiN3V6gdWq6mg4A4ArK15CcPl8thscxhjjLHNNpeccRGAxe5G4/OKilKzeVhgmExW4o4QQghdyYgDYIxB7E7TNGmQAoNhgsTdYOg2GLqvZJynaTR6CoDIWOwuNGGzeZhsjri3t/9qZ2RDNtvcFYD9/dBl7gJjaurl/Pw7tbqhubmJiASThHHuolDcDYe/AIDB0HXR/fca+eBgb5woZhAlO1uaAKDVPtzc/AQA09Ozen1LSgdObm62Xq9dWvIAYACgKEkCgE7XvLCwEgyGvF6f1+tL59SMxWIJskgqpcfGDCpVVTrWJSWFGk2juMegi1fHUOjQ7w9e49qiVJYqlcUIIbGO/t9N/zrgJ9fdWya+pK+4AAAAAElFTkSuQmCC"
    m["light_bg_key"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC40lEQVR42u2WTUjbYBjHnzSRGRWk07qmdp2C8zApG7UUW3C0yAZCdxBPw506NhB0MGn1UhIoHmQDHYrehAndQQ/DXbbDKHqp6GhVhq2iHVNYrfYrTa0L64fZIUxr/ZjN6mCwnB6SP//fm//7vs/7Iiybgst8RHDJzz8F2NkJj47aFxY+Z79ECjUH29tBkhymaQbHi+32lwX+g0N3AFCpGgocUSAQoqiRX+63ursfFRIQCIRIcjgajfHuvb1PioqwbAFWqGTUaqXFYsIwrGCrKNtdJBJ1dDw46S4c4PcfuQPAwcGBzTbq9wcLA/D7gxR1lIxarQQAmmYoajgQCP8pINu9tva6xWKyWEyHjOnpjzl61GolT7okkym32+NwzM3OflpZWQ+F6IqKchwvznYHAIbZk0iu1tXd0Gpv7+5GQqFIW9u96uprv9nJTqd7YmI6EokdW20Y2tysXlpajcXi/Ng3N79xHIcgiNlsamq6c9FeNDX1YXDwdY47AKTTmZmZBd5drVYODPR0dj5EEITjuMXF1XMixXLGPjn5HgBQVGQ06g0GLUFU7u3tu1weu/1dIvEdAMTicn69t7RoS0txl2ulvf3+OYCjiJLJVFeXLRKJoaior+9pY+OxlhIMhnt6XrAsCwA227OGhpt5t+vl5VU+GaNRn+MOAFVVlSTZydcOx7yQ82Bt7Qtf6PXaU6X19bVyuRQAvF6fEABNx/mCICrPUkulEgDgpzpvQEkJzheJxP5Zav4TjhcLASgUMr5wuTynShkm7vNtAUBNTbUQgEajxDCU3woMkxsCx3Hj42/T6QwA6HQqIQCxuLy19S4ARKMxq/XV+vrX7LEPDU04nW4AIAiJwaC5OOBYq0gmUxQ1cmgtl0tlsqp4PLGxsZXJZAAAx6/09z/PK6LcXsSyP8bG3szNLZ2UEoTEbH6cl/uZ1xaPZ8PhmPd6fTTNlJWVKBQynU5lMGhOPbOEAP7fTf8m4Ccu22FCuC1tYgAAAABJRU5ErkJggg=="
    m["light_bg_keyboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACkUlEQVR42u2WTUgbURSFT8bY2ARqKzEYG5UQKloyakUNuJJCKS3FTQQx2L1WAy5MhRI3IgVrwVJUcF8s3biym25cKYo/SKjQgMxj0JlAEhsnEodJ4qSLsYmpicZE6ca7u/MO53s/915GJYox3GRQuOG4Bfx/gPqfPBQSGGY/Go3m46VWV1UZKyr0mQHB4O+ZmXmPx1vgltvbn/T19eh0d5VUpfTB8bE4NPT+4ODwWq6lpqZyYsJVXKxOnWB+/rvibrU+6uiwlZTcycNXkqKLi0uEcCzLLyz86O5+mQLs7HgBlJeXud1vFHJ+0dpKO53jgnC0vu5RAKdVxHF+ABZLdSHuAHQ6bX29BQDL+tLKVJYTAChKBUAQwk7n2ODg2OFhGMDamqe3d3h6+ouinJ396nAMr65un1eeOlIUAFmWs/YBITzPB3y+AMPsA9ja2hFFSXEEsLKyJUnS5ubP88qc+gAATdfa7c+BRGNjHQC7/Zksn7S0WJVVp/P1xoanq+vFeWWugKIiyuF4lUwNBv3AQG8ytdkabLaGjMorjApC9gnZy/1tL9BnfAPO5frgck0yzF5u7hfpLylKQQi73Z94PpBxtbKyfHx86GrDDoDZ/HBy8i2QMJurtrd/ZXMHwPMBQvimprqkPiuAolQnJ4l4XP7LMJ2tKJ/PnxFgNBpouvasPtkBSjekANXVRkI4r5eJRI51Om22iro0otHY7i4LwGQypAHa2hoJ4QThaHT0c2fnU42mOI85IYrS0tJaMBgCQNN1aeM6FouPjHxkWe5axrVe/2Bq6p1WW5ICAIhExLm5b8vLmwW6Nzc/7u/vKSu7n3aCZPj9QZb1xePxPKw1Go3FYiotvXf2o+r2z+4WUHD8AclzK/tn+rIjAAAAAElFTkSuQmCC"
    m["light_bg_link"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD0ElEQVR42u1WTUxTWRQ+bS2lff19ef03YmaGiU7LQhgWkjKZiKaiCUNilZWTMY5B5yckaEK0WEmDQojBaE0cySTjwo1NRHckYlhASDB2mhmBMSOasLCFttdCyyuv7+k8ZnHHZ3lU+xPZzVnd3HPu992fc75zJQzzGjbTpLDJtukEW8peyfN8NJpIpdJarcZmM8lk0o9GkM2yw8Ojo6OT6TSNZ9RqVVPT7kOH3AShFAVLSn1khJb9/uuRSGyjy2Sizp8/ZbOZyidAaNnnuxqLIQDQ6TQuV53FQiGUHB8PLS2lAcBspi5f7lKpKsshyGbZ06f7FxcRADgc1V1d3xOECrsYJjs4+Fs4/BcAtLbuPXr0m3KyKJlMYXSns9rrPSmgA4BSWdnZecxg0ALA2NgUz/OCS9bd7SuSQKMhSFJfVWVvb29TKCpEXrl8C0LLc3PzLMs1Nn6p1apLyKJIJBYOz8ZiSCqVbd9u5zhuIwEAGI0kHtD0arFpmkqtDA0FHz36c21tTZisqJC3tu71ePaLcj8WS+CBsP0CBAglfb4Azplc47jXweBIJBLv7PxOmKTpzMREGAAMBq3FQhUmyEWvqrK1tTXv2PEJy3KPH88EgyM0vRoKzQjBLMsNDPxK0xkAcLtdEomkAEEuek3N52fPtguXfvDg17t2fXH37oP6eqeA3td3c3b2OQBs22ZtaWkqUGgILV+4cBVn5M6dn3q9p5RKxfsOitGnp5/hKvP7OyhK/yEtyq1Vp7P63LmTeRNGQO/vH8LoRiPZ0/OjCF1caAzD+v3XN6JPTf0RCNxeWEiIgvv6bj558jfee29vh8lEFVDTe/dGsYo5HOv2fu3abZZlQ6Fpj2d/fX2NQiF/+vTFnTsjL18uvr2ZnymKzHvKd2/A8/zx4950mtbpNIFAd64SDA7empz8Pe96q9XY0/PT+9DXnSAaTWB9d7nqctEBoKPj261bzffvP2RZ7t3WJJKGhtoTJzwajbqojray8l/3MJvFVymTSY8caT5w4KtQaHZ+PvLmzT9WK1Vb67RaqRJaJkEQePDqVTJvqFwuj0bjdrt5376Gcnqy3W5Sq1U0vTo+Hjp8uFmprBRl5KVLv8zMzAGAw/GZqG0V9auQyaR79uwGgKWl9JUrtxgmm6szFy/ewOgWC0WSuuJPsK6SMxnmzJmBeBwBgF6vbWysI0l9PI4mJsJYZ/LWagkEABCNxnt7b2xUUKwzXu8PJaHn16JMhhkefjA2NiX8SgwGrdvtamlp+oBslEAg1N3CQoJhsgShslioXAX+OAT/f37f2r9nqrnOwoH1HQAAAABJRU5ErkJggg=="
    m["light_bg_medal"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADwUlEQVR42t1WX0xTZxT/3T+kS1xAa4vpqkk7plItArErmQ2tCbXCNOHJaNVlJsZETNQHXhB8to8Go4TsbcscGgJv0GIbvL3UxkpLDKFUw0gjpGmVNrQaLKMtdw/faIhdi7fMl52n853znfO733fO+d2PSqcz+JJC4wtLKYBcbn1qajaV+lBsQyr1YWpqNpdbL5GELeEbHLQPDjoUCnlv722GoQvhe3ruRqNLZ860njt3qpwTrK1lAESjS37/dKHX75+ORpfy28oBOHHCQFEUAIfDU+i12ycAUBTV0nKsTACFQl5XdwDA9PTrhYXYZlck8nZmZg7AkSMHlcrq8ruora2ZKC6X55PPFwQBwMmTzdtqU52uTi6XAhgff55OrxJjOv2X2/0CgEy2S6fTbguApmmz+RhJOjERIEaen/z4MQ3AYjEUdpfoQbNYDBUVLAC7nSOWsTEPAJZlzOYftgxnt9xRWfm1Xl//7FlgYSFms/UDePMmAqCpqaGqqnK7VCEIwvj489nZ1xu9H/T7g0QPBv/kOB8pdQmhSpDd2lrmwYOHHk+gRLzRqLt27QK5Q3FXJAhCX98fJHtFBWs2G0wm3b59CgCLi1Gen3Q6vZlMluf9AG7e/Fn0CZ4+9d2//zuA3bt3dndfVamUudz648ejAM6e/ZFh6HA4YrP1JxJJANevXzx+vElEDbLZ3KNHI+Tbu7s7VColAJfLOzQ0NjQ05nJ5AajVylu3rrIsA2BgYKQYp/47QCg0H48vkx5Vqb4BkEy+Hx5+QrzDw0+SyfcEw2IxAIjHl0OheRE1CAbniNLcrOvt/TUQmFlZWc174/Hly5d7duz46uhRbVubcXSUJyFa7f7PPUEisfwPPsvwvD+fXSKRSCQSoq+srPK8P98/iURKxBURlgawZ49Mr6/P27u6rnR1Xckv9fr66mrZRoiYQZNKd+ZpubPzUmPjIbJ0uyfd7kmiNzYe6uy8FIm83QipEgGg1R7I8xrLsmr1XrLkOB/H+YiuVu9lWZbnX2yE7BcBoNHUyGS7ADid3nA4Eou9K9wTi70LhxedTi8AuVxaW1sjAoBhaKv1NIBMJmuz9dM0Qyrc3t7S3t5C6kzTzJ07v2SzOQBW66livF10kgVBuHfvN8IELMs0NGhaW421td8CePVq3uGYePkyRLKbTPobN34qh+wymWxf30OCUUxMJn1Hh7UE2VFbPh05zjcwMEIGe7PI5dLz508bjd+XT9eb31ih0HwwOEcGUCaTHj78nUZTQ9Nb/xCp//Xj9z+RvwH6sJSRVSZdrAAAAABJRU5ErkJggg=="
    m["light_bg_monitor"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABkklEQVR42u2WPWvCUBSGT0QnAxo/qNaA3sGhhSB1659o5w46dHI2WvsPbIniP+gQ/QHi6l5HnSLioEIS/Lg0UtM6REyHFEVqK/WDVsg7XS6c97l5Dzn3EtOpBoeUBQ6s4wdYFyuMxzxfFoS2orxubefxUJHIWTx+RZJ2Y4cwmozxmGWzqvq+l1N7PFQ+nzEYn1/A82XDHSHa7/dubd3ryZI0wFgplSqJxM0SIAhtAEAowHF3BEFsDdC0WTKZleVhvd5cabKRu99/sos7ANhs1lCIBgCMFfM/MAEmwAT8FuB2OwGg2xU1bbaLna7rkjQAAIpyrFw40eh5tfosy0OWfQgGT9cWz+e6KPYBgKZ9Fsv6mSjLw15PAgCGCa9cOJOJmk5zo9HLXmIhSXuhcO9yOZcAAFDVt2Kx0mg0F5N2C1GUg2HCsdi14b4C2KharZ7LPQFAKnV7eXnx/14V36nTEfv9EQC0Wl1jZ7Hw+bwI0T+Xb4io05HS6Udd19cXEwTHZRAK/GVEm5u8iOir9hDREcyiD+orpYJ+DoZ8AAAAAElFTkSuQmCC"
    m["light_bg_moon"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADHUlEQVR42u2WXUhaYRjHn5Nf1TK1xEysUXO0PrAPQqF5kbVFIwhaC3J3dhPU1XbtdtVNthHkRVI4aCsdBQUbY4VBxPqYW8ipyTTjRFRkX6SWpXW0s4uziatsZbaLsefqff4v5/09L+95PhCvF4frtBi4ZvvnAU6nW6s1KBRPNZreyADIOY88OWnWat8eHHgBgMGg6/UvIwBQw20MDRn7+t4TBEG6Eok4shucDTAap3p734UqhYXZUXuD5eV1nW4AACgUSnb2LVJMT0+NGkCn68dxPwAolbVBQGxsXHQACwtLFssCAOTmiiorZXQ6jdR9Pl90AOPjX8hFXd0DBEFSUpJJd3V1PTqA2dl5AOBwWHl5twFAJLpJ6ihqiwLg6Ah3OLYAICsrA0EQABAIeAIBDwCmp1GPZ/+qAJdrj/zxebzkoFhRIQOAw8NDg+HDVQHBtIqJQUIAd7lcDgCMjEyYTOiVAExmPLlwu/eCIoNBb2ysRxCEIIj29teXZfwGiI+PY7OZAIBhy6F6UVGOQlEFADiOt7W96urq3931XBBAUameh/oYtrKy4nC7PTJZcWLijaCekyOiUqkWywJBEBi2PDz8aXV1/egIx3E/jgfW1jbn5uYHB40azRuHY0sqFYetpiYTqlbrAKC8vKSpSXEiHBS1dnYatred54TMYDD0+hdh86C4WMzncwFgbOyzzbZ4YregIFujedbQ8Ego5IcDlJVJ/tAPTKY5tbobADicxJaWJyTvtDkc2xi2tLm5s7/vtdkWyWgSEuI7OlQsFvO8YieVisvLSwDA6dxVqdqtVuxMQGoqVyYrrqm5z2Yz7fYlAEAQpLn5cejpYTua3+9vbe02m7+Tn8nlkurqe2lp/BNJg6LW/v6PwdOVyodVVaUXbZl+v7+7e2B0dCqoCIX8zExhUhI7EAhsbOzY7Ysu1890odNpjY31paWSy/VkAPj69VtPzxBZoMJZUVGOUllLlqxLAwDg+Ph4ZsYyMWG2WrGdHdevWhIjEPDy8+/I5dKMDGGEU8Vp8/kO3W4PhUJhsRJoNOpVx5b/o+PfAfwAvyRJmiie5UQAAAAASUVORK5CYII="
    m["light_bg_mute"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAChElEQVR42u2WQUgbQRSG34wb0kSoCJpmN1khWNuQRqupl8RL8VTqMQcvQulCL9WEhkTsYQkkemgRQbo9J9B6EvQW6NGDiShJA0kKitAQaSNUQrL1sLVZMj1sG+w2SmjXQyGPuezO2/fNvH/mvUWSVIerNAxXbB3AfwUolcpzc1GfLyqKX7UHFAqHPL96fHxSLp/s739sH0C145RMZgRhrV6XlcdGg2gJSCS24vFNQoj2GhBCYrGNWGyDEIIQGhm5/ReA33awu5vb3s4A/FxspVI7OCgCgE5H+XwzGONc7kDln07nvN4HZnOf8kaW5fX1dwAwPf2wqwurAYLwRpLOVEswGg0LC0+czqGdnaxqShDeStK3bHY/GvUzjEmW5eXlWDqdBwCH4+boqF2doj+j22zWpaVnTudQy+27XHcAoFoVw+FXR0fHzei9vT02G3OhyB6PKxh83E5+/f6Zs7Pv6XS+WhWDwReNRkOJHon4e3qua3CTKYqan+fGx4cB4Hx0i8WkZanA+PzBaygkbQCKqnt7eQDAGANArXYaibwul79cBkil3nu9PmWEQi9LpfJFAEFYa6q6svJcyZWiuSietgAYDHpViGLxE8+vFgqHLQGZzIdm3gcG6KYe1apYLH5WfLp4Ptz8wGIxEwIsa2ZZmmVpo9FQqdTqdTmZzJjNfRjjVCoLAB7PGMvSAGC13tDrdbOzMwzTr2TJ7b5LCHE4Bicn3RgjAECXNH1CSDy+mUhsAQBCaHj4lnKTQyHO7R7ToBYhhDjOy3FehBAhRFUnNOsHU1P3A4FHOh11hR1tYuIezz/t7r726+Aj7Tua0zm0uBig6X6GMdntg+0DUOfPrgP4Z/sB3nEHqiSqIHsAAAAASUVORK5CYII="
    m["light_bg_news"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACa0lEQVR42mP8/v03Ay0BEwONwdC3gAWN/+/fvydPXj1//uLfv/+kuZSJUV5eRkJCBJ8FDx8+mzRp0YMHT8l2r4aGUmFhvIiIEFyEEZ6Kvn79XlTU/ubNewrDREpKrLe3go2NFd0HBw6cgphuYWFgZWXAxERa9Pz792/nzqNXr95+9uzVoUNnXFws0S24f/8xhJGTE8PJyU6G2/X1NeLjKxgYGG7duge3AOHMnz9/MTAwMDIykmc6AwMDDw83hPH9+y+cqQgOpk1bvm/f8f//CaclRkZGZ2fLzMxI0vLBsWPniDGdgYHh////x46dJzYfwEFubuyRI2cZGIixg9HW1phkC8zN9czN9aifk+Hg48fP167dQRNkY2MzMNBcvXr79u2Hvnz5BhGUlhZPT4/Q1lYhzYKamgnPnr3CFHd3t9258zCyyNOnLxcuXN/VVUqaBXh8BmGoqSmKiAjcuvXg7dsPd+8+IjmIWloKsAbRjx8/Tpy4wMDA4OfnaGlp2Ns7/9ixc+TEAT8/r6WlIab48ePnqRPJJ09ewkym7OxsKirykMxFqQWTJy/+/v0Hpvi7dx8gmaunZx7CFBZmkms0KysjTGeys7M7OVlycnJgFnMk+yArKzIrKxJXib9r15GvX7/D84G3tz1hCzg42CB+//LlK7xcxAqUlGQzMrDYDQ9SDg5WLBaoqiru23eSgYGhp2eeq6sVGRXOkSPnYC6Qx1Jl/v79p6Sk88mTFxQWPqKiQv39lfB4QjiTlZWlpiZTTU2REtMVFWWqqjKRUwEjZtPxxYs3Dx8+IaPZIi0tKS0thpb2GEfbpgNuAQC4w+x/E0S1pwAAAABJRU5ErkJggg=="
    m["light_bg_octagon"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACGElEQVR42tWWP0/CQBiHX0jZpC0mokKYZAFlUCuJWz8L6maq0dQ4IGB1UAlGu5rgV2GujQOYsuBkBAMJ/zRh4KIOB1VIe5Qaot5EwvV5cu97fX91dDpdmORywoQXRf671Wpr2iNhQzgcZBi3TcHzczWZlBuNFmGPx8NIkuDzeccukRU6ADQarURCLperZhschk3+Tue4CM+vGT6cyymq+kA+h4GgUqkdHV1j+urqoihuulzGlUQIZTJZRSkAAMu6UykhEJgbUaJKpZZIyFboAEBR1P5+LBqNAECz+ZpKyU9PLyQBptfrTQBYWQmT6RYdTjP6wcHWSPo3x4aZo9eDdvttb+9M76ooxiiKGuuFQgil01lVLeCeX14e0vTU1wmKxVKfvmSDjs8hijGOi+C7WyyWBkr0/v6Bf/B81AZdd+gXWgf+/ix61bTSpGYRAMTjV4QxAAB+/6wsx//wuD493R1Zoh8JGMa9vr78pxOtJ3A6Hf0JfIcQssdCCOVyyhCwJwiFgh4PAwCqWkinszYc/VHRi4dQKDggoOmpk5Od6WkWO87Pb7pdNBY9k7nFg4hl3cnkNh5EAz2Yn5+RJAE77u+1iwurDkxXlLxh7Aw02YajH2p5s1AbvkVjOaxEpnHol8tVPTg5bonnoyahf6cHwPGx4Pd7rX5VDDnIi0AnvWg+n1eSBHx3bdNJJ7A8rhcYhiZscPz7r+tPFgJIvw3UauIAAAAASUVORK5CYII="
    m["light_bg_palette"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEtklEQVR42tVWX0yTVxQ/39cWKG2BFiijLbZdGUgVqK4gTukYlKUCS4XFJQ2ThansQaOSjQgvPi2hxkAyEl+WMAgokjTRkUa2sAraQAMFKsLAoAHMLMgf068tH3YMbPdwoVIoWMh82H0697un53d7zu/87sFcrhV4nwuH97yoAfoRhGNmZsHpXAQAFovJ5UZyuZz/AMBqnevo6DabhxcWbJuOwsNZMllSVlZ6cnIChmHbRcC2qwFBOBoa7ppMFo/Hs/MlxGJBaemXBw7E7wJgcHC0rq6JJF+jLZsdJpMliUQCNjsMxzGCcFqtcyMj4zMz82tRMKygIOv06ZMUCv5ugAcP+m7caHG73QCwb1+sRpMfExP96hWRkCBksZgbPScm/rpz54/e3iG0lcuTKyq+pVKpOwEMDo5qtT+73W4Mw9TqHI2m4NYtvV7f6fF46PSQysqygwc/AoCpqWmDoQcAlMpjNpu9rq6ZJJcAQKGQX7r0zbYANpu9vLyaJF9jGHb27CmVKnN6eu7ixR+9DkIhv7a2cmrKWlVVs7KyCgA0GlWr/SEoiHb16k8E4QSA8+eLs7Mz/PdBY+OvKO9qdY5KlQkAm8iDtl1dfSg6AKysrHZ29vJ43Kqq76hUCgA0N7e5XH/7AbBa50wmy3reC9BHiSQuNJTu9UlJSdyOSxLJPrU6BwCcTtJgMPkB6OjoRozUaPLRXVBPXblyTijk0+kh6empZWVfAUB2dgaNtlZJGo2WnX0U2Wp1TnBwEAA8fDjgp9H6+4cRI+XyZADQ6X5rbzdiGHbihKK2tnLjZUUivlZbcf9+j8eDKZWfiEQ89J3BCE1NTTKbHz9/biXJJSaT8RaAIBzz8zYAkMmScBw3GgdaW9vRUWvrvdjYqOPH5b4YvDNnTm1N1P79YrP5scfjefFiNilJ8jZF3pYRiQQAMDr6bOPPRkaeBShZHE44MhYXSZ8aIBYDAJvNAoDoaB8h43IjAwTwsgvHKf7lGtU5L+9TsViwLjVxeXmKAAGePp1CRmxstE+Rmcw1DXA4SAAIDQ25dq1ifHwSABITP9yqMH6XzWbv7h4EAC6Xw+NxfQB4vDXAyUkrMigUXCqND/xhWVpyXb/+i8u1DAD5+Z95BZy6nvpwLpczP28bGnridrtxfBcvHUE4LJYxne531Ofx8UKkApv74MiRVL2+y253ms3DGRmyHSK2txtv3mxbXv5n65FA8EFl5Tlvn/oUOTf3GPpft2/fW11d3S76o0dj9fW6rdEpFIpKlVld/T2bHe7/yeTzYzIzPzYaB6zW2ZYWfUlJoV+A/v4/kXH4sDQkJBgAGAy6WMxPS0vhcCLe8SaXlJy0WJ6Q5FJbW2dUVKRfdsbErPWEVBpfWJi7u7GFzQ6/fLkEkbK+XtfYeHdrrpTKo0hfu7r69jIXHTokvXDha8Qivb6zvLzaZLK8eeP2OjAYoVKpBABmZxf2OLYoFGksFqOurtnpJGdm5mtqGtCEIhbz2eywxUXX2NgEAPjN+C7GFrvd2dTUZjT2bze2FBd/UVT0+d4BvCprMPSYzSMvXy5sYCSuUilKS4t2mLcCBfAuh8OJRkcqlSaRxEVEhAXY59j/frr+Fw5l3ePK5MxTAAAAAElFTkSuQmCC"
    m["light_bg_pause"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD+0lEQVR42tVWX2hTZxQ/t/desDZ/m3jN2lVTRRkZ2iWQSiKlD324BUWHNA8tbFJQH1PwJQwyBLEMfVHjg382FDIhkm5oGKPFTCFgI4uQq30IqyBpusXYNDe5N4nN6L232cOXZck1pukyH3aevvPd8/1+9557vt85WKkkwIe0DvjARrQYVygUWTbPsjkMw3Q6jU6nVii6/gOCVCoTCkWePVtYWkrKHvX391qtB4eHBw0GfRME7H3/gOfzfv9cMBiWJKnJeRzHafrw2NioWq3cAsHiYvzSpW85roDc7ds7zWbTrl0f6XQaAMhmuUQixTCxtbUSCtBoVC7Xqf37+1siCIejHs/3giACAEXpJyaO2GxmgsBlYaIohsPPfb6f0uksAJAkMTX1pc1m3oRgcTF+7pwHoY+ODk1OniCIZv9JEMTbt394+HAecZw/75R9Rx0BzxfOnv0GZebkyc+PHRtpscYCgUde7wOUq8uXv1KpFI3vgd8/i9BHRuytowPA8eMjND0EAByX9/vnGl+0VCoTDIYBYOdO/ZkzjvqKKkSjMUnaQK4kbUSjMZ4v1MZMTp6gqG4ACAafrKywDQhCoQiqyPHxI7K8u91Xpqevz8zMIndmZnZ6+rrbfaU2hiSJ8fGjACCKUigUaUAQiSygirTZPpNl4PXrNAAkk2nkogXarDW73dLVta0KVUdQKBQTiSQAmM2m5mXTTBUIfGDABABLS8li8W0dQSbDo4XR2NOOtO3e3QMA5XK5ClghyOUqvlarboegejyX4+oIMKwSsbFRbk+ey38DYnUEVWaO49uBz2blmagQ6HQVP5FItUOwvJxCr18FrBAolQqjsRcAGCYmiuK/QxcEkWFiALBnz8fVdvTPPRgcPAgAa2ulcPi57GRPDwUAvb0UctECbcpkuFT6EwCs1gMNxO7Nm4zTeUGSJIrq9ni+JkmiVipevfp9YOATHO9AUvHixW979/bVNpn1dcHpvLC6miUI/No1N0Xp5V9gMOhp+jAApNPZW7fu1b6aWq20WEwIHQBwvMNiMcla2J07P66uZgGApoeq6HI1HRsb1WhUAPD48a+BwKPWs3///i+oJWi1KoeDfu/YolYrXa5TKDle74ObN++hztPE1teFGzd8d+8GAIAkSZfrtFKp2KRlPn3KXL3qRdA7dnRPTBy1283vCpQoivPzUZ/vZ5QZkiSnpr7YvGUie/kyfvHidxyXR25n5zaL5dO+PoNerwWATCa3vJximBiqGZQZl+v0vn3GLYwt+XzR758LBp+IotRcQWl6yOGgZZnZnADZygobCkUikYV4/I93Bq++Q4cODA9ba2tmywRVKxbfsizPshwAbGl0xP730/VfKoG5uO6GraQAAAAASUVORK5CYII="
    m["light_bg_pen"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADIklEQVR42u2W3UtaYRzHv+oxK7YadLGLFmROy2pFBdW0KLKiYA12sZc2emGzSC8qkF4ofKuL6LJyiewPaLuLrroIVlDBGkhEbVTDYy+KOpu92Fw5cBdPOCt70RZjsOfqnOc8fL6cz+/H7xyGx+PFdS4mrnn9CwF7e267fevwMLhq6ipom81pMLxdWFgGwOFwKisLq6sfUBQr8Awj7CJbLA61esDl2g3cLCrKbW6u+QOKNjftKtURPSUlqaqqJDb2JoCpqTma3riqovn5z/39b4j03Nx7CsVLiqLS0/l9fQYAi4urXG5C+AHr6zY/nce7o1C8ItJ9Pp9fe/iK1tasGs2gv2FMJsvU1BwAq9VhMLwjm+npgjAVmc1WrXZod9cNICkpgaY3fT6fXj/idG5PTMy6XDsAiovzuNz4cLrIbLZotTpCF4myWlvrJyc/6PUjAWaQnZ3a3t7AZlMhK6LpQHp2a2s9i8WUSO7X1Dz0n8nKSm1rk56gX0oRTW9qNDq3ex+AWJzT0lLLYjEBOJ3fxsdnyJm4uFvt7dKICHbIo+IculI55HA4AWRmpuh0qqD0C96Apjc0Gp3b/R1AQUFOS0stk0no2yrVb3pnZ+NZ9PMCTKYNrfaIXlKSJ5e/YDAYhK5WD9jtTgAZGcnn088MCKRLJPky2XNC39pyqdWDNpsTgFDI6+hoOJ8ePGB5me7tHfZ4fgCQSEQy2TNC397e7ekZ9tO7u2WRkZwLe4Q6NSPtvb2vPZ4DAOXl4sbGp4Tucu2oVANW61cAaWl3u7qaLkMPEjAzYyT0iopCqfRxAH2Q0FNTQ6AHadPFxVUAbDa7ru6R34xaPWS1OoiZkOgnA7zenysrZgDJyYmkejs7e1rtkMViByAQcLu7m6KiOCHNx2OKVlZor9cLIC2Nv7/vmZ7+ODb2nlRVIOAqlfKoqMhQx/uxgKWlL+TCaPw0OjpxcHBIbvn8RKVSHh0dGcbXiTpdAACrq+ajxxRLJMqSSp+ERz8Z4OcCiI+/XVoqKi7OjYm5cZU/j2MBIlH27KwxPz+zrEwsFPJIF11xMf7/m/71gF/onGvZtxWkfQAAAABJRU5ErkJggg=="
    m["light_bg_people"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEAElEQVR42u1WX0xTZxQ/l1tX2l6kOgrtWmoLtLbSP5ZRpYSwzP1JjDMqe5jJXhxxusRkD1obHkgfjKZLCC/GbNmSxUQXXkhoTRa2DEmDYoZtMc0o1Nhh+dO/d7R0rHIp9Pbu4ZMKBdYuxmwPnqdfznfO/X3fOb/z3Q+jqDV4lVYGr9heExQ11k4LuVzu3j2P2z0xOxvGMJBKxUajpr3dWFb27/aEbasiilqx2b6bnAwU+DUaRVfXOQ6n/GUJenq+HxvzAgCOl0mlIgCYm4vSdA4AWlsNly51ojCSXBgdfRSJkHz+bp1uv063vySCYDBsNn8FAGJxTXf3F9XVVQAQjyeuXv06EiEBoLe3SyYTDw6O3Lp1Z23tRfqhQ7qLFz/btYtVpMle7xQCnZ0fo68DQE3Nm2fOdKwH+Kemfr95c2Dj1wHA5frt9u07xVWUSPyJgEwm3uivr69FIJlM9fX9mMvlMAy7cOHTvr7enh4L2srg4EgqtVSEgMtlI5BK/bXRv7j4PJPDKZ+ZCQGAVqs8cqSFzX6jrq725Mn3AIBhmGAwVIRAoZAhYLcPMQyDMMMwdvtdhJVK+UvNgcGgFokE0egfo6PjJJlobtYAgNvtCwRmUOf1epVMJvH7pycmngwP/9ra2hQOxxyOIQDAMEwulxSX6dOn81brdYpa2VI9zpUrX8rlEr9/2mq9nsvlCgKOH383rwVkeHe3dSvBnj2VJpOBJJPx+AKqEo7jRqPWbD5bWysEAIFgb0UF4fM9QcOxLlP9+fOf4HhZ8RPkLZvNhkIkAEgk1SxWYT1JMvngwaNoNM7n79bpVBqNotRJXl6mXK6JQGBmaSmdd/L5FQ0N+5qbtTweJ++MxRb6+3/GcVyh2Gcy6QmCV4Qgm6UHBn5xOIYzmcy2Z+Jw2CdOvH/q1AcsFg4AN2784HQ+zC+dPv3RsWPvYBi2fQ8oauXatW+czoc0Te9cNNrnCzx+PG0yHWSxWDRNezw+1IlslvZ6/c+eUQbDgW1OwDCMzfbt+PgkABAEt6PjQ5NJn78qGIaJxxNjY167fSidXkY3j8VyFm02lVpyOl39/T9lMqsAYDZ3mkyGwhPcv+9BoyQSCWw2c1PTAR6P+2IjGEYQXJWqrq3tbY/Hl04vh8NxiUSI7trycrZaXadS1Y+MuBmGmZuLHj3aXjjJDscwkqPFcq6qir9TiQSCvZcvf460mJ9tZI2NDW1tTQAQCsXCYXITAUkmZ2fDANDSclAqFf7z9Mtkbx0+rAOAYHA+kVjcuKTVPv8lRCLxTQTz89H1CGUpN0xjo3I9MVagsfwAbSJYXV1FgCA4pRBUVhJ54f0/XhVqdb1QWIVAKWk7xW/1Y6/fpv85wd8lE6/QqShwAgAAAABJRU5ErkJggg=="
    m["light_bg_personplus"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADDElEQVR42u1W30tacRQ/egVnOYpNK2c57Ycs0lrO7IfRQ2x7jeofaLHFnnoIkh4ixAKh8KHZD7aHDaJtFZW+bGzrx4OEWK5NVm2QkIlZeUtrLbrqXHcPX3JhandFbA+dh8uH7/2e8zn3nM85XBpB/ISLNDpcsF0SnGqMWC8ODw9Npo9W64LT6abRQCDgFxVJKiqK6PS/y4kWVUUE4ddqny0t2SPOJZKclpYGFuvKeUvU0/MSRccwukjEF4n4GEYHgMVFe1/fq/OWyOFwWyw2AODzU1tbH6ekcADA4/F2dPStr+Nm8+faWrdQyD/7F9hsXxGor69F0QEgNfV6XV3N0YVvES44vt3bOzg7+4USgdf7HYGINLOyMhDw+XYjXEZH309Pz+r1A5QIEhKYCOzu/jh+vrOzh8DJJhNEEAAIIkCJICdHiIDBMEGSJMIkSRoMkwiLxaJzNbmwMJfH425sbM3MzOO4Vy6XAIDVumi3r6LOFxTcQnUfGXkXCAQBYHl5FfnqdM+R+svL7xQX58ecg5UVV1vbE4Lwn6geS6NpFInSAaC///XkpDlW4izWlcHBrphzkJmZ0dWlksulSP4AgGGYQpHf2alC0QFAJstjMpnRp5dGKyuTxZvksIVCobU1HADS01MYjJh7Rad7YTZ/AoCxMT2lXXRwQMzNLdjtq3t7++HD5OSr2dk35XJpYiLr7E0OhX6Nj38wGqcCgUCM4jKrqu5WV99jMLDjNQk/48mUIPwaTc/w8NtY0ZHYh4betLf3+v1/7iiVMhaLWVlZGm+bkiSp1T6dn18CADY7oabmfmlpQXhVkCTp8XgtFpvBMLG/fwAACkW+SvUwatbRCUwma3f3AADweFy1upHDSY7qsLXlU6v1m5vbANDU9ECplFFddkbjFJKjStUQKzoAcLnXmpsfIfmGZ/t0Ahz3OZ1uACgpuS0QpMX3EQpvoCl1OFxe7w4lApdrAwGpVExFfHl54iPHTUoEwWAQATabksaTkthh4f0ffxW5uVlpaRwEqLhRv0+7/Df95wS/AScdKxdGFZv3AAAAAElFTkSuQmCC"
    m["light_bg_phone"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABrklEQVR42mP8/v03Ay0BEwONAQseuf///+/Zc/zAgZP37z/9+fMnuk4WZllZyaAgVysrIzyGMOIKov////f1zTt27AJBN/r6OiUkBJLsgz17jkNM5+Rk19JSYWdnQ1Pw69efixev//79Z/PmfVpaymZmeqRZcPDgKQYGBnZ29s7OMmlpMaxqrl+/W18/6e/ff9u3H8JlAc5IfvDgCQMDg7a2Mi7TGRgYNDWV9fQ0GBgYbt9+QHIq+vHjFwMDAwcHO/4I4OTkYGBg+P7954Al01ELRi0YtWDUglELaF3pI4NXr96sWrXj589fDAwM7OxsYWEeYmIi1LRg7drd+/efRHiciTkrK5KiIILUZV+//oBwjYy02dmhtRs7O7uJiRaEDWnOcHKyk+wDVVX5S5duXrly89q1O1paKubmesuW9aCpefz4xZUrdxgYGBQUZEi2wMvL/tKlm3///mtsnKKvr4HZbPnx4+fVq3chPnB0NCe54cXAwLBw4YZNm/YSDGVra+PCwnhGRkaSLWBgYDhx4sK6dbsfPXr2+/cfjPYEu6KirIODubOzBTlNxyGT0QDbvZyA+udBkQAAAABJRU5ErkJggg=="
    m["light_bg_phonebell"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC2UlEQVR42tVWTUgbQRh9m02MMYFC24Mi4k/Rahs1TVBxqVBpQw5WURFqMFAoRTAhIJibJy9Se+khlxTBi4J/PQiKKWhaUIlEmmCNQRtM00YPe/CwqGl0Nz89LASJGpt0hfadvvlmhsc38828R0QiHG4SItwwxJdmNza25uc/B4P7kchZypRcnltZea+t7alSWf4nBMTFI5qdtU9NLV5TuEjU2/tCq6UyriAYPJiZ+QiAJMmamvsymTRlwcnJL6/XH4/Hx8Y+KJUVBQV3MyNwu33xeByAxfKqvr7m0j1LS06bbZJlOZdrs739WWaXfHBA84FGo7xqT3NzA0EQfLnJJMMcmUxDJtMQTR+mI4jF4nxAklc2mFhM8gFfK49AYJ+mD2n6cGTkPctyQrYpwxy53b7q6ora2koAoRA9N7csJMHg4LvhYZvVOtHf/1KhyAOwsPDp7IwV+KE5nR6v19/S8gRAOHzq8fgEI7BYXvMXZrevUJSaT+7sBAQjKC0tVCorAPj9P/Lz70gkYgDJXhLmiG7fvgUgFotxXFQqzQHAcVHBCBKJRCDwE4BCkUeSZDgc4WPBCOz2lVCIBqBWP9jd/Z5IJAAUFRUIRjAxMQ9AIhF3duqWl9f5pEpVJRhBY6NKKs3p69MfH584nR4AxcWF5eXF6fQgI5jNBrPZwDBHAwNv+PPp6WnlPyshH1ogsM8wxwC0WkqjeXiNomUBlaqqo0MLoLu75XrJzAIkKTIY2v4Z0U/C5dpaW3MDCV7Am5o0V8lclgRW63gkcpocbm7ujI+//StflBSyaDQGgKLUyYYjCIKiHp1XPZFIlHEFJSWFq6tfADgc6zrdY6NRbzTqLxgDb8p/kAFBQ4NqenqRZbnR0RmX66tcLktZEA6fbm9/42tNYwzSGS+HY91mmzov6JdCr3/e1aXLhgCAz7c3ObmwtxfiuNRZmSy3rKyotbW5rq46S+v4n7nr33qLHMZnPoLkAAAAAElFTkSuQmCC"
    m["light_bg_playcircle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEYUlEQVR42tVWbWhTVxh+r7lhxubT1LTTVtOCdXRql2JakpFmGEY6UuzURmjoKpXaP9UVZBAVpuAGQxkWIxTLpmLtiGQbsRW7Ymwhw6ZrBGOLlLUg+XAhqybNzYe509w0+3HKdblN0nTMH3t/nXvPe56H857nPOfFSDIJbzPWwVsOvMC8WCweCkVDoTCGYWKxUCwWcLlF/wFBIBC0250PH854PH7GVEXFFrl8t1pdV1panAcBy3UGkUjUYhm12RypVCrPehaLpdV+2NLSKBDw1kAwN+e+cOE7goihzw0bODJZ9dat74rFQgBYXCS83oDLNZtIkChBKOQbjZ1VVRUFETgcj0ymm8kkBQASSbHBoFMoZDjOYqRRFOVwPDab7zx/vggAbDbe09OuUMhWIZibc589a0LojY2qjo4DOJ7vnJJJ6tq1n+7dm0Ac5859zthHBkEkEjtx4htUmcOHP923T1OgxoaGxgYGbqNa9fae4vO52e+BxfILQtdolIWjA0Bzs0arVQEAQUQtltHsFy0QCNpsDgAoKSnu6tL/M6mvz9zW9sXg4DBJvsrF0dFxQCLZCAA224OFhVAWArvdiRTZ2qpj1H18fJIkX1mttuPHv7Lbnel0eiUBm423tjYBAEWl7HZnFgKncwYpUqH4gLGYRgyHIybTzdOne58+9a3kUCpri4rW01AZBLFY3Ov1A4BMVp1LNnw+l8ViAcD8vNto/Lav74dIJJrhCjirpqYaADwefzz+MoMgGIyggVS6OVeVd+6sunjxVE3Ne2hPY2O/HTv29fDweCq1ROds27YZzdKA6+i9o4FIJMijlrKykjNnuk+e7EL+k0iQN25YLZYROoFeHg4TGQQYtpyxtJReVZRLSxnHjNGLAQDSjJ84g5kgInmgnz378/r1n6enf6c96tChT3Q6NZ2wuMisxDKBWLz87fUGcqE/eTI/NTWNpIxhmEajMBiaGCbq8wXQLA24TMDjcaXSLR6P3+WapSgqq5Ci0Tga7NhR0dmpr6wsX+lLLtcsAFRWltHP0RugurrdHo8/kSAdjscNDXsyDAvDUNVFIkF7e7NKtSez7m9smCT/AgC5fFeWi6ZW1yGZm813kJvSodEoOJx39u//+PLlLxsa5FnRX79Oms130W1Qq+XZ3fTq1R9HRn4FgL1767u729b0uPf330KmrdN9dOTIwexu2tLSKBTyAWB8fGpoaKxwdKv1PkIXifh6vTZn2yIQ8IzGTjYbB4CBgdv9/bcYtcpamStXzIODQwDAZrONxqM8HneVJ3Ny0nXp0gCC3rRpo8HQpFTKVuqKoqiJiUdm890XL9CTye7p+Wz1JxPF/Lz7/PnvCWLZyzic9bW175eXlxYXiwAgGAz7fAGXaxZpBlXGaDy6fbt0DW1LNBq3WEZttgcUla9twXGWVqvS67WMyqxOgGJhIWS3O53OGbf7jxWNV3l9/S61Wi6R/KvGixHx+MtQKBIKEQCwptYR+993138Dkabtts3pi5AAAAAASUVORK5CYII="
    m["light_bg_plus"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEEklEQVR42tVWTUxTWRg99fWBCKXU1trRQYsJ4mC0FFNMa0iTIfEx8QcjdAHJYEjU5ZC4aVyZuJnRDZGVOhNNOoaaMo2SakQ7Y9JEnklNKLBgxE0pGdKA/Xn9kQ7tK53FrbV9reVnxsV8q/tyv3vO98797rlXlEik8CVjG75wiDeYF4vFg8FoMBgWiURyeZ1cLq2pqf4PCPz+gMvlfvNmZn5+UTDV0LBXpztqNLapVIoyCKLP7UEkErXZxp1ONp1Ol1lPURTDnOjp6ZRKJZsgmJvz3rz5M8fFyOeOHVVabfO+fV/J5XUAQiHO5/N7PLMrKwmSUFdXazZfPHiwYUMELDs5PPxrKsUDUCoVfX2n9HqtWEwJ0nieZ9kpq9WxvBwCQNPiwcF+vV67DsHcnPfatWGC3tnZPjBwXiwut0+pFH/v3m8vXkwQjuvXfxD8RwFBJBK7cuVHosyFC+fOnu3YYI+Njf1hsTwmWg0NXa2trSl9Dmy2ZwS9o8NQjJ5Or42MPBkZeZJOrwmmuro6GKYdAMdFbbbx0gfN7w84nSyA3bsVly+bisucnn5rtz+3259PT78tnh0YOK9U7gTgdL5aWgqWIHC53KQje3tPldR9dXVVMMgPmhb39p4GwPNpl8tdgsDtniEdqde3bM0VDIbW6urtOagCglgs7vMtAtBqm8u3TTlXEFMaTTOA+fnFePxDgVUEAhEyUKv35O/q1NSfyWTyYwfPCwYAKioqWlq+oahsofv372HZyUwmEwhEiFllCcLhLIFMJs0tHh19Njo6Xlypw/HS4fj02dPDEPXzl4fDHKk1yywSZbPX1jL/zp4zHwFFBRLlmDkukss1mb5rbFTnS+RwvARw5sy3TU3qfIlyS0IhoRJZArk8++3z+fOcctuxY4cLxQGApiZ1seeQWFjwk/JzgFmJJJIatXovAI9nluf5ramTSvEezyyAAwe+zl1Hn85BW9tRACsrCZad2hoBy04mEn8D0OmOlDhoRmMbRVEArFYHcVNBVFZWCgb5kUymrNan5DQYjboSBCqVgmFOAFheDt29+7AYQqM51N19srv7pEZzqHj2/n37+/chAAzTrlQqytj1TxwXBdDff66ra6N2/ejR7w8ejAGQyWqHhq5KJJ+xa6lUYjZfpGkxAIvl8Z07D0tqJVDm9m0rQadp2my+lI9e+sp8/dpz65aFQO/atbOv77TBoC02KJ7nJyYmrdanRBmapgcHv1//yiTx7p33xo1fiFYAqqq2t7Yerq9XKRQyAIFAeGHB7/HMkp4hypjNlxob1Zt4tkSjcZtt3Ol8xfPp8g7KMO0mEyNQZn0CEktLQZfL7XbPeL1/FT286o8fP2I06vJ7ZtMEuYjHPwSDkWCQA7Cpp6Pof/+6/gf/hMcvWOV6pQAAAABJRU5ErkJggg=="
    m["light_bg_power"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC70lEQVR42uWWy08aURSHzyiIGHlZSYsPLCoikTRGa2KJK6nuCrpqQpPuaGp04YaFJvYPcEs0mJiYYCNxUx+pG8EHRmy1SmIUpI06EaGOtEUExEYD08WwoMIMQ1KSNj2rM3Pv+X3nPs7NQa6vbyGXlgc5tuwAKOpFUW+uACjq0+uH9fphFPXlBIBhfhzHcRzHMP8/ewZ/DBCLxY1Gs0435HC4qOMdDpdON2Q0mmOxeBaA0dEpi2UjEAja7Q5qgN3uCASCFsvG2Ng0XYDV+mF1dRMAeDyORqOiBqjV7VxuMQAsLW2srGxmBlxdRScnZwGAyWQMDr4Wi0XUgKqqsoGBVwxGPgCYTLPR6M8MgMVFeyQSBYDu7o7aWjGdY6yrk2g0TwEgFIpYrfYMgLW1LQBgs1lqdTv9q9LVpWKxWABgs32iAlxehjweDACamhRsdiF9QFERu7lZDgAnJ1/D4QgpgFAHAJnsYZrjykPuOMkmlUoAAMfx01Ms+T8j+SMSuSKckhJeqkR9fXVZmZBwUkf5fC7hhMNRUkB+fmJBt7exVAkej2swvCHbpXg8nnZ9v22RQJBI/Pz8e7ZPAoYlQkpL+aSAykoRcaP39j5nC9jf/0JUT3n5A1JAYSGroUEKAC7Xkc+XxZvs9Z673ccAoFDUFRQwqeqgo0NJXAaTaZY+wGSawXEcADo7lRkKrbW1USKpAIDt7b2FhVU66vPzyzs7TgCoqRG3tDzKAEAQpLdXy2QyAGBi4t3c3BKRWlrDcXxmxkKslclk9PRoEeRuiSBp2xabbctgeEtIKxRSrfaZTCa5M+fg4Mhsfu90HhJp9fe/bGt7nCqFkPVF6+vbIyNTNzeJUZFIKJdXC4X3AMDv/+F2H5+dfSOGWKyCvr4XSmVTWh2EovHyeLDx8WkiRzJTKKQ63fOKivtkE5CMnZ3Tebi8/HF39+DiIpRcko2N9SrVE7m8hjocod86hkKRYDAMAAIBh8MpphmF/Ge96d8I+AXQ8B6dqPK4owAAAABJRU5ErkJggg=="
    m["light_bg_puzzle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACiElEQVR42mP8/v03Ay0BEwONwagFA28BCzGKvnz5euPGfUZGRg0NRW5uLipbsHnz/mXLNv/69ZuBgYGdnS062tfb24FqQXTo0JkFC9ZBTGdgYPj589e8eWuPHj1HvAWMaBntxYs3q1fv+PXrF4R77drdDx8+MTMzR0f7/v//f9myLX///hUU5NPUVIYoYGNjCw31kJAQITaIVq/eceDASTRBQ0Mtf39nBgaG69fvnjlz5f37T8eOnUdWkJsbQ2wQwUMDDtjYWB0cTCFsBwczNjZWglqIiuS1aydjClpaGlpaGsK5wcG5gzijLVq04efPX8QYcf36naNHzxJrATyIN27c29o649+/f3iMhih+//5TX9+CrVsPYlXDXFNTh8yXl5f69u3Hx4+ff/z4+fr1O2lpcXl5KVwWSEuL/fr15+XLt////7927a6npy0rKysBC3h4uMzN9UxN9bdtO8jAwMDNzWlqqofLAllZSVtbY2ZmpsuXb/39+1dLS0VSUpSoOPj//x/x0fj//39opmUkIpk+f/5m9ertFy9eh3D19TXwGH3ixIV9+05cuHCdgYGBk5NdTU2RsAVr1uw4ePAUhK2rq4ac6jHBpEmL4SktOtqfm5uTsAXwbBkU5BYa6sHExPT377/Dh09fvnybgYFBX1/dxsaYiYkJXvYxMDAICvInJwfjcgrOnBwd7cvAwPD9+8/W1unXr9+FCB44cHLPnmPV1Zns7GxwlZqayng8SiAnr1y5DW46BFy9emfVqu1UqHCQyxlBQf62toJ//xiqq/s/fPi0YcOeDRv2kFlUYBaWkLQkJiYiISFiYKCJKz8T64PQUA8GBgZ4hQOvUoiRJapGG20XDUMLAAzY/igatweUAAAAAElFTkSuQmCC"
    m["light_bg_receipt"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACaklEQVR42t2W30tacRTAz1fHNQWRIC6sVmSBrJelG4QKDabBWDgIiuBGRNiTPvvUnzCIPYTdp6hwy4fL2IbQetFohOlgchsMhxF3KCXI5CKC13uHfvcgE3H4414Ntp23e75fPufc8+t7kCD8hNsUFdyy3Gn6rlSqLJuUJEkBiyAIs3lKrVa1M8AwHxjmWLG/S0tPKcrVLkTX17leAnJzk+sQorr4fG5Z6K2tPYxx5xzUxWazyPR+r59VFI+zfv+rXO6H7CrqRsLhc5oOYoxVKrXHQ/W5D+p0hJDFMtVro+3sBFdXfScn8T/pHg9ltZp7DVE0mhAE0e9/Xa1WAaCR7nTa+jAq3O5FhBDGmKaDCuid/8DhsNbotRqXS++qimo4mg4CgFx6t2XqdNomJkYBwGi81+s0bSUK0F0ZiMe/nJ19BsAtztHs7KOZmQfKDWxvBwSh3OYCyyYDgRfKy9Ruf4gQanWKELLbLT2FyOulvF7qr36T/2MDGGOWTebzfKOS4zIcl2nU5PM8yyZro1Bekjc3X6ZSnEZDLC8/c7meSJK0v/8uEjkHAIfDtr6+QBBEKBRhmGNRlEwmo2wDqRQHAKIoBQLvT08/FYslni/8fhWiicRXvV6XTmcbL8vOgck0rtUOAEA6na3RSXKIJIcAgOcLNbpWO2Ayjcvog5EREgB0Ou3a2sLcnI3nC7u7b2IxFiE0P/94ZeU5ABweho6OPmKMrVbzxsbi4KAhHI4dHLwtlYThYbK5GZuW30qlenHxbXJy1GDQ15WXl981Gs3Y2N26Jp3Olstio++FQvHqKjM9fb9pdUT//Hb9CyZODpIXOWSWAAAAAElFTkSuQmCC"
    m["light_bg_refresh"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADk0lEQVR42s1Wa0hTYRh+z9naRxfTkcRQ1K1sXmqB2vAyFVLqT+hqsxteBk2ClBX97vIj6W8FYwWpEZUW1gQNRIyu05nRJsVubpqbtLJyqWWN49a+fhyRpe6cJQ16f31853zfw/t8z/u8L+H3ByCWQUKMgxv9r/PzgdnZ7wAQHx/H4635ZwBWq8tgeG2xuCYnpzDGAEAQhECQKJGIS0ulWVlbmY8T4W9w9epdo9Gk0dTl5+8EAKfTfePGA5fLw3BeLBap1cr09LSoAKqqTmKMZbK806dVnZ199+71hEIh+lNiIl8sFm3alAAAPt/0yMi4zzez8IwkeeTIPoViD0EQLBTRDGCMW1ru9/Ya6M1du3YoFHszMkRLTjoc7zo7+0wmaygUam9/ODMzq1YfZMlAqdQAgFCY7HZ7AQAh1Nh4VCbLY6BoYMCk092lKAoAVKoDlZVl7DKdmPgAAAjxzp9vYL4dAGSyvHPnTtCiamvr9ng+sAOEQhgAjh8/nJm5JRohZmVtra8/BADB4K/bt7vYKVoSCKFTpxZ0FSkwxmfPXnE43gHA5ctnUlMFK2ewogwoijKbrSxiJwi5vJxeG43miCqSy8uNRnNysmDtWhSWAU+p3MNKVG5uNkKIoiir1RURoLZWXlsrX6XncLlCYdLIyLjX+ylWZsfnxwPA3NyPWAEUF+cixCspkUZUkVZ7Z3BwWKOpKSzMiUk/eP78FUXNG43DsWo469evA4Dp6W+xajgpKQK7fcztfh8M/uJyOcwnP3+e6ujopaj5xR2/n/J6JwsKclSq/SsDZGen2+1jfj81PGyTSiXMAHr9o6dPh5bvd3c/Dgcg/3SuXHrR1fU4israjhBi/Y1YMlVcuKB788YBAI2N1WVlBVES/eTJS52uLSw5bcQ6qKs7wOFwAKC5ucNuH4vmdovFdf16BwCQJME+tgiFSTU1FfQM0dR0rb//NfPtz54NXbx4LRAIAEBaWjI7RXS0tt7v6Xmx6GIKxd7MzC3hXosxttlG9fo+mk8AqKjY7fPN0lYaTtHKY8uxY1UJCRvppm8228xmG58fn5Ehot3G5/vqcnkWy4XDIaurK+Xy8kuXbi73fIJhdBwd9bS26p3OceZ2plYrRaIUABgaeqvV3ioqymtoOBoVAB12+5jBYLJYnB8/fqGnGJIkk5I2SyTbSkulYrHo72TKEMFgcG7uJ8Y4Lm4Da52vBuA/na5/A/MBhHlHhwC+AAAAAElFTkSuQmCC"
    m["light_bg_rocket"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADo0lEQVR42tVWX0xTZxT/fS3m9na4uUobWijxMiW4i8FYE4Q3vLotGYIaTMTx5maMBs1eTH2ZSfvKiymZCcZ/CwmJ4Y/OabKt2FRtoaaIm7IGGnK7BimxYKmWXpraXh8+xb0I91Z92Pf0y/nuOec753fuOYdIUhYf82jwkY86B6L4RBSfqFIpUvidLMvXrw/19PwKoKVFaG9vJoQoUSRKOJBl2eXq8XrvL0saG+uOH/9OiQ9FKbp0qZ9aZ1mGZRkAHk/gypXBD8OB13v/5k0vgOJivdP5o9N5Uq9nAdy44bl3L/i+DhKJ5MWL/QC0Wq3dfoTjyjjOarcf0Wq1AM6f70smn7+Xg/7+P1OpNIADB77evPkLKuT5jfv37waQSi0ODg4VXkWp1OLt2yMAjEZDc/OuW7fuBIOPNRpis9Xs27fb4wnMzSXcbl9r61fFxZ8U4mB4+K9MJgOgqamxq+sXv/8hlY+N/RMKTTU1NV6+PCBJmUDgb0GoLyRFweBjAISQ0tISap1hGIZhAPh8oxaLiZZpMDheIAfhcARAZaV1fn6BSuz2H06d+p7iubnEhg1lAMJhsRAOFhelZPIFgIoKs8HwGRUODPyRz8sUl5R8XlFhEcXpROJ5Or2k1+vURfDsWZICo9FQU1NlNhsBPHo0OT4eBmCxGHl+o8lkWK5m1SnK5XKvYywqYlnm9OmjPL+JEEII4flNdvtRnY6hfwOAXE4uoIpe95l8PgegrMzkcJyQpCUALKt7c5UvvJuuX/8pBUNDgWg09o4qiFJgMKxV7WBy8l8K4vH5eHx+5WdOTERsNl4FB6HQVGfnBeVTpbPzQig0pXQeRCIzZ86cfdOCvjl48NsVTPf2/tbX9zslxuE4UVlpXSWCWCzucHRR67W11S0twspv37t3V21tNQBJWnI6f47F4qtEcO5cr9vtf3tNiCDUyzL8/tGOjva6uq0AAoGHLldPQ4NNo4HbPSzLb2tUEBqOHWtbieRt2/i7d0dpj6PD0ud7AECSMt3dV7dsqQbQ3X1VkjJ+/wNCyH+tMwyzffuXq3OQy+VnZ+PR6Mz09OzMzNP6+q0TE5Fr19w0IQCWcVUVNzIyZrGYystLrVaL2WzUajWFDP10eqmjw7Gw8GLNmiIA2ezLdevWulw/vav/qB76er2urW0PNZ3NvgRw6NAeJdZVLF6CsIPjyinmuPKdO3d84M2OEHL4cCttdhQoVVS1/IriNI1AuQr532/XrwBJnHyczZGRHgAAAABJRU5ErkJggg=="
    m["light_bg_scroll"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACWElEQVR42mP8/v03Ay0BEwONAc0tYMEqeuvWg1Wrdj558kxGRoKTk50Yg9jY2PT11W1sjJmYUBzNiBkHa9fuWr58y////8lwr7a2SnV1Jjs7G84gunXrAdmmMzAwXL16Z9Wq7fiC6NChMxDT8/Pj7OxM8Rs3efKS48fP5+bGWFoavnjxprq6/8OHTwcPno6N9cfpg48fP0MYtrYmBN178OCpnz9/HT9+kYGBQUJCREtLiYGB4cOHT4QjmYGBgZGRkaAFEL8ePXr26NGzaII0TKbIMYzPBxDw4cOn69fvoglqaioLCPDBuSIigmpqCnCfW1sbkmBBdXX/ixdv0AQlJUWnTKmDc9XUFIuLEwdZToaD1tZCrEFENQsEBPgsLQ1p6IMTJy4cPXqegQE55TFaWxtaWBhQx4JJk5b8/PkTTfD8+avEW0Agki0tDTAzoLm5AdWCKDc3Jjc3ZohUOH///jt//tqbN+8h3OPHz+PSw8rKamioxczMRJoFK1ZsXbduF5zb0zMPj7agILfoaF/SggizSMAD0BTfvfvo7t1HxEZyUJCbuLgINzcHVg2YPrt791F5eQ8DA0NnZ4myshxOC9jYWCEMX19HPj4ePBHw+/fvT58+v3//ESLy8uUbWNH7GV8QqarKQxjTpy/7+PETLgsgJfPVq3c6OmYjizMzM8NNwN6q+P79Z2Fh2+vX78hLjp6e9ikpIfh8wMnJXlWVISYmRIbpVlYG8fEB2KtetHbRjx8/Dx8+e+PGvV+/fuFvZgkI8L5+/Z6fn9vUVE9PTx1n3T7a+CUEALfG4HIzgnXNAAAAAElFTkSuQmCC"
    m["light_bg_search"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC20lEQVR42t2Wv08aYRjHv6/c0oZYFX8ciDYBWjvo2YVDY7qUkjiJiengAEtZ3DEupn/B7S6kiWfs0sWDsWAXDaAk6NW0khhJbBAQhGq0Gj24DtcQ2yh5sTq07/Tc87z3fO7e75PnfcjZ2SXuczXhnte/D2DqxBRFicfleFxOp/cOD48BGAyPLJYeh4PjeY5hGBoAuUnkaDQpisGDg+K1UZZt93jcQ0PPbwOoVquiKIVCyzVPd3cXy7YDyOWKmUy+5h8bc3q9bkJIY0ckikuh0CcAOl2TyzXidr/s7GyvRfP5Q0mKhMOrlUo1GIwQAq93vIE/iEaTgvAOgF7/cHra19//5NrXZDklCIHT03MAMzM+nh+kqiJFUUQxqH273//mpuwAOK7P7/fpdE0ARFFSFIUKEI/Lmqou18jAwNP66nFcn9M5DCCbLayvf6YF1NSjKUG3+5VmrK3JVIB0eg+A2cx2dRloACzbbjJ1AtjZ2aMClMvHACiz1xgAyuWjBlqFqqr0gEpF20yoAC0tzVql0wMKhSKA1tZmKoDV2gsgk8nnckWa7NlscX+/AMBm66UCOBycZgSDyzQASfqoGTzPUQF4ntNEC4dXZTlVP/vm5nYkEgNgNHbY7XQAhmE8HjeASqUqCIE6jI2NbUEIVKtVAF7vOMPobtqpm519e/XZbGbPzy9SqfTlpbKykiiVjsxmVq9/ePXcFxel+fmli4tf7WFw8JnF0tNAu1ZVdWFBkqRIzWMydRiNnQCy2QNN1d9SEDI1Nam1jQYunLW1zfn5pZvKyWjs8HjGT05+zM29V1WVEOLzvR4dfdEAAICiVNbX5Xhc3t39Vip9B9DW1mK19vA8Z7dz2rlHIrH6DPL3c1F9xp8i32JZLGaDoTWR2FJVNZn80tyst9ke3/HY4nQOTU1NEkJUVQ0EPsRiG3c/FzmdwzVGMvmVai66BUOvf5BIbE1MuO5S5P99Nv0J1yBFOdlFIzYAAAAASUVORK5CYII="
    m["light_bg_server"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABi0lEQVR42u1Wv2vCQBR+uaTxT2hLqjaCQ3GRCMXNoaU/oKBDMjj7N6T/g7o7tHTslOKQpULJLoGgtEjHBFEL7mKNuUsH22ClscYibSHfdu+O971737uPo8bjKWwSCDaM/0/ALKw1ramq2mAwJIQEqxSheJwTxZNsNj0fp+ZF1rRmrXb7w5JluTTP8ekGqqoBAMtuCUIKISpQXsdxDKODMbm7a/gSDAZDABCElCyX1qi9XL7W9cdu98VXg1nfEXpX3jR7AC7PRwEAY9JuP9u2vZCUZdl0+oCmEQAwDA0AhLjLRPZgmn1ZrgBApSInElFFuVeUxpcnRfG0WLz4M2Pqgee5avXSa5EknSeT+34tWpUAIUQIcZzpB8eet0XTKJNJfTdIMwkpX4JYbNey+obRKZevGIYJOKak1eoAAMdt+xJI0lm1eoMx0fWntZteKBz7vmQAaDbb9fqDZfUwDmwV0ehOPn+Uyx0um6LR6HUysV13LeNEdCTCLgRDLwq9KPSi0ItW8CIq/Jv+OsEb6l0JyyXcsw4AAAAASUVORK5CYII="
    m["light_bg_share"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADQ0lEQVR42tVWS0wTURS949AiLdqgWEJJhRZC+CwMgQSDVAzfWruA0PLZSQmwJoTPgrgGwnfBAhITNDEQYMUnVEAaKRIIEFKMqSUpI78SR7EFS4cC47h4MCgRkXZY+FYn972cm3vPux+Mog7hKs81uOLj4z2F07m3umoDgNBQib+/kEsHFLXf3T2s10/S9A8AwHFcqVQUFqr9/HzZN5g3GrS0dE1NLZwxJiXFVVToONBgbu49YheLA4uLtcXFGrH4FgBMTy8uLHzgIEUmkxmB6uqSsDAJAMTERFRU1AHA4qI5Pj7W2wj29igEQkLECEgkx8DlorxNkc1GWq1rCI+MvEXAaJxHQCy+7bnIDsdub69+fHyapuljCgyiosIZhrFYCIZh+HxeU1MNG80lNHC59gcG3gwMGNxuN7IEBgZsbzsYhjGbrSfOMJ1Ow7L/wcHBweHk5DxBrAOAXC5VKBL4fN7REW0wzPb0DDkc31lqjUaZlnZ/eflTf//rlZV1DAO5XKrVKiMjZb8S/pYigthoaHhOkl9ZS1BQoFKpGB2d2tr6giz+/sKcnHSVKoXP5/1L3KcOKMpdVdVgs5HnPfX19VWrH2VnpwsE1z3pRQbDDGJPTo7X6XIBmLa2lyaTBWU2IyMpL+9xQIDI826K8g4AJSVakeiGSHSzvPwpsiQm3isrK/CA/YI6YBiGy3kgk91FoLOzz27fsdt3mpu7kGV21tTR0WO373jg4FTk/X13ZSX3IuO1tc+O5fbxiYmJWFr66HS62Ovg4Du5uVkkue10umiaNputY2PvMAyTy6U4jl8uArbQjMYFgljDMEwmkyoUCTyez0mhDTscu2cKzWIh+vr0BLEBADKZNC9PGRUl/5sDz1rFKR2GlZbmZ2Y+4LjZRUdHAIDZbEXNrrGxhu3hHo5Mm42sq+vY3CQBoKgoR61OBYCJiZn29lcAoNUqCwqeeDUPJBJxePjxt87KeohAcnI8AiT5jYOZLBT6IYDiAIDNzc8ICAR+HMzkuLjYkREjANTXd6jVqQDM4KDh5Cqam7WltfUFOybPW1u8ckBR7u7uIb3eiH4UjuMqVUp+voqzxYtdHdfWttDqKBQKLqjk/2+7/gn9ropw9EPo8AAAAABJRU5ErkJggg=="
    m["light_bg_shield"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD4klEQVR42tVWbUxTZxR+bgs0uDIE7vqxOlBIhQ6Z1kLbmCqgieh+Wj9+qDGYzBhwzdQYMakmVDLjiGERyRIzjS775UR/Leo0FikptKEdASFKJlOUFmjX0oHctra9+3GX7q5cKF8u2fl3z33Ped7zvOe870NQ1Du8T+PhPVvK/JfSND009BpAfv4nBEEsJ4DPN9He3v3okdXt9gAgySydTrV9u04szkkaS8xxBuHwO4fjaVub3ekciMViiZEEUVi4pqJCo9Op0tMFCwCgafrZsyGzuctq/ZWiQnF/erpg0yYlAE5/ZaW2qCh/JnX/ApicnLp/v+PJEztDRXynJSVrKyrUWu0GgSANQCgU7urqaWuz9/UN0jQdXymVflRert6xQ5eRIeQGMBgaRkbGEgIqK9Ukmc1ZvtfrM5vtCRuSycSXLxu5AfT6L5OWzNldCZS2tjbP1UVKZXFNzf75ty9BEApFgUJRQFFhq9X5Xw/a4gHcbu+VKz/abL3LNsls8/sD9fXNHo/PZuvVaL5Z5grevqXOn//O4/EBUCo/XRJFgcCk0zkQjcbY433x4tVXr0YAFBXlHzu2f0kUGY3fulzjavVnJ09Wp6Sk0DTd3PxDf/9vAFatkpw5cyQtLXUBFQgEAgChUIjd5QDs9t7GxuuRSOTatZ+s1h4AOTkrz56tFQo/YIcHg0FmjGYFyMzMADAxMRn31NUdzcrKBNDd3Xf8+Nf37lkACIUrjMYaklw54+T/jCfhBsjO/hCA2+2Jky6TierrDQyGy+UBkJqaWld3JDdXmpA9EomOjnoBMIu5AYqL5QCmp6nBwd9Zd8s/GDwe78SJQwpFwUyunz8foqgggHXr1s4KsHHj3z338KGV7ZfJRA0NX23dqjl16rBavZ7zMOMh8SQcAIWFa/LyPgZgsXQPD7vZvyQSsrb2wGzZX74c6ehwAFi9WiaX580KQBDE3r07AcRiscbG75mSk1owGGpqusE8DPv2fZ5wAScOmkazXqUqBuByjTc13QiHk4iaUCh86dL1N29GAZSWlpSVlSSZZIIgDIaDIhEJwOHoN5la/P7AHGLAZGpxOgcAiESkwXAgyZPJvilNppbxcS/T9dXV+vLyMnYwTdNms+3mzbtTU9MAxGLy3LlaiYRcgKrw+wMXLlx98WKY+czNlezaVaXVbgDQ2dnT2vqAoQWAXJ53+vQXCe0/L9kSiURv335w584v0WiU8QiFKwAwuwbA5/N3767S66v4fN5idFGcrlu3frZYHGwBwePxNm8u3bNnp1RKLl54sW1s7I/Hjzvb2x0AtmxRbdumZRphScru/6Gu/wJcJ7QkP46iGgAAAABJRU5ErkJggg=="
    m["light_bg_shuffle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACyElEQVR42u1WS0gbURS9M40MgsZI6IfYUIy2IHVqxcSYRSA1lMaFBbERRFclmxBwJ1iIP1yKQQtmNsFNiyLThatWKONOkpg0ifVTF4UErGOxi5B2EcdM8rqYdqL524477/bOO+ede+67d7BkMgVXGThccVwTCJFOZ0Kh/UTiV35KJgkBTX+g6fX6+rrp6ZGGhlvSK0AIAUA8npicfH10dCI9gdXa09lJChwTE/OHh9/FFCa8g0Tip9M5z7I/zh8jCMJme9Hd3VUCemPD5/G84zjuwq1x3OV6pVbfySqIRtkcdADgOM7tXmYYbzF0hvG63cs56ACQyWQCgZ0LJpPkg/7+Z8fH2fLxfDoQ2EEIUdQKAJjNhnx0ilpBCGEYptORqVRqb+/r2VkKAFSq2729Ty6UqMgFfRS1LEDYbFaLxVgs1dbWMj4+H48nAECrJUdHX8pksvImm81ddvsghmEIIY+HFmvl80VEdLt90GIxrq19LIhevovMZoPIQVErAkc4/EVEF0rX0fGwupowGrU56GVKVLDcdvsgSd6n6XWttlWvf1z2LFbhuC7hR+m44XROVPKdRnNXqawPBncRQuHwvlxe09x8T7Jh5/dHFhffkmRzQc//VwHDeBcW3kSj3zguNTDQo1QqBB3B4K5SqdBo1ADg938eG5uNxVidrhXH8UsoOG9ve3tLsb4KhfaSSW5z89Ps7BLP85UqYBifiG6zWU0m/V8/1KIfweCuXF5jMum93sjpKceyJ7EYazC0iTr+dFE6nVldfV9wVJzv98pHhcs1VlUlyxJEIgczM4sFurgIeg5Hfmp4+Hlf39OsB42NKpXqZs5HBEE4HEPF0AU/HI4hgiByWxPHdbpHl3topYPn+bm5pa2tHQBQKGqnpkaEZSDhTl4X0PPXsjQrE8OwguiSlSidzmxvHzQ1qevqav9x2F3/Ol5d/AarFqFCawqTWQAAAABJRU5ErkJggg=="
    m["light_bg_sign"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABVElEQVR42mP8/v03Ay0BEwONwdC3gAWZM23a8n37jv///58MgxgZGe3tzXJyohkZGXH6gGzTGRgY/v//f+DAyVWrtuPzAcR0ERFBNTUFUi04f/769+8/Vq/eoagoY2amh90CCFBTUywuTiTVglOnLnV1zfn///+kSYs7O0ukpcWpHMlmZnqurlYMDAzfv//YtGkf9VPR69fvTpy4CGHr66vjC6I3b94fP34eqykvXrxlYGCQkBDGlFq7dtenT18YGBi8ve2trIzwWXDr1v2envvk+UNbWzU+PghnMpWSEqMklERFhUpKkpiZUcxkRC7sPn78fO3aHVz6b968v3nzfgYGBl9fR3V1RTRZZmYmTU1lXl4efPmAn5/X0tIQjxshFqirK+JXNlqajlowasGoBSO7XYQfSEiIQdo8EhIkVBuMJDV+799/wsDAoKgoQysLBmMcAADTA3AAZObBvAAAAABJRU5ErkJggg=="
    m["light_bg_skull"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADqElEQVR42s1WX2hTZxT/fbk2vbl1ud429k8qqcH+obnVpNRWygSRslQmHUjFlk3G9iJu2IGtDxb0QaXKhhOftrUPG3uS5HlYBCEI06ozbQptE7O20ZDV/klJlrZJadp+e/hYGElubhwVPE+H33e+87v3nPOdc0gikcS7FA3esezK0y4eT7x+PReNxjQaotd/UFVlFATdDhBsbCRdrmcu19Pp6SClNIUTQqqrq9raWo8da9ZqC3J4IDly4HZPDg05wuFIjvulpcXnznU1NlremsDpHHY6h9lXFxTsslrrLZYDBsMeSunSUtTnm/V4pjY3t9jfdHefPH26/S1C5HQOOxz32eX29qNnzpwQRX2aTSTyt8Nx/+HDEUrpvXu/EYLOzva8/sDtnrx1a5BSqtUW9PZ+2dx8MEeInj8fv3Pn12QySQi5cuUrm61epUw3NpJDQw5KKSFE1TuAlhbrxYufE0IopYODzmRyU4XA5XrGsmq3H1X1zuTIEVtbWyuAxcXwo0d/qBI8ZVnt6jqR/2vq7v6Y47jUdcUkr63Fp6eDAKzWelHUb21tP3jw+4sXExoNaWpqsNs/5DgNgExckkSrtW50dMrvfxWPrwsCn50gGHzD6tJiOQDg7t1fnjzxsKOxsSmvd6a39wsl3GKpHh2d2t7eDoXe1Naas4coFlthSkmJ6PcHUl6YPH7s9vtfKeElJXv+Ld+VvFpFIPBXNjCkYBzS6Xj1bpp6TUtLkeJiMdPaYJCU8MXFZaZLkl6RwGQysjSOj/saGmorKvb+99Ro3CvL1Uq4x+MFwHGcyVShSCAIvCzXAJiY+HNubqG//7ws1xBCCCGyXHP58nmeL9TpCjPxUGje55sFcOhQHc8X5moVbvfkzZs/ATCZygcG+gSBTyTWAWSGOIXH4+v9/d+HQvMArl79Oq1bpD+0pib58OGDAILB+YGBH1dX13Q6PmsCGb6ysnrjxg/Me0uLVb0XAejp+cxoLAXg88329X0bjcaUKi0ajV269J3fHwBQWVl24cKnec3k3buLrl//Zv/+SgDhcMTrnVEi8HpnWOMym/ddu9ZTVCTkO/QlSVQaIFmls9MuSeL7ulXcvv0zAIBNfJKh/18CrVabNvsU9KzGeRDYbPWnTn20sBAGsLwcffkyAKCuzgwgpbMGV1ZmyKxOdQKO05w9+wnTR0bGmNOOjuMpgo6O462tjTuz2ZWXlxJCmMJWjZSuKiTP5Zc1arN5X5q+YwTv73b9D/nwjaKYMT1tAAAAAElFTkSuQmCC"
    m["light_bg_sliders"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADEklEQVR42u1WX0iaURQ/fimWpstM127+SXMoZbH156EwVutpg7anCDYftpdBkIMioj3sIfewIOopAl/qKSLYICifNlwbmROyljRwINqfr68/Yk7JPrJpe7hhomU2jMHYefj4nXPuub/vcM859zJo+hiuUwi4Zvn3COx2p17fMzo6mbo0GAwZDEaDwRgMhlK9o6OTen2P3e68hMBqXaLpI4vFlrqFy+WhKB9F+VwuT6rXYrHR9JHVunQJwcnJSfybJIeHRxjQdCTVe1FgpmdgNs+ZTFMYm0xTZvPnbB6yzbY8Nvb++Pi0YyKRyNjYO7v9W9YIZmfnACAWi7pcNpfraywWA4CZmblMYpmZLFpfpwDA79/yeFYAQCgsEYmka2tbWctAKCwAAB5PyOHwOBw+j1cIACJRQdYyqKurJMmd3FxuU9PTBGNV1jJob39YXq5KtFRU3G5re/AnBJHIabFHo7G4kcViGo0vW1ubsdra2tzfb2CxmFcjCIfpoaHxxcXvWO3ufut2b8S9DAZDrVZgrFYrGAzGlfvAZJpaWDhrdJLcGRgwhUIH2Rl2gUDQanUAwMFBwOn8RFFuAAgEQvPzjkx28Xg2Mdje3g2HD88hwJUOAB7PCkn+WF39kmRPI9PTH3t7BzH2erc6O994vZvJBIWFAgyKiiRMJksslid2QBpxuzcmJmYSZ1wodDA8PB63nFaCRCJGSERRPoRUCJ1WZE4OUVurTU/gcKziybG8/GFvb72ysgkhFUX5SHJXKi0+y4AgiO7u53x+/llqBKHXP1YqpekJ9veDGPh8G9HoL7+fxKrf/zO5ihQK6cjI69LSEqwODvY+enT/0gOQyRAGWu09iUSjVN7Bqlx+65xG43I5CN3EOM6UXhobawQCPgAgpKqqauJyCwCgoeGuQHAjO5c+n5/f1/dCJiuOW3S6mo6OJ9l8VahU8qGhVxjX1mq7up5xOLkXEuAZcO4kIAhGEkisCBzCZrMvGXY6XXVeHrulpT6VQKMpQ0iMkFijKUv1trTU5+Wxdbrq5D/+/zb96wS/AR0yHxBGw4ROAAAAAElFTkSuQmCC"
    m["light_bg_sparkle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACrUlEQVR42tWWT08aURTFzwOkKrBoo8akbSImslCbODORhL/SSE10oXbvxk0/QdHPILJ20cS67IJFZUMbJQZBMGJmhrSWJkgcY+1GTbsApQ4M08W01LQWgw6mvav3bibze++8e24uKRZLaGRo0OCoDyAIh4Jw2ChALnfg8/l9Pn8ud9AQQCSSkGVZluVIJKE+QBRLySSnrBMJXhRLKgNYduf09JuyPjsrsuyOyoBodLvG9qaAQuE0nc4AsFi6enq6APB8Jp8vqAaIxdhyWQLg8QwODVkBSJK0scGrAMjnC+FwLBSKANDptHY77XRSOp0WwPLyajgcu/Ie5NJWIYollt2JRrd5PiNJkpK0Wh/Nzj4DMDf3IpV6ryS1Wi1F9Xo8gwzTr9c3XQ3Y2/u0srKRTHLVmlHOTtN909NPOzraABwdnSwtvea4D4puShgMzXY7PTLi7O5++FeAIHyemfFXKpVqxmLpcrutLhdtNBr+fPl4nIvFUtns/i/FNRq/f8Zsvn97ze52JWrEI+suvZde32SzUTYblc8X4nEuFIqcnHzluB/m4rgMgLa2uxMTXpeLNpmMNSTS1VbQZDKOjbkBLC4Gy2UpmeQqFaIoMzn5ZHTUpY6T3W5GMVc0ur2+nlKUcTop1VqF0WgYGOgFkM3u7+7uA6Co3t+UWVh4NTX1fGvr3TW7qcczWGMLYG1ts1g8TyS4+t6gGgzTbzA0K7Xb2trCMP1KXpIq6fRHURRlWQZwfPxlc5Pv7Gw3mx/UB9Drm+x2enU1CcDhoKoVGQy+CQbfVj/LZoVAQCCEzM/PKn6uw8ler4MQQgjxeh3Xd/KVYwuA6vUvShQIvARgsZjHxx9fRyIlLv76p5M1DNMHgBAiy3J7+z2bjWrIZDc8bGtpueN00jeS6P+fTf9FwHcXe1iaJGiRUgAAAABJRU5ErkJggg=="
    m["light_bg_speaker"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADGElEQVR42u1WW0iTYRh+vn+bodAOkUPEw0xbarqsiSOFEWQX6YWKpEKltAsvYgOHXg4EWTd6oWAEhmjJLtTwkDA6CCEehgdmYmrKNJ2lA5dsLnTGNv8ufpHpps3Ui8CX/+L/3+973+d/T8/3EafThbMUCmcs5wD/FYDZvKpUVqlUVRsbjtMHmJoyaTR1Fot1ddU6O/vNe8nj2dHpenS6Hrfb7WvIDsT70JCxvl7ncu3a7+zQ3qsTE1+7unoBWCzWigoFIeR4Eej1fbW1r/e8+0psbKRAwAMwPDzBIAUKQNN0U1NHU1MHTdOEEInk2oHMGI3TdruDz+dWViqDgy8AaG9/v7b289AUjYxMDg4agd0MrK/b5+YWAXA4bJXqEUVRk5Nze5tbW/WdnR8FAq5Wq46MDCsuzmtoaHW5XN3dn0pLC/xHUF/fYjCMGwyfmYfxHhISrNE8zciQ+o3SZnPU1r6iaToz87ZQeBlAf/+Ydz73ATidvw/Yx8REaLVlSUlXfV0XFt5PThYDmJ83j419oShKLpcCcDq3Taalo7ooPf1WefmTvxafzWYrFA/U6mcARkcn09IkCQlxwAcAS0sriYlxpzDJUVFhfD4XwMrKGoDQUAGjt9t/nSJV0L4q70k4EcDysoX52YgIIQCr1cboeTzuUTUwGMYNhvG9IqtUj6Ojw323ud3uxsY3zHta2g0AMzPzzKdIFO4/AmZYvGVx8YdGUzc1ZfIFaGt7Nz1tAiAWi1JTkzyenYEBI9PWYrHIfwQqVbHvoG1tObXaF0rlQxaL5QsjEHDV6hJCSG/vIDPDcnkqm832DyCTSWQyiTdVNDd36vV9Lpe7rq6F6fo9KSrKjo+/Ehsbyedzl5ctOt1bAEFBnJyczEC5iBCiUOQrFPmEEJqmvXkCAItFSaXX+Xyu3e6oqnrODGlBQZZQeOl4bJqdfUetLuFwDiX2hYXvNpsDQHr6zdzcu/9yHmRkSHk8bnX1y83NbQAUtY/xU1IS8vLuASgqyjpwGAAggV+8zObVmppGQohWW8bjXQzQipzf7M4BTix/AHdyPRtPgFVUAAAAAElFTkSuQmCC"
    m["light_bg_stop"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABRklEQVR42mP8/v03Ay0BEwONwagFBAELVtE/f/4cO3b+zp1H799/JGgEFxentraqjY0RExMW5zJipqKnT1/19s57+PApSS7V0VEtKkrg5+cjEER//vwhw3QGBoYrV2739i74//8/gSA6duw8xHRjY+309HBhYUGCRr969a63d96dOw+vXr195swVU1NdfD64c+cRhEGk6QwMDGJiQnl5sRD21at3CATR+/efIAwiTYcAaWlxCOPt2w+jGW3UglELRi2g3AJhYQF4rUC8KW/evIMwBAUJ1QdaWsoQxuTJi169ekOc6R9mzFgJYauqyhOo0f7//9/cPO3ixRtkhIaionRHRwkLCws+HzAyMubnx+roqJJuukxxcTKa6djrZAYGhn///h09eu7q1dtfv34naLSgIL+amryFhSELCzNRlf5oPhhuFgAAR7d8TGtBXIUAAAAASUVORK5CYII="
    m["light_bg_tag"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC8klEQVR42u2WXUiTURjH/+8cLUlR/JiJmIgfSCnLNjRmF4qYN0EXQmFXpqjZhSDDi6HOOWQXwmRazYbaF5QFil54YzKQQNElg02tTCXRxjadbjNzbX68Xby2yN5t7zvwIui5es7hnP/vPOd5zsMh3O59nKZxcMr27wO4Pm9mxtTV9cLj8QTekJgYL5XeS0ris45gctIQVB2AxbLZ2tptNm+wjoAkScoRi3P9rbbZtlZW1hwOV2trd1tbPZM4uH9PSSSV/lYfHByqVP16/ZzD4ZLJ1HJ5fXLy+RCTbLc7NZqXDQ1KhUJjMi0eH4cbJpFU5eXlAHA6v8nl3evr1lAAe3s/ZLIunW56bc1iNH5UKB7NzX0OjUEP0OuNNpsdAJ8fRxAESZKjoxO/r5UNgx6wve2inIqKm7Gx0QC2trb/SB1jBj0gLe0C5XR09NvtDgDp6Skny4MZgx4gEGQVFub7hnx+XHn5DZoSZMAgfN1UpXo6NWUAMDT0gJoxGj8tL6/FxESJxbk83pmgtQsgOjryRO0G6kUCQVZZ2fWiovwA6r/iqBSJjuNoa3totdppAARBUM7g4BjrjsblNjZWpqYmA3A4XMPD4zSAgoIrHA4HwMDAqFb7+ujoiBVjYuL96upX6qBC4UWaHADQ601q9XOPx0vdT2NjVXj4WSbqOt10T88rkiQJgqiuvlVaeo0eAGBpaVWp1O7s7ALIyEiRSmujoiJDVqcBALBa7e3tGotlE0BCQlxLy/3ExPjQ1OkBAJzOHaXy8crKOoCIiHNNTbWZmakhqPsFAHC7PZ2dTwyGDwB4PJ5EclcovMRWPRAAwOHhUW/vm/HxKQAcDqem5nZJiZiVOoCw5maZ30bIIYTCbAALC8skSc7Oznu9+wJBFnP1IBH4bGzsXV/fEPUycnIy5+eXKPW6ujvFxVcD7yUY/uxmZkxq9TOvd9/37JmoswAAWFz8olRqd3e/M1dnBwBgNm+MjLwVibLz8y8z3EL8//wGs58R6aGOXMEKNwAAAABJRU5ErkJggg=="
    m["light_bg_target"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAFkElEQVR42tVWW0wTWRj+p0wTLwV6A9l1QcCoBLfFgi0pCDUpAYxGUYQEohKM8qSQuA9gYjRBkhWzG4IP6wOIBo1NWC5L1CC0m9gANdSNFUuI0GBbtlixl+kNWmHa2YdTR0AE3awPe57mnDnn//7/+6+Y378I33Ix4Bsv/Avveb0+h8PjcBAYhvF4bB4vmsXa/B8AWK12tVr77NlLk2lmxa+kpK1isVAmk8TF8deQgH3OB263p6PjsVKpCQaDa7yPiIgoKMg+frwwOjryKwAmJozXr7e4XF603bRpo0iUmpDwHY/HBgCn02U2W3W68fl5P7rAZkfV1p7ZuTPpiwA0muc3btxdXCQBIDaWX15+UCoV4XjEimskSWo0LxSKB+/eOQGAycRrak5JpaJ1ACYmjFeu3EDSCwtzKiuP4fhaflpcJNvaOgcGhhFGfX31CjuWAbjd3gsXfkbMVFQUHT4sR+cm0xuVSqPXT9hsBADExHDS0nbJ5Vnbtn2PLvT2/tne/gfiqqnpYlQU66OTLl26TG/u3u0dGzMAgFyedeLEYaTgrVudN2/eNxhMHo8vGAwGg0GPx2cwmAcGhj0er1C4i8FgpKQku92+qanpQOD9wgKZnp66SqJZrXalUgMAW7bwq6pKkPSGht/6+wcpigIALpedkbE7I2M3l8sGAIqi+voGGxpukiQJAJWVx2JjuQCgVA7NzjpWyQO1WosisqzsIOL99u1uZBCXyz57tkQsFmAYhkRrtfqWlg6CcOv1k3fudJ85U8pk4mVlh5qb20kyqFZrS0sPrLRAq32JIlIq3YN4HxgYQtKvXbsgkQiRdADAMCwzU9jY+BOHEw0A/f3D09NWAMjKSt+8eQMtahmA1+szm2cAQCRKReqrVBrETFVVKY/HCYVCnZ39587Vnz9f39XVHwqFeDwOYjIUCqlUGgDA8Yi0tFQAMJlmfL65ZQB2uxt9JCaGA0Ovn0Dq7937IwB0dysViodWq+3NG9v9+w97elQAIBYLkRGjo6/QKxRXFEXRAsMABBHeowcA4HAQqOAgZgYH/1oa3UNDzxBXSUlb6ctLnxOEaxnAB3ohFKKWCkIsrbE+/MfoA9pPywBoZJcrbAqPxwEAo3EGYeTmipfKzc2VIHiTyQIAMTFsdO50rmQC/yAuvDebregjLW2XxfKWINxarT4zU3j0aB4APHkygmHY/v2SoqI8ABgZGSUIDwAIBCnoFQonDMNogWGAyEhWYuJWk2lGpxsnSRLHcbk8q69vMBQKtbR0bN+ewOezi4vzi4vzaSPsdmdr6+8AwGAw8vKyUWLqdOMAkJz8A92OPuaBRCIEgPl5v0bzAsVDfn428n9d3S9a7SjtD4qiRkZe1NX9itQvLNyXkBCHyrDfHwAAsViwSibLZJKuroFgMKhQPJBK9zCZeGXlMYvl7diYgSDcjY2tHE5UcnI8AExN/e1yedArgWBnRcVRAFhYWFQoHqFskMnEqxQ7FmuTx+M1GMxzc36n0yWRCBkMRk5Oxtzc/OvXFoqiAoH3VqvNarUFAu8RM4WFudXVJ1Fitrb+rtdPAsCBA7J9+/auUa6vIe1OnSo6ckROu06l0uj1r+hyLRCk5OVlI2YAoKdHde9eLwBwOFFNTRcjI1mfbTiTk8bLl8MNJz8/+/Tp40zmWg1nYWGxra0TlWEmk3n1avWOHYnrtMynT3XNze0IIyaGW15+KCtL9GlfI0lyePi5QvHIZkMtk1lTc3L9lknb0djYSnty48YN6em74+Pj+HwOANjtxPS0VacbRzGDmKmtPbtC93XGFo/H19HxWKkcIsm1xhYcjygoyCkpKVjK+xcBoDU761CrtVrtS6PR8sngFZ+ZKZDJxLGx/2rwWrF8vjmHw+1wuADgq0ZH7H8/Xf8D/ku5aZ5o6MUAAAAASUVORK5CYII="
    m["light_bg_trash"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACWUlEQVR42u1Wz0sbQRR+s7ukuDu7nmpR00OQSlusikVSD572UFp6VEIOvRQ8eBAq+CfYm7cQjz2IUCG5ltbLnkLKQn+IID0UUWyyyuol2U2XbLDTwyTDUrLZWW0ohc5p3nvz5pv3vfdmBnleC/o5BOjz+PcBpMgVl5c/9/a++r7/mz6RSExP3xNF4boAhcK7QuF9V9PCwuNs9tl1KapW7TCTZdl/gCI21tZesPnGxmtOLxTsg83NN4bxgRACQKg1TjoJAEII6frc8nK2O0Xl8mdC2NYoZr0gACCElMtfQilaWXleKn2q1ZyDg28AkEolh4dvRm58emofHVUBYGLijqap8/MPQwHS6cl0evLk5Gx19RUAzM4+yGSeRgLs7LylAEtLmWTyVnQVaZpMJ67b4KHGcdrLVFXmKlOMFYQQANRqbU/T3M/nt237goq2fZHPb5vmPhXr9QYAIIQwVrgAJEmU5RsA4Dgu1eRyW4ZhFou7VCwWdw3DzOW2OhG4AKAoA127unujqSoOAnheEwA8z++IPlOyCFRVidHJHYAf/DmgLrwAmqYAQL3u8gNoGo4dge+3mk2/9+6e12y1WmEl1ANACSaQr0bx1QAaUQBukFX+HOBghfQjAjl4wJGRIQAYHR2iSjqhSnYC1v9c7wE7DvVfX395ePh9auouVS4uPhkfT42N3Q5SFBZBBABlYHBQnZm5z6yiKDAxkiIpJAfteEulj5XKWY8cHB9XOgADMQDofUcIsaxzyzqP/vwIAsZxkixJoq7P0Ts1+iVDSNcfhf1f0P+/6V8H+AXENugzsZqkegAAAABJRU5ErkJggg=="
    m["light_bg_trophy"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACw0lEQVR42mP8/v03Ay0BEwONwdC3gAWP3PHj5ydNWvzrF75IYmNjzcuLtbQ0JMcHx49fxG86AwPDr1+/jx27gEcBI3Iq+vDhU3V1/4sXb9AUWVlhd+CxY+fRRCQkRFpbCwUE+LAH0eHDZzFNZ2BgKC5OwmFBLprIixdvjh497+1tj92C589fQxhmZrosLCw3bz54+/Y9Pu8zMv7//19IiF9DQ+nPn7+nTl1iYGB4/vwlzjhgY2OFMCIjfYuLk9TVFYlJJxoaSsXFSWFhXjBD2HBaoKWlDGEsWbLxz58/xKfF37//LFu2CWaICs5kamysIycn8ejRi7NnrxYUtP3//48Y0+/de1RQ0AqJPHl5aSMjLZw+YGZmKi5OgaSB589fv3jxFiL+8+cvTHO/f//5//9/BgaGFy/eQkwXFOQvLk5kYmLClw9kZMR7espcXa04OTnggpcu3cS0AFmQi4vTzc26t7dMWlocXz5ABv///7927XZd3WQGBgYZGYm2tiJubk647Ldv38vLe549e8XIyNjUlKepqczIyEhaTmZkZNTWVoNksSdPXlRV9Z06denHj5/fv/88efISxHQGBgZrayMtLRVcpuPzAQR8/fqtpqb/0aMXcI9BdEE48vJSLS0FXFycxBYVWMGXL19nzlx1/Ph5SJTC/WdtbZSeHo7fdKIsgIBHj16sXbvjyJGzDAwMNjbGISEesrIS1KwP5OQkLCz0IWwLC30iTadHhUM4iF69erNq1Y6fP3+9efPh1q37DAwMamqKIiIC7OxsYWEeYmIi5NdoELBmzc79+08ii9y6df/WLUhUM2Rnx1AaRN+//8Il9ePHL4rqZDSwdu1kODskJA851Q7iSJ42bfm+fcdxOZaRkdHZ2TIzM5J8Hxw7dg5PUPz//x+z3ictDnJzY48cOQsrgrD4wdbWmDpFxQhumwIArosmDpRkCR4AAAAASUVORK5CYII="
    m["light_bg_upload"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABnklEQVR42u2WsWrCQBiA/+g5FnER0S6B0sGSSfEVKrTQgijioCAdQxeJk43oqoNon8I8QH0DN7tlkEIGSWiDcJ4ZHEqkw4m11mgSKwj1n477776Py939OWY2+4RDhgcOHP9KoKo6z9d5vq6quv1ZjM1NVlW9Wm1jTAAgEPDXao+RSPDPVrBKBwCMSbXatrkOj1O6U4fH0ZehnbRh07FNoGnf9FjsKp+/o/2Fwn0iwVGHKLZGo3c3AkKmorigx+Ncufzg8yGaQshbKhXjcQ4AJhOjVnsmZOpYoCjaki4IRYTQahYhJAgLB8ZEUTQrDrJKcNxlKnUNAJlMco2+6uh2e3SwY4HX68nlbrdvIEJo55hTsTsyASHGYCCb5twdyzTng4FMiGF5iiqVlqbp6XQym71xIZCkF0nqhcPBTudps0DTdFp/Ns4PhYIMw9CGReH6WEJ234PfwbKRRqNMG9v+MAzjUgAALHt+dKdowwrGY9zvv7pgjcfYlmA4VJpN5SD3IBwO7k9cg/x4VRBiyPLbnoJo9MLvP3P8bDkVu8PFF9OtwHP5514XAAAAAElFTkSuQmCC"
    m["light_bg_video"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACCElEQVR42mP8/v03Ay0BEwONwagFI8ACFmTO16/fDxw49eDB4x8/fuHXxsjIpKgobWFhICkpSkAlPB88evS8tXX6mzfviXcdOztbTk60lZURsuC9e48ZGRkVFWVQfPDv379JkxaSZDoDA8PPn7+mTFmmrCwvLi7MwMDw7t2HBQs2HD16lpGRsbu7XFFRGmHB06ev7t9/ysDAYGamn5cXy8nJjt/of//+bdy4d8mSTT9//jxy5Iy/v8vOnYeXL9/6/fsPBgaG////v3jxCsWCZ89eQBg2NoYETWdgYGBiYvL3d166dPP///8vXbp56NCZJ09e4EtF//79h+skNv3BVF65chtiOicnu4mJDjWT6f///+Fsa2vjSZNqHBzM8CVT8gAHB1tFRbqurhqtMhoPDzcu04dIUfHly9fLl2/R0IIfP341NEzu61vw7t0HAmURqYCRkRGekI4ePXvu3BVtbVXsPmBiYoRnUSJNh6vU0VGVkZFgYGD4/v3nmTNXsFsgKysFYezcefTr12/EmL537wmI87W1VXt7K5KSgjk5OXAGkaSkqJaWyrVrd65evR0XV05Ccc/CbGFhyMLC7O3tYGlpAC/sJCTE0IvrV6/etbZOx1Wk4DI9OTnUzc0aT3HNiNwu+vHj59Gj527evPf9+0+CFY6srLi5uYGcnCSxFc5opT9qwaC1AABDgtoLkd15/AAAAABJRU5ErkJggg=="
    m["light_bg_warning"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADS0lEQVR42u2WX0hTcRTHv/feheyfC6kly5AkzP6sTVg0oz+MTHMpmVObD82Nnkd7C4Je+vPQUw89l24ZFeZ0SwY1WwpqTjAU/DPUmlZMaeXc0vb/rocLqWsts0kvnafD+R7u58f5nXt+hwgGo9hMI7HJtukA1vpT43H6yRMbgAsXlBRFZh5gs/W0tT0HwOdzq6oUGS5RILDU2mpj/NZWWyCwlGHAo0edy8shxl9eDj1+bMskYGbG09X1GoBQmCMU5gCw2/tmZjwZA5hM7TRNA9BoqjWaagA0TTc1Pc0MYGBgeGTEBaCoqEAul5aUFB84sAfA6OiU0zn8t4BYLNbSYgVAEMSlS7UEQQDQ6WpJkgTQ3GyJRKJ/BbBaHXNzXgClpSUFBbuY4O7dO0+dkgP49OlzZ+erjQP8/oDZbAfAZmep1Wf9/oBef12vv+73BxoaKjkcNgCz+YXP598gwGSyBoMhAPX1yq1bs12udx6P1+PxulzvBAJ+XV05gGAw/PDhs40A3O4PPT2DAHJzt1VUnABA0wlGYhyl8qRItB1Ad/fg9PTsnwESicS9e22JRAKATqfasiXFRGGxWBrN+aTk9QJ6e4cmJt4COHRor0x28FenO3xYXFy8H8DkpLu3d2i9gEgkypSVokittiZ9k2i1NRRFATCZLKFQeF0As9nu9S4AKCs7np8vSg/Iy9tRVnYMwMLCosXy8veAL198VqsDAI/HUasrVktZWVlJDmMNDcrsbB6Ajo4u5mTpAEajJRwOA1CrK3k87mpJIilSqcpVqnKJpGh1nMvl1NVVMLV98MCaDjA56e7vfwMgLy/39OmjSakURSoUcoVC/vNzdubMMaaYfX1D4+PTqQFrW7OGxaKSvvL+/bzBcPPy5Zuzs8mDmiRJnU7F+Pfvr2nZFYDD4WT+F5lMLJXuS9Vd4Xicjsfj4XDkZ1UsLpTJxADc7o8Oh/NHnGD2omAwpNff8PkCLBZ1585VkUiYsmfGxqZoOiEWF6ZU5+c/Gwy3otGYQMC/e/cal8teAbS0WNvb7QAEAj4z7jdm4+PTi4tfAVRXl168eG4F0Nh4ZWnpWwbXIR6PYzTeXrkDuVzKPCYZMYIgjhyRrrmD/7vpPwR8B1NpXWYKBcjWAAAAAElFTkSuQmCC"
    m["light_bg_window"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAB+ElEQVR42u2Wv0vDQBTH39XapNpILWJB0VYrLQgOOogVF0ulUwali3TRzdHJf8LF1Um61IIoktOhQttBsODqFB1SBMGfDaWmSSrmHFJaDAE19QdCb3p3HN/P3Xt37z0kyy/wk8MGPzz+P8BumItiWRBuVFW1oEXTVDDo7+7uMgfIsrqzc5DNnrVyXoQQy0YSCdZu7zC6qHV1ACCEcFw2lcLGG4hiOZcrAIDX2xePx2jacXv76PG4KapTFCsA0NvLfKj+/Czv7h6VyxWM84uLUYZxNQGCcEMIAYB4PBaJzOzvn6RS2OcbWF9f3dpKEgKbmxs+38BnbrC9ndY07erqempqvAloRNXppABAkqoAIElyraa+vmqEEFWtfcZFDFOPsKIo5q+I5wUA8PsHp6cngsHRh4dSLDZHCDw9iYWC+CGA54vmz/T+vqQbGOcxzuv2+flFY18mc/qlaN/dlX73o/X3e3SDZedDoRHLcjxfxDgHAF6vxzwGodBIODzZypExbmfTNqANMAfQNKUblUq1FTlZrmdliqLe/eSxsWGbzaZpWjp9jBByuZzW1Pf2MnrhDASG6kW00Xglk4ccl/0WtywszK6tLRtzUSLBIkQ4Lq+XNstFPxoNr6wsNVcMraMkVS8vi4pipW1xOByBwJDb3fMO2e5N/xzwBhy4xzwB4pIAAAAAAElFTkSuQmCC"
    m["light_bg_wrench"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC2ElEQVR42u2Wz0sbQRTH3252E7O7Eo3aErUh/sghbnvYRrzkENpSTw1WoQcrQgRPQoX8A+Jf4EW8eJBqQUQKltQipaQVSWjRbrEkharFtU1Km2DSmiab2OpOD0OTaEqT4HrrOy1fZj7ftzPz5g2RyfyC8wwSzjnO3YCqdAJCKBjcDoW2o9F4Q4Oxv/+WRkOqZrC5+X5m5uHnz9GcYrO12e28OgZe7/O5uUcIoUKxqkqnzh4EAm9mZ5cQQgRBOJ1dnZ1XsF5fX6uCQTotT08vAgBJkh6Pe3R0UKulAIAgiLo6gwoGPt/LVCoNAL29Nx2OqwCwv/8NAGpqqimKUsFgYyMEAFot3dNzAyvZbBb/kDp1EIl8BYDW1kssq8eK1WoBgHj8ezQaLxwZiyVE8d3xsVLZKTo8/AkAOToA8LzV53sFAPPzj53OrsbGC6IY8vvFnZ2PCKG+vu6BAVcFBgYDF4slCpPl+Xb84feLfr94anwicVDBEimKwrIsXqhYLPHndBpdrmt6/d+LoLn5YrlLpCjK5OQDSQoDAMexDJMnut19g4O3d3c/hUIfwuEvPN++srImSREAEISOsgwwfW3tNaaPj9/jOLZwgEZDWq0WvOELC08wneetFktTaYNiektLE9ZXV9c5jhGEDpqmAECSwouLT9fX3wKATqcdHr5T+i76Bz2n0zRlNNak03IqJeNZNE17PG6z2VSIIoo7Wjn04rBYmkZG7ra1mUvcpuXQOY7t7nbs7UUODn7odDqz2WS3XxYEG0EQJa5rRVGmpuYxhWWrxsZGcvRTenGmpftBmbnn9Ip78tLSM9XpeQOE0PLyKgAwjF5Fet4gmUwlkykAcDgEFel5A4bRU5QGALa2pEwme3R0pAr9RB1MTNwPBERsRpIkbmFnpJ/Y5KGhXpOpAQBkOYPpBkP1GemnK1mWM17vi2BwS1GQzdbicl2vrTWc8WVH/H/8lorfEsCHs8EpKywAAAAASUVORK5CYII="
    m["light_bg_zoom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADfElEQVR42t1Wz08TaRh+vk4Du9qwYAtMsSgpYN2oA8YwlJi92O2um6zWBDlwgIv1wL2Gi/EfEM9eWBPG2EtDwrQmu0aKFw0tNOmPNUoTYg2G/gZWo/woMx0PX5xUgmSKeHDf0zvP9873zPu8873fSzY2tvEtTYdvbN8/gX6PNUmSwuFEOJxIpZZWVt4BMBp/slpbe3s5nuf0er0WAvKlIs/ORgXBn88Xd11lWdPQkMtu794PQblcFgQxEJhRkaNHm1nWBCCbLS4v51T88mXH8LCLEFKdRIIwFQg8AcAwOqfzvMt1oanJpK7mciuiGJyefibLZb8/SAiGh69UkcHsbHRs7B4Ag+HQjRvu06c7d30tkUiOjY1/+LAJYHTUzfNdmv4iSZIEwU+/3eO5pu4uy2Wv96HX+1CWyxThOJvH42YYHQBBECVJ0kQQDidoVZ3O82fOnFDxeHxhcvLR5OSjeHxBBTnO5nD0AchkCvPz/2olUKtXiW9tbe1wqLlcv1Jnbi6hqcip1BIAi4VtbjZSZWKxl6VSKZl8TQOoU1NT0939M8PoWNbU0tKUTucXF5c0EaytvQNAdwfg8/3t8/1TGRAIzAQCAHD16u+Dg3/SA5FO59fW3lbRKhRF0d4JZJkGE00Z1NfXbWwUcrkV+jgw8EdnZxuViJ67S5cu2GxtVCIaUygUATQ01GkiaG8/lskUlpdz2WyRZU0Mozt37tQncQDAZmvr6zurxmcyxXS6AKCj45gmiXp7Oer4/TOVeG1t7Q6Hmig+pg7Pc5oy4HmOZU3ZbHF6+pnd3sVxNop3dZ3s7/+NOpWHIxgMATCbG3t6OK2tIhSK3b79F4DDh3/weNwqxw6LxRbu3BlfX98CMDp6fY8MmJs3b1U+Wyzs5mYpmUxtb0tPn0ZWV99aLKzBcKhS9wcPxImJqVJJUvOzWluraNeKoty/L4piUEVaWhrN5iYAmUyeVvWzLQgZGRmkbaOKC2duLj4xMZXN7n7hmM2NQ0NX3r9fv3vXqygKIcTtHrh48ZcqCABIkjw/nwiHE69evVld/Q/AkSP17e2tPM/19HB6PQMgGAztzUG+fi7am2NnkfdhVqvFaGyIRJ4rihKNvqirM3R0HD/gscXhsI+MDBJCFEUZH/eFQrGDn4scjj6VIxp9qWku2geHwfBjJPK8v995kEX+v8+mHwEQjZQBhW+gzgAAAABJRU5ErkJggg=="
    m["light_side_broom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACcUlEQVR42t1Wz0sbQRh9hpIYbQihJOlsTA45VAqhh6ZeAoWiIkW0BulB6Mlb7gX/AMWLx9JD/wRPEnsQGggGQtpSK5p2KVZQSE2y+bFxMT913ez2sGWUlsRMWC+d0zezb/fNe9983+yAKDZxm8OEWx79E2QyuUwmdyPsTn9fPzrKLC+/AbCy8trn44wniMWSmqYBUBTFeItqtcbOzjcAHo/b7/cZT7C9/Vnf+OTkU+OTrGlaIvEJgNVqCYUeG0+wv/9DFE8BhEJPrNZB4wni8Y96MD4eMr4ORFHi+Z8ARkf9Xi8xniAeT6mq2vv22QgURUkmvwCw2e6OjT3q8a2BLs2uXK5Eo7GLC5n6c3z8CwAhTq/3T/VaLOZweMrpvNdPJW9sfEilvv67LghlQSjTabutRiKv+rHo5CTfiwnZrNBPL9I0rVAQAQQCD5aWIgB2d/m9ve9zc1eGrK294/lDQSipqmoymdgIRPFUlmUAHOfWV4LBQDAYuI7hODfPH15eKpWK1CkNHS3K5Up6QIi7Wq2n0wfttkpNT6cPqtU6Ie6/wAwKCoWiHng8rtXVt4JQCoen5uefA9jcjEWjMUJci4svr4EfsikQhCsFekxX6JQqoI8YCPL5EoChoUG73dYJY7fbhoetFMxKUARAyP3uZ5QQF4BstshGUK83a7UGAI/H2Z2A41wAGo1Gvd5gIMjlCjQBNymgB6nIQEA9pUXQWQHNc5mh2a2vv9/aSjB18unpZwsLL3pV0Gyes950rdY5Q6HNzk4AaDZb+lSSziTpbGTEbTZbAMjyRTZbdDjsDoddB5jN5pmZCeb74H//+e1x/Aaccg81pHPB7AAAAABJRU5ErkJggg=="
    m["light_sel_broom"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACgElEQVR42t2WyU8TURzHv22wC9KCxlkKatQYN0CCJAaDEtSaGgweNDFGT8aLJy7e/BeMB40xXPwTvBjBQGqIBMISlyCUUjyoFOgspYtdmA7TeR6mTEi0ZaYZLr7T771833zyW9/YInMEu7ns2OVVPWBlNbqyGt1RVlPd138t/3j+6imAx/1PmhoPWg8YmxglhAAoFhXrQ5TNZb/NfwXAMr7Dh45YD5icHlcUBcDFCz3WJ5kQMjUzDsDldHa0n7cesBCeSyTXAXSc63S5XNYDJqbGNKOr85L1fZBMJiLfwwCOHT3uY5usB4xPflRVFUBXZ7f1nawoysznSQB1e+vOtrQbvGWrMOwSyfhwcEiWC1vbxHL0JwCaYhp9pfg4HM6Av3f/vgPVdPL7kXefvkz/fS6IvCDy+lYtFu/ffVBNiNZiq0aCsMatVTOLCCHxuADg5InTjx72A5gLzc4vzG4PyMDrF5GlsCDyKlHtNrs5QDK1Lm/KABiK1U5am9tam9u2axiKjSyFFWUzlUqUS0PZEHE8pxk0xWaymfBiSCtQAKqqhhdDmWyG3mLrYhMeCGLpDsuwLweeCSIf8Pdev9YHYOTD4HBwiKaYO7fu6eIzp1rMeaDXCU2xms0LpRPNEERe92B7URkF8AIHwO12ezzechqPx1vrrtXF1QBoyle5RimKAcBxMXOAfD6Xy2UBMDRTGcDQLID8RklvFMDxMT0BlQG6oFyU7BXiA4CldwDognJ5/vewezv4ZnQsaGqSX+7237xx26gHkiSZfemkgmSi0fxXAgREkja0bTqdSv9OsYzP4XACkOUCx8fqvQ319Q2aYE+N42pPwPR78L///BpcfwB6OxFGmZCZogAAAABJRU5ErkJggg=="
    m["light_side_chat"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABeUlEQVR42mN88+YbAy0BEwONwagFBAELMufs2SsnTpz7//8/2cYxMjJaWhoZGekgRJBTUXp65ffvPyl0MgcH+6xZ7diDiHLTGRgYfv78hTOIIMDc3CA7O44Mo6dMWXjq1MXhnYrQwOvXbzds2IUWpmiAnZ0tIMBNVFSYHAs2b957+PBpwoHAxJycHEZOEOnra7Gzs+M3nZ2d3cBAk8wgMjbWmT27fQDigGC4UyEO8Ic7pXFAMNzpGgcDkdFOnbrIwbEKEsSPHj2fNWvpo0fPqOMDTk52BgaG////Hzp0koGB4cqVm62tk0k1nZ2dDacP0tKilyxZ//bt+////x86dGr+/NV///5lYGBQVVUUFOQjssKxsDBCEUFrtkyduujkyQsQpZCqzdPTMSLCh5GRkcoZ7f///0xMTDExgS4u1jTJyWxsbNnZsYaG2lRORZKSYgwMDPz8vIWFyUpKcpQnU/Q4+Pv335UrtxQVpfn4eKmSDxhH26YDbgEAA4iOJuJ7Qs8AAAAASUVORK5CYII="
    m["light_sel_chat"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABfElEQVR42mO8efk/Ay0BEwONwagFBAELMufy1YvnLpxmYKAk2hmNDU11tPSxW7Bs5fwfP39S6OTrN692NPVjDyLKTWdgYPj16yfOIIIAAz3j+OgUMoxeuHT2hUvnhncqQgPv3r/ZuWcbWpiiATY2dncXLyFBEXIs2L1vx6kzxwkHAiNTeEgMOUGkpaHLxsaO33Q2NnYtTR0yg0hXW7+zecIAxAHBcKdCHOAPd0rjgGC40zUOBiKjXbx8buWaJZAgfvb86bJVC54+e0IdH3CwszMwMPz////kmWMMDAw3b1+fPKOHVNPRog3FB1Hhies3rXr/4d3///9PnTm+at3Sv3//MjAwKCoo8/PxE1nhGBmYovDRmi0Ll865cOksAwMDIyPj////GRgYHO1cfb0CGRkZqZzR/v//z8TEFOgXZmNpT5OczMbKFheVrK2lR+VUJC4mzsDAwMvDl5KQKSerQHkyRY+Df//+3bx1XUZGlpeHjyr5gHG0bTrgFgAAKmeMd68uHiIAAAAASUVORK5CYII="
    m["light_side_chest"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACYUlEQVR42mN88+YbAy0BEwONwagFBAELQRUfPny6dev+06cv3r37+P37dwYGBk5OTiEhfmlpCTU1RQEBPjIt+Pnz5+HDZw4dOvngwRM8+pWU5GxtzWxtTdjY2LAqYMSaTI8fP7ds2caPHz8TGQ4CAnxRUf4WFoaELfj379+CBWsOHDgB4bKyshgYaOnqaigqygoLC/LwcDEwMHz58u3t23f37z+5ePH6xYvX//z5A1Hs7GwdFxfEyMiIz4IlS9bv2nWYgYGBmZnZzc3Ox8eJl5cbj9s/ffqyZcve3bsP//37j4GBwcPDISrKD6cFN27caW+f/v//f25urqKiFFVVBSKD6ObNe/39c759+8HIyFhdnaOmpog9me7Ycej///8MDAzZ2bHEm87AwKCurpSREcvAwPD///8dOw7iTEU3btxhYGBQVJTV0VFHM+L///937z589+4jAwODqKiQoqIsmgIDA015eemHD59ev34XpwXfvv2A6Mc0ferURadOXYSLODlZJyQEoykTFxd5+PDp169fCeSD9+8/IpvFwMDw8uUrNJEDB47LyUny8HCjaSQqo92+/eD27Qf4Ax2SmgdrWaSqquDubo8scufOA0ja8PCwZ2BggLNVVFBS2s6dBzG9jsUCISEBMzN9VBF+iKHISVBXV11XVwNZ2enTF8kMIhUVBVlZKWQRERFBVVVF6hTXEFBamrZr1+FXr94wMDCIiAi5udlycLBT0wIBAb6wMO/RKhMCTp68cPLkBZr4AFe1RxJAMwTFB+npUadOXYCU2OQBRkZGMzMDwnXyaMNrWFkAAJZg7d3tVAZkAAAAAElFTkSuQmCC"
    m["light_sel_chest"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACZUlEQVR42mO8efk/Ay0BEwONwagFBAELQRWfPn28//Du8xfPPn788OPndwYGBg52TgEBQQlxSUV5ZT4+fjIt+PXr56mzJ06dPvb46SM8+uVk5M1MrMxMLFhZ2bAqYMSaTM9dOL1hy5rPnz8RGQ58vPwBviGG+iaELfj3/9+adcuPnzoC9SALq7amjrqalqy0vJCgEBcXNwMDw7dvX99/ePvoyaPrN65ev3nlz58/EMXWlvbB/uGMjIz4LFi/adWho/sZGBiYmZntrJ2cHNx4uHnwuP3zl897D+w8fHT/v3//GBgYHGxd/H2CcVpw996tqbMm/P//n4uLOzUhS0Feicggunf/zpyF075//87IyJibUayooIw9mR44vO////8MDAxxUcnEm87AwKCkqBITkcTAwPD///8Dh/fiTEV3799iYGCQlZFXV9VEM+L///8PH9//+PEDAwODkKCwrIw8mgItDR1pKdmnzx7fuXsLpwXfv39nYGAQFhLGNH3RsjkXLp2Di1hZ2IUGRqIpExURffrs8bfvXwnkg48fP1y8fA5Z5PWbl8imMzAwnDh1RFpSmhs1/iH+I5zR7j+8d//hPfyB/u/fv9Xrlw/WskhRXsne1hlZ5MHDe5C04WDrzMDAAGejpbSDh/dieh2LBfz8gvq6RqgiAhBDkZOgupqWhpoWsjK0eCIhiBTklKQkpZFFBAWFFOWVqVNcQ0B6Uu6ho/vfvnsNyQe21o7s7OzUtICPj9/HM2C0yoQlhrMXLp2liQ/YcFR7JAE0Q1B8EBWecOHSWQYGStp6jAZ6xoTr5NGG17CyAADyt+ri+e4B1gAAAABJRU5ErkJggg=="
    m["light_side_clock"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEBUlEQVR42tWWTUxTWRTHz7OPDK21ff0chKadBBOHmILxSWfkLdQ2mhQ1b6I11WBC6kbjpsksaoalC4nuYGE0LmqiM4ER0iYjkmFhCQFHOtBIa4IBE7FNsYRHSz+oJH2ls7i1PF6/qDMu5qzuyz3v/O4959z/vRjDpOFr2h74yobv0i+V2ohGE9HoOoZhcrlUJpOKxaL/ALCywkxNzfp8gWBwmTel1TaSpJ6iSLVaWSECVq4GiUTS5RobH3+VzWYr/C8QCIzGYzR9WiIR1wBYXFzq73fG40n0KRLV6/UtGk2DXE4AQCwWD4U+BgLz6fQmcpBK99nttgMHvtsVYHr69YMHv7EsCwAqlcJiMbe3t+G4gOfGsqzXOzc0NMowUQDAcfz69S6Doa0KYHFxqbf3HopuMnV0df2E45XqxLLs48cuj+cvxOjpucHbx56deU/19ztR9MuXz3V3W7jRE4mkw3Hb4bidSCS3mwTHbbaLly6dQ7C+PmcyuVEW4HL9ifJ+/PiPZvNJ3mIXFt5HIkwkwiwsvOdNdXaeNBopAIjHk273WGnAygozPv4KANRqRXf3+eJsbG3leAOuXblCK5VyAPB4Xq6urpUATE3Noo68cMFcOe+lDxSOWyxmAGDZ7OTkTAnA7GwAdWR7e+uXqYLBcFgkqgcAn+8NH5BKbYRCywCg17d8wfI/b0Kg138PAMHgciqV3gGIRuOfBWD/v5E2jWY/AORyuULAPCAWS6ABQUirRpmY8HLLyDWCkKDB+vpOAIYVWmWrXNyGBhWGYQDg98/fvHlncPDZp0+bRV45XsA8QCbLkwv6U2xabWNPzw2drgmdqZGRFw5H78yMn+tTnIkCIP8dCn2skJyDB5tv3fr56lWrVLoPrebhwwGuQzgcAQAMwwoB8wCxeK9W2wgAgcA8koqy+o5hJ078cPfuL2fOGIXCbwyGw1xd8vvfAoBO11S4jrY7kiT1weByOr3p9c51dJCV6ywU1lutZ63WszwZRlU5cuRQiYNGUaRAIACAoaHRypsoaZlMZnh4FJ0GijpaAqBWK43GYwDAMNFHj57WCnjyxM0wMQAwmSiVSlFaTWn6NKrexMTfz597dh99ZOQFuhIIQkLTp8rKtUQittttSCoGBv5wOp9WzVUmk3E6fx8cfAYAdXW43W4Ti/dWuTK93rn7939FoZVKmcXSaTC0FQsUy7LT06+Hh0dRZurq8GvXdnFlInv3bqmvb/vSFwrrW1tbmpq+VShkALC2FguHI37/28JJJgiJ3W5rbtbV8GxJJjfc7jGP5yXLZisrqMlE0fQpXmaqA5Ctrq5NTs74fG8+fAjzpnQ6DUkeoqij3J6pGcB5OqZjsTgS4Zqejtj//nX9D1rov5nZaNE4AAAAAElFTkSuQmCC"
    m["light_sel_clock"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEDUlEQVR42tWWb0wTdxjHn+POWGyvf2j9Q4tsbjEEoS0WJhUiZk2AWFO0TCIaQjbe9IXJErPsxfaG+IYsIcte7QV7wZZmuk0SWMrWhY6ZGQyjrFYKVMFERIcH2tJe71ps0ruwFz/oylGu1M0Xe179Lve77+fueX7P9zlsfmYdXmcUwGsOYpf7Eol4jInRsSgGmFKpVMiV+/ZJ/wNAKBzy+b2z9wPU8pLglk5bUnnMWGOq1aj3iyhgO9WAjTMjo+6JyTs8z4s8j+N4nflUo8VKysg8AItPFvqdfWycQZcSSWF5WcWhg1qlQgkADENTK9SD+WAy+RJtIEl5V6fjzdK3dgWYmr57/YdvOI4DAHWRxtrcYtSbcBwXbON5bmra7x5xRaKrAEAQREf7B0a9KQdg8cnCl199gdTrTzbYbW04LlYnjuOGXDfHvWOIccVxVfAdBVvzzvY7+5B6y9nWC+cvZaqzcaant7untzudOiTa1nrZZm1FsH5nXzwR3xEwMvozetj8Tv27DY2Cl328+CgUfhEKv3i8+Ehwy3K6sc7cAAAsy3hG3dkBoXBoYvIOyvsFe/v2bKyvrwsWmWG3tRWp1AAw7h1bjYSzAHx+LzqR1uYW8bxnbyiCsDa3oOL7/N4sgNn7U+hEGvXHX80VqgzVhYWFADATDAgBiUScWn4GAOVlFa/w+ummKzt6DACo5aW1tcQWAB2j0UJbrPs31lZ8SIeKlBbcADBMDC3kpCKnysSf45llzAyFXLEpuBWAYSByQlBo1AcwDAOAufngZ59fG3YPJZPJ7WcNtipuAOSbZJaN7QTQaUuuOK7qtIdRT9267enp7Z6evZe5h47FBJ9SsHmtRAtqhRJJzttHjn704ScX3+sgZXLU298NODM3rDynAADDsLTgBkAqlWmLSwDgwXyQ5zkxf8cw84n6Tz++ZjndJNm7t0pfnelLcw+DAFCiPZweR/+cSH2FkVpeSiZfTk37q4+fEK+zRCKxWe02q11gw6gqlRWGLI1WY6pFnuwecSG/yytSqZTb4wIAHCdqTLVZABr1/jrzKQCIRFcHhm7kC/hxeCAajSCTL1Jpsrtpo8VKknIAmPT9cev2r7tX/+13DxoJclLRZDmzo12TMrKr00EQBAAMuwcHBm/kzFUqlbo5eP2nX4YAgCD2dHU6pFJZjpEZmPF/+/3XSFqlKjrbfK7KYNpuUDzP3QvcdXtcKDMEsaej/f3cI3NjcD5d6Hf2sWx66EvKyyoPHihWKVUAEKWjK8+puYfBdCfLSUVXp+ON0iN5/LbEE3HPqHvcOybeFjhO1J9saLKcEWQmNwDFaiTs83tngoFn1F/bnKPUUGmoMdVmnpm8AelYW0vEGJqmaQDI69cR+9//Xf8Nuye+MMOMirQAAAAASUVORK5CYII="
    m["light_side_film"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACMUlEQVR42u1WTUsbURQ9k4T6orQJCYaGhHzoqAWDgtCshG5axFWy7Cp248q46Q/pQnQpwYBg6cJCIEIpSN05Gz+w0pIZO1OStFUTkorNm0Jmunh2dEJJy0Qtpd7VmcfjnHvvu+/M446Pv+Eqw4Yrjn9fwHHxY3f3XS73WpZLqqpa4CKki+fDyeTE4GDUWOSMQ97YEBYXn+u63mHKdrttdvbJ2FjMVIGqqsvLL3Vdt9ttw8NDhNwShB0AHo+b58Nt6ERRqVZrAOLx0dPTxv5+odnUMpkXIyP3HA7HuYCilBsNCiCZnEgkHgFIpZ4CGBiIzMyk2ggsLGQ3N7cBpNNTAFZWcvn8er1+IstFno+cH3Kt9pUBv9/XSX/6+kIMVCq1650iSimgA9z8/JI1ItbSn6FTSk0VHB5WAO7y8uaOjqqmCoJBPwP9/RGv1wWATdGfRzw+ylovSQqAQOCuScBmOytlcvIB22ou+ffBpkgQdliTDcIbs/t/7FrTNAbW1t4IwrYFIjY8hkMYhGcCxeInBiRJliQrmbbcm1Lps6lFPp8X0C+vMXpvr8dUASGEWUU6PWXtomWzzy5cNI4Qcr1T5PG4GDg4+NgJXbn8hQG3+46pReFwwOW6Xa+f5PPrilLq6XGy9UJBbm/goqgYU0Tp97299wC6u0k0Gmz96W9tvZ2byzSbWqdOzXHT04/Hx++3CrB8V1dfieIHSq08W5zOrlAomEg8jMWGfvFsufGivyXwA24R2gQNAwCSAAAAAElFTkSuQmCC"
    m["light_sel_film"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACPklEQVR42mO8efk/Ay0BEwONwdC3gAWZc+Pm1d37dzx5+vjXr59kmMXOzqEgr+ju7K2ooAwXZIRH8qkzx1esWfz/P6VxzsTElBibpqOlj+KDX79+rt+86v///0xMTOqqmuzs7BcunWNgYBAQEFSQU8Rj3INH9z98eM/AwGCgZ/Tt+7fbd27++/dv1dplGmraLCwsCAuePnvy48cPBgYGdxcfN2dPBgaGC5cyGRgYFOSU4qNT8FiwcOmcCx/OMjAwxEenMjAwbN62bt/B3Z+/fHry7JGCnBIikj99/ghhiIuJUxI+crIKEAbEW3RMRT9+fGdg+M/AwLhgyWzyDCosz0Ti/f/x8zuKD968e8vAwEg9dzO+ffcOxQdSElIQhryckqCAAAMDAyQVEQ8M9IwYGBjef3j/8NF9BgYGSXFJFAuYmKBecbRz1tc1gqci4gEkFV28fA4SyHADRwu7kVNc//v3D8LYf2jvhUtnyTBo4dLZkGSKZiDUgmcvnkEYDx/de/iIHJei5ZvnL5+jBJGIkDADAxVr///CQkIoPuDg4IQUFQkxqZCMhlq2EAb9ndORMhojBzsnfVMRP78AhPHo8QNKjHvx8gWEwcfLjxJE0pKyvDx8n7982ndw95Nnj7k4uWA14j1I8sBTZcJT0c+fP2/evs7AwMDJySkrI4de6V+9dmne4pnw5EV+Sc3IGBkaZ2psgW4BAwPDg4f3duze+uDRvZ8/f5BhNAc7u7SUnKuzp7qqJpZmy2hZNFAWAAB+3NwPhOtLhAAAAABJRU5ErkJggg=="
    m["light_side_gamepad"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADXElEQVR42u2VXUhTcRTAz3bnvPc6zM2hjq6gzGZuA6fR9hAGYUpGNNFkD5H4lKAVQfWSE4kSX0r6MAjCj3xQ0YpMMNBIQQR1Op2bzabrrjW5uuY0mfvAbfZw57RlUVQPkeftf87/nt/5/F+Gw+GGvylM+MuyB9gD/AMAVsTZaqW02mmK+hQIBH7NEYslECQcOiQlCMFOPSO8yS6Xu6mpc3x8+nfiZTAYcrmsrOxMTAz2FcDlctfWPlhYWPojZSGIxKqqSzQjBLh/v4WOnSASVarTYnGax+MjSZtUKkKQ7/aJopZI0iaTSXAc3djYMBhMHR09FGUHAIUiq7LyXKgHViu15V1QXX0Rw1AAUKvvUJS9sDC/qOjErt4HBkaamzsBAMfRW7eu8fncrCxJerrwxo27FGUfG5tSKo8ThIAJAFptqO4q1SkMQ9fWXGNjOjoQvd40NWUMBILfAkZHJ3EcRRDE7fbq9bO0EsdRleoUAGxubmq1M6ExXVx00OaMDCEA1NY2NDQ8oTVms6W+/nF3d9+3gP37kzweH5sdBQCTk4bGxk6bjQIAsfjAVgHtoRKFJ5LNZv98J0tKCmJjOWbzh7k50micBwCd7u29ezUoGk1f8Pv9u+wBAFRVXZidNdNJCIUpR48qTCZzOKewsNnswsK83NwjFRVqLncfAKysfF5f93A4eOSiIQhCH7xeH4pGx8Zy5PJMgSCBouwZGcK+vsHvja/FYq2puSyVigwGEwBIpQc5HNzt9tLWqKioEIAgkmiVRjOdk3M4nAdJ2kZGJn+wHDbbUmvr86tXz8/MzAOARJIGABrNFG1NTk4KARQK2bNnrwKBYFvbi4QEXnq6EABiYnCz2TI8rAGA+HjuzZtXdubucrnV6ttO5+rQkIbP5ymVeUwmEwCMxvn29pcAwGIhcrlse9G6unp7el7TH6emJvN4+0jS5nSu0levX69MS0uJCH9uzlJX99DvDwAAjxeXmko4nZ9J8iNtVSrziosLtgHBYLCl5eng4EiEFwyLLi8/m50t3bVEExP6R4/afD5fhD4390hpaRGDwfjqsQMAg+Fdf/+wyfTe4/Hy+dzMTPHJk8fi4+N+MKwOx0pv7xudbnZ5eQXDMJEoJT8/RyIR7fKa7v3R9gD/L+ALf4dlH5vCzCIAAAAASUVORK5CYII="
    m["light_sel_gamepad"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADbklEQVR42u2VWUwTYRDHZ9vi7hYIW1BpqyAWlkIVUCEa1EiMgBZPNMYrMTEmBiMqRtREfdAHYuIRNWKC4UFNIIiCilGjxlsMarBQetEChR7QbmtsidIuWrY+bPEoRzTqg5F5++abb37fzM7/W0Sv8sPfNA78ZRsDjAH+AQAvaN1j61ZrmykHxTADv5aIx5swXpgyPU0ULf7ej3xVssfTV11b2aJu+p37IggyIzV9bf4GHOf/APB4+s6VnbJTtj/SFpFQtLOgmGUEWlRdW8lmFwlFy+SryQQpTdNWq1mamMzhjPidHE67xWqWJafgGP7Z99lg0N26e8PhtNvstms3qjZv3BoA9Ni62c6IhOJd2/dhGAYAJ8tKHE5qcXbekpzlw2ZveF1/9XolAGAYvr/osEAQOU2WKpGQZ0qPO5z25pa3OYvkomgxBwDU2mb2zDJ5PoZhHz5+UKoUDicFAK2GVm2rmmGYoYAmZSOO4xwOl6a9OoOGdeIYvjxvFQD4/X6NRhkYU+c7B7tNxicCQGnZqUsV5azHZDaWXzz/4NGdoQBhtJim6ZCQcQCg0bZU11TYqB4AIOOT2ADKSQVa5PMFJpKN/klbumRFWFi4ydLZ1dXRbtQDgLZVfeTQMRRF2QCfzzeMDgCgsGCvsbONLWJKrGROxlxjV/vlyvKgsBDeuNzsvPmZCw4dLY6IIACgt9ft9Xr4/NBgofG4XHbR39+Pomh4WHhayqyJE6IdTipBQj5/+Wik8bX2mIp2HJCSyfo2HQBISRmfH+qlvYP9CAkAhMKA9pQqxeyMzK91WK1mhbJxFHHY7LbauuptWwsNbXoASCSlANCiUgyqQRwAzExLv3v/FsMwdbdroqLGx08lASCUH2qyGBsVrwBAQEQW7z74fe0eT9+JsyVut+tNY4OAiMzNzuMgHABo7zDcvF0LAFwub2Zq+jcl37lX9/DJPfZwzOQpRARhsZrdvS42tLBgT1ysJOj6XSZj6YXTAwM+ACAIQcykWHev22I1sbu5i+Ty3BXfAIyfqble1fCmPigLhqKb1m+ZLksbtkUqTXPFlUufPvUH+edlZq1ZuQ5BkB8eOwDQt+levHzaaeqgaa+AiJQlpSzMyhEQglGG1eV6//jZA51e43K/x1B8alz8gvkLExOShnlNx/5oY4D/F/AFQPdmgKYC54oAAAAASUVORK5CYII="
    m["light_side_keyboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACm0lEQVR42u2WT0iacRjHv76aZrKGpM3pytrCkVkrhE7BDhsbDSqC2FjH/p522CCjCKMIBztsg7FTRcexjU4d1mWH0alMmrkWGDTfV9MX1P68lfn3bYc3LKeWabFLz+15f1++n/d53+d53pfn8wVwmUHgkuMK8P8Bgn/y7W3G4dgIh8NZeOXlCVSqG8XFstQAv39rYuLzyoo9x1uur7/X0fGsoCCfS3ncHAQCwcHBN5ub2xfyWEpKbo6MvBQIBMcVTE9/49wrK+80NNSLRMIsfMPh8OzsD4pyO52emZnvra2PjwGrq3YAMpm0r6+XI2cXdXW6/v7XDLNnsdg4wFEXeTxeAGVlJbm4A5BIxBrNbQAuF53Qpix7CIAgeAAYZtdgMBkMpp2dXQAWy6/e3oHx8U+ccnLyS3f3gNm8nKzkgs8nALAsm3YOSNJD0z6a9jkcGwCs1t8HB6HFxWXudGHhZygUslpXkpUZzQEArbaiufkhAJ1OA6Cp6QHLxmprq7jTnp72pSVbS8ujZGWmAD6faGt7Ek/l8qKurufxVK/X6fW6lMpzrAqS3CBJV+bv9hR9CgBFuY3Gt0bjO4cjI8bp+jOakmF2x8Y+0LQv5alCIRsaenG+ZQegtFQ5OvoKOFSrb9ls9nTuAGjaR5Ke6mpNXJ8WQBC8WOwwFjtqXrVadbKjaNqbpgK5VltxUh+fAIIgEgAqlYKi3Gtrf/b3DyQScbqOOjMikcj6uhOAUilPAOj11RTlZpg9k+ljY+N9oTCbZRcMhubmzH7/FoCqqrsJ6zoajQ4Pv3c63ReyrouKpCZTn1icfwzgPglTU1/n55dydK+pqezsfCqVXk+oIB5er9/loiORaBbWIpGovFxVWHjt5EXe1Z/dFSDn+AvV1SoRTqA/1QAAAABJRU5ErkJggg=="
    m["light_sel_keyboard"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACpklEQVR42mO8efk/Ay0BEwONwagFA28BCxr/06ePT549/v37FzlmMbOIi0uKCItit+DDh3fL1yy+dfsGhU420DMKC47h5OCEcBkh+eD7j+9dfc0fPr6nSrBISkgX5VawsLAgfLB952aI6SrKaqZGFuzs7GSY++vXr4NH9j599uT5i6d79u/wcPVBWHDn3g0GBgZBQaH0pFyIzeQBHS29tp6GL18+X7l2EWIBNBW9fPWSgYFBVlqeEtMZGBg4ObmUFFQYGBiev3iGEsn///9nYGBgYmJkYGD4/OXT5Om9DAz/czNKeHn5Ll+9uGzlfD1do8jQOAYGhpVrlpy7eCYqLF5f1xBNJTThMzExMDD8+/cPZz54+uzp6zevXr95/eTpYwYGhms3Lv/4+fPS5XMQ2QuXz/769fPajcuYKonKBwwMDGoq6i5OnowM/9XVNBkYGFydPP79+6etqQuRjQpLuHLtopuzF6ZKYi1gYmLydveDc4UERSCBAwG62vq62vpYVZJQVDx5+vjps0fExy0e9SzY4uBJ3+R2BgaGotwKGWk5gqbjV08gUULSyes3r7DKioqI5WYWk1bYMTAwSEvJFOVWMjL+l5aSu3HrOi7TGRgYXr959fTZUw01Tbh6nBYwMjL+////719o4pWRlkVOUW/evMRqgYiIuJqKOrJ6BgaG////wXMDwgJJCamnz57cf3j3+/dvnJxcuFIUQfD79+9Hjx8yMDCIi4mjWKCrbfD02ZMvXz5PmdnnYOvCxsZGRjnx8+fPU2eOv//wjoGBQVVFE6W4/vPnT/+UjmfPn1KluBYUECorrOXg4EBYAKkSVq9bdv7iGQpN11TXDg+J4ecTQPEBHLx7/+b582d//v4hw2g2VnYZGVleHj5kQcbRlt2oBRQDADuFI6f6h8xxAAAAAElFTkSuQmCC"
    m["light_side_palette"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAErklEQVR42tVWW0zaZxQ/f0ADgoKCihdErQq6YuKlm1IvIVJaiW7LWKOrqWlcmrQPRk321gd56duSNk2aaNI9bF5S04ZoZ5TGGNAqWszfibphOp3TBUFF5SrOUtjDpxQLODTrw87T+W7n933n8vsOZjbvw8cUAnxkIYW5z2KxmUzbNpsDAKKjqSxWXHx83H8AsLGxqVJN4fiC2bz3wVJMDE0g4JeVFeflZWMYFsoCFioGFoutp2dAq53zer2nX4LLTWlo+JLPv3AGAJ1O39HR7XS60JDBiBEIeBxOCoMRTSAQrFabwbCl1/9uNG4dWcGwq1cr6upqiUTCvwNMTMw8edLn8XgAIDU1SSa7lpDA2tmxZGWl0WhU/52rq38NDo7OzMyjYUHBxebmRhKJdBqATqd/8OAHj8eDYZhUKpLJqp89G1Iq1V6vl0Iht7Y25eZmAcD6+oZKNQUAIlHp7q61s7PX6XQCgFBYdOdOQ8g03duzdnR0I+uNjbK6uprtbfPwsAqFweU66O7uB4C1NYNc/nB0dHJ0dFIuf8hk0tvbmxmMGADQaPDxcW1IgN7eF8jvUqmoqkoIAB8kz87OLvKh2+1GM263e3xcy2YntLV9SyIRAaCvb/Dg4CAIwMbGplY7d+z3ajSZkcGJiiL79uTl5YTKpYwMjlQqAgC73aFWTwcBUKmmkCtksmvoLgBAo1FbWpo4nGQKhVxUJLh162sAqKj41BfJiAhSeflnSK+uFkVGRgLA5ORskELD8UWUkQUFnwBAf//LkZFJDAOxuOz+/e/8L8vhJMvlbWNjUwBYZWVJWloSmqdSKQIBD8cX1tcNDsc+jRb1HsBisZnNuwAgEPAIBIJGgysUL9GSQqFMTGSVlhb6Y6SlJd28+VWgo7Kz03F8wev1GgwmHi/zvYtMpq3j26UAwNLSiv8xvX45TMqKjaUjxeFwnoiBw7F/XLTRAMBkxvofY7GYYQK8fXuUXUQiMThdozhLJOVcbsox1aRKJJfDBFhZ+RMpiYnME0H2cQAiZAqFLJe3LS+vAkBWVkYgwwSVvT3r9PQvAMBixbHZCScA2Ox4pKytGY7fSODxLoT/sezvHzx69KPL9TcASCQVPgIn+fiSxYozm3cXFpY8Hg+BcIafzmKx6XS/DQyMoLLPzEwTiy8HqYPiYoFSOWa12nF88dKl/FMsjoxM9PUNHh4eBi4lJye2tjb56vREkEWiEvQuhWLYRzWBMj+/1NWlCLROJBKrqoTt7S2I9YK8ICkpsbS0UKPBDYbN58+H6us/DwowO/srUvLzc8nkSACIiqJwuSmFhRd9RRDyT66vr9XplpxO59CQmsmMu3KlLPBAQsLRX8/nZ9bUVJ2tbWEwYu7ebUBJ2dWl6O19EeirysoSxK+vXs2cpy/Kz+ffvv0NyiKlUn3v3vevX8+9e+fxbaBSKTk5mQCwtWU+Z9siFBbRaNTOzh673Wk0bj1+/BPqULjcZDo9xul0vXnzhz/tnC4h2xar1f706c8aDR6qbbl+XVpbKz4/gI9l1erp2dlFk8nsl5EEsbjsxo0vTum3wgXwic1mNxq37XZHREREenoqnR4dZp1j//vu+h+XAeCgvQm2ZAAAAABJRU5ErkJggg=="
    m["light_sel_palette"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEwUlEQVR42s1WWVBTZxQ+9yZIyHKzsyQBZEcQhbIJoRGoiGBBRdtqO2oZ2pkytTO0M0596GNf7Et9cfrQdtCxzICjWMpSFBjBAIGwBRIQKmgtICRhy80C2Jj04WeLJBAYnen/9G/3fPf/zjnfOdiI2g5vc+DwlgfVzXskadDN6MxmIwAw6Ewej8/j8t8AgFY33d4pVw+q5ufnXjtiMlmR4VGJ8YfCQiIwDHNlAXPlA5I0/F5zRzXQY7dv4ySxyP9k3gehwWE7ABga1pSVl1oWLWhJsNiREVEiXwlBEDiOk0bDtHZ6dGxEp9euWMEwWVpmfm4BjuPbA3T1dJTfuWWz2QDAz1eUczRPwBfOL8wH+u9lMJgbb45PPG9qvt+v7kPL6H0HCs9/TqFQtwIYGtb8evMnm82GYViGLCs3O7+2vqpZ3mi322k0WtGF4tCQcACYfDGhULYCQEpSmoFcKCu/YVk0A0BCXNInZwtdhqmBXCgrL0XWT584m5d7anZO//BRA3LD0tLSverbADAxOX7t+tU2RUubouXa9ascNqfk0mWCxQaA7j6lslvhEqCq5i7iPUOWJU2RAcCcY/CgZVdvh9VqRTtWq7WzWyEU+Hz2aTEip7qucnl5yQmAVjetGuhBvOdm56NNf3EAjea1dic8NNJVLPlLAjMPHwEAk9mE2HsdoL1TjqjIOZpHoVDQJoPBLLrwhchPTKPRYqJjz5w6BwDJCSlU6oonqVSP5IRUNM+QZe3x2AMA3b1dThJNM9iPIjI66gAAPGiqlbc1A4alpaRfLvlu48+K/CRfX7rS0dUKduxQklTkJ0b7Xl70iPAo9aDqxdS4xWKm0xnrACRpmJufBYDIiCgcw3v6lH8+qEFH9Q3VQoHwndhERwxxQf5Hm4naGxisHlTZ7fZp7VRwUOg6RfqZlZQR+UoAYPTpXxs/ezI24qZkcdgcNDFbTA4+MFvMK0lLEADA5TgIGY8rcBNgLbpwnOJcrpGfZdIMsch/VWoCZNJ0NwH+/ucpmggFQgcn0+krGmAyGQGARqN989WVZ8/HACAoMGSzwjgdBnKhT9UFADwuXyjwcQDwFnijycTk+Oob8ZCgMPcLy+LSYumtn5eWlwFAJs1cE3DqKvVsHpc/Nz87/GTIZrfh2A4qHUkaHo9o7jfVoZoRIAlMSz3sJA9i9se2yJuMRlKt6T8YE7eFRXl7c03dvZf/vtx85OPtW3SxeC1PHZycmpyG3lXfUP3qldWV9eGRwcqqis3WKRSKNEVW8uW3BMF2XjK9hb7xcYndvcpp7VRtfVX+8dNOAdRDA2iyLyLa09MTALxodLFIsj/6IJvgbFOT83IKhh4PWhbNDx81crn8d1OdRCeft5ITIcFh76Vn76xtIQj2+XOFKCgrqyqqau5u5iolSYr0VdndsZu+KDIi+uMPLyKMZnnjDz9+rxroQeVzTdFCgkIBYGZWt8u2JT4uiUFn/FZxw2w26fTam2W/oA5FLJIQLLZl0TL2bBQA2GyOOwAu2xajkfyjrrKnT+mqbTl+7MSRjGO7B1hTWUVnq2aoXz+jX6cVx9NS00++f2aLfstdgPUHmUi9XmcyG6lUD39xAItFvOHelMUkWEwC4P/XXf8HGlTdpZoRJAoAAAAASUVORK5CYII="
    m["light_side_people"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAD/klEQVR42u1WX0xTZxQ/t7eB/gGLKcXS1pZSWigXWttiJWZzMZooUeNMfFBj5nDuaRXiYkzMEh98YQ9EEx98gSx7MdPERBeqS2DqDCiEatvBoNRRYoHbXnoLUkhpwd579/DZChVsF2O2B8/TL+c75/y+7/y7F4tGl+BjCg8+snwiyCn8jQ5Yln369LnbPTI9HQbgVCqF1Urs3Gnj8f7dnbB1uyiZTF658tPY2HiW3mjUnTv3jUAg+FCCa9d+fvZsCABwnKdUygGAJCmGYQHAbjc7HKeQGU3PDgx4KIqWSDYRhJ4gDHmlaHIyhKKXl5edP/+tTCZFsdrbO8LhyODgn1NToa1bFT09vTdvdr1+nUJeTucDq7XO4fiKz+fnKPLQkA+Bkye/RNEBQCaTHj9+OG0w5vcHbtz4NRMdidv9161bztxd9OrVAgJqtXK1XqtVpQ1it2//xrIshmFnzhzr7Pzx8uXv0VW6u3tjscUcBEJhIQILC2tM5+cX0gaCyUkSAGpr9bt22QsKCioqVAcO7AYAjuOCQTIHgU6nSaf1IcdxCHMc53Q+RLiqquKD5qC+vloul1EU3d/vpunZbdsIAPB4RgKBIKo8QRjUaqXfPzE6+vfjxwM7dlhCoRlEj2GYRqPM3aYvX063tV1PJJJZepFIcPHidxqN0u+faGu7zrJslsH+/V+cOHF4tQa/cOGHdwlKSjbZ7aZodJ6moyhLOI5bLMTZs1+jsSgt3VxUJPb5xtFwILHZ6pubj2aNOvb+70EqlQqFaABQKGRZDQ4AND03OOilKFoiKSYIg9FYle8kLy0l3e7hQCC4uBjPKCWS4spKtcVSJxK9XRWRSPTu3R4cx3U6dUODqahIlIMglWK6un6/f/+P5eXldd8kFBY2Ne0+eHAPn48DQEfHL729rszRkSNN+/Z9jmHY+jVIJpPt7R19fS6GYTZOGuPzjb94MWG3m/l8PsOwXu8oqkQqxQwPjyUSSZOpZp0XcBx39Wqn1+sDALFYdOjQnu3bTZlVwXEcTc+6XENO54N4PAEAVmtda2szumwsttjX57pzp3tlZQUAHI5Tdrs5+wX9/W7Uy3K57NKlVrPZKBa/TSiGYWKxyGDQNjZaPZ6ReDwRDkcUii0qVTkACASFBoPWYNA+efKc4ziSpPbu/Sx7ku/de4TasaXltFRaslGKSks3t7ScxnFexiUjNTW6xkYLAJDkTDgcWUNA03NTUyEAaGgwqVRb3j/9anW5zVYPAMHg9Nzc/Oqj2lo9AhRFryEgyRkECEKfz4YxGvVpR2q1XiB4sygzm/wNASoOAIhEwnwIiovFCCQSy/+Pv4rq6sqyMikC+bhtZP+uHvv0b/qfE/wD5pqy0Z1/Qa8AAAAASUVORK5CYII="
    m["light_sel_people"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAEBElEQVR42u1WSWxbVRS939/le0rAjpN4iIPjeIgdTzGhUqXSdCCUBSpUIgvokBbaBloBQkhI7FiwYlMhtSACKhUsWIBU1KotcZMmVVVok9qZHGeoY9MkHr7HOm7jIf7+LF5tHCepg6oKFj2rq/vue+e9e8+772HT4zQ8STDgCeMpQVkw1xvI0TmbfdDhHPMHvAAgFkn1OuMLls0M7N/tCVtTRel06ruz38y6Z0r8ykb1kc73CYL1uAQ//NQ95hgGAAaDIRZJAMAf8OVyOQAwGy2d+46isGgsbB+5HQoHK3iValWTWtm0oRR5fQto9ZpqUde7JwR8IQBEouHuM6eCIXJkzN6+c0Eirrv+R//5i+ey2WU0q2+gR68zde47wmQyyxR5amYCGXv3dKDVAaBKIHz9tTfzAc5Zz53fLvxaWB3B4Ry9cPlceRXF43FkSMV1xX6ZtD4fcO9Sz/lcLodh2FsdB7/84qtPPvysSiAEgOs3+hOJxTIELBaBjMT9FaHxxXg+gOXzzQOASqnZ3Lpl06Zn6qT1O9vaAYCmaa9vvgzB87KGfFqtNP1QAjRNX71mfRhQr3ise9Ck0VULa0LhoH1kKBIN67UGAHBMjt+d86DKa1RaiUTm9rjuuKZvDd0wG1vJoL9vwAoAGIZJJbLyMl3wzp3uPplKpVZlj33i2Md1Upnb4zrdfRIJtxhtL+16I68FBPyD45+vJqisfNZssERj0Ug0hLKE43iz1nho/zGxSAwAfL6Ay+W5ZqeLOQzN5o69bzMYjPInKICismSQBIDamlocL81nNBYZHrWFw2RFRaVaqVU2qjfai5KppGNi9O6858GD+wVnRUVlfZ28WWdks9jII+BXmQwt1t5LiUQiFAlKxFIOh1umVVAU1dv/+9VrVzKZ9JrcLILYvu2Vl3fsxnEcAH7+5cfB238Whl5t37Nt6w4Mw9auQTqd+vbMqSHbTYqi1ktalqJc7hn3Xy6zwYLjzFyOmpgcR5XIUtTUjDOZSmo1zWucgKbp789+7ZxyAACHw921fbfZ2FJoFTRNR6LhMcdwX3/PUnIJAPQ60zsHu9BmE4nFQdtNa+/FzHIGAA7tP2oyWEpPYB8ZQlquFtZ8dPxTXVMzm835ZyMYxuFwG+SNFtOLE5PjS8mlYIisrRGhXksQhELe2CBX2oZv0TQdIP1bt7SV3mR0UXEcP3zgPf5z/PVSxOcLDh/oQlrsG7iy4rVQqCymVgAIkP5giFxBEI1FfH4vABj1LUjpj4BELDXqzQDg9c3di8eKh1T5JyFUQhAg/fkIzUY6jFKhKZmIQBBEXgvZFQTLyxlkcIry/gjweLyC8P4fvwqFXCmsqkbGRqatF7/ajz39m/7nBH8DwMWu2halUBEAAAAASUVORK5CYII="
    m["light_side_phone"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABrElEQVR42mN88+YbAy0BEwONAQseuf///x88ePLw4dOPHj37+fMnuk4WZmlpCR8fZ3NzAzyGMOIKov///0+duujUqYsE3ejh4RAV5UeyDw4cOAkxnZOTXV1diY2NDU3B799/L1++8efPnx07DmhoKBkZ6ZBmwbFjZxgYGNjZ2RsaCiUlxbCquXnzXkfHtL9//+3efRiXBTgj+dGjpwwMDOrqSrhMh8hqa6szMDDcvfuI5FT048cvBgYGDg42/BHAycnOwMDw48fPAUumoxaMWjBqwagFoxbQutJHBq9fv92wYdfPn78YGBjY2dkCAtxERYWpacHmzXsPHz6N8DgTc3JyGEVBxMHBzsDA8O0btKrS19diZ2eHsNnZ2Q0MNCFsSHMGUq+R5gMlJdmrV29fv37r5s276urKxsY6s2e3o6l5+vTF9ev3GBgY5OSkSbbAzc3u6tXbf//+6+ycoaOjhtls+fHj182b9yA+sLExIbnhxcDAsHz55u3b9xMMZXNzw6ysGEZGRpItYGBgOH360pYtex8/fv7nzx/M9oScnIyNjYm9vTk5Tcchk9EAfUCb7/LCta4AAAAASUVORK5CYII="
    m["light_sel_phone"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAABrElEQVR42mO8efk/Ay0BEwONAQseuf///584ffT02RNPnz359esnmiwzM4uEuKSLo7uBnjEeQxhxBdH///8XLZtz4dI5gm50sHXx9wkm2QcnTh2FmM7Bzq6kqMrGxoam4PfvPzdvX/vz58+Bw3uUlVR0tPRJs+DM+ZMMDAxsbOyFuZViouJY1dy7f2fqrP5///4dPnYAlwU4I/nZs8cMDAzKiiq4TGdgYFBSVFFT1WRgYHj46AHJqejnr18MDAzs7Oz4I4CDnYOBgeHnzx8DlkxHLRi1YNSCUQtGLaB1pY8M3r1/s3PPNkjVz8bG7u7iJSQoQk0Ldu/bcerMcYTHGZnCQ2IoCiJIXfb9O7Sq0tLQZWOD1m5sbOxamjoQNsRPHLgrPpw+kJNVuHX7xu27N+7ev62sqKqrrd/ZPAFNzYuXz+/cu83AwCAlJUuyBXZWjrdu3/j379/02ZPUVTUwmy0/f/68e/8OxAdmxhYkN7wYGBg2bV23/9BugqFsqG8SG5nEyMhIsgUMDAwXL5/fe2Dn8xdP//z5g9GeYJeWkjM1tjA3tSKn6ThkMhoAb6CbLr92WG0AAAAASUVORK5CYII="
    m["light_side_puzzle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAChUlEQVR42mN88+YbAy0BEwONwagFA28BCzGKvnz5dufOA0ZGRhUVBW5uTipbsGPHwTVrtv369ZuBgYGNjS001Mvd3Y5qQXTs2NllyzZCTGdgYPj169fSpRtOnDhPvAWMaBnt1as3Gzbs/vXrF4R78+a9jx8/MzMzh4Z6/f//f82a7X///hUQ4FNTU4QoYGNjCwhwFRMTITaINmzYfeTIaTRBPT1NLy9HiH0XLlz78OHTqVMXkRWkpUUSG0S/f/9GE2FjY7W2NoawbWxM2dhYCWohKpIXLerDFDQz0zcz04dz4+KKBnFGW7FiMzyq8YObN+/hSVfoFrCyQoN427b9PT1z/v37h8doSHx8+PBp2rTFu3YdxqqGuaysGpkvKyv57duPT5++/Pjx882bd5KSYrKykrgskJAQ+/377+vXb////3/z5n0XFxtWVhYCFnBzcxkb6xoZ6ezefZiBgYGbm9PISAeXBdLSEpaWhszMTNeu3f7796+6urKEhAhRcfD//z/io/H/f1imZSQimb58+WbDhl1XrtyEcLW11fAYffr0pcOHT16+fJOBgYGTk11FRYGwBRs37j569AyEraWlipzqMcHMmcvgKS001IeLi4OwBfBs6evrEhDgysTE9Pfvv+PHz167doeBgUFHR83CwpCJiQle9jEwMAgI8MXEBOJyCs6cHBrqxcDA8OPHz97e2Tdv3oMIHjly+sCBEyUlqWxsbHCV6upKeDxKICevW7cTbjoE3Lhxd/36XVSocJDLGQEBvtra3P///zc3T/748fPWrfu2bt1HZlEBz8nIQEdHXVRUWExMRFdXA1MWqxacPggIcIXHHnKVQowsUTXaaLtoGFoAAMeX/g9WnxyuAAAAAElFTkSuQmCC"
    m["light_sel_puzzle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAClklEQVR42mO8efk/Ay0BEwONwagFA28BCzGKvn37ev/hPUZGRkV5JU5OLipbcPDw3q07N/7+/ZuBgYGNlc3bw9/OxolqQXT2/KkNW9ZATGdgYPj1+9f6zavPXzxDvAWMaBntzdvXu/Zs+/3nF4R79/6dz58/MTMze7n7MzD837Zz09+/f/l4+ZUUlSEKWFnY3Fy8RIRFiQ2iXXu2nT53Ak1QQ03byd6VgYHh3v07V69f/vT544VL55AVRIXHExtEv//8RhNhZWU1NTaHsE2NLVhZWQlqISqS+zunYwrq6xrp6xrBuYXlmYM4o23etu7371/EGHHv/h086QrdAlYWaBDvO7h75ryp//7/w2M0JD4+ff64aNncQ0f3Y1XDnJvVgMyXlJT+8eP7ly+ff/76+f79W3FRCUkJaVwWiImK//795937N////793/46NlT3cfTgt4OLi1tU20NHSP3xsPwMDAxcnp46WPi4LJMQljQxMmZiYbt+5+ffvX2VFVVERMSLj4B8J8fgfmlUZGYlIpq/fvN61d+vNW9chXDVVTTwmX7x8/tSZYzduXWNgYOBgZ5eXVyJswe69286cOwlhqyqr6+sZ4bFg2coFv2ApzdszkJODk7AF8Gzp4ujh5uLFxMj079+/s+dP3b5zk4GBQV1N09DAhImRCV72MTAw8PHyB/mHIWdAonKyt4c/AwPDz58/Z82fcu/+HYjg6XMnjp86kp6Uw8rKBleppKiCy3TCOXnH7i1w06Hl673bO3ZvpUKFg1zO8PHy52eX/Pv3f9L0ns+fP+07uGvfwV1kFhWYOQUS9EKCIiLCohpqWljyMzYtOH3g5uLFwMAAr3CgVYqzF1TW2YvhP4asixcJNdpou2gYWgAAQUT68EwArSIAAAAASUVORK5CYII="
    m["light_side_share"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADP0lEQVR42tVWXUiTYRQ+X9/m32yYc2PKUpciK5CRibSZpjl1oeaceaOMtEsRvAi8EfTC20ARRC8UkwqEGKJdLHVg/s0wm/hHTof6pXPDzdz8mRv6+XXxTtcPan1bQe/Vw/O+nMM5533OOZjN5oS/ea7AXz4M303s7zs3NjYBQCCICg0N8acDl8ulVr/TasdI8gQAcByXyVKLix8GBQWevcF8qUFr66uJCf1PZEqKuKrqiR9qMD29gKxzuRyVSqlSFUVEhAPA5OTMzMxnP6Robm4Rgerqp9HRkQAgEsXV1j4HgNnZRbH4pq8ROJ0uBKKiuAjw+dzTq0NfU2SxbK2ufkF4cHAUAZ3uEwJcLod+ihyOvZ6egeHhDyRJIqa7+61ev3ByQhmNawAQEMCUSm/TcXB46NJo3ms0w263GzHh4WE7Ow6KogyGFc+nxLCysiI+n3eug6Ojo/FxPUGsA0BsrEAqvcNkMo+PybGxj2q1xuHYQ884nGuFhdnp6SlGI9HXp11bW8cwLCZGoFBkx8fHfm/wBx0QhKm5+YXVun3G8HicrKzUoSGdxWJDDIvFys/PzMlJYzKZvxO314HL5a6vbzSbt857GhgYmJublpf3IDg4iE4vGh2dRNYlkqSyMgUA1db2en5+CWU2I+NuUVFuWBibfjcliA0EVColmx3KZl+trFQhJjk5saKihIb1S3RAUZQ/50FMzHUEurrUdvuu3b7b0vISMVNTc52db+z2XRoOvEV2u911df4vMl5TU+spN4MhEt2YnzccHHg7CZ8fUVAgs9m29/edJEkaDCtDQxMYBkKhAMfxP4vgTGg6nZ4gNpBwpNIkBoNxgdCWl9d6ewcIwgTgEVpCgvAiB/RahdcchpWXP87MlNCfaL82OwyDhIQ4AFhaWqEoKiCA2dDwLDKS59PItFi2Ghs7zGYrAJSWPpLLMwBgZGSyvb0bABSKHKVS7tM84PN5QmE0wjLZPQQkEk+Xtlq/+mEmh4R4PuvmpvUUbJ1eBfthJovFt7TacQBoauqQy+9TFNXfP4yuEhNF/25t8WnxqqgoYbNDtdpx9KNwHM/OTlMqc2nq4ILV0WQyo9WRxQq+RMn/33b9DUXJgWut1wMkAAAAAElFTkSuQmCC"
    m["light_sel_share"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAADcUlEQVR42tWWSUxTYRCA5/n67AJFWlqXtlQQCKCotbLYYkVkUVFEimKUqInGxJgYL968eDEejMbowcQEF9yIGmIkbiiIWGkoAStgLUsKlFatLNpWSgt5fR5+0hIjoK+Pg3P6Mv+fmfwz/yxYZzsFcynzYI6FFboJj2f0y1c7ACxZLOXxwph04PN5n9ZU6xrr/X4/AOA4nqnKKsjfwWazmQnR/aq7Dbo6ZB0ASJJs0NVVPqxgJgcfTW2txmYAiBKKtEV7tEWlQkEUABjbWk3mDgZCZO4yITh04KhkiRQA4mITzl08AwDmTtPypJRQX+D1jiFYKF6EQCyahDGvJ9QQDQ45rLZ+xDr9awStRgMCoUBEP0Rut+v5qydNze9IkkSax0+q2j+2URTV128BAIIgUpVpdBx4vd76ty9fN9SOj/uQJjJS4HT+oCjK0tuDNBiGFReWBmL1BwcTExMt7w22z1YAiJbKlYp0giBIkjS06J+9qHb/dKFrgkhhXs7WjDR1f39vTd0zm92KASaTRufnFsTIl001iE3tRTb7wI3bV4dHhgKaKKEoU5Wlb2oYHBpEGh43LCc7X6POJgjib94ddODz+S5cPvtt0DHd1fnz2RvWb8rJyudwOHR6kaGlEVlXKtJ2Fu4GoO5UXu/sNqPIqtLXb87dFhGxgH43tdkHEJQU7eGH8/nhEfv3HUaaVSmK3dp9NKzPUgcURTE5D2RSOYKHjypdLqfL5ay4U440bR3GB1V3XS4nDQfBJI+P+85fYj7J+PFjpycJZ8XFxnd1mz1jwU4iFolzs7eOfB/yeDwkSVp6e/QGHYaBTCrHcfzfXhAotFZjs81uxeZhMolcqUhjsViThVZT7Xb/Xmh9fZaauqc2+wAGIJXIN+cWxMbEzeSAXqsImsOwXcV71RkaOg6ma3YYBstiEgDA0tdDURRBECdPnAr08GAO/lLYbPaK5JVrVq/t7P406hkFgJ2FJaXasvRUlSBS2GH64Pf7w3i8+LjEkOaBWLRILluKOHPdRgRrVqciGB4ZZmAmczhcBIGf7fj2FQGXw2NgJicnpej0bwCg/OaVLE0OUFS9rhYdJSUup5/kqXLr3jW0WEwVxSrlwbIjzCxepdqy8HD+O/0b9KNwHNeos7fkbadZBzOtjo7PACBZLOVyebNU8v+3Xf8CgEmDsWsxSTEAAAAASUVORK5CYII="
    m["light_side_sparkle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACqklEQVR42tWWv0sbYRjHv5fL0XDeIipCW4yQDCo13tWQy5lCsOigDv0D3Lo4Cu3UJYPugpDVQhGXDkUHMxhoiBiTk9jLj6IWkpDT2sWIyxmtl8t1eGkqrT+IJqV9pvd9OO7zPt/nBw9VKpXRTLOgyVYfQFUPVfWwWYBC4SAQmAsE5gqFg6YAotG4aZqmaUaj8cYDdF2X5RQ5y3JK1/UGAxRlp1w+J+dy+VxRdhoMiMWSN1zvC9C0cja7B8DptDscdgCZzJ6mnTYMEI9/qlQMAD6f2+dzAzAMI5FINQCgaafh8EYoFAFgtdKiyHu9vNVKA1hd/RgOb9waB3XlqNB1XVF2YrFkJrNnGAZxDg4+mZ5+CWB+/u329mfipGna5erx+dyC0McwzO2AYvFrJLIpy6lazZC3u1y9k5MvOjraABwdHS8trWQyu0Q3YixrE0V+eHiou/vxtYD9/W+BwFy1Wq15nE770JDb6xU4jv0z84mEsrmZzOXUX4pbLDMzr7q6Hv69Yfd3JWpGkq1XxsUwjMcz4PEMaNppPK6EQpHj45N0epcUZTq9C6CtrXV8fFiSBI5ruUEi680KclzL6OgzAIuLHyoVQ5ZTpgmizMTE85ERX2M6WZKekuaKxZJkCtE07fXyDRsVHMf29/cAyOXUfF4F4HL1/KbMwsL7qak3tdzUXaZkBF13BbC+Lp+dfU8klPpyUDNB6GNZG6ldlrUJQh/xG0Y1m/1ycXFhmiaAUulkayvd2dlutz+qD8AwjCjykUgCgCjytYpcWVlbXl6rfZbPF4PBIkVRs7OvST/X0cl+v0RRFEVRfr90906+dW0BUAv/skTB4DsADkf32Jj/LhIRu/zrn51s4fleABRFmabZ3t7q8Qw0ZbPz+0Wb7YEkCfeS6P/fTf9FwA8RzFhjA7sjuAAAAABJRU5ErkJggg=="
    m["light_sel_sparkle"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAACtUlEQVR42tVWTUzTYBh+StfANg4y9SKwBQ84NreOdkuRgIBGjyYmnj14MjEaogeDB6/GizExJiYmhhguJESjiSaCCgQyafbDxrJSdoBsbJ7M8EAZWLp6+HASRXCjI/qevu/N1z59n/d9nn7UQkJHNaMGVY7yALK55WxuuaxHTH9/NLOcfvj4PoD+a7ftzQ7jK5gJTeu6ruv6TGjaeIpUVY3NRch6Nh5RN1WDASQ5USgUyHp9vSDNJwwGCEXEXbb7BVhbU+SUBMBhb3HYWwDIqaSirBoGEImFNG0TQIAT/JwAQNO02R8t2ReAoqxOBSfGJ8cA0LTJ5+XbvTxNmwB8nBidCk7sWQe1o1WoqirJiVBElFNJTdNI0uNmr1y+CuDZ8yeJZJwkaZp2troDvOByehiG2Rsgm8sExanYXKQ0M+Tb2064L164ZGs4AiC/8uXl65H5hSThjYTZbPZ5+U6hu6nR/keA3Ofsg0f3isViKeOwt/g5gWP9Fov1985H4+FwVExnln4yXlNz8/pA47GmgzO7g6WoGk3e2U0ZhmE9HOvhFGU1Gg+PT46tfM1L8pa4JDkJoOGQra/nHMf6rdb6yu3aaq3v7uwF8OLVsKZtxuYiOkCYOdN7vutUjzFK5n0BIq5QVAxHRcJMu5c3zCosFquz1QUgnVkiQ+lsdf/CzPDI0MDd/lJvyh7TAC/ssgUghoPrGxuz8XCFv0yX02M2m8ns1tWZXW0eki8Wi3JKUtVvuq4DyK/k44noYdvRpsbm8gAYhvF5+U/iNIB2lmdMWxM5+uHNu/dvS8fSmcXBoUWKom7duEP0XIaSOwJdFEVRFNUR6KpcyXteWwCUyt9O0eDQUwAO+/G+02croYjE9leX3M3lPAmAoihd120NNtbDVeVmJwQ6a2vrOJ9/XxT9/3fTfxHgOwNnVHXiND3eAAAAAElFTkSuQmCC"
    m["light_side_target"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAFn0lEQVR42tVWS0xTWRj+e7mgQqVP8EGhEMUZKBVsC6FU02DVCaMD49A4IaioG8y4YFZd4ELZ4EIXg4sJZhINDw2TFJGHkjgMhYRqYUqjFKgjIlBsKaG0l7ZUam9vZ3FKlYqok3ExZ3XOved83znf/6TZ7V74kgODLzzwT9zn8Sw7HC6Hg6DRaGw2g8Vi0Omx/wHB/Lxdqx02GIxmszXiV0rKTrFYKJOJExO5GyDQPmQDl8vd1vawr08XCAQ2OB8VFXXwoLSk5Eh8PP0zCCYmpq9fv7W05EbL2NjNQmEGj7edzWYCgNO5NDs7ZzSavN4VtIHB2FpVdXb37tRPIhgcfHLjxh2SJAEgIYGjVBbl5mbjeFTENpIkh4aeqtXddrsDAHAcP3++PC8v+yMEExPTV678itAVioLy8u9xfCM7kSTZ1NSm0TxGHNXVP0W8Yw2By+W5ePEqUqas7LuiokL03Wye6+/XjY09X1wkAIDLZQoEe+Ty/OTkHWjDgwealpZOpFVtrWrr1ri3RlKpLoYXLS2dJtMLAJDL80+cOIYu2NjYdvPm75OTM273ciAQCAQCbvfy5KRZo3nsdnsEgj0YhqWnpy0teaamZn2+N34/mZ2dsU6gzc/b+/p0AJCYyKmo+AGhX716o7dXGwwGAYDFYuTkZOTkZLBYDAAIBoM9Pdpr135Dep48WcLlsgFAo3m0sLC4ThxotcPII0tLi5Duzc3tJtMkgq6oKN23T0Cj0RC0wTDW0KAmCNf4+MSdO+2nT5fiOK5UFtXX3ybJwMCA/vjxbyJfMDxsRB6Zm7sX6a7RPELoly5ViURZCB0AaDSaWJx1+fLPTGY8APT2Pn71ag4A8vJyYmM3A4DBMBopkcezPDtrBQChMANdv79fh5Q5c0bJZjMpimpv/0OluqJS1XZ09FAUxWYzKypKAYCiqP7+QQDA8Sih8GsAMJutHo93DYHDsbSaAEKOMTb2fFX3TADo7PyztbXbZluw2exq9YOuLg0AiERZ6BGjo3+jUzzeDqRhGDBE4HS60ITJZKx+IQCAz9+JlNHpDO96t06nR1qlpCQBgMNBrB6PRxOCWEuwKi9QFPUu0NrVRjltdRKMAAwRsFgh5nD+YbGYAGA2W5AlpFLJu3gFBRIkhdlsAQAOh/EhJfBVuNB6dnYOTbKy9lit8wThMhjGxOKsY8cKAUCr/QsA9u+XHD16EAD0eiNBuABAIPgKnbJYbEi6MGCIgE6PS0nZaTZbjUYTSZI4jsvl+T09WoqiGhrUqak8DodZXKwoLlaEH7G46GxqugsAGIbJ5VIUmCMjzwCAz08Kl6O3cSAWCwHA610ZGnoKAMnJOwoLpQBAEK6aml+Gh41IK6SMXj9SU1OHrq9QFPB421Aafv16BQBEIsE6kSyTiTs6egKBgFrdnZeXjeN4eXmJ1WozmSYJwlVXd4vJjE9NTQKAqalXYVNlZqaXlRUDgN/vb23tRtEgk0nWSXZxcbFut+flS7PX+9rpJEQiIYZhUqloedk7PW0JBoMrKz6bzW6z2X2+N0iZQ4f2V1aWocBsbLw7Pj4BAIcPH8jPF62fTdPSkrVavc/3ZmbGumlTTHp6GoZh2dmZEokQx3Gfb8XvJ6Oj8e3buVKp+Ny5Hw8ckGAYBgD37/d2dfWiOLhw4VRMTMwHC86LF9O1taGCU1goPXXq+MYFx+/3Nze3aTQ6AIiOxqurL+zaxf9IyRwaelpffxtxcLkspfJbZJL3a9ng4JPW1m673YnQKys/oWSG31FX97bob9myee/ejKSkbRwOCzmoxWIbGXmGfAYpU1V1NuLuH2lb3O7le/ceajSPSHKjtgXHoxQKWUnJYTo97vP6IjQWFhYHBvQGw+jMjCXiF5/PE4sFMpkkIYHzbxqv91pHr9O5hJLwZ7WOtP99d/0PSn2xcxwbvyoAAAAASUVORK5CYII="
    m["light_sel_target"] := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAFqUlEQVR42tVWW1BTVxTdubmlvJPgE4ioVRryxvAIGKFKiyhUFF9DW8e29oOZWmfKj/3q2I+OM60fdqb6QWeKHYeOYlVqmMZCwUdBIBQDAQISkYIJN7wk9+YmEJLc3H6cEDUiaKd+dH/dc+45a529zt5nb85ADwuv0jB4xYa/4DqXy0k5KJKyc4DD5/N5sfzIyKj/gGByarLDoO/tMxI2a8ivxAShTKJMV6mXL1uxCALneXdAOx11Dbq29maGYRbZz+VyN2fl5OcVxkTHvATB8MhQ5fkK2ulAw/DwCLFIunpVAp/HBwCHgyTGiP4Bk9s9ixbExMQeOVy2LumNFyLo6r77c/VPPp8PAJbFLS8sKFbKVVwuN2QZw/i6ug26Ou20/REA4Dh+qPRjpVy1BMHwyNDZH04jdE12bsmuA1zuYvfk8/lqtJda9E2I42hZeYgfTxHQTvrU6a+RMsVFe7fl5qN5wjba1n7HPNhvJ+0AECeIe3NjSlamJn51Ilpw4/YftbqrSKvj5V9GR0U/vqRjn34VHNTqagaHzACQlaF5d2cJOuCVa9WXrlSNWP52uZwMwzAM43Q5RyzDLfomp5MWJadgGLZ+3QbaSVusIx7PnM/rE6dIF0i0yanJtvZmpPv+klKEXlH5fUvbnyzLAgCPx5ekyCQpMh6PDwAsyza33q748QzD+ACgZNeBOMEyAGjRNz2anlogDzoMehSRhQXFSPea2l8GH5gR9P49pVKxgsPhIOjevu7LNRccNHX/wcCvtZf37SnFcbywoLjq4jmG8XUY9AXvFIV60NvXhSJSKd+EdG/VNyH0z48el0mUCB0AOByOXKosP/ZFbAwPHdk2TgBAqiItIiICAHpMxlCJXC4nYRsFALFIio7f1n4HKXNgz3t8nsDP+usbr588deLkqRMNN677WT+fJ0BK+v3+tvY7KOlEyRIAIGzWmRnXUwQkRaKPhPhAYJgH+wO6i+UA0HCj7nq9dnJqYnJq4rc6bePNegCQSZTICfP9frQLxRXLskHAAIHDQaEPtAEAKMoOAInxQqRMp/GvJ6O709iOtEpMEAIASU6jeV4sbx7waYJ5eQHJErSQ4bPGhuyfnwjOBAhi55lpOuAKjycAgFHCijhUqZlP4qZtUiN6grACgIAvmJeaCnEFnx/zA0k7RqAPUbJ4fGLMQVO9fd1yqfLtbdsBoMPQBsDJSFPnvbUdALp7uxw0BQDJG8Vo19g4gaQLAgYIoqKiE+KFhM3aP2BiGB+Xi2dlappbb/v9/ss1F4SJSQK+ID9vR37ejqATJDl99Vo1AGAYlpWxBSXmPbMJAIQJa4Ll6HEeyKVKAHC7Z7u6DSgestU5AOCgqe/OfNNj6greB8uy3b2dp898i46vyc6NXx2PnmG32w0AMqligUxOV6kbbv7OMIyuTquUq3AcL9m1f3zCNvjA7KCpyvMVsTE8YeIaALCMPqTpQKlI3iDaXbQPALxer65eCwBcLp6uUi/w2EVGRjld9EPL8Kx7lnKQcqkSw7C01IyZmRkrYWFZds4zh/LA45lDymzJ3vpB6YcoMa9eq74/OAAAOZqtKmXGwq+pMHFtR6fe45kbJaxhYa+vX7cBwzBJikwh38Tl4h6P2+f14ji+YsVKVWrmwb2HMtOzMAwDgMZb9Y236lAaHX7/k7CwsOcXnIdDZysCBWezOqek+CCOL1ZwvF5vTe2lVn0zAOD4a5+Vla9NWr9EyTT2GKounkMcAkFcUcHuVIXq2brGML5O411dvdZun0boh0o/WrpkBv2oPF8RvMnw8HCxSLZqZTxKKDtpHxsn7plNKGaQMkcOl4WcfYm2xely1jfoWvRNqJ48v23BNdm52/N2Rj1RJl+IANmj6akOg77HZBwlLM80XkkKmSJdpY4TLP83jVeIzcy4KAdJkiQAvFTryPnfd9f/ACI1sipdmjK9AAAAAElFTkSuQmCC"
    return m
}

; Writes the icons for the current theme to the data folder once, returns that folder
IconDir() {
    static dir := ""
    theme := DarkOn() ? "dark" : "light"
    want := DATA_DIR "\icons\v2_" theme
    if (dir = want)
        return dir
    if !FileExist(want "\side_gamepad.png") {
        try DirCreate(want)
        for k, b64 in IconData() {
            if (SubStr(k, 1, StrLen(theme) + 1) != theme "_")
                continue
            try B64ToFile(b64, want "\" SubStr(k, StrLen(theme) + 2) ".png")
        }
    }
    dir := want
    return dir
}

B64ToFile(b64, path) {
    size := 0
    DllCall("Crypt32\CryptStringToBinary", "Str", b64, "UInt", 0, "UInt", 1, "Ptr", 0, "UInt*", &size, "Ptr", 0, "Ptr", 0)
    buf := Buffer(size)
    DllCall("Crypt32\CryptStringToBinary", "Str", b64, "UInt", 0, "UInt", 1, "Ptr", buf, "UInt*", &size, "Ptr", 0, "Ptr", 0)
    f := FileOpen(path, "w")
    f.RawWrite(buf, size)
    f.Close()
}

; Which icon goes with which setting text
IconFor(text) {
    static m := 0
    if !IsObject(m) {
        m := Map()
        for k, v in Map(
        "Click reward buttons (Continue, Collect, Claim...)", "gift",
        "Start by itself when I click into Fortnite", "playcircle",
        "Laptop: stop when the battery is low", "battery",
        "Dim the screen while running", "moon",
        "Check Fortnite's servers first (wait during outages)", "server",
        "Leave when I got no teammates, or they all left (experimental)", "exit",
        "FPS saver: Fortnite at 30 FPS while running (yours comes back after)", "gauge",
        "Keep the PC awake while running", "coffee",
        "Click known Fortnite popups by itself (disconnected, server not responding, removed...)", "puzzle",
        "Open Fortnite by itself (scheduled start, crash, stuck)", "rocket",
        "Live status message (shows when the PC went offline)", "broadcast",
        "Try to switch the mode for me (experimental)", "shuffle",
        "Mute Fortnite while running", "mute",
        "Windows notifications (stopped, stuck, crashed)", "bell",
        "Read my placement and XP after each match", "medal",
        "Screenshot to Discord after every match", "camera",
        "Stop moving while I'm spectating teammates", "eye",
        "Start with Windows", "power",
        "Hide the status box from OBS / streams / screenshots", "eyeoff",
        "Get the newest words online (weekly prize names)", "globe",
        "Don't click Play Again while my teammates are still playing", "pause",
        "Wake Fortnite from Sleep Mode (clicks Keep Playing)", "alarm",
        "Watch for treasure", "chest",
        "Weekly recap on Sundays at 8 PM", "calendar",
        "Profile", "sliders",
        "Stop after a time, or at a clock time:", "stop",
        "When it stops:", "flag",
        "After a match:", "finish",
        "Stop after this many matches (0 = no limit):", "hash",
        "Your name (for Discord and the leaderboard):", "tag",
        "Team size", "people",
        "Build", "brick",
        "Fill", "personplus",
        "If the mode is wrong", "warning",
        "Start every day at:", "alarm",
        "Fresh restart: restart Fortnite every this many hours, between matches (0 = off):", "refresh",
        "Or set Fortnite's volume while running (0-100, 100 = leave it):", "speaker",
        "Battery % that counts as low:", "battery",
        "Discord alert link (optional):", "link",
        "Daily Discord summary at (blank = off):", "news",
        "Screenshot to Discord every (minutes, 0 = off):", "camera",
        "Friends leaderboard: webhook link of a shared channel (optional)", "trophy",
        "Phone push with the free ntfy app: topic name (optional)", "phonebell",
        "Bot token", "key",
        "Channel ID", "hash",
        "Your Discord user ID (only you can control it)", "idcard",
        "Data folder:", "folder",
        "Delete match lists older than this many days (0 = keep, treasure finds are always kept):", "trash",
        "Delete proof screenshots older than this many days (0 = keep forever):", "image",
        "Keep the log under (MB):", "scroll",
        "Warn when a drive has less than (GB, 0 = off):", "disk",
        "Settings code (your profile, timers, movement and look. No names or Discord links):", "clipboard",
        "Prize banner (must be on screen)", "sign",
        "My own words", "pen",
        "Clip with", "video",
        "Clip key", "keyboard",
        "Wait (seconds)", "hourglass",
        "Stop after the match when I find:", "octagon",
        "Language", "globe",
        "Theme", "contrast",
        "Accent colour", "palette",
        "Status box style", "window",
        "Status box corner", "corner",
        "Status box size", "zoom",
        "Fortnite's screen", "monitor",
        "What to look for", "search",
        "Keep it safe", "shield",
        "When I find treasure", "bellring",
        "Clips", "film",
        "Lobby Loop keys", "keyboard",
        "Your Fortnite keys", "gamepad",
        "Tools", "wrench",
        "Recent finds", "history",
        "Pirate Shop Access (pirate token)", "skull",
        "Gizmos (Sprite Locator, Lucky Locator...)", "compass",
        "Treasure (any other prize)", "gem",
        "Windows notification", "window",
        "Play a sound", "speaker",
        "Tell Discord", "chat",
        "Add a screenshot", "camera",
        "Save a clip (20 s before + 5 s after)", "film",
        "Team Fill check: make sure Fill is on before every queue", "plus",
        "Also put the PC to sleep", "moon",
        "Lobby proof: screenshot the prize screen, then click Claim", "receipt",
        "Send the clip to Discord (if under 10 MB)", "upload",
        "Show the status box", "eye",
        "Week {1} prizes", "gift",
        "This week's prizes", "gift")
            m[Tx(k)] := v
    }
    t := Trim(text)
    if m.Has(t)
        return m[t]
    for k, v in m                                       ; e.g. "Show the status box  (F10)"
        if (StrLen(k) >= 8 && SubStr(t, 1, StrLen(k)) = k)
            return v
    return ""
}

SectionIcon(name) {
    static m := Map(
        "Play", "gamepad",
        "Mode", "target",
        "Squad fill", "people",
        "Schedule", "clock",
        "Extras", "sparkle",
        "Treasure", "chest",
        "Alerts & clips", "film",
        "Hotkeys", "keyboard",
        "Popups", "puzzle",
        "Discord alerts", "chat",
        "Phone control", "phone",
        "Look", "palette",
        "Storage", "broom",
        "Share & tools", "share")
    return m.Has(name) ? m[name] : ""
}

; After the window is built: put an icon in front of every setting, section and page title
AddSettingsIcons(g, pages, navs, sections) {
    dir := IconDir()
    if !FileExist(dir "\side_gamepad.png")
        return
    for i, n in navs {
        ic := SectionIcon(sections[i][2])
        if (ic = "" || !FileExist(dir "\side_" ic ".png"))
            continue
        n.Opt("+0x4000000")                             ; clip siblings: don't paint over the icon
        n.GetPos(&x, &y, &w, &h)
        p := g.Add("Picture", "x" (x + 12) " y" (y + (h - 20) // 2) " w20 h20", dir "\side_" ic ".png")
        DllCall("SetWindowPos", "Ptr", p.Hwnd, "Ptr", 0, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x13)
        NAV_ICONS[n.Hwnd] := [p, dir, ic]
    }
    for i, pg in pages {
        count := pg.Length
        loop count {
            ctrl := pg[A_Index]
            if (ctrl.Type != "Text")
                continue
            ic := (A_Index = 1) ? SectionIcon(sections[Min(i, sections.Length)][2]) : IconFor(ctrl.Text)
            if (ic = "" || !FileExist(dir "\bg_" ic ".png"))
                continue
            ctrl.GetPos(&x, &y, &w, &h)
            big := (A_Index = 1)                        ; page title
            sz := big ? 26 : 18
            p := g.Add("Picture", "x" x " y" (y + (big ? 3 : Max(0, (Min(h, 22) - sz) // 2))) " w" sz " h" sz, dir "\bg_" ic ".png")
            ctrl.Move(x + sz + 8, , Max(20, w - sz - 8))
            pg.Push(p)
        }
    }
}

; ============================================================
; v7.9: the match recap shows "TREASURE FOUND:" and only an icon (no name).
; Look at the icons under the label: Pirate Shop Access is a gold square with an F compass.
; ============================================================
RecapIcon(label) {
    lh := Max(16, label.h)
    x := Max(MON_X, label.x - 10), y := label.y + lh + lh // 2
    w := Min(Round(MON_W * 0.30), MON_X + MON_W - x), h := Min(lh * 5, MON_Y + MON_H - y)
    out := {gold: false, ratio: 0, path: ""}
    if (w < 40 || h < 40)
        return out
    path := A_Temp "\ll_recap_icon.png"
    try FileDelete(path)
    if SaveRegionImage(path, x, y, w, h)
        out.path := path
    cap := Capture(x, y, w, h)
    cell := 10, cols := w // cell, rows := h // cell
    grid := []
    loop rows {
        r := A_Index - 1
        row := []
        loop cols {
            cx := x + (A_Index - 1) * cell, cy := y + r * cell, n := 0, g := 0
            loop 5 {
                py := cy + (A_Index - 1) * 2
                loop 5 {
                    c := Px(cap, cx + (A_Index - 1) * 2, py)
                    if (c < 0)
                        continue
                    n += 1
                    rr := (c >> 16) & 0xFF, gg := (c >> 8) & 0xFF, bb := c & 0xFF
                    if (rr > 170 && gg > 110 && bb < 110 && rr >= gg && rr - bb > 90)
                        g += 1
                }
            }
            row.Push(n ? g / n : 0)
        }
        grid.Push(row)
    }
    win := Max(3, Round(lh * 3.2 / cell))               ; an icon is about 3 label-heights wide
    best := 0
    loop Max(1, rows - win + 1) {
        r0 := A_Index
        loop Max(1, cols - win + 1) {
            c0 := A_Index, sum := 0, cnt := 0
            loop Min(win, rows - r0 + 1) {
                rr := r0 + A_Index - 1
                loop Min(win, cols - c0 + 1) {
                    sum += grid[rr][c0 + A_Index - 1]
                    cnt += 1
                }
            }
            best := Max(best, cnt ? sum / cnt : 0)
        }
    }
    out.ratio := Round(best, 2)
    out.gold := best >= 0.25
    Log("Recap icon gold: " Round(best * 100) "%")
    return out
}
