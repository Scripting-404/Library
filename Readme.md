# Scripting404 UI

A lightweight, responsive, executor-friendly UI library for Roblox. Gray/black default theme, built-in search, config save/load, notifications, dialogs, and an optional **Secured Mode** that protects your script from being dumped via hooks.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Step-by-Step Usage](#step-by-step-usage)
- [Library:CreateWindow(config)](#librarycreatewindowconfig)
- [Tabs and Containers](#tabs-and-containers)
- [Elements](#elements)
- [Reading Values with Flags](#reading-values-with-flags)
- [Notifications and Dialogs](#notifications-and-dialogs)
- [Floating Toggle Button](#floating-toggle-button)
- [Themes](#themes)
- [Config](#config)
- [Window API](#window-api)
- [Icons](#icons)
- [Secured Mode (anti-hook)](#secured-mode-anti-hook)
- [Full Example](#full-example)
- [Notes](#notes)

## Features

- Responsive window that stays inside the screen (drag, resize, maximize, mobile support, UI scale)
- Theme presets: Dark Gray, Graphite, Black, Midnight, Light, plus custom colors and accent
- Global feature search (`Ctrl+F` focuses the search box, `Enter` jumps to the first result)
- Auto save/load config, clipboard export/import
- Notifications (6 positions), dialogs, optional floating toggle button
- Executor compatibility: `cloneref`, `gethui`, `protect_gui`, HttpGet fallbacks, text fallback if the icon library fails to load
- Singleton: re-executing automatically closes the previous UI
- Optional Secured Mode (anti-hook)

## Installation

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()
```

## Quick Start

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()

local Window = Library:CreateWindow({ Version = "v1.0" })
local Tab = Window:CreateTab("Main", "house")

Tab:AddToggle({
    Name = "Auto Farm",
    Flag = "farm",
    Description = "Farms automatically",
    Callback = function(value) print(value) end,
})

Window:CreateSettingsTab()
```

## Step-by-Step Usage

**1. Load the library**

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()
```

**2. Create a window**

```lua
local Window = Library:CreateWindow({
    Title = "My Script",
    Version = "v1.0",
    Theme = "Midnight",
})
```

**3. Add tabs** (optionally with section titles in the sidebar)

```lua
Window:CreateTabSection("General")
local Main = Window:CreateTab("Main", "house")
local Visuals = Window:CreateTab("Visuals", "eye")
```

**4. Add groups and elements**

```lua
local Combat = Main:AddGroup("Combat", { Icon = "swords" })

Combat:AddToggle({ Name = "Kill Aura", Flag = "killaura", Callback = function(on) end })
Combat:AddSlider({ Name = "Range", Flag = "range", Min = 5, Max = 50, Default = 15, Callback = function(v) end })
```

**5. Add the built-in settings tab** (theme, scale, keybind, config manager)

```lua
Window:CreateSettingsTab()
```

**6. Use the values**

```lua
if Window.Flags.killaura then
    print("Range:", Window.Flags.range)
end
```

Press `RightShift` (default) to hide/show the UI.

## Library:CreateWindow(config)

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | string | `"Scripting404"` | Window title |
| `Version` | string | - | Version chip in the header |
| `Icon` | string / number | `"terminal"` | Header icon |
| `Theme` | string / table | `"Dark Gray"` | Preset name or a table of colors |
| `Accent` | Color3 | preset | Accent color |
| `Size` / `MinSize` / `MaxSize` | Vector2 | 620x420 / 380x260 / 1000x700 | Window size and resize limits |
| `Scale` | number | 1 | Initial UI scale |
| `AutoScale` | boolean | true | Scale to the screen automatically |
| `ToggleKey` | Enum.KeyCode | `RightShift` | Show/hide key |
| `ToggleButton` | table | - | Floating toggle button options |
| `Background` | boolean | true | Animated background |
| `BackgroundParticles` | number | 110 (60 on touch) | Number of background particles |
| `NotifyPosition` | string | `"TopLeft"` | `TopLeft`, `TopCenter`, `TopRight`, `BottomLeft`, `BottomCenter`, `BottomRight` |
| `MaxNotifications` | number | 5 | Max notifications on screen |
| `ShowUser` | boolean | true | Show the player profile in the sidebar |
| `AutoSave` | boolean | true | Auto save config on change |
| `AutoLoad` | boolean | true | Load the last config on start |
| `ConfigFolder` | string | `"Scripting404"` | Config folder |
| `ConfigName` | string | last used or `"default"` | Config file name |
| `SaveDelay` | number | 1.2 | Seconds to wait before auto save |
| `Singleton` | boolean | true | Close the previous window when re-executed |
| `OnClose` | function | - | Called when the UI is closed |

## Tabs and Containers

```lua
Window:CreateTabSection("Section title")
local Tab = Window:CreateTab("Name", "icon")
Tab:Select()
Window:SelectTab(Tab)
```

```lua
local Group = Tab:AddGroup("Title", { Icon = "settings", Collapsed = false })
Group:Expand(); Group:Collapse(); Group:Toggle(); Group:SetTitle("New title")

Tab:AddSection("Section")          -- titled divider
Tab:AddDivider("Optional text")    -- thin line
```

Every element below can be added to a `Tab` or a `Group`. Groups cannot be nested.

## Elements

### Button

```lua
local btn = Group:AddButton({
    Name = "Teleport",
    Description = "Teleport to spawn",  -- optional
    Icon = "mouse-pointer-click",       -- optional
    Style = "accent",                   -- "accent" | "danger" | nil
    Callback = function() print("clicked") end,
})
btn:Fire()            -- run the callback from code
btn:SetName("Done!")  -- change the label
```

### Toggle

```lua
local toggle = Group:AddToggle({
    Name = "ESP", Description = "Show players", Flag = "esp", Default = false,
    Callback = function(value) print(value) end,
})
toggle:Set(true)          -- fires Callback
toggle:Set(true, true)    -- silent: does not fire Callback
print(toggle:Get())
```

If `Default = true`, `Callback` runs once when the toggle is created.

### Slider

```lua
local slider = Group:AddSlider({
    Name = "WalkSpeed", Flag = "ws",
    Min = 16, Max = 200, Default = 16, Increment = 1, Suffix = " studs/s",
    Callback = function(value) end,
})
slider:Set(50); print(slider:Get())
```

### Dropdown

```lua
local dd = Group:AddDropdown({
    Name = "Target Part", Flag = "part",
    Options = { "Head", "Torso", "Random" },
    Default = "Head",
    Callback = function(value) end,
})

-- Multi select: Default and the callback value are arrays
Group:AddDropdown({
    Name = "Mobs", Flag = "mobs", Multi = true,
    Options = { "Bandit", "Boss", "Elite" }, Default = { "Bandit" },
    Callback = function(list) print(table.concat(list, ", ")) end,
})

dd:Set("Torso"); print(dd:Get()); dd:Refresh({ "A", "B", "C" })
```

`Search` is enabled automatically when there are more than 8 options (set `Search = true/false` to force it).

### Segmented

```lua
local seg = Group:AddSegmented({
    Name = "Mode", Flag = "mode",
    Options = { "Legit", "Rage" }, Default = "Legit",
    Callback = function(value) end,
})
seg:Set("Rage"); print(seg:Get())
```

### Input and TextArea

```lua
local input = Group:AddInput({
    Name = "Amount", Flag = "amount",
    Default = "10", Placeholder = "Type here...",
    Numeric = true,                               -- only accept numbers
    Callback = function(text, enterPressed) end,
})
input:Set("25"); print(input:Get())

local notes = Group:AddTextArea({
    Name = "Notes", Flag = "notes", Height = 90, Placeholder = "Write something...",
    Callback = function(text, enterPressed) end,
})
```

### Keybind

```lua
local kb = Group:AddKeybind({
    Name = "Fly Key", Flag = "flykey",
    Default = Enum.KeyCode.F,
    Callback = function(key) print("pressed", key.Name) end,  -- when the key is pressed
    Changed = function(key) print("rebound to", key.Name) end, -- when the user picks a new key
})
kb:Set(Enum.KeyCode.G)   -- a string such as "G" also works
```

Press `Esc` while binding to clear the key.

### Color Picker

```lua
local cp = Group:AddColorPicker({
    Name = "ESP Color", Flag = "espcolor",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color) end,
})
cp:Set(Color3.fromRGB(0, 255, 0))   -- hex strings also work
print(cp:Get())
```

### Display elements

```lua
local label = Group:AddLabel("Plain text")
label:Set("Updated")                                              -- change the text
local p = Group:AddParagraph("Title", "Longer description text.")   -- p:Set(title, body)

local tags = Group:AddTag({ Name = "Status", Tags = { "Online", { "Premium", Color3.fromRGB(255, 200, 0) } } })
tags:Add("New", Color3.fromRGB(0, 200, 120)); tags:Clear()

Group:AddInfo({ Title = "Heads up", Content = "Something to know.", Type = "warning" })  -- info | success | warning | error

local bar = Group:AddProgress({ Name = "Loading", Value = 0 })   -- 0-100
bar:Set(70)

local stat = Group:AddStat({ Name = "Kills", Value = 0, Icon = "swords" })
stat:Set(12)

Group:AddImage({ Image = "rbxassetid://123456", Height = 120 })

Group:AddCode({ Title = "Discord", Code = "discord.gg/example" })   -- includes a copy button

local console = Group:AddConsole({ Name = "Log", Height = 120, MaxLines = 200 })
console:Log("Started")
console:Log("Done", "success")   -- info | success | warning | error
console:Clear()
```

### Custom

```lua
Group:AddCustom(100, function(frame, theme)
    -- frame is a 100px-high Frame; theme holds the current colors
end)
```

### Shared options and methods

| Option | Description |
| --- | --- |
| `Flag` | Config key. The value is saved and available in `Window.Flags` |
| `Keywords` | Extra search terms |
| `Tooltip` | Text shown on hover |
| `Locked` | `true` to start locked |
| `Visible` | `false` to start hidden |

Methods available on every element object: `:SetVisible(bool)`, `:SetLocked(bool)`, `:Destroy()`.

## Reading Values with Flags

Any element created with a `Flag` stores its value in `Window.Flags`, saves it to the config, and restores it on the next run.

```lua
print(Window.Flags.farm)          -- toggle state
print(Window.Flags.ws)            -- slider value
print(Window.Flags.flykey)        -- keybind name, e.g. "F"
print(Window.Flags.espcolor)      -- color as hex string

Window.Setters.farm(true)         -- set an element by its flag
```

## Notifications and Dialogs

```lua
Window:Notify({
    Title = "Hello",
    Content = "Script loaded.",
    Type = "success",     -- info | success | warning | error
    Duration = 3,         -- seconds (default 4)
    Icon = "circle-check", -- optional
})

Window:Dialog({
    Title = "Confirm",
    Content = "Are you sure?",
    Icon = "triangle-alert",
    Buttons = {
        { Text = "Cancel" },
        { Text = "Delete", Style = "danger", Callback = function() print("deleted") end },
    },
})
```

`Notify` returns an object with `.Dismiss()`. A dialog without `Buttons` shows a single **OK** button.

## Floating Toggle Button

When the window is minimized, a floating button appears to bring it back. Configure it with `ToggleButton` in `CreateWindow` or later with `Window:SetToggleButton(opts)`.

```lua
Window:SetToggleButton({
    Icon = "terminal",
    Shape = "Circle",       -- "Rounded" | "Circle" | "Square"
    Size = 46,
    Animation = "pulse",    -- "pulse" | "float" | "spin" | "glow" | "breathe"
    AlwaysVisible = false,  -- true: show even when the window is open
})
```

Other options: `Image`, `IconSize`, `IconColor`, `Position` (UDim2), `Transparent`, `Background`, `BackgroundColor`, `BackgroundTransparency`, `Stroke`, `StrokeColor`, `Draggable`, `Custom`, `ClipCustom`.

`Custom` lets you draw your own button content:

```lua
Window:SetToggleButton({
    Shape = "Circle",
    Custom = function(holder, api)
        api.OnState(function(minimized) end)
        api.OnHover(function(hovering) end)
        api.OnClick(function() end)
    end,
})
```

## Themes

Presets: `Dark Gray` (default), `Graphite`, `Black`, `Midnight`, `Light`.

```lua
-- At creation
Library:CreateWindow({ Theme = "Midnight" })
Library:CreateWindow({ Theme = { Accent = Color3.fromRGB(120, 90, 255) } })  -- custom (missing keys use defaults)

-- At runtime
Window:SetThemePreset("Light")
Window:SetTheme({ Accent = Color3.fromRGB(255, 80, 80) })
Window:SetAccent(Color3.fromRGB(0, 170, 255))
```

Theme keys: `Background`, `Panel`, `Element`, `ElementHover`, `Stroke`, `Text`, `SubText`, `Accent`, `Danger`.

## Config

```lua
Window:SaveConfig("name")
Window:LoadConfig("name")
Window:DeleteConfig("name")
print(table.concat(Window:ListConfigs(), ", "))

local json = Window:ExportConfig()   -- JSON string
Window:ImportConfig(json)
Window:SetAutoSave(true)
```

Configs are stored as JSON in `ConfigFolder` (requires `writefile`/`readfile`). Without file support, clipboard export/import still works. The last used config name is remembered and loaded automatically.

## Window API

```lua
Window:Toggle(); Window:Minimize(); Window:Restore(); Window:ToggleMaximize()
Window:SetTitle("Title")
Window:SetToggleKey(Enum.KeyCode.RightControl)
Window:SetBackground(true)
Window:SetScale(1)            -- 0.4 - 2
Window:SetAutoScale(true)
Window:SetSidebar("Auto")     -- "Auto" | "Expanded" | "Collapsed"
Window:SetNotifyPosition("TopRight")
Window:CreateSettingsTab()    -- built-in Settings tab
Window:Destroy()
Library:DestroyAll()
```

Properties: `Window.Flags`, `Window.Setters`, `Window.Tabs`, `Window.Gui`, `Window.Minimized`, `Window.Destroyed`, `Window.ConfigName`.

`CreateSettingsTab(name?, icon?)` adds a ready-made tab with theme preset, accent color, animated background, auto scale, UI scale, sidebar mode, notification position, UI toggle key, and the full config manager (save, load, delete, clipboard export/import).

## Icons

An icon can be a Lucide icon name (`"house"`), an asset string (`"rbxassetid://123"`), or a number (`123`). If the icon library cannot be loaded, a text glyph is shown instead. You can override the icon source by setting `Library.IconsUrl` before the first `CreateWindow`.

## Secured Mode (anti-hook)

Secured Mode watches the functions that are commonly hooked to dump a script (`loadstring`, `request`, `setclipboard`, `writefile`, `hookfunction`, `game.HttpGet`, ...). If one of them changes after the library loaded, the UI is destroyed and the player is kicked and/or sent to another server. It is **off by default**.

Set the options **before** loading the library:

```lua
getgenv().SECURED_MODE = true
getgenv().SECURED_ACTION = "Kick"          -- "Kick" | "ServerHop" | "Both"
getgenv().SECURED_MESSAGE = "Unauthorized hook detected."
getgenv().SECURED_STRICT = false           -- true: also watch __namecall/__index/__newindex

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()
```

| Option | Default | Description |
| --- | --- | --- |
| `SECURED_MODE` | `false` | Enables the protection |
| `SECURED_ACTION` | `"Kick"` | `Kick`, `ServerHop`, or `Both` |
| `SECURED_MESSAGE` | built-in text | Kick message |
| `SECURED_STRICT` | `false` | Also watch metamethods. May cause false positives with other scripts (remote spies, Infinite Yield) |

### Using your own hooks

UI callbacks are trusted automatically. Hooks installed by your own script outside callbacks must be wrapped so they do not trigger the protection:

```lua
Library.Secure:Trust(function()
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        return old(self, ...)
    end)
end)
```

Other API:

```lua
Library.Secure:IsEnabled()
Library.Secure:Rebaseline()                -- accept the current state as safe
Library.Secure.OnViolation = function(reason) end
```

### Limitations

- This is client-side protection. It raises the effort needed to dump your script but cannot stop a determined attacker.
- Detection is relative to the state at load time. A hook installed before the library loads cannot be detected this way.
- Yielding (`task.wait`) inside a trusted callback before installing a hook also makes that hook trusted.

## Full Example

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()

local Window = Library:CreateWindow({
    Title = "My Hub",
    Version = "v1.0",
    Theme = "Midnight",
    ToggleButton = { Shape = "Circle", Animation = "pulse" },
})

Window:CreateTabSection("General")
local Main = Window:CreateTab("Main", "house")

local Farm = Main:AddGroup("Farming", { Icon = "sprout" })
Farm:AddToggle({ Name = "Auto Farm", Flag = "farm", Callback = function(on)
    Window:Notify({ Title = "Auto Farm", Content = on and "Enabled" or "Disabled", Type = on and "success" or "info", Duration = 2 })
end })
Farm:AddSlider({ Name = "Delay", Flag = "delay", Min = 0.1, Max = 5, Default = 1, Increment = 0.1, Suffix = "s" })
Farm:AddDropdown({ Name = "Target", Flag = "target", Options = { "Nearest", "Weakest", "Strongest" }, Default = "Nearest" })
Farm:AddKeybind({ Name = "Panic Key", Flag = "panic", Default = Enum.KeyCode.X, Callback = function()
    Window.Setters.farm(false)
end })

local Info = Main:AddGroup("Info", { Collapsed = true })
Info:AddStat({ Name = "Runs", Value = 0, Icon = "activity" })
Info:AddCode({ Title = "Discord", Code = "discord.gg/example" })

Window:CreateSettingsTab()

task.spawn(function()
    while task.wait(Window.Flags.delay or 1) do
        if Window.Destroyed then break end
        if Window.Flags.farm then
            -- your farming logic here
        end
    end
end)
```

## Notes

- Callbacks run in their own thread (`task.spawn`), so an error in a callback does not break the UI.
- With `Singleton = true` (default), creating a new window destroys the previous one. Set `Singleton = false` to keep several windows.
- Closing the window with the **X** button asks for confirmation first.
- The icon library is fetched over HTTP; without it only the icons are replaced by text glyphs.
