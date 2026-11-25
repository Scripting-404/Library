local __modules = {}
local __cache = {}

local function import(path)
	local cached = __cache[path]
	if cached ~= nil then
		return cached
	end
	local loader = __modules[path]
	if not loader then
		error("module not found: " .. tostring(path))
	end
	local value = loader()
	__cache[path] = value
	return value
end

__modules["utilities/http"] = function()
	local Http = {}

	function Http.request()
		return request
			or http_request
			or (syn and syn.request)
			or (http and http.request)
			or (fluxus and fluxus.request)
	end

	function Http.get(url, retries)
		local lastErr = "request failed"
		for attempt = 0, retries or 0 do
			if attempt > 0 then
				task.wait(0.4 * attempt)
			end

			local req = Http.request()
			if req then
				local ok, res = pcall(req, { Url = url, Method = "GET" })
				if ok and type(res) == "table" then
					if res.StatusCode == 200 and type(res.Body) == "string" and res.Body ~= "" then
						return res.Body
					end
					lastErr = "HTTP " .. tostring(res.StatusCode)
				elseif not ok then
					lastErr = tostring(res)
				end
			end

			local ok, body = pcall(function()
				return game:HttpGet(url)
			end)
			if ok and type(body) == "string" and body ~= "" then
				return body
			end
			if not ok then
				lastErr = tostring(body)
			end
		end
		return nil, lastErr
	end

	return Http
end

__modules["images/images"] = function()
	local Images = {
		FONT = "rbxassetid://12187365364",
		KEY = "rbxassetid://96510194465420",
		SUBMIT = "rbxassetid://113692007244654",
		LINK = "rbxassetid://114238209622913",
		DISCORD = "rbxassetid://127255077587058",
		GLOW = "rbxassetid://8992230677",
		LOGO = "rbxassetid://106783148545356",
		CLOSE_ICON = "rbxassetid://110786993356448",
		MOON_ICON = "rbxassetid://83380517901735",
		SHADOW = "rbxassetid://6014261993",
		GAME_PLACEHOLDER = "rbxassetid://74584987850498",
		KEYLESS = "rbxassetid://130551565616516",
	}

	return Images
end

__modules["variables"] = function()
	return {
		Title = "Scripting 404",
		Description = "Violence District",
		Logo = "rbxassetid://106783148545356",
		Theme = "Dark",
		Folder = "Scripting404",
		getkey = true,
		Intro = "true",
		startintro_size = 80,
		squareintro_time = 1.2,
		squarecontorn = "true",
		Changelogocolor = true,
		Changeiconscolor = true,
		ChangeTheme = "false",
		discord_link = "",
		website_link = "",
		Discord = "false",
		Website = "false",
		Informations = "true",
		NotifStyle = "1",
		TabsStyle = "1",
	}
end

__modules["utilities/lucide"] = function()

	local Http = import("utilities/http")

	local Lucide = {}

	local PACK_URL = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"
	local CACHE_FOLDER = "Scripting404-KSY"
	local CACHE_FILE = CACHE_FOLDER .. "/lucide_pack.lua"
	local PREFIX = "lucide:"

	local pack = nil
	local failed = false
	local loading = false
	local preloaded = {}
	local warned = {}

	local function readCache()
		if not (isfile and readfile) then
			return nil
		end
		local ok, body = pcall(function()
			if isfile(CACHE_FILE) then
				return readfile(CACHE_FILE)
			end
		end)
		if ok and type(body) == "string" and body ~= "" then
			return body
		end
		return nil
	end

	local function writeCache(body)
		if not writefile then
			return
		end
		pcall(function()
			if isfolder and makefolder and not isfolder(CACHE_FOLDER) then
				makefolder(CACHE_FOLDER)
			end
			writefile(CACHE_FILE, body)
		end)
	end

	local function parsePack(body)
		local chunk, err = loadstring(body)
		if not chunk then
			error(err)
		end
		return chunk()
	end

	local function loadPack()
		if pack or failed then
			return pack
		end
		if loading then
			while loading do
				task.wait()
			end
			return pack
		end

		loading = true
		local ok, result = pcall(function()
			if not loadstring then
				error("loadstring is not available")
			end

			local cached = readCache()
			if cached then
				local okParse, parsed = pcall(parsePack, cached)
				if okParse and type(parsed) == "table" then
					return parsed
				end
			end

			local body, err = Http.get(PACK_URL, 1)
			if not body then
				error("could not download the icon pack: " .. tostring(err))
			end
			local parsed = parsePack(body)
			if type(parsed) == "table" then
				writeCache(body)
			end
			return parsed
		end)
		loading = false

		if ok and type(result) == "table" then
			pack = result
		else
			failed = true
			warn("[Scripting 404] Lucide icons unavailable: " .. tostring(result))
		end
		return pack
	end

	local function toAsset(value)
		if type(value) == "number" then
			return "rbxassetid://" .. tostring(math.floor(value))
		end
		if type(value) == "string" and value:match("^%d+$") then
			return "rbxassetid://" .. value
		end
		return value
	end

	function Lucide.isName(value)
		if type(value) ~= "string" or value == "" then
			return false
		end
		if value:match("^%d+$") then
			return false
		end
		if value:match("^rbx%a*://") or value:match("^https?://") then
			return false
		end
		return true
	end

	local function stripPrefix(name)
		if name:sub(1, #PREFIX):lower() == PREFIX then
			return name:sub(#PREFIX + 1)
		end
		return name
	end

	local function preload(sheet)
		if preloaded[sheet] then
			return
		end
		preloaded[sheet] = true
		task.spawn(function()
			pcall(function()
				game:GetService("ContentProvider"):PreloadAsync({ sheet })
			end)
		end)
	end

	function Lucide.resolve(value)
		if not Lucide.isName(value) then
			return nil
		end

		local name = stripPrefix(value):lower():gsub("_", "-")
		local loaded = loadPack()
		if not loaded then
			return nil
		end

		local icons = loaded.Icons or loaded
		local entry = type(icons) == "table" and icons[name] or nil
		if type(entry) ~= "table" then
			if not warned[name] then
				warned[name] = true
				warn('[Scripting 404] unknown Lucide icon "' .. tostring(value) .. '"')
			end
			return nil
		end

		local sheet = entry.Image
		if type(loaded.Spritesheets) == "table" and loaded.Spritesheets[tostring(entry.Image)] ~= nil then
			sheet = loaded.Spritesheets[tostring(entry.Image)]
		end
		sheet = toAsset(sheet)
		if type(sheet) ~= "string" then
			return nil
		end

		preload(sheet)
		return {
			Image = sheet,
			RectSize = entry.ImageRectSize or Vector2.new(0, 0),
			RectOffset = entry.ImageRectPosition or entry.ImageRectOffset or Vector2.new(0, 0),
		}
	end

	function Lucide.apply(label, value)
		local sprite = Lucide.resolve(value)
		if sprite then
			label.Image = sprite.Image
			label.ImageRectSize = sprite.RectSize
			label.ImageRectOffset = sprite.RectOffset
			return true
		end

		label.ImageRectSize = Vector2.new(0, 0)
		label.ImageRectOffset = Vector2.new(0, 0)
		if Lucide.isName(value) then
			label.Image = ""
			return false
		end
		label.Image = value or ""
		return value ~= nil
	end

	return Lucide
end

__modules["utilities/pasteblox"] = function()
	local Players = game:GetService("Players")
	local HttpService = game:GetService("HttpService")
	local Http = import("utilities/http")

	local ORIGIN = "https://pasteblox.com"
	local SLUG = "35p5bhgqp5"
	local LIST_URL = ORIGIN .. "/raw/get_404/list"

	local MESSAGES = {
		invalid_key = "That key doesn't exist. Check it or get a new one.",
		expired = "This key has expired. Get a new one.",
		revoked = "This key was revoked by the owner.",
		wrong_device = "This key is locked to another device. Ask the owner to reset it.",
		blacklisted = "You're blacklisted from this script.",
		disabled = "The key system for this script is off right now.",
	}

	local STATUS = {
		{ icon = "\240\159\159\162", text = "Active", role = "success" },
		{ icon = "\240\159\159\161", text = "Needs updating", role = "warn" },
		{ icon = "\240\159\148\180", text = "Doesn't work", role = "error" },
	}

	local UNREACHABLE = "Couldn't reach pasteblox. Try again."
	local UNKNOWN = "Something went wrong. Try again."
	local IS_LINK = "That's the link. Open it in your browser, then paste the key here."

	local function encode(value)
		local text = tostring(value or "")
		local ok, result = pcall(function()
			return HttpService:UrlEncode(text)
		end)
		if ok and type(result) == "string" then
			return result
		end
		return (text:gsub("[^%w%-_%.~]", function(c)
			return string.format("%%%02X", string.byte(c))
		end))
	end

	local function trim(value)
		return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
	end

	local function fetch(url)
		local ok, body = pcall(function()
			return game:HttpGet(url)
		end)
		if ok and type(body) == "string" then
			return body
		end
		local req = Http.request()
		if req then
			local okReq, res = pcall(req, { Url = url, Method = "GET" })
			if okReq and type(res) == "table" and type(res.Body) == "string" then
				return res.Body
			end
		end
		return nil
	end

	local function decode(body)
		if type(body) ~= "string" then
			return nil
		end
		local ok, result = pcall(function()
			return HttpService:JSONDecode(body)
		end)
		if ok and type(result) == "table" then
			return result
		end
		local cleaned = body:gsub(",%s*([%]}])", "%1")
		ok, result = pcall(function()
			return HttpService:JSONDecode(cleaned)
		end)
		if ok and type(result) == "table" then
			return result
		end
		return nil
	end

	local function getHwid()
		if gethwid then
			local ok, value = pcall(gethwid)
			if ok and type(value) == "string" and value ~= "" then
				return value
			end
		end
		local ok, value = pcall(function()
			return game:GetService("RbxAnalyticsService"):GetClientId()
		end)
		if ok and type(value) == "string" and value ~= "" then
			return value
		end
		return tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
	end

	local function getExecutor()
		local getter = identifyexecutor or getexecutorname
		if type(getter) ~= "function" then
			return ""
		end
		local ok, name, version = pcall(getter)
		if not ok or name == nil then
			return ""
		end
		if version == nil then
			return tostring(name)
		end
		return tostring(name) .. " " .. tostring(version)
	end

	local function timeLeft(data)
		if data.kind == "lifetime" or type(data.expiresAt) ~= "string" then
			return "lifetime key"
		end
		local ok, stamp = pcall(function()
			return DateTime.fromIsoDate(data.expiresAt).UnixTimestamp
		end)
		if not ok or type(stamp) ~= "number" then
			return "expires " .. data.expiresAt:sub(1, 10)
		end
		local left = stamp - os.time()
		if left < 3600 then
			return math.max(1, math.floor(left / 60)) .. "m left"
		end
		if left < 172800 then
			return math.floor(left / 3600) .. "h left"
		end
		return math.floor(left / 86400) .. "d left"
	end

	local Pasteblox = {}
	Pasteblox.__index = Pasteblox

	function Pasteblox.new(config)
		config = config or {}
		local self = setmetatable({}, Pasteblox)
		self.origin = tostring(config.Origin or ORIGIN)
		self.slug = tostring(config.Slug or SLUG)
		self.hwid = getHwid()
		self.api = self.origin .. "/api/ks/" .. encode(self.slug)
		return self
	end

	function Pasteblox:GetKeyLink()
		return self.origin .. "/k/" .. encode(self.slug) .. "?h=" .. encode(self.hwid)
	end

	function Pasteblox:CheckKey(key)
		key = trim(key):gsub("%s+", "")
		if key == "" then
			return false, "Paste your key in the box first."
		end
		if key == self:GetKeyLink():gsub("%s+", "") or key:find("pasteblox.com", 1, true) then
			return false, IS_LINK
		end

		local player = Players.LocalPlayer
		local url = self.api
			.. "/redeem?key=" .. encode(key)
			.. "&hwid=" .. encode(self.hwid)
			.. "&uid=" .. encode(player and player.UserId or 0)
			.. "&name=" .. encode(player and player.Name or "")
			.. "&exec=" .. encode(getExecutor())

		local data = decode(fetch(url))
		if not data then
			return false, UNREACHABLE
		end

		if data.ok == true and type(data.token) == "string" then
			return true, nil, data.token, timeLeft(data)
		end

		local known = MESSAGES[data.code]
		if known then
			return false, known
		end
		if type(data.message) == "string" and data.message ~= "" then
			return false, data.message
		end
		return false, UNKNOWN
	end

	function Pasteblox:Run(token)
		local body = fetch(self.api .. "/script?t=" .. encode(token))
		if not body or body == "" then
			return false, "Couldn't reach pasteblox to load the script. Try again."
		end
		local compile = loadstring or load
		if not compile then
			return false, "loadstring is not available."
		end
		local fn, err = compile(body)
		if not fn then
			return false, tostring(err)
		end
		task.spawn(function()
			local ok, result = pcall(fn)
			if not ok then
				warn("[Scripting 404] " .. tostring(result))
			end
		end)
		return true
	end

	function Pasteblox.fetchGames()
		local body = fetch(LIST_URL)
		local games = {}
		if type(body) ~= "string" then
			return games
		end

		local list = body:match("%[(.*)%]") or body
		for block in list:gmatch("%b{}") do
			local placeId = tonumber(block:match('"[Pp]lace[Ii][Dd]"%s*:%s*"?(%d+)'))
			if placeId then
				local status = STATUS[1]
				local best = math.huge
				for _, entry in ipairs(STATUS) do
					local at = block:find(entry.icon, 1, true)
					if at and at < best then
						best = at
						status = entry
					end
				end
				table.insert(games, {
					placeId = placeId,
					name = trim(block:match('"[Nn]ame"%s*:%s*"(.-)"')),
					status = status,
				})
			end
		end

		if #games == 0 then
			for id in list:gmatch("%d%d%d%d%d+") do
				table.insert(games, { placeId = tonumber(id), name = "", status = STATUS[1] })
			end
		end

		return games
	end

	Pasteblox.STATUS = STATUS

	return Pasteblox
end

__modules["components/window/notification"] = function()
local Lighting = game:GetService("Lighting")

local Notification = {}

local STYLE_BY_NAME = { stripe = "1", pill = "2", island = "3", ring = "4", solid = "5" }

function Notification.new(ctx)
	local C = ctx.C
	local make, frame, text, round = ctx.make, ctx.frame, ctx.text, ctx.round
	local tween, prep, fade = ctx.tween, ctx.prep, ctx.fade
	local root, cfg, Images = ctx.root, ctx.cfg, ctx.images
	local FONT, FONT_BOLD = ctx.FONT, ctx.FONT_BOLD
	local markBoldFont = ctx.markBoldFont

	local NOTIF_W = cfg.NOTIF_W
	local NOTIF_TRANSPARENCY = cfg.NOTIF_TRANSPARENCY
	local NOTIF_COLOR = cfg.NOTIF_COLOR
	local NOTIF_BLUR = cfg.NOTIF_BLUR

	local ISLAND_W = 260
	local RING_DOTS = 28
	local MAX_NOTIFS = 4

	local WHITE = Color3.fromRGB(255, 255, 255)
	local DARK = Color3.fromRGB(11, 11, 11)

	local ICONS = {
		key = { Images.KEY, 18 },
		submit = { Images.SUBMIT, 18 },
		link = { Images.LINK, 18 },
		discord = { Images.DISCORD, 18 },
		close = { Images.CLOSE_ICON, 14 },
		moon = { Images.MOON_ICON, 14 },
	}

	local function kindColor(kind)
		if kind == "success" then
			return C.success
		elseif kind == "warn" then
			return C.warn
		elseif kind == "error" then
			return C.error
		end
		return C.accent
	end

	local function contrastOn(color)
		local luminance = 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
		return luminance > 0.55 and DARK or WHITE
	end

	local function cardHover()
		return NOTIF_COLOR == "bg" and C.card or C.btn2
	end

	local cornerHolder = make("Frame", {
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -16, 1, -8),
		Size = UDim2.new(0, NOTIF_W, 1, -16),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 20,
	}, root)
	make("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
	}, cornerHolder)

	local islandHolder = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 12),
		Size = UDim2.new(0, ISLAND_W, 1, -24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 20,
	}, root)
	make("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
	}, islandHolder)

	local notifCount = 0
	local activeNotifs = {}

	local Blur = { effect = nil, users = 0 }

	function Blur.to(size, time)
		if NOTIF_BLUR <= 0 then
			return
		end
		if not Blur.effect then
			local ok, effect = pcall(function()
				local e = Instance.new("BlurEffect")
				e.Name = "Scripting404Blur"
				e.Size = 0
				e.Parent = Lighting
				return e
			end)
			if not ok then
				return
			end
			Blur.effect = effect
		end
		tween(Blur.effect, time, { Size = size })
	end

	function Blur.acquire()
		Blur.users += 1
		Blur.to(NOTIF_BLUR, 0.35)
	end

	function Blur.release()
		Blur.users = math.max(Blur.users - 1, 0)
		if Blur.users == 0 and Blur.effect then
			Blur.to(0, 0.5)
		end
	end

	root.Destroying:Connect(function()
		if Blur.effect then
			Blur.effect:Destroy()
			Blur.effect = nil
		end
	end)

	local function newWrapper(holder, width, height)
		return make("Frame", {
			LayoutOrder = notifCount,
			Size = UDim2.new(0, width, 0, height + 8),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, holder)
	end

	local function newToast(wrapper, props, radius, strokeColor)
		props.BorderSizePixel = 0
		props.AutoButtonColor = false
		props.ClipsDescendants = true
		props.Text = ""
		local toast = make("TextButton", props, wrapper)
		round(toast, radius, strokeColor)
		local stroke = toast:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			stroke.Transparency = 0.35
		end
		return toast
	end

	local function label(parent, str, x, y, w, h, size, color, bold)
		local l = text(parent, str, x, y, w, h, size, color)
		if bold then
			markBoldFont(l)
		end
		l.TextTruncate = Enum.TextTruncate.AtEnd
		return l
	end

	local function iconImage(parent, spec, color, size)
		return make("ImageLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, size, 0, size),
			BackgroundTransparency = 1,
			Image = spec[1],
			ImageColor3 = color,
		}, parent)
	end

	local function buildStripe(title, message, color)
		local W, H = NOTIF_W, 62
		local wrapper = newWrapper(cornerHolder, W, H)
		local toast = newToast(wrapper, {
			Position = UDim2.new(0, 40, 0, 0),
			Size = UDim2.new(0, W, 0, H),
			BackgroundColor3 = C[NOTIF_COLOR],
			BackgroundTransparency = NOTIF_TRANSPARENCY,
		}, 10, C.stroke)

		round(frame(toast, 8, 10, 3, H - 20, color, 0), 2)
		label(toast, title, 22, 11, W - 36, 18, 13, C.text, true)
		label(toast, message, 22, 30, W - 36, 16, 12, C.muted)

		local trackW = W - 44
		round(frame(toast, 22, H - 9, trackW, 2, color, 0.8), 1)
		local fill = frame(toast, 22, H - 9, trackW, 2, color, 0)
		round(fill, 1)

		return {
			wrapper = wrapper,
			toast = toast,
			startPos = UDim2.new(0, 40, 0, 0),
			restPos = UDim2.new(0, 0, 0, 0),
			baseColor = C[NOTIF_COLOR],
			hoverColor = cardHover(),
			progress = function(fraction)
				tween(
					fill,
					0.06,
					{ Size = UDim2.new(0, math.floor(trackW * fraction), 0, 2) },
					Enum.EasingStyle.Linear
				)
			end,
		}
	end

	local function escapeRich(str)
		return (str:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
	end

	local function buildPill(title, message, color, spec)
		local H = 36
		local wrapper = make("Frame", {
			LayoutOrder = notifCount,
			Size = UDim2.new(0, NOTIF_W, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, cornerHolder)
		make("UIPadding", { PaddingBottom = UDim.new(0, 8) }, wrapper)

		local toast = newToast(wrapper, {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 40, 0, 0),
			Size = UDim2.new(0, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = C[NOTIF_COLOR],
			BackgroundTransparency = NOTIF_TRANSPARENCY,
		}, H / 2, C.stroke)
		make("UISizeConstraint", { MinSize = Vector2.new(0, H) }, toast)
		make("UIPadding", {
			PaddingLeft = UDim.new(0, 6),
			PaddingRight = UDim.new(0, 14),
			PaddingTop = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 6),
		}, toast)
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		}, toast)

		local badge = make("Frame", {
			LayoutOrder = 1,
			Size = UDim2.new(0, 24, 0, 24),
			BackgroundColor3 = color,
			BorderSizePixel = 0,
		}, toast)
		make("UICorner", { CornerRadius = UDim.new(1, 0) }, badge)
		iconImage(badge, spec, contrastOn(color), math.min(spec[2], 14))

		local rich = "<b>" .. escapeRich(title) .. "</b>"
		if message ~= "" then
			rich = rich .. '  <font color="#' .. C.muted:ToHex() .. '">' .. escapeRich(message) .. "</font>"
		end
		local body = make("TextLabel", {
			LayoutOrder = 2,
			Size = UDim2.new(0, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			RichText = true,
			TextWrapped = true,
			Text = rich,
			TextSize = 13,
			TextColor3 = C.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			FontFace = FONT,
		}, toast)
		make("UISizeConstraint", { MaxSize = Vector2.new(NOTIF_W - 52, math.huge) }, body)

		return {
			wrapper = wrapper,
			toast = toast,
			startPos = UDim2.new(1, 40, 0, 0),
			restPos = UDim2.new(1, 0, 0, 0),
			baseColor = C[NOTIF_COLOR],
			hoverColor = cardHover(),
		}
	end

	local function buildIsland(title, message, color, spec)
		local W, H = ISLAND_W, 52
		local border = Color3.fromRGB(42, 42, 48)
		local wrapper = newWrapper(islandHolder, W, H)
		local toast = newToast(wrapper, {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, -70),
			Size = UDim2.new(0, H, 0, H),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.06,
		}, H / 2, border)

		local badge = frame(toast, 10, 10, 32, 32, color, 0)
		make("UICorner", { CornerRadius = UDim.new(1, 0) }, badge)
		iconImage(badge, spec, contrastOn(color), spec[2])

		label(toast, title, 54, 9, W - 70, 16, 13, Color3.fromRGB(244, 244, 245), true)
		label(toast, message, 54, 27, W - 70, 14, 12, Color3.fromRGB(154, 154, 162))

		return {
			wrapper = wrapper,
			toast = toast,
			baseColor = Color3.fromRGB(0, 0, 0),
			hoverColor = Color3.fromRGB(22, 22, 26),
			enter = function(items)
				fade(items, 1, 0.25)
				tween(toast, 0.4, { Position = UDim2.new(0.5, 0, 0, 0) }, Enum.EasingStyle.Quint)
				task.delay(0.12, function()
					tween(toast, 0.5, { Size = UDim2.new(0, W, 0, H) }, Enum.EasingStyle.Quint)
				end)
			end,
			leave = function(items)
				fade(items, 0, 0.25)
				tween(
					toast,
					0.3,
					{ Size = UDim2.new(0, H, 0, H) },
					Enum.EasingStyle.Quint,
					Enum.EasingDirection.In
				)
				task.delay(0.15, function()
					tween(
						toast,
						0.3,
						{ Position = UDim2.new(0.5, 0, 0, -70) },
						Enum.EasingStyle.Quint,
						Enum.EasingDirection.In
					)
				end)
			end,
		}
	end

	local function buildRing(title, message, color, spec)
		local W, H = NOTIF_W, 60
		local wrapper = newWrapper(cornerHolder, W, H)
		local toast = newToast(wrapper, {
			Position = UDim2.new(0, 40, 0, 0),
			Size = UDim2.new(0, W, 0, H),
			BackgroundColor3 = C[NOTIF_COLOR],
			BackgroundTransparency = NOTIF_TRANSPARENCY,
		}, 10, C.stroke)

		local ringBox = frame(toast, 10, 10, 40, 40)
		local dots = {}
		for i = 0, RING_DOTS - 1 do
			local angle = (i / RING_DOTS) * math.pi * 2 - math.pi / 2
			local dot = make("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5 + math.cos(angle) * 0.425, 0, 0.5 + math.sin(angle) * 0.425, 0),
				Size = UDim2.new(0, 3, 0, 3),
				BackgroundColor3 = color,
				BorderSizePixel = 0,
			}, ringBox)
			make("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
			dots[#dots + 1] = dot
		end
		iconImage(ringBox, spec, ctx.tintIcons and color or WHITE, math.min(spec[2], 18))

		label(toast, title, 62, 11, W - 76, 18, 13, C.text, true)
		label(toast, message, 62, 31, W - 76, 16, 12, C.muted)

		local lastLit = RING_DOTS
		return {
			wrapper = wrapper,
			toast = toast,
			startPos = UDim2.new(0, 40, 0, 0),
			restPos = UDim2.new(0, 0, 0, 0),
			baseColor = C[NOTIF_COLOR],
			hoverColor = cardHover(),
			progress = function(fraction)
				local lit = math.ceil(fraction * RING_DOTS)
				if lit >= lastLit then
					return
				end
				for i = lit + 1, lastLit do
					tween(dots[i], 0.15, { BackgroundTransparency = 0.82 })
				end
				lastLit = lit
			end,
		}
	end

	local function buildSolid(title, message, color, spec)
		local W, H = NOTIF_W, 58
		local onColor = contrastOn(color)
		local wrapper = newWrapper(cornerHolder, W, H)
		local toast = newToast(wrapper, {
			Position = UDim2.new(0, 40, 0, 0),
			Size = UDim2.new(0, W, 0, H),
			BackgroundColor3 = color,
			BackgroundTransparency = 0.04,
		}, 10, nil)

		local iconBox = frame(toast, 14, (H - 22) / 2, 22, 22)
		iconImage(iconBox, spec, onColor, math.min(spec[2] + 4, 22))

		label(toast, title, 48, 10, W - 62, 18, 13, onColor, true)
		label(toast, message, 48, 30, W - 62, 16, 12, onColor:Lerp(color, 0.35))

		return {
			wrapper = wrapper,
			toast = toast,
			startPos = UDim2.new(0, 40, 0, 0),
			restPos = UDim2.new(0, 0, 0, 0),
			baseColor = color,
			hoverColor = color:Lerp(WHITE, 0.12),
		}
	end

	local STYLES = {
		["1"] = buildStripe,
		["2"] = buildPill,
		["3"] = buildIsland,
		["4"] = buildRing,
		["5"] = buildSolid,
	}

	local function resolveKey()
		local raw = ctx.getStyle and ctx.getStyle() or "1"
		local key = (tostring(raw):lower():gsub("%s+", ""))
		key = STYLE_BY_NAME[key] or key
		return STYLES[key] and key or "1"
	end

	local function resolveStyle()
		return STYLES[resolveKey()]
	end

	local function notify(title, message, kind, iconKey, duration)
		kind = kind or "info"
		duration = duration or 3.5
		title = tostring(title or "")
		message = tostring(message or "")
		local color = kindColor(kind)
		local spec = ICONS[iconKey] or (kind == "error" and ICONS.close or ICONS.key)

		notifCount += 1
		Blur.acquire()

		local n = resolveStyle()(title, message, color, spec)
		local wrapper, toast = n.wrapper, n.toast

		local items = prep(toast)
		fade(items, 0)

		local handle = {}
		local dismissed = false
		function handle.dismiss()
			if dismissed then
				return
			end
			dismissed = true
			Blur.release()
			local idx = table.find(activeNotifs, handle)
			if idx then
				table.remove(activeNotifs, idx)
			end
			if n.leave then
				n.leave(items)
			else
				fade(items, 0, 0.25)
				tween(toast, 0.3, { Position = n.startPos }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			end
			task.delay(0.28, function()
				local size = wrapper.Size
				local height = wrapper.AbsoluteSize.Y
				wrapper.AutomaticSize = Enum.AutomaticSize.None
				wrapper.Size = UDim2.new(size.X.Scale, size.X.Offset, 0, height)
				tween(wrapper, 0.2, { Size = UDim2.new(size.X.Scale, size.X.Offset, 0, 0) })
				task.delay(0.22, function()
					wrapper:Destroy()
				end)
			end)
		end

		toast.MouseButton1Click:Connect(handle.dismiss)

		if n.enter then
			n.enter(items)
		else
			fade(items, 1, 0.3)
			tween(toast, 0.45, { Position = n.restPos }, Enum.EasingStyle.Quint)
		end

		local hovering, hoverSince = false, 0
		toast.MouseEnter:Connect(function()
			if dismissed then
				return
			end
			hovering = true
			hoverSince = os.clock()
			tween(toast, 0.15, { BackgroundColor3 = n.hoverColor })
		end)
		toast.MouseLeave:Connect(function()
			if dismissed then
				return
			end
			hovering = false
			tween(toast, 0.15, { BackgroundColor3 = n.baseColor })
		end)

		task.spawn(function()
			local remaining = duration
			local started = os.clock()
			local last = started
			while not dismissed do
				task.wait(0.05)
				local now = os.clock()
				if not (hovering and now - hoverSince < 8) then
					remaining -= now - last
				end
				last = now
				if n.progress and now - started > 0.35 then
					n.progress(math.clamp(remaining / duration, 0, 1))
				end
				if remaining <= 0 then
					handle.dismiss()
					break
				end
			end
		end)

		table.insert(activeNotifs, handle)
		while #activeNotifs > MAX_NOTIFS do
			activeNotifs[1].dismiss()
		end

		return handle
	end

	local function dismissAll()
		for i = #activeNotifs, 1, -1 do
			activeNotifs[i].dismiss()
		end
	end

	return {
		notify = notify,
		dismissAll = dismissAll,
		styleKey = resolveKey,
		blur = Blur,
	}
end

return Notification
end

__modules["components/window/pages"] = function()

local Pages = {}

local NAMED_COLORS = {
	red = Color3.fromRGB(229, 57, 53),
	orange = Color3.fromRGB(245, 124, 0),
	yellow = Color3.fromRGB(250, 204, 21),
	green = Color3.fromRGB(34, 160, 80),
	teal = Color3.fromRGB(20, 160, 150),
	cyan = Color3.fromRGB(6, 182, 212),
	blue = Color3.fromRGB(59, 130, 246),
	indigo = Color3.fromRGB(99, 102, 241),
	purple = Color3.fromRGB(147, 51, 234),
	pink = Color3.fromRGB(236, 72, 153),
	grey = Color3.fromRGB(100, 100, 108),
	gray = Color3.fromRGB(100, 100, 108),
	white = Color3.fromRGB(245, 245, 245),
	black = Color3.fromRGB(16, 16, 16),
}

local function parseColor(value)
	if value == nil or value == "" then
		return nil
	end
	if typeof(value) == "Color3" then
		return value
	end
	if type(value) == "string" then
		local named = NAMED_COLORS[value:lower()]
		if named then
			return named
		end
		local hex = value:match("^#?(%x%x%x%x%x%x)$")
		if hex then
			return Color3.fromHex(hex)
		end
	end
	return nil
end

function Pages.new(ctx)
	local C, make, round = ctx.C, ctx.make, ctx.round
	local tween, prep, fade = ctx.tween, ctx.prep, ctx.fade
	local setRole, icon, assetId = ctx.setRole, ctx.icon, ctx.assetId
	local contrastOn, iconRole, logoRole = ctx.contrastOn, ctx.iconRole, ctx.logoRole
	local FONT, FONT_BOLD, Images = ctx.FONT, ctx.FONT_BOLD, ctx.images
	local state, content, canvas = ctx.state, ctx.content, ctx.canvas
	local W, H = ctx.width, ctx.height

	local TOPBAR_H = 38
	local SIDE_W = 124
	local SLIDE_TIME = 0.55
	local Quint = Enum.EasingStyle.Quint

	local SECTION_TEXT_SIZE = 15
	local SECTION_TEXT_TRANSPARENCY = 0.35

	local TAB_SLIDE = 10
	local TAB_IN_TIME = 0.32
	local TAB_STAGGER = 0.045
	local TAB_STAGGER_MAX = 0.4

	local NEXT_ARROW_ROTATION = 90
	local BACK_ARROW_ROTATION = -NEXT_ARROW_ROTATION

	local TABS_BAR_H = 34
	local TAB_H_STYLE2 = 26

	local tintIcons = type(iconRole("muted")) == "string"

	local function arrowIcon(parent, rotation, drop)
		local img = make("ImageLabel", {
			Name = "ArrowIcon",
			Position = UDim2.new(0.5, -8, 0.5, -8 + (drop or 0)),
			Size = UDim2.new(0, 16, 0, 16),
			BackgroundTransparency = 1,
			Image = Images.SUBMIT,
			ImageColor3 = iconRole("muted"),
			Rotation = rotation,
			ZIndex = 6,
		}, parent)
		task.spawn(function()
			pcall(function()
				game:GetService("ContentProvider"):PreloadAsync({ img })
			end)
		end)
		return img
	end

	local function tintArrow(img, color)
		if tintIcons then
			tween(img, 0.15, { ImageColor3 = color })
		end
	end

	local function line(parent, x, y, w, h)
		return make("Frame", {
			Position = UDim2.new(0, x, 0, y),
			Size = UDim2.new(0, w, 0, h),
			BackgroundColor3 = "stroke",
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
		}, parent)
	end

	local page = make("Frame", {
		Name = "Page2",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, H),
		Size = UDim2.new(0, W, 0, H),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
	}, canvas)

	local topbar = make("Frame", {
		Name = "Topbar",
		Size = UDim2.new(0, W, 0, TOPBAR_H),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, page)

	make("ImageLabel", {
		Position = UDim2.new(0, 14, 0, 9),
		Size = UDim2.new(0, 24, 0, 20),
		BackgroundTransparency = 1,
		Image = ctx.logo,
		ImageColor3 = logoRole("accent"),
		ScaleType = Enum.ScaleType.Fit,
	}, topbar)

	local pageTitle = make("TextLabel", {
		Position = UDim2.new(0, 46, 0, 0),
		Size = UDim2.new(0, W - 46 - 84, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = ctx.title,
		TextSize = 14,
		TextColor3 = "text",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = FONT_BOLD,
	}, topbar)
	ctx.markTitleFont(pageTitle)

	local function topButton(rightOffset)
		local btn = make("TextButton", {
			Name = "TopButton",
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -rightOffset, 0, 6),
			Size = UDim2.new(0, 26, 0, 26),
			BackgroundColor3 = "card",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
			ZIndex = 5,
		}, topbar)
		make("UICorner", { CornerRadius = UDim.new(0, 7) }, btn)
		return btn
	end

	local closeBtn = topButton(12)
	local closeIcon = make("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
		BackgroundTransparency = 1,
		Image = Images.CLOSE_ICON,
		ImageColor3 = iconRole("muted"),
		ZIndex = 6,
	}, closeBtn)

	local backBtn = topButton(40)
	local backIcon = arrowIcon(backBtn, BACK_ARROW_ROTATION, 0)

	closeBtn.MouseEnter:Connect(function()
		tween(closeBtn, 0.15, { BackgroundTransparency = 0 })
		if tintIcons then
			tween(closeIcon, 0.15, { ImageColor3 = C.text })
		end
	end)
	closeBtn.MouseLeave:Connect(function()
		tween(closeBtn, 0.15, { BackgroundTransparency = 1 })
		if tintIcons then
			tween(closeIcon, 0.15, { ImageColor3 = C.muted })
		end
	end)
	backBtn.MouseEnter:Connect(function()
		tween(backBtn, 0.15, { BackgroundTransparency = 0 })
		tintArrow(backIcon, C.text)
	end)
	backBtn.MouseLeave:Connect(function()
		tween(backBtn, 0.15, { BackgroundTransparency = 1 })
		tintArrow(backIcon, C.muted)
	end)

	local tabsStyle = "1"
	local function normalizeStyle(value)
		value = tostring(value or "1"):lower()
		if value == "2" or value == "horizontal" or value == "row" then
			return "2"
		end
		return "1"
	end
	if ctx.getTabsStyle then
		tabsStyle = normalizeStyle(ctx.getTabsStyle())
	end

	local topLine = line(page, 14, TOPBAR_H, W - 28, 1)
	local tabsLine = line(page, 14, TOPBAR_H + TABS_BAR_H, W - 28, 1)
	local sideLine = line(page, SIDE_W, TOPBAR_H + 10, 1, H - TOPBAR_H - 20)

	local sidebar = make("ScrollingFrame", {
		Name = "Tabs",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ScrollBarThickness = 0,
	}, page)
	local sideLayout = make("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, sidebar)
	local sidePadding = make("UIPadding", {}, sidebar)

	local holder = make("Frame", {
		Name = "TabContent",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
	}, page)

	sidebar.InputChanged:Connect(function(input)
		if tabsStyle == "2" and input.UserInputType == Enum.UserInputType.MouseWheel then
			local maxX = math.max(0, sidebar.AbsoluteCanvasSize.X - sidebar.AbsoluteWindowSize.X)
			local x = sidebar.CanvasPosition.X - input.Position.Z * 30
			sidebar.CanvasPosition = Vector2.new(math.clamp(x, 0, maxX), 0)
		end
	end)

	local tabs = {}
	local current = nil

	local function applyTabsStyle()
		local row = tabsStyle == "2"

		topLine.Visible = not row
		sideLine.Visible = not row
		tabsLine.Visible = row

		sidebar.CanvasPosition = Vector2.new(0, 0)
		sidebar.AutomaticCanvasSize = Enum.AutomaticSize.None
		sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
		if row then
			sidebar.Position = UDim2.new(0, 0, 0, TOPBAR_H)
			sidebar.Size = UDim2.new(0, W, 0, TABS_BAR_H)
			sidebar.ScrollingDirection = Enum.ScrollingDirection.X
			sidebar.AutomaticCanvasSize = Enum.AutomaticSize.X
			sideLayout.FillDirection = Enum.FillDirection.Horizontal
			sideLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			sidePadding.PaddingTop = UDim.new(0, 0)
			sidePadding.PaddingBottom = UDim.new(0, 0)
			sidePadding.PaddingLeft = UDim.new(0, 12)
			sidePadding.PaddingRight = UDim.new(0, 12)

			holder.Position = UDim2.new(0, 0, 0, TOPBAR_H + TABS_BAR_H + 1)
			holder.Size = UDim2.new(0, W, 0, H - TOPBAR_H - TABS_BAR_H - 1)
		else
			sidebar.Position = UDim2.new(0, 0, 0, TOPBAR_H + 1)
			sidebar.Size = UDim2.new(0, SIDE_W, 0, H - TOPBAR_H - 1)
			sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
			sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
			sideLayout.FillDirection = Enum.FillDirection.Vertical
			sideLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			sidePadding.PaddingTop = UDim.new(0, 10)
			sidePadding.PaddingBottom = UDim.new(0, 10)
			sidePadding.PaddingLeft = UDim.new(0, 10)
			sidePadding.PaddingRight = UDim.new(0, 10)

			holder.Position = UDim2.new(0, SIDE_W + 1, 0, TOPBAR_H + 1)
			holder.Size = UDim2.new(0, W - SIDE_W - 1, 0, H - TOPBAR_H - 1)
		end

		for _, tab in ipairs(tabs) do
			tab.applyStyle()
		end
		if current then
			current.refresh()
		end
	end

	local opened, moving = false, false

	local function open()
		if opened or moving then
			return
		end
		opened, moving = true, true
		if ctx.onOpen then
			ctx.onOpen()
		end
		if current then
			current.refresh()
		end
		page.Visible = true
		tween(page, SLIDE_TIME, { Position = UDim2.new(0.5, 0, 0.5, 0) }, Quint)
		tween(content, SLIDE_TIME, { Position = UDim2.new(0.5, 0, 0.5, -H) }, Quint)
		task.delay(SLIDE_TIME + 0.05, function()
			moving = false
		end)
	end

	local function back()
		if not opened or moving then
			return
		end
		opened, moving = false, true
		tween(page, SLIDE_TIME, { Position = UDim2.new(0.5, 0, 0.5, H) }, Quint)
		tween(content, SLIDE_TIME, { Position = UDim2.new(0.5, 0, 0.5, 0) }, Quint)
		task.delay(SLIDE_TIME + 0.05, function()
			if not opened then
				page.Visible = false
			end
			moving = false
		end)
	end

	local function fadeOut(time)
		if not page.Visible then
			return
		end
		fade(prep(page), 0, time)
		task.delay(time, function()
			page.Visible = false
		end)
	end

	local nextBtn = make("TextButton", {
		Name = "NextPage",
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0, W / 2, 0, H - 2),
		Size = UDim2.new(0, 40, 0, 20),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		Visible = false,
		ZIndex = 5,
	}, content)
	local nextIcon = arrowIcon(nextBtn, NEXT_ARROW_ROTATION, 2)

	nextBtn.MouseEnter:Connect(function()
		tintArrow(nextIcon, C.text)
	end)
	nextBtn.MouseLeave:Connect(function()
		tintArrow(nextIcon, C.muted)
	end)
	nextBtn.MouseButton1Click:Connect(function()
		if not state.ready or state.closing then
			return
		end
		open()
	end)

	backBtn.MouseButton1Click:Connect(function()
		if not state.ready or state.closing then
			return
		end
		back()
	end)
	closeBtn.MouseButton1Click:Connect(function()
		ctx.requestClose()
	end)

	local function styleTab(tab, on)
		tween(tab.btn, 0.15, { BackgroundTransparency = on and 0 or 1 })
		setRole(tab.label, "TextColor3", on and "text" or "muted")
		if tab.iconImage then
			local role = iconRole(on and "accent" or "muted")
			if type(role) == "string" then
				setRole(tab.iconImage, "ImageColor3", role)
			end
		end
		tab.scroll.Visible = on
	end

	local originals = setmetatable({}, { __mode = "k" })

	local function snapshot(child)
		local items = prep(child)
		for _, it in ipairs(items) do
			local saved = originals[it[1]]
			if not saved then
				saved = {}
				originals[it[1]] = saved
			end
			if saved[it[2]] == nil then
				saved[it[2]] = it[3]
			else
				it[3] = saved[it[2]]
			end
		end
		return items
	end

	local function animateIn(tab)
		tab.animId = (tab.animId or 0) + 1
		local id = tab.animId

		local children = {}
		for _, child in ipairs(tab.scroll:GetChildren()) do
			if child:IsA("GuiObject") then
				children[#children + 1] = child
			end
		end
		table.sort(children, function(a, b)
			return a.LayoutOrder < b.LayoutOrder
		end)
		if #children == 0 then
			return
		end

		local lists = {}
		for i, child in ipairs(children) do
			local items = snapshot(child)
			fade(items, 0)
			lists[i] = items
		end

		tab.scroll.Position = UDim2.new(0, 0, 0, TAB_SLIDE)
		tween(tab.scroll, TAB_IN_TIME + 0.08, { Position = UDim2.new(0, 0, 0, 0) }, Quint)

		local step = math.min(TAB_STAGGER, TAB_STAGGER_MAX / #children)
		for i, items in ipairs(lists) do
			task.delay((i - 1) * step, function()
				if tab.animId ~= id then
					return
				end
				fade(items, 1, TAB_IN_TIME)
			end)
		end
	end

	local function selectTab(tab, animate)
		if current == tab then
			return
		end
		if current then
			styleTab(current, false)
		end
		current = tab
		styleTab(tab, true)
		tab.refresh()
		if animate ~= false and (opened or page.Visible) then
			animateIn(tab)
		end
	end

	local function createTab(props)
		if type(props) ~= "table" then
			props = { Title = props }
		end
		local title = props.Title ~= nil and tostring(props.Title) or "Tab"
		local image = assetId(props.Icon)

		local tab = {}

		tab.btn = make("TextButton", {
			Name = "Tab",
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = "card",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
			LayoutOrder = #tabs + 1,
		}, sidebar)
		round(tab.btn, 7)

		tab.inner = make("Frame", {
			Name = "Inner",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, tab.btn)
		tab.pad = make("UIPadding", {}, tab.inner)
		make("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 6),
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, tab.inner)

		if image then
			local iconHolder = icon(tab.inner, 0, 0, "muted", image)
			iconHolder.LayoutOrder = 1
			tab.iconImage = iconHolder:FindFirstChild("iconimage")
		end

		tab.label = make("TextLabel", {
			Size = UDim2.new(1, image and -22 or 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = title,
			TextSize = 12,
			TextColor3 = "muted",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextTruncate = Enum.TextTruncate.AtEnd,
			FontFace = FONT,
			LayoutOrder = 2,
		}, tab.inner)

		tab.applyStyle = function()
			if tabsStyle == "2" then
				tab.btn.Size = UDim2.new(0, 0, 0, TAB_H_STYLE2)
				tab.btn.AutomaticSize = Enum.AutomaticSize.X
				tab.inner.Size = UDim2.new(0, 0, 1, 0)
				tab.inner.AutomaticSize = Enum.AutomaticSize.X
				tab.pad.PaddingLeft = UDim.new(0, 10)
				tab.pad.PaddingRight = UDim.new(0, 12)
				tab.label.Size = UDim2.new(0, 0, 1, 0)
				tab.label.AutomaticSize = Enum.AutomaticSize.X
			else
				tab.btn.AutomaticSize = Enum.AutomaticSize.None
				tab.btn.Size = UDim2.new(1, 0, 0, 30)
				tab.inner.AutomaticSize = Enum.AutomaticSize.None
				tab.inner.Size = UDim2.new(1, 0, 1, 0)
				tab.pad.PaddingLeft = UDim.new(0, 12)
				tab.pad.PaddingRight = UDim.new(0, 8)
				tab.label.AutomaticSize = Enum.AutomaticSize.None
				tab.label.Size = UDim2.new(1, image and -22 or 0, 1, 0)
			end
		end
		tab.applyStyle()

		tab.scroll = make("ScrollingFrame", {
			Name = "TabContent",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ElasticBehavior = Enum.ElasticBehavior.Never,
			VerticalScrollBarInset = Enum.ScrollBarInset.None,
			ScrollBarThickness = 2,
			ScrollBarImageTransparency = 0.45,
			Visible = false,
		}, holder)
		setRole(tab.scroll, "ScrollBarImageColor3", "muted")

		local layout = make("UIListLayout", {
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, tab.scroll)
		make("UIPadding", {
			PaddingTop = UDim.new(0, 12),
			PaddingBottom = UDim.new(0, 12),
			PaddingLeft = UDim.new(0, 12),
			PaddingRight = UDim.new(0, 14),
		}, tab.scroll)

		tab.refresh = function()
			tab.scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 24)
		end
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(tab.refresh)

		tab.btn.MouseEnter:Connect(function()
			if current ~= tab then
				tween(tab.btn, 0.12, { BackgroundTransparency = 0.5 })
			end
		end)
		tab.btn.MouseLeave:Connect(function()
			if current ~= tab then
				tween(tab.btn, 0.12, { BackgroundTransparency = 1 })
			end
		end)
		tab.btn.MouseButton1Click:Connect(function()
			if state.closing then
				return
			end
			selectTab(tab)
		end)

		tabs[#tabs + 1] = tab
		if not nextBtn.Visible then
			nextBtn.Visible = true
			task.defer(function()
				nextIcon.Image = ""
				nextIcon.Image = Images.SUBMIT
			end)
		end
		if not current then
			selectTab(tab, false)
		end

		local order = 0
		local function nextOrder()
			order = order + 1
			return order
		end

		local obj = {}

		function obj:Select()
			selectTab(tab)
			return self
		end

		function obj:Section(p)
			p = type(p) == "table" and p or {}
			local sectionImage = assetId(p.Icon)

			local row = make("Frame", {
				Name = "Section",
				Size = UDim2.new(1, 0, 0, 26),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				LayoutOrder = nextOrder(),
			}, tab.scroll)
			make("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 7),
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}, row)

			if sectionImage then
				local iconHolder = icon(row, 0, 0, "accent", sectionImage)
				iconHolder.LayoutOrder = 1
			end

			local label = make("TextLabel", {
				Size = UDim2.new(1, sectionImage and -23 or 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = p.Title ~= nil and tostring(p.Title) or "Section",
				TextSize = SECTION_TEXT_SIZE,
				TextColor3 = "text",
				TextTransparency = SECTION_TEXT_TRANSPARENCY,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextTruncate = Enum.TextTruncate.AtEnd,
				FontFace = FONT_BOLD,
				LayoutOrder = 2,
			}, row)

			local section = { Frame = row }
			function section:SetTitle(str)
				label.Text = tostring(str)
				return self
			end
			function section:Destroy()
				row:Destroy()
			end
			return section
		end

		function obj:Paragraph(p)
			p = type(p) == "table" and p or {}
			local color = parseColor(p.Color)
			local onColor = color and contrastOn(color) or nil

			local box = make("Frame", {
				Name = "Paragraph",
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = color or "card",
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				LayoutOrder = nextOrder(),
			}, tab.scroll)
			round(box, 8, (not color) and "stroke" or nil)
			make("UIPadding", {
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
			}, box)
			make("UIListLayout", {
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}, box)

			local function paragraphLabel(layoutOrder, size, font, textColor, str, transparency)
				return make("TextLabel", {
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = str,
					TextSize = size,
					TextColor3 = textColor,
					TextTransparency = transparency,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					FontFace = font,
					LayoutOrder = layoutOrder,
					Visible = str ~= "",
				}, box)
			end

			local titleText = p.Title ~= nil and tostring(p.Title) or ""
			local descText = p.Desc ~= nil and tostring(p.Desc) or ""
			local titleLabel = paragraphLabel(1, 13, FONT_BOLD, onColor or "text", titleText, 0)
			local descLabel = paragraphLabel(2, 12, FONT, onColor or "muted", descText, onColor and 0.2 or 0)

			local buttons = type(p.Buttons) == "table" and p.Buttons or {}
			if #buttons > 0 then
				local row = make("Frame", {
					Name = "Buttons",
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = 3,
				}, box)
				make("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					Wraps = true,
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}, row)

				for i, b in ipairs(buttons) do
					if type(b) == "table" then
						local btn = make("TextButton", {
							Name = "Button",
							Size = UDim2.new(0, 0, 0, 26),
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundColor3 = color and onColor or "btn2",
							BackgroundTransparency = color and 0.86 or 0,
							BorderSizePixel = 0,
							AutoButtonColor = false,
							Text = "",
							LayoutOrder = i,
						}, row)
						round(btn, 7, (not color) and "stroke" or nil)
						make("UIPadding", {
							PaddingLeft = UDim.new(0, 9),
							PaddingRight = UDim.new(0, 10),
						}, btn)
						make("UIListLayout", {
							FillDirection = Enum.FillDirection.Horizontal,
							Padding = UDim.new(0, 6),
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
						}, btn)

						local buttonImage = assetId(b.Icon)
						if buttonImage then
							local iconHolder = icon(btn, 0, 0, onColor or "text", buttonImage)
							iconHolder.LayoutOrder = 1
						end
						make("TextLabel", {
							Size = UDim2.new(0, 0, 1, 0),
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Text = b.Title ~= nil and tostring(b.Title) or "Button",
							TextSize = 12,
							TextColor3 = onColor or "text",
							TextXAlignment = Enum.TextXAlignment.Left,
							TextYAlignment = Enum.TextYAlignment.Center,
							FontFace = FONT,
							LayoutOrder = 2,
						}, btn)

						btn.MouseEnter:Connect(function()
							if color then
								tween(btn, 0.12, { BackgroundTransparency = 0.72 })
							else
								tween(btn, 0.12, { BackgroundColor3 = C.btn2Hover })
							end
						end)
						btn.MouseLeave:Connect(function()
							if color then
								tween(btn, 0.12, { BackgroundTransparency = 0.86 })
							else
								tween(btn, 0.12, { BackgroundColor3 = C.btn2 })
							end
						end)
						btn.MouseButton1Click:Connect(function()
							if state.closing or type(b.Callback) ~= "function" then
								return
							end
							task.spawn(function()
								local ok, err = pcall(b.Callback)
								if not ok then
									warn("[Scripting 404] Button callback error: " .. tostring(err))
								end
							end)
						end)
					end
				end
			end

			local paragraph = { Frame = box }
			function paragraph:SetTitle(str)
				titleLabel.Text = tostring(str)
				titleLabel.Visible = titleLabel.Text ~= ""
				return self
			end
			function paragraph:SetDesc(str)
				descLabel.Text = tostring(str)
				descLabel.Visible = descLabel.Text ~= ""
				return self
			end
			function paragraph:Destroy()
				box:Destroy()
			end
			return paragraph
		end

		return obj
	end

	applyTabsStyle()

	if ctx.registerTabsStyle then
		ctx.registerTabsStyle(function()
			if not page.Parent then
				return false
			end
			local style = normalizeStyle(ctx.getTabsStyle and ctx.getTabsStyle())
			if style ~= tabsStyle then
				tabsStyle = style
				applyTabsStyle()
			end
			return true
		end)
	end

	return {
		createTab = createTab,
		open = open,
		back = back,
		fadeOut = fadeOut,
		isOpen = function()
			return opened
		end,
	}
end

return Pages
end

__modules["components/window/ui"] = function()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

local Images = import("images/images")
local Notification = import("components/window/notification")
local Variables = import("variables")
local Pasteblox = import("utilities/pasteblox")
local Pages = import("components/window/pages")
local Lucide = import("utilities/lucide")
local Http = import("utilities/http")

local FONT = Font.new(Images.FONT, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local FONT_BOLD = Font.new(Images.FONT, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local GLOW = Images.GLOW
local CLOSE_ICON = Images.CLOSE_ICON
local MOON_ICON = Images.MOON_ICON

local FINAL_W, FINAL_H = 460, 260

local NOTIF_W, NOTIF_H = 300, 70
local NOTIF_TRANSPARENCY = 0.28
local NOTIF_COLOR = "bg"
local NOTIF_BLUR = 6

local CHECK_TIME = 0
local SAVED_CHECK_TIME = 0

local MAX_FAILED_ATTEMPTS = 5
local LOCKOUT_TIME = 30

local WHITE = Color3.fromRGB(255, 255, 255)
local uiSettings = { tintIcons = true, tintLogo = true }

local function asBool(v, default)
	if v == nil then
		return default
	end
	if type(v) == "string" then
		return v:lower() == "true"
	end
	return v == true
end

local function assetId(v)
	if v == nil or v == "" then
		return nil
	end
	local str = tostring(v)
	if str:match("^%d+$") then
		return "rbxassetid://" .. str
	end
	return str
end

local function iconRole(role)
	return uiSettings.tintIcons and role or WHITE
end
local function logoRole(role)
	return uiSettings.tintLogo and role or WHITE
end

local function mountGui(gui)
	if syn and syn.protect_gui then
		pcall(syn.protect_gui, gui)
	end
	local getters = {
		function()
			return gethui and gethui()
		end,
		function()
			return game:GetService("CoreGui")
		end,
		function()
			return player and player:FindFirstChildOfClass("PlayerGui")
		end,
	}
	for _, get in ipairs(getters) do
		local ok, parent = pcall(get)
		if ok and typeof(parent) == "Instance" then
			local old = parent:FindFirstChild(gui.Name)
			if old and old ~= gui then
				pcall(function()
					old:Destroy()
				end)
			end
			if pcall(function()
				gui.Parent = parent
			end) and gui.Parent == parent then
				return true
			end
		end
	end
	return false
end

local THEME_ORDER = {
	"Carmim",
	"Plant",
	"Plant-Dark",
	"Dark",
	"Light",
	"Violet",
	"Midnight",
	"Amber",
	"Indigo",
	"Amethyst",
}

local THEMES = {
	Amethyst = {
		bg = Color3.fromRGB(20, 16, 20),
		input = Color3.fromRGB(24, 19, 24),
		card = Color3.fromRGB(28, 22, 28),
		stroke = Color3.fromRGB(40, 32, 41),
		btn2 = Color3.fromRGB(42, 36, 43),
		btn2Hover = Color3.fromRGB(54, 47, 55),
		text = Color3.fromRGB(233, 229, 234),
		muted = Color3.fromRGB(125, 115, 126),
		accent = Color3.fromRGB(235, 199, 246),
		warn = Color3.fromRGB(240, 176, 108),
		success = Color3.fromRGB(120, 210, 140),
		error = Color3.fromRGB(240, 120, 120),

		submitBg = Color3.fromRGB(235, 199, 246),
		submitText = Color3.fromRGB(24, 18, 26),

		glowBase = Color3.fromRGB(226, 218, 230),
		glowFrom = Color3.fromRGB(255, 255, 255),
		glowTo = Color3.fromRGB(235, 199, 246),

		confetti = {
			Color3.fromRGB(235, 199, 246),
			Color3.fromRGB(120, 210, 140),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(240, 176, 108),
			Color3.fromRGB(150, 190, 255),
		},
	},

	Carmim = {
		bg = Color3.fromRGB(10, 10, 10),
		input = Color3.fromRGB(16, 14, 14),
		card = Color3.fromRGB(20, 17, 17),
		stroke = Color3.fromRGB(38, 32, 32),
		btn2 = Color3.fromRGB(32, 28, 28),
		btn2Hover = Color3.fromRGB(46, 40, 40),
		text = Color3.fromRGB(240, 236, 236),
		muted = Color3.fromRGB(130, 122, 122),
		accent = Color3.fromRGB(230, 45, 55),
		warn = Color3.fromRGB(240, 176, 108),
		success = Color3.fromRGB(120, 210, 140),
		error = Color3.fromRGB(240, 120, 120),

		submitBg = Color3.fromRGB(139, 17, 27),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(255, 120, 120),
		glowFrom = Color3.fromRGB(255, 90, 90),
		glowTo = Color3.fromRGB(200, 20, 35),

		confetti = {
			Color3.fromRGB(230, 45, 55),
			Color3.fromRGB(255, 120, 120),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(240, 176, 108),
			Color3.fromRGB(150, 20, 30),
		},
	},

	Plant = {
		bg = Color3.fromRGB(28, 94, 56),
		input = Color3.fromRGB(23, 78, 46),
		card = Color3.fromRGB(34, 108, 65),
		stroke = Color3.fromRGB(58, 140, 92),
		btn2 = Color3.fromRGB(44, 122, 74),
		btn2Hover = Color3.fromRGB(56, 140, 88),
		text = Color3.fromRGB(255, 255, 255),
		muted = Color3.fromRGB(188, 226, 202),
		accent = Color3.fromRGB(255, 255, 255),
		warn = Color3.fromRGB(255, 214, 140),
		success = Color3.fromRGB(200, 255, 210),
		error = Color3.fromRGB(255, 150, 150),

		submitBg = Color3.fromRGB(96, 205, 122),
		submitText = Color3.fromRGB(14, 66, 36),

		glowBase = Color3.fromRGB(255, 255, 255),
		glowFrom = Color3.fromRGB(255, 255, 255),
		glowTo = Color3.fromRGB(235, 255, 240),

		confetti = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(150, 235, 170),
			Color3.fromRGB(96, 205, 122),
			Color3.fromRGB(255, 214, 140),
			Color3.fromRGB(210, 255, 220),
		},
	},

	["Plant-Dark"] = {
		bg = Color3.fromRGB(10, 10, 10),
		input = Color3.fromRGB(14, 16, 14),
		card = Color3.fromRGB(18, 22, 19),
		stroke = Color3.fromRGB(34, 42, 36),
		btn2 = Color3.fromRGB(28, 34, 29),
		btn2Hover = Color3.fromRGB(40, 48, 42),
		text = Color3.fromRGB(238, 242, 238),
		muted = Color3.fromRGB(122, 132, 124),
		accent = Color3.fromRGB(70, 214, 110),
		warn = Color3.fromRGB(240, 176, 108),
		success = Color3.fromRGB(120, 220, 150),
		error = Color3.fromRGB(240, 120, 120),

		submitBg = Color3.fromRGB(22, 101, 52),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(110, 255, 150),
		glowFrom = Color3.fromRGB(90, 240, 130),
		glowTo = Color3.fromRGB(30, 170, 70),

		confetti = {
			Color3.fromRGB(70, 214, 110),
			Color3.fromRGB(150, 245, 175),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(240, 176, 108),
			Color3.fromRGB(22, 101, 52),
		},
	},

	Dark = {
		bg = Color3.fromRGB(10, 10, 10),
		input = Color3.fromRGB(18, 18, 18),
		card = Color3.fromRGB(23, 23, 23),
		stroke = Color3.fromRGB(46, 46, 46),
		btn2 = Color3.fromRGB(34, 34, 34),
		btn2Hover = Color3.fromRGB(48, 48, 48),
		text = Color3.fromRGB(255, 255, 255),
		muted = Color3.fromRGB(150, 150, 150),
		accent = Color3.fromRGB(255, 255, 255),
		warn = Color3.fromRGB(240, 176, 108),
		success = Color3.fromRGB(120, 210, 140),
		error = Color3.fromRGB(240, 120, 120),

		submitBg = Color3.fromRGB(66, 66, 66),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(255, 255, 255),
		glowFrom = Color3.fromRGB(255, 255, 255),
		glowTo = Color3.fromRGB(210, 210, 210),

		confetti = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(200, 200, 200),
			Color3.fromRGB(140, 140, 140),
			Color3.fromRGB(240, 176, 108),
			Color3.fromRGB(120, 210, 140),
		},
	},

	Light = {
		bg = Color3.fromRGB(255, 255, 255),
		input = Color3.fromRGB(240, 240, 240),
		card = Color3.fromRGB(245, 245, 245),
		stroke = Color3.fromRGB(216, 216, 216),
		btn2 = Color3.fromRGB(232, 232, 232),
		btn2Hover = Color3.fromRGB(218, 218, 218),
		text = Color3.fromRGB(10, 10, 10),
		muted = Color3.fromRGB(110, 110, 110),
		accent = Color3.fromRGB(10, 10, 10),
		warn = Color3.fromRGB(196, 116, 24),
		success = Color3.fromRGB(28, 150, 72),
		error = Color3.fromRGB(210, 58, 58),

		submitBg = Color3.fromRGB(20, 20, 20),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(30, 30, 30),
		glowFrom = Color3.fromRGB(60, 60, 60),
		glowTo = Color3.fromRGB(0, 0, 0),

		confetti = {
			Color3.fromRGB(10, 10, 10),
			Color3.fromRGB(90, 90, 90),
			Color3.fromRGB(160, 160, 160),
			Color3.fromRGB(230, 150, 50),
			Color3.fromRGB(50, 170, 100),
		},
	},

	Violet = {
		bg = Color3.fromRGB(94, 64, 162),
		input = Color3.fromRGB(78, 52, 140),
		card = Color3.fromRGB(108, 78, 180),
		stroke = Color3.fromRGB(136, 108, 204),
		btn2 = Color3.fromRGB(120, 90, 192),
		btn2Hover = Color3.fromRGB(136, 106, 208),
		text = Color3.fromRGB(255, 255, 255),
		muted = Color3.fromRGB(214, 202, 242),
		accent = Color3.fromRGB(255, 255, 255),
		warn = Color3.fromRGB(255, 214, 140),
		success = Color3.fromRGB(200, 255, 210),
		error = Color3.fromRGB(255, 160, 170),

		submitBg = Color3.fromRGB(58, 32, 112),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(255, 255, 255),
		glowFrom = Color3.fromRGB(255, 255, 255),
		glowTo = Color3.fromRGB(240, 232, 255),

		confetti = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(214, 190, 255),
			Color3.fromRGB(170, 130, 255),
			Color3.fromRGB(255, 214, 140),
			Color3.fromRGB(58, 32, 112),
		},
	},

	Midnight = {
		bg = Color3.fromRGB(26, 44, 104),
		input = Color3.fromRGB(18, 32, 80),
		card = Color3.fromRGB(34, 56, 124),
		stroke = Color3.fromRGB(62, 88, 158),
		btn2 = Color3.fromRGB(44, 70, 142),
		btn2Hover = Color3.fromRGB(58, 86, 164),
		text = Color3.fromRGB(255, 255, 255),
		muted = Color3.fromRGB(190, 204, 240),
		accent = Color3.fromRGB(255, 255, 255),
		warn = Color3.fromRGB(255, 214, 140),
		success = Color3.fromRGB(190, 255, 215),
		error = Color3.fromRGB(255, 150, 160),

		submitBg = Color3.fromRGB(52, 92, 196),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(255, 255, 255),
		glowFrom = Color3.fromRGB(255, 255, 255),
		glowTo = Color3.fromRGB(226, 236, 255),

		confetti = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(170, 200, 255),
			Color3.fromRGB(100, 150, 255),
			Color3.fromRGB(255, 214, 140),
			Color3.fromRGB(52, 92, 196),
		},
	},

	Amber = {
		bg = Color3.fromRGB(160, 84, 16),
		input = Color3.fromRGB(132, 68, 10),
		card = Color3.fromRGB(176, 98, 28),
		stroke = Color3.fromRGB(206, 132, 62),
		btn2 = Color3.fromRGB(186, 108, 38),
		btn2Hover = Color3.fromRGB(200, 122, 52),
		text = Color3.fromRGB(255, 255, 255),
		muted = Color3.fromRGB(255, 228, 196),
		accent = Color3.fromRGB(255, 255, 255),
		warn = Color3.fromRGB(255, 240, 170),
		success = Color3.fromRGB(215, 255, 205),
		error = Color3.fromRGB(110, 18, 18),

		submitBg = Color3.fromRGB(110, 50, 6),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(255, 255, 255),
		glowFrom = Color3.fromRGB(255, 255, 255),
		glowTo = Color3.fromRGB(255, 240, 220),

		confetti = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(255, 220, 160),
			Color3.fromRGB(255, 180, 90),
			Color3.fromRGB(255, 240, 170),
			Color3.fromRGB(110, 50, 6),
		},
	},

	Indigo = {
		bg = Color3.fromRGB(20, 14, 58),
		input = Color3.fromRGB(15, 10, 46),
		card = Color3.fromRGB(28, 20, 76),
		stroke = Color3.fromRGB(50, 40, 112),
		btn2 = Color3.fromRGB(38, 29, 96),
		btn2Hover = Color3.fromRGB(52, 42, 122),
		text = Color3.fromRGB(240, 238, 255),
		muted = Color3.fromRGB(150, 142, 204),
		accent = Color3.fromRGB(150, 132, 255),
		warn = Color3.fromRGB(240, 190, 120),
		success = Color3.fromRGB(120, 220, 160),
		error = Color3.fromRGB(255, 120, 140),

		submitBg = Color3.fromRGB(84, 64, 210),
		submitText = Color3.fromRGB(255, 255, 255),

		glowBase = Color3.fromRGB(160, 140, 255),
		glowFrom = Color3.fromRGB(140, 120, 255),
		glowTo = Color3.fromRGB(90, 70, 230),

		confetti = {
			Color3.fromRGB(150, 132, 255),
			Color3.fromRGB(200, 190, 255),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(240, 190, 120),
			Color3.fromRGB(84, 64, 210),
		},
	},
}

local themeIndex = 1

local C = {}
local function loadTheme(theme)
	for k, v in pairs(theme) do
		C[k] = v
	end
end

local COLOR_PROPS = {
	BackgroundColor3 = true,
	TextColor3 = true,
	ImageColor3 = true,
	Color = true,
	PlaceholderColor3 = true,
}
local bindings = {}
local gradients = {}

local fontBindings = {}
local fontSettings = { ui = nil, title = nil }

local function fontFor(entryFont)
	if entryFont.title and fontSettings.title then
		local t = fontSettings.title
		if entryFont.bold then
			return Font.new(t.Family, Enum.FontWeight.Bold, t.Style)
		end
		return t
	end
	if fontSettings.ui then
		local u = fontSettings.ui
		if entryFont.bold then
			return Font.new(u.Family, Enum.FontWeight.Bold, u.Style)
		end
		return u
	end
	return entryFont.bold and FONT_BOLD or FONT
end

local function applyFontAll()
	for _, entryFont in ipairs(fontBindings) do
		if entryFont.inst.Parent then
			entryFont.inst.FontFace = fontFor(entryFont)
		end
	end
end

local function markTitleFont(inst)
	for _, entryFont in ipairs(fontBindings) do
		if entryFont.inst == inst then
			entryFont.title = true
			inst.FontFace = fontFor(entryFont)
			return
		end
	end
end

local function markBoldFont(inst)
	for _, entryFont in ipairs(fontBindings) do
		if entryFont.inst == inst then
			entryFont.bold = true
			inst.FontFace = fontFor(entryFont)
			return
		end
	end
end

local function resolveFont(input)
	if input == nil then
		return nil
	end
	if typeof(input) == "Font" then
		return input
	end
	if type(input) == "table" then
		return Font.new(input.Family or input.family, input.Weight or Enum.FontWeight.Regular, input.Style or Enum.FontStyle.Normal)
	end
	local name = tostring(input)
	local ok, enumFont = pcall(function()
		return Enum.Font[name]
	end)
	if ok and typeof(enumFont) == "EnumItem" then
		return Font.fromEnum(enumFont)
	end
	local family = name
	if family:match("^%d+$") then
		family = "rbxassetid://" .. family
	end
	return Font.new(family, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
end

local function make(class, props, parent)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		if type(v) == "string" and COLOR_PROPS[k] then
			bindings[#bindings + 1] = { inst, k, v }
			inst[k] = C[v]
		elseif k == "FontFace" and (v == FONT or v == FONT_BOLD) then
			fontBindings[#fontBindings + 1] = { inst = inst, bold = (v == FONT_BOLD), title = false }
			inst[k] = v
		else
			inst[k] = v
		end
	end
	inst.Parent = parent
	return inst
end

local function unbind(inst, prop)
	for i = #bindings, 1, -1 do
		local b = bindings[i]
		if b[1] == inst and b[2] == prop then
			table.remove(bindings, i)
		end
	end
end

local function setRole(inst, prop, role)
	local found = false
	for _, b in ipairs(bindings) do
		if b[1] == inst and b[2] == prop then
			b[3] = role
			found = true
			break
		end
	end
	if not found then
		bindings[#bindings + 1] = { inst, prop, role }
	end
	inst[prop] = C[role]
end

local function frame(parent, x, y, w, h, color, transparency)
	return make("Frame", {
		Position = UDim2.new(0, x, 0, y),
		Size = UDim2.new(0, w, 0, h),
		BackgroundColor3 = color or C.bg,
		BackgroundTransparency = transparency or 1,
		BorderSizePixel = 0,
	}, parent)
end

local function text(parent, str, x, y, w, h, size, color, align)
	return make("TextLabel", {
		Position = UDim2.new(0, x, 0, y),
		Size = UDim2.new(0, w, 0, h),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = str,
		TextSize = size,
		TextColor3 = color,
		TextXAlignment = align or Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		FontFace = FONT,
	}, parent)
end

local function round(parent, radius, strokeColor)
	make("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
	if strokeColor then
		make("UIStroke", {
			Thickness = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			Color = strokeColor,
		}, parent)
	end
end

local function icon(parent, x, y, color, image)
	local holder = frame(parent, x, y, 16, 16)
	make("ImageLabel", {
		Name = "iconglow",
		Size = UDim2.new(2, 0, 2, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = GLOW,
		ImageColor3 = color,
		ImageTransparency = 0.9,
		ZIndex = 0,
	}, holder)
	local img = make("ImageLabel", {
		Name = "iconimage",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ImageColor3 = iconRole(color),
	}, holder)
	Lucide.apply(img, image)
	return holder
end

local function decor(parent, w, h, x, y, transparency, rotation)
	local img = make("ImageLabel", {
		Size = UDim2.new(0, w, 0, h),
		Position = UDim2.new(0, x, 0, y),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = GLOW,
		ImageColor3 = "glowBase",
		ImageTransparency = transparency,
		ScaleType = Enum.ScaleType.Stretch,
	}, parent)
	local grad = make("UIGradient", {
		Rotation = rotation,
		Color = ColorSequence.new(C.glowFrom, C.glowTo),
	}, img)
	gradients[#gradients + 1] = grad
	return img
end

local function centered(parent, w, h)
	return make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, w, 0, h),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, parent)
end

local function tween(inst, time, props, style, dir)
	local t = TweenService:Create(
		inst,
		TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function ring(parent, size, thickness, color, transparency)
	local f = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, size, 0, size),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, parent)
	make("UICorner", { CornerRadius = UDim.new(1, 0) }, f)
	local stroke = make("UIStroke", { Thickness = thickness, Color = color, Transparency = transparency }, f)
	return f, stroke
end

local function comet(stroke)
	make("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.35, 0),
			NumberSequenceKeypoint.new(0.7, 1),
			NumberSequenceKeypoint.new(1, 1),
		}),
	}, stroke)
end

local function prep(container)
	local items = {}
	local function add(inst)
		if inst:IsA("GuiObject") then
			items[#items + 1] = { inst, "BackgroundTransparency", inst.BackgroundTransparency }
			if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
				items[#items + 1] = { inst, "TextTransparency", inst.TextTransparency }
			elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
				items[#items + 1] = { inst, "ImageTransparency", inst.ImageTransparency }
			elseif inst:IsA("ScrollingFrame") then
				items[#items + 1] = { inst, "ScrollBarImageTransparency", inst.ScrollBarImageTransparency }
			end
		elseif inst:IsA("UIStroke") then
			items[#items + 1] = { inst, "Transparency", inst.Transparency }
		end
	end
	add(container)
	for _, d in ipairs(container:GetDescendants()) do
		add(d)
	end
	return items
end

local function fade(items, alpha, time)
	for _, it in ipairs(items) do
		local inst, prop, orig = it[1], it[2], it[3]
		local target = 1 - (1 - orig) * alpha
		if time and time > 0 then
			tween(inst, time, { [prop] = target })
		else
			inst[prop] = target
		end
	end
end

local function tintTo(inst, color)
	if uiSettings.tintIcons then
		tween(inst, 0.15, { ImageColor3 = color })
	end
end

local function applyTheme(name, time)
	local theme = THEMES[name]
	if not theme then
		return
	end

	local oldFrom, oldTo = C.glowFrom, C.glowTo
	loadTheme(theme)

	local style, dir = Enum.EasingStyle.Sine, Enum.EasingDirection.InOut
	for i = #bindings, 1, -1 do
		local b = bindings[i]
		local inst = b[1]
		if inst.Parent == nil then
			table.remove(bindings, i)
		else
			tween(inst, time, { [b[2]] = C[b[3]] }, style, dir)
		end
	end

	local newFrom, newTo = C.glowFrom, C.glowTo
	local driver = Instance.new("NumberValue")
	local conn = driver.Changed:Connect(function(a)
		local seq = ColorSequence.new(oldFrom:Lerp(newFrom, a), oldTo:Lerp(newTo, a))
		for _, g in ipairs(gradients) do
			g.Color = seq
		end
	end)
	local t = tween(driver, time, { Value = 1 }, style, dir)
	t.Completed:Connect(function()
		conn:Disconnect()
		driver:Destroy()
		for _, g in ipairs(gradients) do
			g.Color = ColorSequence.new(newFrom, newTo)
		end
	end)
end

local UI = {}

local getkeySettings = { title = nil, icon = nil }
local getkeyAppliers = {}

local function applyGetkeyAll()
	for _, apply in ipairs(getkeyAppliers) do
		apply()
	end
end

local getMethods = {}
local selectedMethodIndex = nil

function UI.GetMethod(entry)
	entry = entry or {}
	local method = {
		title = entry.Title ~= nil and tostring(entry.Title) or nil,
		icon = entry.Icon,
		url = entry.URL,
		getKeyLink = entry.GetKeyLink or entry.getKeyLink,
		fields = entry,
	}
	table.insert(getMethods, method)
	if not selectedMethodIndex then
		selectedMethodIndex = 1
	end
	applyGetkeyAll()
	return #getMethods
end

local function contrastOn(color)
	local luminance = 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
	return luminance > 0.55 and Color3.fromRGB(11, 11, 11) or Color3.fromRGB(255, 255, 255)
end

local notifSettings = { style = nil }

function UI.SetNotifStyle(style)
	notifSettings.style = style ~= nil and tostring(style) or nil
end

local tabsSettings = { style = nil }
local tabsAppliers = {}

function UI.SetTabsStyle(style)
	tabsSettings.style = style ~= nil and tostring(style) or nil
	for i = #tabsAppliers, 1, -1 do
		if tabsAppliers[i]() == false then
			table.remove(tabsAppliers, i)
		end
	end
end

function UI.SetUIFont(font)
	fontSettings.ui = resolveFont(font)
	applyFontAll()
end

function UI.SetTitleFont(font)
	fontSettings.title = resolveFont(font)
	applyFontAll()
end

function UI.SetGetkeyTitle(title)
	getkeySettings.title = title ~= nil and tostring(title) or nil
	applyGetkeyAll()
end

function UI.SetGetkeyIcon(icon)
	getkeySettings.icon = icon
	applyGetkeyAll()
end

function UI.new(options)
	local __S = {}
	local cfg = {}
	for k, v in pairs(Variables) do
		cfg[k] = v
	end
	for k, v in pairs(options or {}) do
		cfg[k] = v
	end

	__S.HUB_NAME = tostring(cfg.Title)
	__S.HUB_SUBTITLE = tostring(cfg.Description)
	__S.FOLDER = cfg.Folder
	__S.LOGO = assetId(cfg.Logo) or Images.LOGO

	__S.iconsPreloaded = false
	task.spawn(function()
		pcall(function()
			local list = {}
			for _, id in pairs(Images) do
				if type(id) == "string" then
					table.insert(list, id)
				end
			end
			table.insert(list, __S.LOGO)
			game:GetService("ContentProvider"):PreloadAsync(list)
		end)
		__S.iconsPreloaded = true
	end)

	__S.INTRO_SIZE = tonumber(cfg.startintro_size) or 80
	__S.LOADING_TIME = 3
	__S.SQUARE_TIME = tonumber(cfg.squareintro_time) or 1.2
	__S.SHOW_SQUARE_CONTORN = asBool(cfg.squarecontorn, true)

	uiSettings.tintLogo = asBool(cfg.Changelogocolor, true)
	uiSettings.tintIcons = asBool(cfg.Changeiconscolor, true)
	__S.SHOW_GETKEY = asBool(cfg.getkey, true)
	__S.SHOW_CHANGE_THEME = asBool(cfg.ChangeTheme, true)

	__S.themeName = cfg.Theme
	if not THEMES[__S.themeName] then
		__S.themeName = "Amethyst"
	end
	themeIndex = table.find(THEME_ORDER, __S.themeName) or 1
	loadTheme(THEMES[__S.themeName])

	__S.DISCORD_LINK = tostring(cfg.discord_link or "")
	__S.WEBSITE_LINK = tostring(cfg.website_link or "")
	__S.HAS_DISCORD = __S.DISCORD_LINK ~= ""
	__S.HAS_WEBSITE = __S.WEBSITE_LINK ~= ""

	function __S.cardFlag(default, ...)
		for _, source in ipairs({ options or {}, Variables }) do
			for _, key in ipairs({ ... }) do
				if source[key] ~= nil then
					return asBool(source[key], default)
				end
			end
		end
		return default
	end

	__S.SHOW_DISCORD_CARD = __S.cardFlag(true, "Discord", "discord")
	__S.SHOW_WEBSITE_CARD = __S.cardFlag(__S.HAS_WEBSITE, "Website", "website")
	__S.SHOW_INFO_CARD = __S.cardFlag(true, "Informations", "Information", "informations", "information")
	__S.SHOW_INTRO = __S.cardFlag(true, "Intro", "intro")

	__S.KL = { disabletextbox = true, disablegetkey = true, showcard = false, autoconfirm = false }
	__S.KEYLESS = false
	__S.SHOW_KEYLESS_CARD = false

	__S.DISCORD_STARTS_OPEN = __S.SHOW_DISCORD_CARD and not __S.SHOW_WEBSITE_CARD and __S.HAS_DISCORD and not __S.SHOW_KEYLESS_CARD

	__S.NOTIF_STYLE = "1"
	for _, source in ipairs({ options or {}, Variables }) do
		local value = source.NotifStyle
		if value == nil then
			value = source.notifstyle
		end
		if value ~= nil then
			__S.NOTIF_STYLE = tostring(value)
			break
		end
	end

	local INVITE_DISPLAY, INVITE_URL, INVITE_CODE = "Not Configured", "", ""
	if __S.HAS_DISCORD then
		local invite = __S.DISCORD_LINK
		if not invite:find("[/.]") then
			invite = "discord.gg/" .. invite
		end
		INVITE_DISPLAY = invite:gsub("^https?://", "")
		INVITE_URL = invite:match("^https?://") and invite or ("https://" .. invite)
		INVITE_CODE = (INVITE_DISPLAY:gsub("[?#].*$", "")):match("([^/]+)/*$") or INVITE_DISPLAY
	end

	local WEBSITE_DISPLAY, WEBSITE_URL = "Not Configured", ""
	if __S.HAS_WEBSITE then
		WEBSITE_DISPLAY = __S.WEBSITE_LINK:gsub("^https?://", "")
		WEBSITE_URL = __S.WEBSITE_LINK:match("^https?://") and __S.WEBSITE_LINK or ("https://" .. __S.WEBSITE_LINK)
	end

	__S.KEY_CFG = cfg.KeySystem or {}
	__S.API_SERVICES = { cfg.Service or Pasteblox.new(__S.KEY_CFG) }
	__S.KEY_URL = tostring(__S.KEY_CFG.URL or "")
	__S.KEY_SAVE = asBool(__S.KEY_CFG.SaveKey, true)

	__S.LINKS = {
		getKey = __S.KEY_URL,
		website = WEBSITE_URL,
		discord = INVITE_URL,
	}

	function __S.validateKey(key)
		local valid, reason, token, left = __S.API_SERVICES[1]:CheckKey(key)
		if valid then
			return true, nil, token, left
		end
		return false, reason
	end

	function __S.safeIsFile(path)
		if not isfile then
			return false
		end
		local ok, res = pcall(isfile, path)
		return ok and res == true
	end

	function __S.safeReadFile(path)
		if not readfile then
			return nil
		end
		local ok, res = pcall(readfile, path)
		if ok and type(res) == "string" then
			return res
		end
		return nil
	end

	function __S.safeWriteFile(path, contents)
		if not writefile then
			return false
		end
		if __S.FOLDER and __S.FOLDER ~= "" and isfolder and makefolder then
			local ok, exists = pcall(isfolder, __S.FOLDER)
			if ok and not exists then
				pcall(makefolder, __S.FOLDER)
			end
		end
		return pcall(writefile, path, contents) == true
	end

	function __S.hashName(seed)
		local bxor = bit32 and bit32.bxor
		local parts = {}
		for round = 1, 4 do
			local h = (2166136261 + round * 16777619) % 4294967296
			local input = seed .. "|" .. round
			for i = 1, #input do
				local b = input:byte(i)
				h = bxor and bxor(h, b) or ((h + b) % 4294967296)
				h = (h * 16777619) % 4294967296
			end
			parts[round] = string.format("%08x", h)
		end
		return table.concat(parts)
	end

	__S.KEY_HASH = __S.hashName(tostring(__S.FOLDER or "") .. "|" .. __S.HUB_NAME)
	__S.KEY_FILE = (__S.FOLDER and __S.FOLDER ~= "" and (__S.FOLDER .. "/" .. __S.KEY_HASH)) or __S.KEY_HASH

	__S.SAVED_KEY = nil
	if __S.KEY_SAVE and __S.safeIsFile(__S.KEY_FILE) then
		local contents = __S.safeReadFile(__S.KEY_FILE)
		if contents then
			contents = contents:match("^%s*(.-)%s*$")
			if contents ~= "" then
				__S.SAVED_KEY = contents
			end
		end
	end

	if __S.SAVED_KEY and not __S.KEYLESS then
		local service = __S.API_SERVICES[1]
		local okCheck, valid, _, token = pcall(service.CheckKey, service, __S.SAVED_KEY)
		if okCheck and valid and token and service:Run(token) then
			if type(cfg.Callback) == "function" then
				task.spawn(pcall, cfg.Callback, __S.SAVED_KEY)
			end
			return setmetatable({}, {
				__index = function()
					return function(self)
						return self
					end
				end,
				__call = function(self)
					return self
				end,
			})
		end
	end

	__S.STATS_HASH = __S.hashName(tostring(__S.FOLDER or "") .. "|" .. __S.HUB_NAME .. "|stats")
	__S.STATS_FILE = (__S.FOLDER and __S.FOLDER ~= "" and (__S.FOLDER .. "/" .. __S.STATS_HASH)) or __S.STATS_HASH

	__S.STATS = { valid = 0, expired = 0, last = 0 }
	do
		local contents = __S.safeReadFile(__S.STATS_FILE)
		if contents then
			local ok, data = pcall(function()
				return HttpService:JSONDecode(contents)
			end)
			if ok and type(data) == "table" then
				__S.STATS.valid = tonumber(data.valid) or 0
				__S.STATS.expired = tonumber(data.expired) or 0
				__S.STATS.last = tonumber(data.last) or 0
			end
		end
	end

	function __S.saveStats()
		local ok, encoded = pcall(function()
			return HttpService:JSONEncode(__S.STATS)
		end)
		if ok then
			__S.safeWriteFile(__S.STATS_FILE, encoded)
		end
	end

	function __S.formatAgo(ts)
		if not ts or ts <= 0 then
			return "Never"
		end
		local diff = os.time() - ts
		if diff < 60 then
			return "Just now"
		elseif diff < 3600 then
			return math.floor(diff / 60) .. " min ago"
		elseif diff < 86400 then
			return math.floor(diff / 3600) .. " h ago"
		else
			return math.floor(diff / 86400) .. " d ago"
		end
	end

	local state = { ready = false, closing = false }
	local snapLocked = false

	local root = Instance.new("ScreenGui")
	root.Name = "Scripting404"
	root.Enabled = true
	root.DisplayOrder = 999
	root.IgnoreGuiInset = true
	root.ResetOnSpawn = false
	root.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	root.ClipToDeviceSafeArea = true

	root.Destroying:Connect(function()
		for i = #bindings, 1, -1 do
			if bindings[i][1]:IsDescendantOf(root) then
				table.remove(bindings, i)
			end
		end
		for i = #gradients, 1, -1 do
			if gradients[i]:IsDescendantOf(root) then
				table.remove(gradients, i)
			end
		end
		for i = #fontBindings, 1, -1 do
			if fontBindings[i].inst:IsDescendantOf(root) then
				table.remove(fontBindings, i)
			end
		end
	end)

	local main = make("Frame", {
		Name = "Frame",
		Size = UDim2.new(0, __S.INTRO_SIZE, 0, __S.INTRO_SIZE),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, root)

	local shadow = make("ImageLabel", {
		Size = UDim2.new(1, 50, 1, 50),
		Position = UDim2.new(0, -25, 0, -25),
		BackgroundTransparency = 1,
		Image = Images.SHADOW,
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
	}, main)

	local canvas = make("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = "bg",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
	}, main)
	make("UICorner", { CornerRadius = UDim.new(0, 10) }, canvas)

	local borderStroke = make("UIStroke", {
		Thickness = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = "accent",
		Transparency = 1,
	}, canvas)

	local glowStroke
	do
		local RunService = game:GetService("RunService")

		local glow = make("Frame", {
			Name = "BorderGlow",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 5,
		}, main)
		make("UICorner", { CornerRadius = UDim.new(0, 10) }, glow)

		glowStroke = make("UIStroke", {
			Thickness = 2,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.new(1, 1, 1),
			Transparency = 1,
		}, glow)

		local gradient = make("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.35, 0.85),
				NumberSequenceKeypoint.new(0.65, 0.85),
				NumberSequenceKeypoint.new(1, 0),
			}),
		}, glowStroke)

		local conn = RunService.RenderStepped:Connect(function()
			local t = os.clock()
			local h = (t * 0.12) % 1
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(h, 0.85, 1)),
				ColorSequenceKeypoint.new(0.5, Color3.fromHSV((h + 0.5) % 1, 0.85, 1)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 0.85, 1)),
			})
			gradient.Rotation = (t * 140) % 360
		end)

		root.Destroying:Connect(function()
			conn:Disconnect()
		end)
	end

	local decorGroup = make("CanvasGroup", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		GroupTransparency = 1,
	}, canvas)
	make("UICorner", { CornerRadius = UDim.new(0, 10) }, decorGroup)

	local bgFrame = centered(decorGroup, FINAL_W, FINAL_H)
	decor(bgFrame, 380, 140, 230, 266, 0.86, 270)
	decor(bgFrame, 100, 46, -8, 252, 0.75, 90)
	decor(bgFrame, 400, 184, 450, 8, 0.92, 90)
	decor(bgFrame, 70, 138, 5, -5, 0.78, 90)

	local ctx = {
		C = C,
		make = make,
		frame = frame,
		text = text,
		round = round,
		tween = tween,
		prep = prep,
		fade = fade,
		images = Images,
		FONT = FONT,
		FONT_BOLD = FONT_BOLD,
		markBoldFont = markBoldFont,
		root = root,
		canvas = canvas,
		state = state,
		tintIcons = uiSettings.tintIcons,
		attempts = { fails = 0, lockedUntil = 0 },
		getStyle = function()
			return notifSettings.style or __S.NOTIF_STYLE
		end,
		cfg = {
			NOTIF_W = NOTIF_W,
			NOTIF_H = NOTIF_H,
			NOTIF_TRANSPARENCY = NOTIF_TRANSPARENCY,
			NOTIF_COLOR = NOTIF_COLOR,
			NOTIF_BLUR = NOTIF_BLUR,
		},
	}

	local notifs = Notification.new(ctx)
	local notify = notifs.notify

	local intro = centered(canvas, FINAL_W, FINAL_H)

	local introLogo = make("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 64, 0, 58),
		BackgroundTransparency = 1,
		Image = __S.LOGO,
		ImageColor3 = logoRole("accent"),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Fit,
	}, intro)

	local spinnerHolder = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 36),
		Size = UDim2.new(0, 36, 0, 36),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, intro)

	local ringTrack = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 24, 0, 24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, spinnerHolder)
	make("UICorner", { CornerRadius = UDim.new(1, 0) }, ringTrack)
	make("UIStroke", { Thickness = 2.5, Color = "muted", Transparency = 0.75 }, ringTrack)

	local spinner = make("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 24, 0, 24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, spinnerHolder)
	make("UICorner", { CornerRadius = UDim.new(1, 0) }, spinner)
	local spinnerStroke = make("UIStroke", { Thickness = 2.5, Color = "accent" }, spinner)
	make("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.35, 0),
			NumberSequenceKeypoint.new(0.7, 1),
			NumberSequenceKeypoint.new(1, 1),
		}),
	}, spinnerStroke)

	local spin = TweenService:Create(
		spinner,
		TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
		{ Rotation = 360 }
	)

	local content = centered(canvas, FINAL_W, FINAL_H)
	content.Visible = false

	local left = frame(content, 0, 0, 272, 260)

	make("ImageLabel", {
		Position = UDim2.new(0, 22, 0, 20),
		Size = UDim2.new(0, 36, 0, 32),
		BackgroundTransparency = 1,
		Image = __S.LOGO,
		ImageColor3 = logoRole("accent"),
		ScaleType = Enum.ScaleType.Fit,
	}, left)

	local hubTitle = text(left, __S.HUB_NAME, 66, 20, 190, 22, 20, "text")
	markTitleFont(hubTitle)
	hubTitle.TextTruncate = Enum.TextTruncate.AtEnd
	local hubSubtitle = text(left, __S.HUB_SUBTITLE, 66, 42, 190, 14, 12, "muted")
	hubSubtitle.TextTruncate = Enum.TextTruncate.AtEnd

	local licenseLabel = text(left, "License key", 22, 78, 228, 14, 11, "muted")

	local inputBox = frame(left, 22, 96, 228, 36, "input", 0)
	inputBox.ClipsDescendants = true
	round(inputBox, 8, "stroke")
	icon(inputBox, 12, 10, "muted", Images.KEY)

	__S.KEY_MAX_LENGTH = 256

	local keyBox = make("TextBox", {
		Name = "TextBox",
		Position = UDim2.new(0, 38, 0, 0),
		Size = UDim2.new(1, -48, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = "",
		TextSize = 13,
		TextColor3 = "text",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		PlaceholderText = "Paste your key here",
		PlaceholderColor3 = "muted",
		ClearTextOnFocus = false,
		MultiLine = false,
		FontFace = FONT,
	}, inputBox)

	keyBox:GetPropertyChangedSignal("Text"):Connect(function()
		if #keyBox.Text > __S.KEY_MAX_LENGTH then
			keyBox.Text = keyBox.Text:sub(1, __S.KEY_MAX_LENGTH)
		end
	end)

	local submit = make("TextButton", {
		Name = "TextButton",
		Position = UDim2.new(0, 22, 0, 142),
		Size = UDim2.new(0, 110, 0, 34),
		BackgroundColor3 = "submitBg",
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "Submit",
		TextSize = 13,
		TextColor3 = "submitText",
		FontFace = FONT,
	}, left)
	round(submit, 8)
	make("UIPadding", { PaddingLeft = UDim.new(0, 24) }, submit)
	icon(submit, -12, 9, "submitText", Images.SUBMIT)

	local getKey = make("TextButton", {
		Name = "TextButton",
		Position = UDim2.new(0, 140, 0, 142),
		Size = UDim2.new(0, 110, 0, 34),
		BackgroundColor3 = "btn2",
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "Get a key",
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextSize = 13,
		TextColor3 = "text",
		FontFace = FONT,
	}, left)
	round(getKey, 8, "stroke")
	local getKeyPadding = make("UIPadding", { PaddingLeft = UDim.new(0, 24) }, getKey)
	local getKeyIcon = icon(getKey, -12, 9, "text", Images.KEY)

	local methodArrow = make("TextButton", {
		Name = "TextButton",
		Position = UDim2.new(1, -26, 0, 0),
		Size = UDim2.new(0, 26, 1, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "\226\150\190",
		TextSize = 11,
		TextColor3 = "text",
		FontFace = FONT,
		Visible = false,
	}, getKey)

	local methodDropdown = make("Frame", {
		Name = "GetKeyDropdown",
		BackgroundColor3 = "card",
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 50,
		ClipsDescendants = true,
	}, main)
	round(methodDropdown, 8, "stroke")

	local function closeMethodDropdown()
		methodDropdown.Visible = false
	end

	local function rebuildMethodDropdown()
		for _, child in ipairs(methodDropdown:GetChildren()) do
			if child:IsA("GuiObject") then
				child:Destroy()
			end
		end
		local rowH = 32
		for i, m in ipairs(getMethods) do
			local row = make("TextButton", {
				Name = "TextButton",
				Position = UDim2.new(0, 0, 0, (i - 1) * rowH),
				Size = UDim2.new(1, 0, 0, rowH),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "",
				ZIndex = 51,
			}, methodDropdown)
			icon(row, 10, 8, "text", assetId(m.icon) or Images.KEY)
			local label = text(row, m.title or ("Method " .. i), 34, 0, 96, rowH, 12, "text")
			label.ZIndex = 52
			row.MouseButton1Click:Connect(function()
				selectedMethodIndex = i
				applyGetkeyAll()
				closeMethodDropdown()
			end)
		end
		methodDropdown.Size = UDim2.new(0, 140, 0, rowH * math.max(#getMethods, 1))
	end

	methodArrow.MouseButton1Click:Connect(function()
		if not state.ready or state.closing or #getMethods < 2 or (__S.KEYLESS and __S.KL.disablegetkey) then
			return
		end
		if methodDropdown.Visible then
			closeMethodDropdown()
			return
		end
		rebuildMethodDropdown()
		local pos = getKey.AbsolutePosition - main.AbsolutePosition
		local h = methodDropdown.AbsoluteSize.Y
		methodDropdown.Position = UDim2.new(0, pos.X, 0, pos.Y - h - 6)
		methodDropdown.Visible = true
	end)

	do
		local outsideConn = UserInputService.InputBegan:Connect(function(input)
			if not methodDropdown.Visible then
				return
			end
			local kind = input.UserInputType
			if kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.Touch then
				return
			end
			local p = input.Position
			local function inside(gui)
				local a, s = gui.AbsolutePosition, gui.AbsoluteSize
				return p.X >= a.X and p.X <= a.X + s.X and p.Y >= a.Y and p.Y <= a.Y + s.Y
			end
			if not inside(methodDropdown) and not inside(methodArrow) then
				closeMethodDropdown()
			end
		end)
		root.Destroying:Connect(function()
			outsideConn:Disconnect()
		end)
	end

	local function applyGetkey()
		local method = getMethods[selectedMethodIndex or 0]
		local title = method and method.title
		local iconValue = method and method.icon
		if not title or title == "" then
			title = getkeySettings.title
		end
		getKey.Text = (title and title ~= "") and title or "Get a key"
		local image = getKeyIcon:FindFirstChild("iconimage")
		if image then
			Lucide.apply(image, assetId(iconValue) or assetId(getkeySettings.icon) or Images.KEY)
		end
		local showArrow = #getMethods > 1
		methodArrow.Visible = showArrow
		getKeyPadding.PaddingRight = showArrow and UDim.new(0, 20) or UDim.new(0, 0)
		if not showArrow then
			closeMethodDropdown()
		end
	end
	applyGetkey()
	table.insert(getkeyAppliers, applyGetkey)
	root.Destroying:Connect(function()
		local index = table.find(getkeyAppliers, applyGetkey)
		if index then
			table.remove(getkeyAppliers, index)
		end
	end)

	if not __S.SHOW_GETKEY then
		getKey.Visible = false
		submit.Size = UDim2.new(0, 228, 0, 34)
	end

	local avatar = make("ImageLabel", {
		Position = UDim2.new(0, 22, 0, 214),
		Size = UDim2.new(0, 32, 0, 32),
		BackgroundColor3 = "input",
		BorderSizePixel = 0,
		Image = player and ("rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150") or "",
		ScaleType = Enum.ScaleType.Crop,
	}, left)
	round(avatar, 16, "stroke")

	text(left, "Welcome Back", 62, 215, 188, 14, 11, "muted")
	local welcomeName = text(left, ((player and player.DisplayName) or "User") .. "!", 62, 229, 188, 16, 14, "text")
	markBoldFont(welcomeName)
	welcomeName.TextTruncate = Enum.TextTruncate.AtEnd

	frame(content, 272, 20, 1, 220, "stroke", 0)

	local right = frame(content, 273, 0, 187, 260)

	text(right, "Detected game", 20, 24, 147, 14, 11, "muted")

	local gameCard = frame(right, 20, 42, 147, 52, "card", 0)
	round(gameCard, 8)

	local gameImg = make("ImageLabel", {
		Position = UDim2.new(0, 9, 0, 9),
		Size = UDim2.new(0, 34, 0, 34),
		BackgroundColor3 = "input",
		BorderSizePixel = 0,
		Image = Images.GAME_PLACEHOLDER,
		ScaleType = Enum.ScaleType.Stretch,
	}, gameCard)
	round(gameImg, 7, "stroke")

	local gameName = text(gameCard, "Loading...", 52, 10, 90, 14, 12, "text")
	gameName.TextTruncate = Enum.TextTruncate.AtEnd
	local gameStatus = text(gameCard, "Checking...", 52, 27, 90, 13, 11, "muted")

	local rows = frame(right, 0, 0, 187, 260)

	text(rows, "Executor", 20, 106, 60, 14, 11, "muted")
	local executorLabel = text(rows, "Detecting...", 80, 106, 87, 14, 11, "text", Enum.TextXAlignment.Right)
	executorLabel.TextTruncate = Enum.TextTruncate.AtEnd

	text(rows, "Status", 20, 126, 60, 14, 11, "muted")
	local statusValue = text(rows, "Key required", 80, 126, 87, 14, 11, "warn", Enum.TextXAlignment.Right)

	local rightDivider = frame(right, 20, 148, 147, 1, "stroke", 0)

	__S.CARD_PAD = 2
	__S.CARD_VIEW_BOTTOM = 256
	local cardScroll = make("ScrollingFrame", {
		Name = "Cards",
		Position = UDim2.new(0, 20 - __S.CARD_PAD, 0, 158 - __S.CARD_PAD),
		Size = UDim2.new(0, 147 + __S.CARD_PAD + 5, 0, __S.CARD_VIEW_BOTTOM - 158 + __S.CARD_PAD),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
		ScrollBarThickness = 2,
		ScrollBarImageTransparency = 0.45,
		ClipsDescendants = true,
	}, right)
	setRole(cardScroll, "ScrollBarImageColor3", "muted")

	local function linkButton(y, title, subtitle, image)
		local btn = make("TextButton", {
			Name = "TextButton",
			Position = UDim2.new(0, 20, 0, y),
			Size = UDim2.new(0, 147, 0, 40),
			BackgroundColor3 = "card",
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
		}, cardScroll)
		round(btn, 8, "stroke")
		local iconHolder = icon(btn, 11, 12, "accent", image)
		local titleLabel = text(btn, title, 36, 6, 106, 14, 12, "text")
		local subLabel = text(btn, subtitle, 36, 21, 106, 13, 11, "muted")
		subLabel.TextTruncate = Enum.TextTruncate.AtEnd
		return btn, iconHolder, titleLabel, subLabel
	end

	local discord, discordIcon, discordTitle, discordSub = linkButton(158, "Discord", INVITE_DISPLAY, Images.DISCORD)
	local website = linkButton(206, "Website", WEBSITE_DISPLAY, Images.LINK)
	discord.Visible = __S.SHOW_DISCORD_CARD
	website.Visible = __S.SHOW_WEBSITE_CARD
	discordTitle.TextTruncate = Enum.TextTruncate.AtEnd

	discord.ClipsDescendants = true

	local discordExtra = frame(discord, 0, 0, 147, 82)
	discordExtra.Visible = false

	local serverIcon = make("ImageLabel", {
		Position = UDim2.new(0, 9, 0, 7),
		Size = UDim2.new(0, 26, 0, 26),
		BackgroundColor3 = "input",
		BorderSizePixel = 0,
		Image = __S.LOGO,
		ImageColor3 = logoRole("accent"),
		ScaleType = Enum.ScaleType.Fit,
	}, discordExtra)
	round(serverIcon, 8, "stroke")

	local linkHit = make("TextButton", {
		Position = UDim2.new(0, 40, 0, 19),
		Size = UDim2.new(0, 102, 0, 17),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	}, discordExtra)

	frame(discordExtra, 10, 41, 127, 1, "stroke", 0)

	local function statBlock(x, label, dotColor)
		local num = text(discordExtra, "...", x, 47, 62, 16, 13, "text")
		markBoldFont(num)
		local dot = frame(discordExtra, x, 66, 6, 6, dotColor, 0)
		make("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
		text(discordExtra, label, x + 10, 62, 50, 14, 10, "muted")
		return num
	end

	local onlineNum = statBlock(12, "Online", "success")
	local offlineNum = statBlock(80, "Offline", "muted")

	local extraItems = prep(discordExtra)
	local rowsItems = prep(rows)
	local discordIconItems = prep(discordIcon)

	local infoCard, infoIcon, infoTitle, infoSub = linkButton(254, "Information", "Tap to view", Images.KEY)
	infoCard.Visible = __S.SHOW_INFO_CARD
	infoCard.ClipsDescendants = true
	infoTitle.TextTruncate = Enum.TextTruncate.AtEnd

	__S.INFO_OPEN_H = 92
	local infoUI = {}
	do
		local extra = frame(infoCard, 0, 0, 147, __S.INFO_OPEN_H)
		extra.Visible = false
		infoUI.extra = extra

		local iconBox = frame(extra, 9, 7, 26, 26, "input", 0)
		round(iconBox, 8, "stroke")
		icon(iconBox, 5, 5, "accent", Images.KEY)

		frame(extra, 10, 41, 127, 1, "stroke", 0)

		local function stat(x, label, dotColor)
			local num = text(extra, "0", x, 46, 62, 16, 13, "text")
			markBoldFont(num)
			local dot = frame(extra, x, 66, 6, 6, dotColor, 0)
			make("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
			text(extra, label, x + 10, 62, 50, 14, 10, "muted")
			return num
		end
		infoUI.valid = stat(12, "Valid", "success")
		infoUI.expired = stat(80, "Expired", "warn")

		text(extra, "Last used", 12, 77, 56, 13, 10, "muted")
		local lastUsed = text(extra, "Never", 66, 77, 69, 13, 11, "text", Enum.TextXAlignment.Right)
		lastUsed.TextTruncate = Enum.TextTruncate.AtEnd
		infoUI.lastUsed = lastUsed
	end
	infoUI.extraItems = prep(infoUI.extra)
	infoUI.iconItems = prep(infoIcon)

	local keylessCard = linkButton(206, "Keyless Mode", "No key needed", Images.KEYLESS)
	keylessCard.Visible = __S.SHOW_KEYLESS_CARD

	local closeBtn = make("TextButton", {
		Name = "CloseButton",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -12, 0, 12),
		Size = UDim2.new(0, 26, 0, 26),
		BackgroundColor3 = "card",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 5,
	}, content)
	make("UICorner", { CornerRadius = UDim.new(0, 7) }, closeBtn)

	local closeIcon = make("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
		BackgroundTransparency = 1,
		Image = CLOSE_ICON,
		ImageColor3 = iconRole("muted"),
		ZIndex = 6,
	}, closeBtn)

	local moonBtn = make("TextButton", {
		Name = "ThemeButton",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -38, 0, 12),
		Size = UDim2.new(0, 26, 0, 26),
		BackgroundColor3 = "card",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 5,
	}, content)
	make("UICorner", { CornerRadius = UDim.new(0, 7) }, moonBtn)

	local moonIcon = make("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 10, 0, 10),
		BackgroundTransparency = 1,
		Image = MOON_ICON,
		ImageColor3 = iconRole("muted"),
		ZIndex = 6,
	}, moonBtn)
	moonBtn.Visible = __S.SHOW_CHANGE_THEME

	local closeGui

	ctx.pages = Pages.new({
		C = C,
		make = make,
		round = round,
		tween = tween,
		prep = prep,
		fade = fade,
		setRole = setRole,
		icon = icon,
		assetId = assetId,
		contrastOn = contrastOn,
		iconRole = iconRole,
		logoRole = logoRole,
		markTitleFont = markTitleFont,
		getTabsStyle = function()
			if tabsSettings.style then
				return tabsSettings.style
			end
			for _, source in ipairs({ options or {}, Variables }) do
				local value = source.TabsStyle
				if value == nil then
					value = source.tabsstyle
				end
				if value ~= nil then
					return tostring(value)
				end
			end
			return "1"
		end,
		registerTabsStyle = function(apply)
			table.insert(tabsAppliers, apply)
		end,
		FONT = FONT,
		FONT_BOLD = FONT_BOLD,
		images = Images,
		canvas = canvas,
		content = content,
		state = state,
		width = FINAL_W,
		height = FINAL_H,
		title = __S.HUB_NAME,
		logo = __S.LOGO,
		onOpen = function()
			closeMethodDropdown()
		end,
		requestClose = function()
			if not state.ready or state.closing then
				return
			end
			task.spawn(closeGui)
		end,
	})

	if __S.KEYLESS then
		local DIM = 0.5
		local function dim(container)
			local function apply(inst)
				if inst:IsA("GuiObject") then
					inst.BackgroundTransparency = 1 - (1 - inst.BackgroundTransparency) * DIM
					if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
						inst.TextTransparency = 1 - (1 - inst.TextTransparency) * DIM
					elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
						inst.ImageTransparency = 1 - (1 - inst.ImageTransparency) * DIM
					end
				elseif inst:IsA("UIStroke") then
					inst.Transparency = 1 - (1 - inst.Transparency) * DIM
				end
			end
			apply(container)
			for _, d in ipairs(container:GetDescendants()) do
				apply(d)
			end
		end

		if __S.KL.disabletextbox then
			dim(licenseLabel)
			dim(inputBox)
			pcall(function()
				keyBox.TextEditable = false
				keyBox.Active = false
				keyBox.Interactable = false
			end)
			keyBox.Focused:Connect(function()
				keyBox:ReleaseFocus()
			end)
		end

		if __S.KL.disablegetkey then
			dim(getKey)
			pcall(function()
				getKey.Active = false
				getKey.Interactable = false
				methodArrow.Active = false
				methodArrow.Interactable = false
			end)
		end

		statusValue.Text = "Keyless"
		setRole(statusValue, "TextColor3", "accent")
	end

	local spinnerItems = prep(spinnerHolder)
	local contentItems = prep(content)
	fade(spinnerItems, 0)
	fade(contentItems, 0)

	__S.SUPPORTED_GAMES = {}
	__S.GAME_NAMES = {}

	task.spawn(function()
		local okGames, games = pcall(Pasteblox.fetchGames)
		if okGames and type(games) == "table" then
			for _, entry in ipairs(games) do
				__S.SUPPORTED_GAMES[entry.placeId] = entry.status
				if entry.name ~= "" then
					__S.GAME_NAMES[entry.placeId] = entry.name
				end
			end
		end

		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(game.PlaceId)
		end)
		if state.closing then
			return
		end
		gameName.Text = __S.GAME_NAMES[game.PlaceId] or (ok and type(info) == "table" and info.Name) or "Unknown game"

		if game.GameId ~= 0 then
			gameImg.Image = "rbxthumb://type=GameIcon&id=" .. game.GameId .. "&w=150&h=150"
		end

		local mapStatus = __S.SUPPORTED_GAMES[game.PlaceId]
		if mapStatus then
			gameStatus.Text = mapStatus.text
			setRole(gameStatus, "TextColor3", mapStatus.role)
		else
			gameStatus.Text = "Not in our list"
			setRole(gameStatus, "TextColor3", "muted")
		end
	end)

	local function detectExecutor()
		local ok, name = pcall(function()
			if identifyexecutor then
				return identifyexecutor()
			elseif getexecutorname then
				return getexecutorname()
			end
		end)
		if ok and name and tostring(name) ~= "" then
			return tostring(name)
		end
		return "Unknown"
	end

	executorLabel.Text = detectExecutor()

	local function copyLink(url, label, iconKey)
		if not state.ready or state.closing then
			return false
		end
		local fn = setclipboard or toclipboard
		local ok = fn and pcall(fn, url)
		if ok then
			notify(label .. " copied", "The link is in your clipboard.", "success", iconKey)
			return true
		end
		notify("Couldn't copy", url, "warn", iconKey, 5)
		return false
	end

	local fetchingKeyLink = false

	getKey.MouseButton1Click:Connect(function()
		if not state.ready or state.closing then
			return
		end
		if __S.KEYLESS and __S.KL.disablegetkey then
			return
		end

		if #getMethods > 0 then
			local method = getMethods[selectedMethodIndex or 1]
			if not method then
				return
			end
			if method.url and method.url ~= "" then
				copyLink(method.url, "Key link", "link")
				return
			end
			if type(method.getKeyLink) == "function" then
				if fetchingKeyLink then
					return
				end
				fetchingKeyLink = true
				task.spawn(function()
					local methodCtx = { Request = Http.request() }
					for k, v in pairs(method.fields or {}) do
						methodCtx[k] = v
					end
					local ok, link, err = pcall(method.getKeyLink, methodCtx)
					fetchingKeyLink = false
					if not state.ready or state.closing then
						return
					end
					if ok and link then
						copyLink(link, "Key link", "link")
					else
						notify("Couldn't get a key", tostring((not ok) and link or err or "Try again."), "warn", "link", 5)
					end
				end)
			end
			return
		end

		if __S.LINKS.getKey ~= "" then
			copyLink(__S.LINKS.getKey, "Key link", "link")
			return
		end

		local linkProviders = {}
		for _, service in ipairs(__S.API_SERVICES) do
			if service.GetKeyLink then
				table.insert(linkProviders, function()
					return service:GetKeyLink()
				end)
			end
		end
		if #linkProviders > 0 then
			if fetchingKeyLink then
				return
			end
			fetchingKeyLink = true
			task.spawn(function()
				local link, err
				for _, getLink in ipairs(linkProviders) do
					local ok, res, res2 = pcall(getLink)
					if ok and res then
						link = res
						break
					end
					err = ok and res2 or (not ok and res) or err
				end
				fetchingKeyLink = false
				if not state.ready or state.closing then
					return
				end
				if link then
					copyLink(link, "Key link", "link")
				elseif err == "RATE_LIMITED" then
					notify("Slow down", "Wait 5 minutes before requesting another link.", "warn", "link", 5)
				else
					notify("Couldn't get a link", tostring(err or "Unknown error"), "warn", "link", 5)
				end
			end)
			return
		end

		if __S.LINKS.website ~= "" then
			copyLink(__S.LINKS.website, "Key link", "link")
			return
		end

		notify("No link set", "The key link isn't set.", "warn", "link")
	end)

	__S.httpRequest = Http.request()

	local discordInfo = { fetching = false, ok = false, iconLoaded = false, last = 0, online = 0, offline = 0 }

	local discordOpen = false
	local infoOpen = false

	local function anyCardOpen()
		return discordOpen or infoOpen
	end

	local function refreshDiscordTitle()
		local target = (discordOpen and discordInfo.name) or "Discord"
		if discordTitle.Text == target then
			return
		end
		if not state.ready then
			discordTitle.Text = target
			return
		end
		tween(discordTitle, 0.12, { TextTransparency = 1 })
		task.delay(0.12, function()
			if state.closing then
				return
			end
			discordTitle.Text = (discordOpen and discordInfo.name) or "Discord"
			tween(discordTitle, 0.15, { TextTransparency = 0 })
		end)
	end

	local function formatNumber(n)
		local reversed = tostring(math.floor(n)):reverse():gsub("(%d%d%d)", "%1,"):reverse()
		return (reversed:gsub("^,", ""))
	end

	local function applyDiscordInfo()
		if discordInfo.ok then
			onlineNum.Text = formatNumber(discordInfo.online)
			offlineNum.Text = formatNumber(discordInfo.offline)
		elseif discordInfo.fetching then
			onlineNum.Text = "..."
			offlineNum.Text = "..."
		else
			onlineNum.Text = "N/A"
			offlineNum.Text = "N/A"
		end
	end

	local function fetchDiscord()
		if discordInfo.fetching then
			return
		end
		discordInfo.fetching = true
		applyDiscordInfo()

		if __S.httpRequest then
			local ok, res = pcall(__S.httpRequest, {
				Url = "https://discord.com/api/v10/invites/" .. INVITE_CODE .. "?with_counts=true",
				Method = "GET",
			})
			if ok and res and res.StatusCode == 200 and res.Body then
				local okJson, data = pcall(function()
					return HttpService:JSONDecode(res.Body)
				end)
				if okJson and type(data) == "table" and data.approximate_member_count then
					local online = data.approximate_presence_count or 0
					discordInfo.online = online
					discordInfo.offline = math.max(data.approximate_member_count - online, 0)
					discordInfo.ok = true
					discordInfo.last = os.clock()
					if type(data.guild) == "table" and data.guild.name then
						discordInfo.name = data.guild.name
					end

					local guild = data.guild
					local getAsset = getcustomasset or getsynasset
					if guild and guild.icon and not discordInfo.iconLoaded and writefile and getAsset then
						local url = ("https://cdn.discordapp.com/icons/%s/%s.png?size=128"):format(guild.id, guild.icon)
						local okI, resI = pcall(__S.httpRequest, { Url = url, Method = "GET" })
						if okI and resI and resI.StatusCode == 200 and resI.Body and #resI.Body > 0 then
							local okW, asset = pcall(function()
								local fileName = "discord_" .. INVITE_CODE .. ".png"
								if __S.FOLDER and __S.FOLDER ~= "" then
									if isfolder and makefolder and not isfolder(__S.FOLDER) then
										makefolder(__S.FOLDER)
									end
									fileName = __S.FOLDER .. "/" .. fileName
								end
								writefile(fileName, resI.Body)
								return getAsset(fileName)
							end)
							if okW and asset then
								serverIcon.Image = asset
								unbind(serverIcon, "ImageColor3")
								serverIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
								serverIcon.ScaleType = Enum.ScaleType.Crop
								discordInfo.iconLoaded = true
							end
						end
					end
				end
			end
		end

		discordInfo.fetching = false
		applyDiscordInfo()
		refreshDiscordTitle()
	end

	if __S.HAS_DISCORD then
		task.spawn(fetchDiscord)
	end

	__S.CARD_GAP = 8
	local cardOrder = {}
	if __S.SHOW_DISCORD_CARD then
		table.insert(cardOrder, discord)
	end
	if __S.SHOW_KEYLESS_CARD then
		table.insert(cardOrder, keylessCard)
	end
	if __S.SHOW_WEBSITE_CARD then
		table.insert(cardOrder, website)
	end
	if __S.SHOW_INFO_CARD then
		table.insert(cardOrder, infoCard)
	end

	local function cardHeight(card)
		if card == discord and discordOpen then
			return 82
		end
		if card == infoCard and infoOpen then
			return __S.INFO_OPEN_H
		end
		return 40
	end

	__S.layoutToken = 0

	local function layoutCards(instant, focusCard)
		local Quint = Enum.EasingStyle.Quint
		local open = anyCardOpen()
		local divider = open and 106 or 148
		local top = open and 114 or 158

		local y = __S.CARD_PAD
		local focusTop, focusBottom
		for _, card in ipairs(cardOrder) do
			local h = cardHeight(card)
			if card == focusCard then
				focusTop, focusBottom = y - __S.CARD_PAD, y + h + __S.CARD_PAD
			end
			if instant then
				card.Position = UDim2.new(0, __S.CARD_PAD, 0, y)
				card.Size = UDim2.new(0, 147, 0, h)
			else
				tween(card, 0.55, {
					Position = UDim2.new(0, __S.CARD_PAD, 0, y),
					Size = UDim2.new(0, 147, 0, h),
				}, Quint)
			end
			y = y + h + __S.CARD_GAP
		end

		local canvasH = math.max(y - __S.CARD_GAP + __S.CARD_PAD, 0)
		local viewH = __S.CARD_VIEW_BOTTOM - top + __S.CARD_PAD
		local maxPos = math.max(canvasH - viewH, 0)
		local pos = cardScroll.CanvasPosition.Y
		local targetPos = math.clamp(pos, 0, maxPos)
		if focusTop then
			if focusBottom > targetPos + viewH then
				targetPos = focusBottom - viewH
			end
			if focusTop < targetPos then
				targetPos = focusTop
			end
			targetPos = math.clamp(targetPos, 0, maxPos)
		end

		local scrollPos = UDim2.new(0, 20 - __S.CARD_PAD, 0, top - __S.CARD_PAD)
		local scrollSize = UDim2.new(0, 147 + __S.CARD_PAD + 5, 0, viewH)
		local canvasSize = UDim2.new(0, 0, 0, canvasH)

		__S.layoutToken += 1
		local token = __S.layoutToken

		if instant then
			rightDivider.Position = UDim2.new(0, 20, 0, divider)
			cardScroll.Position = scrollPos
			cardScroll.Size = scrollSize
			cardScroll.CanvasSize = canvasSize
			cardScroll.CanvasPosition = Vector2.new(0, targetPos)
			return
		end

		tween(rightDivider, 0.55, { Position = UDim2.new(0, 20, 0, divider) }, Quint)

		if canvasH >= cardScroll.CanvasSize.Y.Offset then
			cardScroll.CanvasSize = canvasSize
		else
			task.delay(0.58, function()
				if token == __S.layoutToken then
					cardScroll.CanvasSize = canvasSize
				end
			end)
		end
		tween(cardScroll, 0.55, {
			Position = scrollPos,
			Size = scrollSize,
			CanvasPosition = Vector2.new(0, targetPos),
		}, Quint)
	end
	layoutCards(true)

	__S.suppressClick = false
	do
		local dragging, dragStartY, dragStartCanvas = false, 0, 0
		local function onPress(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 or dragging or not state.ready then
				return
			end
			if cardScroll.CanvasSize.Y.Offset <= cardScroll.AbsoluteSize.Y then
				return
			end
			dragging = true
			dragStartY = input.Position.Y
			dragStartCanvas = cardScroll.CanvasPosition.Y
		end
		cardScroll.InputBegan:Connect(onPress)
		for _, card in ipairs(cardOrder) do
			card.InputBegan:Connect(onPress)
		end
		local dragMove = UserInputService.InputChanged:Connect(function(input)
			if not dragging or input.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end
			local delta = input.Position.Y - dragStartY
			if not __S.suppressClick and math.abs(delta) < 5 then
				return
			end
			__S.suppressClick = true
			local maxPos = math.max(cardScroll.CanvasSize.Y.Offset - cardScroll.AbsoluteSize.Y, 0)
			cardScroll.CanvasPosition = Vector2.new(0, math.clamp(dragStartCanvas - delta, 0, maxPos))
		end)
		local dragEnd = UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not dragging then
				return
			end
			dragging = false
			task.delay(0.1, function()
				__S.suppressClick = false
			end)
		end)
		root.Destroying:Connect(function()
			dragMove:Disconnect()
			dragEnd:Disconnect()
		end)
	end

	__S.discordToken = 0

	local function setDiscord(open)
		discordOpen = open
		refreshDiscordTitle()
		__S.discordToken += 1
		local token = __S.discordToken
		local Quint = Enum.EasingStyle.Quint

		layoutCards(false, open and discord or nil)

		local textX = open and 40 or 36
		tween(discordTitle, 0.4, { Position = UDim2.new(0, textX, 0, 6) }, Quint)
		tween(discordSub, 0.4, {
			Position = UDim2.new(0, textX, 0, 21),
			Size = UDim2.new(0, open and 102 or 106, 0, 13),
		}, Quint)

		fade(rowsItems, anyCardOpen() and 0 or 1, 0.25)
		fade(discordIconItems, open and 0 or 1, 0.2)

		if open then
			discordExtra.Visible = true
			fade(extraItems, 0)
			task.delay(0.15, function()
				if token == __S.discordToken then
					fade(extraItems, 1, 0.3)
				end
			end)
			if not discordInfo.fetching and (not discordInfo.ok or os.clock() - discordInfo.last > 60) then
				task.spawn(fetchDiscord)
			end
		else
			fade(extraItems, 0, 0.15)
			tween(discordSub, 0.15, { TextColor3 = C.muted })
			task.delay(0.17, function()
				if token == __S.discordToken then
					discordExtra.Visible = false
				end
			end)
		end
	end

	if __S.DISCORD_STARTS_OPEN then
		discordOpen = true
		__S.discordToken += 1
		layoutCards(true)
		discordTitle.Position = UDim2.new(0, 40, 0, 6)
		discordSub.Position = UDim2.new(0, 40, 0, 21)
		discordSub.Size = UDim2.new(0, 102, 0, 13)
		fade(rowsItems, 0)
		fade(discordIconItems, 0)
		discordExtra.Visible = true
	end

	discord.MouseButton1Click:Connect(function()
		if not state.ready or state.closing or __S.suppressClick then
			return
		end
		if not __S.HAS_DISCORD then
			notify("Not configured", "No Discord link has been set.", "warn", "discord")
			return
		end
		setDiscord(not discordOpen)
	end)

	linkHit.MouseButton1Click:Connect(function()
		if __S.suppressClick then
			return
		end
		copyLink(__S.LINKS.discord, "Discord invite", "discord")
	end)
	linkHit.MouseEnter:Connect(function()
		if discordOpen then
			tween(discordSub, 0.15, { TextColor3 = C.accent })
		end
	end)
	linkHit.MouseLeave:Connect(function()
		tween(discordSub, 0.15, { TextColor3 = C.muted })
	end)
	website.MouseButton1Click:Connect(function()
		if not state.ready or state.closing or __S.suppressClick then
			return
		end
		if not __S.HAS_WEBSITE then
			notify("Not configured", "No website link has been set.", "warn", "link")
			return
		end
		copyLink(__S.LINKS.website, "Website link", "link")
	end)

	local function refreshInfo()
		infoUI.valid.Text = formatNumber(__S.STATS.valid)
		infoUI.expired.Text = formatNumber(__S.STATS.expired)
		infoUI.lastUsed.Text = __S.formatAgo(__S.STATS.last)
	end
	refreshInfo()

	do
		local function setLabelText(label, str)
			if label.Text == str then
				return
			end
			if not state.ready then
				label.Text = str
				return
			end
			tween(label, 0.12, { TextTransparency = 1 })
			task.delay(0.12, function()
				if state.closing then
					return
				end
				label.Text = str
				tween(label, 0.15, { TextTransparency = 0 })
			end)
		end

		local infoToken = 0

		local function setInfo(open)
			infoOpen = open
			infoToken += 1
			local token = infoToken
			local Quint = Enum.EasingStyle.Quint

			if open then
				refreshInfo()
			end
			setLabelText(infoSub, open and "Key history" or "Tap to view")

			layoutCards(false, open and infoCard or nil)

			local textX = open and 40 or 36
			tween(infoTitle, 0.4, { Position = UDim2.new(0, textX, 0, 6) }, Quint)
			tween(infoSub, 0.4, {
				Position = UDim2.new(0, textX, 0, 21),
				Size = UDim2.new(0, open and 102 or 106, 0, 13),
			}, Quint)

			fade(rowsItems, anyCardOpen() and 0 or 1, 0.25)
			fade(infoUI.iconItems, open and 0 or 1, 0.2)

			if open then
				infoUI.extra.Visible = true
				fade(infoUI.extraItems, 0)
				task.delay(0.15, function()
					if token == infoToken then
						fade(infoUI.extraItems, 1, 0.3)
					end
				end)
			else
				fade(infoUI.extraItems, 0, 0.15)
				task.delay(0.17, function()
					if token == infoToken then
						infoUI.extra.Visible = false
					end
				end)
			end
		end

		infoCard.MouseButton1Click:Connect(function()
			if not state.ready or state.closing or __S.suppressClick then
				return
			end
			setInfo(not infoOpen)
		end)
	end

	__S.checkingKey = false

	local fadeContent
	do
		local rowsHidden, discordIconHidden, infoIconHidden = {}, {}, {}
		for _, it in ipairs(rowsItems) do
			rowsHidden[it[1]] = true
		end
		for _, it in ipairs(discordIconItems) do
			discordIconHidden[it[1]] = true
		end
		for _, it in ipairs(infoUI.iconItems) do
			infoIconHidden[it[1]] = true
		end

		function fadeContent(alpha, time)
			if anyCardOpen() and alpha > 0 then
				local filtered = {}
				for _, it in ipairs(contentItems) do
					local inst = it[1]
					local hide = rowsHidden[inst] or (discordOpen and discordIconHidden[inst]) or (infoOpen and infoIconHidden[inst])
					if not hide then
						filtered[#filtered + 1] = it
					end
				end
				fade(filtered, alpha, time)
			else
				fade(contentItems, alpha, time)
			end
		end
	end

	local function runKeyCheck(key, isSavedKey)
		__S.checkingKey = true
		state.ready = false
		notifs.dismissAll()

		local result
		task.spawn(function()
			if __S.KEYLESS then
				result = { ok = true, valid = true }
				return
			end
			local ok, valid, reason, token, left = pcall(__S.validateKey, key)
			result = { ok = ok, valid = valid, reason = reason, token = token, timeLeft = left }
		end)

		fadeContent(0, 0.25)
		task.wait(0.25)
		content.Visible = false
		spinnerHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
		spin:Play()
		fade(spinnerItems, 1, 0.25)

		local minCheckTime = isSavedKey and SAVED_CHECK_TIME or CHECK_TIME
		local t0 = os.clock()
		repeat
			task.wait()
		until (result and os.clock() - t0 >= minCheckTime) or os.clock() - t0 > 15

		if not (result and result.ok and result.valid) then
			fade(spinnerItems, 0, 0.25)
			task.wait(0.25)
			spin:Cancel()
			content.Visible = true
			fadeContent(1, 0.35)
			if result and result.ok then
				if isSavedKey then
					if delfile and __S.safeIsFile(__S.KEY_FILE) then
						pcall(delfile, __S.KEY_FILE)
					end
					keyBox.Text = ""
				end

				local attempts = ctx.attempts
				attempts.fails += 1
				if attempts.fails >= MAX_FAILED_ATTEMPTS then
					attempts.fails = 0
					attempts.lockedUntil = os.clock() + LOCKOUT_TIME
				end

				local detail = result.reason and tostring(result.reason) or "That key isn't valid. Get a new one."
				if detail:lower():find("expir") then
					__S.STATS.expired += 1
					__S.saveStats()
					refreshInfo()
				end
				notify("Invalid key", detail, "error")
			else
				local detail = result and result.valid and tostring(result.valid) or "Couldn't check your key. Try again."
				notify("Something went wrong", detail, "error")
			end
			task.wait(0.35)
			state.ready = true
			__S.checkingKey = false
			return
		end

		ctx.attempts.fails = 0

		if __S.KEYLESS then
			statusValue.Text = "Keyless"
			setRole(statusValue, "TextColor3", "accent")
		else
			statusValue.Text = "Key valid"
			setRole(statusValue, "TextColor3", "success")

			if __S.KEY_SAVE then
				__S.safeWriteFile(__S.KEY_FILE, key)
			end

			__S.STATS.valid += 1
			__S.STATS.last = os.time()
			__S.saveStats()
		end

		local runOk, runError = __S.API_SERVICES[1]:Run(result.token)

		if not runOk then
			fade(spinnerItems, 0, 0.25)
			task.wait(0.25)
			spin:Cancel()
			content.Visible = true
			fadeContent(1, 0.35)
			notify("Script error", tostring(runError):sub(1, 80), "error", nil, 5)
			task.wait(0.35)
			state.ready = true
			__S.checkingKey = false
			return
		end

		if type(cfg.Callback) == "function" then
			task.spawn(pcall, cfg.Callback, key)
		end

		state.closing = true
		fade(spinnerItems, 0, 0.2)
		tween(canvas, 0.3, { BackgroundTransparency = 1 })
		tween(decorGroup, 0.3, { GroupTransparency = 1 })
		tween(borderStroke, 0.3, { Transparency = 1 })
		tween(glowStroke, 0.3, { Transparency = 1 })
		tween(shadow, 0.3, { ImageTransparency = 1 })
		task.wait(0.35)
		spin:Cancel()
		root:Destroy()
	end

	ctx.submit = function()
		if not state.ready or state.closing or __S.checkingKey then
			return
		end

		if __S.KEYLESS then
			runKeyCheck("")
			return
		end

		local locked = ctx.attempts.lockedUntil - os.clock()
		if locked > 0 then
			notify("Slow down", ("Too many wrong keys. Try again in %ds."):format(math.ceil(locked)), "warn", "key")
			return
		end

		local key = keyBox.Text:match("^%s*(.-)%s*$")
		if key == "" then
			notify("Empty key", "Paste your key in the box first.", "warn", "key")
			return
		end

		runKeyCheck(key)
	end

	submit.MouseButton1Click:Connect(ctx.submit)
	keyBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			ctx.submit()
		end
	end)

	closeGui = function()
		if state.closing then
			return
		end
		state.closing = true
		state.ready = false
		notifs.dismissAll()

		tintTo(closeIcon, C.muted)
		tween(closeBtn, 0.15, { BackgroundTransparency = 1 })

		if not __S.SHOW_INTRO then
			fadeContent(0, 0.3)
			ctx.pages.fadeOut(0.3)
			tween(canvas, 0.35, { BackgroundTransparency = 1 })
			tween(decorGroup, 0.35, { GroupTransparency = 1 })
			tween(borderStroke, 0.35, { Transparency = 1 })
			tween(glowStroke, 0.35, { Transparency = 1 })
			tween(shadow, 0.35, { ImageTransparency = 1 })
			task.wait(0.4)
			root:Destroy()
			return
		end

		fadeContent(0, 0.2)
		ctx.pages.fadeOut(0.2)

		task.wait(0.2)
		content.Visible = false

		introLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
		tween(introLogo, 0.4, { ImageTransparency = 0 })
		tween(borderStroke, 0.5, { Transparency = 0.55 })
		tween(main, 0.65, { Size = UDim2.new(0, __S.INTRO_SIZE, 0, __S.INTRO_SIZE) }, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
		task.wait(0.7)

		tween(canvas, 0.35, { BackgroundTransparency = 1 })
		tween(decorGroup, 0.35, { GroupTransparency = 1 })
		tween(introLogo, 0.35, { ImageTransparency = 1 })
		tween(borderStroke, 0.35, { Transparency = 1 })
		tween(glowStroke, 0.35, { Transparency = 1 })
		tween(shadow, 0.35, { ImageTransparency = 1 })
		task.wait(0.4)
		root:Destroy()
	end

	closeBtn.MouseButton1Click:Connect(function()
		if not state.ready or state.closing then
			return
		end
		task.spawn(closeGui)
	end)

	closeBtn.MouseEnter:Connect(function()
		if not state.ready or state.closing then
			return
		end
		tween(closeBtn, 0.15, { BackgroundTransparency = 0 })
		tintTo(closeIcon, C.text)
	end)
	closeBtn.MouseLeave:Connect(function()
		if not state.ready or state.closing then
			return
		end
		tween(closeBtn, 0.15, { BackgroundTransparency = 1 })
		tintTo(closeIcon, C.muted)
	end)
	moonBtn.MouseEnter:Connect(function()
		if not state.ready or state.closing then
			return
		end
		tween(moonBtn, 0.15, { BackgroundTransparency = 0 })
		tintTo(moonIcon, C.text)
	end)
	moonBtn.MouseLeave:Connect(function()
		tween(moonBtn, 0.15, { BackgroundTransparency = 1 })
		tintTo(moonIcon, C.muted)
	end)

	__S.THEME_ANIM_TIME = 1.6
	__S.switchingTheme = false

	local function switchTheme()
		if not state.ready or state.closing or __S.checkingKey or __S.switchingTheme then
			return
		end
		__S.switchingTheme = true
		state.ready = false
		notifs.dismissAll()

		tintTo(moonIcon, C.muted)
		tween(moonBtn, 0.15, { BackgroundTransparency = 1 })
		fadeContent(0, 0.25)
		task.wait(0.25)
		content.Visible = false
		spinnerHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
		spin:Play()
		fade(spinnerItems, 1, 0.25)
		task.wait(0.4)

		themeIndex = themeIndex % #THEME_ORDER + 1
		local name = THEME_ORDER[themeIndex]
		applyTheme(name, __S.THEME_ANIM_TIME)
		task.wait(__S.THEME_ANIM_TIME + 0.3)

		fade(spinnerItems, 0, 0.25)
		task.wait(0.25)
		spin:Cancel()
		content.Visible = true
		fadeContent(1, 0.35)
		notify("Theme: " .. name, "Theme applied.", "info", "moon")
		task.wait(0.35)

		state.ready = true
		__S.switchingTheme = false
	end

	moonBtn.MouseButton1Click:Connect(function()
		task.spawn(switchTheme)
	end)

	if not mountGui(root) then
		root:Destroy()
		error("[" .. __S.HUB_NAME .. "] couldn't find a place to mount the UI (gethui / CoreGui / PlayerGui all failed)")
	end

	local dragOffset = Vector2.new(0, 0)

	local function snap()
		if snapLocked then
			return
		end
		local size = root.AbsoluteSize
		main.Position = UDim2.new(0, math.floor(size.X / 2 + dragOffset.X), 0, math.floor(size.Y / 2 + dragOffset.Y))
	end
	snap()
	root:GetPropertyChangedSignal("AbsoluteSize"):Connect(snap)

	do
		local RunService = game:GetService("RunService")

		local zone = make("Frame", {
			Name = "DragZone",
			Size = UDim2.new(1, -90, 0, 38),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Active = true,
			ZIndex = 2,
		}, canvas)

		local dragging = false
		local dragInput, dragStart, startOffset
		local target = dragOffset
		local rot, bias, vx, lastDir = main.Rotation, 0, 0, 1
		local stepConn

		local function apply()
			local size = root.AbsoluteSize
			main.Position = UDim2.new(
				0,
				math.floor(size.X / 2 + dragOffset.X + 0.5),
				0,
				math.floor(size.Y / 2 + dragOffset.Y + 0.5)
			)
		end

		local function step(dt)
			dt = math.min(dt, 0.1)
			if state.closing then
				dragging = false
			end

			local prevX = dragOffset.X
			dragOffset = dragOffset:Lerp(target, 1 - math.exp(-dt * 20))
			if (target - dragOffset).Magnitude < 0.05 then
				dragOffset = target
			end
			apply()

			local instant = dt > 0 and (dragOffset.X - prevX) / dt or 0
			vx = vx + (instant - vx) * (1 - math.exp(-dt * 10))
			if math.abs(vx) > 20 then
				lastDir = vx > 0 and 1 or -1
			end

			local biasGoal = dragging and 3 * lastDir or 0
			bias = bias + (biasGoal - bias) * (1 - math.exp(-dt * 8))

			local goal = math.clamp(vx * 0.012, -12, 12) + bias
			rot = rot + (goal - rot) * (1 - math.exp(-dt * 12))
			main.Rotation = rot

			if not dragging and dragOffset == target and math.abs(rot) < 0.05 and math.abs(vx) < 1 then
				rot, bias, vx = 0, 0, 0
				main.Rotation = 0
				if stepConn then
					stepConn:Disconnect()
					stepConn = nil
				end
			end
		end

		local function startLoop()
			if not stepConn then
				stepConn = RunService.RenderStepped:Connect(step)
			end
		end

		zone.InputBegan:Connect(function(input)
			local kind = input.UserInputType
			if kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.Touch then
				return
			end
			if dragging or not state.ready or state.closing then
				return
			end
			dragging = true
			dragInput = input
			dragStart = input.Position
			startOffset = dragOffset
			target = dragOffset
			startLoop()
		end)

		local moveConn = UserInputService.InputChanged:Connect(function(input)
			if not dragging then
				return
			end
			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input ~= dragInput then
				return
			end
			local delta = input.Position - dragStart
			local size = root.AbsoluteSize
			target = Vector2.new(
				math.clamp(startOffset.X + delta.X, -size.X / 2 + 60, size.X / 2 - 60),
				math.clamp(startOffset.Y + delta.Y, -size.Y / 2 + 40, size.Y / 2 - 40)
			)
		end)

		local endConn = UserInputService.InputEnded:Connect(function(input)
			if not dragging or not dragInput then
				return
			end
			local sameMouse = dragInput.UserInputType == Enum.UserInputType.MouseButton1
				and input.UserInputType == Enum.UserInputType.MouseButton1
			if input == dragInput or sameMouse then
				dragging = false
				dragInput = nil
			end
		end)

		root.Destroying:Connect(function()
			moveConn:Disconnect()
			endConn:Disconnect()
			if stepConn then
				stepConn:Disconnect()
				stepConn = nil
			end
		end)
	end

	task.spawn(function()
		if __S.SHOW_INTRO then
			main.Size = UDim2.new(0, __S.INTRO_SIZE - 20, 0, __S.INTRO_SIZE - 20)
			tween(main, 0.6, { Size = UDim2.new(0, __S.INTRO_SIZE, 0, __S.INTRO_SIZE) }, Enum.EasingStyle.Quint)
			tween(canvas, 0.5, { BackgroundTransparency = 0 })
			tween(decorGroup, 0.5, { GroupTransparency = 0 })
			tween(introLogo, 0.5, { ImageTransparency = 0 })
			if __S.SHOW_SQUARE_CONTORN then
				tween(borderStroke, 0.5, { Transparency = 0.55 })
			end
			tween(shadow, 0.5, { ImageTransparency = 0.6 })
			task.wait(__S.SQUARE_TIME)

			tween(borderStroke, 0.7, { Transparency = 1 })
			tween(main, 0.85, { Size = UDim2.new(0, FINAL_W, 0, FINAL_H) }, Enum.EasingStyle.Quint)
			tween(introLogo, 0.7, { Position = UDim2.new(0.5, 0, 0.5, -20) }, Enum.EasingStyle.Quint)
			task.wait(0.35)
			spin:Play()
			fade(spinnerItems, 1, 0.4)

			task.wait(__S.LOADING_TIME)

			fade(spinnerItems, 0, 0.3)
			tween(introLogo, 0.3, { ImageTransparency = 1 })
			task.wait(0.2)
			spin:Cancel()
		else
			main.Size = UDim2.new(0, FINAL_W, 0, FINAL_H)
			task.wait(__S.LOADING_TIME)

			tween(canvas, 0.5, { BackgroundTransparency = 0 })
			tween(decorGroup, 0.5, { GroupTransparency = 0 })
			tween(shadow, 0.5, { ImageTransparency = 0.6 })
			task.wait(0.25)
		end

		while not __S.iconsPreloaded do
			task.wait()
		end

		tween(glowStroke, 0.6, { Transparency = 0 })
		content.Visible = true
		fadeContent(1, 0.45)
		task.wait(0.3)
		state.ready = true

		if __S.KEYLESS then
			if __S.KL.autoconfirm and not __S.checkingKey then
				task.wait(0.15)
				runKeyCheck("")
			end
		elseif __S.SAVED_KEY and not __S.checkingKey then
			keyBox.Text = __S.SAVED_KEY
			task.wait(0.15)
			runKeyCheck(__S.SAVED_KEY, true)
		end
	end)

	local api = {}
	function api:SetGetkeyTitle(title)
		UI.SetGetkeyTitle(title)
		return self
	end
	function api:SetGetkeyIcon(icon)
		UI.SetGetkeyIcon(icon)
		return self
	end
	function api:SetNotifStyle(style)
		UI.SetNotifStyle(style)
		return self
	end
	api.NotifStyle = api.SetNotifStyle
	function api:SetTabsStyle(style)
		UI.SetTabsStyle(style)
		return self
	end
	api.TabsStyle = api.SetTabsStyle
	function api:GetMethod(entry)
		UI.GetMethod(entry)
		return self
	end
	function api:SetUIFont(font)
		UI.SetUIFont(font)
		return self
	end
	function api:SetTitleFont(font)
		UI.SetTitleFont(font)
		return self
	end
	function api:Tab(props)
		return ctx.pages.createTab(props)
	end
	api.Gui = root

	return setmetatable(api, {
		__call = function(_, props)
			return ctx.pages.createTab(props)
		end,
		__index = function(_, key)
			local value = root[key]
			if type(value) == "function" then
				return function(_, ...)
					return value(root, ...)
				end
			end
			return value
		end,
		__newindex = function(_, key, value)
			root[key] = value
		end,
	})
end

return UI
end

local KeySystem = {}
local launched = false
local current = nil

local function firstArg(a, b)
	if a == KeySystem then
		return b
	end
	return a
end

function KeySystem.new(a, b)
	launched = true
	if current then
		pcall(function()
			current.Gui:Destroy()
		end)
		current = nil
	end
	local options = firstArg(a, b)
	if type(options) ~= "table" then
		options = {}
	end
	current = import("components/window/ui").new(options)
	return current
end

function KeySystem.SetGetkeyTitle(a, b)
	import("components/window/ui").SetGetkeyTitle(firstArg(a, b))
	return KeySystem
end

function KeySystem.SetGetkeyIcon(a, b)
	import("components/window/ui").SetGetkeyIcon(firstArg(a, b))
	return KeySystem
end

function KeySystem.SetNotifStyle(a, b)
	import("components/window/ui").SetNotifStyle(firstArg(a, b))
	return KeySystem
end

KeySystem.NotifStyle = KeySystem.SetNotifStyle

function KeySystem.SetTabsStyle(a, b)
	import("components/window/ui").SetTabsStyle(firstArg(a, b))
	return KeySystem
end

KeySystem.TabsStyle = KeySystem.SetTabsStyle

function KeySystem.GetGames()
	return import("utilities/pasteblox").fetchGames()
end

function KeySystem.GetMethod(a, b)
	return import("components/window/ui").GetMethod(firstArg(a, b))
end

function KeySystem.SetUIFont(a, b)
	import("components/window/ui").SetUIFont(firstArg(a, b))
	return KeySystem
end

function KeySystem.SetTitleFont(a, b)
	import("components/window/ui").SetTitleFont(firstArg(a, b))
	return KeySystem
end

return KeySystem
