-- Scripting404 | Logo-code.lua
-- Dipanggil oleh KeySystem lewat loadstring(...). Mengembalikan fungsi yang menerima context
-- (new, tween, tweenAfter, loopTween, GRID, CENTER, GRID_R, STROKE, CHARS) lalu mengembalikan
-- tabel { Build, Dissolve, Names }.
--   Build(holder, shapeName, accent, secondary, textSize) -> state
--   Dissolve(state)

return function(ctx)
	ctx = ctx or {}
	local GRID = ctx.GRID or 41
	local CENTER = ctx.CENTER or 21
	local GRID_R = ctx.GRID_R or 20
	local STROKE = ctx.STROKE or 0.055
	local CHARS = ctx.CHARS or { "0", "1", "{", "}", "<", ">", "/", ";", "#" }
	local FORM = 1.2

	local function create(class, props, parent)
		if ctx.new then
			return ctx.new(class, props, parent)
		end
		local inst = Instance.new(class)
		for k, v in pairs(props) do
			inst[k] = v
		end
		inst.Parent = parent
		return inst
	end

	local function randomChar()
		return CHARS[math.random(1, #CHARS)]
	end

	-- ===== Shapes: signed distance in normalized space (-1..1), negative = inside =====
	local function polygon(n, rotation, radius)
		local pts = {}
		for i = 0, n - 1 do
			local a = rotation + (i / n) * math.pi * 2
			pts[#pts + 1] = { math.cos(a) * radius, math.sin(a) * radius }
		end
		local edges = {}
		for i = 1, n do
			local a, b = pts[i], pts[i % n + 1]
			local dx, dy = b[1] - a[1], b[2] - a[2]
			local len = math.sqrt(dx * dx + dy * dy)
			edges[i] = { a = a, nx = dy / len, ny = -dx / len }
		end
		return function(u, v)
			local d = -math.huge
			for _, e in ipairs(edges) do
				local s = (u - e.a[1]) * e.nx + (v - e.a[2]) * e.ny
				if s > d then
					d = s
				end
			end
			return d
		end
	end

	local function box(hw, hh)
		return function(u, v)
			return math.max(math.abs(u) - hw, math.abs(v) - hh)
		end
	end

	local crossA, crossB = box(0.95, 0.3), box(0.3, 0.95)

	local SHAPES = {
		Circle = function(u, v)
			return math.sqrt(u * u + v * v) - 0.95
		end,
		Ring = function(u, v)
			local r = math.sqrt(u * u + v * v)
			return math.min(math.abs(r - 0.95), math.abs(r - 0.72)) - 0.001
		end,
		Square = box(0.82, 0.82),
		Diamond = function(u, v)
			return math.abs(u) + math.abs(v) - 1.0
		end,
		Triangle = polygon(3, -math.pi / 2, 0.98),
		Pentagon = polygon(5, -math.pi / 2, 0.98),
		Hexagon = polygon(6, 0, 0.98),
		Octagon = polygon(8, math.pi / 8, 0.98),
		Cross = function(u, v)
			return math.min(crossA(u, v), crossB(u, v))
		end,
	}

	local NAMES = { "Circle", "Hexagon", "Diamond", "Triangle", "Square", "Octagon", "Pentagon", "Ring", "Cross" }

	-- ===== Center "404" (3x5 pixel font) =====
	local GLYPH = {
		["4"] = { "101", "101", "111", "001", "001" },
		["0"] = { "111", "101", "101", "101", "111" },
	}
	local TEXT = "404"

	local function textCells()
		local map = {}
		local startX = -math.floor((#TEXT * 4 - 1) / 2)
		for i = 1, #TEXT do
			local rows = GLYPH[TEXT:sub(i, i)]
			local ox = startX + (i - 1) * 4
			for r = 1, 5 do
				for c = 1, 3 do
					if rows[r]:sub(c, c) == "1" then
						map[(CENTER + ox + c - 1) .. "," .. (CENTER + r - 3)] = true
					end
				end
			end
		end
		return map
	end

	local function ease(t)
		return 1 - (1 - t) ^ 3
	end

	local Logo = { Names = NAMES, Shapes = SHAPES }

	function Logo.Build(holder, shapeName, accent, secondary, textSize)
		local sdf = SHAPES[shapeName] or SHAPES.Circle
		accent = accent or Color3.fromRGB(238, 240, 246)
		secondary = secondary or Color3.fromRGB(128, 134, 148)
		textSize = textSize or 8

		local root = create("Frame", {
			Name = "LogoShape",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 7,
		}, holder)

		local text = textCells()
		local cells = {}

		local function addCell(gx, gy, kind)
			local final = kind == "text" and "#" or randomChar()
			local dx, dy = gx - CENTER, gy - CENTER
			local dist = math.sqrt(dx * dx + dy * dy) / GRID_R
			local label = create("TextLabel", {
				Position = UDim2.fromScale((gx - 1) / GRID, (gy - 1) / GRID),
				Size = UDim2.fromScale(1 / GRID, 1 / GRID),
				BackgroundTransparency = 1,
				Text = "",
				Font = Enum.Font.Code,
				TextSize = textSize,
				TextColor3 = kind == "fill" and secondary or accent,
				TextTransparency = 1,
				ZIndex = 7,
			}, root)
			cells[#cells + 1] = {
				label = label,
				kind = kind,
				final = final,
				target = kind == "outline" and 0 or (kind == "text" and 0.05 or 0.8),
				delay = (kind == "text" and 0.35 or 0) + dist * FORM * 0.45 + math.random() * 0.2,
				done = false,
			}
		end

		for gy = 1, GRID do
			for gx = 1, GRID do
				local key = gx .. "," .. gy
				if text[key] then
					addCell(gx, gy, "text")
				else
					local u, v = (gx - CENTER) / GRID_R, (gy - CENTER) / GRID_R
					local d = sdf(u, v)
					local inTextBox = math.abs(gx - CENTER) <= 6 and math.abs(gy - CENTER) <= 3
					if math.abs(d) <= STROKE then
						if not inTextBox then
							addCell(gx, gy, "outline")
						end
					elseif d < -STROKE - 0.06 and not inTextBox and math.random() < 0.1 then
						addCell(gx, gy, "fill")
					end
				end
			end
		end

		local state = { root = root, cells = cells, alive = true }

		task.spawn(function()
			local t0 = os.clock()
			local nextFlicker = 0
			while state.alive and root.Parent do
				local t = os.clock() - t0
				for _, c in ipairs(cells) do
					if not c.done then
						local p = (t - c.delay) / 0.35
						if p >= 1 then
							c.done = true
							c.label.Text = c.final
							c.label.TextTransparency = c.target
						elseif p > 0 then
							c.label.Text = randomChar()
							c.label.TextTransparency = 1 - (1 - c.target) * ease(p)
						end
					end
				end
				if t > FORM + 0.4 and t >= nextFlicker then
					nextFlicker = t + 0.07
					for _ = 1, 4 do
						local c = cells[math.random(1, #cells)]
						if c.kind ~= "text" and c.done then
							c.label.Text = randomChar()
						end
					end
				end
				task.wait(1 / 30)
			end
		end)

		return state
	end

	function Logo.Dissolve(state)
		if type(state) ~= "table" or not state.alive then
			return
		end
		state.alive = false
		local root, cells = state.root, state.cells
		if not root or not root.Parent then
			return
		end
		task.spawn(function()
			local t0 = os.clock()
			local span = 0.4
			for _, c in ipairs(cells) do
				c.out = math.random() * 0.2
			end
			while os.clock() - t0 < span + 0.2 and root.Parent do
				local t = os.clock() - t0
				for _, c in ipairs(cells) do
					local p = math.clamp((t - c.out) / 0.2, 0, 1)
					if p > 0 then
						c.label.Text = randomChar()
						c.label.TextTransparency = c.label.TextTransparency + (1 - c.label.TextTransparency) * p
					end
				end
				task.wait(1 / 30)
			end
			if root.Parent then
				root:Destroy()
			end
		end)
	end

	return Logo
end
