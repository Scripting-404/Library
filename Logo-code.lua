return function(ctx)
	local new = ctx.new
	local tween = ctx.tween
	local tweenAfter = ctx.tweenAfter
	local GRID = ctx.GRID
	local CENTER = ctx.CENTER
	local GRID_R = ctx.GRID_R
	local STROKE = ctx.STROKE
	local CHARS = ctx.CHARS

local Geo = {}

function Geo.hyp(a, b)
	return math.sqrt(a * a + b * b)
end

function Geo.seg(u, v, x1, y1, x2, y2)
	local dx, dy = x2 - x1, y2 - y1
	local t = math.clamp(((u - x1) * dx + (v - y1) * dy) / (dx * dx + dy * dy), 0, 1)
	return Geo.hyp(u - (x1 + t * dx), v - (y1 + t * dy))
end

function Geo.poly(u, v, pts)
	local m = math.huge
	local n = #pts
	for i = 1, n do
		local a = pts[i]
		local b = pts[i % n + 1]
		local d = Geo.seg(u, v, a[1], a[2], b[1], b[2])
		if d < m then
			m = d
		end
	end
	return m
end

function Geo.inside(u, v, pts)
	local result = false
	local n = #pts
	local j = n
	for i = 1, n do
		local xi, yi = pts[i][1], pts[i][2]
		local xj, yj = pts[j][1], pts[j][2]
		if (yi > v) ~= (yj > v) and u < (xj - xi) * (v - yi) / (yj - yi) + xi then
			result = not result
		end
		j = i
	end
	return result
end

function Geo.rbox(u, v, cx, cy, hx, hy, r)
	local qx = math.abs(u - cx) - (hx - r)
	local qy = math.abs(v - cy) - (hy - r)
	return Geo.hyp(math.max(qx, 0), math.max(qy, 0)) + math.min(math.max(qx, qy), 0) - r
end

function Geo.ell(u, v, ang, a, b)
	local ca, sa = math.cos(ang), math.sin(ang)
	local x = u * ca + v * sa
	local y = -u * sa + v * ca
	return (x / a) ^ 2 + (y / b) ^ 2
end

function Geo.glyph(g, bx, by)
	if bx < 0 or bx >= 5 or by < 0 or by >= 7 then
		return false
	end
	return g[by + 1]:sub(bx + 1, bx + 1) == "X"
end

Geo.H = { "X...X", "X...X", "X...X", "XXXXX", "X...X", "X...X", "X...X" }
Geo.I = { "XXXXX", "..X..", "..X..", "..X..", "..X..", "..X..", "XXXXX" }
Geo.HEX = { { 0, -0.86 }, { 0.745, -0.43 }, { 0.745, 0.43 }, { 0, 0.86 }, { -0.745, 0.43 }, { -0.745, -0.43 } }
Geo.TAIL = { { -0.52, 0.42 }, { -0.66, 0.88 }, { -0.12, 0.46 } }
Geo.SHIELD = { { 0, -0.88 }, { 0.74, -0.62 }, { 0.74, 0.06 }, { 0.46, 0.52 }, { 0, 0.9 }, { -0.46, 0.52 }, { -0.74, 0.06 }, { -0.74, -0.62 } }
Geo.BOLT = { { 0.18, -0.92 }, { -0.52, 0.08 }, { -0.06, 0.08 }, { -0.2, 0.92 }, { 0.52, -0.16 }, { 0.06, -0.16 } }
Geo.PINS = { -0.3, 0, 0.3 }
Geo.DOTS = { -0.7, -0.54, -0.38 }
Geo.ATOM = { 0, math.pi / 3, 2 * math.pi / 3 }
function Geo.line(u, v, pts)
	local m = math.huge
	for i = 1, #pts - 1 do
		local a, b = pts[i], pts[i + 1]
		local d = Geo.seg(u, v, a[1], a[2], b[1], b[2])
		if d < m then
			m = d
		end
	end
	return m
end

function Geo.arc(cx, cy, a, b, t0, t1, n)
	local pts = {}
	for i = 0, n do
		local t = t0 + (t1 - t0) * i / n
		pts[#pts + 1] = { cx + a * math.cos(t), cy + b * math.sin(t) }
	end
	return pts
end

Geo.BRACE = { { -0.38, -0.8 }, { -0.62, -0.66 }, { -0.62, -0.14 }, { -0.84, 0 }, { -0.62, 0.14 }, { -0.62, 0.66 }, { -0.38, 0.8 } }
Geo.BRACKET = { { -0.4, -0.7 }, { -0.8, -0.7 }, { -0.8, 0.7 }, { -0.4, 0.7 } }
Geo.DOTS3 = { -0.2, 0, 0.2 }
Geo.DB_TOP = Geo.arc(0, -0.5, 0.62, 0.22, 0, 2 * math.pi, 28)
Geo.DB_M1 = Geo.arc(0, -0.1, 0.62, 0.22, 0, math.pi, 16)
Geo.DB_M2 = Geo.arc(0, 0.3, 0.62, 0.22, 0, math.pi, 16)
Geo.DB_BOT = Geo.arc(0, 0.7, 0.62, 0.22, 0, math.pi, 16)
Geo.HEART = {}
for i = 0, 47 do
	local t = (i / 48) * 2 * math.pi
	local hx = 16 * math.sin(t) ^ 3
	local hy = 13 * math.cos(t) - 5 * math.cos(2 * t) - 2 * math.cos(3 * t) - math.cos(4 * t)
	Geo.HEART[#Geo.HEART + 1] = { hx / 17.5, -(hy + 2.5) / 17.5 }
end
Geo.WIFI = { 0.38, 0.68, 0.98 }
Geo.CURSOR = { { -0.5, -0.85 }, { -0.5, 0.6 }, { -0.14, 0.3 }, { 0.08, 0.86 }, { 0.3, 0.77 }, { 0.08, 0.22 }, { 0.55, 0.22 } }
Geo.PULSE = { { -0.9, 0.05 }, { -0.45, 0.05 }, { -0.3, -0.35 }, { -0.1, 0.5 }, { 0.1, -0.7 }, { 0.3, 0.2 }, { 0.45, 0.05 }, { 0.9, 0.05 } }
Geo.TRAY = { { -0.72, 0.12 }, { -0.72, 0.72 }, { 0.72, 0.72 }, { 0.72, 0.12 } }
Geo.ARROWHEAD = { { -0.4, -0.08 }, { 0, 0.34 }, { 0.4, -0.08 } }
Geo.PLAY = { { -0.22, -0.5 }, { 0.54, 0 }, { -0.22, 0.5 } }
Geo.BUG_NODES = { { -0.32, -0.7 }, { -0.32, 0.7 }, { 0.4, -0.38 } }

local Shapes = {
	roblox = function(u, v)
		local a = math.rad(-14)
		local ru = u * math.cos(a) - v * math.sin(a)
		local rv = u * math.sin(a) + v * math.cos(a)
		local m = math.max(math.abs(ru), math.abs(rv))
		return (m <= 0.78 and m > 0.36) and 2 or 0
	end,
	lua = function(u, v)
		if Geo.hyp(u - 0.7, v + 0.7) <= 0.17 then
			return 1
		end
		local bd = Geo.hyp(u + 0.08, v - 0.08)
		if bd <= 0.78 and not (bd >= 0.40 and bd <= 0.52) then
			return 2
		end
		return 0
	end,
	cyber = function(u, v)
		if Geo.poly(u, v, Geo.HEX) <= STROKE then
			return 1
		end
		local d = math.abs(u) + math.abs(v)
		if d <= 0.36 or math.abs(d - 0.52) <= 0.04 then
			return 1
		end
		return 0
	end,
	code = function(u, v)
		local w = 0.07
		if Geo.seg(u, v, -0.30, -0.56, -0.84, 0.0) <= w or Geo.seg(u, v, -0.84, 0.0, -0.30, 0.56) <= w then
			return 1
		end
		if Geo.seg(u, v, 0.30, -0.56, 0.84, 0.0) <= w or Geo.seg(u, v, 0.84, 0.0, 0.30, 0.56) <= w then
			return 1
		end
		if Geo.seg(u, v, 0.16, -0.66, -0.16, 0.66) <= w then
			return 1
		end
		return 0
	end,
	hello = function(u, v, cx, cy)
		local sd = Geo.rbox(u, v, 0, -0.12, 0.88, 0.60, 0.24)
		local tx = cx + 11
		local gy = math.floor((cy + 9) / 2)
		if tx >= 0 and tx < 10 and Geo.glyph(Geo.H, math.floor(tx / 2), gy) then
			return 1
		end
		local tx2 = tx - 12
		if tx2 >= 0 and tx2 < 10 and Geo.glyph(Geo.I, math.floor(tx2 / 2), gy) then
			return 1
		end
		if Geo.inside(u, v, Geo.TAIL) then
			return 0
		end
		if sd > 0 and Geo.poly(u, v, Geo.TAIL) <= STROKE then
			return 1
		end
		if math.abs(sd) <= STROKE then
			return 1
		end
		return 0
	end,
	core = function(u, v)
		if math.abs(Geo.rbox(u, v, 0, 0, 0.52, 0.52, 0.08)) <= STROKE then
			return 1
		end
		if math.max(math.abs(u), math.abs(v)) <= 0.26 then
			return 1
		end
		for _, k in ipairs(Geo.PINS) do
			if math.abs(u - k) <= 0.04 and math.abs(v) > 0.5 and math.abs(v) <= 0.86 then
				return 1
			end
			if math.abs(v - k) <= 0.04 and math.abs(u) > 0.5 and math.abs(u) <= 0.86 then
				return 1
			end
		end
		return 0
	end,
	shield = function(u, v)
		if Geo.poly(u, v, Geo.SHIELD) <= STROKE then
			return 1
		end
		if Geo.seg(u, v, -0.30, 0.0, -0.08, 0.24) <= 0.07 or Geo.seg(u, v, -0.08, 0.24, 0.32, -0.22) <= 0.07 then
			return 1
		end
		return 0
	end,
	lock = function(u, v)
		local sd = Geo.rbox(u, v, 0, 0.3, 0.56, 0.46, 0.1)
		if sd <= 0 then
			if Geo.hyp(u, v - 0.24) <= 0.1 or (math.abs(u) <= 0.04 and v >= 0.24 and v <= 0.5) then
				return 0
			end
			return (sd < -STROKE) and 2 or 1
		end
		if v <= -0.1 and math.abs(Geo.hyp(u, v + 0.1) - 0.34) <= 0.065 then
			return 1
		end
		return 0
	end,
	bolt = function(u, v)
		return Geo.inside(u, v, Geo.BOLT) and 1 or 0
	end,
	terminal = function(u, v)
		local sd = Geo.rbox(u, v, 0, 0, 0.9, 0.68, 0.1)
		if math.abs(sd) <= STROKE then
			return 1
		end
		if sd < 0 and math.abs(v + 0.42) <= 0.04 then
			return 1
		end
		for _, dx in ipairs(Geo.DOTS) do
			if Geo.hyp(u - dx, v + 0.55) <= 0.055 then
				return 1
			end
		end
		if Geo.seg(u, v, -0.55, -0.2, -0.25, 0.04) <= 0.06 or Geo.seg(u, v, -0.25, 0.04, -0.55, 0.28) <= 0.06 then
			return 1
		end
		if Geo.seg(u, v, -0.1, 0.34, 0.36, 0.34) <= 0.06 then
			return 1
		end
		return 0
	end,
	gear = function(u, v)
		local r = Geo.hyp(u, v)
		if math.abs(r - 0.52) <= 0.09 or math.abs(r - 0.2) <= 0.07 then
			return 1
		end
		if r >= 0.58 and r <= 0.86 and math.cos(8 * math.atan2(v, u)) > 0.25 then
			return 1
		end
		return 0
	end,
	globe = function(u, v)
		local r = Geo.hyp(u, v)
		if math.abs(r - 0.84) <= STROKE then
			return 1
		end
		if r < 0.84 then
			if math.abs(v) <= 0.045 or math.abs(u) <= 0.045 then
				return 1
			end
			if math.abs(math.abs(v) - 0.44) <= 0.04 then
				return 1
			end
			if math.abs((u / 0.42) ^ 2 + (v / 0.84) ^ 2 - 1) <= 0.22 then
				return 1
			end
		end
		return 0
	end,
	key = function(u, v)
		if math.abs(Geo.hyp(u + 0.42, v + 0.36) - 0.3) <= 0.07 then
			return 1
		end
		if Geo.seg(u, v, -0.2, -0.14, 0.74, 0.8) <= 0.065 then
			return 1
		end
		if Geo.seg(u, v, 0.5, 0.56, 0.66, 0.4) <= 0.06 or Geo.seg(u, v, 0.34, 0.4, 0.5, 0.24) <= 0.06 then
			return 1
		end
		return 0
	end,
	atom = function(u, v)
		if Geo.hyp(u, v) <= 0.13 then
			return 1
		end
		for _, ang in ipairs(Geo.ATOM) do
			if math.abs(Geo.ell(u, v, ang, 0.88, 0.32) - 1) <= 0.2 then
				return 1
			end
		end
		return 0
	end,
	braces = function(u, v)
		local x = u > 0 and -u or u
		if Geo.line(x, v, Geo.BRACE) <= 0.07 then
			return 1
		end
		for _, dx in ipairs(Geo.DOTS3) do
			if Geo.hyp(u - dx, v) <= 0.055 then
				return 1
			end
		end
		return 0
	end,
	brackets = function(u, v)
		local x = u > 0 and -u or u
		if Geo.line(x, v, Geo.BRACKET) <= 0.07 then
			return 1
		end
		if Geo.seg(u, v, -0.14, 0, 0.14, 0) <= 0.06 or Geo.seg(u, v, 0, -0.14, 0, 0.14) <= 0.06 then
			return 1
		end
		return 0
	end,
	database = function(u, v)
		local x = math.abs(u)
		if v >= -0.5 and v <= 0.7 and math.abs(x - 0.62) <= 0.05 then
			return 1
		end
		if Geo.line(u, v, Geo.DB_TOP) <= 0.055 or Geo.line(u, v, Geo.DB_M1) <= 0.055
			or Geo.line(u, v, Geo.DB_M2) <= 0.055 or Geo.line(u, v, Geo.DB_BOT) <= 0.055 then
			return 1
		end
		return 0
	end,
	cloud = function(u, v)
		local d = math.min(
			Geo.hyp(u + 0.42, v - 0.12) - 0.3,
			Geo.hyp(u + 0.02, v + 0.14) - 0.42,
			Geo.hyp(u - 0.44, v - 0.12) - 0.3,
			Geo.rbox(u, v, 0.02, 0.31, 0.76, 0.17, 0.17)
		)
		if math.abs(d) <= STROKE then
			return 1
		end
		return d < 0 and 2 or 0
	end,
	wifi = function(u, v)
		local dx, dy = u, v - 0.6
		local r = Geo.hyp(dx, dy)
		if r <= 0.1 then
			return 1
		end
		if dy < 0 and -dy >= math.abs(dx) * 0.9 then
			for _, rr in ipairs(Geo.WIFI) do
				if math.abs(r - rr) <= 0.065 then
					return 1
				end
			end
		end
		return 0
	end,
	heart = function(u, v)
		if Geo.poly(u, v, Geo.HEART) <= STROKE then
			return 1
		end
		return Geo.inside(u, v, Geo.HEART) and 2 or 0
	end,
	bug = function(u, v)
		local x = math.abs(u)
		local b = Geo.hyp(u / 0.4, (v - 0.12) / 0.55)
		if math.abs(b - 1) <= 0.1 or (b < 1 and x <= 0.035) then
			return 1
		end
		if math.abs(Geo.hyp(u, v + 0.62) - 0.2) <= 0.06 then
			return 1
		end
		if Geo.seg(x, v, 0.38, -0.2, 0.8, -0.38) <= 0.055 or Geo.seg(x, v, 0.4, 0.12, 0.84, 0.12) <= 0.055
			or Geo.seg(x, v, 0.36, 0.44, 0.78, 0.62) <= 0.055 or Geo.seg(x, v, 0.1, -0.78, 0.3, -0.92) <= 0.05 then
			return 1
		end
		return 0
	end,
	branch = function(u, v)
		if Geo.seg(u, v, -0.32, -0.54, -0.32, 0.54) <= 0.065 or Geo.seg(u, v, -0.32, 0.22, 0.4, -0.2) <= 0.065 then
			return 1
		end
		for _, n in ipairs(Geo.BUG_NODES) do
			if math.abs(Geo.hyp(u - n[1], v - n[2]) - 0.17) <= 0.06 then
				return 1
			end
		end
		return 0
	end,
	pulse = function(u, v)
		return Geo.line(u, v, Geo.PULSE) <= 0.065 and 1 or 0
	end,
	eye = function(u, v)
		if math.abs(u) <= 0.92 then
			local h = 0.55 * (1 - (u / 0.92) ^ 2)
			if math.abs(math.abs(v) - h) <= 0.06 then
				return 1
			end
		end
		local r = Geo.hyp(u, v)
		if r <= 0.17 or math.abs(r - 0.34) <= 0.05 then
			return 1
		end
		return 0
	end,
	cursor = function(u, v)
		if Geo.poly(u, v, Geo.CURSOR) <= STROKE then
			return 1
		end
		return Geo.inside(u, v, Geo.CURSOR) and 2 or 0
	end,
	download = function(u, v)
		if Geo.seg(u, v, 0, -0.8, 0, 0.32) <= 0.07 or Geo.line(u, v, Geo.ARROWHEAD) <= 0.07 or Geo.line(u, v, Geo.TRAY) <= 0.065 then
			return 1
		end
		return 0
	end,
	play = function(u, v)
		if math.abs(Geo.hyp(u, v) - 0.84) <= STROKE or Geo.inside(u, v, Geo.PLAY) then
			return 1
		end
		return 0
	end,
	hash = function(u, v)
		if Geo.seg(u, v, -0.2, -0.75, -0.38, 0.75) <= 0.07 or Geo.seg(u, v, 0.38, -0.75, 0.2, 0.75) <= 0.07
			or Geo.seg(u, v, -0.7, -0.28, 0.7, -0.28) <= 0.07 or Geo.seg(u, v, -0.7, 0.28, 0.7, 0.28) <= 0.07 then
			return 1
		end
		return 0
	end,
}
local SHAPE_NAMES = {
	"roblox", "lua", "cyber", "code", "hello", "core", "shield", "lock", "bolt", "terminal", "gear", "globe", "key", "atom",
	"braces", "brackets", "database", "cloud", "wifi", "heart", "bug", "branch", "pulse", "eye", "cursor", "download", "play", "hash",
}

local function buildLogo(holder, shapeName, accent, secondary, textSize)
	local fn = Shapes[shapeName]
	local state = { alive = true, cells = {} }
	for y = 1, GRID do
		for x = 1, GRID do
			local cx, cy = x - CENTER, y - CENTER
			local fill = fn(cx / GRID_R, cy / GRID_R, cx, cy)
			if fill == 2 and (x + y) % 2 ~= 0 then
				fill = 0
			end
			if fill ~= 0 then
				local color = (math.random() < 0.6) and accent or secondary
				local label = new("TextLabel", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromScale(1 / GRID, 1 / GRID),
					Position = UDim2.fromScale(math.random(-250, -40) / 100, math.random(-40, 140) / 100),
					BackgroundTransparency = 1,
					Text = CHARS[math.random(1, #CHARS)],
					TextSize = textSize,
					Font = Enum.Font.Code,
					TextColor3 = color,
					TextTransparency = 1,
					ZIndex = 9,
				}, holder)
				state.cells[#state.cells + 1] = { label = label, color = color }
				local delay = ((x + y) / (GRID * 2)) * 0.5 + math.random() * 0.2
				tweenAfter(label, delay, 0.45 + math.random() * 0.1, {
					Position = UDim2.fromScale((x - 0.5) / GRID, (y - 0.5) / GRID),
					TextTransparency = 0,
				}, Enum.EasingStyle.Quint)
			end
		end
	end

	task.spawn(function()
		while state.alive and #state.cells > 0 do
			for _ = 1, math.clamp(math.floor(#state.cells / 40), 6, 14) do
				local c = state.cells[math.random(1, #state.cells)]
				if c.label.Parent then
					c.label.Text = CHARS[math.random(1, #CHARS)]
					c.label.TextColor3 = Color3.fromRGB(255, 255, 255)
					tween(c.label, 0.35, { TextColor3 = c.color }, Enum.EasingStyle.Sine)
				end
			end
			task.wait(0.07)
		end
	end)

	return state
end

local function dissolveLogo(state)
	if not state then
		return
	end
	state.alive = false
	for _, cell in ipairs(state.cells) do
		local pos = cell.label.Position
		tweenAfter(cell.label, math.random() * 0.2, 0.5, {
			Position = UDim2.fromScale(pos.X.Scale + math.random(150, 300) / 100, pos.Y.Scale + math.random(-20, 20) / 100),
			TextTransparency = 1,
		}, Enum.EasingStyle.Quad)
	end
	task.delay(1, function()
		for _, cell in ipairs(state.cells) do
			if cell.label.Parent then
				cell.label:Destroy()
			end
		end
	end)
end

	return {
		Build = buildLogo,
		Dissolve = dissolveLogo,
		Names = SHAPE_NAMES,
	}
end
