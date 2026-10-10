# Scripting404 UI Library

A modern dark-gray UI library for Roblox executors (Luau), with an animated blackhole / code-rain background, responsive scaling, config auto save, global search, a built-in **key system** (full gate or per-feature locks) and an optional **execution tracker**.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Window Options](#window-options)
- [Tabs, Groups and Sections](#tabs-groups-and-sections)
- [Elements](#elements)
- [Flags, Auto Save and Configs](#flags-auto-save-and-configs)
- [Notifications and Dialogs](#notifications-and-dialogs)
- [Themes](#themes)
- [Toggle Button](#toggle-button)
- [Key System](#key-system)
- [Execution Tracker](#execution-tracker)
- [Secure Mode](#secure-mode)
- [Window API](#window-api)
- [Library API](#library-api)
- [Notes](#notes)

---

## Features

- Dark gray theme with 5 presets (`Dark Gray`, `Graphite`, `Black`, `Midnight`, `Light`) and fully custom colors
- Animated blackhole background with code particles, code-rain notifications
- Draggable, resizable, maximizable window with minimize / close and a restore toggle button
- Customizable toggle button (custom icon, asset id, transparent, or a custom animated GUI)
- Responsive: auto scale for different screen sizes and DPI, collapsible sidebar, mobile friendly
- Tabs, tab sections, collapsible groups
- Elements: label, paragraph, tag, info, progress, stat, image, code, console, button, toggle, slider, dropdown (single / multi / search), segmented, input, text area, keybind, color picker, custom
- Global search across all tabs and elements (`Ctrl + F`)
- Config system: auto save / auto load, named configs, export / import via clipboard
- Notifications with positions, types and custom icons
- Confirmation dialogs
- Icons from [Footagesus Icons](https://github.com/Footagesus/Icons) (Lucide by default) or any `rbxassetid`
- Key system: full gate or lock only selected features, customizable link and GUI
- Execution tracker (executor name + unique event key sent to your own API)
- Optional tamper detection (Secure Mode)

---

## Installation

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()
```

---

## Quick Start

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripting-404/Library/refs/heads/main/Ui-library"))()

local Window = Library:CreateWindow({
	Title = "Scripting404",
	Version = "v1.0",
	Theme = "Dark Gray",
	ToggleKey = Enum.KeyCode.RightShift,
})

local Main = Window:CreateTab("Main", "house")
local Group = Main:AddGroup("Player", { Icon = "user" })

Group:AddToggle({
	Name = "Speed Boost",
	Flag = "speed_boost",
	Default = false,
	Callback = function(state)
		print("Speed boost:", state)
	end,
})

Group:AddSlider({
	Name = "Walk Speed",
	Flag = "walk_speed",
	Min = 16, Max = 200, Default = 16, Increment = 1,
	Callback = function(value)
		print("Walk speed:", value)
	end,
})

Group:AddButton({
	Name = "Say Hello",
	Callback = function()
		Window:Notify({ Title = "Hello", Content = "It works!", Type = "success", Duration = 3 })
	end,
})

Window:CreateSettingsTab() -- theme, scale, notifications, configs
```

---

## Window Options

`Library:CreateWindow(cfg)` returns a `Window`.

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `Title` | string | `"Scripting404"` | Window title |
| `Version` | string | nil | Small version chip next to the title |
| `Icon` | string / number | `"terminal"` | Window icon (Lucide name or asset id) |
| `Theme` | string / table | `"Dark Gray"` | Preset name or table of colors |
| `Accent` | Color3 | preset | Accent color override |
| `ToggleKey` | Enum.KeyCode | `RightShift` | Show / hide key |
| `Size` | Vector2 | auto | Initial size |
| `MinSize` / `MaxSize` | Vector2 | auto | Resize limits |
| `Scale` | number | `1` | User scale multiplier |
| `AutoScale` | boolean | `true` | Fit UI size to the screen |
| `Background` | boolean | `true` | Animated blackhole background |
| `BackgroundParticles` | number | 110 (60 on touch) | Particle count |
| `ShowUser` | boolean | `true` | Show the user card in the sidebar |
| `NotifyPosition` | string | `"TopLeft"` | `TopLeft`, `TopCenter`, `TopRight`, `BottomLeft`, `BottomCenter`, `BottomRight` |
| `MaxNotifications` | number | `5` | Max visible notifications |
| `ToggleButton` | table | nil | See [Toggle Button](#toggle-button) |
| `AutoSave` | boolean | `true` | Auto save flags |
| `AutoLoad` | boolean | `true` | Load the last config on start |
| `SaveDelay` | number | `1.2` | Auto save debounce (seconds) |
| `ConfigFolder` | string | `"Scripting404"` | Folder for config files |
| `ConfigName` | string | last used / `"default"` | Config file name |
| `Singleton` | boolean | `true` | Destroy the previous window before creating a new one |
| `OnClose` | function | nil | Called when the window is destroyed |
| `KeySystem` | table | nil | See [Key System](#key-system) |
| `Execution` | table | nil | See [Execution Tracker](#execution-tracker) |

---

## Tabs, Groups and Sections

```lua
Window:CreateTabSection("General")                 -- sidebar section header
local Tab = Window:CreateTab("Main", "house")      -- name, icon, [options]
local Group = Tab:AddGroup("Combat", { Icon = "swords", Collapsed = false })
Tab:AddSection("Section title")                    -- header line inside a page
Tab:AddDivider("or")                               -- divider with optional text
```

- `AddGroup(title, { Icon, Collapsed, KeyLocked })` returns a group that supports every element below.
  Group methods: `Expand()`, `Collapse()`, `Toggle()`, `SetTitle(text)`.
- Tabs and groups both accept all `Add*` element functions.
- `Window:CreateTab(name, icon, { KeyLocked = true })` locks a whole tab (see [Key System](#key-system)).

---

## Elements

Every element accepts these shared options:

| Option | Description |
| --- | --- |
| `Name` | Display name |
| `Description` | Small text under the name (button, toggle, ...) |
| `Flag` | Key used for save / load and `Window.Flags` |
| `Callback` | Function called with the new value |
| `Keywords` | Extra words used by the search |
| `Tooltip` | Hover text |
| `Locked` | Blocks interaction (`obj:SetLocked(bool)` at runtime) |
| `Visible` | `false` hides the element (`obj:SetVisible(bool)`) |
| `KeyLocked` | Requires a valid key (see [Key System](#key-system)) |

Every element object also has `obj.Frame` and `obj:Destroy()`.

### Display elements

```lua
local label = Group:AddLabel("Plain text")
label:Set("New text")

local para = Group:AddParagraph("Title", "Longer body text")
para:Set("New title", "New body")

local tags = Group:AddTag({ Name = "Status", Tags = { "Stable", { "Beta", Color3.fromRGB(225, 175, 80) } } })
tags:Add("New", Color3.fromRGB(110, 190, 140))
tags:Clear()

Group:AddInfo({ Title = "Notice", Content = "Something important", Type = "warning" }) -- info, success, warning, error

local bar = Group:AddProgress({ Name = "Loading", Value = 40, Suffix = "%" })
bar:Set(80)

local stat = Group:AddStat({ Name = "FPS", Value = "60", Icon = "activity" })
stat:Set("144")

Group:AddImage({ Image = "rbxassetid://123456", Height = 120 })

Group:AddCode({ Title = "Example", Code = "print('hello')" }) -- has a copy button

local console = Group:AddConsole({ Name = "Log", Height = 120, MaxLines = 100 })
console:Log("Message")
console:Clear()
```

### Interactive elements

| Element | Options | Methods |
| --- | --- | --- |
| `AddButton` | `Name`, `Description`, `Icon`, `Style` (`"accent"`, `"danger"`), `Callback` | `Fire()`, `SetName(text)` |
| `AddToggle` | `Name`, `Default`, `Flag`, `Callback(state)` | `Set(bool, silent)`, `Get()` |
| `AddSlider` | `Name`, `Min`, `Max`, `Default`, `Increment`, `Suffix`, `Flag`, `Callback(value)` | `Set(v)`, `Get()` |
| `AddDropdown` | `Name`, `Options`, `Default`, `Multi`, `Search`, `Flag`, `Callback(value)` | `Set(v)`, `Get()`, `Refresh(options)` |
| `AddSegmented` | `Name`, `Options`, `Default`, `Flag`, `Callback(value)` | `Set(v)`, `Get()` |
| `AddInput` | `Name`, `Default`, `Placeholder`, `Numeric`, `Flag`, `Callback(text)` | `Set(v)`, `Get()` |
| `AddTextArea` | `Name`, `Default`, `Placeholder`, `Height`, `Flag`, `Callback(text)` | `Set(v)`, `Get()` |
| `AddKeybind` | `Name`, `Default` (Enum.KeyCode), `Flag`, `Changed(key)`, `Callback(key)` | `Set(key, silent)`, `Get()` |
| `AddColorPicker` | `Name`, `Default` (Color3), `Flag`, `Callback(color)` | `Set(color)`, `Get()` |
| `AddCustom(height, builder)` | `builder(frame, theme)` runs in a new thread | returns the frame |

Examples:

```lua
Group:AddDropdown({
	Name = "Targets",
	Options = { "Players", "NPCs", "Items" },
	Default = { "Players" },
	Multi = true, -- Default and callback value are tables when Multi = true
	Callback = function(selected) print(selected) end,
})

Group:AddKeybind({
	Name = "Fly Key",
	Default = Enum.KeyCode.F,
	Callback = function(key) print("pressed", key) end,   -- fired when the key is pressed
	Changed = function(key) print("rebound to", key) end, -- fired when the bind changes
})

Group:AddCustom(80, function(frame, theme)
	-- build any GUI inside `frame`
end)
```

---

## Flags, Auto Save and Configs

Elements with a `Flag` are saved and restored automatically. Current values are available in `Window.Flags`.

```lua
print(Window.Flags.speed_boost)
Window.Setters.speed_boost(true) -- programmatically set a flagged element
```

| Function | Description |
| --- | --- |
| `Window:SaveConfig(name)` | Save current flags |
| `Window:LoadConfig(name)` | Load a config, returns `true` on success |
| `Window:DeleteConfig(name)` | Delete a config |
| `Window:ListConfigs()` | Returns a sorted list of config names |
| `Window:ExportConfig()` | Returns the config as a JSON string |
| `Window:ImportConfig(json)` | Imports a JSON string |
| `Window:SetAutoSave(bool)` | Toggle auto save |

`Window:CreateSettingsTab(name, icon)` adds a ready-made tab with theme, accent, scale, sidebar, notification position, toggle key and all config actions.

---

## Notifications and Dialogs

```lua
Window:Notify({
	Title = "Title",
	Content = "Message",
	Type = "info",     -- info, success, warning, error
	Duration = 4,
	Icon = "bell",     -- Lucide name or asset id (optional)
	Color = Color3.fromRGB(150, 170, 200), -- optional
})

Window:Dialog({
	Title = "Are you sure?",
	Content = "This action cannot be undone.",
	Icon = "triangle-alert",
	Buttons = {
		{ Text = "Confirm", Style = "danger", Callback = function() print("confirmed") end },
		{ Text = "Cancel" },
	},
})
```

---

## Themes

```lua
Window:SetThemePreset("Midnight")
Window:SetAccent(Color3.fromRGB(150, 165, 205))
Window:SetTheme({ Background = Color3.fromRGB(10, 10, 12), Text = Color3.new(1, 1, 1) })
```

Theme keys: `Background`, `Panel`, `Element`, `ElementHover`, `Stroke`, `Text`, `SubText`, `Accent`, `Danger`.
Presets are available in `Library.Presets`.

Other appearance functions: `SetBackground(bool)`, `SetScale(number)`, `SetAutoScale(bool)`, `SetSidebar("Auto" | "Expanded" | "Collapsed")`, `SetNotifyPosition(position)`, `SetTitle(text)`, `SetToggleKey(KeyCode)`.

---

## Toggle Button

The button that restores the UI after minimizing. Configure it with `cfg.ToggleButton` or `Window:SetToggleButton(opts)`.

| Option | Description |
| --- | --- |
| `Icon` / `Image` | Lucide name, asset id or `rbxassetid://` |
| `IconColor`, `IconSize` | Icon tint and size |
| `Transparent` | `true` removes the background (icon only) |
| `Shape` | Button shape (default `"Rounded"`) |
| `Background`, `BackgroundColor`, `BackgroundTransparency` | Background settings |
| `Stroke`, `StrokeColor` | Border settings |
| `Position` | `UDim2` start position |
| `Animation` | Built-in animation name (string) |
| `Custom` | `function(holder, api)` to build a fully custom animated GUI inside the button |
| `ClipCustom` | `true` clips the custom GUI to the button |

```lua
Window:SetToggleButton({
	Icon = "rbxassetid://1234567890",
	Transparent = true,
})
```

---

## Key System

Two modes:

- **`Full`** – a key GUI is shown before the UI loads. The script stops if the key window is closed without a valid key.
- **`Partial`** – the UI loads normally. Only features marked `KeyLocked` are locked. Clicking a locked feature opens the key popup. After a valid key, everything unlocks instantly.

### Configure

Call `Library:SetKeySystem(options)` before `CreateWindow`, or pass the same table as `cfg.KeySystem`.

```lua
Library:SetKeySystem({
	Mode = "Partial",

	-- Key source (pick one)
	Provider = "Panda",
	ServiceId = "scripting404",
	-- Keys = { "KEY-123", "KEY-456" },
	-- Validate = function(key) return key == "my-secret-key" end,

	GetKeyLink = "https://example.com/getkey", -- string or function

	Title = "Scripting404 Auth",
	Subtitle = "secure access terminal",
	Theme = "Dark Gray",
})
```

### Options

| Option | Default | Description |
| --- | --- | --- |
| `Enabled` | `true` after `SetKeySystem` | Turn the key system on / off |
| `Mode` | `"Partial"` | `"Full"` or `"Partial"` |
| `Provider` | nil | `"Panda"` uses `ServiceId` with the Panda auth library |
| `ServiceId` | nil | Panda service id (sets `Provider = "Panda"` automatically) |
| `PandaUrl` | official lib URL | Override the Panda library URL |
| `Keys` | nil | Static list of valid keys |
| `Validate` | nil | `function(key)` returning `true` / `false` or `{ success = bool, isPremium = bool }` |
| `GetKeyLink` | nil | String or function returning the key URL (copied to clipboard) |
| `SaveKey` | `true` | Save the key to `KeyFile` |
| `AutoLogin` | `true` | Validate the saved key on start (also reads `getgenv().Scripting404_Key`) |
| `KeyFile` | `"Scripting404_key.txt"` | Saved key file name |
| `Title`, `Subtitle`, `Footer` | defaults | Header and footer texts |
| `Icon` | `"shield-check"` | Header icon (Lucide name or asset id) |
| `Placeholder` | `"enter your key..."` | Input placeholder |
| `GetKeyText`, `VerifyText` | `"GET KEY"`, `"VERIFY"` | Button labels |
| `IdleText`, `EmptyText`, `FailText`, `SuccessText`, `NoLinkText`, `LinkCopiedText`, `UnavailableText` | defaults | Status messages |
| `LockedText` | `"[ locked ] {feature} requires a key"` | Status shown when opened from a locked feature |
| `UnlockedText` | `"Key accepted. All features unlocked."` | Notification after a valid key |
| `Phrases` | defaults | Typing greeting lines, `{name}` = player name |
| `Size` | `Vector2.new(420, 250)` | Key window size |
| `Theme` | window theme | Preset name or table (`Background`, `Panel`, `Element`, `ElementHover`, `Stroke`, `Text`, `SubText`, `Accent`, `Success`, `Danger`) |
| `Rain`, `Animations`, `Greeting`, `Draggable` | `true` | Toggle visual effects and dragging |
| `OnSuccess` | nil | `function(result)` after a valid key |
| `OnDeny` | nil | Called in `Full` mode when the window is closed without a key |
| `OnGetKey` | nil | `function(url)` when GET KEY is pressed |

### Lock only some features

```lua
-- single element
Group:AddToggle({ Name = "Locked Toggle", KeyLocked = true, Callback = function(v) end })
Group:AddButton({ Name = "Locked Button", KeyLocked = true, Callback = function() end })

-- whole group
local VIP = Tab:AddGroup("VIP", { Icon = "lock", KeyLocked = true })

-- whole tab
local VipTab = Window:CreateTab("VIP", "crown", { KeyLocked = true })
```

- Callbacks of locked elements never run while locked (including values loaded from a saved config). The latest value is applied automatically once the key is accepted.
- Locked elements show a dim overlay with a lock icon; clicking opens the key popup.

### Custom code

```lua
Window:RequireKey("Feature name", function()
	-- runs immediately if the key is valid, otherwise opens the popup and runs after success
end)

Window:LockWithKey(someFrame, 6, "Feature name") -- adds the lock overlay to any custom frame
Window:KeyPrompt("Feature name")                 -- open the popup manually
Window:IsKeyValid()
```

### Full gate without a window

```lua
if Library:KeyGate() then
	-- key is valid
end
```

---

## Execution Tracker

Sends an anonymous execution event (random event key + executor name) to your own endpoint once per execution, when the first window is created.

```lua
Library.Execution.ApiKey = "YOUR_API_KEY"
-- Library.Execution.ApiUrl  = "https://your-endpoint/api/execution"
-- Library.Execution.Enabled = false
```

Or per window:

```lua
Library:CreateWindow({
	Title = "Scripting404",
	Execution = { ApiKey = "YOUR_API_KEY" },
})
```

Request format:

```
POST <ApiUrl>
Content-Type: application/json
x-api-key: <ApiKey>

{ "eventKey": "<random GUID>", "executorName": "<detected executor>" }
```

Nothing is sent while `ApiKey` is empty or still the placeholder `"Api key"`.
`Library:GetExecutor()` returns the detected executor name.

---

## Secure Mode

Optional tamper detection that watches common executor functions (`loadstring`, `request`, `writefile`, `hookfunction`, ...) and the game metatable. Enable it with a global **before** loading the library:

```lua
getgenv().SECURED_MODE = true
getgenv().SECURED_ACTION = "kick"      -- "kick" | "warn" | "serverhop"
getgenv().SECURED_MESSAGE = "Security: script tampering detected."
getgenv().SECURED_INTERVAL = 1         -- check interval (seconds)
getgenv().SECURED_STRICT = false       -- stricter native checks
getgenv().SECURED_META = true          -- set false to skip metamethod checks
```

API: `Library.Secure.Start()`, `Stop()`, `Check()`, `Pause()`, `Resume()`, `Trust(fn, ...)`, `OnDetect(callback)`, `Watch(name)`, `Exclude(name)`.
Use `Library:Trust(fn)` for code that intentionally hooks or replaces watched functions.

---

## Window API

| Function | Description |
| --- | --- |
| `Window:CreateTab(name, icon, opts)` | Create a tab |
| `Window:CreateTabSection(text)` | Sidebar section header |
| `Window:CreateSettingsTab(name, icon)` | Prebuilt settings tab |
| `Window:SelectTab(tab)` / `tab:Select()` | Switch tab |
| `Window:Notify(opts)` | Show a notification |
| `Window:Dialog(opts)` | Show a confirmation dialog |
| `Window:Toggle()` / `Minimize()` / `Restore()` / `ToggleMaximize()` | Visibility and size |
| `Window:SetToggleButton(opts)` | Rebuild the toggle button |
| `Window:SetTitle(text)` | Change title |
| `Window:SetToggleKey(key)` | Change show / hide key |
| `Window:SetTheme(table)` / `SetThemePreset(name)` / `SetAccent(color)` | Theme control |
| `Window:SetBackground(bool)` / `SetScale(n)` / `SetAutoScale(bool)` / `SetSidebar(mode)` / `SetNotifyPosition(pos)` | Appearance |
| `Window:SetAutoSave(bool)` | Auto save |
| `Window:SaveConfig` / `LoadConfig` / `DeleteConfig` / `ListConfigs` / `ExportConfig` / `ImportConfig` | Configs |
| `Window:KeyPrompt` / `RequireKey` / `IsKeyValid` / `LockWithKey` | Key system helpers |
| `Window:Destroy()` | Close and clean up |

Fields: `Window.Flags`, `Window.Setters`, `Window.Tabs`, `Window.Main`, `Window.Gui`, `Window.Compact`.

---

## Library API

| Function | Description |
| --- | --- |
| `Library:CreateWindow(cfg)` | Create a window |
| `Library:DestroyAll()` | Destroy every window |
| `Library:SetKeySystem(options)` | Configure the key system |
| `Library:KeyGate(theme)` | Yielding key gate, returns `true` / `false` |
| `Library:IsKeyValid()` | `true` when the key is valid or the key system is off |
| `Library:ValidateKey(key)` | Returns `ok, result` |
| `Library:GetKeyLink()` | Returns the key URL |
| `Library:OnKeyValid(callback)` | Run a function when the key becomes valid |
| `Library:SendExecution()` | Send the execution event manually (once) |
| `Library:GetExecutor()` | Detected executor name |
| `Library:Trust(fn, ...)` | Run code while Secure Mode is paused |
| `Library.Presets`, `Library.Windows`, `Library.Version`, `Library.KeySystem`, `Library.Key`, `Library.Execution`, `Library.Secure` | Data tables |

---

## Notes

- The key system and locked features run on the client. Keep sensitive logic server-side if you need real protection.
- File features (configs, saved key) need an executor with `writefile`, `readfile` and `isfile`. Without them the UI still works, only saving is disabled.
- The UI parents to `gethui()` when available, otherwise `CoreGui` / `PlayerGui`.
- Icons require the Footagesus Icons library to load; missing icons fall back to a text glyph.

## Credits

- Icons: [Footagesus Icons](https://github.com/Footagesus/Icons)
