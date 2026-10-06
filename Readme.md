# Scripting404 UI Library

A modern, responsive, single-file UI library for Roblox executors. It ships with an animated black-hole background, tab sidebar, collapsible groups, global feature search, notifications, dialogs, theme presets, a built-in config system, and an optional anti-tamper module.

- **Version:** 4.0
- **Platforms:** PC and mobile (auto-scales and switches to a compact layout on touch devices)
- **Dependencies:** none required. Lucide icons are fetched at runtime and fall back to text glyphs if unavailable.

---

## Table of Contents

1. [Features](#features)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Window](#window)
   - [CreateWindow Options](#createwindow-options)
   - [Toggle Button Options](#toggle-button-options)
   - [Window Methods](#window-methods)
   - [Window Properties](#window-properties)
5. [Tabs, Sections and Groups](#tabs-sections-and-groups)
6. [Elements](#elements)
   - [Common Options and Methods](#common-options-and-methods)
   - [Display Elements](#display-elements) (Section, Divider, Label, Paragraph, Tag, Info, Progress, Stat, Image, Code, Console)
   - [Interactive Elements](#interactive-elements) (Button, Toggle, Slider, Dropdown, Segmented, Input, TextArea, Keybind, ColorPicker)
   - [Custom Element](#custom-element)
7. [Notifications](#notifications)
8. [Dialogs](#dialogs)
9. [Icons](#icons)
10. [Themes](#themes)
11. [Configuration System](#configuration-system)
12. [Settings Tab](#settings-tab)
13. [Search](#search)
14. [Secure Mode (Anti-Tamper)](#secure-mode-anti-tamper)
15. [Library API](#library-api)
16. [Keyboard Shortcuts](#keyboard-shortcuts)
17. [Full Example](#full-example)
18. [Troubleshooting](#troubleshooting)

---

## Features

- Animated black-hole background with falling glyph rain on notifications
- Responsive layout: auto-scale, compact mode for touch devices, collapsible sidebar, resizable and maximizable window
- 18 ready-made elements (toggles, sliders, dropdowns with search, color picker, console, and more)
- Collapsible groups, section headers, dividers
- Global search (`Ctrl + F`) that jumps to and highlights any feature
- Notifications with six anchor positions, and modal dialogs
- 5 theme presets plus fully custom themes, changeable at runtime
- Automatic config save/load via flags, with import/export through the clipboard
- Customizable floating toggle button with animations and a custom renderer
- Optional anti-tamper (Secure Mode)
- Singleton window: re-executing the script replaces the previous window

---

## Installation

Host `Scripting404UI.lua` somewhere reachable (for example this GitHub repository) and load it with `loadstring`:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()
```

Replace `<user>` and `<repo>` with your own values.

---

## Quick Start

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()

local Window = Library:CreateWindow({
    Title = "My Hub",
    Version = "v1.0",
    Theme = "Midnight",
})

local Main = Window:CreateTab("Main", "home")

Main:AddToggle({
    Name = "Auto Farm",
    Flag = "auto_farm",
    Default = false,
    Callback = function(state)
        print("Auto Farm:", state)
    end,
})

Window:CreateSettingsTab()

Window:Notify({ Title = "Loaded", Content = "Welcome!", Type = "success" })
```

---

## Window

### CreateWindow Options

`Library:CreateWindow(cfg)` returns a `Window` object.

| Option | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `"Scripting404"` | Window title. Hidden automatically when the window is narrow. |
| `Icon` | string / number | `"terminal"` | Title icon (Lucide name or asset id). |
| `Version` | string | `nil` | Shows a small version chip in the header (visible when width >= 580). |
| `Theme` | string / table | `"Dark Gray"` | A preset name or a table of theme color overrides. See [Themes](#themes). |
| `Accent` | Color3 | preset accent | Overrides only the accent color. |
| `Singleton` | boolean | `true` | When not `false`, destroys the previous window on re-execute. |
| `Size` | Vector2 | `540x360` (`440x280` compact) | Initial size. |
| `MinSize` | Vector2 | `360x240` (`320x210` compact) | Minimum size when resizing. |
| `MaxSize` | Vector2 | `980x680` | Maximum size when resizing. |
| `Scale` | number | `1` | User scale multiplier. |
| `AutoScale` | boolean | `true` | Scales the UI to fit the screen. |
| `ToggleKey` | Enum.KeyCode | `RightShift` | Key that shows/hides the window. |
| `ConfigFolder` | string | `"Scripting404"` | Folder used for saved configs. |
| `ConfigName` | string | last used or `"default"` | Config file to use. |
| `AutoLoad` | boolean | `true` | Loads the config on startup (set `false` to disable). |
| `AutoSave` | boolean | `true` | Saves flags automatically (set `false` to disable). |
| `SaveDelay` | number | `1.2` | Debounce delay (seconds) for auto save. |
| `Background` | boolean | `true` | Shows the animated black-hole background. |
| `BackgroundParticles` | number | `110` (`60` on touch) | Number of background glyph particles. |
| `ShowUser` | boolean | `true` | Shows the player profile card at the bottom of the sidebar. |
| `NotifyPosition` | string | `"TopLeft"` | `TopLeft`, `TopCenter`, `TopRight`, `BottomLeft`, `BottomCenter`, `BottomRight`. |
| `MaxNotifications` | number | `5` | Maximum notifications on screen at once. |
| `ToggleButton` | table | see below | Floating restore button options. |
| `OnClose` | function | `nil` | Called after the window is destroyed. |

### Toggle Button Options

The toggle button appears when the window is minimized (or always, with `AlwaysVisible`). Pass these in `cfg.ToggleButton`, or later with `Window:SetToggleButton(opts)`.

| Option | Type | Default | Description |
|---|---|---|---|
| `Position` | UDim2 | top center | Initial position. |
| `Size` | number | `46` | Button size in pixels. |
| `Shape` | string | `"Rounded"` | `Rounded`, `Circle`, or `Square`. |
| `Transparent` | boolean | `false` | Removes background and stroke. |
| `Background` | boolean | `true` | Set `false` to hide the background. |
| `BackgroundTransparency` | number | `0` | Background transparency. |
| `BackgroundColor` | Color3 | theme `Panel` | Background color. |
| `Stroke` | boolean | `true` | Show or hide the border. |
| `StrokeColor` | Color3 | theme `Accent` | Border color. |
| `Icon` / `Image` | string / number | window icon | Icon displayed on the button. |
| `IconSize` | number | auto | Icon size in pixels. |
| `IconColor` | Color3 | theme `Accent` | Icon tint. |
| `Animation` | string | `nil` | `pulse`, `float`, `spin`, `glow`, or `breathe`. |
| `AlwaysVisible` | boolean | `false` | Keeps the button visible; clicking toggles the window. |
| `Draggable` | boolean | `true` | Set `false` to lock the position. |
| `Custom` | function | `nil` | `function(holder, api)` for fully custom rendering. |
| `ClipCustom` | boolean | `false` | Clips the custom holder to its bounds. |

The `api` passed to `Custom` contains: `Theme`, `Tween`, `Window`, `Button`, `Face`, `Icon`, `Size`, `SetIcon`, `Create`, `OnState(fn)`, `OnHover(fn)`, `OnClick(fn)`, `Track(connection)`.

```lua
ToggleButton = {
    Shape = "Circle",
    Animation = "pulse",
    Icon = "terminal",
    AlwaysVisible = true,
}
```

### Window Methods

| Method | Description |
|---|---|
| `Window:CreateTab(name, icon)` | Creates a tab and returns a `Tab`. The first tab is selected automatically. |
| `Window:CreateTabSection(text)` | Adds an uppercase label to the sidebar tab list. Call it before the tabs it should precede. |
| `Window:SelectTab(tab)` | Selects a tab programmatically. |
| `Window:CreateSettingsTab(name, icon)` | Builds a ready-made settings tab. See [Settings Tab](#settings-tab). |
| `Window:Notify(options)` | Shows a notification. See [Notifications](#notifications). |
| `Window:Dialog(options)` | Shows a modal dialog. See [Dialogs](#dialogs). |
| `Window:Minimize()` | Minimizes the window. |
| `Window:Restore()` | Restores the window. |
| `Window:Toggle()` | Toggles between minimized and restored. |
| `Window:ToggleMaximize()` | Maximizes or restores the original size. |
| `Window:Destroy()` | Saves config (if auto save is on), disconnects everything, removes the GUI. |
| `Window:SetTitle(text)` | Changes the title. |
| `Window:SetToggleKey(keyCode)` | Changes the show/hide key. |
| `Window:SetTheme(table)` | Applies theme color overrides live. |
| `Window:SetThemePreset(name)` | Applies a preset. Returns `false` if the name is unknown. |
| `Window:SetAccent(color3)` | Changes the accent color live. |
| `Window:SetBackground(bool)` | Shows or hides the animated background. |
| `Window:SetScale(multiplier)` | Sets the user scale (clamped to 0.4 - 2). |
| `Window:SetAutoScale(bool)` | Enables or disables auto scale. |
| `Window:SetSidebar(mode)` | `"Auto"`, `"Expanded"`, or `"Collapsed"`. |
| `Window:SetAutoSave(bool)` | Enables or disables auto save. |
| `Window:SetNotifyPosition(pos)` | Moves the notification stack. |
| `Window:SetToggleButton(opts)` | Rebuilds the toggle button. |
| `Window:SaveConfig(name)` | Saves flags to a file. Returns `true` on success. |
| `Window:LoadConfig(name)` | Loads and applies a config. Returns `true` on success. |
| `Window:DeleteConfig(name)` | Deletes a config file. |
| `Window:ListConfigs()` | Returns a sorted array of config names. |
| `Window:ExportConfig()` | Returns the current config as a JSON string. |
| `Window:ImportConfig(json)` | Applies a JSON config string. Returns `true` on success. |

### Window Properties

| Property | Description |
|---|---|
| `Window.Flags` | Table of current flag values (`Window.Flags["auto_farm"]`). |
| `Window.Setters` | Table of flag setter functions. |
| `Window.Tabs` | Array of created tabs. |
| `Window.Minimized` | `true` while minimized. |
| `Window.Destroyed` | `true` after `Destroy()`. |
| `Window.AutoSave` | Current auto save state. |
| `Window.ConfigName` | Active config name. |
| `Window.Compact` | `true` if the compact (mobile) layout is active. |
| `Window.Gui` | The `ScreenGui`. |
| `Window.Main` | The main window frame. |
| `Window.Library` | Reference to the library table. |

---

## Tabs, Sections and Groups

```lua
Window:CreateTabSection("General")           -- sidebar label
local Combat = Window:CreateTab("Combat", "swords")
local Visuals = Window:CreateTab("Visuals", "eye")
```

A `Tab` supports every element method listed below, plus:

| Method | Description |
|---|---|
| `Tab:Select()` | Selects this tab. |
| `Tab:GetPage()` | Returns the underlying `ScrollingFrame`. |
| `Tab:AddGroup(title, opts)` | Creates a collapsible group. |

**Groups** hold elements inside a collapsible card. Groups cannot be nested.

```lua
local Group = Combat:AddGroup("Aimbot", { Icon = "crosshair", Collapsed = true })

Group:AddToggle({ Name = "Enabled", Flag = "aim_enabled" })
Group:AddSlider({ Name = "FOV", Min = 10, Max = 360, Default = 90, Flag = "aim_fov" })
```

| Group option | Type | Description |
|---|---|---|
| `Icon` | string / number | Icon next to the title. |
| `Collapsed` | boolean | Start collapsed. |

| Group method | Description |
|---|---|
| `Group:Expand()` | Expand the group. |
| `Group:Collapse()` | Collapse the group. |
| `Group:Toggle()` | Toggle expanded state. |
| `Group:SetTitle(text)` | Change the title. |

Groups support all element methods, so elements are added the same way as on a tab.

---

## Elements

Every element method is available on both tabs and groups.

### Common Options and Methods

These options work on all elements from `AddLabel` through `AddColorPicker`:

| Option | Type | Description |
|---|---|---|
| `Locked` | boolean | Starts locked (dimmed overlay blocks input). |
| `Visible` | boolean | Set `false` to start hidden. |
| `Tooltip` | string | Hover tooltip (PC only). |
| `Keywords` | string | Extra words used by [search](#search). |
| `Flag` | string | Saves and restores the value in configs (interactive elements only). |

Returned objects additionally get:

| Method | Description |
|---|---|
| `obj:SetVisible(bool)` | Show or hide the element. |
| `obj:SetLocked(bool)` | Lock or unlock the element. |
| `obj:Destroy()` | Remove the element and its search entries. |
| `obj.Frame` | The element's root frame. |

### Display Elements

#### AddSection(text)
A bold accent header with an underline. Returns the frame.

```lua
Tab:AddSection("Movement")
```

#### AddDivider(text?)
A thin line, optionally with centered text. Returns the frame.

```lua
Tab:AddDivider("or")
```

#### AddLabel(text)
A wrapped text line. Returns `{ Set(text) }`.

```lua
local lbl = Tab:AddLabel("Status: idle")
lbl:Set("Status: running")
```

#### AddParagraph(title, body)
A title with wrapped body text. Returns `{ Set(title, body) }`. Pass `nil` to keep a part unchanged.

```lua
local p = Tab:AddParagraph("About", "This script does something useful.")
p:Set(nil, "Updated body text.")
```

#### AddTag({ Name, Tags })
A row of chips. `Tags` can contain strings or `{ text, Color3 }` pairs.

```lua
local tags = Tab:AddTag({
    Name = "Features",
    Tags = { "Fast", { "Beta", Color3.fromRGB(225, 175, 80) } },
})
tags:Add("New", Color3.fromRGB(110, 190, 140))
tags:Clear()
```

#### AddInfo({ Type, Title, Content, Icon })
A colored callout box. `Type` is `"info"`, `"success"`, `"warning"`, or `"error"`. Returns `{ Set(title, content) }`.

```lua
Tab:AddInfo({ Type = "warning", Title = "Heads up", Content = "This feature is experimental." })
```

#### AddProgress({ Name, Value, Suffix })
A progress bar (0 - 100). Returns `{ Set(v), Get() }`. `Suffix` defaults to `"%"`.

```lua
local bar = Tab:AddProgress({ Name = "Loading", Value = 25 })
bar:Set(80)
```

#### AddStat({ Name, Value, Icon })
A big-number stat card. Returns `{ Set(v), Get() }`.

```lua
local coins = Tab:AddStat({ Name = "Coins", Value = 0, Icon = "coins" })
coins:Set(1500)
```

#### AddImage({ Image, Height, Name })
Displays an image (asset id, `rbxassetid://` URL, or icon name). Returns `{ Set(image), Instance }`.

```lua
Tab:AddImage({ Image = 123456789, Height = 140 })
```

#### AddCode({ Title, Code })
A monospace code block with a copy button (needs `setclipboard`). Returns `{ Set(code) }`.

```lua
Tab:AddCode({ Title = "Loader", Code = 'loadstring(game:HttpGet("..."))()' })
```

#### AddConsole({ Name, Height, MaxLines })
A scrolling log with a Clear button. Returns `{ Log(text, kind), Clear() }`. `kind` is `"info"`, `"success"`, `"warning"`, or `"error"`. Defaults: `Height = 120`, `MaxLines = 200`.

```lua
local console = Tab:AddConsole({ Name = "Output", Height = 140 })
console:Log("Started", "success")
console:Log("Something failed", "error")
```

### Interactive Elements

#### AddButton({ Name, Description, Style, Icon, Callback })
- `Style`: `nil` (default), `"accent"`, or `"danger"`.
- Returns `{ Fire(), SetName(text) }`.

```lua
Tab:AddButton({
    Name = "Rejoin",
    Description = "Rejoins the current server",
    Style = "accent",
    Icon = "refresh-cw",
    Callback = function() print("clicked") end,
})
```

#### AddToggle({ Name, Description, Default, Flag, Callback })
- `Callback(state)` is called on change, and once at creation if `Default` is `true`.
- Returns `{ Set(bool, silent?), Get() }`.

```lua
local t = Tab:AddToggle({
    Name = "ESP",
    Default = false,
    Flag = "esp",
    Callback = function(on) print(on) end,
})
t:Set(true, true) -- silent: no callback
```

#### AddSlider({ Name, Min, Max, Default, Increment, Suffix, Flag, Callback })
- Defaults: `Min = 0`, `Max = 100`, `Increment = 1`.
- `Callback(value)`. Returns `{ Set(v, silent?), Get() }`.

```lua
Tab:AddSlider({
    Name = "WalkSpeed", Min = 16, Max = 200, Default = 16,
    Increment = 1, Suffix = " studs/s", Flag = "walkspeed",
    Callback = function(v) print(v) end,
})
```

#### AddDropdown({ Name, Options, Default, Multi, Search, Flag, Callback })
- Single select: `Default` is a value; `Callback(value)`.
- Multi select (`Multi = true`): `Default` is an array; `Callback(arrayOfValues)`.
- `Search`: shows a search box. When omitted, it appears automatically if there are more than 8 options.
- Returns `{ Set(v, silent?), Get(), Refresh(newOptions) }`.

```lua
local dd = Tab:AddDropdown({
    Name = "Target",
    Options = { "Head", "Torso", "Legs" },
    Default = "Head",
    Flag = "target",
    Callback = function(v) print(v) end,
})
dd:Refresh({ "Head", "Torso", "Arms", "Legs" })

Tab:AddDropdown({
    Name = "Modes", Multi = true,
    Options = { "A", "B", "C" }, Default = { "A" },
    Callback = function(list) print(table.concat(list, ", ")) end,
})
```

#### AddSegmented({ Name, Options, Default, Flag, Callback })
A segmented selector. `Name` is optional. Returns `{ Set(v, silent?), Get() }`.

```lua
Tab:AddSegmented({ Name = "Mode", Options = { "Easy", "Normal", "Hard" }, Default = "Normal" })
```

#### AddInput({ Name, Default, Placeholder, Numeric, Flag, Callback })
- `Numeric = true` rejects non-numeric text.
- `Callback(text, enterPressed)` fires when focus is lost.
- Returns `{ Set(v), Get() }`.

```lua
Tab:AddInput({
    Name = "Webhook", Placeholder = "https://...",
    Callback = function(text, enter) print(text) end,
})
```

#### AddTextArea({ Name, Default, Placeholder, Height, Flag, Callback })
Multi-line input (default `Height = 90`). Same callback and return values as `AddInput`.

#### AddKeybind({ Name, Default, Flag, Callback, Changed })
- `Default`: an `Enum.KeyCode`.
- `Callback(key)` fires when the bound key is pressed. `Changed(key)` fires when the user rebinds.
- Press `Escape` while binding to clear it (`Enum.KeyCode.Unknown`).
- Returns `{ Set(key, silent?), Get() }`. `Set` also accepts a key name string.

```lua
Tab:AddKeybind({
    Name = "Fly Key", Default = Enum.KeyCode.F, Flag = "fly_key",
    Callback = function() print("Fly pressed") end,
})
```

#### AddColorPicker({ Name, Default, Flag, Callback })
HSV picker with a hex input. `Callback(color3)`. Returns `{ Set(color3 | "#hex", silent?), Get() }`.

```lua
Tab:AddColorPicker({
    Name = "ESP Color", Default = Color3.fromRGB(255, 0, 0), Flag = "esp_color",
    Callback = function(c) print(c) end,
})
```

### Custom Element

`AddCustom(height, builder)` creates an empty card and calls `builder(frame, theme)` so you can build your own content. It returns the frame.

```lua
Tab:AddCustom(80, function(frame, theme)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.Text
    label.Text = "Hello from a custom element"
    label.Parent = frame
end)
```

---

## Notifications

```lua
Window:Notify({
    Title = "Success",
    Content = "Config saved.",
    Type = "success",
    Duration = 4,
})
```

| Option | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `"Notification"` | Heading. |
| `Content` | string | `""` | Body text (wraps). |
| `Duration` | number | `4` | Seconds before auto-dismiss. |
| `Type` | string | `nil` | `"info"`, `"success"`, `"warning"`, `"error"` (sets color and icon). |
| `Color` | Color3 | by type / accent | Overrides the accent color. |
| `Icon` / `Image` | string / number | by type | Custom icon. |
| `IconColor` | Color3 | auto | Icon tint. |

Returns `{ Dismiss = function }`. Clicking a notification dismisses it.

---

## Dialogs

A modal confirmation box inside the window.

```lua
Window:Dialog({
    Title = "Reset settings?",
    Content = "This cannot be undone.",
    Icon = "triangle-alert",
    IconColor = Color3.fromRGB(225, 80, 80),
    Buttons = {
        { Text = "Reset", Style = "danger", Callback = function() print("reset") end },
        { Text = "Cancel" },
    },
})
```

| Option | Description |
|---|---|
| `Title`, `Content` | Heading and body text. |
| `Icon`, `IconColor` | Dialog icon and tint. |
| `Buttons` | Array of `{ Text, Style = "danger"?, Callback? }`. Defaults to a single `OK` button. |

---

## Icons

Anywhere an `Icon` is accepted you can pass:

- A **Lucide icon name**, e.g. `"home"`, `"settings"`, `"swords"` (loaded at runtime from the Footagesus Icons module; requires HTTP access).
- A **number** or numeric string: treated as `rbxassetid://<id>`.
- A full `rbxassetid://`, `rbxasset://`, or `rbxthumb://` URL.

If an icon cannot be loaded, a text glyph (the first letter or a built-in symbol) is shown instead, so the UI still works offline.

---

## Themes

Presets: `Dark Gray`, `Graphite`, `Black`, `Midnight`, `Light`.

```lua
Library:CreateWindow({ Theme = "Midnight" })
Window:SetThemePreset("Light")
```

A custom theme is a table of any of these keys (missing keys keep the default):

| Key | Used for |
|---|---|
| `Background` | Window background |
| `Panel` | Sidebar, cards, dropdown rows |
| `Element` | Element backgrounds |
| `ElementHover` | Hover state |
| `Stroke` | Borders and tracks |
| `Text` | Primary text |
| `SubText` | Secondary text |
| `Accent` | Highlights, active states |
| `Danger` | Destructive actions |

```lua
Library:CreateWindow({
    Theme = {
        Accent = Color3.fromRGB(120, 180, 255),
        Background = Color3.fromRGB(12, 12, 16),
    },
})

Window:SetTheme({ Accent = Color3.fromRGB(255, 120, 120) })
```

---

## Configuration System

Configs are JSON files stored at `<ConfigFolder>/<name>.json`. The last used name is stored in `<ConfigFolder>/_last.txt` and loaded next time.

- Any element with a `Flag` is saved and restored automatically.
- Saves are debounced (default 1.2 s after the last change) when `AutoSave` is on, and also happen on `Window:Destroy()`.
- Requires executor file APIs (`writefile`, `readfile`, `isfile`; `makefolder`, `isfolder`, `listfiles`, `delfile` for the extras). Without them, auto save and file configs are disabled; clipboard export/import still works.
- Use unique flag names. Flags prefixed `ui_` are reserved for the settings tab.

```lua
Window:SaveConfig("legit")
Window:LoadConfig("legit")
print(table.concat(Window:ListConfigs(), ", "))

local json = Window:ExportConfig()
Window:ImportConfig(json)

print(Window.Flags["auto_farm"]) -- read a flag value
```

---

## Settings Tab

`Window:CreateSettingsTab(name?, icon?)` builds a complete settings page. Call it **after** your own tabs so it appears last.

It includes:

- **Interface:** theme preset, accent color, animated background, auto scale, UI scale, sidebar mode, notification position, toggle key, test notification
- **Configuration:** auto save, config name, saved configs list, save / load / delete / refresh, copy config to clipboard, import config
- **About:** collapsed info card

The settings tab uses these flags: `ui_theme`, `ui_accent`, `ui_bg`, `ui_autoscale`, `ui_scale`, `ui_sidebar`, `ui_notifpos`, `ui_togglekey`, `ui_autosave`.

---

## Search

The search pill in the header indexes every tab, group, section, and element by name, plus `Keywords`, paragraph/info/code content, and the element type.

- Press `Ctrl + F` to focus the search box.
- Press `Enter` to jump to the top result.
- Clicking a result opens the tab, expands the group, scrolls to the element, and flashes its border.

Add `Keywords` to make features easier to find:

```lua
Tab:AddToggle({ Name = "ESP", Keywords = "wallhack visuals players box" })
```

---

## Secure Mode (Anti-Tamper)

An optional module that watches common executor functions for tampering (hooks, replaced functions, and similar) and reacts when it detects it. It is **off by default**.

### Enabling

Set the globals **before** loading the library:

```lua
getgenv().SECURED_MODE = true
getgenv().SECURED_ACTION = "kick"      -- "kick" (default), "warn", or "serverhop"
getgenv().SECURED_MESSAGE = "Security: script tampering detected."
getgenv().SECURED_STRICT = false       -- true also flags non-native HttpGet
getgenv().SECURED_META = true          -- false disables the metamethod leak check
getgenv().SECURED_INTERVAL = 1         -- seconds between checks

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()
```

(`SECURED_MODR` is accepted as an alias of `SECURED_MODE`.)

### Monitored functions by default

`game.HttpGet`, `game.HttpGetAsync`, `loadstring`, `request`, `http_request`, `syn.request`, `http.request`, `fluxus.request`, `setclipboard`, `toclipboard`, `set_clipboard`, `writefile`, `appendfile`, `hookfunction`, `replaceclosure`.

### API (`Library.Secure`)

| Function | Description |
|---|---|
| `Secure.Start()` / `Secure.Stop()` | Start or stop monitoring. |
| `Secure.Check()` | Run a check immediately. |
| `Secure.Trigger(reason)` | Manually trigger the detection response. |
| `Secure.OnDetect(callback)` | Register `callback(reason)`. Return `false` to cancel the default action. |
| `Secure.Watch(name)` | Add a function path (e.g. `"mycustom.func"`) to the watch list. |
| `Secure.Exclude(name)` | Remove a path from the watch list. |
| `Secure.Pause()` / `Secure.Resume()` | Temporarily suspend checks (nestable). Resume re-baselines. |
| `Secure.Trust(fn, ...)` | Runs `fn` with checks paused. Also `Library:Trust(fn, ...)`. |
| `Secure.Rebaseline()` | Re-record the current function states as the baseline. |

Use `Trust` around code that legitimately modifies monitored functions, so it does not trigger a false positive:

```lua
Library:Trust(function()
    loadstring(game:HttpGet("https://example.com/other-script.lua"))()
end)
```

Note: this is a best-effort deterrent, not a guarantee. Determined users can bypass client-side checks.

---

## Library API

| Member | Description |
|---|---|
| `Library:CreateWindow(cfg)` | Creates a window. |
| `Library:DestroyAll()` | Destroys every window created by the library. |
| `Library:Trust(fn, ...)` | Runs a function with Secure Mode paused. |
| `Library.Windows` | Array of created windows. |
| `Library.Presets` | Table of theme presets. |
| `Library.Secure` | Secure Mode API. |
| `Library.Version` | Library version string. |
| `Library.DefaultTitle` | Default window title. |

---

## Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `RightShift` (configurable) | Show / hide the window |
| `Ctrl + F` | Focus search |
| `Enter` (in search) | Jump to the first result |
| `Escape` (while binding a key) | Clear the keybind |

---

## Full Example

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()

local Window = Library:CreateWindow({
    Title = "Example Hub",
    Version = "v1.0.0",
    Theme = "Graphite",
    ToggleKey = Enum.KeyCode.RightShift,
    NotifyPosition = "BottomRight",
    ToggleButton = { Shape = "Circle", Animation = "pulse", AlwaysVisible = false },
})

Window:CreateTabSection("Features")

local Main = Window:CreateTab("Main", "home")
Main:AddSection("Player")

Main:AddSlider({
    Name = "WalkSpeed", Min = 16, Max = 200, Default = 16, Flag = "ws",
    Callback = function(v)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end,
})

local Combat = Window:CreateTab("Combat", "swords")
local Aim = Combat:AddGroup("Aimbot", { Icon = "crosshair" })
Aim:AddToggle({ Name = "Enabled", Flag = "aim_on", Keywords = "assist lock" })
Aim:AddDropdown({ Name = "Part", Options = { "Head", "Torso" }, Default = "Head", Flag = "aim_part" })
Aim:AddKeybind({ Name = "Hold Key", Default = Enum.KeyCode.E, Flag = "aim_key" })

local Logs = Window:CreateTab("Logs", "terminal")
local console = Logs:AddConsole({ Name = "Output", Height = 160 })
console:Log("Hub loaded", "success")

Main:AddButton({
    Name = "Say hello",
    Style = "accent",
    Callback = function()
        Window:Notify({ Title = "Hello", Content = "Button clicked!", Type = "info" })
        console:Log("Button clicked")
    end,
})

Window:CreateSettingsTab()
```

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Icons show as letters/symbols | The icon module could not be downloaded. Check HTTP access, or use asset ids. |
| Configs are not saved | The executor lacks `writefile`/`readfile`/`isfile`. Use `ExportConfig` / `ImportConfig` with the clipboard. |
| Copy button says clipboard is unsupported | The executor lacks `setclipboard`. |
| UI is too big or small on my screen | Use the **UI Scale** slider in the settings tab or set `Scale` / `AutoScale` in `CreateWindow`. |
| Settings do not restore | Make sure every element has a unique `Flag` and that flag names do not start with `ui_`. |
| Window disappears after minimizing | Click the floating toggle button or press the toggle key (`RightShift` by default). |
| Two windows after re-executing | Set `Singleton = true` (default) or call `Library:DestroyAll()` first. |
| Secure Mode kicks me unexpectedly | Wrap legitimate hook or loader code in `Library:Trust(...)`, or set `SECURED_ACTION = "warn"` while debugging. |

---

## License

Add your license here (for example MIT).
