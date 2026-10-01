# Scripting404 UI

A lightweight, responsive, executor-friendly UI library for Roblox. Gray/black default theme, built-in search, config save/load, notifications, and an optional **Secured Mode** that protects your script from being dumped via hooks.

## Features

- Responsive window that always stays inside the screen (drag, resize, maximize, mobile rotation, UI scale)
- Theme presets: Dark Gray, Graphite, Black, Midnight, Light, plus custom accent color
- Global feature search (`Enter` jumps to first result, `Ctrl+F` focuses the search box)
- Auto save/load config, clipboard export/import
- Notifications (6 positions), dialogs, optional floating toggle button
- Executor compatibility: `cloneref`, `gethui`, `protect_gui`, HttpGet fallbacks, text fallback if the icon library fails to load
- Singleton: re-executing automatically closes the previous UI
- Secured Mode (anti-hook) and a simple build-time obfuscator

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

## Icons

An icon can be a Lucide icon name (`"house"`), an asset string (`"rbxassetid://123"`), or a number (`123`). If the icon library cannot be loaded, a text glyph is shown instead. You can override the icon source by setting `Library.IconsUrl` before the first `CreateWindow`.

## Library:CreateWindow(config)

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | string | `"Scripting404"` | Window title |
| `Version` | string | - | Version text in the header |
| `Icon` | string / number | - | Header icon |
| `Theme` | string / table | `"Dark Gray"` | Preset name or a table of colors |
| `Accent` | Color3 | preset | Accent color |
| `Size` / `MinSize` / `MaxSize` | Vector2 | 620x420 / 380x260 / 1000x700 | Window size limits |
| `Scale` | number | 1 | Initial UI scale |
| `AutoScale` | boolean | true | Scale to the screen automatically |
| `ToggleKey` | Enum.KeyCode | `RightShift` | Show/hide key |
| `ToggleButton` | table | - | Floating toggle button options (see below) |
| `Background` | boolean | true | Animated background |
| `BackgroundParticles` | any | - | Background particle option |
| `NotifyPosition` | string | `"TopLeft"` | `TopLeft`, `TopCenter`, `TopRight`, `BottomLeft`, `BottomCenter`, `BottomRight` |
| `MaxNotifications` | number | - | Max notifications on screen |
| `ShowUser` | boolean | - | Show the player in the header |
| `AutoSave` | boolean | true | Auto save config on change |
| `AutoLoad` | boolean | - | Load the last config on start |
| `ConfigFolder` | string | `"Scripting404"` | Config folder |
| `ConfigName` | string | last used or `"default"` | Config file name |
| `SaveDelay` | number | - | Delay before auto save |
| `Singleton` | boolean | true | Close the previous window when re-executed |
| `OnClose` | function | - | Called when the UI is closed |

Floating toggle button (`ToggleButton`): `Icon`, `Image`, `Size`, `Position`, `Shape` (`"Rounded"`, `"Circle"`, `"Square"`), `Transparent`, `Background`, `BackgroundColor`, `BackgroundTransparency`, `Stroke`, `Animation` (`"pulse"`), `Custom`.

## Tabs

```lua
Window:CreateTabSection("Section title")
local Tab = Window:CreateTab("Name", "icon")
Tab:Select()
Window:SelectTab(Tab)
```

## Containers

```lua
local Group = Tab:AddGroup("Title", { Icon = "settings", Collapsed = false })
Group:Expand(); Group:Collapse(); Group:Toggle(); Group:SetTitle("New title")
Tab:AddSection("Section")
Tab:AddDivider("Optional text")
```

Every element below can be added to a `Tab` or a `Group`.

## Elements

| Element | Options | Methods |
| --- | --- | --- |
| `AddLabel(text)` | - | - |
| `AddParagraph(title, body)` | - | - |
| `AddTag(o)` | `Name`, `Tags` | `:Add(text, color)`, `:Clear()` |
| `AddInfo(o)` | `Title`, `Content`, `Type` (`info`, `success`, `warning`, `error`), `Icon` | - |
| `AddProgress(o)` | `Name`, `Value` (0-100) | `:Set(v)`, `:Get()` |
| `AddStat(o)` | `Name`, `Value`, `Icon` | - |
| `AddImage(o)` | `Image`, `Height`, `Name` | - |
| `AddCode(o)` | `Title`, `Code` (copy button included) | - |
| `AddConsole(o)` | `Name`, `Height`, `MaxLines` | `:Log(text, kind)`, `:Clear()` |
| `AddButton(o)` | `Name`, `Description`, `Icon`, `Style` (`accent`, `danger`), `Callback` | `:Fire()`, `:SetName(t)` |
| `AddToggle(o)` | `Name`, `Default`, `Description`, `Callback(value)` | `:Set(v, silent)`, `:Get()` |
| `AddSlider(o)` | `Name`, `Min`, `Max`, `Default`, `Increment`, `Suffix`, `Callback(value)` | `:Set(v, silent)`, `:Get()` |
| `AddDropdown(o)` | `Name`, `Options`, `Default`, `Multi`, `Search`, `Callback(value)` | `:Set(v, silent)`, `:Get()`, `:Refresh(options)` |
| `AddSegmented(o)` | `Name`, `Options`, `Default`, `Callback(value)` | `:Set(v, silent)`, `:Get()` |
| `AddInput(o)` | `Name`, `Default`, `Placeholder`, `Callback(text)` | `:Set(v)`, `:Get()` |
| `AddTextArea(o)` | `Name`, `Default`, `Placeholder`, `Height`, `Callback(text)` | `:Set(v)`, `:Get()` |
| `AddKeybind(o)` | `Name`, `Default` (Enum.KeyCode), `Callback(key)`, `Changed(key)` | `:Set(k, silent)`, `:Get()` |
| `AddColorPicker(o)` | `Name`, `Default` (Color3), `Callback(color)` (hex input included) | `:Set(c, silent)`, `:Get()` |
| `AddCustom(height, builder)` | `builder(frame, theme)` | - |

Options shared by (almost) all elements: `Flag` (config key), `Keywords` (extra search terms), `Tooltip`, `Locked`, `Visible`.
Shared methods: `:SetVisible(bool)`, `:SetLocked(bool)`, `:Destroy()`.

## Window API

```lua
Window:Notify({ Title = "Hello", Content = "Text", Type = "success", Duration = 3 })
Window:Dialog({
    Title = "Confirm",
    Content = "Are you sure?",
    Buttons = {
        { Text = "Cancel" },
        { Text = "Delete", Style = "danger", Callback = function() end },
    },
})

Window:Toggle(); Window:Minimize(); Window:Restore(); Window:ToggleMaximize()
Window:SetTitle("Title"); Window:SetToggleKey(Enum.KeyCode.RightControl)
Window:SetThemePreset("Midnight"); Window:SetTheme({ Accent = Color3.fromRGB(255, 80, 80) }); Window:SetAccent(Color3.new(1, 0, 0))
Window:SetBackground(true); Window:SetScale(1); Window:SetAutoScale(true)
Window:SetSidebar("Auto") -- "Auto" | "Expanded" | "Collapsed"
Window:SetNotifyPosition("TopRight"); Window:SetToggleButton({ Shape = "Circle" })
Window:CreateSettingsTab() -- built-in Settings tab (theme, scale, keybind, config manager)
Window:Destroy(); Library:DestroyAll()
```

`Window.Flags` holds the current value of every element that has a `Flag`.

## Config

```lua
Window:SaveConfig("name"); Window:LoadConfig("name"); Window:DeleteConfig("name")
Window:ListConfigs(); Window:ExportConfig(); Window:ImportConfig(jsonString); Window:SetAutoSave(true)
```

Configs are stored as JSON in the `ConfigFolder` (needs `writefile`/`readfile`). Without file support, clipboard export/import still works.

## Secured Mode (anti-hook)

Secured Mode watches the functions that are commonly hooked to dump a script (`loadstring`, `request`, `setclipboard`, `writefile`, `hookfunction`, `game.HttpGet`, ...). If one of them changes after the library loaded, the UI is destroyed and the player is kicked and/or sent to another server.

Set the options **before** loading the library:

```lua
getgenv().SECURED_MODE = true
getgenv().SECURED_ACTION = "Kick"          -- "Kick" | "ServerHop" | "Both"
getgenv().SECURED_MESSAGE = "Unauthorized hook detected."
getgenv().SECURED_STRICT = false           -- true: also watch __namecall/__index/__newindex

local Library = loadstring(game:HttpGet("RAW_URL"))()
```

| Option | Default | Description |
| --- | --- | --- |
| `SECURED_MODE` | `false` | Enables the protection |
| `SECURED_ACTION` | `"Kick"` | Punishment: `Kick`, `ServerHop`, or `Both` |
| `SECURED_MESSAGE` | built-in text | Kick message |
| `SECURED_STRICT` | `false` | Also watch metamethods. May cause false positives with other scripts (remote spies, Infinite Yield) |

### Using your own hooks

Hooks installed by your own script must not trigger the protection. UI callbacks are trusted automatically. For hooks outside callbacks, wrap them:

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
