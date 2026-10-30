do
	local Constant = 'L'..'P'..'H'..'_NO_VIRTUALIZE';
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end;
end;
cloneref = cloneref or function(i) return i end;
gethui = gethui or get_hidden_gui;
getcustomasset = getcustomasset or getsynasset;
getgenv = getgenv or getfenv;
local LOAD_ENV = LPH_NO_VIRTUALIZE(function()
	if game:GetService('RunService'):IsStudio() then
		local BaseWorkspace = game:GetService("ReplicatedFirst"):FindFirstChild('PRI_WORKSPACE') or Instance.new('Folder',game:GetService("ReplicatedFirst"));
		BaseWorkspace.Name = 'PRI\0.'..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));
		local __get_path_c = function(path)
			return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
		end;
		local __get_path = function(path)
			local main = __get_path_c(path);
			local block = BaseWorkspace;
			for i,v in next , main do
				block = block[v];
			end;
			return block;
		end;
		getgenv().readfile = function(path)
			local path  = __get_path(path);
			return path.Value;
		end;
		getgenv().isfile = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);
			if success and not message:IsA("Folder") then
				return true;
			end;
			return false;
		end;
		getgenv().isfolder = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);
			if success and message:IsA("Folder") then
				return true;
			end;
			return false;
		end;
		getgenv().writefile = function(path,content)
			local main = __get_path_c(path);
			local block = BaseWorkspace;
			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('StringValue',block);
					c.Name = tostring(v);
					c.Value = content;
				else
					if item:IsA('StringValue') and tostring(item) == v then
						item.Name = tostring(v);
						item.Value = content;
					end;
					block = item;
				end;
			end;
		end;
		getgenv().listfiles = function(path)
			local fold = __get_path(path);
			local pa = {};
			for i,v in next , fold:GetChildren() do
				if v:IsA('StringValue') then
					table.insert(pa,path..'/'..tostring(v));
				end;
			end;
			return pa;
		end;
		getgenv().makefolder = function(path)
			local main = __get_path_c(path);
			local block = BaseWorkspace;
			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('Folder',block);
					c.Name = tostring(v);
				else
					block = item;
				end;
			end;
		end;
		getgenv().delfile = function(path)
			local main = __get_path_c(path);
			local block = BaseWorkspace;
			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if item and item:IsA('StringValue') then
					item:Destroy();
				else
					block = item;
				end;
			end;
		end;
	end;
end)
LOAD_ENV();
writefile = writefile or getgenv().writefile;
makefolder = makefolder or getgenv().makefolder;
readfile = readfile or getgenv().readfile;
delfolder = delfolder or getgenv().delfolder;
delfile = delfile or getgenv().delfile;
listfiles = listfiles or getgenv().listfiles;
isfolder = isfolder or getgenv().isfolder;
isfile = isfile or getgenv().isfile;
local NeverloseUI = {};
NeverloseUI.BuiltInRegular = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal);
NeverloseUI.BuiltInBold = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal);
NeverloseUI.GlobalSignals = {};
NeverloseUI.UnloadEnabled = false;
local cloneref = cloneref or function(f) return f end;
local TweenService = cloneref(game:GetService('TweenService'));
local UserInputService = cloneref(game:GetService('UserInputService'));
local TextService = cloneref(game:GetService('TextService'));
local RunService = cloneref(game:GetService('RunService'));
local Players = cloneref(game:GetService('Players'));
local HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer = Players.LocalPlayer;
local CoreGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or cloneref(game:FindFirstChild('CoreGui')) or cloneref(LocalPlayer.PlayerGui);
local Mouse = LocalPlayer:GetMouse();
local CurrentCamera = cloneref(workspace.CurrentCamera);
local ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end;
local GlobalWindow = Instance.new('ScreenGui');
local ManualTween = TweenInfo.new(0.1);
local SlowyTween = TweenInfo.new(0.175);
local FastTween = TweenInfo.new(0.05);
local VSlowTween = TweenInfo.new(0.5,Enum.EasingStyle.Quint);
local Encryption = {};
NeverloseUI.UserProfile = Players:GetUserThumbnailAsync(LocalPlayer.UserId , Enum.ThumbnailType.HeadShot , Enum.ThumbnailSize.Size150x150)
NeverloseUI.RandomString = LPH_NO_VIRTUALIZE(function()
	return string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4));
end);
ProtectGui(GlobalWindow);
GlobalWindow.Name = NeverloseUI.RandomString();
GlobalWindow.IgnoreGuiInset = true;
GlobalWindow.ZIndexBehavior = Enum.ZIndexBehavior.Global;
GlobalWindow.ResetOnSpawn = false;
GlobalWindow.Parent = CoreGui;
NeverloseUI.Scales = {
	Small = UDim2.fromOffset(540,380),
	Compact = UDim2.fromOffset(600,380),
	Mobile = UDim2.fromOffset(640,385),
	Default = UDim2.fromOffset(640 , 480),
	Large = UDim2.fromOffset(800 , 600)
};
NeverloseUI.IconColor = Color3.fromRGB(255, 255, 255);
NeverloseUI.ScreenGui = GlobalWindow;
NeverloseUI.Flags = {};
NeverloseUI.PendingFlagValues = {};
NeverloseUI.AccentColor = Color3.fromRGB(3, 169, 244);
NeverloseUI.MainColor = Color3.fromRGB(7, 10, 16);
NeverloseUI.BrandName = "NeverloseUI";
NeverloseUI.DragTilt = false;
NeverloseUI.DragMaxTilt = 4;
NeverloseUI.TiltHideContent = true;
NeverloseUI.BorderEnabled = true;
NeverloseUI.BorderColor = nil;
NeverloseUI.BorderColor2 = nil;
NeverloseUI.BorderClarity = 1;
NeverloseUI.BorderThickness = 2;
NeverloseUI.BorderSpeed = 90;
NeverloseUI.SpinBorders = {};
NeverloseUI.DragSmoothness = 60;
NeverloseUI.MobileScale = 0.72;
NeverloseUI.RegisiteryColor = {};
NeverloseUI.NameRegisitry = {};
NeverloseUI.SectionOwners = {};
NeverloseUI.IsMosueOverOtherFrame = false;
NeverloseUI.TextGradientEnabled = true;
NeverloseUI.TextGradientAnimationTime = 0;
NeverloseUI.TextGradientAccumulator = 0;
NeverloseUI.TextGradientLabels = {};
NeverloseUI.TextGradientObjects = {};
NeverloseUI.GlobalLogo = "rbxassetid://120358385035996";
NeverloseUI.ImageColorMapping = "rbxassetid://4155801252";
NeverloseUI.IconBase = "https://raw.githubusercontent.com/nhfudzfsrzggt/brigida/refs/heads/main/";
NeverloseUI.Icons = {};
NeverloseUI.IconScale = 0.82;
NeverloseUI.Font = nil;
NeverloseUI.FontFace = nil;
NeverloseUI.IconAliases = {
	["lucide:table-of-contents"] = "list-bulleted",
	["lucide:toggle-right"] = "two-switches-horizontal",
	["lucide:mouse"] = "mouse-button-left",
	["lucide:chevrons-left-right-ellipsis"] = "dual-arrows-horizontal",
	["lucide:list-collapse"] = "list-bulleted",
	["lucide:palette"] = "paint-brush",
	["lucide:sliders-horizontal"] = "three-sliders-horizontal",
	["lucide:keyboard"] = "key",
	["lucide:layout-grid"] = "grid",
	["lucide:bell"] = "bell",
	["lucide:message-circle"] = "speech-bubble-round",
	["lucide:circle-info"] = "circle-i",
	["lucide:check"] = "check",
	["lucide:circle-alert"] = "triangle-exclamation",
	["lucide:house"] = "house",
};
NeverloseUI.IconLibraryLoaded = false;
NeverloseUI.IconLibraryLoading = false;
NeverloseUI.IconSystem = nil;
function NeverloseUI:NormalizeIconId(iconId)
	if not iconId or iconId == "" then
		return "";
	end;
	iconId = tostring(iconId);
	if string.match(iconId, "^%d+$") then
		return "rbxassetid://" .. iconId;
	end;
	if string.find(iconId, "rbxassetid://", 1, true)
	or string.find(iconId, "rbxasset://", 1, true)
	or string.match(iconId, "^https?://") then
		return iconId;
	end;
	return iconId;
end;
function NeverloseUI:LoadIconLibrary()
	if NeverloseUI.IconLibraryLoaded then
		return NeverloseUI.Icons;
	end;
	if NeverloseUI.IconLibraryLoading then
		repeat task.wait() until not NeverloseUI.IconLibraryLoading;
		return NeverloseUI.Icons;
	end;
	NeverloseUI.IconLibraryLoading = true;
	local function Load(path)
		local success, result = pcall(function()
			return loadstring(game:HttpGet(NeverloseUI.IconBase .. path))();
		end);
		if success and typeof(result) == "table" then
			return result;
		end;
		return {};
	end;
	local defaultIcons = Load("src/elements/icon/basic.lua");
	local lucideIcons = Load("src/elements/icon/lucide.lua");
	local solarIcons = Load("src/elements/icon/solar.lua");
	for name, id in pairs(defaultIcons) do
		NeverloseUI.Icons[name] = NeverloseUI:NormalizeIconId(id);
	end;
	for name, id in pairs(lucideIcons) do
		NeverloseUI.Icons["lucide:" .. name] = NeverloseUI:NormalizeIconId(id);
	end;
	for name, id in pairs(solarIcons) do
		NeverloseUI.Icons["solar:" .. name] = NeverloseUI:NormalizeIconId(id);
	end;
	NeverloseUI.IconLibraryLoaded = true;
	NeverloseUI.IconLibraryLoading = false;
	NeverloseUI.IconSystem = {
		Icons = NeverloseUI.Icons,
		getIconId = function(iconName)
			return NeverloseUI:GetIconId(iconName);
		end,
	};
	return NeverloseUI.Icons;
end;
NeverloseUI.IconsV2Url = "https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua";
NeverloseUI.IconsV2 = nil;
NeverloseUI.IconsV2Loaded = false;
NeverloseUI.IconsV2Loading = false;
NeverloseUI.IconsType = "lucide";
NeverloseUI.IconProviders = {};
NeverloseUI.IconCache = {};
NeverloseUI.IconMiss = {};
NeverloseUI.IconPrefixes = { "lucide", "solar", "craft", "geist", "sfsymbols", "gravity-ui", "gravityui", "gravity" };
function NeverloseUI:IsLibraryIcon(Name)
	local Prefix = string.match(string.lower(tostring(Name or "")), "^([%w%-_]+):");
	if not Prefix then
		return false;
	end;
	for _, Known in ipairs(NeverloseUI.IconPrefixes) do
		if Known == Prefix then
			return true;
		end;
	end;
	return false;
end;
function NeverloseUI:LoadIconsV2(Force)
	if NeverloseUI.IconsV2Loaded and not Force then
		return NeverloseUI.IconsV2;
	end;
	if NeverloseUI.IconsV2Loading then
		repeat task.wait() until not NeverloseUI.IconsV2Loading;
		return NeverloseUI.IconsV2;
	end;
	NeverloseUI.IconsV2Loading = true;
	local Ok, Library = pcall(function()
		local Source;
		local Fetched, Body = pcall(function()
			return game:HttpGet(NeverloseUI.IconsV2Url);
		end);
		if Fetched and type(Body) == "string" and Body ~= "" then
			Source = Body;
		else
			Source = game:HttpGetAsync(NeverloseUI.IconsV2Url);
		end;
		return loadstring(Source)();
	end);
	if Ok and typeof(Library) == "table" then
		NeverloseUI.IconsV2 = Library;
		if type(Library.SetIconsType) == "function" then
			pcall(Library.SetIconsType, NeverloseUI.IconsType);
		end;
		if Force then
			NeverloseUI.IconMiss = {};
		end;
	end;
	NeverloseUI.IconsV2Loaded = true;
	NeverloseUI.IconsV2Loading = false;
	return NeverloseUI.IconsV2;
end;
function NeverloseUI:GetIconsV2()
	return NeverloseUI:LoadIconsV2();
end;
function NeverloseUI:SetIconsType(IconType)
	NeverloseUI.IconsType = tostring(IconType or "lucide");
	NeverloseUI.IconCache = {};
	NeverloseUI.IconMiss = {};
	local Library = NeverloseUI.IconsV2;
	if Library and type(Library.SetIconsType) == "function" then
		pcall(Library.SetIconsType, NeverloseUI.IconsType);
	end;
	return NeverloseUI;
end;
NeverloseUI.IconProviders[1] = {
	Name = "IconsV2",
	Resolve = function(Name)
		local Library = NeverloseUI:LoadIconsV2();
		if not Library or type(Library.GetIcon) ~= "function" then
			return nil;
		end;
		local Ok, Result = pcall(Library.GetIcon, Name);
		if not Ok then
			return nil;
		end;
		if type(Result) == "table" then
			Result = Result.Image or Result.Id or Result[1];
		end;
		if type(Result) == "number" then
			Result = tostring(Result);
		end;
		if type(Result) == "string" and Result ~= "" then
			return Result;
		end;
		return nil;
	end,
};
function NeverloseUI:AddIconProvider(Name, Resolve)
	if type(Resolve) ~= "function" then
		return NeverloseUI;
	end;
	NeverloseUI:RemoveIconProvider(Name);
	table.insert(NeverloseUI.IconProviders, { Name = tostring(Name), Resolve = Resolve });
	NeverloseUI.IconMiss = {};
	return NeverloseUI;
end;
function NeverloseUI:RemoveIconProvider(Name)
	for Index = #NeverloseUI.IconProviders, 1, -1 do
		if NeverloseUI.IconProviders[Index].Name == tostring(Name) then
			table.remove(NeverloseUI.IconProviders, Index);
			NeverloseUI.IconMiss = {};
		end;
	end;
	return NeverloseUI;
end;
function NeverloseUI:ResolveIconFromProviders(IconName)
	local Cached = NeverloseUI.IconCache[IconName];
	if Cached then
		return Cached;
	end;
	if NeverloseUI.IconMiss[IconName] then
		return "";
	end;
	for _, Provider in ipairs(NeverloseUI.IconProviders) do
		local Ok, Result = pcall(Provider.Resolve, IconName);
		if Ok and type(Result) == "string" and Result ~= "" then
			Result = NeverloseUI:NormalizeIconId(Result);
			NeverloseUI.IconCache[IconName] = Result;
			return Result;
		end;
	end;
	NeverloseUI.IconMiss[IconName] = true;
	return "";
end;
function NeverloseUI:GetIconId(iconName)
	if not iconName or iconName == "" then
		return "";
	end;
	iconName = tostring(iconName);
	local DirectIcon = NeverloseUI:NormalizeIconId(iconName);
	if DirectIcon ~= iconName
	or string.find(DirectIcon, "rbxassetid://", 1, true)
	or string.find(DirectIcon, "rbxasset://", 1, true)
	or string.match(DirectIcon, "^https?://") then
		return DirectIcon;
	end;
	if not NeverloseUI.IconLibraryLoaded then
		NeverloseUI:LoadIconLibrary();
	end;
	if NeverloseUI.Icons[iconName] then
		return NeverloseUI:NormalizeIconId(NeverloseUI.Icons[iconName]);
	end;
	return NeverloseUI:ResolveIconFromProviders(iconName);
end;
function NeverloseUI:GetIcon(iconName)
	return NeverloseUI:GetIconId(iconName);
end;
function NeverloseUI:IsWebmIcon(iconName)
	if not iconName or iconName == "" then
		return false;
	end;
	iconName = string.lower(tostring(iconName));
	return string.sub(iconName, 1, 5) == "webm:"
		or string.match(iconName, "%.webm$") ~= nil
		or string.match(iconName, "%.webm%?") ~= nil
		or string.match(iconName, "%.webm#") ~= nil;
end;
function NeverloseUI:NormalizeVideoIcon(iconName)
	iconName = tostring(iconName or "");
	if string.sub(string.lower(iconName), 1, 5) == "webm:" then
		iconName = string.sub(iconName, 6);
	end;
	return NeverloseUI:NormalizeIconId(iconName);
end;
function NeverloseUI:ClearIconVideo(IconObject)
	local VideoIcon = IconObject and IconObject:FindFirstChild("ModernIconVideo");
	if VideoIcon then
		pcall(function()
			VideoIcon:Pause();
		end);
		VideoIcon.Visible = false;
		VideoIcon.Video = "";
	end;
end;
function NeverloseUI:ApplyIconVideo(IconObject, IconSource)
	if not IconObject then
		return nil;
	end;
	local VideoIcon = IconObject:FindFirstChild("ModernIconVideo");
	if not VideoIcon then
		VideoIcon = Instance.new("VideoFrame");
		VideoIcon.Name = "ModernIconVideo";
		VideoIcon.Parent = IconObject;
		VideoIcon.AnchorPoint = Vector2.new(0.5, 0.5);
		VideoIcon.BackgroundTransparency = 1;
		VideoIcon.BorderSizePixel = 0;
		VideoIcon.Position = UDim2.fromScale(0.5, 0.5);
		VideoIcon.Size = UDim2.fromScale(1, 1);
		VideoIcon.ZIndex = IconObject.ZIndex + 1;
		VideoIcon.Volume = NeverloseUI.IconVideoVolume or 0;
		VideoIcon.Visible = true;
		NeverloseUI:AddSignal(VideoIcon.Ended:Connect(function()
			VideoIcon.TimePosition = 0;
			VideoIcon:Play();
		end));
	end;
	if not IconObject:GetAttribute("ModernIconVideoBound") then
		IconObject:SetAttribute("ModernIconVideoBound", true);
		NeverloseUI:AddSignal(IconObject:GetPropertyChangedSignal("ZIndex"):Connect(function()
			local ChildVideo = IconObject:FindFirstChild("ModernIconVideo");
			if ChildVideo then
				ChildVideo.ZIndex = IconObject.ZIndex + 1;
			end;
		end));
		if IconObject:IsA("ImageLabel") or IconObject:IsA("ImageButton") then
			NeverloseUI:AddSignal(IconObject:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
				local ChildVideo = IconObject:FindFirstChild("ModernIconVideo");
				if ChildVideo then
					ChildVideo.Visible = IconObject.ImageTransparency < 0.99;
				end;
			end));
		end;
	end;
	VideoIcon.Video = NeverloseUI:NormalizeVideoIcon(IconSource);
	VideoIcon.Volume = NeverloseUI.IconVideoVolume or 0;
	VideoIcon.Visible = true;
	VideoIcon:SetAttribute("_isWebm", true);
	pcall(function()
		VideoIcon:Play();
	end);
	return VideoIcon;
end;
NeverloseUI.IconSystem = {
	Icons = NeverloseUI.Icons,
	getIconId = function(iconName)
		return NeverloseUI:GetIconId(iconName);
	end,
};
task.spawn(function()
	pcall(function()
		NeverloseUI:LoadIconLibrary();
	end);
	pcall(function()
		NeverloseUI:LoadIconsV2();
	end);
end);
NeverloseUI.Themes = {};
NeverloseUI.ThemeCallbacks = {};
function NeverloseUI:OnThemeChanged(fn)
	table.insert(NeverloseUI.ThemeCallbacks, fn);
end;
local function _ApplyTheme(theme)
	NeverloseUI.CurrentTheme = theme;
	NeverloseUI.AccentColor  = theme.Accent      or NeverloseUI.AccentColor;
	NeverloseUI.MainColor    = theme.Background  or NeverloseUI.MainColor;
	NeverloseUI.IconColor    = theme.Icon        or NeverloseUI.IconColor;
	for _, fn in next, NeverloseUI.ThemeCallbacks do
		pcall(fn, theme);
	end;
	if NeverloseUI.SetTextGradientEnabled then
		NeverloseUI:SetTextGradientEnabled(NeverloseUI.TextGradientEnabled);
	end;
end;
function NeverloseUI:GetTheme()
	return NeverloseUI.CurrentTheme or {
		Name        = "Default",
		Accent      = NeverloseUI.AccentColor,
		Background  = NeverloseUI.MainColor,
		Surface     = Color3.fromRGB(20,22,27),
		Outline     = Color3.fromRGB(45,48,58),
		Text        = Color3.fromRGB(255,255,255),
		Placeholder = Color3.fromRGB(140,140,155),
		Button      = NeverloseUI.AccentColor,
		Icon        = NeverloseUI.IconColor,
	};
end;
function NeverloseUI:BindTheme(Object, Map)
	if typeof(Object) ~= "Instance" or type(Map) ~= "table" then
		return Object;
	end;
	local Dead = false;
	local function Apply(Theme)
		if Dead then
			return;
		end;
		for Property, Role in next, Map do
			local Color = Theme[Role];
			if Color ~= nil then
				pcall(function()
					Object[Property] = Color;
				end);
			end;
		end;
	end;
	Object.Destroying:Connect(function()
		Dead = true;
	end);
	Apply(NeverloseUI:GetTheme());
	NeverloseUI:OnThemeChanged(Apply);
	return Object;
end;
function NeverloseUI:AddTheme(Config)
	Config = Config or {};
	Config.Name = Config.Name or "Custom Theme";
	local theme = {
		Name        = Config.Name,
		Accent      = Config.Accent      or NeverloseUI.AccentColor,
		Background  = Config.Background  or NeverloseUI.MainColor,
		Surface     = Config.Surface     or Color3.fromRGB(20,22,27),
		Outline     = Config.Outline     or Color3.fromRGB(45,48,58),
		Text        = Config.Text        or Color3.fromRGB(255,255,255),
		Placeholder = Config.Placeholder or Color3.fromRGB(140,140,155),
		Button      = Config.Button      or NeverloseUI.AccentColor,
		Icon        = Config.Icon        or NeverloseUI.IconColor,
	};
	table.insert(NeverloseUI.Themes, theme);
	_ApplyTheme(theme);
	return theme;
end;
NeverloseUI.SaveRoot = "NeverloseUI";
NeverloseUI.AutoSavePath = "NeverloseUI/AutoSave.json";
NeverloseUI.UISettingsPath = "NeverloseUI/UISettings.json";
NeverloseUI.UISettings = {};
NeverloseUI.UISettingsLoaded = false;
function NeverloseUI:_ReadJson(Path)
	local Ok, Result = pcall(function()
		if isfile and isfile(Path) then
			return HttpService:JSONDecode(readfile(Path));
		end;
		return nil;
	end);
	if Ok and type(Result) == "table" then
		return Result;
	end;
	return nil;
end;
function NeverloseUI:_WriteJson(Path, Data)
	return pcall(function()
		if isfolder and makefolder and not isfolder(NeverloseUI.SaveRoot) then
			makefolder(NeverloseUI.SaveRoot);
		end;
		writefile(Path, HttpService:JSONEncode(Data));
	end);
end;
function NeverloseUI:ReadAutoSave(Key)
	local Store = NeverloseUI:_ReadJson(NeverloseUI.AutoSavePath);
	if Store and type(Store.Scripts) == "table" then
		local Entry = Store.Scripts[Key];
		if type(Entry) == "table" and type(Entry.Data) == "string" then
			return Entry.Data;
		end;
	end;
	return nil;
end;
function NeverloseUI:WriteAutoSave(Key, Data)
	local Store = NeverloseUI:_ReadJson(NeverloseUI.AutoSavePath) or {};
	if type(Store.Scripts) ~= "table" then
		Store.Scripts = {};
	end;
	Store.Version = 1;
	Store.Scripts[Key] = {
		Data = Data,
		Updated = os.time(),
	};
	return NeverloseUI:_WriteJson(NeverloseUI.AutoSavePath, Store);
end;
function NeverloseUI:LoadUISettings()
	if not NeverloseUI.UISettingsLoaded then
		NeverloseUI.UISettingsLoaded = true;
		local Data = NeverloseUI:_ReadJson(NeverloseUI.UISettingsPath);
		if Data then
			NeverloseUI.UISettings = Data;
		end;
	end;
	return NeverloseUI.UISettings;
end;
function NeverloseUI:SetUISetting(Key, Value)
	if Value == nil then
		return;
	end;
	if typeof(Value) == "Color3" then
		Value = "#" .. Value:ToHex();
	end;
	NeverloseUI.UISettings[Key] = Value;
	if NeverloseUI._UISettingsSaveQueued then
		return;
	end;
	NeverloseUI._UISettingsSaveQueued = true;
	task.delay(0.75, function()
		NeverloseUI._UISettingsSaveQueued = false;
		NeverloseUI:_WriteJson(NeverloseUI.UISettingsPath, NeverloseUI.UISettings);
	end);
end;
function NeverloseUI:GetUISetting(Key, Default)
	local Value = NeverloseUI.UISettings[Key];
	if Value == nil then
		return Default;
	end;
	return Value;
end;
function NeverloseUI:GetUIColor(Key)
	local Value = NeverloseUI.UISettings[Key];
	if type(Value) == "string" then
		local Ok, Color = pcall(Color3.fromHex, Value);
		if Ok then
			return Color;
		end;
	end;
	return nil;
end;
function NeverloseUI:ApplyUISettings(Window)
	local S = NeverloseUI:LoadUISettings();
	local Fresh = next(S) == nil;
	if S.BackgroundOpacity ~= nil then
		Window:SetBackgroundOpacity(tonumber(S.BackgroundOpacity));
	end;
	if type(S.BackgroundImage) == "string" and S.BackgroundImage ~= "" then
		Window:SetBackground(S.BackgroundImage);
	end;
	if type(S.Keybind) == "string" and S.Keybind ~= "" then
		Window.Keybind = S.Keybind;
	end;
	if S.AutoSave ~= nil then
		Window.ConfigAutoSave = S.AutoSave == true;
	end;
	if tonumber(S.DragSmoothness) then
		NeverloseUI.DragSmoothness = math.clamp(tonumber(S.DragSmoothness), 0, 100);
	end;
	if tonumber(S.MobileScale) then
		NeverloseUI.MobileScale = math.clamp(tonumber(S.MobileScale), 0.4, 1);
		if Window.UpdateFitScale then
			Window:UpdateFitScale(false);
		end;
	end;
	local Scale = S.MenuScale;
	if type(Scale) == "string" and Scale ~= "Mobile" and NeverloseUI.Scales[Scale] then
		task.defer(function()
			pcall(function()
				Window:SetSize(NeverloseUI.Scales[Scale]);
			end);
		end);
	end;
	if Fresh then
		NeverloseUI:SetUISetting("MenuScale", "Mobile");
		NeverloseUI:SetUISetting("AutoSave", Window.ConfigAutoSave == true);
		NeverloseUI:SetUISetting("BackgroundOpacity", Window.BackgroundImageOpacity);
		NeverloseUI:SetUISetting("BackgroundImage", "");
	end;
end;
function NeverloseUI:SetTilt(Settings)
	if type(Settings) == "boolean" then
		Settings = { Enabled = Settings };
	end;
	if type(Settings) ~= "table" then
		return NeverloseUI;
	end;
	if Settings.Enabled ~= nil then
		NeverloseUI.DragTilt = Settings.Enabled == true;
	end;
	local Max = Settings.Max or Settings.MaxTilt;
	if Max ~= nil then
		NeverloseUI.DragMaxTilt = math.clamp(tonumber(Max) or 4, 0, 10);
	end;
	local Hide = Settings.HideContent;
	if Hide ~= nil then
		NeverloseUI.TiltHideContent = Hide == true;
	end;
	return NeverloseUI;
end;
function NeverloseUI:SetInterface(Settings)
	if type(Settings) ~= "table" then
		return NeverloseUI;
	end;
	if Settings.TextGradient ~= nil then
		NeverloseUI:SetTextGradientEnabled(Settings.TextGradient == true);
	end;
	if typeof(Settings.AccentColor) == "Color3" then
		NeverloseUI:AddTheme({
			Name = "Custom Accent",
			Accent = Settings.AccentColor,
			Button = Settings.AccentColor,
		});
	end;
	return NeverloseUI;
end;
function NeverloseUI:_ApplyBorder(Border)
	if not Border or not Border.Stroke or not Border.Stroke.Parent then
		return;
	end;
	local Clarity = math.clamp(tonumber(Border.Clarity or NeverloseUI.BorderClarity) or 1, 0, 1);
	local Main = Border.Color or NeverloseUI.BorderColor or NeverloseUI._ThemeAccent or NeverloseUI.AccentColor;
	local Second = Border.Color2 or NeverloseUI.BorderColor2 or Main:Lerp(Color3.new(1, 1, 1), 0.55);
	local Enabled = Border.Enabled;
	if Enabled == nil then
		Enabled = NeverloseUI.BorderEnabled;
	end;
	local Peak = 1 - Clarity;
	local Base = 1 - (Clarity * 0.45);
	Border.Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Main),
		ColorSequenceKeypoint.new(0.3, Main),
		ColorSequenceKeypoint.new(0.5, Second),
		ColorSequenceKeypoint.new(0.7, Main),
		ColorSequenceKeypoint.new(1, Main),
	});
	Border.Gradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, Base),
		NumberSequenceKeypoint.new(0.3, Base),
		NumberSequenceKeypoint.new(0.5, Peak),
		NumberSequenceKeypoint.new(0.7, Base),
		NumberSequenceKeypoint.new(1, Base),
	});
	Border.Stroke.Thickness = tonumber(Border.Thickness or NeverloseUI.BorderThickness) or 2;
	Border.Stroke.Enabled = Enabled ~= false;
end;
function NeverloseUI:CreateSpinBorder(Parent, Cfg)
	Cfg = Cfg or {};
	local Stroke = Instance.new("UIStroke");
	Stroke.Name = NeverloseUI.RandomString();
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	Stroke.Color = Color3.fromRGB(255, 255, 255);
	Stroke.Transparency = Cfg.Transparency or 0;
	Stroke.Parent = Parent;
	local Gradient = Instance.new("UIGradient");
	Gradient.Rotation = 0;
	Gradient.Parent = Stroke;
	local Border = {
		Stroke = Stroke,
		Gradient = Gradient,
		Color = Cfg.Color,
		Color2 = Cfg.Color2,
		Clarity = Cfg.Clarity,
		Thickness = Cfg.Thickness,
		Speed = Cfg.Speed,
		Enabled = Cfg.Enabled,
	};
	function Border:Refresh()
		NeverloseUI:_ApplyBorder(Border);
		return Border;
	end;
	function Border:SetColor(c) Border.Color = c; return Border:Refresh(); end;
	function Border:SetColor2(c) Border.Color2 = c; return Border:Refresh(); end;
	function Border:SetClarity(v) Border.Clarity = v; return Border:Refresh(); end;
	function Border:SetThickness(v) Border.Thickness = v; return Border:Refresh(); end;
	function Border:SetSpeed(v) Border.Speed = v; return Border; end;
	function Border:SetEnabled(v) Border.Enabled = v; return Border:Refresh(); end;
	function Border:Destroy()
		Stroke:Destroy();
	end;
	table.insert(NeverloseUI.SpinBorders, Border);
	NeverloseUI:_ApplyBorder(Border);
	if not NeverloseUI._SpinBorderLoop then
		NeverloseUI._SpinBorderLoop = RunService.RenderStepped:Connect(function(dt)
			dt = math.min(dt, 0.1);
			local List = NeverloseUI.SpinBorders;
			for i = #List, 1, -1 do
				local B = List[i];
				if not B.Stroke.Parent then
					table.remove(List, i);
				elseif B.Stroke.Enabled and B.Stroke.Transparency < 0.99 then
					B.Gradient.Rotation = (B.Gradient.Rotation + (tonumber(B.Speed or NeverloseUI.BorderSpeed) or 90) * dt) % 360;
				end;
			end;
		end);
		pcall(function()
			NeverloseUI:AddSignal(NeverloseUI._SpinBorderLoop);
		end);
		NeverloseUI:OnThemeChanged(function(theme)
			if theme.Accent then
				NeverloseUI._ThemeAccent = theme.Accent;
			end;
			for _, B in ipairs(NeverloseUI.SpinBorders) do
				NeverloseUI:_ApplyBorder(B);
			end;
		end);
	end;
	return Border;
end;
function NeverloseUI:SetBorder(Settings)
	if type(Settings) ~= "table" then
		return NeverloseUI;
	end;
	local Map = {
		Enabled = {"BorderEnabled", "Enabled"},
		Color = {"BorderColor", "Color"},
		Color2 = {"BorderColor2", "Color2"},
		Clarity = {"BorderClarity", "Clarity"},
		Thickness = {"BorderThickness", "Thickness"},
		Speed = {"BorderSpeed", "Speed"},
	};
	Settings = {
		Enabled = Settings.Enabled,
		Color = Settings.Color,
		Color2 = Settings.Color2,
		Clarity = Settings.Clarity or Settings.Opacity or Settings.Visibility,
		Thickness = Settings.Thickness,
		Speed = Settings.Speed,
	};
	for Key, Names in next, Map do
		if Settings[Key] ~= nil then
			NeverloseUI[Names[1]] = Settings[Key];
			for _, B in ipairs(NeverloseUI.SpinBorders) do
				B[Names[2]] = nil;
			end;
		end;
	end;
	for _, B in ipairs(NeverloseUI.SpinBorders) do
		NeverloseUI:_ApplyBorder(B);
	end;
	return NeverloseUI;
end;
function NeverloseUI:CreateMenuIcon(Config)
	Config = Config or {};
	do
		local ActiveWin = NeverloseUI.ActiveWindow;
		if not Config.Auto and ActiveWin and ActiveWin._AutoMenuIcon then
			local Old = ActiveWin._AutoMenuIcon;
			ActiveWin._AutoMenuIcon = nil;
			if ActiveWin._MenuIcon == Old then
				ActiveWin._MenuIcon = nil;
			end;
			pcall(function()
				Old:Destroy();
			end);
		end;
	end;
	local iconSize       = Config.Size         or 48;
	local iconImage      = Config.Image        or "";
	local iconScale      = tonumber(Config.IconScale or Config.Scale) or 1;
	local iconColor      = Config.IconColor    or Color3.fromRGB(255,255,255);
	local bgColor        = Config.BGColor      or Color3.fromRGB(20,22,27);
	local draggable      = (Config.Draggable ~= false);
	local cornerRadius   = UDim.new(0, math.floor(iconSize * 0.28));
	local IconRoot = Instance.new("Frame");
	IconRoot.Name             = NeverloseUI.RandomString();
	IconRoot.Parent           = NeverloseUI.ScreenGui;
	IconRoot.AnchorPoint      = Vector2.new(0, 0.5);
	IconRoot.BackgroundColor3 = bgColor;
	IconRoot.BackgroundTransparency = 1;
	IconRoot.BorderSizePixel  = 0;
	IconRoot.Size             = UDim2.fromOffset(iconSize, iconSize);
	IconRoot.Position         = Config.Position or UDim2.new(0, 15, 0.5, 0);
	IconRoot.ZIndex           = 900;
	IconRoot.ClipsDescendants = false;
	IconRoot.Active           = true;
	IconRoot.Visible          = false;
	local IconPop = Instance.new("UIScale");
	IconPop.Scale  = 0.5;
	IconPop.Parent = IconRoot;
	local UICornerIcon = Instance.new("UICorner");
	UICornerIcon.CornerRadius = cornerRadius;
	UICornerIcon.Parent       = IconRoot;
	local SpinBorder = NeverloseUI:CreateSpinBorder(IconRoot, {
		Color        = Config.BorderColor or Config.StrokeColor,
		Color2       = Config.BorderColor2,
		Clarity      = Config.BorderClarity,
		Thickness    = Config.BorderThickness or Config.StrokeThick,
		Speed        = Config.BorderSpeed,
		Enabled      = Config.BorderEnabled,
		Transparency = 1,
	});
	local UIStrokeIcon = SpinBorder.Stroke;
	local IconLabel = Instance.new("TextLabel");
	IconLabel.Name                = NeverloseUI.RandomString();
	IconLabel.Parent              = IconRoot;
	IconLabel.AnchorPoint         = Vector2.new(0.5, 0.5);
	IconLabel.BackgroundTransparency = 1;
	IconLabel.BorderSizePixel     = 0;
	IconLabel.Position            = UDim2.fromScale(0.5, 0.5);
	IconLabel.Size                = UDim2.fromScale(0.65, 0.65);
	IconLabel.ZIndex              = 901;
	IconLabel.FontFace            = NeverloseUI.BuiltInBold;
	IconLabel.Text                = "";
	IconLabel.TextColor3          = iconColor;
	IconLabel.TextScaled          = true;
	IconLabel.TextTransparency    = 1;
	IconLabel.TextWrapped         = true;
	local IconImage = Instance.new("ImageLabel");
	IconImage.Name                = NeverloseUI.RandomString();
	IconImage.Parent              = IconRoot;
	IconImage.AnchorPoint         = Vector2.new(0.5, 0.5);
	IconImage.BackgroundTransparency = 1;
	IconImage.BorderSizePixel     = 0;
	IconImage.Position            = UDim2.fromScale(0.5, 0.5);
	IconImage.Size                = UDim2.fromScale(0.65, 0.65);
	IconImage.ZIndex              = 901;
	IconImage.ImageColor3         = iconColor;
	IconImage.ImageTransparency   = 1;
	IconImage.ScaleType           = Enum.ScaleType.Fit;
	IconImage:SetAttribute("ModernIconScaleValue", iconScale);
	local UICornerImg = Instance.new("UICorner");
	UICornerImg.CornerRadius = UDim.new(0.15, 0);
	UICornerImg.Parent       = IconImage;
	local IconShadow = NeverloseUI:CreateShadow(IconRoot, true);
	local MenuIconLib = {
		Root         = IconRoot,
		Border       = SpinBorder,
		Visible      = false,
		_size        = iconSize,
		_draggable   = draggable,
		AutoHide     = Config.AutoHide ~= false,
	};
	local function _applyIcon(src)
		if not src or src == "" then
			IconLabel.Text           = "";
			IconImage.Image          = "";
			IconLabel.Visible        = false;
			IconImage.Visible        = true;
			return;
		end;
		NeverloseUI:SetIconMode(IconImage, src);
		IconImage.Visible = true;
		IconLabel.Visible = false;
	end;
	_applyIcon(iconImage);
	local ShowToken = 0;
	local function _setIconVisible(val)
		if MenuIconLib.Visible == val then
			return;
		end;
		MenuIconLib.Visible = val;
		ShowToken += 1;
		local Token = ShowToken;
		local IconFallbackText = IconImage:FindFirstChild("ModernIconFallbackText");
		local ShowInfo = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
		local HideInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
		if val then
			if not IconRoot.Visible then
				IconPop.Scale = 0.15;
				IconRoot.Rotation = -40;
			end;
			IconRoot.Visible = true;
			NeverloseUI.PlayAnimate(IconPop, ShowInfo, {
				Scale = 1,
			});
			NeverloseUI.PlayAnimate(IconRoot, ShowInfo, {
				Rotation = 0,
			});
			NeverloseUI.PlayAnimate(IconRoot, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = 0,
			});
			NeverloseUI.PlayAnimate(UIStrokeIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 0,
			});
			NeverloseUI.PlayAnimate(IconLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				TextTransparency = 0,
			});
			NeverloseUI.PlayAnimate(IconImage, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageTransparency = 0,
			});
			if IconFallbackText then
				NeverloseUI.PlayAnimate(IconFallbackText, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 0,
				});
			end;
			IconShadow:Render(true);
		else
			NeverloseUI.PlayAnimate(IconPop, HideInfo, {
				Scale = 0,
			});
			NeverloseUI.PlayAnimate(IconRoot, HideInfo, {
				Rotation = 40,
			});
			NeverloseUI.PlayAnimate(IconRoot, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				BackgroundTransparency = 1,
			});
			NeverloseUI.PlayAnimate(UIStrokeIcon, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Transparency = 1,
			});
			NeverloseUI.PlayAnimate(IconLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				TextTransparency = 1,
			});
			NeverloseUI.PlayAnimate(IconImage, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				ImageTransparency = 1,
			});
			if IconFallbackText then
				NeverloseUI.PlayAnimate(IconFallbackText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					TextTransparency = 1,
				});
			end;
			IconShadow:Render(false);
			task.delay(0.34, function()
				if Token == ShowToken and not MenuIconLib.Visible and IconRoot.Parent then
					IconRoot.Visible = false;
					IconRoot.Rotation = 0;
				end;
			end);
		end;
	end;
	function MenuIconLib:SetVisible(val)
		_setIconVisible(val == true);
	end;
	function MenuIconLib:SetIcon(src)
		iconImage = src;
		_applyIcon(src);
	end;
	function MenuIconLib:SetIconScale(scale)
		iconScale = tonumber(scale) or iconScale;
		IconImage:SetAttribute("ModernIconScaleValue", iconScale);
		local IconScaleObject = IconImage:FindFirstChild("ModernIconScale");
		if IconScaleObject then
			IconScaleObject.Scale = iconScale;
		end;
		return MenuIconLib;
	end;
	function MenuIconLib:SetIconColor(c3)
		iconColor = c3;
		IconLabel.TextColor3  = c3;
		IconImage.ImageColor3 = c3;
	end;
	function MenuIconLib:SetBGColor(c3)
		bgColor = c3;
		IconRoot.BackgroundColor3 = c3;
	end;
	function MenuIconLib:SetStrokeColor(c3)
		SpinBorder:SetColor(c3);
	end;
	function MenuIconLib:SetStrokeThick(t)
		SpinBorder:SetThickness(t);
	end;
	function MenuIconLib:SetBorder(Settings)
		Settings = Settings or {};
		if Settings.Color ~= nil then SpinBorder.Color = Settings.Color; end;
		if Settings.Color2 ~= nil then SpinBorder.Color2 = Settings.Color2; end;
		local Clarity = Settings.Clarity or Settings.Opacity or Settings.Visibility;
		if Clarity ~= nil then SpinBorder.Clarity = Clarity; end;
		if Settings.Thickness ~= nil then SpinBorder.Thickness = Settings.Thickness; end;
		if Settings.Speed ~= nil then SpinBorder.Speed = Settings.Speed; end;
		if Settings.Enabled ~= nil then SpinBorder.Enabled = Settings.Enabled; end;
		SpinBorder:Refresh();
		return MenuIconLib;
	end;
	function MenuIconLib:SetSize(sz)
		MenuIconLib._size = sz;
		IconRoot.Size = UDim2.fromOffset(sz, sz);
		UICornerIcon.CornerRadius = UDim.new(0, math.floor(sz * 0.28));
	end;
	function MenuIconLib:SetDraggable(enabled)
		MenuIconLib._draggable = enabled;
	end;
	function MenuIconLib:GetCenter()
		local Screen = NeverloseUI.ScreenGui.AbsoluteSize;
		local Pos = IconRoot.Position;
		return Vector2.new(
			Pos.X.Scale * Screen.X + Pos.X.Offset + (MenuIconLib._size / 2),
			Pos.Y.Scale * Screen.Y + Pos.Y.Offset
		);
	end;
	function MenuIconLib:SetAutoHide(value)
		MenuIconLib.AutoHide = value == true;
		return MenuIconLib;
	end;
	function MenuIconLib:OnWindowToggle(windowVisible)
		if MenuIconLib.AutoHide then
			_setIconVisible(not windowVisible);
		end;
	end;
	function MenuIconLib:Destroy()
		MenuIconLib.Visible = false;
		if IconRoot.Parent then
			IconRoot:Destroy();
		end;
	end;
	do
		local function clampPosition(pos)
			local screenSize = NeverloseUI.ScreenGui.AbsoluteSize;
			local sz2 = MenuIconLib._size;
			local nx = math.clamp(pos.X.Scale * screenSize.X + pos.X.Offset, 0, screenSize.X - sz2);
			local ny = math.clamp(pos.Y.Scale * screenSize.Y + pos.Y.Offset, sz2/2, screenSize.Y - sz2/2);
			return UDim2.new(0, nx, 0, ny);
		end;
		local DRAG_THRESHOLD = 6;
		NeverloseUI:AddSignal(IconRoot.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
				return;
			end;
			local dragStart = input.Position;
			local startPos  = IconRoot.Position;
			local moved = false;
			local moveConn, endConn;
			local base = clampPosition(startPos);
			local curX, curY = base.X.Offset, base.Y.Offset;
			local tgtX, tgtY = curX, curY;
			local followConn;
			local sinkName = NeverloseUI.NewSinkName();
			local sinking = false;
			local released = false;
			local velX, velY = 0, 0;
			local function stopFollow()
				if followConn then
					followConn:Disconnect();
					followConn = nil;
				end;
			end;
			local function startFollow()
				if followConn then
					return;
				end;
				followConn = RunService.RenderStepped:Connect(function(dt)
					if not IconRoot.Parent then
						stopFollow();
						return;
					end;
					dt = math.min(dt, 0.05);
					local Rate = NeverloseUI.GetDragRate();
					if not Rate then
						curX, curY, velX, velY = tgtX, tgtY, 0, 0;
						IconRoot.Position = UDim2.new(0, math.round(curX), 0, math.round(curY));
						stopFollow();
						return;
					end;
					local decay = math.exp(-Rate * dt);
					local changeX = curX - tgtX;
					local changeY = curY - tgtY;
					local tempX = (velX + Rate * changeX) * dt;
					local tempY = (velY + Rate * changeY) * dt;
					velX = (velX - Rate * tempX) * decay;
					velY = (velY - Rate * tempY) * decay;
					curX = tgtX + (changeX + tempX) * decay;
					curY = tgtY + (changeY + tempY) * decay;
					if released and math.abs(tgtX - curX) < 0.15 and math.abs(tgtY - curY) < 0.15 and math.abs(velX) < 4 and math.abs(velY) < 4 then
						curX, curY, velX, velY = tgtX, tgtY, 0, 0;
						IconRoot.Position = UDim2.new(0, math.round(curX), 0, math.round(curY));
						stopFollow();
						return;
					end;
					IconRoot.Position = UDim2.new(0, math.round(curX), 0, math.round(curY));
				end);
			end;
			moveConn = UserInputService.InputChanged:Connect(function(mv)
				if mv.UserInputType ~= Enum.UserInputType.MouseMovement
				and mv.UserInputType ~= Enum.UserInputType.Touch then return; end;
				local delta = mv.Position - dragStart;
				if (moved or delta.Magnitude > DRAG_THRESHOLD) and MenuIconLib._draggable then
					moved = true;
					if not sinking then
						sinking = true;
						NeverloseUI.SetInputSink(sinkName, true);
					end;
					local raw = UDim2.new(
						startPos.X.Scale, startPos.X.Offset + delta.X,
						startPos.Y.Scale, startPos.Y.Offset + delta.Y
					);
					local target = clampPosition(raw);
					tgtX, tgtY = target.X.Offset, target.Y.Offset;
					if NeverloseUI.GetDragRate() then
						startFollow();
					else
						stopFollow();
						curX, curY = tgtX, tgtY;
						IconRoot.Position = target;
					end;
				end;
			end);
			endConn = input.Changed:Connect(function()
				if input.UserInputState ~= Enum.UserInputState.End then return; end;
				moveConn:Disconnect();
				endConn:Disconnect();
				released = true;
				if sinking then
					sinking = false;
					NeverloseUI.SetInputSink(sinkName, false);
				end;
				if not followConn then
					stopFollow();
				end;
				if not moved then
					local Owner = MenuIconLib._Owner;
					if Owner and not Owner.Destroyed and Owner.ToggleInterface then
						Owner:ToggleInterface();
					else
						NeverloseUI:FireKeybind();
					end;
				end;
			end);
		end));
	end;
	NeverloseUI:OnThemeChanged(function(theme)
		if theme.Icon then
			MenuIconLib:SetIconColor(theme.Icon);
		end;
	end);
	local ActiveWin = NeverloseUI.ActiveWindow;
	_setIconVisible(not (MenuIconLib.AutoHide and ActiveWin and ActiveWin.Signal and ActiveWin.Signal:GetValue()));
	return MenuIconLib;
end;
if getcustomasset then
	local link = "https://github.com/4lpaca-pin/NeverloseUI/blob/main/assets/%s?raw=true";
	local dir = 'NLAssets';
	if not isfolder(dir) then
		makefolder(dir);
	end;
	pcall(function()
		if not isfile(dir..'/'..'logo.png') then
			local byte = game:HttpGet(string.format(link,'logo.png'));
			writefile(dir..'/'..'logo.png' , byte);
			task.wait();
		end;
		if isfile(dir..'/'..'logo.png') then
			NeverloseUI.GlobalLogo = getcustomasset(dir..'/'..'logo.png')
		end;
	end);
	pcall(function()
		if not isfile(dir..'/'..'saturation_value_gradient.png') then
			local byte = game:HttpGet(string.format(link,'saturation_value_gradient.png'));
			writefile(dir..'/'..'saturation_value_gradient.png' , byte);
			task.wait();
		end;
		if isfile(dir..'/'..'saturation_value_gradient.png') then
			NeverloseUI.ImageColorMapping = getcustomasset(dir..'/'..'saturation_value_gradient.png')
		end;
	end);
end;
function NeverloseUI:AddSignal(RBXSignal)
	if NeverloseUI.UnloadEnabled then
		table.insert(NeverloseUI.GlobalSignals,RBXSignal);
	end;
	return RBXSignal;
end;
NeverloseUI:AddSignal(GlobalWindow.DescendantAdded:Connect(function(Object)
	task.defer(function()
		NeverloseUI:ApplyFont(Object);
	end);
end));
function NeverloseUI:AddQuery(ItemRoot , Name )
	local SectionOwner = nil;
	local Parent = ItemRoot;
	while Parent do
		if NeverloseUI.SectionOwners[Parent] then
			SectionOwner = NeverloseUI.SectionOwners[Parent];
			break;
		end;
		Parent = Parent.Parent;
	end;
	table.insert(NeverloseUI.NameRegisitry , {
		Root = ItemRoot,
		Idx = Name,
		Section = SectionOwner,
	});
end;
function NeverloseUI:RevealQueryItem(Query)
	if not Query or not Query.Root then
		return;
	end;
	if Query.Section and Query.Section.GetCollapsed and Query.Section:GetCollapsed() then
		Query.Section:SetCollapsed(false);
	end;
	task.defer(function()
		local Root = Query.Root;
		if not Root or not Root.Parent then
			return;
		end;
		local ScrollParent = Root.Parent;
		while ScrollParent and not ScrollParent:IsA("ScrollingFrame") do
			ScrollParent = ScrollParent.Parent;
		end;
		if not ScrollParent then
			return;
		end;
		local CanvasMaxY = math.max(0, ScrollParent.AbsoluteCanvasSize.Y - ScrollParent.AbsoluteSize.Y);
		local TargetY = Root.AbsolutePosition.Y - ScrollParent.AbsolutePosition.Y + ScrollParent.CanvasPosition.Y - 8;
		ScrollParent.CanvasPosition = Vector2.new(
			ScrollParent.CanvasPosition.X,
			math.clamp(TargetY, 0, CanvasMaxY)
		);
	end);
end;
function NeverloseUI:RegisterFlag(Flag, Object)
	if not Flag or not Object then
		return Object;
	end;
	Flag = tostring(Flag);
	NeverloseUI.Flags[Flag] = Object;
	if NeverloseUI.PendingFlagValues[Flag] ~= nil and Object.SetValue then
		local PendingValue = NeverloseUI.PendingFlagValues[Flag];
		NeverloseUI.PendingFlagValues[Flag] = nil;
		task.spawn(function()
			pcall(function()
				Object:SetValue(PendingValue);
			end);
		end);
	end;
	return Object;
end;
function NeverloseUI:ResolveConfigFlag(Config)
	if typeof(Config) ~= "table" then
		return nil;
	end;
	local Flag = Config.Flag or Config.Key or Config.ConfigKey;
	if Flag ~= nil then
		Flag = tostring(Flag);
		Config.Flag = Flag;
	end;
	return Flag;
end;
function NeverloseUI:AttachLockMethods(Object, Frame, Config)
	if not Object or not Frame then
		return Object;
	end;
	Config = Config or {};
	local LockObject = NeverloseUI:ApplyLock(Frame, Config.Locked == true, Config.TextLocked or Config.LockMessage or "Locked");
	Object.Lock = LockObject;
	function Object:SetLocked(state)
		LockObject:SetLocked(state);
		return Object;
	end;
	function Object:SetTextLocked(text)
		LockObject:SetTextLocked(text);
		return Object;
	end;
	function Object:GetLocked()
		return LockObject:GetLocked();
	end;
	local KeyWanted = Config.KeyLocked == true or Config.RequireKey == true or Config.KeyRequired == true;
	local KeyLockObject = NeverloseUI:ApplyKeyLock(Frame, KeyWanted);
	Object.KeyLock = KeyLockObject;
	function Object:SetKeyLocked(state)
		KeyLockObject:SetRequired(state);
		return Object;
	end;
	function Object:GetKeyLocked()
		return KeyLockObject:IsActive();
	end;
	return Object;
end;
function Encryption.new(data)
	local bytes = {};
	local encrypt_seed = ((#data + 3782) % 111) + 1;
	string.gsub(data , '.', LPH_NO_VIRTUALIZE(function(dt)
		table.insert(bytes , tostring(dt:byte() + encrypt_seed));
	end));
	local concatbyte = table.concat(bytes,'?');
	table.clear(bytes);
	return "{"..tostring(encrypt_seed + 72667).."}?"..concatbyte;
end;
function Encryption.reverse(data)
	local main_data = string.split(data,'?');
	local seed_str = main_data[1]:gsub('{',''):gsub('}','');
	local seed = tonumber(seed_str);
	local ks = {};
	local real_seed = seed - 72667;
	for i,v in next , main_data do
		if i > 1 then
			local fake_byte = tonumber(v);
			table.insert(ks , string.char(fake_byte - real_seed))
		end;
	end;
	local data = table.concat(ks);
	table.clear(ks);
	return data;
end;
do
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	NeverloseUI.Base64Encode = LPH_NO_VIRTUALIZE(function(data)
		return ((data:gsub('.', function(x)
			local r,b='',x:byte()
			for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
			return r;
		end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return b:sub(c+1,c+1)
		end)..({ '', '==', '=' })[#data%3+1])
	end);
	NeverloseUI.Base64Decode = LPH_NO_VIRTUALIZE(function(data)
		data = string.gsub(data, '[^'..b..'=]', '')
		return (data:gsub('.', function(x)
			if (x == '=') then return '' end
			local r,f='',(b:find(x)-1)
			for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
			return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c=0
			for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
			return string.char(c)
		end))
	end);
end;
function NeverloseUI:FireKeybind()
	if NeverloseUI.ActiveWindow then
		NeverloseUI.ActiveWindow:ToggleInterface();
	end;
end;
NeverloseUI.LoadIcon = LPH_NO_VIRTUALIZE(function()
	NeverloseUI.RobloxIcon = {
		["3d-cube-arrow-left"] = "3d-cube-arrow-left",
		["amazon"] = "amazon",
		["arm-left"] = "arm-left",
		["arm-right"] = "arm-right",
		["arrow-curl-to-left"] = "arrow-curl-to-left",
		["arrow-curl-to-right"] = "arrow-curl-to-right",
		["arrow-down-to-line"] = "arrow-down-to-line",
		["arrow-large-down"] = "arrow-large-down",
		["arrow-large-left"] = "arrow-large-left",
		["arrow-large-right"] = "arrow-large-right",
		["arrow-large-up"] = "arrow-large-up",
		["arrow-right-from-portrait-rectangle"] = "arrow-right-from-portrait-rectangle",
		["arrow-right-to-portrait-rectangle"] = "arrow-right-to-portrait-rectangle",
		["arrow-rotate-down-dashed"] = "arrow-rotate-down-dashed",
		["arrow-rotate-right"] = "arrow-rotate-right",
		["arrow-rotate-right-dashed"] = "arrow-rotate-right-dashed",
		["arrow-small-down"] = "arrow-small-down",
		["arrow-small-left"] = "arrow-small-left",
		["arrow-small-right"] = "arrow-small-right",
		["arrow-small-up"] = "arrow-small-up",
		["arrow-spin-clockwise"] = "arrow-spin-clockwise",
		["arrow-spin-clockwise-10"] = "arrow-spin-clockwise-10",
		["arrow-spin-clockwise-15"] = "arrow-spin-clockwise-15",
		["arrow-spin-clockwise-30"] = "arrow-spin-clockwise-30",
		["arrow-spin-counter-clockwise-10"] = "arrow-spin-counter-clockwise-10",
		["arrow-spin-counter-clockwise-15"] = "arrow-spin-counter-clockwise-15",
		["arrow-spin-counter-clockwise-30"] = "arrow-spin-counter-clockwise-30",
		["arrow-thick-to-left"] = "arrow-thick-to-left",
		["arrow-thick-to-right"] = "arrow-thick-to-right",
		["arrow-up-from-landscape-rectangle"] = "arrow-up-from-landscape-rectangle",
		["arrow-up-right-from-square"] = "arrow-up-right-from-square",
		["arrow-wide-short-down"] = "arrow-wide-short-down",
		["arrow-wide-short-left"] = "arrow-wide-short-left",
		["arrow-wide-short-right"] = "arrow-wide-short-right",
		["arrow-wide-short-up"] = "arrow-wide-short-up",
		["arrows-small-directional"] = "arrows-small-directional",
		["audio-wave-dotted-line"] = "audio-wave-dotted-line",
		["backpack"] = "backpack",
		["beard"] = "beard",
		["bell"] = "bell",
		["bell-clock"] = "bell-clock",
		["bell-plus"] = "bell-plus",
		["bell-slash"] = "bell-slash",
		["belt"] = "belt",
		["binoculars"] = "binoculars",
		["book-closed"] = "book-closed",
		["bookmark"] = "bookmark",
		["bow-tie"] = "bow-tie",
		["building-store"] = "building-store",
		["bullet-flying"] = "bullet-flying",
		["butterfly-wings"] = "butterfly-wings",
		["calendar"] = "calendar",
		["calendar-plus"] = "calendar-plus",
		["calendar-star"] = "calendar-star",
		["camera-small"] = "camera-small",
		["caret-small-down"] = "caret-small-down",
		["caret-small-left"] = "caret-small-left",
		["caret-small-right"] = "caret-small-right",
		["caret-small-up"] = "caret-small-up",
		["chain-link"] = "chain-link",
		["chart-four-vertical-bars"] = "chart-four-vertical-bars",
		["chart-line"] = "chart-line",
		["chart-pie"] = "chart-pie",
		["chart-scatter-plot"] = "chart-scatter-plot",
		["chart-three-vertical-bars"] = "chart-three-vertical-bars",
		["check"] = "check",
		["check-large"] = "check-large",
		["check-small"] = "check-small",
		["chevron-large-down"] = "chevron-large-down",
		["chevron-large-down-to-line"] = "chevron-large-down-to-line",
		["chevron-large-left"] = "chevron-large-left",
		["chevron-large-left-to-line"] = "chevron-large-left-to-line",
		["chevron-large-right"] = "chevron-large-right",
		["chevron-large-right-to-line"] = "chevron-large-right-to-line",
		["chevron-large-up"] = "chevron-large-up",
		["chevron-large-up-to-line"] = "chevron-large-up-to-line",
		["chevron-small-down"] = "chevron-small-down",
		["chevron-small-down-to-line"] = "chevron-small-down-to-line",
		["chevron-small-left"] = "chevron-small-left",
		["chevron-small-left-to-line"] = "chevron-small-left-to-line",
		["chevron-small-right"] = "chevron-small-right",
		["chevron-small-right-to-line"] = "chevron-small-right-to-line",
		["chevron-small-up"] = "chevron-small-up",
		["chevron-small-up-to-line"] = "chevron-small-up-to-line",
		["circle-check"] = "circle-check",
		["circle-i"] = "circle-i",
		["circle-minus"] = "circle-minus",
		["circle-person"] = "circle-person",
		["circle-person-three-horizontal-bars-wrapping-right"] = "circle-person-three-horizontal-bars-wrapping-right",
		["circle-play"] = "circle-play",
		["circle-plus"] = "circle-plus",
		["circle-question"] = "circle-question",
		["circle-slash"] = "circle-slash",
		["circle-star"] = "circle-star",
		["circle-three-dots-horizontal"] = "circle-three-dots-horizontal",
		["circle-three-dots-vertical"] = "circle-three-dots-vertical",
		["circle-x"] = "circle-x",
		["clock"] = "clock",
		["clock-dashed"] = "clock-dashed",
		["clock-spin-reverse"] = "clock-spin-reverse",
		["clock-spin-reverse-dashed"] = "clock-spin-reverse-dashed",
		["clothes-hanger"] = "clothes-hanger",
		["cloud"] = "cloud",
		["cloud-arrow-down"] = "cloud-arrow-down",
		["code"] = "code",
		["compact-makeup-brush"] = "compact-makeup-brush",
		["compass"] = "compass",
		["controller-with-cog"] = "controller-with-cog",
		["crop"] = "crop",
		["crosshairs"] = "crosshairs",
		["crosshairs-slash"] = "crosshairs-slash",
		["cube-vertexes"] = "cube-vertexes",
		["curved-rectangle-megaphone"] = "curved-rectangle-megaphone",
		["diagonal-line-pattern"] = "diagonal-line-pattern",
		["diagonal-line-pattern-sticker"] = "diagonal-line-pattern-sticker",
		["diamond-simplified"] = "diamond-simplified",
		["discord"] = "discord",
		["disguise-nose-glasses"] = "disguise-nose-glasses",
		["document-circle-slash"] = "document-circle-slash",
		["document-list-heart"] = "document-list-heart",
		["door-open-arrow-to-bottom-right"] = "door-open-arrow-to-bottom-right",
		["dress"] = "dress",
		["dual-arrows-horizontal"] = "dual-arrows-horizontal",
		["dual-arrows-to-corners"] = "dual-arrows-to-corners",
		["dual-arrows-vertical"] = "dual-arrows-vertical",
		["envelope"] = "envelope",
		["eraser"] = "eraser",
		["eye"] = "eye",
		["eye-slash"] = "eye-slash",
		["eye-with-eyeliner"] = "eye-with-eyeliner",
		["eyebrows"] = "eyebrows",
		["eyelashes"] = "eyelashes",
		["face-winking"] = "face-winking",
		["facebook"] = "facebook",
		["file-box"] = "file-box",
		["fingerprint"] = "fingerprint",
		["flag"] = "flag",
		["flame"] = "flame",
		["folder"] = "folder",
		["fountain-pen-nib"] = "fountain-pen-nib",
		["four-bars-horizontal-center-aligned"] = "four-bars-horizontal-center-aligned",
		["four-bars-horizontal-chevron-left"] = "four-bars-horizontal-chevron-left",
		["four-bars-horizontal-chevron-right"] = "four-bars-horizontal-chevron-right",
		["four-bars-horizontal-justified-aligned"] = "four-bars-horizontal-justified-aligned",
		["four-bars-horizontal-left-aligned"] = "four-bars-horizontal-left-aligned",
		["four-bars-horizontal-right-aligned"] = "four-bars-horizontal-right-aligned",
		["frame-bubble-slash"] = "frame-bubble-slash",
		["frame-bubble-soundwave"] = "frame-bubble-soundwave",
		["frame-camera"] = "frame-camera",
		["frame-camera-center"] = "frame-camera-center",
		["frame-collapsed"] = "frame-collapsed",
		["frame-corners"] = "frame-corners",
		["frame-expanded"] = "frame-expanded",
		["frame-face"] = "frame-face",
		["frame-person-torso"] = "frame-person-torso",
		["frame-record"] = "frame-record",
		["frame-single-bar-horizontal"] = "frame-single-bar-horizontal",
		["frame-soundwave"] = "frame-soundwave",
		["frame-video-camera"] = "frame-video-camera",
		["gear"] = "gear",
		["generic-dpad"] = "generic-dpad",
		["gift-box"] = "gift-box",
		["gift-card"] = "gift-card",
		["glasses"] = "glasses",
		["globe-detailed"] = "globe-detailed",
		["globe-simplified"] = "globe-simplified",
		["globe-simplipfied-speech-bubble"] = "globe-simplipfied-speech-bubble",
		["grid"] = "grid",
		["guilded"] = "guilded",
		["hack-week"] = "hack-week",
		["hammer-code"] = "hammer-code",
		["hand-curved-arrow-left"] = "hand-curved-arrow-left",
		["hand-dual-arrows"] = "hand-dual-arrows",
		["hand-ellipse"] = "hand-ellipse",
		["hand-half-ellipse"] = "hand-half-ellipse",
		["hand-two-arrows-horizontal"] = "hand-two-arrows-horizontal",
		["hashtag"] = "hashtag",
		["hat-fedora"] = "hat-fedora",
		["hat-toque"] = "hat-toque",
		["head-blank"] = "head-blank",
		["head-blush"] = "head-blush",
		["head-female"] = "head-female",
		["head-freckles"] = "head-freckles",
		["head-lips"] = "head-lips",
		["head-male"] = "head-male",
		["headphones"] = "headphones",
		["headphones-arrow-up"] = "headphones-arrow-up",
		["headphones-arrow-up-lock"] = "headphones-arrow-up-lock",
		["headphones-slash"] = "headphones-slash",
		["headphones-x"] = "headphones-x",
		["headphones-x-lock"] = "headphones-x-lock",
		["heart"] = "heart",
		["house"] = "house",
		["image"] = "image",
		["image-stacked"] = "image-stacked",
		["instagram"] = "instagram",
		["jacket"] = "jacket",
		["key"] = "key",
		["key-alt"] = "key-alt",
		["key-apostrophe"] = "key-apostrophe",
		["key-arrow-down"] = "key-arrow-down",
		["key-arrow-right"] = "key-arrow-right",
		["key-arrow-up"] = "key-arrow-up",
		["key-asterisk"] = "key-asterisk",
		["key-backspace"] = "key-backspace",
		["key-caps-lock"] = "key-caps-lock",
		["key-caret"] = "key-caret",
		["key-comma"] = "key-comma",
		["key-command"] = "key-command",
		["key-control"] = "key-control",
		["key-grave-accent"] = "key-grave-accent",
		["key-period"] = "key-period",
		["key-return"] = "key-return",
		["key-shift"] = "key-shift",
		["key-space"] = "key-space",
		["key-tab"] = "key-tab",
		["language-characters"] = "language-characters",
		["leg-left"] = "leg-left",
		["leg-right"] = "leg-right",
		["lightning-bolt"] = "lightning-bolt",
		["linkedin"] = "linkedin",
		["lips"] = "lips",
		["lipstick"] = "lipstick",
		["list-bulleted"] = "list-bulleted",
		["location-pin"] = "location-pin",
		["location-pin-map"] = "location-pin-map",
		["lock-closed"] = "lock-closed",
		["lollipop"] = "lollipop",
		["magnifying-glass"] = "magnifying-glass",
		["magnifying-glass-minus"] = "magnifying-glass-minus",
		["magnifying-glass-plus"] = "magnifying-glass-plus",
		["mascara"] = "mascara",
		["megaphone"] = "megaphone",
		["memory-card"] = "memory-card",
		["messenger"] = "messenger",
		["microphone"] = "microphone",
		["microphone-slash"] = "microphone-slash",
		["microphone-text-box"] = "microphone-text-box",
		["microphone-triangle-exclamation"] = "microphone-triangle-exclamation",
		["minus"] = "minus",
		["minus-small"] = "minus-small",
		["mirror-standing"] = "mirror-standing",
		["moments"] = "moments",
		["moon"] = "moon",
		["mouse-button-left"] = "mouse-button-left",
		["mouse-button-right"] = "mouse-button-right",
		["mouse-scrollwheel"] = "mouse-scrollwheel",
		["music-note"] = "music-note",
		["nebula"] = "nebula",
		["necklace"] = "necklace",
		["nine-dots-grid"] = "nine-dots-grid",
		["ninja"] = "ninja",
		["nose"] = "nose",
		["page"] = "page",
		["paint-brush"] = "paint-brush",
		["paint-bucket"] = "paint-bucket",
		["pants"] = "pants",
		["pants-2d-text"] = "pants-2d-text",
		["paper-airplane"] = "paper-airplane",
		["parrot"] = "parrot",
		["pause-large"] = "pause-large",
		["pause-small"] = "pause-small",
		["pencil"] = "pencil",
		["pencil-square"] = "pencil-square",
		["person"] = "person",
		["person-arrow-from-bottom-right"] = "person-arrow-from-bottom-right",
		["person-check"] = "person-check",
		["person-circle-slash"] = "person-circle-slash",
		["person-climbing"] = "person-climbing",
		["person-clock"] = "person-clock",
		["person-falling"] = "person-falling",
		["person-graduate"] = "person-graduate",
		["person-jumping"] = "person-jumping",
		["person-magnifying-glass"] = "person-magnifying-glass",
		["person-photo-camera"] = "person-photo-camera",
		["person-play"] = "person-play",
		["person-play-clock"] = "person-play-clock",
		["person-plus"] = "person-plus",
		["person-racing"] = "person-racing",
		["person-running"] = "person-running",
		["person-standing"] = "person-standing",
		["person-standing-arrow-reverse"] = "person-standing-arrow-reverse",
		["person-standing-dual-arrows-vertical"] = "person-standing-dual-arrows-vertical",
		["person-standing-gear"] = "person-standing-gear",
		["person-swimming"] = "person-swimming",
		["person-teleport"] = "person-teleport",
		["person-trash-can"] = "person-trash-can",
		["person-walking"] = "person-walking",
		["person-with-smaller-person"] = "person-with-smaller-person",
		["phone"] = "phone",
		["phone-down"] = "phone-down",
		["phone-plus"] = "phone-plus",
		["phone-volume"] = "phone-volume",
		["phone-x"] = "phone-x",
		["photo-camera"] = "photo-camera",
		["photo-camera-face"] = "photo-camera-face",
		["photo-camera-slash"] = "photo-camera-slash",
		["picture-in-picture"] = "picture-in-picture",
		["pig"] = "pig",
		["pin"] = "pin",
		["pin-slash"] = "pin-slash",
		["play-large"] = "play-large",
		["play-small"] = "play-small",
		["plus-large"] = "plus-large",
		["plus-small"] = "plus-small",
		["premium"] = "premium",
		["ps-circle"] = "ps-circle",
		["ps-dpad-down"] = "ps-dpad-down",
		["ps-dpad-left"] = "ps-dpad-left",
		["ps-dpad-right"] = "ps-dpad-right",
		["ps-dpad-up"] = "ps-dpad-up",
		["ps-l1"] = "ps-l1",
		["ps-l2"] = "ps-l2",
		["ps-l3"] = "ps-l3",
		["ps-r1"] = "ps-r1",
		["ps-r2"] = "ps-r2",
		["ps-r3"] = "ps-r3",
		["ps-square"] = "ps-square",
		["ps-stick-left"] = "ps-stick-left",
		["ps-stick-right"] = "ps-stick-right",
		["ps-triagle"] = "ps-triagle",
		["ps-x"] = "ps-x",
		["ps4-options"] = "ps4-options",
		["ps4-share"] = "ps4-share",
		["ps4-touchpad"] = "ps4-touchpad",
		["ps5-options"] = "ps5-options",
		["ps5-share"] = "ps5-share",
		["ps5-touchpad"] = "ps5-touchpad",
		["pumpkin"] = "pumpkin",
		["purse"] = "purse",
		["rectangle-list"] = "rectangle-list",
		["rectangle-numbers-counting"] = "rectangle-numbers-counting",
		["rectangle-person-with-three-horizontal-lines"] = "rectangle-person-with-three-horizontal-lines",
		["robux"] = "robux",
		["rosette-seven-point"] = "rosette-seven-point",
		["rosette-ten-point"] = "rosette-ten-point",
		["seven-point-rosette"] = "seven-point-rosette",
		["shield-check"] = "shield-check",
		["shield-lock"] = "shield-lock",
		["shirt"] = "shirt",
		["shirt-2d-text"] = "shirt-2d-text",
		["shirt-pants"] = "shirt-pants",
		["shoe-left"] = "shoe-left",
		["shoe-right"] = "shoe-right",
		["shopping-basket"] = "shopping-basket",
		["shopping-basket-check"] = "shopping-basket-check",
		["shopping-cart"] = "shopping-cart",
		["shorts"] = "shorts",
		["sidebar"] = "sidebar",
		["signal-exclamation"] = "signal-exclamation",
		["six-dots-two-column-grid"] = "six-dots-two-column-grid",
		["skip-end-large"] = "skip-end-large",
		["skip-end-small"] = "skip-end-small",
		["skip-next-large"] = "skip-next-large",
		["skip-next-small"] = "skip-next-small",
		["skip-previous-large"] = "skip-previous-large",
		["skip-previous-small"] = "skip-previous-small",
		["skip-start-large"] = "skip-start-large",
		["skip-start-small"] = "skip-start-small",
		["smartphone-portrait"] = "smartphone-portrait",
		["speaker"] = "speaker",
		["speaker-slash"] = "speaker-slash",
		["speaker-triangle-exclamation"] = "speaker-triangle-exclamation",
		["speaker-x"] = "speaker-x",
		["speech-bubble-align-center"] = "speech-bubble-align-center",
		["speech-bubble-align-left"] = "speech-bubble-align-left",
		["speech-bubble-exclamation"] = "speech-bubble-exclamation",
		["speech-bubble-round"] = "speech-bubble-round",
		["square-bone"] = "square-bone",
		["square-books"] = "square-books",
		["square-check"] = "square-check",
		["square-code"] = "square-code",
		["square-dashed-person-standing"] = "square-dashed-person-standing",
		["square-dual-arrows-horizontal"] = "square-dual-arrows-horizontal",
		["square-dual-arrows-to-corner"] = "square-dual-arrows-to-corner",
		["square-face-sound"] = "square-face-sound",
		["square-face-waving-hand"] = "square-face-waving-hand",
		["square-face-winking"] = "square-face-winking",
		["square-minus"] = "square-minus",
		["square-person"] = "square-person",
		["squares-grid-plus"] = "squares-grid-plus",
		["squares-grid-qr"] = "squares-grid-qr",
		["stacked-squares-arrow-down-left"] = "stacked-squares-arrow-down-left",
		["stacked-squares-arrow-up-right"] = "stacked-squares-arrow-up-right",
		["stacked-squares-plus"] = "stacked-squares-plus",
		["star"] = "star",
		["stop-large"] = "stop-large",
		["stop-small"] = "stop-small",
		["studio"] = "studio",
		["sun"] = "sun",
		["sweater"] = "sweater",
		["sword"] = "sword",
		["tag-sparkle"] = "tag-sparkle",
		["teletype"] = "teletype",
		["tencent-qq"] = "tencent-qq",
		["text-b-bold"] = "text-b-bold",
		["text-box-microphone"] = "text-box-microphone",
		["text-h-subscript-1"] = "text-h-subscript-1",
		["text-h-subscript-2"] = "text-h-subscript-2",
		["text-h-subscript-3"] = "text-h-subscript-3",
		["text-i-italic"] = "text-i-italic",
		["text-s-strikethrough"] = "text-s-strikethrough",
		["text-u-underline"] = "text-u-underline",
		["text-uppercase-a-lowercase-a"] = "text-uppercase-a-lowercase-a",
		["text-x-subscript-2"] = "text-x-subscript-2",
		["text-x-superscript-2"] = "text-x-superscript-2",
		["three-bars-horizontal"] = "three-bars-horizontal",
		["three-bars-horizontal-chevron-left"] = "three-bars-horizontal-chevron-left",
		["three-bars-horizontal-narrowing"] = "three-bars-horizontal-narrowing",
		["three-bars-horizontal-triangles-vertical"] = "three-bars-horizontal-triangles-vertical",
		["three-bars-vertical-triangles-horizontal"] = "three-bars-vertical-triangles-horizontal",
		["three-chevrons-enlarging-down"] = "three-chevrons-enlarging-down",
		["three-chevrons-enlarging-up"] = "three-chevrons-enlarging-up",
		["three-dots-horizontal"] = "three-dots-horizontal",
		["three-dots-vertical"] = "three-dots-vertical",
		["three-horizontal-bars-wrapping-right"] = "three-horizontal-bars-wrapping-right",
		["three-people"] = "three-people",
		["three-ring-note"] = "three-ring-note",
		["three-sliders-horizontal"] = "three-sliders-horizontal",
		["three-stacked-squares-tilted"] = "three-stacked-squares-tilted",
		["thumb-down"] = "thumb-down",
		["thumb-up"] = "thumb-up",
		["tik-tok"] = "tik-tok",
		["tilt"] = "tilt",
		["torso"] = "torso",
		["trash-can"] = "trash-can",
		["triangle-exclamation"] = "triangle-exclamation",
		["trophy"] = "trophy",
		["tshirt"] = "tshirt",
		["tshirt-2d-text"] = "tshirt-2d-text",
		["tshirt-dual-arrows"] = "tshirt-dual-arrows",
		["twitch"] = "twitch",
		["twitter"] = "twitter",
		["two-arrows-down-and-up"] = "two-arrows-down-and-up",
		["two-arrows-from-center"] = "two-arrows-from-center",
		["two-arrows-left-right"] = "two-arrows-left-right",
		["two-arrows-loop-clockwise"] = "two-arrows-loop-clockwise",
		["two-arrows-loop-clockwise-1"] = "two-arrows-loop-clockwise-1",
		["two-arrows-loop-clockwise-infinity"] = "two-arrows-loop-clockwise-infinity",
		["two-arrows-spin-clockwise"] = "two-arrows-spin-clockwise",
		["two-arrows-spin-clockwise-plus"] = "two-arrows-spin-clockwise-plus",
		["two-arrows-switch-right"] = "two-arrows-switch-right",
		["two-arrows-to-center"] = "two-arrows-to-center",
		["two-folders"] = "two-folders",
		["two-location-pins-connecting-arrow"] = "two-location-pins-connecting-arrow",
		["two-makeup-brushes"] = "two-makeup-brushes",
		["two-people"] = "two-people",
		["two-people-speech-bubble"] = "two-people-speech-bubble",
		["two-stacked-squares"] = "two-stacked-squares",
		["two-switches-horizontal"] = "two-switches-horizontal",
		["verified-backplate"] = "verified-backplate",
		["verified-check"] = "verified-check",
		["verified-mono"] = "verified-mono",
		["video-camera"] = "video-camera",
		["video-camera-arrow-to-bottom-left"] = "video-camera-arrow-to-bottom-left",
		["video-camera-arrow-to-top-right"] = "video-camera-arrow-to-top-right",
		["video-camera-slash"] = "video-camera-slash",
		["video-camera-triangle-exclamation"] = "video-camera-triangle-exclamation",
		["video-camera-x"] = "video-camera-x",
		["wallet"] = "wallet",
		["we-chat"] = "we-chat",
		["whatsapp"] = "whatsapp",
		["x"] = "x",
		["x-small"] = "x-small",
		["xbox-a"] = "xbox-a",
		["xbox-a-pressed"] = "xbox-a-pressed",
		["xbox-a-unpressed"] = "xbox-a-unpressed",
		["xbox-b"] = "xbox-b",
		["xbox-dpad"] = "xbox-dpad",
		["xbox-dpad-down"] = "xbox-dpad-down",
		["xbox-dpad-left"] = "xbox-dpad-left",
		["xbox-dpad-right"] = "xbox-dpad-right",
		["xbox-dpad-up"] = "xbox-dpad-up",
		["xbox-lb"] = "xbox-lb",
		["xbox-lt"] = "xbox-lt",
		["xbox-menu"] = "xbox-menu",
		["xbox-rb"] = "xbox-rb",
		["xbox-rt"] = "xbox-rt",
		["xbox-stick-left"] = "xbox-stick-left",
		["xbox-stick-left-directional"] = "xbox-stick-left-directional",
		["xbox-stick-left-horizontal"] = "xbox-stick-left-horizontal",
		["xbox-stick-left-vertical"] = "xbox-stick-left-vertical",
		["xbox-stick-right"] = "xbox-stick-right",
		["xbox-stick-right-directional"] = "xbox-stick-right-directional",
		["xbox-stick-right-horizontal"] = "xbox-stick-right-horizontal",
		["xbox-stick-right-vertical"] = "xbox-stick-right-vertical",
		["xbox-view"] = "xbox-view",
		["xbox-x"] = "xbox-x",
		["xbox-y"] = "xbox-y",
		["xr-headset"] = "xr-headset",
		["youtube"] = "youtube"
	};
end);
NeverloseUI.IsMouseOverFrame = LPH_NO_VIRTUALIZE(function(self , Frame)
	if not Frame then
		return;
	end;
	if NeverloseUI.Global3DRenderMode then
		if Frame.GuiState == Enum.GuiState.Hover or Frame.GuiState == Enum.GuiState.Press then
			return true;
		end;
		return false;
	end;
	local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
	if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
		return true;
	end;
end);
NeverloseUI.CreateSignal = LPH_NO_VIRTUALIZE(function(self , DefaultValue)
	local __cache = Instance.new('BindableEvent');
	local bind = {
		Value = DefaultValue,
		__event = __cache
	};
	function bind:GetValue()
		return bind.Value;
	end;
	function bind:SetValue(f)
		bind.Value = f;
		return __cache:Fire(f);
	end;
	function bind:Connect(f)
		local signal = __cache.Event:Connect(f);
		NeverloseUI:AddSignal(signal);
		return signal;
	end;
	return bind;
end);
function NeverloseUI:_ApplyTextGradient(Label)
	if not Label or not Label.Parent then
		return;
	end;
	local Gradient = Label:FindFirstChild("ModernTextGradient");
	if not NeverloseUI.TextGradientEnabled then
		if Gradient then
			Gradient:Destroy();
		end;
		return;
	end;
	if not Gradient then
		Gradient = Instance.new("UIGradient");
		Gradient.Name = "ModernTextGradient";
		Gradient.Parent = Label;
	end;
	local Accent = NeverloseUI.AccentColor or Color3.fromRGB(78, 127, 252);
	local SweepX = (((NeverloseUI.TextGradientAnimationTime or 0) * 0.9) % 2) - 1;
	Gradient.Rotation = 0;
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Accent:Lerp(Color3.new(1, 1, 1), 0.2)),
		ColorSequenceKeypoint.new(0.55, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1, Accent:Lerp(Color3.new(1, 1, 1), 0.35)),
	});
	Gradient.Offset = Vector2.new(SweepX, 0);
	for _,ExistingGradient in ipairs(NeverloseUI.TextGradientObjects) do
		if ExistingGradient == Gradient then
			return Gradient;
		end;
	end;
	table.insert(NeverloseUI.TextGradientObjects, Gradient);
	return Gradient;
end;
function NeverloseUI:AddTextGradient(Label)
	if not Label then
		return Label;
	end;
	for _,ExistingLabel in ipairs(NeverloseUI.TextGradientLabels) do
		if ExistingLabel == Label then
			NeverloseUI:_ApplyTextGradient(Label);
			return Label;
		end;
	end;
	table.insert(NeverloseUI.TextGradientLabels, Label);
	NeverloseUI:_ApplyTextGradient(Label);
	return Label;
end;
function NeverloseUI:SetTextGradientEnabled(Enabled)
	NeverloseUI.TextGradientEnabled = Enabled == true;
	if not NeverloseUI.TextGradientEnabled then
		NeverloseUI.TextGradientAccumulator = 0;
	end;
	table.clear(NeverloseUI.TextGradientObjects);
	for Index = #NeverloseUI.TextGradientLabels, 1, -1 do
		local Label = NeverloseUI.TextGradientLabels[Index];
		if Label and Label.Parent then
			NeverloseUI:_ApplyTextGradient(Label);
		else
			table.remove(NeverloseUI.TextGradientLabels, Index);
		end;
	end;
end;
function NeverloseUI:AnimateTextGradients(dt)
	if not NeverloseUI.TextGradientEnabled then
		return;
	end;
	NeverloseUI.TextGradientAccumulator = (NeverloseUI.TextGradientAccumulator or 0) + (dt or 0);
	if NeverloseUI.TextGradientAccumulator < (1 / 30) then
		return;
	end;
	local ResolvedDt = NeverloseUI.TextGradientAccumulator;
	NeverloseUI.TextGradientAccumulator = 0;
	NeverloseUI.TextGradientAnimationTime = (NeverloseUI.TextGradientAnimationTime or 0) + ResolvedDt;
	local SweepX = ((NeverloseUI.TextGradientAnimationTime * 0.9) % 2) - 1;
	local Offset = Vector2.new(SweepX, 0);
	for Index = #NeverloseUI.TextGradientObjects, 1, -1 do
		local Gradient = NeverloseUI.TextGradientObjects[Index];
		if Gradient and Gradient.Parent then
			Gradient.Rotation = 0;
			Gradient.Offset = Offset;
		else
			table.remove(NeverloseUI.TextGradientObjects, Index);
		end;
	end;
end;
NeverloseUI:AddSignal(RunService.RenderStepped:Connect(function(dt)
	NeverloseUI:AnimateTextGradients(dt);
end));
NeverloseUI.SetIconMode = LPH_NO_VIRTUALIZE(function(self , Label , Icon)
	Icon = tostring(Icon or "");
	local OriginalIcon = Icon;
	local FallbackIcon = NeverloseUI.IconAliases[OriginalIcon] or OriginalIcon;
	local IsVideoIcon = NeverloseUI:IsWebmIcon(OriginalIcon) or NeverloseUI:IsWebmIcon(FallbackIcon);
	local ResolvedIcon = NeverloseUI:GetIconId(OriginalIcon);
	if ResolvedIcon == "" and FallbackIcon ~= OriginalIcon then
		ResolvedIcon = NeverloseUI:GetIconId(FallbackIcon);
	end;
	if Label:IsA("ImageLabel") then
		if IsVideoIcon then
			Label.Image = "";
			Label.ImageTransparency = 1;
			Label.ScaleType = Enum.ScaleType.Fit;
			NeverloseUI:ApplyIconVideo(Label, OriginalIcon);
			local FallbackText = Label:FindFirstChild("ModernIconFallbackText");
			if FallbackText then
				FallbackText.Visible = false;
			end;
			return;
		end;
		NeverloseUI:ClearIconVideo(Label);
		Label.Image = ResolvedIcon;
		Label.ScaleType = Enum.ScaleType.Fit;
		local IconScale = Label:FindFirstChild("ModernIconScale");
		if not IconScale then
			IconScale = Instance.new("UIScale");
			IconScale.Name = "ModernIconScale";
			IconScale.Parent = Label;
		end;
		IconScale.Scale = tonumber(Label:GetAttribute("ModernIconScaleValue")) or NeverloseUI.IconScale or 0.82;
		local FallbackText = Label:FindFirstChild("ModernIconFallbackText");
		if ResolvedIcon ~= "" then
			if FallbackText then
				FallbackText.Visible = false;
			end;
		else
			Label.ImageTransparency = 1;
			if FallbackIcon ~= "" and not NeverloseUI:IsLibraryIcon(FallbackIcon) then
				if not FallbackText then
					FallbackText = Instance.new("TextLabel");
					FallbackText.Name = "ModernIconFallbackText";
					FallbackText.Parent = Label;
					FallbackText.AnchorPoint = Vector2.new(0.5, 0.5);
					FallbackText.BackgroundTransparency = 1;
					FallbackText.BorderSizePixel = 0;
					FallbackText.Position = UDim2.fromScale(0.5, 0.5);
					FallbackText.Size = UDim2.fromScale(1, 1);
					FallbackText.ZIndex = Label.ZIndex + 1;
					FallbackText.TextScaled = true;
					FallbackText.TextWrapped = true;
					FallbackText:SetAttribute("NeverloseUIIconFont", true);
					NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
						local ChildIcon = Label:FindFirstChild("ModernIconFallbackText");
						if ChildIcon then
							ChildIcon.TextTransparency = Label.ImageTransparency;
						end;
					end));
					NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("ImageColor3"):Connect(function()
						local ChildIcon = Label:FindFirstChild("ModernIconFallbackText");
						if ChildIcon then
							ChildIcon.TextColor3 = Label.ImageColor3;
						end;
					end));
					NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("ZIndex"):Connect(function()
						local ChildIcon = Label:FindFirstChild("ModernIconFallbackText");
						if ChildIcon then
							ChildIcon.ZIndex = Label.ZIndex + 1;
						end;
					end));
				end;
				local useBold = string.lower(string.sub(FallbackIcon , -5)) == '-bold';
				FallbackText.Text = useBold and FallbackIcon:sub(1,-6) or FallbackIcon;
				FallbackText.FontFace = useBold and NeverloseUI.BuiltInBold or NeverloseUI.BuiltInRegular;
				FallbackText.TextColor3 = Label.ImageColor3;
				FallbackText.TextTransparency = Label.ImageTransparency;
				FallbackText.Visible = true;
			elseif FallbackText then
				FallbackText.Visible = false;
			end;
		end;
		return;
	end;
	local IconImage = Label:FindFirstChild("ModernResolvedIcon");
	if IsVideoIcon then
		if not IconImage then
			IconImage = Instance.new("ImageLabel");
			IconImage.Name = "ModernResolvedIcon";
			IconImage.Parent = Label;
			IconImage.AnchorPoint = Vector2.new(0.5, 0.5);
			IconImage.BackgroundTransparency = 1;
			IconImage.BorderSizePixel = 0;
			IconImage.Position = UDim2.fromScale(0.5, 0.5);
			IconImage.Size = UDim2.fromScale(1, 1);
			IconImage.ScaleType = Enum.ScaleType.Fit;
			IconImage.ZIndex = Label.ZIndex;
		end;
		IconImage.Image = "";
		IconImage.ImageTransparency = 1;
		IconImage.Visible = true;
		NeverloseUI:ApplyIconVideo(IconImage, OriginalIcon);
		Label.Text = "";
		return;
	elseif IconImage then
		NeverloseUI:ClearIconVideo(IconImage);
	end;
	if ResolvedIcon ~= "" then
		if not IconImage then
			IconImage = Instance.new("ImageLabel");
			IconImage.Name = "ModernResolvedIcon";
			IconImage.Parent = Label;
			IconImage.AnchorPoint = Vector2.new(0.5, 0.5);
			IconImage.BackgroundTransparency = 1;
			IconImage.BorderSizePixel = 0;
			IconImage.Position = UDim2.fromScale(0.5, 0.5);
			IconImage.Size = UDim2.fromScale(1, 1);
			IconImage.ScaleType = Enum.ScaleType.Fit;
			IconImage.ZIndex = Label.ZIndex;
			NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("TextTransparency"):Connect(function()
				local ChildIcon = Label:FindFirstChild("ModernResolvedIcon");
				if ChildIcon then
					ChildIcon.ImageTransparency = Label.TextTransparency;
				end;
			end));
			NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("TextColor3"):Connect(function()
				local ChildIcon = Label:FindFirstChild("ModernResolvedIcon");
				if ChildIcon then
					ChildIcon.ImageColor3 = Label.TextColor3;
				end;
			end));
			NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("ZIndex"):Connect(function()
				local ChildIcon = Label:FindFirstChild("ModernResolvedIcon");
				if ChildIcon then
					ChildIcon.ZIndex = Label.ZIndex;
				end;
			end));
		end;
		IconImage.Image = ResolvedIcon;
		IconImage.ImageColor3 = Label.TextColor3;
		IconImage.ImageTransparency = Label.TextTransparency;
		IconImage.Visible = true;
		Label.Text = "";
		return;
	end;
	if IconImage then
		IconImage.Visible = false;
		IconImage.Image = "";
	end;
	Icon = FallbackIcon;
	if NeverloseUI:IsLibraryIcon(Icon) then
		Label.Text = "";
		return;
	end;
	local useBold = string.lower(string.sub(Icon , -5)) == '-bold';
	if useBold then
		Label.Text = Icon:sub(1,-6);
		Label.FontFace = NeverloseUI.BuiltInBold;
	else
		Label.Text = Icon;
		Label.FontFace = NeverloseUI.BuiltInRegular;
	end;
	Label:SetAttribute("NeverloseUIIconFont", true);
end);
function NeverloseUI:GetIconFont(icon)
	local useBold = string.lower(string.sub(icon , -5)) == '-bold';
	if useBold then
		return NeverloseUI.BuiltInBold;
	end;
	return NeverloseUI.BuiltInRegular;
end;
function NeverloseUI:ResolveFontFace(FontConfig)
	if typeof(FontConfig) == "Font" then
		return FontConfig;
	end;
	if not FontConfig or FontConfig == "" then
		return nil;
	end;
	local FontSource = tostring(FontConfig);
	if string.match(FontSource, "^%d+$") then
		FontSource = "rbxassetid://" .. FontSource;
	elseif not string.find(FontSource, "rbxasset://", 1, true) and not string.find(FontSource, "rbxassetid://", 1, true) and not string.match(FontSource, "^https?://") then
		FontSource = "rbxasset://fonts/families/" .. FontSource .. ".json";
	end;
	local Success, ResolvedFont = pcall(function()
		return Font.new(FontSource,Enum.FontWeight.Regular,Enum.FontStyle.Normal);
	end);
	if Success then
		return ResolvedFont;
	end;
end;
function NeverloseUI:ApplyFont(Object)
	if not NeverloseUI.FontFace then
		return Object;
	end;
	if not Object or (not Object:IsA("TextLabel") and not Object:IsA("TextBox") and not Object:IsA("TextButton")) then
		return Object;
	end;
	if Object:GetAttribute("NeverloseUIIconFont") then
		return Object;
	end;
	Object.FontFace = NeverloseUI.FontFace;
	return Object;
end;
function NeverloseUI:SetFont(FontConfig)
	NeverloseUI.Font = FontConfig;
	NeverloseUI.FontFace = NeverloseUI:ResolveFontFace(FontConfig);
	if NeverloseUI.FontFace then
		for _, Object in next, NeverloseUI.ScreenGui:GetDescendants() do
			NeverloseUI:ApplyFont(Object);
		end;
	end;
	return NeverloseUI.FontFace;
end;
function NeverloseUI:MoreThanHalfY(Value)
	return (NeverloseUI.ScreenGui.AbsoluteSize.Y / 2) < Value
end;
NeverloseUI.IsStudio = RunService:IsStudio();
NeverloseUI.IsMobile = UserInputService.TouchEnabled;
function NeverloseUI:IsSmallScreen()
	local Screen = NeverloseUI.ScreenGui.AbsoluteSize;
	return NeverloseUI.IsMobile == true and math.min(Screen.X, Screen.Y) < 700;
end;
NeverloseUI.CreateInput = LPH_NO_VIRTUALIZE(function(self , Frame , Callback)
	local Button = Instance.new('ImageButton',Frame);
	Button.ZIndex = Frame.ZIndex + 10;
	Button.Size = UDim2.fromScale(1,1);
	Button.BackgroundTransparency = 1;
	Button.ImageTransparency = 1;
	Button.Image = "rbxasset://textuers/translateIcon.png";
	if Callback then
		local bth_signal = Button.MouseButton1Click:Connect(Callback);
		return Button , bth_signal;
	end;
	return Button;
end);
NeverloseUI.PlayAnimate = LPH_NO_VIRTUALIZE(function(Self , Info , Property)
	if Self and Self:IsA("ImageLabel") then
		local ImageProperty = {};
		for Key,Value in next , Property do
			if Key == "TextTransparency" then
				ImageProperty.ImageTransparency = Value;
			elseif Key == "TextColor3" then
				ImageProperty.ImageColor3 = Value;
			else
				ImageProperty[Key] = Value;
			end;
		end;
		Property = ImageProperty;
	end;
	local Tween = TweenService:Create(Self , Info or TweenInfo.new(0.25) , Property);
	Tween:Play();
	return Tween;
end);
NeverloseUI._SinkId = 0;
NeverloseUI.NewSinkName = function()
	NeverloseUI._SinkId += 1;
	return "NLInputSink_" .. tostring(NeverloseUI._SinkId);
end;
NeverloseUI.SetInputSink = function(Name, State)
	pcall(function()
		local CAS = game:GetService("ContextActionService");
		if State then
			CAS:BindActionAtPriority(Name, function()
				return Enum.ContextActionResult.Sink;
			end, false, 5000, Enum.UserInputType.Touch);
		else
			CAS:UnbindAction(Name);
		end;
	end);
end;
NeverloseUI.GetDragRate = function()
	local Level = math.clamp(tonumber(NeverloseUI.DragSmoothness) or 0, 0, 100);
	if Level <= 0 then
		return nil;
	end;
	return 40 * (0.08 ^ (Level / 100));
end;
NeverloseUI.Drag = function(InputFrame, MoveFrame, Speed, Guard)
	local CurX, CurY, TgtX, TgtY = 0, 0, 0, 0;
	local SpringVX, SpringVY = 0, 0;
	local SinkName = NeverloseUI.NewSinkName();
	pcall(function()
		InputFrame.Active = true;
	end);
	local FollowConn = nil;
	local SettleTime = 0;
	local DragInput = nil;
	local Dragging = false;
	local DragStart = nil;
	local StartPos = nil;
	local DragTime = 0;
	local LastX, LastT = 0, 0;
	local VelX = 0;
	local Rot, RotVel = 0, 0;
	local Tilting = false;
	local Guarded = false;
	local DRAG_THRESHOLD = 4;
	local RotConn = nil;
	local function SetGuard(state)
		if Guarded == state then
			return;
		end;
		Guarded = state;
		if Guard then
			pcall(Guard, state);
		end;
	end;
	local function StopTilt()
		if RotConn then
			RotConn:Disconnect();
			RotConn = nil;
		end;
		Rot, RotVel, VelX = 0, 0, 0;
		Tilting = false;
		if MoveFrame.Rotation ~= 0 then
			MoveFrame.Rotation = 0;
		end;
		SetGuard(false);
	end;
	local function ApplyFollow(X, Y)
		MoveFrame.Position = UDim2.new(StartPos.X.Scale, math.round(X), StartPos.Y.Scale, math.round(Y));
	end;
	local function StopFollow()
		if FollowConn then
			FollowConn:Disconnect();
			FollowConn = nil;
		end;
	end;
	local function StartFollow()
		if FollowConn then
			return;
		end;
		FollowConn = RunService.RenderStepped:Connect(function(dt)
			local Window = NeverloseUI.ActiveWindow;
			if not MoveFrame.Parent or not StartPos or (Window and Window.Minimizing) then
				StopFollow();
				return;
			end;
			dt = math.min(dt, 0.05);
			local Rate = NeverloseUI.GetDragRate();
			if not Rate then
				CurX, CurY, SpringVX, SpringVY = TgtX, TgtY, 0, 0;
				ApplyFollow(CurX, CurY);
				StopFollow();
				return;
			end;
			local Decay = math.exp(-Rate * dt);
			local ChangeX = CurX - TgtX;
			local ChangeY = CurY - TgtY;
			local TempX = (SpringVX + Rate * ChangeX) * dt;
			local TempY = (SpringVY + Rate * ChangeY) * dt;
			SpringVX = (SpringVX - Rate * TempX) * Decay;
			SpringVY = (SpringVY - Rate * TempY) * Decay;
			CurX = TgtX + (ChangeX + TempX) * Decay;
			CurY = TgtY + (ChangeY + TempY) * Decay;
			if not DragInput and math.abs(TgtX - CurX) < 0.15 and math.abs(TgtY - CurY) < 0.15 and math.abs(SpringVX) < 4 and math.abs(SpringVY) < 4 then
				CurX, CurY, SpringVX, SpringVY = TgtX, TgtY, 0, 0;
				ApplyFollow(CurX, CurY);
				StopFollow();
				return;
			end;
			ApplyFollow(CurX, CurY);
		end);
	end;
	local function StartTilt()
		if RotConn or not NeverloseUI.DragTilt then
			return;
		end;
		Tilting = true;
		RotConn = RunService.RenderStepped:Connect(function(dt)
			if not MoveFrame.Parent or NeverloseUI.Global3DRenderMode or not NeverloseUI.DragTilt then
				StopTilt();
				return;
			end;
			dt = math.min(dt, 0.05);
			local TargetRot = 0;
			if Dragging then
				DragTime += dt;
				VelX *= math.exp(-dt * 7);
				local Dead = 120;
				local Eff = 0;
				if math.abs(VelX) > Dead then
					Eff = VelX - (math.sign(VelX) * Dead);
				end;
				local Max = math.clamp(tonumber(NeverloseUI.DragMaxTilt) or 4, 0, 10);
				local Ramp = math.clamp((DragTime - 0.08) / 0.3, 0, 1);
				TargetRot = math.clamp(Eff * 0.003, -Max, Max) * Ramp;
			end;
			RotVel += ((TargetRot - Rot) * 140 - RotVel * 24) * dt;
			Rot += RotVel * dt;
			if not Dragging and math.abs(Rot) < 0.05 and math.abs(RotVel) < 0.1 then
				StopTilt();
				return;
			end;
			local NewRot = math.abs(Rot) < 0.02 and 0 or Rot;
			if MoveFrame.Rotation ~= NewRot then
				MoveFrame.Rotation = NewRot;
			end;
			if NeverloseUI.TiltHideContent ~= false then
				if math.abs(Rot) > 0.25 then
					SetGuard(true);
				elseif math.abs(Rot) < 0.08 then
					SetGuard(false);
				end;
			else
				SetGuard(false);
			end;
		end);
	end;
	NeverloseUI:AddSignal(InputFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not NeverloseUI.Global3DRenderMode then
			if DragInput then
				return;
			end;
			DragInput = input;
			Dragging = false;
			DragStart = input.Position;
			StartPos = MoveFrame.Position;
			local input_end;
			input_end = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					DragInput = nil;
					Dragging = false;
					NeverloseUI.SetInputSink(SinkName, false);
					SettleTime = 0;
					input_end:Disconnect();
				end;
			end);
		end;
	end));
	NeverloseUI:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if not DragInput then
			return;
		end;
		local IsMove = false;
		if DragInput.UserInputType == Enum.UserInputType.Touch then
			IsMove = (input == DragInput);
		else
			IsMove = (input.UserInputType == Enum.UserInputType.MouseMovement);
		end;
		if not IsMove or not MoveFrame.Parent or NeverloseUI.Global3DRenderMode then
			return;
		end;
		local Delta = input.Position - DragStart;
		if not Dragging then
			if Delta.Magnitude < DRAG_THRESHOLD then
				return;
			end;
			Dragging = true;
			NeverloseUI.SetInputSink(SinkName, true);
			DragStart = input.Position;
			StartPos = MoveFrame.Position;
			CurX, CurY = StartPos.X.Offset, StartPos.Y.Offset;
			TgtX, TgtY = CurX, CurY;
			SpringVX, SpringVY = 0, 0;
			SettleTime = 0;
			DragTime = 0;
			VelX = 0;
			LastX, LastT = input.Position.X, os.clock();
			if MoveFrame.Rotation ~= 0 then
				MoveFrame.Rotation = 0;
			end;
			StartTilt();
			return;
		end;
		local Now = os.clock();
		local Dtm = math.max(Now - LastT, 1 / 240);
		local Vx = (input.Position.X - LastX) / Dtm;
		VelX += (Vx - VelX) * 0.35;
		LastX, LastT = input.Position.X, Now;
		local Screen = NeverloseUI.ScreenGui.AbsoluteSize;
		local OffsetX = StartPos.X.Offset + Delta.X;
		local OffsetY = StartPos.Y.Offset + Delta.Y;
		local CenterX = StartPos.X.Scale * Screen.X + OffsetX;
		local CenterY = StartPos.Y.Scale * Screen.Y + OffsetY;
		OffsetX += math.clamp(CenterX, 20, math.max(20, Screen.X - 20)) - CenterX;
		OffsetY += math.clamp(CenterY, 20, math.max(20, Screen.Y - 20)) - CenterY;
		TgtX, TgtY = OffsetX, OffsetY;
		if NeverloseUI.GetDragRate() then
			StartFollow();
		else
			StopFollow();
			CurX, CurY = OffsetX, OffsetY;
			SpringVX, SpringVY = 0, 0;
			ApplyFollow(CurX, CurY);
		end;
	end));
end;
NeverloseUI.Rounding = LPH_NO_VIRTUALIZE(function(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0);
	return math.floor(num * mult + 0.5) / mult;
end);
NeverloseUI.Http = {};
do
	local Http = NeverloseUI.Http;
	local Wrapped = setmetatable({}, { __mode = "k" });
	local function ColorToHex(Value)
		local Ok, Hex = pcall(function()
			return Value:ToHex();
		end);
		if Ok and Hex then
			return "#" .. Hex;
		end;
		return string.format("#%02X%02X%02X", math.floor(Value.R * 255 + 0.5), math.floor(Value.G * 255 + 0.5), math.floor(Value.B * 255 + 0.5));
	end;
	local function Sanitize(Value, Depth)
		local Kind = typeof(Value);
		if Kind == "number" then
			if Value ~= Value or Value == math.huge or Value == -math.huge then
				return 0;
			end;
			return Value;
		end;
		if Kind == "string" or Kind == "boolean" then
			return Value;
		end;
		if Kind == "Color3" then
			return ColorToHex(Value);
		end;
		if Kind == "EnumItem" then
			return tostring(Value);
		end;
		if Kind == "Instance" then
			return Value.Name;
		end;
		if Kind == "table" then
			if Depth > 8 then
				return nil;
			end;
			local Out = {};
			for Key, Item in next, Value do
				local Clean = Sanitize(Item, Depth + 1);
				if Clean ~= nil then
					Out[type(Key) == "number" and Key or tostring(Key)] = Clean;
				end;
			end;
			return Out;
		end;
		if Kind == "nil" or Kind == "function" or Kind == "thread" then
			return nil;
		end;
		return tostring(Value);
	end;
	function Http.Encode(Value)
		local Ok, Result = pcall(function()
			return HttpService:JSONEncode(Sanitize(Value, 0));
		end);
		if Ok then
			return Result;
		end;
		return "null";
	end;
	function Http.Decode(Text)
		local Ok, Result = pcall(function()
			return HttpService:JSONDecode(Text);
		end);
		if Ok then
			return Result;
		end;
		return nil;
	end;
	function Http.ToText(Value)
		local Kind = typeof(Value);
		if Kind == "string" then
			return Value;
		end;
		if Kind == "Color3" then
			return ColorToHex(Value);
		end;
		if Kind == "table" then
			return Http.Encode(Value);
		end;
		return tostring(Value);
	end;
	function Http.Format(Text, Context)
		if type(Text) ~= "string" or not string.find(Text, "{", 1, true) then
			return Text;
		end;
		Context = Context or {};
		return (string.gsub(Text, "{([%w_:%.%-]+)}", function(Key)
			if string.lower(string.sub(Key, 1, 5)) == "flag:" then
				local Object = (NeverloseUI.Flags or {})[string.sub(Key, 6)];
				if Object and type(Object.GetValue) == "function" then
					local Ok, Value = pcall(Object.GetValue, Object);
					if Ok then
						return Http.ToText(Value);
					end;
				end;
				return "";
			end;
			local Value = Context[string.lower(Key)];
			if Value ~= nil then
				return Http.ToText(Value);
			end;
			return nil;
		end));
	end;
	local function FormatDeep(Value, Context, Depth)
		Depth = Depth or 0;
		if type(Value) == "string" then
			return Http.Format(Value, Context);
		end;
		if type(Value) == "table" and Depth < 8 then
			local Out = {};
			for Key, Item in next, Value do
				Out[Key] = FormatDeep(Item, Context, Depth + 1);
			end;
			return Out;
		end;
		return Value;
	end;
	Http.FormatDeep = FormatDeep;
	function Http.BuildContext(Params, Args)
		local LocalPlayer = Players.LocalPlayer;
		local Packed = {};
		local Count = (Args and Args.n) or 0;
		for Index = 1, Count do
			Packed[Index] = Args[Index];
		end;
		local Value = Packed[1];
		local ValueJson = "null";
		if Value ~= nil then
			ValueJson = string.sub(Http.Encode({ Value }), 2, -2);
		end;
		local Text = Http.ToText(Value);
		return {
			value       = Value,
			value_json  = ValueJson,
			value_url   = HttpService:UrlEncode(Text),
			name        = Params and Params.Name or "",
			flag        = Params and (Params.Flag or Params.Key or Params.ConfigKey) or "",
			player      = LocalPlayer and LocalPlayer.Name or "",
			displayname = LocalPlayer and LocalPlayer.DisplayName or "",
			userid      = LocalPlayer and LocalPlayer.UserId or 0,
			placeid     = game.PlaceId,
			gameid      = game.GameId,
			jobid       = game.JobId,
			time        = os.date("!%Y-%m-%d %H:%M:%S") .. " UTC",
			iso         = os.date("!%Y-%m-%dT%H:%M:%SZ"),
			timestamp   = os.time(),
			args        = Http.Encode(Packed),
		};
	end;
	local function Trim(Text)
		return (string.match(Text, "^%s*(.-)%s*$"));
	end;
	local function PickRequester()
		if typeof(request) == "function" then
			return request;
		end;
		if typeof(http_request) == "function" then
			return http_request;
		end;
		if syn and typeof(syn.request) == "function" then
			return syn.request;
		end;
		if http and typeof(http.request) == "function" then
			return http.request;
		end;
		if fluxus and typeof(fluxus.request) == "function" then
			return fluxus.request;
		end;
		return nil;
	end;
	local function Execute(Config)
		if type(Config) == "string" then
			Config = { Url = Config };
		end;
		Config = Config or {};
		local Response = {
			Success = false,
			StatusCode = 0,
			StatusMessage = "",
			Body = "",
			Headers = {},
			Json = nil,
			Error = nil,
		};
		local Context = Config.Context or {};
		local Url = Config.Url;
		if type(Url) == "function" then
			local Ok, Result = pcall(Url);
			Url = Ok and Result or nil;
		end;
		Url = Trim(Http.Format(tostring(Url or ""), Context));
		if not string.match(Url, "^https?://[^%s]+$") then
			Response.Error = "Invalid URL (it must start with http:// or https://)";
			return Response;
		end;
		local BodyValue = Config.Body;
		if BodyValue == nil then
			BodyValue = Config.Json;
		end;
		local Method = string.upper(tostring(Config.Method or ((BodyValue ~= nil) and "POST" or "GET")));
		if type(Config.Query) == "table" then
			local Parts = {};
			for Key, Item in next, Config.Query do
				table.insert(Parts, HttpService:UrlEncode(tostring(Key)) .. "=" .. HttpService:UrlEncode(Http.ToText(FormatDeep(Item, Context))));
			end;
			table.sort(Parts);
			if #Parts > 0 then
				Url = Url .. (string.find(Url, "?", 1, true) and "&" or "?") .. table.concat(Parts, "&");
			end;
		end;
		local Headers = {};
		if type(Config.Headers) == "table" then
			for Key, Item in next, Config.Headers do
				Headers[tostring(Key)] = Http.Format(tostring(Item), Context);
			end;
		end;
		if type(BodyValue) == "function" then
			local Ok, Result = pcall(BodyValue, Context);
			BodyValue = Ok and Result or nil;
		end;
		local Body;
		if type(BodyValue) == "table" then
			if not Config.PreFormatted then
				BodyValue = FormatDeep(BodyValue, Context);
			end;
			Body = Http.Encode(BodyValue);
			local HasContentType = false;
			for Key in next, Headers do
				if string.lower(Key) == "content-type" then
					HasContentType = true;
				end;
			end;
			if not HasContentType then
				Headers["Content-Type"] = "application/json";
			end;
		elseif BodyValue ~= nil then
			Body = tostring(BodyValue);
			if not Config.PreFormatted then
				Body = Http.Format(Body, Context);
			end;
		end;
		if Method == "GET" or Method == "HEAD" then
			Body = nil;
		end;
		local Retries = math.max(0, math.floor(tonumber(Config.Retries) or 0));
		local Requester = PickRequester();
		for Attempt = 0, Retries do
			local Ok, Result;
			if Requester then
				Ok, Result = pcall(Requester, {
					Url = Url,
					Method = Method,
					Headers = Headers,
					Body = Body,
				});
			elseif Method == "GET" and next(Headers) == nil then
				Ok, Result = pcall(function()
					return { Success = true, StatusCode = 200, Body = game:HttpGet(Url) };
				end);
			else
				Ok, Result = pcall(function()
					return HttpService:RequestAsync({
						Url = Url,
						Method = Method,
						Headers = Headers,
						Body = Body,
					});
				end);
			end;
			if Ok and type(Result) == "table" then
				local Status = tonumber(Result.StatusCode or Result.status_code or Result.Status) or 0;
				Response.StatusCode = Status;
				Response.StatusMessage = tostring(Result.StatusMessage or Result.status_message or "");
				Response.Body = tostring(Result.Body or Result.body or "");
				Response.Headers = (type(Result.Headers) == "table" and Result.Headers) or {};
				local Success = Result.Success;
				if Success == nil then
					Success = Status >= 200 and Status < 300;
				end;
				Response.Success = Success == true;
				Response.Error = nil;
				Response.Json = nil;
				if Config.Parse ~= false and string.find(Response.Body, "^%s*[%[{]") then
					Response.Json = Http.Decode(Response.Body);
				end;
			else
				Response.Success = false;
				Response.Error = tostring(Result);
			end;
			if Response.Success or Attempt >= Retries then
				break;
			end;
			local Delay = tonumber(Config.RetryDelay) or 1;
			if Response.StatusCode == 429 then
				local RetryAfter = (type(Response.Json) == "table" and tonumber(Response.Json.retry_after)) or nil;
				if not RetryAfter then
					for Key, Item in next, Response.Headers do
						if string.lower(tostring(Key)) == "retry-after" then
							RetryAfter = tonumber(Item);
						end;
					end;
				end;
				if RetryAfter then
					Delay = math.clamp(RetryAfter, 0.2, 10);
				end;
			end;
			task.wait(Delay);
		end;
		if not Response.Success and not Response.Error then
			Response.Error = "HTTP " .. tostring(Response.StatusCode);
		end;
		return Response;
	end;
	function Http.Request(Config, Callback)
		if type(Callback) == "function" then
			task.spawn(function()
				local Response = Execute(Config);
				local Ok, Err = pcall(Callback, Response);
				if not Ok then
					warn("[NeverloseUI] Request callback error: " .. tostring(Err));
				end;
			end);
			return nil;
		end;
		return Execute(Config);
	end;
	function Http.Webhook(Url, Payload, Callback)
		local Body = Payload;
		if type(Body) ~= "table" then
			Body = { content = tostring(Payload or "") };
		end;
		if type(Body.content) == "string" and #Body.content > 2000 then
			local Copy = {};
			for Key, Item in next, Body do
				Copy[Key] = Item;
			end;
			Copy.content = string.sub(Body.content, 1, 2000);
			Body = Copy;
		end;
		return Http.Request({
			Url = Url,
			Method = "POST",
			Body = Body,
			Headers = { ["Content-Type"] = "application/json" },
			Retries = 2,
		}, Callback);
	end;
	function Http.BuildWebhookPayload(Spec, Args, Context)
		local Payload;
		if type(Spec.Payload) == "function" then
			local Ok, Result = pcall(Spec.Payload, Args[1], Context);
			if Ok then
				Payload = Result;
			end;
		elseif Spec.Payload ~= nil then
			Payload = Spec.Payload;
		end;
		if type(Payload) == "string" then
			Payload = { content = Http.Format(Payload, Context) };
		elseif type(Payload) == "table" then
			Payload = FormatDeep(Payload, Context);
		else
			Payload = {
				content = Http.Format(tostring(Spec.Content or "**{name}**: {value}"), Context),
				username = Spec.Username and Http.Format(tostring(Spec.Username), Context) or nil,
				avatar_url = Spec.AvatarUrl or Spec.AvatarURL,
				embeds = Spec.Embeds and FormatDeep(Spec.Embeds, Context) or nil,
			};
		end;
		if type(Payload.content) == "string" and #Payload.content > 2000 then
			Payload.content = string.sub(Payload.content, 1, 2000);
		end;
		return Payload;
	end;
	local function ShowResult(Spec, Response)
		local Option = Spec.Notify;
		if not Option then
			return;
		end;
		local Window = NeverloseUI.ActiveWindow;
		if not Window or not Window.Notify then
			return;
		end;
		local Info = (type(Option) == "table" and Option) or {};
		local Title, Content;
		if Response.Success then
			if Info.Success == false then
				return;
			end;
			Title = Info.Title or "Request sent";
			Content = Info.SuccessText or ("HTTP " .. tostring(Response.StatusCode));
		else
			if Info.Error == false then
				return;
			end;
			Title = Info.ErrorTitle or "Request failed";
			Content = tostring(Response.Error or ("HTTP " .. tostring(Response.StatusCode)));
		end;
		if #Content > 70 then
			Content = string.sub(Content, 1, 67) .. "...";
		end;
		Window:Notify({
			Title = Title,
			Content = Content,
			Duration = Info.Duration or 4,
			Icon = Response.Success and "lucide:check" or "lucide:triangle-alert",
		});
	end;
	local function Dispatch(Entry, Params, Args)
		local Spec = Entry.Spec;
		local State = Entry.State;
		local Value = Args[1];
		local Condition = Spec.When;
		if Condition ~= nil then
			if type(Condition) == "function" then
				local Ok, Result = pcall(Condition, table.unpack(Args, 1, Args.n));
				if not (Ok and Result) then
					return;
				end;
			elseif Value ~= Condition then
				return;
			end;
		end;
		local Delay = tonumber(Spec.Debounce);
		if Delay == nil then
			local Kind = typeof(Value);
			Delay = (Kind == "number" or Kind == "Color3") and 0.5 or 0;
		end;
		State.Token = State.Token + 1;
		local Mine = State.Token;
		local function Run()
			State.Last = os.clock();
			local Context = Http.BuildContext(Params, Args);
			local Config;
			if Entry.Webhook then
				Config = {
					Url = Spec.Url or Spec.Webhook,
					Method = "POST",
					Body = Http.BuildWebhookPayload(Spec, Args, Context),
					PreFormatted = true,
					Headers = Spec.Headers,
					Retries = (Spec.Retries == nil and 2) or Spec.Retries,
					RetryDelay = Spec.RetryDelay,
					Context = Context,
					Parse = Spec.Parse,
				};
			else
				Config = {
					Url = Spec.Url,
					Method = Spec.Method,
					Headers = Spec.Headers,
					Body = Spec.Body,
					Json = Spec.Json,
					Query = Spec.Query,
					Retries = Spec.Retries,
					RetryDelay = Spec.RetryDelay,
					Context = Context,
					Parse = Spec.Parse,
				};
			end;
			task.spawn(function()
				local Response = Execute(Config);
				ShowResult(Spec, Response);
				local Extra = table.pack(table.unpack(Args, 1, Args.n));
				NeverloseUI:FireCallback(Spec.OnResponse, "Api OnResponse", Response, table.unpack(Extra, 1, Extra.n));
				if Response.Success then
					NeverloseUI:FireCallback(Spec.OnSuccess, "Api OnSuccess", Response, table.unpack(Extra, 1, Extra.n));
				else
					NeverloseUI:FireCallback(Spec.OnError, "Api OnError", Response, table.unpack(Extra, 1, Extra.n));
				end;
			end);
		end;
		if Delay > 0 then
			task.delay(Delay, function()
				if State.Token == Mine then
					Run();
				end;
			end);
		else
			local Cooldown = tonumber(Spec.Cooldown) or 0.25;
			if os.clock() - State.Last < Cooldown then
				return;
			end;
			Run();
		end;
	end;
	local function NormalizeSpecs(Source, IsWebhook, Out)
		if Source == nil or Source == false then
			return;
		end;
		local function Add(Item)
			if type(Item) == "string" then
				Item = { Url = Item };
			end;
			if type(Item) == "table" then
				table.insert(Out, { Spec = Item, Webhook = IsWebhook, State = { Token = 0, Last = -math.huge } });
			end;
		end;
		if type(Source) == "table" and Source.Url == nil and Source[1] ~= nil then
			for _, Item in ipairs(Source) do
				Add(Item);
			end;
		else
			Add(Source);
		end;
	end;
	function Http.IsWrapped(Callback)
		return Callback ~= nil and Wrapped[Callback] == true;
	end;
	function Http.Attach(Params, UserCallback)
		local Entries = {};
		NormalizeSpecs(Params.Api, false, Entries);
		NormalizeSpecs(Params.Request, false, Entries);
		NormalizeSpecs(Params.Webhook, true, Entries);
		if #Entries == 0 then
			return nil;
		end;
		local Wrapper = function(...)
			local Args = table.pack(...);
			local Results;
			if type(UserCallback) == "function" then
				Results = table.pack(pcall(UserCallback, ...));
			end;
			for _, Entry in ipairs(Entries) do
				local Ok, Err = pcall(Dispatch, Entry, Params, Args);
				if not Ok then
					warn("[NeverloseUI] API dispatch error: " .. tostring(Err));
				end;
			end;
			if Results then
				if not Results[1] then
					error(Results[2], 0);
				end;
				return table.unpack(Results, 2, Results.n);
			end;
		end;
		Wrapped[Wrapper] = true;
		return Wrapper;
	end;
end;
function NeverloseUI:Request(Config, Callback)
	return NeverloseUI.Http.Request(Config, Callback);
end;
function NeverloseUI:Webhook(Url, Payload, Callback)
	return NeverloseUI.Http.Webhook(Url, Payload, Callback);
end;
function NeverloseUI:SendWebhook(Url, Payload, Callback)
	return NeverloseUI.Http.Webhook(Url, Payload, Callback);
end;
function NeverloseUI:JSONEncode(Value)
	return NeverloseUI.Http.Encode(Value);
end;
function NeverloseUI:JSONDecode(Text)
	return NeverloseUI.Http.Decode(Text);
end;
function NeverloseUI:FormatTemplate(Text, Context)
	return NeverloseUI.Http.Format(Text, Context);
end;
NeverloseUI.ProcessParams = LPH_NO_VIRTUALIZE(function(self , Params , Fixed)
	Params = Params or {};
	local UserCallback = Params.Callback;
	local k = Params or {};
	for i,v in next , Fixed do
		if Params[i] == nil then
			k[i] = v;
		end;
	end;
	table.clear(Fixed);
	if (k.Api ~= nil or k.Webhook ~= nil or k.Request ~= nil) and not NeverloseUI.Http.IsWrapped(k.Callback) then
		local Wrapper = NeverloseUI.Http.Attach(k, UserCallback);
		if Wrapper then
			k.Callback = Wrapper;
		end;
	end;
	return k;
end);
function NeverloseUI:ApplyLock(Frame, isLocked, lockMessage)
	local LockFunc = {
		IsLocked = isLocked == true,
	};
	local Message = tostring(lockMessage or "Locked");
	local Destroyed = false;
	local Rebuilding = false;
	local LockOverlay;
	local LockLabel;
	local RefreshLockSize = function() end;
	pcall(function()
		Frame.ClipsDescendants = true;
	end);
	local function BuildOverlay()
		if Destroyed or not Frame or not Frame.Parent then
			return;
		end;
		if LockOverlay and LockOverlay.Parent then
			LockOverlay.Visible = LockFunc.IsLocked;
			return;
		end;
		LockOverlay = Instance.new("TextButton");
		LockOverlay.Name = "LockOverlay";
		LockOverlay.Text = "";
		LockOverlay.Size = UDim2.new(1, 0, 1, 0);
		LockOverlay.BackgroundColor3 = Color3.fromRGB(10, 8, 18);
		LockOverlay.BackgroundTransparency = 0.28;
		LockOverlay.BorderSizePixel = 0;
		LockOverlay.AutoButtonColor = false;
		LockOverlay.ClipsDescendants = false;
		LockOverlay.Visible = LockFunc.IsLocked;
		LockOverlay.ZIndex = (Frame.ZIndex or 1) + 50;
		LockOverlay.Parent = Frame;
		local UICorner = Instance.new("UICorner");
		UICorner.CornerRadius = UDim.new(0, 6);
		UICorner.Parent = LockOverlay;
		local Inner = Instance.new("Frame");
		Inner.Name = "LockInner";
		Inner.AnchorPoint = Vector2.new(0.5, 0.5);
		Inner.Position = UDim2.new(0.5, 0, 0.5, 0);
		Inner.Size = UDim2.new(0, 120, 0, 20);
		Inner.BackgroundTransparency = 1;
		Inner.ClipsDescendants = false;
		Inner.ZIndex = LockOverlay.ZIndex + 1;
		Inner.Parent = LockOverlay;
		local UIListLayout = Instance.new("UIListLayout");
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
		UIListLayout.Padding = UDim.new(0, 7);
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
		UIListLayout.Parent = Inner;
		local LockIcon = Instance.new("ImageLabel");
		LockIcon.Name = "LockIcon";
		LockIcon.Size = UDim2.new(0, 15, 0, 15);
		LockIcon.BackgroundTransparency = 1;
		LockIcon.ScaleType = Enum.ScaleType.Fit;
		LockIcon.Image = NeverloseUI:GetIconId("134724289526879");
		LockIcon.ImageColor3 = Color3.fromRGB(235, 235, 235);
		LockIcon.ImageTransparency = 0.05;
		LockIcon.LayoutOrder = 1;
		LockIcon.ZIndex = LockOverlay.ZIndex + 2;
		LockIcon.Parent = Inner;
		LockLabel = Instance.new("TextLabel");
		LockLabel.Name = "LockLabel";
		LockLabel.Size = UDim2.new(0, 200, 0, 20);
		LockLabel.BackgroundTransparency = 1;
		LockLabel.Font = Enum.Font.GothamBold;
		LockLabel.Text = Message;
		LockLabel.TextSize = 13;
		LockLabel.TextColor3 = Color3.fromRGB(235, 235, 235);
		LockLabel.TextTransparency = 0.05;
		LockLabel.TextXAlignment = Enum.TextXAlignment.Left;
		LockLabel.TextYAlignment = Enum.TextYAlignment.Center;
		LockLabel.TextTruncate = Enum.TextTruncate.None;
		LockLabel.TextWrapped = false;
		LockLabel.LayoutOrder = 2;
		LockLabel.ZIndex = LockOverlay.ZIndex + 2;
		LockLabel.Parent = Inner;
		RefreshLockSize = function()
			if not LockLabel or not LockLabel.Parent then
				return;
			end;
			local TextSize = TextService:GetTextSize(
				LockLabel.Text,
				LockLabel.TextSize,
				LockLabel.Font,
				Vector2.new(math.huge, 20)
			);
			local TextWidth = math.max(40, TextSize.X);
			LockLabel.Size = UDim2.new(0, TextWidth, 0, 20);
			Inner.Size = UDim2.new(0, 22 + TextWidth, 0, 20);
		end;
		RefreshLockSize();
		local FeedbackBusy = false;
		NeverloseUI:AddSignal(LockOverlay.MouseButton1Click:Connect(function()
			if FeedbackBusy or not LockOverlay.Parent then
				return;
			end;
			FeedbackBusy = true;
			NeverloseUI.PlayAnimate(LockOverlay, TweenInfo.new(0.08), {
				BackgroundTransparency = 0.18,
			});
			task.delay(0.12, function()
				if LockOverlay and LockOverlay.Parent then
					NeverloseUI.PlayAnimate(LockOverlay, TweenInfo.new(0.12), {
						BackgroundTransparency = 0.28,
					});
				end;
				FeedbackBusy = false;
			end);
		end));
	end;
	BuildOverlay();
	NeverloseUI:AddSignal(Frame.DescendantRemoving:Connect(function(desc)
		if desc == LockOverlay and LockFunc.IsLocked and not Destroyed then
			if Rebuilding then
				return;
			end;
			Rebuilding = true;
			task.defer(function()
				BuildOverlay();
				Rebuilding = false;
			end);
		end;
	end));
	NeverloseUI:AddSignal(Frame.AncestryChanged:Connect(function(_, newParent)
		if newParent == nil then
			Destroyed = true;
		end;
	end));
	function LockFunc:SetLocked(state)
		LockFunc.IsLocked = state == true;
		if LockFunc.IsLocked and (not LockOverlay or not LockOverlay.Parent) then
			BuildOverlay();
		end;
		if LockOverlay and LockOverlay.Parent then
			LockOverlay.Visible = LockFunc.IsLocked;
		end;
		return LockFunc;
	end;
	function LockFunc:SetTextLocked(text)
		Message = tostring(text or "Locked");
		if LockLabel and LockLabel.Parent then
			LockLabel.Text = Message;
			RefreshLockSize();
		end;
		return LockFunc;
	end;
	function LockFunc:SetMessage(text)
		return LockFunc:SetTextLocked(text);
	end;
	function LockFunc:GetLocked()
		return LockFunc.IsLocked;
	end;
	LockFunc:SetLocked(LockFunc.IsLocked);
	return LockFunc;
end;
NeverloseUI.KeyConfig = nil;
NeverloseUI.KeyVerified = false;
NeverloseUI.KeyValue = nil;
NeverloseUI.KeySignal = NeverloseUI:CreateSignal(false);
NeverloseUI.KeyAttempts = { Fails = 0, LockedUntil = 0 };
NeverloseUI.KeyMaxFails = 5;
NeverloseUI.KeyLockTime = 30;
NeverloseUI.KeyStorePath = "NeverloseUI/Keys.json";
local function TrimKey(Value)
	local Text = tostring(Value or "");
	Text = Text:gsub("^%s+", "");
	Text = Text:gsub("%s+$", "");
	return Text;
end;
local KeyTrueWords = {
	["valid"] = true, ["success"] = true, ["successful"] = true, ["ok"] = true, ["true"] = true, ["yes"] = true,
	["key_valid"] = true, ["keyvalid"] = true, ["keyless"] = true, ["authenticated"] = true, ["authorized"] = true,
	["authorised"] = true, ["approved"] = true, ["verified"] = true, ["correct"] = true, ["granted"] = true,
	["allowed"] = true, ["pass"] = true, ["passed"] = true, ["active"] = true, ["activated"] = true,
	["whitelisted"] = true, ["key valid"] = true, ["key is valid"] = true, ["key verified"] = true, ["valid key"] = true,
};
local KeyFalseWords = {
	["invalid"] = true, ["fail"] = true, ["failed"] = true, ["failure"] = true, ["error"] = true, ["false"] = true,
	["no"] = true, ["key_invalid"] = true, ["key_incorrect"] = true, ["key_expired"] = true, ["key_blacklisted"] = true,
	["key_hwid_locked"] = true, ["key_banned"] = true, ["expired"] = true, ["blacklisted"] = true, ["banned"] = true,
	["incorrect"] = true, ["denied"] = true, ["unauthorized"] = true, ["unauthenticated"] = true, ["wrong"] = true,
	["not_found"] = true, ["not found"] = true, ["key not found"] = true, ["inactive"] = true, ["rejected"] = true,
	["forbidden"] = true, ["key invalid"] = true, ["key is invalid"] = true, ["invalid key"] = true,
};
local KeyStatusFields = { status = true, code = true, statuscode = true, status_code = true };
local function KeyToBool(Value, Field)
	local Kind = type(Value);
	if Kind == "boolean" then
		return Value;
	end;
	if Kind == "number" then
		if Field and KeyStatusFields[Field] then
			if Value >= 200 and Value < 300 then
				return true;
			end;
			if Value >= 300 then
				return false;
			end;
		end;
		if Value == 1 then
			return true;
		elseif Value == 0 then
			return false;
		end;
		return nil;
	end;
	if Kind == "string" then
		local Lower = Value:lower():gsub("^%s+", ""):gsub("%s+$", "");
		if KeyTrueWords[Lower] then
			return true;
		end;
		if KeyFalseWords[Lower] then
			return false;
		end;
	end;
	return nil;
end;
local KeyPrimaryFields = { "valid", "isvalid", "is_valid", "key_valid", "keyvalid", "authenticated", "authorized", "authorised", "verified", "whitelisted", "authenticated_status", "auth_status", "keystatus", "key_status" };
local KeyNestedFields = { "data", "response", "result", "body", "payload", "info", "key" };
local KeyGenericFields = { "success", "ok", "status", "state", "result", "code", "message", "statuscode", "status_code" };
local function KeyLowerMap(Tbl)
	local Map = {};
	for Key, Value in next, Tbl do
		if type(Key) == "string" then
			Map[Key:lower()] = Value;
		end;
	end;
	return Map;
end;
local function KeyDecide(Tbl, Depth)
	if type(Tbl) ~= "table" or Depth > 3 then
		return nil;
	end;
	local Map = KeyLowerMap(Tbl);
	for _, Field in ipairs(KeyPrimaryFields) do
		if Map[Field] ~= nil then
			local State = KeyToBool(Map[Field], Field);
			if State ~= nil then
				return State;
			end;
		end;
	end;
	for _, Field in ipairs(KeyNestedFields) do
		if type(Map[Field]) == "table" then
			local State = KeyDecide(Map[Field], Depth + 1);
			if State ~= nil then
				return State;
			end;
		end;
	end;
	for _, Field in ipairs(KeyGenericFields) do
		if Map[Field] ~= nil and type(Map[Field]) ~= "table" then
			local State = KeyToBool(Map[Field], Field);
			if State ~= nil then
				return State;
			end;
		end;
	end;
	return nil;
end;
local KeyReasonFields = { "reason", "message", "msg", "error", "err", "detail", "details", "description", "info", "note", "status", "code" };
local function KeyReason(Tbl, Depth)
	Depth = Depth or 0;
	if type(Tbl) ~= "table" or Depth > 3 then
		return nil;
	end;
	local Map = KeyLowerMap(Tbl);
	for _, Field in ipairs(KeyReasonFields) do
		local Value = Map[Field];
		if type(Value) == "string" and Value ~= "" then
			return Value;
		end;
	end;
	for _, Field in ipairs(KeyNestedFields) do
		if type(Map[Field]) == "table" then
			local Found = KeyReason(Map[Field], Depth + 1);
			if Found then
				return Found;
			end;
		end;
	end;
	return nil;
end;
local function NormalizeKeyResult(A, B)
	if type(A) == "string" then
		local Trimmed = TrimKey(A);
		local First = Trimmed:sub(1, 1);
		if First == "{" or First == "[" then
			local Ok, Decoded = pcall(function()
				return HttpService:JSONDecode(Trimmed);
			end);
			if Ok and type(Decoded) == "table" then
				A = Decoded;
			end;
		end;
	end;
	if type(A) == "table" then
		local State = KeyDecide(A, 0);
		if State == true then
			return true;
		end;
		return false, KeyReason(A) or "Key is invalid";
	end;
	if A == nil and B ~= nil then
		return NormalizeKeyResult(B);
	end;
	if A == true then
		if type(B) == "table" and KeyDecide(B, 0) == false then
			return false, KeyReason(B) or "Key is invalid";
		end;
		return true;
	end;
	if A == false then
		if type(B) == "table" then
			return false, KeyReason(B) or "Key is invalid";
		end;
		return false, (type(B) == "string" and B) or nil;
	end;
	local State = KeyToBool(A);
	if State == true then
		return true;
	end;
	if State == false then
		return false, (type(A) == "string" and A) or (type(B) == "string" and B) or nil;
	end;
	if type(A) == "string" and A ~= "" then
		return false, A;
	end;
	return false, "No response from key service";
end;
local function KeyRun(Fn, Timeout)
	local Done, Ok, Out = false, false, nil;
	local Thread = task.spawn(function()
		local Packed = table.pack(pcall(Fn));
		Ok = Packed[1];
		if Ok then
			Out = table.pack(table.unpack(Packed, 2, Packed.n));
		else
			Out = tostring(Packed[2]);
		end;
		Done = true;
	end);
	local Start = os.clock();
	while not Done do
		if os.clock() - Start >= Timeout then
			pcall(task.cancel, Thread);
			return false, "timeout";
		end;
		task.wait(0.05);
	end;
	return Ok, Out;
end;
local function KeyCall(Owner, Fn, Name, Style, ...)
	local Args = table.pack(...);
	local function Dot()
		return table.pack(pcall(Fn, table.unpack(Args, 1, Args.n)));
	end;
	local function Colon()
		return table.pack(pcall(Fn, Owner, table.unpack(Args, 1, Args.n)));
	end;
	local First, Second = Dot, Colon;
	if Style == "colon" or (Style == nil and (Name == "CheckKey" or Name == "GetKeyLink")) then
		First, Second = Colon, Dot;
	end;
	if Style == "dot" or Style == "colon" then
		Second = nil;
	end;
	local R1 = First();
	if R1[1] and (R1[2] ~= nil or not Second) then
		return table.unpack(R1, 2, R1.n);
	end;
	if Second then
		local R2 = Second();
		if R2[1] and R2[2] ~= nil then
			return table.unpack(R2, 2, R2.n);
		end;
		if R1[1] then
			return table.unpack(R1, 2, R1.n);
		end;
		if R2[1] then
			return table.unpack(R2, 2, R2.n);
		end;
	end;
	error(tostring(R1[2]), 0);
end;
local KeyCheckNames = {
	"CheckKey", "checkKey", "check_key", "ValidateKey", "validateKey", "validate_key", "VerifyKey", "verifyKey", "verify_key",
	"Validate", "validate", "Verify", "verify", "Check", "check", "CheckLicense", "checkLicense", "check_license",
	"Authenticate", "authenticate", "license", "License", "Redeem", "redeem", "Login", "login",
};
local KeyLinkNames = {
	"GetKeyLink", "getKeyLink", "get_key_link", "GetKeyUrl", "getKeyUrl", "get_key_url", "GetLink", "getLink", "get_link",
	"GetKey", "getKey", "get_key", "KeyLink", "keyLink", "key_link", "CopyLink", "copyLink", "copy_link", "Link", "link",
};
local function KeyOwners(Config)
	local Owners = {};
	local function Add(Value)
		if type(Value) ~= "table" then
			return;
		end;
		for _, Existing in ipairs(Owners) do
			if Existing == Value then
				return;
			end;
		end;
		table.insert(Owners, Value);
	end;
	Add(Config.Service);
	Add(Config.Library);
	Add(Config.Lib);
	Add(Config.API);
	Add(Config.Api);
	Add(Config.SDK);
	Add(Config.Provider);
	Add(Config);
	return Owners;
end;
local function KeyFind(Owner, Names, AllowString)
	for _, Name in ipairs(Names) do
		local Ok, Value = pcall(function()
			return Owner[Name];
		end);
		if Ok and (type(Value) == "function" or (AllowString and type(Value) == "string" and Value ~= "")) then
			return Value, Name;
		end;
	end;
	return nil;
end;
local function KeyTokens(Input)
	local Hwid = "";
	pcall(function()
		Hwid = (gethwid and gethwid()) or game:GetService("RbxAnalyticsService"):GetClientId();
	end);
	return {
		key = Input,
		hwid = tostring(Hwid),
		userid = tostring(LocalPlayer.UserId),
		username = tostring(LocalPlayer.Name),
		placeid = tostring(game.PlaceId),
		gameid = tostring(game.GameId),
		jobid = tostring(game.JobId),
		timestamp = tostring(os.time()),
	};
end;
local function KeyFill(Text, Tokens, Encode)
	return (tostring(Text):gsub("{(%w+)}", function(Name)
		local Value = Tokens[Name:lower()];
		if Value == nil then
			return nil;
		end;
		if Encode then
			return HttpService:UrlEncode(Value);
		end;
		return Value;
	end));
end;
local function KeyFillDeep(Value, Tokens)
	if type(Value) == "string" then
		return KeyFill(Value, Tokens, false);
	end;
	if type(Value) == "table" then
		local Out = {};
		for Key, Item in next, Value do
			Out[Key] = KeyFillDeep(Item, Tokens);
		end;
		return Out;
	end;
	return Value;
end;
local function KeyHttpCheck(Config, Input)
	local Spec = Config.Request;
	if type(Spec) ~= "table" then
		local Url = Config.Url or Config.Endpoint;
		if type(Url) ~= "string" or Url == "" then
			return nil;
		end;
		Spec = {
			Url = Url,
			Method = Config.HttpMethod,
			Headers = Config.Headers,
			Body = Config.Body,
			SuccessField = Config.SuccessField,
			SuccessValue = Config.SuccessValue,
			SuccessText = Config.SuccessText,
			Success = Config.Success,
			StatusOnly = Config.StatusOnly,
		};
	end;
	if type(Spec.Url) ~= "string" or Spec.Url == "" then
		return nil;
	end;
	local Tokens = KeyTokens(Input);
	local Method = tostring(Spec.Method or Spec.HttpMethod or "GET"):upper();
	local Url = KeyFill(Spec.Url, Tokens, true);
	local Headers = KeyFillDeep(Spec.Headers or {}, Tokens);
	local Body = Spec.Body;
	if type(Body) == "table" then
		Body = HttpService:JSONEncode(KeyFillDeep(Body, Tokens));
		if Headers["Content-Type"] == nil then
			Headers["Content-Type"] = "application/json";
		end;
	elseif type(Body) == "string" then
		Body = KeyFill(Body, Tokens, false);
	end;
	local Requester = (syn and syn.request) or request or http_request or (http and http.request) or (fluxus and fluxus.request);
	local Text, Status;
	if Requester then
		local Response = Requester({
			Url = Url,
			Method = Method,
			Headers = Headers,
			Body = (Method ~= "GET" and Method ~= "HEAD") and Body or nil,
		});
		if type(Response) ~= "table" then
			return false, "No response from key server";
		end;
		Text = tostring(Response.Body or "");
		Status = tonumber(Response.StatusCode or Response.Status);
	elseif Method == "GET" then
		Text = tostring(game:HttpGet(Url));
		Status = 200;
	else
		return false, "HTTP requests are not supported by this executor";
	end;
	local Decoded;
	do
		local Ok, Result = pcall(function()
			return HttpService:JSONDecode(Text);
		end);
		if Ok and type(Result) == "table" then
			Decoded = Result;
		end;
	end;
	if type(Spec.Success) == "function" then
		local Ok, A, B = pcall(Spec.Success, Decoded or Text, Status, Text);
		if not Ok then
			return false, "Validation error";
		end;
		return NormalizeKeyResult(A, B);
	end;
	if Spec.SuccessField then
		local Value = Decoded;
		for Part in tostring(Spec.SuccessField):gmatch("[^%.]+") do
			if type(Value) == "table" then
				Value = Value[Part];
			else
				Value = nil;
				break;
			end;
		end;
		local Pass;
		if Spec.SuccessValue ~= nil then
			Pass = Value == Spec.SuccessValue;
		else
			Pass = KeyToBool(Value) == true;
		end;
		if Pass then
			return true;
		end;
		return false, KeyReason(Decoded) or "Key is invalid";
	end;
	if Spec.SuccessText then
		if Text:find(tostring(Spec.SuccessText), 1, true) then
			return true;
		end;
		return false, KeyReason(Decoded) or "Key is invalid";
	end;
	if Decoded then
		return NormalizeKeyResult(Decoded);
	end;
	local Plain = KeyToBool(TrimKey(Text));
	if Plain ~= nil then
		return Plain, (not Plain) and "Key is invalid" or nil;
	end;
	if Spec.StatusOnly == true and Status then
		if Status >= 200 and Status < 300 then
			return true;
		end;
		return false, "Key is invalid";
	end;
	return false, "Unexpected response from key server";
end;
local function KeyNotify(Title, Content, Icon)
	pcall(function()
		NeverloseUI.Notifier.new({
			Title = Title,
			Content = Content,
			Duration = 3.5,
			Icon = Icon or "lucide:key",
		});
	end);
end;
function NeverloseUI:SetKeySystem(Config)
	if type(Config) == "function" then
		Config = { Validate = Config };
	elseif type(Config) == "table" and Config[1] ~= nil and type(Config[1]) == "string" and Config.Keys == nil then
		Config = { Keys = Config };
	end;
	if type(Config) == "table" then
		NeverloseUI.KeyConfig = Config;
	end;
	return NeverloseUI;
end;
function NeverloseUI:IsKeyVerified()
	return NeverloseUI.KeyVerified == true;
end;
function NeverloseUI:_SetKeyVerified(State, Value)
	State = State == true;
	NeverloseUI.KeyVerified = State;
	NeverloseUI.KeyValue = State and Value or nil;
	NeverloseUI.KeySignal:SetValue(State);
end;
function NeverloseUI:ResetKey()
	NeverloseUI:_SetKeyVerified(false);
	return NeverloseUI;
end;
local function KeyExtractLink(A, B)
	if type(A) == "string" and A ~= "" then
		return A;
	end;
	if type(A) == "table" then
		local Map = KeyLowerMap(A);
		for _, Field in ipairs({ "link", "url", "key_link", "keylink", "href" }) do
			if type(Map[Field]) == "string" and Map[Field] ~= "" then
				return Map[Field];
			end;
		end;
		local Reason = KeyReason(A);
		return nil, Reason;
	end;
	if type(B) == "string" and B ~= "" and (B:find("^https?://") or A == true) then
		return B;
	end;
	return nil, (type(B) == "string" and B) or nil;
end;
function NeverloseUI:GetKeyLink()
	local Config = NeverloseUI.KeyConfig;
	if not Config then
		return nil, "Key system is not configured";
	end;
	local Timeout = tonumber(Config.Timeout) or 25;
	local Source = Config.GetKeyLink or Config.KeyLink or Config.Link or Config.GetLink or Config.GetKey;
	if type(Source) == "string" and Source ~= "" then
		return Source;
	end;
	local LastError;
	local function Try(Fn)
		local Ok, R = KeyRun(Fn, Timeout);
		if not Ok then
			LastError = (R == "timeout" and "Key link request timed out") or "Failed to get key link";
			return nil;
		end;
		local Link, Err = KeyExtractLink(R[1], R[2]);
		if Link then
			return Link;
		end;
		LastError = Err or LastError;
		return nil;
	end;
	if type(Source) == "function" then
		local Link = Try(function()
			return Source();
		end);
		if Link then
			return Link;
		end;
	end;
	for _, Owner in ipairs(KeyOwners(Config)) do
		local Member, Name = KeyFind(Owner, KeyLinkNames, true);
		if type(Member) == "string" then
			return Member;
		end;
		if Member then
			local Link = Try(function()
				return KeyCall(Owner, Member, Name, Config.CallStyle);
			end);
			if Link then
				return Link;
			end;
		end;
	end;
	return nil, LastError or "No key link configured";
end;
function NeverloseUI:CopyKeyLink()
	local Link, Err = NeverloseUI:GetKeyLink();
	if not Link then
		return false, Err;
	end;
	local CopyFn = setclipboard or toclipboard or (syn and syn.write_clipboard);
	local Copied = false;
	if CopyFn then
		Copied = pcall(CopyFn, Link) == true;
	end;
	return true, Link, Copied;
end;
function NeverloseUI:CheckKey(Value)
	local Config = NeverloseUI.KeyConfig;
	if not Config then
		return false, "Key system is not configured";
	end;
	if Config.Keyless == true then
		return true;
	end;
	local Input = TrimKey(Value);
	if Input == "" then
		return false, "Key is empty";
	end;
	local Timeout = tonumber(Config.Timeout) or 25;
	local function Failed(Reason)
		if Reason == "timeout" then
			return false, "Validation timed out";
		end;
		return false, "Validation error";
	end;
	local List = Config.Keys or Config.ValidKeys;
	if type(List) == "table" then
		local Sensitive = Config.CaseSensitive ~= false;
		for _, Item in next, List do
			local A, B = TrimKey(Item), Input;
			if not Sensitive then
				A, B = A:lower(), B:lower();
			end;
			if A == B then
				return true;
			end;
		end;
	end;
	local Validate;
	for _, Field in ipairs({ "Validate", "Validator", "CheckKey", "ValidateKey", "VerifyKey", "Verify", "Check" }) do
		if type(Config[Field]) == "function" then
			Validate = Config[Field];
			break;
		end;
	end;
	if Validate then
		local Ok, R = KeyRun(function()
			return Validate(Input);
		end, Timeout);
		if not Ok then
			warn("[NeverloseUI] Key validator error: " .. tostring(R));
			return Failed(R);
		end;
		return NormalizeKeyResult(R[1], R[2]);
	end;
	if type(Config.Service) == "function" then
		local Service = Config.Service;
		local Ok, R = KeyRun(function()
			return Service(Input);
		end, Timeout);
		if not Ok then
			warn("[NeverloseUI] Key service error: " .. tostring(R));
			return Failed(R);
		end;
		return NormalizeKeyResult(R[1], R[2]);
	end;
	do
		local Ok, A, B = (function()
			local RunOk, R = KeyRun(function()
				return KeyHttpCheck(Config, Input);
			end, Timeout);
			if not RunOk then
				return false, R;
			end;
			return true, R[1], R[2];
		end)();
		if not Ok then
			warn("[NeverloseUI] Key request error: " .. tostring(A));
			return Failed(A);
		end;
		if A ~= nil then
			return A == true, (A ~= true and type(B) == "string" and B) or nil;
		end;
	end;
	for _, Owner in ipairs(KeyOwners(Config)) do
		local Member, Name = KeyFind(Owner, KeyCheckNames, false);
		if Member then
			local Ok, R = KeyRun(function()
				return KeyCall(Owner, Member, Name, Config.CallStyle, Input);
			end, Timeout);
			if not Ok then
				warn("[NeverloseUI] Key service error: " .. tostring(R));
				return Failed(R);
			end;
			return NormalizeKeyResult(R[1], R[2]);
		end;
	end;
	if type(List) == "table" then
		return false, "Key is invalid";
	end;
	return false, "Key system is not configured";
end;
function NeverloseUI:VerifyKey(Value)
	local Attempts = NeverloseUI.KeyAttempts;
	local Now = os.clock();
	if Now < Attempts.LockedUntil then
		return false, "Too many attempts, wait " .. tostring(math.ceil(Attempts.LockedUntil - Now)) .. "s";
	end;
	local Ok, Reason = NeverloseUI:CheckKey(Value);
	if Ok then
		Attempts.Fails = 0;
		NeverloseUI:_SetKeyVerified(true, TrimKey(Value));
		return true;
	end;
	if TrimKey(Value) ~= "" then
		Attempts.Fails = Attempts.Fails + 1;
		if Attempts.Fails >= NeverloseUI.KeyMaxFails then
			Attempts.Fails = 0;
			Attempts.LockedUntil = os.clock() + NeverloseUI.KeyLockTime;
			Reason = "Too many attempts, wait " .. tostring(NeverloseUI.KeyLockTime) .. "s";
		end;
	end;
	return false, Reason or "Key is invalid";
end;
function NeverloseUI:ReadSavedKey(Name)
	local Store = NeverloseUI:_ReadJson(NeverloseUI.KeyStorePath);
	if Store and type(Store[Name]) == "string" and Store[Name] ~= "" then
		return Store[Name];
	end;
	return nil;
end;
function NeverloseUI:WriteSavedKey(Name, Value)
	local Store = NeverloseUI:_ReadJson(NeverloseUI.KeyStorePath) or {};
	Store[Name] = Value;
	return NeverloseUI:_WriteJson(NeverloseUI.KeyStorePath, Store);
end;
function NeverloseUI:ApplyKeyLock(Frame, Wanted)
	local KeyLock = { Wanted = Wanted == true };
	local Cover, SignalConn;
	local Destroyed = false;
	local function Active()
		return KeyLock.Wanted and not NeverloseUI.KeyVerified and not Destroyed;
	end;
	local function RemoveCover(Instant)
		local Old = Cover;
		Cover = nil;
		if not Old then
			return;
		end;
		if Instant or not Old.Parent then
			Old:Destroy();
			return;
		end;
		NeverloseUI.PlayAnimate(Old, TweenInfo.new(0.2), { GroupTransparency = 1 });
		task.delay(0.25, function()
			Old:Destroy();
		end);
	end;
	local function BuildCover()
		if not Active() or (Cover and Cover.Parent) or not Frame.Parent then
			return;
		end;
		local Accent = NeverloseUI._ThemeAccent or NeverloseUI.AccentColor;
		local Red = Color3.fromRGB(255, 102, 105);
		local Z = (Frame.ZIndex or 1) + 70;
		pcall(function()
			Frame.ClipsDescendants = true;
		end);
		local P = Instance.new("CanvasGroup");
		P.Name = NeverloseUI.RandomString();
		P.Size = UDim2.new(1, 0, 1, 0);
		P.BackgroundColor3 = Color3.fromRGB(12, 10, 22);
		P.BackgroundTransparency = 0.04;
		P.BorderSizePixel = 0;
		P.GroupTransparency = 1;
		P.Active = true;
		P.ZIndex = Z;
		P.Parent = Frame;
		local PCorner = Instance.new("UICorner");
		PCorner.CornerRadius = UDim.new(0, 6);
		PCorner.Parent = P;
		local PStroke = Instance.new("UIStroke");
		PStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		PStroke.Thickness = 1;
		PStroke.Color = Accent;
		PStroke.Transparency = 0.5;
		PStroke.Parent = P;
		Cover = P;
		local Box = Instance.new("TextBox");
		Box.AnchorPoint = Vector2.new(0, 0.5);
		Box.Position = UDim2.new(0, 5, 0.5, 0);
		Box.Size = UDim2.new(1, -135, 0.78, 0);
		Box.BackgroundColor3 = Color3.fromRGB(24, 22, 38);
		Box.BorderSizePixel = 0;
		Box.ClearTextOnFocus = false;
		Box.Font = Enum.Font.GothamMedium;
		Box.PlaceholderText = "Enter key...";
		Box.PlaceholderColor3 = Color3.fromRGB(125, 125, 145);
		Box.Text = "";
		Box.TextColor3 = Color3.fromRGB(235, 235, 245);
		Box.TextSize = 12;
		Box.TextXAlignment = Enum.TextXAlignment.Left;
		Box.ClipsDescendants = true;
		Box.ZIndex = Z + 2;
		Box.Parent = P;
		local BoxCorner = Instance.new("UICorner");
		BoxCorner.CornerRadius = UDim.new(0, 5);
		BoxCorner.Parent = Box;
		local BoxPad = Instance.new("UIPadding");
		BoxPad.PaddingLeft = UDim.new(0, 8);
		BoxPad.PaddingRight = UDim.new(0, 6);
		BoxPad.Parent = Box;
		local GetBtn = Instance.new("TextButton");
		GetBtn.AnchorPoint = Vector2.new(1, 0.5);
		GetBtn.Position = UDim2.new(1, -62, 0.5, 0);
		GetBtn.Size = UDim2.new(0, 58, 0.78, 0);
		GetBtn.BackgroundColor3 = Color3.fromRGB(34, 32, 52);
		GetBtn.BorderSizePixel = 0;
		GetBtn.AutoButtonColor = false;
		GetBtn.Font = Enum.Font.GothamBold;
		GetBtn.Text = "Get Key";
		GetBtn.TextSize = 11;
		GetBtn.TextColor3 = Color3.fromRGB(235, 235, 245);
		GetBtn.ZIndex = Z + 2;
		GetBtn.Parent = P;
		local GetCorner = Instance.new("UICorner");
		GetCorner.CornerRadius = UDim.new(0, 5);
		GetCorner.Parent = GetBtn;
		local VerBtn = Instance.new("TextButton");
		VerBtn.AnchorPoint = Vector2.new(1, 0.5);
		VerBtn.Position = UDim2.new(1, -5, 0.5, 0);
		VerBtn.Size = UDim2.new(0, 52, 0.78, 0);
		VerBtn.BackgroundColor3 = Accent;
		VerBtn.BorderSizePixel = 0;
		VerBtn.AutoButtonColor = false;
		VerBtn.Font = Enum.Font.GothamBold;
		VerBtn.Text = "Verify";
		VerBtn.TextSize = 11;
		VerBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
		VerBtn.ZIndex = Z + 2;
		VerBtn.Parent = P;
		local VerCorner = Instance.new("UICorner");
		VerCorner.CornerRadius = UDim.new(0, 5);
		VerCorner.Parent = VerBtn;
		NeverloseUI:ApplyFont(Box);
		NeverloseUI:ApplyFont(GetBtn);
		NeverloseUI:ApplyFont(VerBtn);
		NeverloseUI.PlayAnimate(P, TweenInfo.new(0.18), { GroupTransparency = 0 });
		local Busy = false;
		local function Submit()
			if Busy or Cover ~= P then
				return;
			end;
			Busy = true;
			VerBtn.Text = "...";
			local Ok, Reason = NeverloseUI:VerifyKey(Box.Text);
			Busy = false;
			if Ok or Cover ~= P then
				return;
			end;
			VerBtn.Text = "Verify";
			Box.Text = "";
			Box.PlaceholderText = string.sub(tostring(Reason or "Key is invalid"), 1, 22);
			PStroke.Color = Red;
			NeverloseUI.PlayAnimate(PStroke, TweenInfo.new(0.4), { Color = Accent });
		end;
		NeverloseUI:AddSignal(VerBtn.MouseButton1Click:Connect(Submit));
		NeverloseUI:AddSignal(Box.FocusLost:Connect(function(Enter)
			if Enter then
				Submit();
			end;
		end));
		NeverloseUI:AddSignal(GetBtn.MouseButton1Click:Connect(function()
			local Ok, Link, Copied = NeverloseUI:CopyKeyLink();
			if Ok then
				KeyNotify("Get Key", Copied and "Key link copied to clipboard." or tostring(Link), "lucide:link");
			else
				KeyNotify("Get Key", tostring(Link or "No key link configured"), "lucide:triangle-alert");
			end;
		end));
	end;
	local function Refresh()
		if Active() then
			BuildCover();
		else
			RemoveCover();
		end;
	end;
	local function Subscribe()
		if SignalConn then
			return;
		end;
		SignalConn = NeverloseUI.KeySignal:Connect(function(Value)
			if Destroyed then
				return;
			end;
			if Value then
				if Cover then
					local Current = Cover;
					local CurrentStroke = Current:FindFirstChildOfClass("UIStroke");
					if CurrentStroke then
						NeverloseUI.PlayAnimate(CurrentStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(135, 255, 143), Transparency = 0 });
					end;
					task.delay(0.3, function()
						if Cover == Current then
							RemoveCover();
						end;
					end);
				end;
			else
				Refresh();
			end;
		end);
		NeverloseUI:AddSignal(Frame.Destroying:Connect(function()
			Destroyed = true;
			RemoveCover(true);
		end));
	end;
	function KeyLock:SetRequired(State)
		KeyLock.Wanted = State == true;
		if KeyLock.Wanted then
			Subscribe();
		end;
		Refresh();
		return KeyLock;
	end;
	function KeyLock:IsActive()
		return Active();
	end;
	if KeyLock.Wanted then
		Subscribe();
		Refresh();
	end;
	return KeyLock;
end;
function NeverloseUI:RunKeyGate(Window, Cfg)
	Cfg = type(Cfg) == "table" and Cfg or {};
	local Gate = { Ready = false, Closing = false };
	local Accent = NeverloseUI._ThemeAccent or NeverloseUI.AccentColor;
	local PanelColor = Color3.fromRGB(9, 11, 18);
	local Muted = Color3.fromRGB(150, 155, 172);
	local Red = Color3.fromRGB(255, 102, 105);
	local Green = Color3.fromRGB(135, 255, 143);
	local FinalW = tonumber(Cfg.Width) or 320;
	local FinalH = tonumber(Cfg.Height) or 226;
	local LogoImage = tostring(Cfg.Logo or Window.Logo or NeverloseUI.GlobalLogo or "");
	local Host = Window.Root;
	local Z = 5000;
	local Quint = Enum.EasingStyle.Quint;
	local function Tween(Object, Time, Props, Style, Direction)
		return NeverloseUI.PlayAnimate(Object, TweenInfo.new(Time, Style or Enum.EasingStyle.Quad, Direction or Enum.EasingDirection.Out), Props);
	end;
	local function New(Class, Props, Parent)
		local Object = Instance.new(Class);
		Object.Name = NeverloseUI.RandomString();
		for Key, Value in next, Props do
			Object[Key] = Value;
		end;
		Object.Parent = Parent;
		NeverloseUI:ApplyFont(Object);
		return Object;
	end;
	local Cover = New("CanvasGroup", {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = PanelColor,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Active = true,
		ZIndex = Z,
	}, Host);
	New("UICorner", { CornerRadius = UDim.new(0, 6) }, Cover);
	local Content = New("CanvasGroup", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.fromOffset(FinalW, FinalH),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		ZIndex = Z + 1,
	}, Cover);
	local ContentScale = New("UIScale", { Scale = 0.96 }, Content);
	local GateLogo = New("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0, 30),
		Size = UDim2.fromOffset(56, 52),
		BackgroundTransparency = 1,
		Image = LogoImage,
		ImageColor3 = NeverloseUI.IconColor or Color3.new(1, 1, 1),
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = Z + 2,
	}, Content);
	pcall(function()
		if Window.Icon and Window.Icon ~= "" and not Cfg.Logo then
			NeverloseUI:SetIconMode(GateLogo, Window.Icon);
		end;
		GateLogo.ImageColor3 = NeverloseUI.IconColor or GateLogo.ImageColor3;
		NeverloseUI:OnThemeChanged(function()
			if GateLogo and GateLogo.Parent then
				GateLogo.ImageColor3 = NeverloseUI.IconColor or GateLogo.ImageColor3;
			end;
		end);
	end);
	New("TextLabel", {
		Position = UDim2.new(0, 0, 0, 66),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = tostring(Cfg.Title or Window.Name or "Key System"),
		TextSize = 16,
		TextColor3 = Color3.fromRGB(240, 240, 250),
		ZIndex = Z + 2,
	}, Content);
	New("TextLabel", {
		Position = UDim2.new(0, 0, 0, 87),
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = tostring(Cfg.Content or Cfg.Description or "Enter your key to continue"),
		TextSize = 12,
		TextColor3 = Muted,
		ZIndex = Z + 2,
	}, Content);
	local KeyBox = New("TextBox", {
		Position = UDim2.new(0, 20, 0, 118),
		Size = UDim2.new(1, -40, 0, 34),
		BackgroundColor3 = Color3.fromRGB(20, 22, 34),
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		Font = Enum.Font.GothamMedium,
		PlaceholderText = tostring(Cfg.Placeholder or "Enter key..."),
		PlaceholderColor3 = Color3.fromRGB(125, 125, 145),
		Text = "",
		TextColor3 = Color3.fromRGB(235, 235, 245),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClipsDescendants = true,
		ZIndex = Z + 2,
	}, Content);
	New("UICorner", { CornerRadius = UDim.new(0, 7) }, KeyBox);
	New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, KeyBox);
	local GetBtn = New("TextButton", {
		Position = UDim2.new(0, 20, 0, 162),
		Size = UDim2.new(0.5, -24, 0, 34),
		BackgroundColor3 = Color3.fromRGB(28, 30, 46),
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		Text = tostring(Cfg.GetKeyText or "Get Key"),
		TextSize = 13,
		TextColor3 = Color3.fromRGB(235, 235, 245),
		ZIndex = Z + 2,
	}, Content);
	New("UICorner", { CornerRadius = UDim.new(0, 7) }, GetBtn);
	local VerifyBtn = New("TextButton", {
		Position = UDim2.new(0.5, 4, 0, 162),
		Size = UDim2.new(0.5, -24, 0, 34),
		BackgroundColor3 = Accent,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		Text = tostring(Cfg.VerifyText or "Verify"),
		TextSize = 13,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = Z + 2,
	}, Content);
	New("UICorner", { CornerRadius = UDim.new(0, 7) }, VerifyBtn);
	local Status = New("TextLabel", {
		Position = UDim2.new(0, 10, 0, 204),
		Size = UDim2.new(1, -20, 0, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = "",
		TextSize = 11,
		TextColor3 = Muted,
		ZIndex = Z + 2,
	}, Content);
	local CloseBtn;
	if Cfg.Closable ~= false then
		CloseBtn = New("TextButton", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -10, 0, 10),
			Size = UDim2.fromOffset(24, 24),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			Text = "X",
			TextSize = 13,
			TextColor3 = Muted,
			ZIndex = Z + 3,
		}, Cover);
	end;
	local function Hover(Button, Base, Over)
		NeverloseUI:AddSignal(Button.MouseEnter:Connect(function()
			Tween(Button, 0.12, { BackgroundColor3 = Over });
		end));
		NeverloseUI:AddSignal(Button.MouseLeave:Connect(function()
			Tween(Button, 0.12, { BackgroundColor3 = Base });
		end));
	end;
	Hover(GetBtn, GetBtn.BackgroundColor3, Color3.fromRGB(40, 43, 64));
	Hover(VerifyBtn, Accent, Accent:Lerp(Color3.new(1, 1, 1), 0.18));
	local function SetStatus(Text, Color)
		Status.Text = tostring(Text or "");
		Status.TextColor3 = Color or Muted;
	end;
	local function Shake()
		for _, Offset in ipairs({ -8, 8, -5, 5, 0 }) do
			Tween(Content, 0.05, { Position = UDim2.new(0.5, Offset, 0.5, 0) });
			task.wait(0.05);
		end;
	end;
	local function FinishMenuIcon()
		local Icon = Window._MenuIcon;
		if Icon then
			pcall(function()
				if Icon.AutoHide then
					Icon:OnWindowToggle(Window.Signal:GetValue());
				else
					Icon:SetVisible(true);
				end;
			end);
		end;
	end;
	local function Outro(KeyValue)
		Gate.Closing = true;
		local Dark = Color3.fromRGB(2, 3, 6);
		local Quart = Enum.EasingStyle.Quart;
		Tween(Content, 0.18, { GroupTransparency = 1 });
		Tween(ContentScale, 0.18, { Scale = 1.03 });
		Tween(Cover, 0.2, { BackgroundColor3 = Dark }, Quart);
		task.wait(0.2);
		local function Half(PosX)
			local H = New("Frame", {
				Position = UDim2.new(PosX, 0, 0, 0),
				Size = UDim2.new(0.5, 0, 1, 0),
				BackgroundColor3 = Dark,
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				ZIndex = Z,
			}, Host);
			return H;
		end;
		local Left, Right = Half(0), Half(0.5);
		local EdgeL = New("Frame", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			Size = UDim2.new(0, 2, 1, 0),
			BackgroundColor3 = Accent,
			BorderSizePixel = 0,
			ZIndex = Z + 1,
		}, Left);
		local EdgeR = New("Frame", {
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 2, 1, 0),
			BackgroundColor3 = Accent,
			BorderSizePixel = 0,
			ZIndex = Z + 1,
		}, Right);
		Cover:Destroy();
		Window.KeyGateActive = false;
		FinishMenuIcon();
		local Slide = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut);
		NeverloseUI.PlayAnimate(Left, Slide, { Position = UDim2.new(-0.5, 0, 0, 0) });
		NeverloseUI.PlayAnimate(Right, Slide, { Position = UDim2.new(1, 0, 0, 0) });
		task.delay(0.22, function()
			local Fade = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			NeverloseUI.PlayAnimate(Left, Fade, { BackgroundTransparency = 1 });
			NeverloseUI.PlayAnimate(Right, Fade, { BackgroundTransparency = 1 });
			NeverloseUI.PlayAnimate(EdgeL, Fade, { BackgroundTransparency = 1 });
			NeverloseUI.PlayAnimate(EdgeR, Fade, { BackgroundTransparency = 1 });
		end);
		task.wait(0.52);
		Left:Destroy();
		Right:Destroy();
		Gate.Done = true;
		NeverloseUI:FireCallback(Cfg.OnSuccess or Cfg.Callback, "KeySystem", KeyValue);
	end;
	local Busy = false;
	local SaveName = tostring(Cfg.SaveName or Window.AutoSaveKey or Window.Name or "Default");
	local function Submit()
		if not Gate.Ready or Busy or Gate.Closing then
			return;
		end;
		Busy = true;
		VerifyBtn.Text = "Verifying...";
		SetStatus("", Muted);
		local Ok, Reason = NeverloseUI:VerifyKey(KeyBox.Text);
		Busy = false;
		if Gate.Closing then
			return;
		end;
		if Ok then
			if Cfg.SaveKey == true then
				NeverloseUI:WriteSavedKey(SaveName, TrimKey(KeyBox.Text));
			end;
			VerifyBtn.Text = "Verified";
			SetStatus("Key verified", Green);
			task.spawn(Outro, NeverloseUI.KeyValue);
		else
			VerifyBtn.Text = tostring(Cfg.VerifyText or "Verify");
			SetStatus(Reason or "Key is invalid", Red);
			if Cfg.SaveKey == true then
				NeverloseUI:WriteSavedKey(SaveName, nil);
			end;
			task.spawn(Shake);
		end;
	end;
	NeverloseUI:AddSignal(VerifyBtn.MouseButton1Click:Connect(Submit));
	NeverloseUI:AddSignal(KeyBox.FocusLost:Connect(function(Enter)
		if Enter then
			Submit();
		end;
	end));
	NeverloseUI:AddSignal(GetBtn.MouseButton1Click:Connect(function()
		if not Gate.Ready or Gate.Closing then
			return;
		end;
		local Ok, Link, Copied = NeverloseUI:CopyKeyLink();
		if Ok then
			SetStatus(Copied and "Key link copied to clipboard" or tostring(Link), Green);
		else
			SetStatus(Link or "No key link configured", Red);
		end;
	end));
	if CloseBtn then
		NeverloseUI:AddSignal(CloseBtn.MouseButton1Click:Connect(function()
			if Gate.Closing then
				return;
			end;
			Gate.Closing = true;
			Tween(Cover, 0.25, { GroupTransparency = 1 });
			task.wait(0.3);
			Window:Destroy();
		end));
	end;
	pcall(function()
		NeverloseUI.Drag(Cover, Host, 0.15);
	end);
	task.spawn(function()
		task.wait(0.35);
		if Gate.Closing then
			return;
		end;
		Tween(Content, 0.45, { GroupTransparency = 0 });
		Tween(ContentScale, 0.45, { Scale = 1 }, Quint);
		task.wait(0.3);
		if Gate.Closing then
			return;
		end;
		Gate.Ready = true;
		if Cfg.SaveKey == true then
			local Saved = NeverloseUI:ReadSavedKey(SaveName);
			if Saved then
				KeyBox.Text = Saved;
				task.wait(0.15);
				Submit();
			end;
		end;
	end);
	Gate.Root = Cover;
	return Gate;
end;
NeverloseUI.EnabledBlur = true;
NeverloseUI.BlurModuleParent = workspace.CurrentCamera;
NeverloseUI.GetCalculatePosition = LPH_NO_VIRTUALIZE(function(planePos, planeNormal, rayOrigin, rayDirection)
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;
	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;
	return rayOrigin + (a * rayDirection);
end);
NeverloseUI.CreateBlurModule = LPH_NO_VIRTUALIZE(function(self , Frame , Signal , ActiveCheck)
	if not NeverloseUI.EnabledBlur then
		return NeverloseUI:AddSignal(Instance.new('BindableEvent').Event:Connect(function() return "nl"; end));
	end;
	local Part = Instance.new('Part',NeverloseUI.BlurModuleParent);
	local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
	local BlockMesh = Instance.new("BlockMesh");
	BlockMesh.Parent = Part;
	Part.Material = Enum.Material.SmoothPlastic;
	Part.Transparency = 1;
	Part.Reflectance = 0;
	Part.CastShadow = false;
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.CanQuery = false;
	Part.CollisionGroup = NeverloseUI.RandomString();
	Part.Size = Vector3.new(1, 1, 1) * 0.01;
	Part.Color = Color3.fromRGB(0,0,0);
	DepthOfField.Enabled = true;
	DepthOfField.FarIntensity = 0;
	DepthOfField.FocusDistance = 0;
	DepthOfField.InFocusRadius = 1000;
	DepthOfField.NearIntensity = 1;
	DepthOfField.Name = NeverloseUI.RandomString();
	Part.Name = NeverloseUI.RandomString();
	local disconnect;
	local UpdateFunction = function()
		local IsWindowActive = Signal:GetValue();
		if IsWindowActive and type(ActiveCheck) == "function" then
			local CheckOk, CheckValue = pcall(ActiveCheck);
			if CheckOk and CheckValue == false then
				IsWindowActive = false;
			end;
		end;
		if IsWindowActive and not NeverloseUI.Global3DRenderMode then
			NeverloseUI.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 1
			})
			NeverloseUI.PlayAnimate(Part,TweenInfo.new(0.1),{
				Transparency = 0.97,
				Size = Vector3.new(1, 1, 1) * 0.01;
			})
			Part.Parent = NeverloseUI.BlurModuleParent;
		else
			NeverloseUI.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 0
			})
			NeverloseUI.PlayAnimate(Part,TweenInfo.new(0.1),{
				Size = Vector3.zero,
				Transparency = 1.5,
			})
			Part.Parent = nil;
			return false;
		end;
		if IsWindowActive then
			local corner0 = Frame.AbsolutePosition;
			local corner1 = corner0 + Frame.AbsoluteSize;
			local ray0 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner0.X, corner0.Y, 1);
			local ray1 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner1.X, corner1.Y, 1);
			local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);
			local planeNormal = CurrentCamera.CFrame.LookVector;
			local pos0 = NeverloseUI.GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
			local pos1 = NeverloseUI.GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);
			pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
			pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);
			local size   = pos1 - pos0;
			local center = (pos0 + pos1) / 2;
			BlockMesh.Offset = center
			BlockMesh.Scale  = size / 0.0101;
			Part.CFrame = CurrentCamera.CFrame;
		end;
	end;
	local rbxsignal = NeverloseUI:AddSignal(CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction))
	local loopThread = NeverloseUI:AddSignal(UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			pcall(UpdateFunction);
		end;
	end));
	local THREAD = task.spawn(function()
		while true do task.wait(0.1)
			pcall(UpdateFunction);
		end;
	end);
	disconnect = function()
		rbxsignal:Disconnect();
		loopThread:Disconnect();
		task.cancel(THREAD);
		Part:Destroy();
		DepthOfField:Destroy();
	end;
	Frame.Destroying:Connect(disconnect);
	return rbxsignal;
end);
local EmptyFunction = function() end;
function NeverloseUI:FireCallback(Callback, Context, ...)
	if type(Callback) ~= "function" then
		return true;
	end;
	local Args = table.pack(...);
	local Window = NeverloseUI.ActiveWindow;
	local Ok, Result = xpcall(function()
		return Callback(table.unpack(Args, 1, Args.n));
	end, (debug and debug.traceback) or tostring);
	if not Ok then
		warn(("[NeverloseUI] %s callback error: %s"):format(tostring(Context or "Unknown"), tostring(Result)));
		if Window and Window.NotifyOnCallbackError and Window.Notify then
			Window:Notify({
				Title = "Callback Error",
				Content = tostring(Result),
				Duration = 5,
				Icon = "lucide:triangle-alert",
			});
		end;
	end;
	return Ok, Result;
end;
local function CaseInsensitive(t)
	return setmetatable(t, {
		__index = function(self, key)
			local v = rawget(self, key);
			if v ~= nil then return v; end;
			local lower = string.lower(tostring(key));
			for k, val in next, self do
				if string.lower(tostring(k)) == lower then
					return val;
				end;
			end;
		end;
	});
end;
function NeverloseUI:RollingEffect(parent)
	local UIGradient = Instance.new("UIGradient")
	UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.4), NumberSequenceKeypoint.new(1.00, 0.00)}
	UIGradient.Parent = parent
	return UIGradient;
end;
function NeverloseUI:CreateShadow(parent , RollingEffect)
	local Shadow = {};
	local UIShadowSafe85 = Instance.new("UIStroke")
	local UIShadowSafe65 = Instance.new("UIStroke")
	local UIShadowSafe50 = Instance.new("UIStroke")
	local UIShadowSafe45 = Instance.new("UIStroke")
	UIShadowSafe85.Thickness = 6.000
	UIShadowSafe85.Transparency = 1
	UIShadowSafe85.Parent = parent
	UIShadowSafe65.Thickness = 5.000
	UIShadowSafe65.Transparency = 1
	UIShadowSafe65.Parent = parent
	UIShadowSafe50.Thickness = 4.000
	UIShadowSafe50.Transparency = 1
	UIShadowSafe50.Parent = parent
	UIShadowSafe45.Thickness = 3.000
	UIShadowSafe45.Transparency = 1
	UIShadowSafe45.Parent = parent
	local RollingEffectThread;
	local r1,r2,r3,r4;
	if RollingEffect then
		r1 = NeverloseUI:RollingEffect(UIShadowSafe85);
		r2 = NeverloseUI:RollingEffect(UIShadowSafe65);
		r3 = NeverloseUI:RollingEffect(UIShadowSafe50);
		r4 = NeverloseUI:RollingEffect(UIShadowSafe45);
	end;
	Shadow.Render = LPH_NO_VIRTUALIZE(function(self , value)
		if RollingEffectThread then
			task.cancel(RollingEffectThread);
			RollingEffectThread = nil;
		end;
		if value then
			NeverloseUI.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 0.900
			})
			NeverloseUI.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 0.900
			})
			NeverloseUI.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 0.900
			})
			NeverloseUI.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 0.900
			})
			if RollingEffect then
				RollingEffectThread = task.spawn(function()
					local level = 20;
					while true do task.wait(0.025)
						NeverloseUI.PlayAnimate(r1 , SlowyTween , {
							Rotation = r1.Rotation + level
						});
						NeverloseUI.PlayAnimate(r2 , SlowyTween , {
							Rotation = r2.Rotation + level
						});
						NeverloseUI.PlayAnimate(r3 , SlowyTween , {
							Rotation = r3.Rotation + level
						});
						NeverloseUI.PlayAnimate(r4 , SlowyTween , {
							Rotation = r4.Rotation + level
						});
					end;
				end);
			end;
		else
			NeverloseUI.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 1
			})
		end;
	end);
	return Shadow;
end;
function NeverloseUI:CreateOptionWindow(Frame , Zindex)
	Zindex = Zindex or 9;
	local Window = {
		Signal = NeverloseUI:CreateSignal(false),
	};
	local OptionHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIListLayout = Instance.new("UIListLayout")
	local UIStroke = Instance.new("UIStroke")
	local shadow = NeverloseUI:CreateShadow(OptionHandler);
	OptionHandler.Name = NeverloseUI.RandomString();
	OptionHandler.Parent = NeverloseUI.ScreenGui
	OptionHandler.AnchorPoint = Vector2.new(0, 0)
	OptionHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	OptionHandler.BackgroundTransparency = 0.035
	OptionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OptionHandler.BorderSizePixel = 0
	OptionHandler.ClipsDescendants = true
	OptionHandler.Position = UDim2.new(255,255,255,255)
	OptionHandler.Size = UDim2.new(0, 220, 0, 75)
	OptionHandler.ZIndex = Zindex + 9
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = OptionHandler
	UIListLayout.Parent = OptionHandler
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = OptionHandler
	NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		NeverloseUI.PlayAnimate(OptionHandler , SlowyTween , {
			Size = UDim2.new(0, 220, 0, UIListLayout.AbsoluteContentSize.Y - 1)
		})
	end)));
	NeverloseUI:AddSignal(OptionHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if OptionHandler.BackgroundTransparency > 0.9 then
			OptionHandler.Visible = false;
			UIListLayout.Parent = nil;
			OptionHandler.Parent = nil;
		else
			OptionHandler.Visible = true;
			UIListLayout.Parent = OptionHandler
			if NeverloseUI.Global3DRenderMode then
				OptionHandler.Parent = NeverloseUI.GlobalSurfaceGui;
			else
				OptionHandler.Parent = NeverloseUI.ScreenGui;
			end;
		end
	end)));
	local FollowingThread;
	local SetPosition = LPH_NO_VIRTUALIZE(function()
		if NeverloseUI:MoreThanHalfY(Frame.AbsolutePosition.Y + 65) then
			OptionHandler.AnchorPoint = Vector2.new(0,1)
		else
			OptionHandler.AnchorPoint = Vector2.new(0,0)
		end;
		OptionHandler.Position = UDim2.fromOffset(Frame.AbsolutePosition.X + 18 , Frame.AbsolutePosition.Y + 65);
	end);
	Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if FollowingThread then
			task.cancel(FollowingThread);
			FollowingThread = nil;
		end;
		if value then
			SetPosition();
			NeverloseUI.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 0.035
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})
			shadow:Render(true);
			if NeverloseUI.Global3DRenderMode then
				OptionHandler.Parent = NeverloseUI.GlobalSurfaceGui;
			else
				OptionHandler.Parent = NeverloseUI.ScreenGui;
			end;
			FollowingThread = task.spawn(function()
				while true do task.wait()
					SetPosition();
				end
			end)
		else
			NeverloseUI.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})
			shadow:Render(false);
		end;
	end);
	Window.SetRender(false);
	Window.Signal:Connect(Window.SetRender)
	local Payback = NeverloseUI:RegisiterItem(OptionHandler , Window.Signal);
	Payback.Winbdow = Window;
	Payback.Root = OptionHandler;
	Payback.Signal = Window.Signal;
	return Payback;
end;
function NeverloseUI:CreateColorPicker(HandleFrame)
	local ZIndex = HandleFrame.ZIndex;
	local ColorPickerLib = {};
	local ColorPickerHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local SaViMap = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local ColorZoneSelection = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorMap = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_4 = Instance.new("UICorner")
	local ColorMapSelection = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local RGBLabel = Instance.new("TextLabel")
	local UICorner_6 = Instance.new("UICorner")
	local Shadow = NeverloseUI:CreateShadow(ColorPickerHandler);
	ColorPickerHandler.Name = NeverloseUI.RandomString();
	ColorPickerHandler.Parent = NeverloseUI.ScreenGui
	ColorPickerHandler.AnchorPoint = Vector2.new(0, 0)
	ColorPickerHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	ColorPickerHandler.BackgroundTransparency = 0.035
	ColorPickerHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerHandler.BorderSizePixel = 0
	ColorPickerHandler.ClipsDescendants = true
	ColorPickerHandler.Position = UDim2.new(255, 0, 255, 20)
	ColorPickerHandler.Size = UDim2.new(0, 200, 0, 240)
	ColorPickerHandler.ZIndex = ZIndex + 125
	NeverloseUI:AddSignal(ColorPickerHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if ColorPickerHandler.BackgroundTransparency > 0.9 then
			ColorPickerHandler.Visible = false;
			ColorPickerHandler.Parent = nil
		else
			ColorPickerHandler.Visible = true;
			if NeverloseUI.Global3DRenderMode then
				ColorPickerHandler.Parent = NeverloseUI.GlobalSurfaceGui;
			else
				ColorPickerHandler.Parent = NeverloseUI.ScreenGui;
			end;
		end;
	end)));
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = ColorPickerHandler
	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = ColorPickerHandler
	SaViMap.Name = NeverloseUI.RandomString();
	SaViMap.Parent = ColorPickerHandler
	SaViMap.AnchorPoint = Vector2.new(0.5, 0)
	SaViMap.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
	SaViMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SaViMap.BorderSizePixel = 0
	SaViMap.Position = UDim2.new(0.5, 0, 0, 5)
	SaViMap.Size = UDim2.new(0, 185, 0, 185)
	SaViMap.ZIndex = ZIndex + 126
	SaViMap.Image = NeverloseUI.ImageColorMapping
	UICorner_2.CornerRadius = UDim.new(0, 5)
	UICorner_2.Parent = SaViMap
	ColorZoneSelection.Name = NeverloseUI.RandomString();
	ColorZoneSelection.Parent = SaViMap
	ColorZoneSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorZoneSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorZoneSelection.BackgroundTransparency = 1.000
	ColorZoneSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorZoneSelection.BorderSizePixel = 0
	ColorZoneSelection.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorZoneSelection.Size = UDim2.new(0, 10, 0, 10)
	ColorZoneSelection.ZIndex = ZIndex + 127
	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorZoneSelection
	UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_2.Parent = ColorZoneSelection
	ColorMap.Name = NeverloseUI.RandomString();
	ColorMap.Parent = ColorPickerHandler
	ColorMap.AnchorPoint = Vector2.new(0.5, 0)
	ColorMap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMap.BorderSizePixel = 0
	ColorMap.Position = UDim2.new(0.5, 0, 0, 200)
	ColorMap.Size = UDim2.new(1, -15, 0, 10)
	ColorMap.ZIndex = ZIndex + 126
	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Parent = ColorMap
	UICorner_4.CornerRadius = UDim.new(0, 3)
	UICorner_4.Parent = ColorMap
	ColorMapSelection.Name = NeverloseUI.RandomString();
	ColorMapSelection.Parent = ColorMap
	ColorMapSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorMapSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMapSelection.BackgroundTransparency = 1.000
	ColorMapSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMapSelection.BorderSizePixel = 0
	ColorMapSelection.Position = UDim2.new(0, 0, 0.5, 0)
	ColorMapSelection.Size = UDim2.new(0, 5, 1, 0)
	ColorMapSelection.ZIndex = ZIndex + 126
	UIStroke_3.Thickness = 2.000
	UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_3.Parent = ColorMapSelection
	UICorner_5.CornerRadius = UDim.new(0, 3)
	UICorner_5.Parent = ColorMapSelection
	RGBLabel.Name = NeverloseUI.RandomString();
	RGBLabel.Parent = ColorPickerHandler
	RGBLabel.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	RGBLabel.BackgroundTransparency = 0.750
	RGBLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RGBLabel.BorderSizePixel = 0
	RGBLabel.Position = UDim2.new(0, 10, 0, 217)
	RGBLabel.Size = UDim2.new(1, -20, 0, 15)
	RGBLabel.ZIndex = ZIndex + 127
	RGBLabel.Font = Enum.Font.GothamBold
	RGBLabel.Text = "#FFFFFF"
	RGBLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	RGBLabel.TextSize = 12.000
	RGBLabel.TextTransparency = 0.400
	RGBLabel.TextXAlignment = Enum.TextXAlignment.Left
	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = RGBLabel
	ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			ColorPickerHandler.Position = UDim2.new(0,HandleFrame.AbsolutePosition.X + 20 , 0 ,HandleFrame.AbsolutePosition.Y + 75);
			NeverloseUI.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 0.035
			})
			NeverloseUI.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 0.650
			})
			NeverloseUI.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 0,
				ImageTransparency = 0
			})
			NeverloseUI.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 0
			})
			NeverloseUI.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 0
			})
			NeverloseUI.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 0
			})
			NeverloseUI.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 0.750,
				TextTransparency = 0.400
			})
			Shadow:Render(true)
		else
			NeverloseUI.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 1,
				ImageTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 1,
				TextTransparency = 1
			})
			Shadow:Render(false)
		end;
	end);
	ColorPickerLib.SetRender(false);
	ColorPickerLib.Root = ColorPickerHandler;
	ColorPickerLib.H = 1;
	ColorPickerLib.S = 1;
	ColorPickerLib.V = 1;
	ColorPickerLib.Callback = EmptyFunction;
	function ColorPickerLib:Update()
		local RealColor = Color3.fromHSV(ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V);
		NeverloseUI.PlayAnimate(ColorZoneSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.S , 1 - ColorPickerLib.V)
		});
		NeverloseUI.PlayAnimate(SaViMap,ManualTween,{
			BackgroundColor3 = Color3.fromHSV(ColorPickerLib.H , 1 , 1)
		});
		NeverloseUI.PlayAnimate(ColorMapSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.H,0.5)
		});
		RGBLabel.Text = "#"..RealColor:ToHex();
		ColorPickerLib.Callback(RealColor);
	end;
	function ColorPickerLib:SetValue(Color)
		if typeof(Color) == 'string' then
			Color = Color3.fromHex(Color);
		end;
		local H , S , V = Color:ToHSV();
		ColorPickerLib.H = H;
		ColorPickerLib.S = S;
		ColorPickerLib.V = V;
		ColorPickerLib:Update();
	end;
	ColorPickerLib.IsHold = false;
	NeverloseUI:AddSignal(ColorPickerHandler.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;
		end;
	end));
	NeverloseUI:AddSignal(ColorPickerHandler.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = false;
		end;
	end));
	NeverloseUI:AddSignal(ColorMap.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;
			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or ColorPickerLib.IsHold) do task.wait()
				local ColorY = ColorMap.AbsolutePosition.X
				local ColorYM = ColorY + ColorMap.AbsoluteSize.X;
				local Value = math.clamp(Mouse.X, ColorY, ColorYM)
				local Code = ((Value - ColorY) / (ColorYM - ColorY));
				ColorPickerLib.H = Code;
				ColorPickerLib:Update();
			end;
		end;
	end)));
	NeverloseUI:AddSignal(SaViMap.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;
			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or ColorPickerLib.IsHold) do task.wait();
				local PosX = SaViMap.AbsolutePosition.X;
				local ScaleX = PosX + SaViMap.AbsoluteSize.X;
				local Value, PosY = math.clamp(Mouse.X, PosX, ScaleX), SaViMap.AbsolutePosition.Y;
				local ScaleY = PosY + SaViMap.AbsoluteSize.Y;
				local Vals = math.clamp(Mouse.Y, PosY, ScaleY);
				ColorPickerLib.S = (Value - PosX) / (ScaleX - PosX);
				ColorPickerLib.V = (1 - ((Vals - PosY) / (ScaleY - PosY)));
				ColorPickerLib:Update();
			end
		end
	end)));
	return ColorPickerLib;
end;
NeverloseUI.KeyEnum = {
	One = '1',
	Two = '2',
	Three = '3',
	Four = '4',
	Five = '5',
	Six = '6',
	Seven = '7',
	Eight = '8',
	Nine = '9',
	Zero = '0',
	['Minus'] = "-",
	['Plus'] = "+",
	BackSlash = "\\",
	Slash = "/",
	Period = '.',
	Semicolon = ';',
	Colon = ":",
	LeftControl = "LCtrl",
	RightControl = "RCtrl",
	LeftShift = "LShift",
	RightShift = "RShift",
	Return = "Enter",
	LeftBracket = "[",
	RightBracket = "]",
	Quote = "'",
	Comma = ",",
	Equals = "=",
	LeftSuper = "Super",
	RightSuper = "Super",
	LeftAlt = "LAlt",
	RightAlt = "RAlt",
	Escape = "Esc",
};
NeverloseUI.EnumReverse = {};
for i,v in next , NeverloseUI.KeyEnum do
	NeverloseUI.EnumReverse[v] = i;
end;
function NeverloseUI:NormalizeKeybindValue(K)
	if K == nil then
		return "None";
	end;
	if typeof(K) == "EnumItem" then
		return K.Name;
	end;
	if typeof(K) == "table" and K.Name ~= nil then
		return tostring(K.Name);
	end;
	return tostring(K);
end;
function NeverloseUI:KeyCodeToStr(K)
	local KeyName = NeverloseUI:NormalizeKeybindValue(K);
	if NeverloseUI.KeyEnum[KeyName] then
		return NeverloseUI.KeyEnum[KeyName];
	end;
	return KeyName;
end;
function NeverloseUI:StrToKeyCode(str)
	str = NeverloseUI:NormalizeKeybindValue(str);
	if NeverloseUI.EnumReverse[str] then
		return Enum.KeyCode[NeverloseUI.EnumReverse[str]];
	end;
	return Enum.KeyCode[str] or Enum.KeyCode.Unknown;
end;
function NeverloseUI:RegisiterHandler(Handler , Signal)
	local handle = {};
	local ZINdex = Handler.ZIndex;
	function handle:AddToggle(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = nil,
			Default = false,
			Type = "Switch",
			Icon = "check",
			Flag = nil,
			Key = nil,
			ConfigKey = nil,
			Locked = false,
			TextLocked = "Locked",
			Callback = EmptyFunction,
		});
		NeverloseUI:ResolveConfigFlag(Config);
		local IsCheckbox = string.lower(tostring(Config.Type)) == "checkbox";
		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Circle = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local CheckboxIcon = Instance.new("ImageLabel")
		local UIStroke = Instance.new("UIStroke")
		Toggle.Name = NeverloseUI.RandomString();
		Toggle.Parent = Handler
		Toggle.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.ClipsDescendants = true
		Toggle.Size = IsCheckbox and UDim2.new(0, 18, 0, 18) or UDim2.new(0, 30, 0, 18)
		Toggle.ZIndex = ZINdex + 13
		Toggle.LayoutOrder = -(#Handler:GetChildren() + 5);
		UICorner.CornerRadius = IsCheckbox and UDim.new(0, 4) or UDim.new(1, 0)
		UICorner.Parent = Toggle
		UIStroke.Transparency = IsCheckbox and 0.650 or 1
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Toggle
		Circle.Name = NeverloseUI.RandomString();
		Circle.Parent = Toggle
		Circle.AnchorPoint = Vector2.new(0.5, 0.5)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 0.500
		Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Circle.BorderSizePixel = 0
		Circle.Position = UDim2.new(0.300000012, 0, 0.5, 0)
		Circle.Size = IsCheckbox and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 16, 0, 16)
		Circle.Visible = not IsCheckbox
		Circle.ZIndex = ZINdex + 14
		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = Circle
		CheckboxIcon.Name = NeverloseUI.RandomString();
		CheckboxIcon.Parent = Toggle
		CheckboxIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		CheckboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CheckboxIcon.BackgroundTransparency = 1.000
		CheckboxIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CheckboxIcon.BorderSizePixel = 0
		CheckboxIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		CheckboxIcon.Size = UDim2.new(1, -4, 1, -4)
		CheckboxIcon.Visible = IsCheckbox
		CheckboxIcon.ZIndex = ZINdex + 14
		CheckboxIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		CheckboxIcon.ImageTransparency = 1
		CheckboxIcon.ScaleType = Enum.ScaleType.Fit
		NeverloseUI:SetIconMode(CheckboxIcon, Config.Icon or "check")
		local ToggleLib = {
			Root = Toggle
		};
		NeverloseUI:AttachLockMethods(ToggleLib, self.Root or Toggle, Config);
		ToggleLib.SetUI = LPH_NO_VIRTUALIZE(function(value)
			if IsCheckbox then
				if value then
					NeverloseUI.PlayAnimate(Toggle,SlowyTween,{
						BackgroundTransparency = 0,
						BackgroundColor3 = NeverloseUI.AccentColor
					})
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 1
					})
					NeverloseUI.PlayAnimate(CheckboxIcon,SlowyTween,{
						TextTransparency = 0
					})
				else
					NeverloseUI.PlayAnimate(Toggle,SlowyTween,{
						BackgroundTransparency = 0,
						BackgroundColor3 = Color3.fromRGB(10, 13, 21)
					})
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.650
					})
					NeverloseUI.PlayAnimate(CheckboxIcon,SlowyTween,{
						TextTransparency = 1
					})
				end;
			elseif value then
				NeverloseUI.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = NeverloseUI.AccentColor
				})
				NeverloseUI.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0,
					Position = UDim2.new(0.7, 0, 0.5, 0)
				})
			else
				NeverloseUI.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(10, 13, 21)
				})
				NeverloseUI.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.500,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);
		ToggleLib.SetVisible = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ToggleLib.SetUI(Config.Default);
			else
				NeverloseUI.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(10, 13, 21)
				})
				NeverloseUI.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
				NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(CheckboxIcon,SlowyTween,{
					TextTransparency = 1
				})
			end;
		end);
		ToggleLib.SetUI(Config.Default);
		ToggleLib.SetVisible(Signal:GetValue());
		NeverloseUI:CreateInput(Toggle , LPH_NO_VIRTUALIZE(function()
			Config.Default = not Config.Default;
			ToggleLib.SetUI(Config.Default);
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default)
		end))
		ToggleLib.Signal = Signal:Connect(ToggleLib.SetVisible);
		function ToggleLib:GetValue()
			return Config.Default;
		end;
		function ToggleLib:SetValue(v)
			Config.Default = v == true;
			if Signal:GetValue() then
				ToggleLib.SetUI(Config.Default);
			end;
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default)
			return ToggleLib;
		end;
		function ToggleLib:Toggle()
			ToggleLib:SetValue(not Config.Default);
			return ToggleLib;
		end;
		function ToggleLib:On()
			ToggleLib:SetValue(true);
			return ToggleLib;
		end;
		function ToggleLib:Off()
			ToggleLib:SetValue(false);
			return ToggleLib;
		end;
		function ToggleLib:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			return ToggleLib;
		end;
		function ToggleLib:SetIcon(icon)
			Config.Icon = icon or Config.Icon;
			if IsCheckbox then
				NeverloseUI:SetIconMode(CheckboxIcon, Config.Icon);
			end;
			return ToggleLib;
		end;
		function ToggleLib:SetEnabled(value)
			Toggle.Visible = value ~= false;
			return ToggleLib;
		end;
		if Config.Flag then
			NeverloseUI:RegisterFlag(Config.Flag, ToggleLib);
		end;
		return CaseInsensitive(ToggleLib);
	end;
	function handle:AddSlider(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = nil,
			Default = 50,
			Min = 0,
			Max = 10,
			Type = "",
			Rounding = 0,
			Nums = {},
			Flag = nil,
			Key = nil,
			ConfigKey = nil,
			Locked = false,
			TextLocked = "Locked",
			Size = 125,
			Tooltip = false,
			Callback = EmptyFunction,
		});
		NeverloseUI:ResolveConfigFlag(Config);
		local SliderLib = {};
		SliderLib.GetSize = LPH_NO_VIRTUALIZE(function()
			return (Config.Default - Config.Min) / (Config.Max - Config.Min);
		end);
		local FullNumSize = TextService:GetTextSize(string.rep("0",(Config.Rounding + #tostring(Config.Max))+1)..tostring(Config.Type),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));
		SliderLib.MaximumSize = FullNumSize.X;
		if Config.Nums then
			local nszie = 0;
			for i,ns in next , Config.Nums do
				local size = TextService:GetTextSize(string.rep("m",string.len(tostring(ns))),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));
				if nszie < size.X then
					nszie = size.X;
				end
			end;
			if SliderLib.MaximumSize < nszie then
				SliderLib.MaximumSize = nszie;
			end;
		end;
		local Slider = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ValueFrame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextBox")
		local SlideMain = Instance.new("Frame")
		local SlideFrame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local SlideMoving = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_5 = Instance.new("UICorner")
		local boxSize = 2;
		local valueGap = 5;
		local TooltipEnabled = Config.Tooltip == true;
		local TooltipFrame;
		local TooltipCorner;
		local TooltipStroke;
		local TooltipLabel;
		Slider.Name = NeverloseUI.RandomString();
		Slider.Parent = Handler
		Slider.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.ClipsDescendants = false
		Slider.Size = UDim2.new(0, Config.Size, 0, 18)
		Slider.ZIndex = ZINdex + 13
		Slider.LayoutOrder = -(#Handler:GetChildren() + 5);
		NeverloseUI:AttachLockMethods(SliderLib, self.Root or Slider, Config);
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Slider
		ValueFrame.Name = NeverloseUI.RandomString();
		ValueFrame.Parent = Slider
		ValueFrame.AnchorPoint = Vector2.new(1, 0)
		ValueFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueFrame.BorderSizePixel = 0
		ValueFrame.ClipsDescendants = true
		ValueFrame.Position = UDim2.new(1, 0, 0, 0)
		ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
		ValueFrame.ZIndex = ZINdex + 13
		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ValueFrame
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ValueFrame
		ValueLabel.Name = NeverloseUI.RandomString();
		ValueLabel.Parent = ValueFrame
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 10.000
		ValueLabel.ClearTextOnFocus = false;
		ValueLabel.TextTransparency = 0.350
		SlideMain.Name = NeverloseUI.RandomString();
		SlideMain.Parent = Slider
		SlideMain.AnchorPoint = Vector2.new(0, 0.5)
		SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SlideMain.BackgroundTransparency = 1.000
		SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMain.BorderSizePixel = 0
		SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
		SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + boxSize + valueGap)), 0, 18)
		SlideMain.ZIndex = ZINdex + 13
		SlideFrame.Name = NeverloseUI.RandomString();
		SlideFrame.Parent = SlideMain
		SlideFrame.AnchorPoint = Vector2.new(0, 0.5)
		SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
		SlideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideFrame.BorderSizePixel = 0
		SlideFrame.Position = UDim2.new(0, 0, 0.5, 0)
		SlideFrame.Size = UDim2.new(1, 0, 0, 5)
		SlideFrame.ZIndex = ZINdex + 13
		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = SlideFrame
		SlideMoving.Name = NeverloseUI.RandomString();
		SlideMoving.Parent = SlideFrame
		SlideMoving.BackgroundColor3 = NeverloseUI.AccentColor
		SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMoving.BorderSizePixel = 0
		SlideMoving.Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
		SlideMoving.ZIndex = ZINdex + 14
		UICorner_4.CornerRadius = UDim.new(1, 0)
		UICorner_4.Parent = SlideMoving
		Frame.Parent = SlideMoving
		Frame.AnchorPoint = Vector2.new(1, 0.5)
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(1, 5, 0.5, 0)
		Frame.Size = UDim2.new(0, 10, 0, 10)
		Frame.ZIndex = ZINdex + 15
		UICorner_5.CornerRadius = UDim.new(1, 0)
		UICorner_5.Parent = Frame
		local function EnsureSliderTooltip()
			if TooltipFrame then
				return;
			end;
			TooltipFrame = Instance.new("Frame");
			TooltipFrame.Name = NeverloseUI.RandomString();
			TooltipFrame.Parent = NeverloseUI.ScreenGui;
			TooltipFrame.AnchorPoint = Vector2.new(0.5, 1);
			TooltipFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27);
			TooltipFrame.BackgroundTransparency = 1;
			TooltipFrame.BorderSizePixel = 0;
			TooltipFrame.ClipsDescendants = true;
			TooltipFrame.Position = UDim2.fromOffset(0, 0);
			TooltipFrame.Size = UDim2.fromOffset(40, 22);
			TooltipFrame.Visible = false;
			TooltipFrame.ZIndex = ZINdex + 200;
			TooltipCorner = Instance.new("UICorner");
			TooltipCorner.CornerRadius = UDim.new(0, 5);
			TooltipCorner.Parent = TooltipFrame;
			TooltipStroke = Instance.new("UIStroke");
			TooltipStroke.Color = Color3.fromRGB(45, 48, 58);
			TooltipStroke.Transparency = 1;
			TooltipStroke.Parent = TooltipFrame;
			TooltipLabel = Instance.new("TextLabel");
			TooltipLabel.Name = NeverloseUI.RandomString();
			TooltipLabel.Parent = TooltipFrame;
			TooltipLabel.BackgroundTransparency = 1;
			TooltipLabel.BorderSizePixel = 0;
			TooltipLabel.Position = UDim2.fromOffset(6, 0);
			TooltipLabel.Size = UDim2.new(1, -12, 1, 0);
			TooltipLabel.ZIndex = TooltipFrame.ZIndex + 1;
			TooltipLabel.Font = Enum.Font.GothamMedium;
			TooltipLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
			TooltipLabel.TextSize = 11;
			TooltipLabel.TextTransparency = 1;
			TooltipLabel.TextXAlignment = Enum.TextXAlignment.Center;
		end;
		local function UpdateSliderTooltip()
			if not TooltipFrame or not TooltipLabel then
				return;
			end;
			TooltipLabel.Text = ValueLabel.Text;
			local TextSize = TextService:GetTextSize(TooltipLabel.Text, TooltipLabel.TextSize, TooltipLabel.Font, Vector2.new(math.huge, math.huge));
			TooltipFrame.Size = UDim2.fromOffset(math.max(34, TextSize.X + 14), 22);
			TooltipFrame.Position = UDim2.fromOffset(Frame.AbsolutePosition.X + (Frame.AbsoluteSize.X / 2), Frame.AbsolutePosition.Y - 2);
		end;
		local function SetSliderTooltipRender(value)
			if not TooltipEnabled or not value then
				if TooltipFrame then
					NeverloseUI.PlayAnimate(TooltipFrame, SlowyTween, {
						BackgroundTransparency = 1,
					});
					NeverloseUI.PlayAnimate(TooltipStroke, SlowyTween, {
						Transparency = 1,
					});
					NeverloseUI.PlayAnimate(TooltipLabel, SlowyTween, {
						TextTransparency = 1,
					});
					task.delay(0.18, function()
						if TooltipFrame and TooltipFrame.BackgroundTransparency > 0.95 then
							TooltipFrame.Visible = false;
						end;
					end);
				end;
				return;
			end;
			EnsureSliderTooltip();
			UpdateSliderTooltip();
			TooltipFrame.Visible = true;
			NeverloseUI.PlayAnimate(TooltipFrame, SlowyTween, {
				BackgroundTransparency = 0.075,
			});
			NeverloseUI.PlayAnimate(TooltipStroke, SlowyTween, {
				Transparency = 0.650,
			});
			NeverloseUI.PlayAnimate(TooltipLabel, SlowyTween, {
				TextTransparency = 0.200,
			});
		end;
		local LoadText = LPH_NO_VIRTUALIZE(function()
			if Config.Nums[Config.Default] then
				ValueLabel.Text = Config.Nums[Config.Default]
			else
				ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);
			end;
			UpdateSliderTooltip();
		end);
		ValueLabel.FocusLost:Connect(LPH_NO_VIRTUALIZE(function()
			local OutVal = NeverloseUI:ParseInput(ValueLabel.Text , true);
			if OutVal then
				local rx = math.clamp(OutVal , Config.Min , Config.Max);
				local Value = NeverloseUI.Rounding(rx,Config.Rounding);
				if Value then
					Config.Default = Value;
					TweenService:Create(SlideMoving , ManualTween ,{
						Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
					}):Play();
					LoadText();
					NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default)
				else
					LoadText();
				end;
			else
				LoadText()
			end;
		end));
		SliderLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
				});
				NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 0.650
				});
				NeverloseUI.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 0.350
				});
				NeverloseUI.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 0
				});
				NeverloseUI.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});
				NeverloseUI.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 0
				});
			else
				SetSliderTooltipRender(false);
				NeverloseUI.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 1,
				});
				NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 1
				});
				NeverloseUI.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 1
				});
				NeverloseUI.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0)
				});
				NeverloseUI.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 1
				});
			end;
		end);
		SliderLib.SetRender(Signal:GetValue());
		SliderLib.Signal = Signal:Connect(SliderLib.SetRender);
		local Update = function(Input)
			local SizeScale = math.clamp((((Input.Position.X) - SlideMain.AbsolutePosition.X) / SlideMain.AbsoluteSize.X), 0, 1);
			local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min;
			local Value = NeverloseUI.Rounding(Main,Config.Rounding);
			local PositionX = UDim2.fromScale(SizeScale, 1);
			local Size = ((Value - Config.Min) / (Config.Max - Config.Min)) + 0.02;
			Config.Default = Value;
			TweenService:Create(SlideMoving , ManualTween ,{
				Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
			}):Play();
			LoadText()
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Value)
		end;
		local IsHold = false;
		do
			NeverloseUI:AddSignal(SlideMain.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
				SetSliderTooltipRender(true);
			end)));
			NeverloseUI:AddSignal(SlideMain.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
				if not IsHold then
					SetSliderTooltipRender(false);
				end;
			end)));
			SlideMain.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					IsHold = true
					Update(Input)
					SetSliderTooltipRender(true);
				end
			end))
			SlideMain.InputEnded:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not NeverloseUI:IsMouseOverFrame(SlideMain) then
							IsHold = false
						end;
					else
						IsHold = false
					end;
					if not IsHold and not NeverloseUI:IsMouseOverFrame(SlideMain) then
						SetSliderTooltipRender(false);
					end;
				end
			end))
			UserInputService.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if IsHold then
					if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)  then
						if UserInputService.TouchEnabled then
							if not NeverloseUI:IsMouseOverFrame(SlideMain) then
								IsHold = false
							else
								Update(Input)
								UpdateSliderTooltip();
							end;
						else
							Update(Input)
							UpdateSliderTooltip();
						end;
					end;
				end;
			end));
		end;
		function SliderLib:GetValue()
			return Config.Default;
		end;
		function SliderLib:SetValue(v)
			local NumericValue = tonumber(v);
			if not NumericValue then
				return SliderLib;
			end;
			Config.Default = NeverloseUI.Rounding(math.clamp(NumericValue, Config.Min, Config.Max),Config.Rounding);
			if Signal:GetValue() then
				NeverloseUI.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});
			end;
			LoadText()
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
			return SliderLib;
		end;
		function SliderLib:SetRange(min,max)
			Config.Min = tonumber(min) or Config.Min;
			Config.Max = tonumber(max) or Config.Max;
			if Config.Min > Config.Max then
				Config.Min, Config.Max = Config.Max, Config.Min;
			end;
			SliderLib:SetValue(Config.Default);
			return SliderLib;
		end;
		function SliderLib:SetMin(min)
			return SliderLib:SetRange(min,Config.Max);
		end;
		function SliderLib:SetMax(max)
			return SliderLib:SetRange(Config.Min,max);
		end;
		function SliderLib:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			return SliderLib;
		end;
		function SliderLib:SetSuffix(suffix)
			Config.Type = tostring(suffix or "");
			LoadText();
			return SliderLib;
		end;
		function SliderLib:SetTooltip(value)
			TooltipEnabled = value == true;
			Config.Tooltip = TooltipEnabled;
			if not TooltipEnabled then
				SetSliderTooltipRender(false);
			end;
			return SliderLib;
		end;
		function SliderLib:SetEnabled(value)
			Slider.Visible = value ~= false;
			return SliderLib;
		end;
		if Config.Flag then
			NeverloseUI:RegisterFlag(Config.Flag, SliderLib);
		end;
		return CaseInsensitive(SliderLib);
	end;
	function handle:AddOption(GearIcon)
		local Option = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local UICorner = Instance.new("UICorner")
		Option.Name = NeverloseUI.RandomString();
		Option.Parent = Handler
		Option.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
		Option.BackgroundTransparency = 1.000
		Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Option.BorderSizePixel = 0
		Option.ClipsDescendants = true
		Option.Size = UDim2.new(0, 20, 0, 18)
		Option.ZIndex = ZINdex + 13
		Option.LayoutOrder = -(#Handler:GetChildren() + 5);
		Icon.Name = NeverloseUI.RandomString();
		Icon.Parent = Option
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = ZINdex + 14
		NeverloseUI:SetIconMode(Icon, (GearIcon == 1 and 'gear') or (GearIcon == 2 and 'chevron-large-right') or "three-dots-horizontal");
		Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		Icon.ImageTransparency = 0.400
		Icon.ScaleType = Enum.ScaleType.Fit
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Option
		local Window = NeverloseUI:CreateOptionWindow(Option , ZINdex + 13);
		local reciveSignal;
		Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.400
				})
			else
				NeverloseUI.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end);
		Window.SetRender(Signal:GetValue());
		Signal:Connect(Window.SetRender);
		local bthg = NeverloseUI:CreateInput(Option , LPH_NO_VIRTUALIZE(function()
			if reciveSignal then
				reciveSignal:Disconnect();
				reciveSignal = nil;
			end;
			Window.Signal:SetValue(true);
			reciveSignal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverloseUI:IsMouseOverFrame(Window.Root) and not NeverloseUI:IsMouseOverFrame(Option) then
						if reciveSignal then
							reciveSignal:Disconnect();
							reciveSignal = nil;
						end;
						Window.Signal:SetValue(false);
					end
				end
			end)
		end));
		NeverloseUI:AddSignal(bthg.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 0.5
			})
			NeverloseUI.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)));
		NeverloseUI:AddSignal(bthg.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 1.000
			})
			NeverloseUI.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.400
			})
		end)));
		return CaseInsensitive(Window);
	end;
	function handle:AddColorPicker(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = nil,
			Default = Color3.fromRGB(255, 255, 255),
			Flag = nil,
			Key = nil,
			ConfigKey = nil,
			Locked = false,
			TextLocked = "Locked",
			Callback  = EmptyFunction,
		});
		NeverloseUI:ResolveConfigFlag(Config);
		if typeof(Config.Default) == 'string' then
			Config.Default = Color3.fromHex(Config.Default:gsub('#',''));
		end;
		local ColorPickerLib = {};
		local ColorPicker = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ImageLabel = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		ColorPicker.Name = NeverloseUI.RandomString();
		ColorPicker.Parent = Handler
		ColorPicker.BackgroundColor3 = Config.Default;
		ColorPicker.BackgroundTransparency = 0
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.ClipsDescendants = true
		ColorPicker.Size = UDim2.new(0, 18, 0, 18)
		ColorPicker.ZIndex = ZINdex + 13
		NeverloseUI:AttachLockMethods(ColorPickerLib, self.Root or ColorPicker, Config);
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = ColorPicker
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ColorPicker
		ImageLabel.Parent = ColorPicker
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel.ZIndex = ZINdex + 11
		ImageLabel.Image = "rbxasset://textures/meshPartFallback.png"
		ImageLabel.ImageTransparency = 0.9
		ImageLabel.BackgroundTransparency = 1;
		ImageLabel.ScaleType = Enum.ScaleType.Crop
		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ImageLabel
		local BackendM = NeverloseUI:CreateColorPicker(ColorPicker);
		BackendM:SetValue(Config.Default)
		BackendM.Callback = function(color)
			ColorPicker.BackgroundColor3 = color;
			Config.Default = color;
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
		end;
		local signal;
		NeverloseUI:CreateInput(ColorPicker , LPH_NO_VIRTUALIZE(function()
			if signal then
				signal:Disconnect();
				signal = nil;
			end;
			BackendM.SetRender(true);
			signal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverloseUI:IsMouseOverFrame(ColorPicker) and not NeverloseUI:IsMouseOverFrame(BackendM.Root) then
						if signal then
							signal:Disconnect();
							signal = nil;
						end;
						BackendM.SetRender(false);
					end;
				end;
			end)
		end));
		ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 0
				})
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})
				NeverloseUI.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 0.9
				})
			else
				NeverloseUI.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 1
				})
			end;
		end);
		ColorPickerLib.SetRender(Signal:GetValue());
		Signal:Connect(ColorPickerLib.SetRender);
		function ColorPickerLib:GetValue()
			return Config.Default;
		end;
		function ColorPickerLib:SetValue(v)
			Config.Default = v;
			BackendM:SetValue(Config.Default)
			return ColorPickerLib;
		end;
		function ColorPickerLib:GetHex()
			return Config.Default:ToHex();
		end;
		function ColorPickerLib:SetHex(hex)
			ColorPickerLib:SetValue(Color3.fromHex(tostring(hex):gsub("#","")));
			return ColorPickerLib;
		end;
		function ColorPickerLib:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			BackendM.Callback = function(color)
				ColorPicker.BackgroundColor3 = color;
				Config.Default = color;
				NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
			end;
			return ColorPickerLib;
		end;
		function ColorPickerLib:SetEnabled(value)
			ColorPicker.Visible = value ~= false;
			return ColorPickerLib;
		end;
		if Config.Flag then
			NeverloseUI:RegisterFlag(Config.Flag, ColorPickerLib);
		end;
		return CaseInsensitive(ColorPickerLib);
	end;
	function handle:AddKeybind(Config)
		Config = NeverloseUI:ProcessParams(Config,{
			Name = nil,
			Default = nil,
			Mode = "Toggle",
			ModeFlag = nil,
			ChangedCallback = nil,
			ModeChangedCallback = nil,
			Blacklist = {},
			Callback = EmptyFunction,
			Flag = nil,
			Key = nil,
			ConfigKey = nil,
			Locked = false,
			TextLocked = "Locked",
		});
		NeverloseUI:ResolveConfigFlag(Config);
		Config.Default = NeverloseUI:NormalizeKeybindValue(Config.Default);
		Config.Mode = string.lower(tostring(Config.Mode or "Toggle")) == "hold" and "Hold" or "Toggle";
		Config.ChangedCallback = Config.ChangedCallback or Config.OnChanged or EmptyFunction;
		Config.ModeChangedCallback = Config.ModeChangedCallback or Config.OnModeChanged or EmptyFunction;
		local ModeFlag = Config.ModeFlag or Config.ModeKey or Config.ModeConfigKey;
		if ModeFlag ~= nil then
			Config.ModeFlag = tostring(ModeFlag);
		end;
		local KeybindLib = {};
		local ToggleState = false;
		local HoldState = false;
		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextLabel")
		Keybind.Name = NeverloseUI.RandomString();
		Keybind.Parent = Handler
		Keybind.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.ClipsDescendants = true
		Keybind.Size = UDim2.new(0, 45, 0, 18)
		Keybind.ZIndex = ZINdex + 13
		NeverloseUI:AttachLockMethods(KeybindLib, self.Root or Keybind, Config);
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Keybind
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Keybind
		ValueLabel.Name = NeverloseUI.RandomString();
		ValueLabel.Parent = Keybind
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.ClipsDescendants = true
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = NeverloseUI:KeyCodeToStr(Config.Default or "None")
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 10.000
		ValueLabel.TextTransparency = 0.500
		KeybindLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 0
				})
				NeverloseUI.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 0.650
				})
				NeverloseUI.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 0.500
				})
			else
				NeverloseUI.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 1
				})
			end;
		end);
		function KeybindLib:Update()
			local size = TextService:GetTextSize(ValueLabel.Text,ValueLabel.TextSize,ValueLabel.Font,Vector2.new(math.huge,math.huge));
			NeverloseUI.PlayAnimate(Keybind , SlowyTween , {
				Size = UDim2.new(0, size.X + 7, 0, 18)
			})
		end;
		local IsBlacklist = LPH_NO_VIRTUALIZE(function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end);
		KeybindLib:Update()
		KeybindLib.SetRender(Signal:GetValue());
		Signal:Connect(KeybindLib.SetRender);
		local IsBinding = false;
		local function FireAction(state)
			NeverloseUI:FireCallback(Config.Callback, Config.Name, state, Config.Default, Config.Mode);
		end;
		local function IsSameKey(Input)
			if not Config.Default or Config.Default == "None" then
				return false;
			end;
			if Config.Default == "M1B" then
				return Input.UserInputType == Enum.UserInputType.MouseButton1;
			elseif Config.Default == "M2B" then
				return Input.UserInputType == Enum.UserInputType.MouseButton2;
			end;
			local KeyCode = NeverloseUI:StrToKeyCode(Config.Default);
			return KeyCode and Input.KeyCode == KeyCode;
		end;
		NeverloseUI:CreateInput(Keybind , function()
			if IsBinding then
				return;
			end;
			IsBinding = true;
			ValueLabel.Text = "...";
			KeybindLib:Update();
			local Selected = nil;
			while not Selected do
				local Key = UserInputService.InputBegan:Wait();
				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("M1B") then
						Selected = "M1B";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("M2B") then
						Selected = "M2B";
					end;
				end;
			end;
			IsBinding = false;
			local KeyName = NeverloseUI:NormalizeKeybindValue(Selected);
			Config.Default = KeyName;
			ValueLabel.Text = NeverloseUI:KeyCodeToStr(KeyName);
			KeybindLib:Update();
			NeverloseUI:FireCallback(Config.ChangedCallback, Config.Name, KeyName);
			NeverloseUI:FireCallback(Config.Callback, Config.Name, KeyName, "Changed", Config.Mode);
		end)
		NeverloseUI:AddSignal(UserInputService.InputBegan:Connect(function(Input, IsTyping)
			if IsTyping or IsBinding or (KeybindLib.GetLocked and KeybindLib:GetLocked()) then
				return;
			end;
			if not IsSameKey(Input) then
				return;
			end;
			if Config.Mode == "Hold" then
				if not HoldState then
					HoldState = true;
					FireAction(true);
				end;
			else
				ToggleState = not ToggleState;
				FireAction(ToggleState);
			end;
		end))
		NeverloseUI:AddSignal(UserInputService.InputEnded:Connect(function(Input)
			if Config.Mode ~= "Hold" or not HoldState or not IsSameKey(Input) then
				return;
			end;
			HoldState = false;
			FireAction(false);
		end))
		function KeybindLib:GetValue()
			return Config.Default;
		end;
		function KeybindLib:SetValue(v)
			Config.Default = NeverloseUI:NormalizeKeybindValue(v);
			ValueLabel.Text = NeverloseUI:KeyCodeToStr(Config.Default);
			KeybindLib:Update();
			NeverloseUI:FireCallback(Config.ChangedCallback, Config.Name, Config.Default);
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default, "Changed", Config.Mode);
			return KeybindLib;
		end;
		function KeybindLib:SetMode(mode)
			local NextMode = string.lower(tostring(mode or "Toggle")) == "hold" and "Hold" or "Toggle";
			if Config.Mode == NextMode then
				return KeybindLib;
			end;
			if HoldState then
				HoldState = false;
				FireAction(false);
			end;
			Config.Mode = NextMode;
			ToggleState = false;
			NeverloseUI:FireCallback(Config.ModeChangedCallback, Config.Name, Config.Mode);
			return KeybindLib;
		end;
		function KeybindLib:GetMode()
			return Config.Mode;
		end;
		function KeybindLib:GetActionState()
			return Config.Mode == "Hold" and HoldState or ToggleState;
		end;
		function KeybindLib:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			return KeybindLib;
		end;
		function KeybindLib:SetBlacklist(list)
			Config.Blacklist = list or {};
			return KeybindLib;
		end;
		function KeybindLib:GetKeyCode()
			return NeverloseUI:StrToKeyCode(Config.Default);
		end;
		function KeybindLib:SetEnabled(value)
			Keybind.Visible = value ~= false;
			return KeybindLib;
		end;
		if Config.Flag then
			NeverloseUI:RegisterFlag(Config.Flag, KeybindLib);
		end;
		if Config.ModeFlag then
			NeverloseUI:RegisterFlag(Config.ModeFlag, {
				GetValue = function()
					return KeybindLib:GetMode();
				end,
				SetValue = function(_, value)
					return KeybindLib:SetMode(value);
				end,
			});
		end;
		return CaseInsensitive(KeybindLib);
	end;
	function handle:AddTextInput(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = nil,
			Default = "",
			Placeholder = "Placeholder",
			Callback = print,
			Flag = nil,
			Key = nil,
			ConfigKey = nil,
			Locked = false,
			TextLocked = "Locked",
			Size = 100,
			Height = nil,
			Type = "TextInput",
			Numeric = false,
			FullWidth = false,
		});
		NeverloseUI:ResolveConfigFlag(Config);
		local IsTextarea = string.lower(tostring(Config.Type or "TextInput")) == "textarea";
		if IsTextarea then
			Config.Numeric = false;
		end;
		local InputHeight = Config.Height or (IsTextarea and 72 or 18);
		local GetInputSize = LPH_NO_VIRTUALIZE(function()
			if Config.FullWidth then
				return UDim2.new(1, 0, 0, InputHeight);
			end;
			return UDim2.new(0, Config.Size, 0, InputHeight);
		end);
		local TextBoxLib = {};
		local TextInput = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")
		TextInput.Name = NeverloseUI.RandomString();
		TextInput.Parent = Handler
		TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = GetInputSize()
		TextInput.ZIndex = ZINdex + 13
		NeverloseUI:AttachLockMethods(TextBoxLib, self.Root or TextInput, Config);
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TextInput
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = TextInput
		TextBox.Parent = TextInput
		TextBox.AnchorPoint = IsTextarea and Vector2.new(0, 0) or Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = IsTextarea and UDim2.new(0, 6, 0, 5) or UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = IsTextarea and UDim2.new(1, -12, 1, -10) or UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = ZINdex + 14
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = Config.Placeholder
		TextBox.Text = tostring(Config.Default)
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 11.000
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		TextBox.TextYAlignment = IsTextarea and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
		TextBox.TextWrapped = IsTextarea
		TextBox.MultiLine = IsTextarea
		TextBoxLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 0
				})
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 0.650
				})
				NeverloseUI.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 0.350
				})
			else
				NeverloseUI.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 1
				})
			end;
		end);
		NeverloseUI:AddSignal(TextBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			local valout = NeverloseUI:ParseInput(TextBox.Text , Config.Numeric);
			if Config.Numeric then
				TextBox.Text = string.gsub(TextBox.Text , '[^0-9.]','')
			end;
			if valout then
				Config.Default = valout;
				NeverloseUI:FireCallback(Config.Callback, Config.Name, valout);
			end
		end)));
		TextBoxLib.SetRender(Signal:GetValue());
		Signal:Connect(TextBoxLib.SetRender);
		function TextBoxLib:GetValue()
			return Config.Default;
		end;
		function TextBoxLib:SetValue(v)
			Config.Default = v;
			TextBox.Text = tostring(v);
			NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
			return TextBoxLib;
		end;
		function TextBoxLib:Clear()
			TextBoxLib:SetValue("");
			return TextBoxLib;
		end;
		function TextBoxLib:SetPlaceholder(text)
			Config.Placeholder = tostring(text or "");
			TextBox.PlaceholderText = Config.Placeholder;
			return TextBoxLib;
		end;
		function TextBoxLib:SetNumeric(value)
			Config.Numeric = value == true;
			if Config.Numeric then
				Config.Type = "TextInput";
				TextBoxLib:SetType("TextInput");
			end;
			return TextBoxLib;
		end;
		function TextBoxLib:SetType(inputType)
			Config.Type = tostring(inputType or "TextInput");
			IsTextarea = string.lower(Config.Type) == "textarea";
			if IsTextarea then
				Config.Numeric = false;
			end;
			InputHeight = Config.Height or (IsTextarea and 72 or 18);
			TextInput.Size = GetInputSize();
			TextBox.AnchorPoint = IsTextarea and Vector2.new(0, 0) or Vector2.new(0, 0.5);
			TextBox.Position = IsTextarea and UDim2.new(0, 6, 0, 5) or UDim2.new(0, 5, 0.5, 0);
			TextBox.Size = IsTextarea and UDim2.new(1, -12, 1, -10) or UDim2.new(1, -5, 0, 17);
			TextBox.TextYAlignment = IsTextarea and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center;
			TextBox.TextWrapped = IsTextarea;
			TextBox.MultiLine = IsTextarea;
			return TextBoxLib;
		end;
		function TextBoxLib:SetHeight(height)
			Config.Height = tonumber(height) or Config.Height;
			InputHeight = Config.Height or (IsTextarea and 72 or 18);
			TextInput.Size = GetInputSize();
			return TextBoxLib;
		end;
		function TextBoxLib:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			return TextBoxLib;
		end;
		function TextBoxLib:Focus()
			TextBox:CaptureFocus();
			return TextBoxLib;
		end;
		function TextBoxLib:SetEnabled(value)
			TextInput.Visible = value ~= false;
			return TextBoxLib;
		end;
		if Config.Flag then
			NeverloseUI:RegisterFlag(Config.Flag, TextBoxLib);
		end;
		return CaseInsensitive(TextBoxLib);
	end;
	handle.AddInput = handle.AddTextInput;
	function handle:AddDropdown(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = nil,
			Default = nil,
			Values = {},
			Multi = false,
			Callback = EmptyFunction,
			AutoUpdate = false,
			Flag = nil,
			Key = nil,
			ConfigKey = nil,
			Locked = false,
			TextLocked = "Locked",
			Size = 100,
			Search = true,
			Position = "Dropdown",
			Placement = nil,
			DropdownPosition = nil,
			PopupPosition = nil,
			OptionsIcon = {},
			DisabledOptions = {},
			AllowNil = false,
			AutoSelectFirst = false,
			ValidateValue = true,
			RefreshInterval = nil,
			OptionsProvider = nil,
		})
		NeverloseUI:ResolveConfigFlag(Config);
		Config.Default = NeverloseUI.ProcessDropdown(Config.Default);
		Config.OptionsIcon = Config.OptionsIcon or Config.OptionIcons or Config.Icons or {};
		Config.DisabledOptions = Config.DisabledOptions or Config.Disabled or {};
		Config.AllowNil = Config.AllowNil == true;
		Config.AutoSelectFirst = Config.AutoSelectFirst == true;
		Config.ValidateValue = Config.ValidateValue ~= false;
		Config.DropdownPosition = Config.DropdownPosition or Config.PopupPosition or Config.Placement or Config.Position;
		local function NormalizeOptionMap(source)
			local Map = {};
			if typeof(source) == "string" or typeof(source) == "number" then
				Map[tostring(source)] = true;
				return Map;
			end;
			if typeof(source) ~= "table" then
				return Map;
			end;
			for key,value in next, source do
				if typeof(key) == "number" then
					Map[tostring(value)] = true;
				elseif value == true then
					Map[tostring(key)] = true;
				end;
			end;
			return Map;
		end;
		local function NormalizeIconMap(source)
			local Map = {};
			if typeof(source) ~= "table" then
				return Map;
			end;
			for key,value in next, source do
				if typeof(key) ~= "number" and value ~= nil then
					Map[tostring(key)] = value;
				elseif typeof(value) == "table" and value.Value and value.Icon then
					Map[tostring(value.Value)] = value.Icon;
				end;
			end;
			return Map;
		end;
		local DisabledMap = NormalizeOptionMap(Config.DisabledOptions);
		local IconMap = NormalizeIconMap(Config.OptionsIcon);
		local function GetFirstDropdownValue()
			for _,Value in next, Config.Values do
				return Value;
			end;
		end;
		local function HasDropdownValue(value)
			for _,Option in next, Config.Values do
				if Option == value then
					return true;
				end;
			end;
			return false;
		end;
		local function ResolveSingleDropdownValue(value)
			if value == nil then
				if Config.AutoSelectFirst then
					return GetFirstDropdownValue();
				end;
				return nil;
			end;
			if Config.ValidateValue and not HasDropdownValue(value) then
				if Config.AutoSelectFirst then
					return GetFirstDropdownValue();
				end;
				return nil;
			end;
			return value;
		end;
		local function ShouldFireDropdownCallback(value)
			return Config.Multi or value ~= nil or Config.AllowNil;
		end;
		local function ResolveMultiDropdownValue(value)
			local Processed = NeverloseUI.ProcessDropdown(value);
			if typeof(Processed) == "table" then
				return Processed;
			end;
			if Processed ~= nil then
				return {
					[Processed] = true,
				};
			end;
			return {};
		end;
		if Config.Multi then
			Config.Default = ResolveMultiDropdownValue(Config.Default);
		else
			Config.Default = ResolveSingleDropdownValue(Config.Default);
		end;
		local Dropdown = Instance.new("Frame")
		local DropdownIcon = Instance.new("ImageLabel")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local BasedLabel = Instance.new("TextLabel")
		Dropdown.Name = NeverloseUI.RandomString();
		Dropdown.Parent = Handler
		Dropdown.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		Dropdown.ClipsDescendants = true
		Dropdown.Size = UDim2.new(0, Config.Size, 0, 18)
		Dropdown.ZIndex = ZINdex + 13
		DropdownIcon.Name = NeverloseUI.RandomString();
		DropdownIcon.Parent = Dropdown
		DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
		DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownIcon.BackgroundTransparency = 1.000
		DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownIcon.BorderSizePixel = 0
		DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
		DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
		DropdownIcon.ZIndex = ZINdex + 14
		NeverloseUI:SetIconMode(DropdownIcon, "chevron-small-down")
		DropdownIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		DropdownIcon.ImageTransparency = 0.250
		DropdownIcon.ScaleType = Enum.ScaleType.Fit
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Dropdown
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Dropdown
		BasedLabel.Name = NeverloseUI.RandomString();
		BasedLabel.Parent = Dropdown
		BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.ClipsDescendants = true
		BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
		BasedLabel.Size = UDim2.new(1, -25, 0, 15)
		BasedLabel.ZIndex = ZINdex + 14
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 12.000
		BasedLabel.TextTransparency = 0.5
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
		do
			local UIGradient = Instance.new("UIGradient")
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.85, 0.23), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = BasedLabel;
		end;
		NeverloseUI:AddSignal(Dropdown.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.200
			})
		end)));
		NeverloseUI:AddSignal(Dropdown.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.5
			})
		end)));
		local DropdownLib = {
			OpenSignal = NeverloseUI:CreateSignal(false),
			Signals = {},
			Refuse = {},
			Items = {},
		};
		NeverloseUI:AttachLockMethods(DropdownLib, self.Root or Dropdown, Config);
		DropdownLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 0
				});
				NeverloseUI.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 0.250
				});
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				});
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.5
				});
			else
				NeverloseUI.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 1
				});
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				});
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});
			end
		end);
		DropdownLib.SetRender(Signal:GetValue())
		Signal:Connect(DropdownLib.SetRender);
		DropdownLib.ExtentSize = 0;
		do
			local DropdownHandler = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local SearchInput = Instance.new("Frame")
			local SearchCorner = Instance.new("UICorner")
			local SearchStroke = Instance.new("UIStroke")
			local SearchIcon = Instance.new("ImageLabel")
			local SearchBox = Instance.new("TextBox")
			local DropdownScrollFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Shadow = NeverloseUI:CreateShadow(DropdownHandler);
			DropdownHandler.Name = NeverloseUI.RandomString();
			DropdownHandler.Parent = NeverloseUI.ScreenGui;
			DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
			DropdownHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
			DropdownHandler.BackgroundTransparency = 0.5
			DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownHandler.BorderSizePixel = 0
			DropdownHandler.ClipsDescendants = true
			DropdownHandler.Position = UDim2.new(255,255,255,255)
			DropdownHandler.Size = UDim2.new(0, 125, 0, 50)
			DropdownHandler.ZIndex = ZINdex + 125
			DropdownLib.BlockRoot = DropdownHandler;
			NeverloseUI:AddSignal(DropdownHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if DropdownHandler.BackgroundTransparency > 0.9 then
					DropdownHandler.Visible = false;
					DropdownHandler.Parent = nil;
				else
					DropdownHandler.Visible = true;
					if NeverloseUI.Global3DRenderMode then
						DropdownHandler.Parent = NeverloseUI.GlobalSurfaceGui;
					else
						DropdownHandler.Parent = NeverloseUI.ScreenGui;
					end;
				end;
			end));
			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = DropdownHandler
			UIStroke.Transparency = 0.650
			UIStroke.Color = Color3.fromRGB(45, 48, 58)
			UIStroke.Parent = DropdownHandler
			SearchInput.Name = NeverloseUI.RandomString();
			SearchInput.Parent = DropdownHandler
			SearchInput.AnchorPoint = Vector2.new(0.5, 0)
			SearchInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
			SearchInput.BackgroundTransparency = 0.250
			SearchInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SearchInput.BorderSizePixel = 0
			SearchInput.ClipsDescendants = true
			SearchInput.Position = UDim2.new(0.5, 0, 0, 5)
			SearchInput.Size = UDim2.new(1, -10, 0, 26)
			SearchInput.Visible = Config.Search == true
			SearchInput.ZIndex = ZINdex + 127
			SearchCorner.CornerRadius = UDim.new(0, 5)
			SearchCorner.Parent = SearchInput
			SearchStroke.Transparency = 0.650
			SearchStroke.Color = Color3.fromRGB(45, 48, 58)
			SearchStroke.Parent = SearchInput
			SearchIcon.Name = NeverloseUI.RandomString();
			SearchIcon.Parent = SearchInput
			SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
			SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchIcon.BackgroundTransparency = 1.000
			SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SearchIcon.BorderSizePixel = 0
			SearchIcon.Position = UDim2.new(0, 4, 0.5, 0)
			SearchIcon.Size = UDim2.new(0, 20, 0, 20)
			SearchIcon.ZIndex = ZINdex + 128
			NeverloseUI:SetIconMode(SearchIcon, "magnifying-glass")
			SearchIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
			SearchIcon.ImageTransparency = 0.450
			SearchIcon.ScaleType = Enum.ScaleType.Fit
			SearchBox.Name = NeverloseUI.RandomString();
			SearchBox.Parent = SearchInput
			SearchBox.AnchorPoint = Vector2.new(0, 0.5)
			SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchBox.BackgroundTransparency = 1.000
			SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SearchBox.BorderSizePixel = 0
			SearchBox.ClearTextOnFocus = false
			SearchBox.PlaceholderText = "Search"
			SearchBox.Position = UDim2.new(0, 26, 0.5, 0)
			SearchBox.Size = UDim2.new(1, -31, 0, 20)
			SearchBox.ZIndex = ZINdex + 128
			SearchBox.Font = Enum.Font.GothamMedium
			SearchBox.Text = ""
			SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			SearchBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 155)
			SearchBox.TextSize = 12.000
			SearchBox.TextTransparency = 0.250
			SearchBox.TextXAlignment = Enum.TextXAlignment.Left
			DropdownScrollFrame.Name = NeverloseUI.RandomString();
			DropdownScrollFrame.Parent = DropdownHandler
			DropdownScrollFrame.Active = true
			DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0)
			DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownScrollFrame.BackgroundTransparency = 1.000
			DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownScrollFrame.BorderSizePixel = 0
			DropdownScrollFrame.Position = Config.Search and UDim2.new(0.5, 0, 0, 35) or UDim2.new(0.5, 0, 0, 2)
			DropdownScrollFrame.Size = Config.Search and UDim2.new(1, -5, 1, -38) or UDim2.new(1, -5, 1, -5)
			DropdownScrollFrame.ZIndex = ZINdex + 127
			DropdownScrollFrame.ScrollBarThickness = 0
			DropdownLib.RootItem = DropdownScrollFrame;
			UIListLayout.Parent = DropdownScrollFrame
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			local GetSearchOffset = LPH_NO_VIRTUALIZE(function()
				return (Config.Search == true and 35) or 5;
			end);
			local UpdateDropdownSize = LPH_NO_VIRTUALIZE(function()
				local ContentHeight = math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250);
				DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
				NeverloseUI.PlayAnimate(DropdownHandler , SlowyTween , {
					Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, ContentHeight + GetSearchOffset());
				})
			end);
			DropdownLib.ApplySearch = LPH_NO_VIRTUALIZE(function()
				local Query = string.lower(SearchBox.Text or "");
				for _,Item in next , DropdownLib.Items do
					if Item.Root then
						if Query == "" then
							Item.Root.Visible = true;
						else
							Item.Root.Visible = string.find(string.lower(Item.Text), Query, 1, true) ~= nil;
						end;
					end;
				end;
				UpdateDropdownSize();
			end);
			NeverloseUI:AddSignal(SearchBox:GetPropertyChangedSignal("Text"):Connect(LPH_NO_VIRTUALIZE(function()
				DropdownLib.ApplySearch();
			end)));
			NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				UpdateDropdownSize();
			end)));
			local GetDropdownWindowRoot = LPH_NO_VIRTUALIZE(function()
				local Current = Dropdown;
				while Current and Current.Parent do
					if Current.Parent == NeverloseUI.ScreenGui
					or (NeverloseUI.GlobalSurfaceGui and Current.Parent == NeverloseUI.GlobalSurfaceGui) then
						return Current;
					end;
					Current = Current.Parent;
				end;
				if NeverloseUI.ActiveWindow and NeverloseUI.ActiveWindow.Root then
					return NeverloseUI.ActiveWindow.Root;
				end;
			end);
			local SetPosition = LPH_NO_VIRTUALIZE(function()
				local Placement = string.lower(tostring(Config.DropdownPosition or "Dropdown"));
				if Placement == "center" or Placement == "middle" then
					local WindowRoot = GetDropdownWindowRoot();
					DropdownHandler.AnchorPoint = Vector2.new(0.5, 0.5);
					if WindowRoot and WindowRoot.Parent then
						DropdownHandler.Position = UDim2.fromOffset(
							WindowRoot.AbsolutePosition.X + (WindowRoot.AbsoluteSize.X / 2),
							WindowRoot.AbsolutePosition.Y + (WindowRoot.AbsoluteSize.Y / 2)
						);
					else
						DropdownHandler.Position = UDim2.fromOffset(
							NeverloseUI.ScreenGui.AbsoluteSize.X / 2,
							NeverloseUI.ScreenGui.AbsoluteSize.Y / 2
						);
					end;
					return;
				end;
				if NeverloseUI:MoreThanHalfY(Dropdown.AbsolutePosition.Y + 85) then
					DropdownHandler.AnchorPoint = Vector2.new(0.5,1)
				else
					DropdownHandler.AnchorPoint = Vector2.new(0.5,0)
				end;
				DropdownHandler.Position = UDim2.fromOffset(Dropdown.AbsolutePosition.X + (DropdownHandler.AbsoluteSize.X / 2), Dropdown.AbsolutePosition.Y + 85);
			end);
			DropdownLib.SetFrameRender = LPH_NO_VIRTUALIZE(function(value)
				DropdownLib.OpenSignal:SetValue(value);
				if value then
					Shadow:Render(true);
					if Config.Search then
						SearchBox.Text = "";
					end;
					DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250) + GetSearchOffset());
					SetPosition();
					NeverloseUI.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 0.035
					})
					NeverloseUI.PlayAnimate(SearchInput , SlowyTween , {
						BackgroundTransparency = Config.Search and 0.250 or 1
					})
					NeverloseUI.PlayAnimate(SearchStroke , SlowyTween , {
						Transparency = Config.Search and 0.650 or 1
					})
					NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
						TextTransparency = Config.Search and 0.450 or 1
					})
					NeverloseUI.PlayAnimate(SearchBox , SlowyTween , {
						TextTransparency = Config.Search and 0.250 or 1
					})
					if Config.AutoUpdate then
						DropdownLib:Generate();
					end;
				else
					NeverloseUI.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 1
					})
					SearchBox:ReleaseFocus();
					NeverloseUI.PlayAnimate(SearchInput , SlowyTween , {
						BackgroundTransparency = 1
					})
					NeverloseUI.PlayAnimate(SearchStroke , SlowyTween , {
						Transparency = 1
					})
					NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
						TextTransparency = 1
					})
					NeverloseUI.PlayAnimate(SearchBox , SlowyTween , {
						TextTransparency = 1
					})
					Shadow:Render(false);
				end;
			end);
			DropdownLib.SetFrameRender(false);
		end;
		local SecureSignal;
		NeverloseUI:CreateInput(Dropdown , LPH_NO_VIRTUALIZE(function()
			if SecureSignal then
				SecureSignal:Disconnect();
				SecureSignal = nil;
			end;
			DropdownLib.SetFrameRender(true);
			NeverloseUI.IsMosueOverOtherFrame = true;
			SecureSignal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverloseUI:IsMouseOverFrame(DropdownLib.BlockRoot) and not NeverloseUI:IsMouseOverFrame(Dropdown) then
						if SecureSignal then
							SecureSignal:Disconnect();
							SecureSignal = nil;
						end;
						NeverloseUI.IsMosueOverOtherFrame = false;
						DropdownLib.SetFrameRender(false);
					end;
				end
			end)
		end))
		DropdownLib.IsMatch = LPH_NO_VIRTUALIZE(function(v1)
			if typeof(Config.Default) =='table' then
				if Config.Default[v1] == true then
					return true;
				end
				for _, Value in next, Config.Default do
					if Value == v1 then
						return true;
					end;
				end;
			end
			if Config.Default == v1 then
				return true;
			end;
		end);
		function DropdownLib:Generate()
			for i,v in next , DropdownLib.RootItem:GetChildren() do
				if v:IsA('Frame') then
					v:Destroy();
				end;
			end;
			for i,v in next , DropdownLib.Signals do
				v:Disconnect();
			end;
			table.clear(DropdownLib.Signals);
			table.clear(DropdownLib.Refuse);
			table.clear(DropdownLib.Items);
			DropdownLib.ExtentSize = 0;
			DisabledMap = NormalizeOptionMap(Config.DisabledOptions);
			IconMap = NormalizeIconMap(Config.OptionsIcon);
			local Lastone;
			for i,Value in next , Config.Values do
				local ItemFrame = Instance.new("Frame")
				local ItemLabel = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local OptionIcon = nil;
				local ValueKey = tostring(Value);
				local IsDisabled = DisabledMap[ValueKey] == true;
				local CustomIcon = IconMap[ValueKey];
				ItemFrame.Name = NeverloseUI.RandomString();
				ItemFrame.Parent = DropdownLib.RootItem
				ItemFrame.BackgroundColor3 = Color3.fromRGB(29, 31, 38)
				ItemFrame.BackgroundTransparency = 1.000
				ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 25)
				ItemFrame.ZIndex = ZINdex + 1258
				ItemLabel.Name = NeverloseUI.RandomString();
				ItemLabel.Parent = ItemFrame
				ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemLabel.BackgroundTransparency = 1.000
				ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemLabel.BorderSizePixel = 0
				ItemLabel.Position = UDim2.new(0, CustomIcon and (Config.Multi and 50 or 34) or 15, 0, 4)
				ItemLabel.Size = UDim2.new(0,1, 0, 15)
				ItemLabel.ZIndex = ZINdex + 1258
				ItemLabel.Font = Enum.Font.GothamMedium
				ItemLabel.Text = tostring(Value);
				ItemLabel.TextColor3 = IsDisabled and Color3.fromRGB(140, 140, 155) or Color3.fromRGB(255, 255, 255)
				ItemLabel.TextSize = 13.000
				ItemLabel.TextTransparency = IsDisabled and 0.600 or 0.200
				ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 10)
				UICorner.Parent = ItemFrame
				if CustomIcon then
					OptionIcon = Instance.new("ImageLabel")
					OptionIcon.Parent = ItemFrame
					OptionIcon.AnchorPoint = Vector2.new(0, 0.5)
					OptionIcon.BackgroundTransparency = 1
					OptionIcon.BorderSizePixel = 0
					OptionIcon.Position = UDim2.new(0, Config.Multi and 29 or 13, 0.5, 0)
					OptionIcon.Size = UDim2.new(0, 15, 0, 15)
					OptionIcon.ZIndex = ZINdex + 1259
					NeverloseUI:SetIconMode(OptionIcon, CustomIcon)
					OptionIcon.ImageColor3 = IsDisabled and Color3.fromRGB(120, 120, 135) or Color3.fromRGB(223, 223, 223)
					OptionIcon.ImageTransparency = IsDisabled and 0.650 or 0.300
					OptionIcon.ScaleType = Enum.ScaleType.Fit
				end;
				local sizetext = TextService:GetTextSize(ItemLabel.Text , ItemLabel.TextSize,ItemLabel.Font,Vector2.new(math.huge,math.huge));
				DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize , sizetext.X + (CustomIcon and 20 or 0));
				table.insert(DropdownLib.Items , {
					Root = ItemFrame,
					Text = tostring(Value),
					Disabled = IsDisabled,
				});
				local MIcon , MarkItem = nil , nil;
				if Config.Multi then
					local Icon = Instance.new("ImageLabel")
					Icon.Parent = ItemFrame;
					Icon.AnchorPoint = Vector2.new(0, 0.5)
					Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Icon.BackgroundTransparency = 1.000
					Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Icon.BorderSizePixel = 0
					Icon.Position = UDim2.new(0, 5, 0.5, 0)
					Icon.Size = UDim2.new(0, 20, 0, 20)
					Icon.ZIndex = ZINdex + 1259
					NeverloseUI:SetIconMode(Icon, "check")
					Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
					Icon.ImageTransparency = 1
					Icon.ScaleType = Enum.ScaleType.Fit
					local VisiblewOfMult = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverloseUI.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = IsDisabled and 0.600 or 0.200,
								Position = UDim2.new(0, CustomIcon and 50 or 30, 0, 4)
							})
							NeverloseUI.PlayAnimate(Icon , SlowyTween , {
								TextTransparency = IsDisabled and 0.650 or 0.250
							})
							local FallbackText = Icon:FindFirstChild("ModernIconFallbackText");
							if FallbackText then
								FallbackText.TextTransparency = 0.250;
							end;
							Lastone = ItemLabel;
						else
							NeverloseUI.PlayAnimate(Icon , SlowyTween , {
								TextTransparency = 1
							})
							local FallbackText = Icon:FindFirstChild("ModernIconFallbackText");
							if FallbackText then
								FallbackText.TextTransparency = 1;
							end;
							NeverloseUI.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = IsDisabled and 0.650 or 0.5,
								Position = UDim2.new(0, CustomIcon and (Config.Multi and 50 or 34) or 15, 0, 4)
							})
						end;
					end);
					MIcon = Icon;
					MarkItem = VisiblewOfMult;
				else
					local DefaultVisible = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverloseUI.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = IsDisabled and 0.600 or 0.200
							})
							Lastone = ItemLabel;
						else
							NeverloseUI.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = IsDisabled and 0.650 or 0.5
							})
						end;
					end);
					MarkItem = DefaultVisible;
				end;
				MarkItem();
				table.insert(DropdownLib.Refuse , MarkItem)
				table.insert(DropdownLib.Signals,ItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					if IsDisabled then
						return;
					end;
					NeverloseUI.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 0.1
					})
				end)));
				table.insert(DropdownLib.Signals,ItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 1
					})
				end)));
				table.insert(DropdownLib.Signals , DropdownLib.OpenSignal:Connect(LPH_NO_VIRTUALIZE(function(val)
					if val then
						MarkItem();
						if OptionIcon then
							NeverloseUI.PlayAnimate(OptionIcon, SlowyTween, {
								TextTransparency = IsDisabled and 0.650 or 0.300
							})
						end;
					else
						NeverloseUI.PlayAnimate(ItemLabel , SlowyTween , {
							TextTransparency = 1
						})
						if OptionIcon then
							NeverloseUI.PlayAnimate(OptionIcon, SlowyTween, {
								TextTransparency = 1
							})
						end;
						if MIcon then
							NeverloseUI.PlayAnimate(MIcon , SlowyTween , {
								TextTransparency = 1
							})
							local FallbackText = MIcon:FindFirstChild("ModernIconFallbackText");
							if FallbackText then
								FallbackText.TextTransparency = 1;
							end;
						end;
					end;
				end)));
				if Config.Multi then
					local _,bth_signal = NeverloseUI:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						if IsDisabled then
							return;
						end;
						Config.Default[Value] = not Config.Default[Value];
						MarkItem();
						BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
						NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
					end));
					table.insert(DropdownLib.Signals , bth_signal);
				else
					local _,bth_signal = NeverloseUI:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						if IsDisabled then
							return;
						end;
						Config.Default = Value;
						for i,v in next , DropdownLib.Refuse do
							task.spawn(v);
						end;
						BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
						NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
					end));
					table.insert(DropdownLib.Signals , bth_signal);
				end;
			end;
			if DropdownLib.ApplySearch then
				DropdownLib.ApplySearch();
			end;
		end;
		DropdownLib:Generate();
		if type(Config.OptionsProvider) == "function" and tonumber(Config.RefreshInterval) then
			local Accumulator = 0;
			local Interval = math.max(tonumber(Config.RefreshInterval) or 1, 0.1);
			DropdownLib.RefreshSignal = NeverloseUI:AddSignal(RunService.RenderStepped:Connect(function(dt)
				if not Dropdown or not Dropdown.Parent then
					if DropdownLib.RefreshSignal then
						DropdownLib.RefreshSignal:Disconnect();
						DropdownLib.RefreshSignal = nil;
					end;
					return;
				end;
				Accumulator += dt or 0;
				if Accumulator < Interval then
					return;
				end;
				Accumulator = 0;
				local ok, values = pcall(Config.OptionsProvider);
				if ok and typeof(values) == "table" then
					Config.Values = values;
					if not Config.Multi then
						Config.Default = ResolveSingleDropdownValue(Config.Default);
						BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
					end;
					DropdownLib:Generate();
				end;
			end));
		end;
		function DropdownLib:GetValue()
			return Config.Default;
		end;
		function DropdownLib:SetValue(v)
			Config.Default = Config.Multi and ResolveMultiDropdownValue(v) or ResolveSingleDropdownValue(v);
			BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
			for i,v in next , DropdownLib.Refuse do
				task.spawn(v);
			end;
			if ShouldFireDropdownCallback(Config.Default) then
				NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
			end;
			return DropdownLib;
		end;
		function DropdownLib:SetValues(a)
			Config.Values = a or {};
			if not Config.Multi then
				Config.Default = ResolveSingleDropdownValue(Config.Default);
				BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
			end;
			if not Config.AutoUpdate then
				DropdownLib:Generate();
			end;
			return DropdownLib;
		end;
		function DropdownLib:SetDisabledOptions(disabledOptions)
			Config.DisabledOptions = disabledOptions or {};
			DisabledMap = NormalizeOptionMap(Config.DisabledOptions);
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:AddDisabledOptions(disabledOptions)
			local NewMap = NormalizeOptionMap(disabledOptions);
			for Option,_ in next, NewMap do
				DisabledMap[Option] = true;
			end;
			Config.DisabledOptions = DisabledMap;
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:RemoveDisabledOptions(enabledOptions)
			local RemoveMap = NormalizeOptionMap(enabledOptions);
			for Option,_ in next, RemoveMap do
				DisabledMap[Option] = nil;
			end;
			Config.DisabledOptions = DisabledMap;
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:SetOptionsIcon(icons)
			Config.OptionsIcon = icons or {};
			IconMap = NormalizeIconMap(Config.OptionsIcon);
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:AddOptionsIcon(option, icon)
			Config.OptionsIcon = Config.OptionsIcon or {};
			Config.OptionsIcon[tostring(option)] = icon;
			IconMap = NormalizeIconMap(Config.OptionsIcon);
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:AddValue(value)
			table.insert(Config.Values,value);
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:RemoveValue(value)
			for Index = #Config.Values, 1, -1 do
				if Config.Values[Index] == value then
					table.remove(Config.Values,Index);
				end;
			end;
			if typeof(Config.Default) == "table" then
				Config.Default[value] = nil;
			elseif Config.Default == value then
				Config.Default = nil;
			end;
			BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
			DropdownLib:Generate();
			return DropdownLib;
		end;
		function DropdownLib:Clear()
			Config.Default = Config.Multi and {} or nil;
			BasedLabel.Text = NeverloseUI.ParseDropdown(Config.Default);
			for _,Refresh in next, DropdownLib.Refuse do
				task.spawn(Refresh);
			end;
			if ShouldFireDropdownCallback(Config.Default) then
				NeverloseUI:FireCallback(Config.Callback, Config.Name, Config.Default);
			end;
			return DropdownLib;
		end;
		function DropdownLib:Select(value)
			if Config.Multi then
				Config.Default = NeverloseUI.ProcessDropdown(Config.Default);
				Config.Default[value] = true;
				DropdownLib:SetValue(Config.Default);
			else
				DropdownLib:SetValue(value);
			end;
			return DropdownLib;
		end;
		function DropdownLib:Unselect(value)
			if Config.Multi then
				Config.Default = NeverloseUI.ProcessDropdown(Config.Default);
				Config.Default[value] = nil;
				DropdownLib:SetValue(Config.Default);
			elseif Config.Default == value then
				DropdownLib:Clear();
			end;
			return DropdownLib;
		end;
		function DropdownLib:IsSelected(value)
			return DropdownLib.IsMatch(value) == true;
		end;
		function DropdownLib:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			return DropdownLib;
		end;
		function DropdownLib:SetSearch(value)
			Config.Search = value == true;
			if DropdownLib.ApplySearch then
				DropdownLib.ApplySearch();
			end;
			return DropdownLib;
		end;
		function DropdownLib:Open()
			DropdownLib.SetFrameRender(true);
			return DropdownLib;
		end;
		function DropdownLib:Close()
			DropdownLib.SetFrameRender(false);
			return DropdownLib;
		end;
		function DropdownLib:SetEnabled(value)
			Dropdown.Visible = value ~= false;
			return DropdownLib;
		end;
		if Config.Flag then
			NeverloseUI:RegisterFlag(Config.Flag, DropdownLib);
		end;
		return CaseInsensitive(DropdownLib);
	end;
	return CaseInsensitive(handle);
end;
NeverloseUI.ProcessDropdown = LPH_NO_VIRTUALIZE(function(value)
	if typeof(value) == 'table' then
		local data = {};
		for i,v in next , value do
			if typeof(v) == 'boolean' and typeof(i) ~= 'number' then
				data[i] = v;
			else
				data[v] = true;
			end;
		end;
		return data;
	else
		return value;
	end;
end);
NeverloseUI.ParseDropdown = LPH_NO_VIRTUALIZE(function(value)
	if not value then return 'Select'; end;
	local Out;
	if typeof(value) == 'table' then
		if #value > 0 then
			local x = {};
			for i,v in next , value do
				table.insert(x , tostring(v))
			end;
			Out = table.concat(x,' , ');
			table.clear(x);
		else
			local x = {};
			for i,v in next , value do
				if v == true then
					table.insert(x , tostring(i));
				end
			end;
			Out = table.concat(x,' , ');
			table.clear(x)
			if not Out:byte() then
				Out = 'Select';
			end
		end;
	else
		Out = tostring(value or 'Select');
	end;
	return Out;
end);
function NeverloseUI:ParseInput(Value , Numeric)
	if not Value then
		return (Numeric and nil) or "";
	end;
	if Numeric then
		local out = string.gsub(tostring(Value), '[^0-9.%-]', '')
		if tonumber(out) then
			return tonumber(out);
		end;
		return nil;
	end;
	return Value;
end;
function NeverloseUI:CreateToolTips(Container , Name , Content)
	local Tooltips = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local TooltipName = Instance.new("TextLabel")
	local TooltipContent = Instance.new("TextLabel")
	local Shadow = NeverloseUI:CreateShadow(Tooltips);
	Tooltips.Name = NeverloseUI.RandomString();
	Tooltips.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	Tooltips.BackgroundTransparency = 0.075
	Tooltips.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tooltips.BorderSizePixel = 0
	Tooltips.ClipsDescendants = true
	Tooltips.Position = UDim2.new(255,255,255,255)
	Tooltips.Size = UDim2.new(0,0,0,0)
	Tooltips.ZIndex = 130
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Tooltips
	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = Tooltips
	TooltipName.Name = NeverloseUI.RandomString();
	TooltipName.Parent = Tooltips
	TooltipName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.BackgroundTransparency = 1.000
	TooltipName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipName.BorderSizePixel = 0
	TooltipName.Position = UDim2.new(0, 15, 0, 5)
	TooltipName.Size = UDim2.new(0, 1, 0, 20)
	TooltipName.ZIndex = 132
	TooltipName.Font = Enum.Font.GothamBold
	TooltipName.Text = Name
	TooltipName.TextColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.TextSize = 15.000
	TooltipName.TextXAlignment = Enum.TextXAlignment.Left
	TooltipContent.Name = NeverloseUI.RandomString();
	TooltipContent.Parent = Tooltips
	TooltipContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.BackgroundTransparency = 1.000
	TooltipContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipContent.BorderSizePixel = 0
	TooltipContent.Position = UDim2.new(0, 15, 0, 30)
	TooltipContent.Size = UDim2.new(0, 1, 0, 15)
	TooltipContent.ZIndex = 132
	TooltipContent.Font = Enum.Font.GothamBold
	TooltipContent.Text = Content
	TooltipContent.TextColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.TextSize = 12.000
	TooltipContent.TextTransparency = 0.650
	TooltipContent.TextXAlignment = Enum.TextXAlignment.Left
	TooltipContent.TextYAlignment = Enum.TextYAlignment.Top
	local ToolTip = {};
	ToolTip.Update = LPH_NO_VIRTUALIZE(function()
		local SizeName = TextService:GetTextSize(TooltipName.Text , TooltipName.TextSize , TooltipName.Font , Vector2.new(math.huge,math.huge));
		local SizeContent = TextService:GetTextSize(TooltipContent.Text , TooltipContent.TextSize , TooltipContent.Font , Vector2.new(math.huge,math.huge));
		local MaxX = math.max(SizeName.X , SizeContent.X) + 65;
		local MaxY = SizeName.Y + SizeContent.Y + 30;
		NeverloseUI.PlayAnimate(Tooltips,SlowyTween , {
			Size = UDim2.new(0,MaxX,0,MaxY)
		})
	end)
	NeverloseUI:AddSignal(Tooltips:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if Tooltips.BackgroundTransparency > 0.9 then
			Tooltips.Visible = false;
			Tooltips.Parent = nil;
		else
			Tooltips.Visible = true;
			if NeverloseUI.Global3DRenderMode then
				Tooltips.Parent = NeverloseUI.GlobalSurfaceGui;
			else
				Tooltips.Parent = NeverloseUI.ScreenGui;
			end;
		end
	end)));
	ToolTip.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			Tooltips.Position = UDim2.fromOffset(Container.AbsolutePosition.X + Container.AbsoluteSize.X , Container.AbsolutePosition.Y + (Container.AbsoluteSize.Y + 25));
			NeverloseUI.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 0.075
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})
			NeverloseUI.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 0
			})
			NeverloseUI.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 0.650
			})
			ToolTip.Update();
			Shadow:Render(true);
		else
			NeverloseUI.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 1
			})
			Shadow:Render(false);
		end;
	end);
	ToolTip.SetRender(false);
	ToolTip.Update();
	local DelayThread;
	NeverloseUI:AddSignal(Container.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;
		DelayThread = task.delay(1,ToolTip.SetRender,true);
	end)));
	NeverloseUI:AddSignal(Container.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;
		ToolTip.SetRender(false);
		ToolTip.Update();
	end)))
	return ToolTip;
end;
function NeverloseUI:RegisiterItem(Frame , Signel)
	local idx = {};
	local LayerIndex = Frame.ZIndex;
	function idx:AddLabel(Name,Warp)
		local RichText = false;
		local AutoSize = false;
		local Stacked = false;
		if typeof(Name) == "table" then
			local Config = Name;
			Name = Config.Text or Config.Name or Config.Title or "Label";
			AutoSize = Config.AutomaticSize == true;
			Warp = Config.Wrap or Config.Warp or Config.Wrapped or AutoSize or Warp;
			RichText = Config.RichText;
		end;
		Name = tostring(Name or "Label");
		RichText = RichText == true;
		Warp = Warp == true;
		local BasedFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local UICorner = Instance.new("UICorner")
		BasedFrame.Name = NeverloseUI.RandomString();
		BasedFrame.Parent = Frame
		BasedFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		BasedFrame.BackgroundTransparency = 1.000
		BasedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedFrame.BorderSizePixel = 0
		BasedFrame.Size = UDim2.new(1, 0, 0, 30)
		BasedFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AddQuery(BasedFrame , Name);
		BasedLabel.Name = NeverloseUI.RandomString();
		BasedLabel.Parent = BasedFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.ClipsDescendants = true
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = LayerIndex + 9
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.RichText = RichText
		BasedLabel.Text = Name
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.35
		BasedLabel.TextTruncate = Enum.TextTruncate.None
		BasedLabel.TextWrapped = Warp
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
		BasedLabel.TextYAlignment = (Warp and Enum.TextYAlignment.Top) or Enum.TextYAlignment.Center
		NeverloseUI:AddTextGradient(BasedLabel);
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = BasedFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		BasedHandler.Name = NeverloseUI.RandomString();
		BasedHandler.Parent = BasedFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = LayerIndex + 12
		UIListLayout.Parent = BasedHandler
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 5)
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = BasedFrame
		local UpdateRowLayout = LPH_NO_VIRTUALIZE(function()
			task.defer(function()
				if not BasedFrame.Parent then
					return;
				end;
				local FrameWidth = BasedFrame.AbsoluteSize.X;
				if FrameWidth <= 0 then
					return;
				end;
				local ContentWidth = math.ceil(UIListLayout.AbsoluteContentSize.X);
				local MaxContentWidth = math.max(0, FrameWidth - 28);
				ContentWidth = math.clamp(ContentWidth, 0, MaxContentWidth);
				local HandlerHeight = math.max(25, UIListLayout.AbsoluteContentSize.Y);
				local LabelWidth = Stacked and math.max(0, FrameWidth - 22) or math.max(0, FrameWidth - ContentWidth - 28);
				local LabelTextSize = 13;
				local LabelHeight = 15;
				if Warp then
					BasedLabel.TextWrapped = true;
					BasedLabel.TextYAlignment = Enum.TextYAlignment.Top;
					if LabelWidth > 0 then
						LabelHeight = math.max(15, TextService:GetTextSize(
							BasedLabel.Text,
							LabelTextSize,
							BasedLabel.Font,
							Vector2.new(LabelWidth, math.huge)
						).Y);
					end;
				elseif LabelWidth > 0 then
					BasedLabel.TextWrapped = false;
					BasedLabel.TextYAlignment = Enum.TextYAlignment.Center;
					while LabelTextSize > 9 and TextService:GetTextSize(
						BasedLabel.Text,
						LabelTextSize,
						BasedLabel.Font,
						Vector2.new(math.huge, math.huge)
					).X > LabelWidth do
						LabelTextSize = LabelTextSize - 1;
					end;
				end;
				local TargetHeight = Stacked and math.max(30, LabelHeight + HandlerHeight + 18) or math.max(30, HandlerHeight + 5, LabelHeight + 13);
				BasedLabel.TextSize = LabelTextSize;
				BasedLabel.Size = UDim2.new(0, LabelWidth, 0, LabelHeight);
				if Stacked then
					BasedHandler.AnchorPoint = Vector2.new(0, 0);
					BasedHandler.Position = UDim2.new(0, 11, 0, LabelHeight + 11);
					BasedHandler.Size = UDim2.new(1, -22, 0, HandlerHeight);
				else
					BasedHandler.AnchorPoint = Vector2.new(1, 0);
					BasedHandler.Size = UDim2.new(0, ContentWidth, 0, 25);
					BasedHandler.Position = UDim2.new(1, -11, 0, math.max(2, math.floor((TargetHeight - 25) / 2)));
				end;
				BasedFrame.Size = UDim2.new(1, 0, 0, TargetHeight);
			end);
		end);
		NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(UpdateRowLayout));
		NeverloseUI:AddSignal(BasedFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(UpdateRowLayout));
		UpdateRowLayout();
		local UpdateWarp = LPH_NO_VIRTUALIZE(function()
			UpdateRowLayout();
		end);
		if Warp then
			UpdateWarp();
		end;
		local handle = NeverloseUI:RegisiterHandler(BasedHandler , Signel);
		handle.Root = BasedFrame;
		handle.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.35
				})
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})
			else
				NeverloseUI.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end);
		function handle:SetVisible(val)
			BasedFrame.Visible = val;
			return handle;
		end;
		NeverloseUI:AddSignal(BasedFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});
			NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.25
			})
		end)))
		NeverloseUI:AddSignal(BasedFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 1
			});
			NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.35
			})
		end)))
		function handle:SetText(t)
			local oldtxt = BasedLabel.Text;
			BasedLabel.Text = tostring(t or "");
			UpdateRowLayout();
			if Warp and oldtxt ~= BasedLabel.Text then
				UpdateWarp();
			end;
			return handle;
		end;
		function handle:GetText()
			return BasedLabel.Text;
		end;
		function handle:SetRichText(value)
			BasedLabel.RichText = value == true;
			UpdateRowLayout();
			return handle;
		end;
		function handle:GetRichText()
			return BasedLabel.RichText;
		end;
		function handle:SetWrapped(value)
			Warp = value == true;
			BasedLabel.TextWrapped = Warp;
			BasedLabel.TextYAlignment = (Warp and Enum.TextYAlignment.Top) or Enum.TextYAlignment.Center;
			UpdateRowLayout();
			return handle;
		end;
		function handle:SetAutomaticSize(value)
			AutoSize = value == true;
			return handle:SetWrapped(AutoSize);
		end;
		function handle:SetStacked(value)
			Stacked = value == true;
			UIListLayout.HorizontalAlignment = (Stacked and Enum.HorizontalAlignment.Left) or Enum.HorizontalAlignment.Right;
			UpdateRowLayout();
			return handle;
		end;
		function handle:GetStacked()
			return Stacked;
		end;
		function handle:ToolTip(Content)
			handle.ToolTip = NeverloseUI:CreateToolTips(BasedFrame , Name , Content);
			return handle;
		end;
		handle.SetRender(Signel:GetValue());
		Signel:Connect(handle.SetRender);
		return CaseInsensitive(handle);
	end;
	function idx:AddButton(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Icon = 'chevron-large-left',
			IconPosition = "Left",
			Name = "Button",
			Callback = EmptyFunction,
			ToolTip = nil,
			Locked = false,
			TextLocked = "Locked",
		});
		local Button = {};
		local ButtonFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Icon = Instance.new("ImageLabel")
		NeverloseUI:AddQuery(ButtonFrame , Config.Name);
		ButtonFrame.Name = NeverloseUI.RandomString();
		ButtonFrame.Parent = Frame
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFrame.BorderSizePixel = 0
		ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
		ButtonFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(Button, ButtonFrame, Config);
		BasedLabel.Name = NeverloseUI.RandomString();
		BasedLabel.Parent = ButtonFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 35, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = LayerIndex + 9
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = Config.Name;
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(BasedLabel);
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = ButtonFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ButtonFrame
		Icon.Name = NeverloseUI.RandomString();
		Icon.Parent = ButtonFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 11, 0, 5)
		Icon.Size = UDim2.new(0, 18, 0, 18)
		Icon.ZIndex = LayerIndex + 9
		NeverloseUI:SetIconMode(Icon, Config.Icon)
		Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		Icon.ImageTransparency = 0.250
		Icon.ScaleType = Enum.ScaleType.Fit
		local function ResolveIconPosition(value)
			value = string.lower(tostring(value or "left"));
			if value == "right" then
				return "Right";
			end;
			return "Left";
		end;
		local function UpdateButtonLayout()
			Config.IconPosition = ResolveIconPosition(Config.IconPosition);
			if Config.IconPosition == "Right" then
				Icon.AnchorPoint = Vector2.new(1, 0);
				Icon.Position = UDim2.new(1, -11, 0, 5);
				BasedLabel.Position = UDim2.new(0, 11, 0, 6);
				BasedLabel.Size = UDim2.new(1, -46, 0, 15);
			else
				Icon.AnchorPoint = Vector2.new(0, 0);
				Icon.Position = UDim2.new(0, 11, 0, 5);
				BasedLabel.Position = UDim2.new(0, 35, 0, 6);
				BasedLabel.Size = UDim2.new(1, -46, 0, 15);
			end;
		end;
		UpdateButtonLayout();
		function Button:SetText(t)
			BasedLabel.Text = t;
			return Button;
		end;
		function Button:SetIcon(t)
			Config.Icon = t or Config.Icon;
			NeverloseUI:SetIconMode(Icon, Config.Icon)
			return Button;
		end;
		function Button:SetIconPosition(position)
			Config.IconPosition = ResolveIconPosition(position);
			UpdateButtonLayout();
			return Button;
		end;
		function Button:GetIconPosition()
			return Config.IconPosition;
		end;
		function Button:SetCallback(fn)
			Config.Callback = fn or EmptyFunction;
			return Button;
		end;
		function Button:Fire(...)
			NeverloseUI:FireCallback(Config.Callback, Config.Name, ...);
			return Button;
		end;
		function Button:Click(...)
			return Button:Fire(...);
		end;
		function Button:SetVisible(value)
			ButtonFrame.Visible = value ~= false;
			return Button;
		end;
		function Button:SetIconColor(color)
			Icon.ImageColor3 = color or Icon.ImageColor3;
			return Button;
		end;
		function Button:SetTextColor(color)
			BasedLabel.TextColor3 = color or BasedLabel.TextColor3;
			return Button;
		end;
		local bth = NeverloseUI:CreateInput(ButtonFrame , LPH_NO_VIRTUALIZE(function()
			NeverloseUI:FireCallback(Config.Callback, Config.Name);
		end));
		NeverloseUI:AddSignal(bth.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});
		end)))
		NeverloseUI:AddSignal(bth.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 1
			});
		end)))
		Button.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				});
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				});
				NeverloseUI.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.250
				});
			else
				NeverloseUI.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				});
			end;
		end);
		if Config.ToolTip then
			Button.ToolTip = NeverloseUI:CreateToolTips(ButtonFrame , Config.Name , Config.ToolTip);
		end;
		Button.SetRender(Signel:GetValue())
		Signel:Connect(Button.SetRender);
		return CaseInsensitive(Button);
	end;
	function idx:AddParagraph(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Content = tostring(Config or ""),
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Information",
			Content = "",
			RichText = true,
			Locked = false,
			TextLocked = "Locked",
		});
		local Paragraph = {};
		local ParagraphFrame = Instance.new("Frame")
		local NameLabel = Instance.new("TextLabel")
		local ContentLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		NeverloseUI:AddQuery(ParagraphFrame , Config.Name);
		ParagraphFrame.Name = NeverloseUI.RandomString();
		ParagraphFrame.Parent = Frame
		ParagraphFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		ParagraphFrame.BackgroundTransparency = 1.000
		ParagraphFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ParagraphFrame.BorderSizePixel = 0
		ParagraphFrame.ClipsDescendants = true
		ParagraphFrame.Size = UDim2.new(1, 0, 0, 58)
		ParagraphFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(Paragraph, ParagraphFrame, Config);
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ParagraphFrame
		NameLabel.Name = NeverloseUI.RandomString();
		NameLabel.Parent = ParagraphFrame
		NameLabel.BackgroundTransparency = 1.000
		NameLabel.BorderSizePixel = 0
		NameLabel.Position = UDim2.new(0, 11, 0, 7)
		NameLabel.Size = UDim2.new(1, -22, 0, 16)
		NameLabel.ZIndex = LayerIndex + 9
		NameLabel.Font = Enum.Font.GothamMedium
		NameLabel.RichText = Config.RichText == true
		NameLabel.Text = tostring(Config.Name)
		NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		NameLabel.TextSize = 13.000
		NameLabel.TextTransparency = 0.200
		NameLabel.TextXAlignment = Enum.TextXAlignment.Left
		NameLabel.TextYAlignment = Enum.TextYAlignment.Top
		NeverloseUI:AddTextGradient(NameLabel);
		ContentLabel.Name = NeverloseUI.RandomString();
		ContentLabel.Parent = ParagraphFrame
		ContentLabel.BackgroundTransparency = 1.000
		ContentLabel.BorderSizePixel = 0
		ContentLabel.Position = UDim2.new(0, 11, 0, 26)
		ContentLabel.Size = UDim2.new(1, -22, 0, 20)
		ContentLabel.ZIndex = LayerIndex + 9
		ContentLabel.Font = Enum.Font.GothamMedium
		ContentLabel.RichText = Config.RichText == true
		ContentLabel.Text = tostring(Config.Content)
		ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ContentLabel.TextSize = 12.000
		ContentLabel.TextTransparency = 0.500
		ContentLabel.TextWrapped = true
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
		ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = ParagraphFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		local function UpdateSize()
			local Width = math.max(120, ParagraphFrame.AbsoluteSize.X - 22);
			local ContentSize = TextService:GetTextSize(ContentLabel.Text,ContentLabel.TextSize,ContentLabel.Font,Vector2.new(Width,math.huge));
			local Height = math.max(58, ContentSize.Y + 38);
			ContentLabel.Size = UDim2.new(1, -22, 0, ContentSize.Y + 4);
			NeverloseUI.PlayAnimate(ParagraphFrame , SlowyTween , {
				Size = UDim2.new(1, 0, 0, Height)
			});
		end;
		task.defer(UpdateSize);
		NeverloseUI:AddSignal(ParagraphFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateSize));
		function Paragraph:SetName(name)
			Config.Name = tostring(name or "");
			NameLabel.Text = Config.Name;
			return Paragraph;
		end;
		function Paragraph:SetContent(content)
			Config.Content = tostring(content or "");
			ContentLabel.Text = Config.Content;
			UpdateSize();
			return Paragraph;
		end;
		function Paragraph:GetName()
			return Config.Name;
		end;
		function Paragraph:GetContent()
			return Config.Content;
		end;
		function Paragraph:SetRichText(value)
			Config.RichText = value == true;
			NameLabel.RichText = Config.RichText;
			ContentLabel.RichText = Config.RichText;
			return Paragraph;
		end;
		function Paragraph:GetRichText()
			return Config.RichText == true;
		end;
		function Paragraph:SetVisible(value)
			ParagraphFrame.Visible = value ~= false;
			return Paragraph;
		end;
		Paragraph.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(NameLabel , SlowyTween , {
					TextTransparency = 0.200
				});
				NeverloseUI.PlayAnimate(ContentLabel , SlowyTween , {
					TextTransparency = 0.500
				});
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				});
			else
				NeverloseUI.PlayAnimate(NameLabel , SlowyTween , {
					TextTransparency = 1
				});
				NeverloseUI.PlayAnimate(ContentLabel , SlowyTween , {
					TextTransparency = 1
				});
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
			end;
		end);
		Paragraph.SetRender(Signel:GetValue());
		Signel:Connect(Paragraph.SetRender);
		return CaseInsensitive(Paragraph);
	end;
	function idx:AddImage(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Image = tostring(Config or ""),
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Image",
			Image = "",
			Size = UDim2.new(1, -20, 0, 120),
			Height = nil,
			ScaleType = Enum.ScaleType.Fit,
			Color = Color3.fromRGB(255, 255, 255),
			Transparency = 0,
			Corner = 6,
			Locked = false,
			TextLocked = "Locked",
		});
		local ImageLib = {};
		local ImageFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ImageLabel = Instance.new("ImageLabel")
		local ImageCorner = Instance.new("UICorner")
		local LineFrame = Instance.new("Frame")
		if Config.Height then
			Config.Size = UDim2.new(1, -20, 0, tonumber(Config.Height) or 120);
		end;
		NeverloseUI:AddQuery(ImageFrame , Config.Name);
		ImageFrame.Name = NeverloseUI.RandomString();
		ImageFrame.Parent = Frame
		ImageFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		ImageFrame.BackgroundTransparency = 1.000
		ImageFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageFrame.BorderSizePixel = 0
		ImageFrame.ClipsDescendants = true
		ImageFrame.Size = UDim2.new(1, 0, 0, Config.Size.Y.Offset + 15)
		ImageFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(ImageLib, ImageFrame, Config);
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ImageFrame
		ImageLabel.Name = NeverloseUI.RandomString();
		ImageLabel.Parent = ImageFrame
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.5, 0, 0, 7)
		ImageLabel.Size = Config.Size
		ImageLabel.ZIndex = LayerIndex + 9
		ImageLabel.ImageColor3 = Config.Color
		ImageLabel.ImageTransparency = Config.Transparency
		ImageLabel.ScaleType = Config.ScaleType
		NeverloseUI:SetIconMode(ImageLabel, Config.Image);
		ImageLabel.ScaleType = Config.ScaleType;
		ImageLabel.ImageColor3 = Config.Color;
		ImageLabel.ImageTransparency = Config.Transparency;
		local ImageScale = ImageLabel:FindFirstChild("ModernIconScale");
		if ImageScale then
			ImageScale.Scale = 1;
		end;
		ImageCorner.CornerRadius = UDim.new(0, Config.Corner)
		ImageCorner.Parent = ImageLabel
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = ImageFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		local function UpdateSize()
			local Height = math.max(30, ImageLabel.Size.Y.Offset + 15);
			ImageFrame.Size = UDim2.new(1, 0, 0, Height);
		end;
		function ImageLib:SetImage(image)
			Config.Image = tostring(image or "");
			NeverloseUI:SetIconMode(ImageLabel, Config.Image);
			ImageLabel.ScaleType = Config.ScaleType;
			ImageLabel.ImageColor3 = Config.Color;
			ImageLabel.ImageTransparency = Config.Transparency;
			local ImageScale = ImageLabel:FindFirstChild("ModernIconScale");
			if ImageScale then
				ImageScale.Scale = 1;
			end;
			return ImageLib;
		end;
		function ImageLib:GetImage()
			return Config.Image;
		end;
		function ImageLib:SetSize(size)
			if typeof(size) == "UDim2" then
				Config.Size = size;
			elseif typeof(size) == "number" then
				Config.Size = UDim2.new(1, -20, 0, size);
			end;
			ImageLabel.Size = Config.Size;
			UpdateSize();
			return ImageLib;
		end;
		function ImageLib:SetHeight(height)
			return ImageLib:SetSize(tonumber(height) or ImageLabel.Size.Y.Offset);
		end;
		function ImageLib:SetScaleType(scaleType)
			Config.ScaleType = scaleType or Config.ScaleType;
			ImageLabel.ScaleType = Config.ScaleType;
			return ImageLib;
		end;
		function ImageLib:SetColor(color)
			Config.Color = color or Config.Color;
			ImageLabel.ImageColor3 = Config.Color;
			return ImageLib;
		end;
		function ImageLib:SetTransparency(value)
			Config.Transparency = tonumber(value) or Config.Transparency;
			ImageLabel.ImageTransparency = Config.Transparency;
			return ImageLib;
		end;
		function ImageLib:SetVisible(value)
			ImageFrame.Visible = value ~= false;
			return ImageLib;
		end;
		ImageLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = Config.Transparency
				});
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				});
			else
				NeverloseUI.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 1
				});
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				});
			end;
		end);
		UpdateSize();
		ImageLib.SetRender(Signel:GetValue());
		Signel:Connect(ImageLib.SetRender);
		return CaseInsensitive(ImageLib);
	end;
	function idx:AddDivider(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Text = tostring(Config or ""),
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Text = "",
			Name = nil,
		});
		local Divider = {};
		local DividerFrame = Instance.new("Frame")
		local LeftLine = Instance.new("Frame")
		local RightLine = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		DividerFrame.Name = NeverloseUI.RandomString();
		DividerFrame.Parent = Frame
		DividerFrame.BackgroundTransparency = 1.000
		DividerFrame.BorderSizePixel = 0
		DividerFrame.Size = UDim2.new(1, 0, 0, 22)
		DividerFrame.ZIndex = LayerIndex + 8
		LeftLine.Name = NeverloseUI.RandomString();
		LeftLine.Parent = DividerFrame
		LeftLine.AnchorPoint = Vector2.new(0, 0.5)
		LeftLine.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LeftLine.BackgroundTransparency = 0.650
		LeftLine.BorderSizePixel = 0
		LeftLine.Position = UDim2.new(0, 10, 0.5, 0)
		LeftLine.Size = UDim2.new(0.5, -20, 0, 1)
		LeftLine.ZIndex = LayerIndex + 9
		TextLabel.Name = NeverloseUI.RandomString();
		TextLabel.Parent = DividerFrame
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.fromScale(0.5, 0.5)
		TextLabel.Size = UDim2.new(0, 0, 0, 16)
		TextLabel.ZIndex = LayerIndex + 9
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = tostring(Config.Text or Config.Name or "")
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 11.000
		TextLabel.TextTransparency = 0.500
		RightLine.Name = NeverloseUI.RandomString();
		RightLine.Parent = DividerFrame
		RightLine.AnchorPoint = Vector2.new(1, 0.5)
		RightLine.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		RightLine.BackgroundTransparency = 0.650
		RightLine.BorderSizePixel = 0
		RightLine.Position = UDim2.new(1, -10, 0.5, 0)
		RightLine.Size = UDim2.new(0.5, -20, 0, 1)
		RightLine.ZIndex = LayerIndex + 9
		local function UpdateDivider()
			local Text = TextLabel.Text;
			if Text == "" then
				TextLabel.Visible = false;
				LeftLine.Size = UDim2.new(1, -20, 0, 1);
				RightLine.Visible = false;
				return;
			end;
			TextLabel.Visible = true;
			RightLine.Visible = true;
			local MaxTextWidth = math.max(40, DividerFrame.AbsoluteSize.X - 70);
			local TextWidth = math.min(TextService:GetTextSize(Text, TextLabel.TextSize, TextLabel.Font, Vector2.new(math.huge, math.huge)).X + 16, MaxTextWidth);
			TextLabel.Size = UDim2.new(0, TextWidth, 0, 16);
			LeftLine.Size = UDim2.new(0.5, -(TextWidth / 2) - 12, 0, 1);
			RightLine.Size = UDim2.new(0.5, -(TextWidth / 2) - 12, 0, 1);
		end;
		function Divider:SetText(text)
			Config.Text = tostring(text or "");
			TextLabel.Text = Config.Text;
			UpdateDivider();
			return Divider;
		end;
		function Divider:GetText()
			return TextLabel.Text;
		end;
		function Divider:SetVisible(value)
			DividerFrame.Visible = value ~= false;
			return Divider;
		end;
		Divider.SetRender = LPH_NO_VIRTUALIZE(function(value)
			NeverloseUI.PlayAnimate(LeftLine , SlowyTween , {
				BackgroundTransparency = value and 0.650 or 1
			});
			NeverloseUI.PlayAnimate(RightLine , SlowyTween , {
				BackgroundTransparency = value and 0.650 or 1
			});
			NeverloseUI.PlayAnimate(TextLabel , SlowyTween , {
				TextTransparency = value and 0.500 or 1
			});
		end);
		UpdateDivider();
		NeverloseUI:AddSignal(DividerFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateDivider));
		Divider.SetRender(Signel:GetValue());
		Signel:Connect(Divider.SetRender);
		return CaseInsensitive(Divider);
	end;
	function idx:AddSpacer(Size)
		local Spacer = {};
		local Height = 8;
		if typeof(Size) == "table" then
			Height = tonumber(Size.Size or Size.Height or Size[1]) or Height;
		else
			Height = tonumber(Size) or Height;
		end;
		local SpacerFrame = Instance.new("Frame")
		SpacerFrame.Name = NeverloseUI.RandomString();
		SpacerFrame.Parent = Frame
		SpacerFrame.BackgroundTransparency = 1.000
		SpacerFrame.BorderSizePixel = 0
		SpacerFrame.Size = UDim2.new(1, 0, 0, Height)
		SpacerFrame.ZIndex = LayerIndex + 8
		function Spacer:SetSize(size)
			Height = tonumber(size) or Height;
			SpacerFrame.Size = UDim2.new(1, 0, 0, Height);
			return Spacer;
		end;
		function Spacer:GetSize()
			return Height;
		end;
		function Spacer:SetVisible(value)
			SpacerFrame.Visible = value ~= false;
			return Spacer;
		end;
		Spacer.SetRender = LPH_NO_VIRTUALIZE(function(value)
			SpacerFrame.Visible = value == true;
		end);
		Spacer.SetRender(Signel:GetValue());
		Signel:Connect(Spacer.SetRender);
		return CaseInsensitive(Spacer);
	end;
	function idx:AddProgressBar(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Value = tonumber(Config) or 0,
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Progress",
			Value = 0,
			Max = 100,
			Type = "%",
			Locked = false,
			TextLocked = "Locked",
		});
		local Progress = {};
		local ProgressFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")
		local ValueLabel = Instance.new("TextLabel")
		local BarBack = Instance.new("Frame")
		local BarBackCorner = Instance.new("UICorner")
		local BarFill = Instance.new("Frame")
		local BarFillCorner = Instance.new("UICorner")
		local LineFrame = Instance.new("Frame")
		NeverloseUI:AddQuery(ProgressFrame , Config.Name);
		ProgressFrame.Name = NeverloseUI.RandomString();
		ProgressFrame.Parent = Frame
		ProgressFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		ProgressFrame.BackgroundTransparency = 1.000
		ProgressFrame.BorderSizePixel = 0
		ProgressFrame.ClipsDescendants = true
		ProgressFrame.Size = UDim2.new(1, 0, 0, 45)
		ProgressFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(Progress, ProgressFrame, Config);
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ProgressFrame
		Title.Name = NeverloseUI.RandomString();
		Title.Parent = ProgressFrame
		Title.BackgroundTransparency = 1.000
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 11, 0, 6)
		Title.Size = UDim2.new(1, -90, 0, 15)
		Title.ZIndex = LayerIndex + 9
		Title.Font = Enum.Font.GothamMedium
		Title.Text = tostring(Config.Name)
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 13.000
		Title.TextTransparency = 0.250
		Title.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(Title);
		ValueLabel.Name = NeverloseUI.RandomString();
		ValueLabel.Parent = ProgressFrame
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderSizePixel = 0
		ValueLabel.Position = UDim2.new(1, -80, 0, 6)
		ValueLabel.Size = UDim2.new(0, 69, 0, 15)
		ValueLabel.ZIndex = LayerIndex + 9
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 12.000
		ValueLabel.TextTransparency = 0.500
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		BarBack.Name = NeverloseUI.RandomString();
		BarBack.Parent = ProgressFrame
		BarBack.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		BarBack.BorderSizePixel = 0
		BarBack.Position = UDim2.new(0, 11, 0, 27)
		BarBack.Size = UDim2.new(1, -22, 0, 8)
		BarBack.ZIndex = LayerIndex + 9
		BarBackCorner.CornerRadius = UDim.new(1, 0)
		BarBackCorner.Parent = BarBack
		BarFill.Name = NeverloseUI.RandomString();
		BarFill.Parent = BarBack
		BarFill.BackgroundColor3 = NeverloseUI.AccentColor
		BarFill.BorderSizePixel = 0
		BarFill.Size = UDim2.fromScale(0, 1)
		BarFill.ZIndex = LayerIndex + 10
		BarFillCorner.CornerRadius = UDim.new(1, 0)
		BarFillCorner.Parent = BarFill
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = ProgressFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		local function UpdateProgress()
			local MaxValue = math.max(tonumber(Config.Max) or 1, 0.0001);
			local Value = math.clamp(tonumber(Config.Value) or 0, 0, MaxValue);
			local Percent = Value / MaxValue;
			local DisplayValue = NeverloseUI.Rounding(Value, 2);
			local DisplayMax = NeverloseUI.Rounding(MaxValue, 2);
			if Config.Type == "%" then
				ValueLabel.Text = tostring(NeverloseUI.Rounding(Percent * 100, 0)).."%";
			else
				ValueLabel.Text = tostring(DisplayValue).."/"..tostring(DisplayMax)..tostring(Config.Type or "");
			end;
			NeverloseUI.PlayAnimate(BarFill , SlowyTween , {
				Size = UDim2.fromScale(Percent, 1),
				BackgroundColor3 = NeverloseUI.AccentColor
			});
		end;
		function Progress:SetValue(value)
			Config.Value = tonumber(value) or Config.Value;
			UpdateProgress();
			return Progress;
		end;
		function Progress:GetValue()
			return Config.Value;
		end;
		function Progress:SetMax(max)
			Config.Max = tonumber(max) or Config.Max;
			UpdateProgress();
			return Progress;
		end;
		function Progress:SetText(text)
			Config.Name = tostring(text or "");
			Title.Text = Config.Name;
			return Progress;
		end;
		function Progress:SetType(text)
			Config.Type = tostring(text or "");
			UpdateProgress();
			return Progress;
		end;
		function Progress:SetVisible(value)
			ProgressFrame.Visible = value ~= false;
			return Progress;
		end;
		Progress.SetRender = LPH_NO_VIRTUALIZE(function(value)
			NeverloseUI.PlayAnimate(Title , SlowyTween , { TextTransparency = value and 0.250 or 1 });
			NeverloseUI.PlayAnimate(ValueLabel , SlowyTween , { TextTransparency = value and 0.500 or 1 });
			NeverloseUI.PlayAnimate(BarBack , SlowyTween , { BackgroundTransparency = value and 0 or 1 });
			NeverloseUI.PlayAnimate(BarFill , SlowyTween , { BackgroundTransparency = value and 0 or 1 });
			NeverloseUI.PlayAnimate(LineFrame , SlowyTween , { BackgroundTransparency = value and 0.650 or 1 });
		end);
		UpdateProgress();
		Progress.SetRender(Signel:GetValue());
		Signel:Connect(Progress.SetRender);
		return CaseInsensitive(Progress);
	end;
	function idx:AddCodeBlock(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Code = tostring(Config or ""),
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Code",
			Code = "",
			RichText = false,
			Copy = true,
			CopyText = "Copy",
			Locked = false,
			TextLocked = "Locked",
		});
		local CodeBlock = {};
		local CodeFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local CodeLabel = Instance.new("TextLabel")
		local CodeCorner = Instance.new("UICorner")
		local CodePadding = Instance.new("UIPadding")
		local CopyButton = Instance.new("Frame")
		local CopyCorner = Instance.new("UICorner")
		local CopyStroke = Instance.new("UIStroke")
		local CopyIcon = Instance.new("ImageLabel")
		local LineFrame = Instance.new("Frame")
		NeverloseUI:AddQuery(CodeFrame , Config.Name);
		CodeFrame.Name = NeverloseUI.RandomString();
		CodeFrame.Parent = Frame
		CodeFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		CodeFrame.BackgroundTransparency = 1.000
		CodeFrame.BorderSizePixel = 0
		CodeFrame.ClipsDescendants = true
		CodeFrame.Size = UDim2.new(1, 0, 0, 60)
		CodeFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(CodeBlock, CodeFrame, Config);
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = CodeFrame
		CodeLabel.Name = NeverloseUI.RandomString();
		CodeLabel.Parent = CodeFrame
		CodeLabel.BackgroundColor3 = Color3.fromRGB(18, 19, 25)
		CodeLabel.BackgroundTransparency = 0.150
		CodeLabel.BorderSizePixel = 0
		CodeLabel.Position = UDim2.new(0, 10, 0, 7)
		CodeLabel.Size = UDim2.new(1, -20, 0, 40)
		CodeLabel.ZIndex = LayerIndex + 9
		CodeLabel.Font = Enum.Font.Code
		CodeLabel.RichText = Config.RichText == true
		CodeLabel.Text = tostring(Config.Code)
		CodeLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
		CodeLabel.TextSize = 12.000
		CodeLabel.TextTransparency = 0.200
		CodeLabel.TextWrapped = true
		CodeLabel.TextXAlignment = Enum.TextXAlignment.Left
		CodeLabel.TextYAlignment = Enum.TextYAlignment.Top
		CodeCorner.CornerRadius = UDim.new(0, 5)
		CodeCorner.Parent = CodeLabel
		CodePadding.PaddingTop = UDim.new(0, 7)
		CodePadding.PaddingBottom = UDim.new(0, 7)
		CodePadding.PaddingLeft = UDim.new(0, 7)
		CodePadding.PaddingRight = UDim.new(0, Config.Copy ~= false and 35 or 7)
		CodePadding.Parent = CodeLabel
		CopyButton.Name = NeverloseUI.RandomString();
		CopyButton.Parent = CodeFrame
		CopyButton.AnchorPoint = Vector2.new(1, 0)
		CopyButton.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		CopyButton.BackgroundTransparency = Config.Copy ~= false and 0.100 or 1
		CopyButton.BorderSizePixel = 0
		CopyButton.ClipsDescendants = true
		CopyButton.Position = UDim2.new(1, -16, 0, 13)
		CopyButton.Size = UDim2.new(0, 24, 0, 24)
		CopyButton.Visible = Config.Copy ~= false
		CopyButton.ZIndex = LayerIndex + 12
		CopyCorner.CornerRadius = UDim.new(0, 5)
		CopyCorner.Parent = CopyButton
		CopyStroke.Transparency = 0.650
		CopyStroke.Color = Color3.fromRGB(45, 48, 58)
		CopyStroke.Parent = CopyButton
		CopyIcon.Name = NeverloseUI.RandomString();
		CopyIcon.Parent = CopyButton
		CopyIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		CopyIcon.BackgroundTransparency = 1
		CopyIcon.BorderSizePixel = 0
		CopyIcon.Position = UDim2.fromScale(0.5, 0.5)
		CopyIcon.Size = UDim2.new(0, 15, 0, 15)
		CopyIcon.ZIndex = LayerIndex + 13
		CopyIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		CopyIcon.ImageTransparency = 0.250
		CopyIcon.ScaleType = Enum.ScaleType.Fit
		NeverloseUI:SetIconMode(CopyIcon, "lucide:copy")
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = CodeFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		local function UpdateCodeSize()
			local Width = math.max(120, CodeFrame.AbsoluteSize.X - 32);
			local Size = TextService:GetTextSize(CodeLabel.Text,CodeLabel.TextSize,CodeLabel.Font,Vector2.new(Width,math.huge));
			local Height = math.max(40, Size.Y + 14);
			CodeLabel.Size = UDim2.new(1, -20, 0, Height);
			CodeFrame.Size = UDim2.new(1, 0, 0, Height + 15);
		end;
		local function GetClipboardWriter()
			return setclipboard or toclipboard or set_clipboard or (syn and syn.write_clipboard) or nil;
		end;
		function CodeBlock:Copy()
			local Writer = GetClipboardWriter();
			if not Writer then
				NeverloseUI:SetIconMode(CopyIcon, "lucide:x")
				task.delay(0.85, function()
					if CopyIcon and CopyIcon.Parent then
						NeverloseUI:SetIconMode(CopyIcon, "lucide:copy")
					end;
				end)
				return false;
			end;
			local Success = pcall(function()
				Writer(Config.Code);
			end);
			NeverloseUI:SetIconMode(CopyIcon, Success and "lucide:check" or "lucide:x")
			task.delay(0.85, function()
				if CopyIcon and CopyIcon.Parent then
					NeverloseUI:SetIconMode(CopyIcon, "lucide:copy")
				end;
			end)
			return Success;
		end;
		function CodeBlock:SetCode(code)
			Config.Code = tostring(code or "");
			CodeLabel.Text = Config.Code;
			UpdateCodeSize();
			return CodeBlock;
		end;
		function CodeBlock:GetCode()
			return Config.Code;
		end;
		function CodeBlock:SetRichText(value)
			Config.RichText = value == true;
			CodeLabel.RichText = Config.RichText;
			return CodeBlock;
		end;
		function CodeBlock:SetVisible(value)
			CodeFrame.Visible = value ~= false;
			return CodeBlock;
		end;
		function CodeBlock:SetCopyEnabled(value)
			Config.Copy = value == true;
			CopyButton.Visible = Config.Copy;
			CodePadding.PaddingRight = UDim.new(0, Config.Copy and 35 or 7);
			return CodeBlock;
		end;
		local CopyInput = NeverloseUI:CreateInput(CopyButton, function()
			CodeBlock:Copy();
		end);
		NeverloseUI:AddSignal(CopyInput.MouseEnter:Connect(function()
			NeverloseUI.PlayAnimate(CopyButton, SlowyTween, {
				BackgroundTransparency = 0
			});
			NeverloseUI.PlayAnimate(CopyIcon, SlowyTween, {
				TextTransparency = 0
			});
		end));
		NeverloseUI:AddSignal(CopyInput.MouseLeave:Connect(function()
			NeverloseUI.PlayAnimate(CopyButton, SlowyTween, {
				BackgroundTransparency = 0.100
			});
			NeverloseUI.PlayAnimate(CopyIcon, SlowyTween, {
				TextTransparency = 0.250
			});
		end));
		CodeBlock.SetRender = LPH_NO_VIRTUALIZE(function(value)
			NeverloseUI.PlayAnimate(CodeLabel , SlowyTween , {
				BackgroundTransparency = value and 0.150 or 1,
				TextTransparency = value and 0.200 or 1
			});
			NeverloseUI.PlayAnimate(CopyButton , SlowyTween , {
				BackgroundTransparency = (value and Config.Copy) and 0.100 or 1
			});
			NeverloseUI.PlayAnimate(CopyStroke , SlowyTween , {
				Transparency = (value and Config.Copy) and 0.650 or 1
			});
			NeverloseUI.PlayAnimate(CopyIcon , SlowyTween , {
				TextTransparency = (value and Config.Copy) and 0.250 or 1
			});
			NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = value and 0.650 or 1
			});
		end);
		task.defer(UpdateCodeSize);
		NeverloseUI:AddSignal(CodeFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateCodeSize));
		CodeBlock.SetRender(Signel:GetValue());
		Signel:Connect(CodeBlock.SetRender);
		return CaseInsensitive(CodeBlock);
	end;
	function idx:AddDependencyBox(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Dependencies = Config and { Config } or {},
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "DependencyBox",
			Dependencies = {},
			Mode = "Visible",
			Locked = false,
			TextLocked = "Dependency required",
		});
		local DependencyBox = {};
		local DependencyFrame = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local DependencyHandler = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local DependencySignal = NeverloseUI:CreateSignal(false);
		local IsRendered = Signel:GetValue() == true;
		local LastMatched;
		local CheckAccumulator = 0;
		local Mode = string.lower(tostring(Config.Mode or "Visible"));
		local LockMode = Mode == "locked" or Mode == "lock";
		local function ResolveDependencyObject(value)
			if typeof(value) == "string" then
				return NeverloseUI.Flags[value] or value;
			end;
			return value;
		end;
		local function GetDependencyValue(object)
			object = ResolveDependencyObject(object);
			if typeof(object) == "table" and object.GetValue then
				local success, result = pcall(function()
					return object:GetValue();
				end);
				if success then
					return result;
				end;
			end;
			return object;
		end;
		local function CompareDependency(actual, expected)
			if typeof(expected) == "function" then
				local success, result = pcall(expected, actual);
				return success and result == true;
			end;
			if expected == nil then
				return actual == true;
			end;
			if typeof(actual) == "table" then
				if typeof(expected) == "table" then
					for key,value in next, expected do
						if actual[key] ~= value and actual[value] ~= true then
							return false;
						end;
					end;
					return true;
				end;
				return actual[expected] == true or table.find(actual, expected) ~= nil;
			end;
			return actual == expected;
		end;
		local function DependencyMatches(dependency)
			if typeof(dependency) ~= "table" then
				return GetDependencyValue(dependency) == true;
			end;
			local Object = dependency.Object or dependency.Element or dependency[1] or dependency.Flag;
			local Expected = dependency.Value;
			if Expected == nil then
				Expected = dependency.Expected or dependency.Equals or dependency[2];
			end;
			return CompareDependency(GetDependencyValue(Object), Expected);
		end;
		local function DependenciesMatch()
			local Dependencies = Config.Dependencies or {};
			if #Dependencies <= 0 then
				return true;
			end;
			for _,Dependency in ipairs(Dependencies) do
				if not DependencyMatches(Dependency) then
					return false;
				end;
			end;
			return true;
		end;
		DependencyFrame.Name = NeverloseUI.RandomString();
		DependencyFrame.Parent = Frame
		DependencyFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		DependencyFrame.BackgroundTransparency = 0.500
		DependencyFrame.BorderSizePixel = 0
		DependencyFrame.ClipsDescendants = true
		DependencyFrame.Size = UDim2.new(1, 0, 0, 0)
		DependencyFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(DependencyBox, DependencyFrame, {
			Locked = LockMode and not DependenciesMatch() or Config.Locked,
			TextLocked = Config.TextLocked,
		});
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = DependencyFrame
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = DependencyFrame
		DependencyHandler.Name = NeverloseUI.RandomString();
		DependencyHandler.Parent = DependencyFrame
		DependencyHandler.AnchorPoint = Vector2.new(0.5, 0)
		DependencyHandler.BackgroundTransparency = 1.000
		DependencyHandler.BorderSizePixel = 0
		DependencyHandler.ClipsDescendants = true
		DependencyHandler.Position = UDim2.new(0.5, 0, 0, 5)
		DependencyHandler.Size = UDim2.new(1, -10, 1, -10)
		DependencyHandler.ZIndex = LayerIndex + 9
		UIListLayout.Parent = DependencyHandler
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		local Inner = NeverloseUI:RegisiterItem(DependencyHandler, DependencySignal);
		local function UpdateSize()
			local Matched = DependenciesMatch();
			local ShouldShow = IsRendered and (LockMode or Matched);
			local ContentHeight = UIListLayout.AbsoluteContentSize.Y;
			local TargetHeight = (ShouldShow and ContentHeight > 0) and (ContentHeight + 10) or 0;
			DependencyFrame.Visible = ShouldShow;
			DependencySignal:SetValue(IsRendered and (LockMode or Matched));
			DependencyBox:SetLocked(Config.Locked == true or (LockMode and not Matched));
			NeverloseUI.PlayAnimate(DependencyFrame, VSlowTween, {
				Size = UDim2.new(1, 0, 0, TargetHeight),
				BackgroundTransparency = ShouldShow and 0.500 or 1,
			});
			NeverloseUI.PlayAnimate(UIStroke, SlowyTween, {
				Transparency = ShouldShow and 0.650 or 1,
			});
			LastMatched = Matched;
		end;
		function DependencyBox:SetDependencies(dependencies)
			Config.Dependencies = dependencies or {};
			UpdateSize();
			return DependencyBox;
		end;
		function DependencyBox:GetDependencies()
			return Config.Dependencies;
		end;
		function DependencyBox:SetMode(mode)
			Config.Mode = tostring(mode or Config.Mode);
			Mode = string.lower(Config.Mode);
			LockMode = Mode == "locked" or Mode == "lock";
			UpdateSize();
			return DependencyBox;
		end;
		function DependencyBox:GetValue()
			return DependenciesMatch();
		end;
		function DependencyBox:SetVisible(value)
			IsRendered = value ~= false and Signel:GetValue() == true;
			UpdateSize();
			return DependencyBox;
		end;
		for key,value in next, Inner do
			if DependencyBox[key] == nil then
				DependencyBox[key] = value;
			end;
		end;
		NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSize));
		Signel:Connect(function(value)
			IsRendered = value == true;
			UpdateSize();
		end);
		NeverloseUI:AddSignal(RunService.RenderStepped:Connect(function(dt)
			CheckAccumulator = CheckAccumulator + (dt or 0);
			if CheckAccumulator < 0.1 then
				return;
			end;
			CheckAccumulator = 0;
			local Matched = DependenciesMatch();
			if Matched ~= LastMatched then
				UpdateSize();
			end;
		end));
		UpdateSize();
		return CaseInsensitive(DependencyBox);
	end;
	function idx:AddDependencyGroupbox(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Name = tostring(Config or "Dependency Groupbox"),
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Dependency Groupbox",
			Dependencies = {},
			Mode = "Visible",
			Collapsible = false,
			Collapsed = false,
			Locked = false,
			TextLocked = "Dependency required",
		});
		local Groupbox = {};
		local GroupFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Title = Instance.new("TextLabel")
		local CollapseIcon = Instance.new("ImageLabel")
		local GroupHandler = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local GroupSignal = NeverloseUI:CreateSignal(false);
		local IsRendered = Signel:GetValue() == true;
		local LastMatched;
		local CheckAccumulator = 0;
		local HeaderHeight = 28;
		local Mode = string.lower(tostring(Config.Mode or "Visible"));
		local LockMode = Mode == "locked" or Mode == "lock";
		local Collapsible = Config.Collapsible == true;
		local Collapsed = Config.Collapsed == true;
		local function ResolveDependencyObject(value)
			if typeof(value) == "string" then
				return NeverloseUI.Flags[value] or value;
			end;
			return value;
		end;
		local function GetDependencyValue(object)
			object = ResolveDependencyObject(object);
			if typeof(object) == "table" and object.GetValue then
				local success, result = pcall(function()
					return object:GetValue();
				end);
				if success then
					return result;
				end;
			end;
			return object;
		end;
		local function CompareDependency(actual, expected)
			if typeof(expected) == "function" then
				local success, result = pcall(expected, actual);
				return success and result == true;
			end;
			if expected == nil then
				return actual == true;
			end;
			if typeof(actual) == "table" then
				if typeof(expected) == "table" then
					for key,value in next, expected do
						if actual[key] ~= value and actual[value] ~= true then
							return false;
						end;
					end;
					return true;
				end;
				return actual[expected] == true or table.find(actual, expected) ~= nil;
			end;
			return actual == expected;
		end;
		local function DependencyMatches(dependency)
			if typeof(dependency) ~= "table" then
				return GetDependencyValue(dependency) == true;
			end;
			local Object = dependency.Object or dependency.Element or dependency[1] or dependency.Flag;
			local Expected = dependency.Value;
			if Expected == nil then
				Expected = dependency.Expected or dependency.Equals or dependency[2];
			end;
			return CompareDependency(GetDependencyValue(Object), Expected);
		end;
		local function DependenciesMatch()
			local Dependencies = Config.Dependencies or {};
			if #Dependencies <= 0 then
				return true;
			end;
			for _,Dependency in ipairs(Dependencies) do
				if not DependencyMatches(Dependency) then
					return false;
				end;
			end;
			return true;
		end;
		GroupFrame.Name = NeverloseUI.RandomString();
		GroupFrame.Parent = Frame
		GroupFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		GroupFrame.BackgroundTransparency = 0.500
		GroupFrame.BorderSizePixel = 0
		GroupFrame.ClipsDescendants = true
		GroupFrame.Size = UDim2.new(1, 0, 0, 0)
		GroupFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(Groupbox, GroupFrame, {
			Locked = Config.Locked == true or (LockMode and not DependenciesMatch()),
			TextLocked = Config.TextLocked,
		});
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = GroupFrame
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = GroupFrame
		Title.Name = NeverloseUI.RandomString();
		Title.Parent = GroupFrame
		Title.BackgroundTransparency = 1.000
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 11, 0, 7)
		Title.Size = UDim2.new(1, -45, 0, 16)
		Title.ZIndex = LayerIndex + 10
		Title.Font = Enum.Font.GothamMedium
		Title.Text = tostring(Config.Name)
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 13.000
		Title.TextTransparency = 0.200
		Title.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(Title);
		CollapseIcon.Name = NeverloseUI.RandomString();
		CollapseIcon.Parent = GroupFrame
		CollapseIcon.AnchorPoint = Vector2.new(1, 0)
		CollapseIcon.BackgroundTransparency = 1.000
		CollapseIcon.BorderSizePixel = 0
		CollapseIcon.Position = UDim2.new(1, -8, 0, 2)
		CollapseIcon.Size = UDim2.new(0, 22, 0, 22)
		CollapseIcon.Visible = Collapsible
		CollapseIcon.ZIndex = LayerIndex + 10
		NeverloseUI:SetIconMode(CollapseIcon, "chevron-small-down")
		CollapseIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		CollapseIcon.ImageTransparency = 0.500
		CollapseIcon.ScaleType = Enum.ScaleType.Fit
		GroupHandler.Name = NeverloseUI.RandomString();
		GroupHandler.Parent = GroupFrame
		GroupHandler.AnchorPoint = Vector2.new(0.5, 0)
		GroupHandler.BackgroundTransparency = 1.000
		GroupHandler.BorderSizePixel = 0
		GroupHandler.ClipsDescendants = true
		GroupHandler.Position = UDim2.new(0.5, 0, 0, HeaderHeight)
		GroupHandler.Size = UDim2.new(1, -10, 1, -HeaderHeight - 5)
		GroupHandler.ZIndex = LayerIndex + 9
		UIListLayout.Parent = GroupHandler
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		local Inner = NeverloseUI:RegisiterItem(GroupHandler, GroupSignal);
		local function UpdateSize()
			local Matched = DependenciesMatch();
			local ShouldShow = IsRendered and (LockMode or Matched);
			local ShowContent = ShouldShow and not Collapsed;
			local ContentHeight = UIListLayout.AbsoluteContentSize.Y;
			local TargetHeight = ShouldShow and HeaderHeight or 0;
			if ShowContent and ContentHeight > 0 then
				TargetHeight = ContentHeight + HeaderHeight + 5;
			end;
			GroupFrame.Visible = ShouldShow;
			GroupHandler.Visible = ShowContent;
			GroupSignal:SetValue(ShowContent);
			Groupbox:SetLocked(Config.Locked == true or (LockMode and not Matched));
			NeverloseUI.PlayAnimate(GroupFrame, VSlowTween, {
				Size = UDim2.new(1, 0, 0, TargetHeight),
				BackgroundTransparency = ShouldShow and 0.500 or 1,
			});
			NeverloseUI.PlayAnimate(UIStroke, SlowyTween, {
				Transparency = ShouldShow and 0.650 or 1,
			});
			NeverloseUI.PlayAnimate(Title, SlowyTween, {
				TextTransparency = ShouldShow and 0.200 or 1,
			});
			NeverloseUI.PlayAnimate(CollapseIcon, SlowyTween, {
				ImageTransparency = (ShouldShow and Collapsible) and 0.500 or 1,
				Rotation = Collapsed and -90 or 0,
			});
			LastMatched = Matched;
		end;
		function Groupbox:SetText(text)
			Config.Name = tostring(text or "");
			Title.Text = Config.Name;
			return Groupbox;
		end;
		function Groupbox:GetText()
			return Title.Text;
		end;
		function Groupbox:SetDependencies(dependencies)
			Config.Dependencies = dependencies or {};
			UpdateSize();
			return Groupbox;
		end;
		function Groupbox:GetDependencies()
			return Config.Dependencies;
		end;
		function Groupbox:SetMode(mode)
			Config.Mode = tostring(mode or Config.Mode);
			Mode = string.lower(Config.Mode);
			LockMode = Mode == "locked" or Mode == "lock";
			UpdateSize();
			return Groupbox;
		end;
		function Groupbox:GetValue()
			return DependenciesMatch();
		end;
		function Groupbox:SetCollapsed(value)
			Collapsed = value == true;
			Config.Collapsed = Collapsed;
			UpdateSize();
			return Groupbox;
		end;
		function Groupbox:ToggleCollapsed()
			return Groupbox:SetCollapsed(not Collapsed);
		end;
		function Groupbox:GetCollapsed()
			return Collapsed;
		end;
		function Groupbox:SetCollapsible(value)
			Collapsible = value == true;
			Config.Collapsible = Collapsible;
			CollapseIcon.Visible = Collapsible;
			if not Collapsible then
				Collapsed = false;
				Config.Collapsed = false;
			end;
			UpdateSize();
			return Groupbox;
		end;
		function Groupbox:SetVisible(value)
			IsRendered = value ~= false and Signel:GetValue() == true;
			UpdateSize();
			return Groupbox;
		end;
		for key,value in next, Inner do
			if Groupbox[key] == nil then
				Groupbox[key] = value;
			end;
		end;
		if Collapsible then
			local CollapseInput = NeverloseUI:CreateInput(GroupFrame, LPH_NO_VIRTUALIZE(function()
				Groupbox:ToggleCollapsed();
			end));
			CollapseInput.ZIndex = LayerIndex + 20;
			CollapseInput.Size = UDim2.new(1, 0, 0, HeaderHeight);
		end;
		NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSize));
		Signel:Connect(function(value)
			IsRendered = value == true;
			UpdateSize();
		end);
		NeverloseUI:AddSignal(RunService.RenderStepped:Connect(function(dt)
			CheckAccumulator = CheckAccumulator + (dt or 0);
			if CheckAccumulator < 0.1 then
				return;
			end;
			CheckAccumulator = 0;
			local Matched = DependenciesMatch();
			if Matched ~= LastMatched then
				UpdateSize();
			end;
		end));
		UpdateSize();
		return CaseInsensitive(Groupbox);
	end;
	function idx:AddUserFrame(Name  , Profile , Expires )
		local UserFrame = Instance.new("Frame")
		local UserLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local LogoImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local UserStatusLabel = Instance.new("TextLabel")
		UserFrame.Name = NeverloseUI.RandomString();
		UserFrame.Parent = Frame
		UserFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		UserFrame.BackgroundTransparency = 1.000
		UserFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserFrame.BorderSizePixel = 0
		UserFrame.Size = UDim2.new(1, 0, 0, 60)
		UserFrame.ZIndex = LayerIndex + 8
		UserLabel.Name = NeverloseUI.RandomString();
		UserLabel.Parent = UserFrame
		UserLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.BackgroundTransparency = 1.000
		UserLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserLabel.BorderSizePixel = 0
		UserLabel.Position = UDim2.new(0, 65, 0, 10)
		UserLabel.Size = UDim2.new(1, -35, 0, 15)
		UserLabel.ZIndex = LayerIndex + 9
		UserLabel.Font = Enum.Font.GothamMedium
		UserLabel.Text = Name or 'User'
		UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.TextSize = 13.000
		UserLabel.TextTransparency = 0.200
		UserLabel.TextXAlignment = Enum.TextXAlignment.Left
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = UserFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = UserFrame
		LogoImage.Name = NeverloseUI.RandomString();
		LogoImage.Parent = UserFrame
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0, 5)
		LogoImage.Size = UDim2.new(0, 45, 0, 45)
		LogoImage.ZIndex = LayerIndex + 9
		LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";
		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = LogoImage
		UserStatusLabel.Name = NeverloseUI.RandomString();
		UserStatusLabel.Parent = UserFrame
		UserStatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.BackgroundTransparency = 1.000
		UserStatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserStatusLabel.BorderSizePixel = 0
		UserStatusLabel.Position = UDim2.new(0, 65, 0, 25)
		UserStatusLabel.Size = UDim2.new(1, -35, 0, 15)
		UserStatusLabel.ZIndex = LayerIndex + 9
		UserStatusLabel.Font = Enum.Font.GothamMedium
		UserStatusLabel.Text = Expires or 'Never'
		UserStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.TextSize = 13.000
		UserStatusLabel.TextTransparency = 0.200
		UserStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
		local UserFrameItem = {};
		UserFrameItem.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverloseUI.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 0.200
				})
				NeverloseUI.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 0.650
				})
				NeverloseUI.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 0
				})
				NeverloseUI.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 0.200
				})
			else
				NeverloseUI.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 1
				})
				NeverloseUI.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 1
				})
				NeverloseUI.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 1
				})
			end;
		end);
		UserFrameItem.SetRender(Signel:GetValue())
		Signel:Connect(UserFrameItem.SetRender);
		function UserFrameItem:SetUsername(name)
			UserLabel.Text = name or 'User'
		end;
		function UserFrameItem:SetProfile(Profile)
			LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";
		end;
		function UserFrameItem:SetExpires(Exp)
			UserStatusLabel.Text = Exp or 'Never';
		end;
		return CaseInsensitive(UserFrameItem);
	end;
	function idx:AddCustom(Config)
		if typeof(Config) == "function" then
			Config = {
				Build = Config,
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Custom",
			Height = 120,
			Build = nil,
			Background = true,
			Locked = false,
			TextLocked = "Locked",
		});
		local Custom = {};
		local CustomFrame = Instance.new("Frame")
		local CustomCorner = Instance.new("UICorner")
		local Container = Instance.new("Frame")
		local ContainerCorner = Instance.new("UICorner")
		local ContainerStroke = Instance.new("UIStroke")
		local LineFrame = Instance.new("Frame")
		local BaseZ = LayerIndex + 10;
		NeverloseUI:AddQuery(CustomFrame , tostring(Config.Name));
		CustomFrame.Name = NeverloseUI.RandomString();
		CustomFrame.Parent = Frame
		CustomFrame.BackgroundTransparency = 1.000
		CustomFrame.BorderSizePixel = 0
		CustomFrame.ClipsDescendants = true
		CustomFrame.Size = UDim2.new(1, 0, 0, (tonumber(Config.Height) or 120) + 15)
		CustomFrame.ZIndex = LayerIndex + 8
		NeverloseUI:AttachLockMethods(Custom, CustomFrame, Config);
		CustomCorner.CornerRadius = UDim.new(0, 10)
		CustomCorner.Parent = CustomFrame
		Container.Name = NeverloseUI.RandomString();
		Container.Parent = CustomFrame
		Container.AnchorPoint = Vector2.new(0.5, 0)
		Container.BackgroundColor3 = Color3.fromRGB(13, 17, 22)
		Container.BackgroundTransparency = Config.Background and 0.200 or 1
		Container.BorderSizePixel = 0
		Container.ClipsDescendants = true
		Container.Position = UDim2.new(0.5, 0, 0, 7)
		Container.Size = UDim2.new(1, -20, 0, tonumber(Config.Height) or 120)
		Container.ZIndex = LayerIndex + 9
		ContainerCorner.CornerRadius = UDim.new(0, 6)
		ContainerCorner.Parent = Container
		ContainerStroke.Color = Color3.fromRGB(45, 48, 58)
		ContainerStroke.Transparency = Config.Background and 0.650 or 1
		ContainerStroke.Parent = Container
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = CustomFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11
		Custom.Root = CustomFrame;
		Custom.Container = Container;
		Custom.ZIndex = BaseZ;
		local ZTrack = setmetatable({}, { __mode = "k" });
		local MaxRaw = math.max(1, tonumber(Config.MaxZIndex) or 20);
		local function TrackZ(Descendant)
			if not Descendant:IsA("GuiObject") or ZTrack[Descendant] then
				return;
			end;
			local Raw = Descendant.ZIndex;
			local Applying = false;
			local function Apply()
				Applying = true;
				Descendant.ZIndex = math.min(Raw, MaxRaw) + BaseZ - 1;
				Applying = false;
			end;
			local Conn = Descendant:GetPropertyChangedSignal("ZIndex"):Connect(function()
				if Applying then
					return;
				end;
				Raw = Descendant.ZIndex;
				Apply();
			end);
			ZTrack[Descendant] = { Conn = Conn, Raw = function() return Raw; end, Apply = Apply };
			Apply();
		end;
		NeverloseUI:AddSignal(Container.DescendantAdded:Connect(TrackZ));
		NeverloseUI:AddSignal(Container.DescendantRemoving:Connect(function(Descendant)
			local Info = ZTrack[Descendant];
			if Info then
				ZTrack[Descendant] = nil;
				Info.Conn:Disconnect();
				pcall(function()
					Descendant.ZIndex = Info.Raw();
				end);
			end;
		end));
		for _, Existing in next, Container:GetDescendants() do
			TrackZ(Existing);
		end;
		function Custom:Create(ClassName, Properties, Parent)
			local Object = Instance.new(ClassName);
			for Key,Value in next, Properties or {} do
				Object[Key] = Value;
			end;
			Object.Parent = Parent or Container;
			return Object;
		end;
		function Custom:GetTheme()
			return NeverloseUI:GetTheme();
		end;
		function Custom:BindTheme(Object, Map)
			return NeverloseUI:BindTheme(Object, Map);
		end;
		function Custom:SetMaxZIndex(Value)
			MaxRaw = math.max(1, tonumber(Value) or 20);
			for _, Info in next, ZTrack do
				pcall(Info.Apply);
			end;
			return Custom;
		end;
		function Custom:SetHeight(height)
			height = tonumber(height) or Config.Height;
			Config.Height = height;
			Container.Size = UDim2.new(1, -20, 0, height);
			CustomFrame.Size = UDim2.new(1, 0, 0, height + 15);
			return Custom;
		end;
		function Custom:GetHeight()
			return Config.Height;
		end;
		function Custom:Clear()
			for _,Child in next, Container:GetChildren() do
				if not Child:IsA("UICorner") and not Child:IsA("UIStroke") then
					Child:Destroy();
				end;
			end;
			return Custom;
		end;
		function Custom:SetVisible(value)
			CustomFrame.Visible = value ~= false;
			return Custom;
		end;
		function Custom:ShowError(Message)
			local Old = Container:FindFirstChild("NeverloseCustomError");
			if Old then
				Old:Destroy();
			end;
			local ErrorLabel = Instance.new("TextLabel");
			ErrorLabel.Name = "NeverloseCustomError";
			ErrorLabel.BackgroundTransparency = 1;
			ErrorLabel.Position = UDim2.new(0, 6, 0, 6);
			ErrorLabel.Size = UDim2.new(1, -12, 1, -12);
			ErrorLabel.Font = Enum.Font.Code;
			ErrorLabel.TextSize = 11;
			ErrorLabel.TextColor3 = Color3.fromRGB(255, 90, 90);
			ErrorLabel.TextWrapped = true;
			ErrorLabel.TextXAlignment = Enum.TextXAlignment.Left;
			ErrorLabel.TextYAlignment = Enum.TextYAlignment.Top;
			ErrorLabel.Text = "Custom build error:\n" .. string.sub(tostring(Message), 1, 400);
			ErrorLabel.Parent = Container;
			return Custom;
		end;
		Custom.IsReady = false;
		local ReadyQueue = {};
		local function CheckReady()
			if Custom.IsReady then
				return;
			end;
			local Size = Container.AbsoluteSize;
			if Size.X > 0 and Size.Y > 0 then
				Custom.IsReady = true;
				local Queue = ReadyQueue;
				ReadyQueue = {};
				for _, Fn in ipairs(Queue) do
					task.spawn(Fn);
				end;
			end;
		end;
		NeverloseUI:AddSignal(Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(CheckReady));
		function Custom:OnReady(Fn)
			if Custom.IsReady then
				task.spawn(Fn, Container, Custom);
			else
				table.insert(ReadyQueue, function()
					Fn(Container, Custom);
				end);
			end;
			return Custom;
		end;
		CheckReady();
		local function RunBuild(Callback)
			local Ok, Result = NeverloseUI:FireCallback(Callback, Config.Name, Container, Custom);
			if Ok == false then
				Custom:ShowError(Result);
			end;
			return Ok;
		end;
		function Custom:Rebuild(Callback)
			Custom:Clear();
			RunBuild(Callback or Config.Build);
			return Custom;
		end;
		Custom.SetRender = LPH_NO_VIRTUALIZE(function(value)
			NeverloseUI.PlayAnimate(Container , SlowyTween , {
				BackgroundTransparency = (value and Config.Background) and 0.200 or 1
			});
			NeverloseUI.PlayAnimate(ContainerStroke , SlowyTween , {
				Transparency = (value and Config.Background) and 0.650 or 1
			});
			NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = value and 0.650 or 1
			});
		end);
		Custom.SetRender(Signel:GetValue());
		Signel:Connect(Custom.SetRender);
		if type(Config.Build) == "function" then
			if Config.Deferred == true and not Custom.IsReady then
				Custom:OnReady(function()
					RunBuild(Config.Build);
				end);
			else
				local Ok = RunBuild(Config.Build);
				if Ok == false and not Custom.IsReady then
					Custom:OnReady(function()
						Custom:Clear();
						RunBuild(Config.Build);
					end);
				end;
			end;
		end;
		return CaseInsensitive(Custom);
	end;
	function idx:AddToggle(Config)
		if Config.Name then
			return self:AddLabel(Config.Name):AddToggle(Config)
		else
			error("Name is required for AddToggle in sections")
		end
	end
	function idx:AddSlider(Config)
		if Config.Name then
			return self:AddLabel(Config.Name):AddSlider(Config)
		else
			error("Name is required for AddSlider in sections")
		end
	end
	function idx:AddDropdown(Config)
		if Config.Name then
			return self:AddLabel(Config.Name):AddDropdown(Config)
		else
			error("Name is required for AddDropdown in sections")
		end
	end
	function idx:AddKeybind(Config)
		if Config.Name then
			return self:AddLabel(Config.Name):AddKeybind(Config)
		else
			error("Name is required for AddKeybind in sections")
		end
	end
	function idx:AddColorPicker(Config)
		if Config.Name then
			return self:AddLabel(Config.Name):AddColorPicker(Config)
		else
			error("Name is required for AddColorPicker in sections")
		end
	end
	function idx:AddTextInput(Config)
		if Config.Name then
			local IsTextarea = string.lower(tostring(Config.Type or "TextInput")) == "textarea";
			if IsTextarea then
				Config.FullWidth = Config.FullWidth ~= false;
				return self:AddLabel(Config.Name):SetStacked(true):AddTextInput(Config)
			end;
			return self:AddLabel(Config.Name):AddTextInput(Config)
		else
			error("Name is required for AddTextInput in sections")
		end
	end
	return CaseInsensitive(idx);
end;
function NeverloseUI:CreateWindow(Config)
	Config = Config or {};
	local ConfigSettings = (typeof(Config.Config) == "table" and Config.Config) or {};
	if Config.Title ~= nil and Config.Name == nil then
		Config.Name = Config.Title;
	end;
	if Config.Image ~= nil and Config.Logo == nil then
		local image = tostring(Config.Image);
		Config.Logo = (image:find("rbxassetid://",1,true) and image) or ("rbxassetid://"..image);
	end;
	if typeof(Config.Color) == "Color3" then
		NeverloseUI.AccentColor = Config.Color;
	end;
	if ConfigSettings.ConfigFolder ~= nil and Config.ConfigFolder == nil then
		Config.ConfigFolder = ConfigSettings.ConfigFolder;
	end;
	if ConfigSettings.TextGradient ~= nil and Config.TextGradient == nil then
		Config.TextGradient = ConfigSettings.TextGradient;
	end;
	if Config.Size == nil then
		Config.Size = NeverloseUI.Scales.Mobile;
	end;
	Config = NeverloseUI:ProcessParams(Config , {
		Logo = NeverloseUI.GlobalLogo,
		Name = "NeverloseUI",
		Content = "Neverlose-UI | Premium",
		Size = NeverloseUI.Scales.Mobile,
		Font = nil,
		ConfigFolder = "NeverloseConfigs",
		Uitransparent = nil,
		ShowUser = true,
		Search = true,
		ConfigEnabled = true,
		TextGradient = true,
		RunningText = false,
		NotifyOnCallbackError = false,
		Loadingscreen = false,
		Enable3DRenderer = false,
		Keybind = "RightControl"
	});
	NeverloseUI:SetTextGradientEnabled(Config.TextGradient);
	if Config.Font ~= nil then
		NeverloseUI:SetFont(Config.Font);
	end;
	Config.ConfigFolder = tostring(Config.ConfigFolder):gsub("[/\\]+$","");
	local KeyGateConfig = Config.KeySystem;
	if type(KeyGateConfig) == "function" then
		KeyGateConfig = { Validate = KeyGateConfig };
	elseif type(KeyGateConfig) == "table" and type(KeyGateConfig[1]) == "string" and KeyGateConfig.Keys == nil then
		KeyGateConfig = { Keys = KeyGateConfig };
	elseif type(KeyGateConfig) ~= "table" then
		KeyGateConfig = nil;
	end;
	if KeyGateConfig then
		NeverloseUI:SetKeySystem(KeyGateConfig);
		if KeyGateConfig.Keyless == true then
			NeverloseUI:_SetKeyVerified(true, "keyless");
		end;
	end;
	local GateOn = KeyGateConfig ~= nil and KeyGateConfig.Enabled ~= false and KeyGateConfig.Gate ~= false and not NeverloseUI.KeyVerified;
	local Window = {
		KeyGateActive = GateOn,
		Logo = Config.Logo,
		Name = Config.Name,
		Content = Config.Content,
		Size = Config.Size,
		ConfigFolder = Config.ConfigFolder,
		Font = Config.Font,
		Uitransparent = Config.Uitransparent,
		ShowUser = Config.ShowUser,
		SearchEnabled = Config.Search,
		ConfigEnabled = Config.ConfigEnabled and Config.Config ~= false,
		RunningText = Config.RunningText == true,
		ConfigAutoSaveFile = ConfigSettings.AutoSaveFile or (function()
			local Clean = tostring(Config.Name or ""):gsub('[/\\:%*%?"<>|]', ""):gsub("^%s+", ""):gsub("%s+$", "");
			Clean = string.sub(Clean, 1, 24):gsub("%s+$", "");
			if Clean == "" then
				return "Default";
			end;
			return Clean;
		end)(),
		ConfigAutoSave = ConfigSettings.AutoSave ~= false,
		ConfigAutoLoad = ConfigSettings.AutoLoad ~= false,
		ConfigOverwrite = ConfigSettings.Overwrite ~= false,
		ConfigEncrypted = ConfigSettings.Encrypted == true or string.lower(tostring(ConfigSettings.Format or "")) == "encoded",
		ConfigShowAutoSaveToggle = ConfigSettings.ShowAutoSaveToggle == true,
		ConfigSaveWindowState = ConfigSettings.SaveWindowState == true,
		Signal = NeverloseUI:CreateSignal(true),
		Tabs = {},
		CurrentTab = 1,
		NotifyOnCallbackError = Config.NotifyOnCallbackError == true,
		Loadingscreen = Config.Loadingscreen == true or Config.LoadingScreen == true or Config.Loading == true,
		OnDestroyCallbacks = {},
		Keybind = Config.Keybind,
		Enable3DRenderer = Config.Enable3DRenderer
	};
	do
		local Key = tostring(ConfigSettings.AutoSaveKey or ConfigSettings.AutoSaveFile or Config.Name or "Default");
		Key = Key:gsub("[%c]", ""):gsub("^%s+", ""):gsub("%s+$", "");
		Key = string.sub(Key, 1, 64);
		if Key == "" then
			Key = "Default";
		end;
		Window.AutoSaveKey = Key;
	end;
	if type(Config.OnDestroy) == "function" then
		table.insert(Window.OnDestroyCallbacks, Config.OnDestroy);
	end;
	NeverloseUI.GlobalLogo = Window.Logo;
	local Logging = NeverloseUI:CreateLogger();
	if not isfolder(Window.ConfigFolder) then
		makefolder(Window.ConfigFolder);
	end;
	local WindowFrame = Instance.new("CanvasGroup")
	local UICorner = Instance.new("UICorner")
	local LeftMenuFrame = Instance.new("Frame")
	local HeadFrame = Instance.new("Frame")
	local LogoImage = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local WindowName = Instance.new("TextLabel")
	local WindowContent = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local LeftScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local BottomFrame = Instance.new("Frame")
	local AccountProfile = Instance.new("ImageLabel")
	local UICorner_3 = Instance.new("UICorner")
	local AccountName = Instance.new("TextLabel")
	local ExpireLabel = Instance.new("TextLabel")
	local LineFrame_2 = Instance.new("Frame")
	local UserSettingButton = Instance.new("ImageLabel")
	local RightMenuFrame = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner_4 = Instance.new("UICorner")
	local RightHeader = Instance.new("Frame")
	local LineFrame_3 = Instance.new("Frame")
	local ConfigFrame = Instance.new("Frame")
	local UIStroke_2 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local ConfigIcon = Instance.new("ImageLabel")
	local LineFrame_4 = Instance.new("Frame")
	local ConfigName = Instance.new("TextLabel")
	local ConfigBthIcon = Instance.new("ImageLabel")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")
	local CloseButton = Instance.new("ImageLabel")
	local MinimizeButton = Instance.new("ImageLabel")
	local TabContainer = Instance.new("Frame")
	WindowFrame.Name = NeverloseUI.RandomString();
	WindowFrame.Parent = NeverloseUI.ScreenGui;
	WindowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	WindowFrame.BackgroundColor3 = Color3.fromRGB(7, 10, 16)
	WindowFrame.BackgroundTransparency = Window.Uitransparent or 0.055
	WindowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowFrame.BorderSizePixel = 0
	WindowFrame.ClipsDescendants = true
	WindowFrame.Position = UDim2.new(255, 0, 255, 0)
	WindowFrame.Size = Window.Size
	WindowFrame.Active = true;
	Window.Root = WindowFrame;
	Window._CreatedAt = os.clock();
	local WindowScale = Instance.new("NumberValue");
	WindowScale.Name = "MinimizeMultiplier";
	WindowScale.Value = 1;
	Window._FitValue = Instance.new("NumberValue");
	Window._FitValue.Name = "FitMultiplier";
	Window._FitValue.Value = 1;
	local FitScale = Instance.new("UIScale");
	FitScale.Name = "FitScale";
	FitScale.Scale = 1;
	FitScale.Parent = WindowFrame;
	Window._ApplyWindowScale = function()
		FitScale.Scale = math.max(Window._FitValue.Value * WindowScale.Value, 0.001);
	end;
	WindowScale.Changed:Connect(Window._ApplyWindowScale);
	Window._FitValue.Changed:Connect(Window._ApplyWindowScale);
	function Window:GetFitScale()
		local Screen = NeverloseUI.ScreenGui.AbsoluteSize;
		local Size = Window.Size;
		local W = Size.X.Offset + Size.X.Scale * Screen.X;
		local H = Size.Y.Offset + Size.Y.Scale * Screen.Y;
		if W <= 0 or H <= 0 or Screen.X <= 0 or Screen.Y <= 0 then
			return 1;
		end;
		local Scale;
		if NeverloseUI:IsSmallScreen() then
			Scale = math.clamp(tonumber(NeverloseUI.MobileScale) or 0.72, 0.4, 1);
			Scale = math.min(Scale, (Screen.X * 0.88) / W, (Screen.Y * 0.82) / H);
		else
			Scale = math.min(1, (Screen.X * 0.96) / W, (Screen.Y * 0.96) / H);
		end;
		return math.clamp(Scale, 0.35, 1);
	end;
	function Window:UpdateFitScale(Animated)
		local Target = Window:GetFitScale();
		if Animated then
			NeverloseUI.PlayAnimate(Window._FitValue, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Value = Target,
			});
		else
			Window._FitValue.Value = Target;
		end;
		return Window;
	end;
	Window:UpdateFitScale(false);
	NeverloseUI:AddSignal(NeverloseUI.ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if not Window.Destroyed then
			Window:UpdateFitScale(true);
		end;
	end));
	if type(Config) == "table" and type(Config.Border) == "table" then
		NeverloseUI:SetBorder(Config.Border);
	end;
	local WindowBorder = NeverloseUI:CreateSpinBorder(WindowFrame, {
		Transparency = 1,
	});
	local BorderStroke = WindowBorder.Stroke;
	Window.Border = WindowBorder;
	function Window:SetBorder(Settings)
		NeverloseUI:SetBorder(Settings);
		return Window;
	end;
	if Window.Loadingscreen then
		local LoadingOverlay = Instance.new("Frame")
		local LoadingPanel = Instance.new("Frame")
		local LoadingCorner = Instance.new("UICorner")
		local LoadingStroke = Instance.new("UIStroke")
		local LoadingIcon = Instance.new("ImageLabel")
		local LoadingTitle = Instance.new("TextLabel")
		local LoadingContent = Instance.new("TextLabel")
		LoadingOverlay.Name = NeverloseUI.RandomString();
		LoadingOverlay.Parent = NeverloseUI.ScreenGui
		LoadingOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		LoadingOverlay.BackgroundTransparency = 1
		LoadingOverlay.BorderSizePixel = 0
		LoadingOverlay.Size = UDim2.fromScale(1, 1)
		LoadingOverlay.ZIndex = 250
		LoadingPanel.Name = NeverloseUI.RandomString();
		LoadingPanel.Parent = LoadingOverlay
		LoadingPanel.AnchorPoint = Vector2.new(0.5, 0.5)
		LoadingPanel.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		LoadingPanel.BackgroundTransparency = 1
		LoadingPanel.BorderSizePixel = 0
		LoadingPanel.Position = UDim2.fromScale(0.5, 0.5)
		LoadingPanel.Size = UDim2.fromOffset(260, 92)
		LoadingPanel.ZIndex = 251
		LoadingCorner.CornerRadius = UDim.new(0, 10)
		LoadingCorner.Parent = LoadingPanel
		LoadingStroke.Color = Color3.fromRGB(45, 48, 58)
		LoadingStroke.Transparency = 1
		LoadingStroke.Parent = LoadingPanel
		LoadingIcon.Name = NeverloseUI.RandomString();
		LoadingIcon.Parent = LoadingPanel
		LoadingIcon.BackgroundTransparency = 1
		LoadingIcon.BorderSizePixel = 0
		LoadingIcon.Position = UDim2.new(0, 18, 0.5, -17)
		LoadingIcon.Size = UDim2.fromOffset(34, 34)
		LoadingIcon.ZIndex = 252
		LoadingIcon.Image = Window.Logo
		LoadingIcon.ImageColor3 = NeverloseUI.IconColor
		LoadingIcon.ImageTransparency = 1
		LoadingTitle.Name = NeverloseUI.RandomString();
		LoadingTitle.Parent = LoadingPanel
		LoadingTitle.BackgroundTransparency = 1
		LoadingTitle.BorderSizePixel = 0
		LoadingTitle.Position = UDim2.new(0, 64, 0, 22)
		LoadingTitle.Size = UDim2.new(1, -82, 0, 20)
		LoadingTitle.ZIndex = 252
		LoadingTitle.Font = Enum.Font.GothamBold
		LoadingTitle.Text = tostring(Config.LoadingTitle or Window.Name)
		LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		LoadingTitle.TextSize = 15
		LoadingTitle.TextTransparency = 1
		LoadingTitle.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(LoadingTitle);
		LoadingContent.Name = NeverloseUI.RandomString();
		LoadingContent.Parent = LoadingPanel
		LoadingContent.BackgroundTransparency = 1
		LoadingContent.BorderSizePixel = 0
		LoadingContent.Position = UDim2.new(0, 64, 0, 45)
		LoadingContent.Size = UDim2.new(1, -82, 0, 18)
		LoadingContent.ZIndex = 252
		LoadingContent.Font = Enum.Font.GothamMedium
		LoadingContent.Text = tostring(Config.LoadingContent or "Loading...")
		LoadingContent.TextColor3 = Color3.fromRGB(255, 255, 255)
		LoadingContent.TextSize = 12
		LoadingContent.TextTransparency = 1
		LoadingContent.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI.PlayAnimate(LoadingOverlay, SlowyTween, { BackgroundTransparency = 0.250 })
		NeverloseUI.PlayAnimate(LoadingPanel, SlowyTween, { BackgroundTransparency = 0.035 })
		NeverloseUI.PlayAnimate(LoadingStroke, SlowyTween, { Transparency = 0.650 })
		NeverloseUI.PlayAnimate(LoadingIcon, SlowyTween, { ImageTransparency = 0 })
		NeverloseUI.PlayAnimate(LoadingTitle, SlowyTween, { TextTransparency = 0 })
		NeverloseUI.PlayAnimate(LoadingContent, SlowyTween, { TextTransparency = 0.350 })
		task.delay(tonumber(Config.LoadingDuration) or 1.15, function()
			if not LoadingOverlay.Parent then
				return;
			end;
			NeverloseUI.PlayAnimate(LoadingOverlay, SlowyTween, { BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(LoadingPanel, SlowyTween, { BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(LoadingStroke, SlowyTween, { Transparency = 1 })
			NeverloseUI.PlayAnimate(LoadingIcon, SlowyTween, { ImageTransparency = 1 })
			NeverloseUI.PlayAnimate(LoadingTitle, SlowyTween, { TextTransparency = 1 })
			NeverloseUI.PlayAnimate(LoadingContent, SlowyTween, { TextTransparency = 1 })
			task.delay(0.2, function()
				if LoadingOverlay.Parent then
					LoadingOverlay:Destroy();
				end;
			end);
		end);
	end;
	if not NeverloseUI.EnabledBlur then
		WindowFrame.BackgroundTransparency = Window.Uitransparent or 0.0255
	end;
	local renderParentWindow = LPH_NO_VIRTUALIZE(function()
		if Window.__3DRender then
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;
				NeverloseUI.PlayAnimate(WindowFrame,VSlowTween , {
					Position = UDim2.fromScale(0.5,0.5);
				});
				WindowFrame.Parent = Window.SurfaceGui;
			end;
		else
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;
				WindowFrame.Parent = NeverloseUI.ScreenGui
			end;
		end;
	end);
	NeverloseUI:AddSignal(WindowFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(renderParentWindow))
	Window.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
		if value and not Window.Destroyed then
			if Window.Minimizing then
				return;
			end;
			if Window.Minimized then
				if not Window.Signal:GetValue() then
					return;
				end;
				Window.Minimized = false;
			end;
			Window._RestoreStart = os.clock();
		end;
		if value then
			if not Window.__3DRender then
				WindowFrame.Visible = true;
				WindowFrame.Parent = NeverloseUI.ScreenGui;
			end;
			if Window.MinimizeRestore or WindowScale.Value < 0.999 then
				local SavedPosition = Window.MinimizeRestore or UDim2.new(0.5, 0, 0.5, 0);
				Window.MinimizeRestore = nil;
				NeverloseUI.PlayAnimate(WindowFrame , VSlowTween , {
					Position = SavedPosition,
				});
				NeverloseUI.PlayAnimate(WindowScale , VSlowTween , {
					Value = 1,
				});
			end;
			NeverloseUI.PlayAnimate(BorderStroke , SlowyTween , {
				Transparency = 0
			})
			NeverloseUI.PlayAnimate(WindowFrame , TweenInfo.new(0.2) , {
				GroupTransparency = 0
			})
			if Window.BackgroundLabel then
				NeverloseUI.PlayAnimate(Window.BackgroundLabel , SlowyTween , {
					ImageTransparency = 1 - (Window.BackgroundImageOpacity or 0.5)
				})
			end;
			NeverloseUI.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = Window.Uitransparent or ((NeverloseUI.EnabledBlur and 0.055) or 0.0255),
				Size = Window:GetCurrentSize()
			})
			NeverloseUI.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 0
			})
			NeverloseUI.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 0
			})
			NeverloseUI.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 0.650
			})
			NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 0.650
			})
			NeverloseUI.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 0
			})
			NeverloseUI.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 0
			})
			NeverloseUI.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 0.650
			})
			NeverloseUI.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 0.650
			})
			NeverloseUI.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 0.5
			})
			NeverloseUI.PlayAnimate(RightMenuFrame , SlowyTween , {
				BackgroundTransparency = 0.600
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})
			NeverloseUI.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 0.650
			})
			NeverloseUI.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 0.750
			})
			NeverloseUI.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 0.650
			})
			NeverloseUI.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 0.250
			})
			NeverloseUI.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 0.650
			})
			NeverloseUI.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 0.350
			})
			NeverloseUI.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 0.250
			})
			NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.250
			})
			NeverloseUI.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 0.350
			})
			NeverloseUI.PlayAnimate(CloseButton , SlowyTween , {
				TextTransparency = 0.450
			})
			NeverloseUI.PlayAnimate(MinimizeButton , SlowyTween , {
				TextTransparency = 0.450
			})
			Window.Shadow:Render(true);
		else
			if Window.BackgroundLabel then
				NeverloseUI.PlayAnimate(Window.BackgroundLabel , SlowyTween , {
					ImageTransparency = 1
				})
			end;
			NeverloseUI.PlayAnimate(BorderStroke , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = 1,
				Size = Window:GetCurrentSize() + UDim2.fromOffset(-15,-15)
			})
			NeverloseUI.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})
			NeverloseUI.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 1
			})
			NeverloseUI.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(RightMenuFrame , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(CloseButton , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(MinimizeButton , SlowyTween , {
				TextTransparency = 1
			})
			Window.Shadow:Render(false);
		end;
	end);
	if Config.WindowShadow == true then
		Window.Shadow = NeverloseUI:CreateShadow(WindowFrame);
	else
		Window.Shadow = { Render = function() end };
	end;
	Window.Shadow:Render(false);
	task.delay(0.25,function()
		WindowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Window:SetRender(true);
		NeverloseUI:AddSignal(Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(...)
			Window:SetRender(...);
		end)))
	end)
	if NeverloseUI.EnabledBlur then
		NeverloseUI:CreateBlurModule(WindowFrame,Window.Signal,function()
			return not Window.Destroyed and not Window.Minimizing and not Window.Minimized;
		end);
	end;
	do
		local Frame = Instance.new("Frame")
		Frame.Parent = WindowFrame
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, 0, 0, 50)
		Frame.ZIndex = 7
		Frame.BackgroundTransparency = 1;
		NeverloseUI.Drag(Frame , WindowFrame , 0.15 , function(hidden)
			TabContainer.Visible = not hidden;
			LeftScrollingFrame.Visible = not hidden;
		end)
	end
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = WindowFrame
	do
		local BackgroundLabel = Instance.new("ImageLabel");
		BackgroundLabel.Name = NeverloseUI.RandomString();
		BackgroundLabel.Parent = WindowFrame;
		BackgroundLabel.BackgroundTransparency = 1;
		BackgroundLabel.BorderSizePixel = 0;
		BackgroundLabel.Position = UDim2.fromScale(0, 0);
		BackgroundLabel.Size = UDim2.fromScale(1, 1);
		BackgroundLabel.ZIndex = 1;
		BackgroundLabel.ScaleType = Enum.ScaleType.Crop;
		BackgroundLabel.Image = "";
		BackgroundLabel.ImageTransparency = 1;
		BackgroundLabel.Visible = false;
		local BackgroundCorner = Instance.new("UICorner");
		BackgroundCorner.CornerRadius = UDim.new(0, 6);
		BackgroundCorner.Parent = BackgroundLabel;
		Window.BackgroundLabel = BackgroundLabel;
		Window.BackgroundImage = "";
		Window.BackgroundImageOpacity = math.clamp(tonumber(Config.BackgroundOpacity) or 0.5, 0, 1);
		function Window:SetBackgroundOpacity(Opacity)
			Window.BackgroundImageOpacity = math.clamp(tonumber(Opacity) or Window.BackgroundImageOpacity, 0, 1);
			if Window.Signal:GetValue() and BackgroundLabel.Visible then
				NeverloseUI.PlayAnimate(BackgroundLabel , SlowyTween , {
					ImageTransparency = 1 - Window.BackgroundImageOpacity
				});
			end;
			return Window;
		end;
		function Window:SetBackground(Id, Opacity)
			local Clean = (tostring(Id or ""):gsub("%s", ""));
			Window.BackgroundImage = Clean;
			if Opacity ~= nil then
				Window.BackgroundImageOpacity = math.clamp(tonumber(Opacity) or Window.BackgroundImageOpacity, 0, 1);
			end;
			if Clean == "" then
				BackgroundLabel.Image = "";
				BackgroundLabel.Visible = false;
				BackgroundLabel.ImageTransparency = 1;
				return Window;
			end;
			BackgroundLabel.Image = NeverloseUI:NormalizeIconId(Clean);
			BackgroundLabel.Visible = true;
			if Window.Signal:GetValue() then
				NeverloseUI.PlayAnimate(BackgroundLabel , SlowyTween , {
					ImageTransparency = 1 - Window.BackgroundImageOpacity
				});
			end;
			return Window;
		end;
		function Window:ClearBackground()
			return Window:SetBackground("");
		end;
		local InitialBackground = Config.BackgroundImage or Config.Background;
		if InitialBackground ~= nil and tostring(InitialBackground) ~= "" then
			Window:SetBackground(InitialBackground);
		end;
	end;
	LeftMenuFrame.Name = NeverloseUI.RandomString();
	LeftMenuFrame.Parent = WindowFrame
	LeftMenuFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftMenuFrame.BackgroundTransparency = 1.000
	LeftMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftMenuFrame.BorderSizePixel = 0
	LeftMenuFrame.Size = UDim2.new(0, 175, 1, 0)
	HeadFrame.Name = NeverloseUI.RandomString();
	HeadFrame.Parent = LeftMenuFrame
	HeadFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeadFrame.BackgroundTransparency = 1.000
	HeadFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeadFrame.BorderSizePixel = 0
	HeadFrame.ClipsDescendants = true
	HeadFrame.Size = UDim2.new(1, 0, 0, 50)
	HeadFrame.ZIndex = 7
	LogoImage.Name = NeverloseUI.RandomString();
	LogoImage.Parent = HeadFrame
	LogoImage.AnchorPoint = Vector2.new(0, 0.5)
	LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoImage.BackgroundTransparency = 1.000
	LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoImage.BorderSizePixel = 0
	LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
	LogoImage.Size = UDim2.new(0, 35, 0, 35)
	LogoImage.ZIndex = 7
	LogoImage.Image = Window.Logo
	LogoImage.ImageColor3 = NeverloseUI.IconColor
	if Config.IconsType ~= nil then
		NeverloseUI:SetIconsType(Config.IconsType);
	end;
	Window.Icon = Config.Icon or Config.TitleIcon or Config.LogoIcon;
	if Window.Icon ~= nil and tostring(Window.Icon) ~= "" then
		NeverloseUI:SetIconMode(LogoImage, Window.Icon);
	end;
	function Window:SetIcon(Icon)
		Window.Icon = Icon;
		if Icon == nil or tostring(Icon) == "" then
			LogoImage.Image = Window.Logo;
		else
			NeverloseUI:SetIconMode(LogoImage, Icon);
		end;
		return Window;
	end;
	UICorner_2.CornerRadius = UDim.new(0, 7)
	UICorner_2.Parent = LogoImage
	WindowName.Name = NeverloseUI.RandomString();
	WindowName.Parent = HeadFrame
	WindowName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.BackgroundTransparency = 1.000
	WindowName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowName.BorderSizePixel = 0
	WindowName.Position = UDim2.new(0, 55, 0, 4)
	WindowName.Size = UDim2.new(1, -65, 0, 25)
	WindowName.ZIndex = 7
	WindowName.Font = Enum.Font.GothamBold
	WindowName.Text = Window.Name
	WindowName.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.TextSize = 18.000
	WindowName.TextXAlignment = Enum.TextXAlignment.Left
	NeverloseUI:AddTextGradient(WindowName);
	WindowContent.Name = NeverloseUI.RandomString();
	WindowContent.Parent = HeadFrame
	WindowContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.BackgroundTransparency = 1.000
	WindowContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowContent.BorderSizePixel = 0
	WindowContent.Position = UDim2.new(0, 55, 0, 25)
	WindowContent.Size = UDim2.new(1, -65, 0, 15)
	WindowContent.ZIndex = 7
	WindowContent.Font = Enum.Font.GothamBold
	WindowContent.Text = Window.Content
	WindowContent.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.TextSize = 9.000
	WindowContent.TextTransparency = 0.650
	WindowContent.TextXAlignment = Enum.TextXAlignment.Left
	WindowContent.TextTruncate = Enum.TextTruncate.None
	local function EnableHeaderAutoFit(Label, MaxTextSize, MinTextSize)
		MaxTextSize = MaxTextSize or Label.TextSize;
		MinTextSize = MinTextSize or 6;
		local function Refresh()
			task.defer(function()
				if not Label or not Label.Parent then
					return;
				end;
				local Width = math.max(1, Label.AbsoluteSize.X);
				local TextSize = MaxTextSize;
				while TextSize > MinTextSize and TextService:GetTextSize(
					Label.Text,
					TextSize,
					Label.Font,
					Vector2.new(math.huge, Label.AbsoluteSize.Y)
				).X > Width do
					TextSize = TextSize - 1;
				end;
				Label.TextSize = TextSize;
			end);
		end;
		NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("Text"):Connect(Refresh));
		NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("AbsoluteSize"):Connect(Refresh));
		Refresh();
	end;
	local function EnableHeaderRunningText(Label, Speed, Gap)
		Speed = Speed or 22;
		Gap = Gap or 45;
		local Clip = Instance.new("Frame");
		Clip.Name = NeverloseUI.RandomString();
		Clip.Parent = Label.Parent;
		Clip.BackgroundTransparency = 1;
		Clip.BorderSizePixel = 0;
		Clip.ClipsDescendants = true;
		Clip.Position = Label.Position;
		Clip.Size = Label.Size;
		Clip.ZIndex = Label.ZIndex;
		Label.Parent = Clip;
		Label.Position = UDim2.fromOffset(0, 0);
		Label.Size = UDim2.fromScale(1, 1);
		Label.TextTruncate = Enum.TextTruncate.None;
		local Clone = Label:Clone();
		Clone.Name = NeverloseUI.RandomString();
		Clone.Parent = Clip;
		Clone.Position = UDim2.fromOffset(0, 0);
		Clone.TextTruncate = Enum.TextTruncate.None;
		Clone.Visible = false;
		local TextWidth = 0;
		local ClipWidth = 0;
		local Overflow = false;
		local StartTick = tick();
		local function SyncClone()
			Clone.Text = Label.Text;
			Clone.TextColor3 = Label.TextColor3;
			Clone.TextTransparency = Label.TextTransparency;
			Clone.Font = Label.Font;
			Clone.FontFace = Label.FontFace;
			Clone.TextSize = Label.TextSize;
		end;
		local function Refresh()
			task.defer(function()
				if not Label.Parent or not Clip.Parent then
					return;
				end;
				SyncClone();
				TextWidth = math.ceil(TextService:GetTextSize(Label.Text, Label.TextSize, Label.Font, Vector2.new(math.huge, Clip.AbsoluteSize.Y)).X);
				ClipWidth = math.max(1, Clip.AbsoluteSize.X);
				Overflow = TextWidth > ClipWidth;
				if Overflow then
					Label.Size = UDim2.new(0, TextWidth, 1, 0);
					Clone.Size = UDim2.new(0, TextWidth, 1, 0);
					Clone.Visible = true;
					StartTick = tick();
				else
					Label.Position = UDim2.fromOffset(0, 0);
					Label.Size = UDim2.fromScale(1, 1);
					Clone.Visible = false;
				end;
			end);
		end;
		NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("Text"):Connect(Refresh));
		NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("TextSize"):Connect(Refresh));
		NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("TextTransparency"):Connect(SyncClone));
		NeverloseUI:AddSignal(Label:GetPropertyChangedSignal("TextColor3"):Connect(SyncClone));
		NeverloseUI:AddSignal(Clip:GetPropertyChangedSignal("AbsoluteSize"):Connect(Refresh));
		NeverloseUI:AddSignal(RunService.RenderStepped:Connect(function()
			if not Label.Parent or not Clip.Parent then
				return;
			end;
			if not Overflow then
				return;
			end;
			local Cycle = TextWidth + Gap;
			local X = -(((tick() - StartTick) * Speed) % Cycle);
			Label.Position = UDim2.fromOffset(X, 0);
			Clone.Position = UDim2.fromOffset(X + Cycle, 0);
		end));
		Refresh();
		return Clip;
	end;
	EnableHeaderAutoFit(WindowContent, 9, 6);
	if Window.RunningText then
		EnableHeaderRunningText(WindowName, 24, 50);
	else
		WindowName.TextTruncate = Enum.TextTruncate.None;
	end;
	LineFrame.Name = NeverloseUI.RandomString();
	LineFrame.Parent = HeadFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -10, 0, 1)
	LineFrame.ZIndex = 5
	LeftScrollingFrame.Name = NeverloseUI.RandomString();
	LeftScrollingFrame.Parent = LeftMenuFrame
	LeftScrollingFrame.Active = true
	LeftScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
	LeftScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftScrollingFrame.BackgroundTransparency = 1.000
	LeftScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftScrollingFrame.BorderSizePixel = 0
	LeftScrollingFrame.Position = UDim2.new(0.5, 0, 0, 60)
	LeftScrollingFrame.Size = UDim2.new(1, -10, 1, -115)
	LeftScrollingFrame.ZIndex = 7
	LeftScrollingFrame.ScrollBarThickness = 0
	UIListLayout.Parent = LeftScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)
	NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		LeftScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 1)
	end)))
	BottomFrame.Name = NeverloseUI.RandomString();
	BottomFrame.Parent = LeftMenuFrame
	BottomFrame.AnchorPoint = Vector2.new(0, 1)
	BottomFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomFrame.BackgroundTransparency = 1.000
	BottomFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BottomFrame.BorderSizePixel = 0
	BottomFrame.Position = UDim2.new(0, 0, 1, 0)
	BottomFrame.Size = UDim2.new(1, 0, 0, 50)
	BottomFrame.ZIndex = 7
	AccountProfile.Name = NeverloseUI.RandomString();
	AccountProfile.Parent = BottomFrame
	AccountProfile.AnchorPoint = Vector2.new(0, 0.5)
	AccountProfile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountProfile.BackgroundTransparency = 1.000
	AccountProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountProfile.BorderSizePixel = 0
	AccountProfile.Position = UDim2.new(0, 10, 0.5, 0)
	AccountProfile.Size = UDim2.new(0, 35, 0, 35)
	AccountProfile.ZIndex = 7
	AccountProfile.Image = NeverloseUI.UserProfile or ""
	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = AccountProfile
	AccountName.Name = NeverloseUI.RandomString();
	AccountName.Parent = BottomFrame
	AccountName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.BackgroundTransparency = 1.000
	AccountName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountName.BorderSizePixel = 0
	AccountName.Position = UDim2.new(0, 55, 0, 5)
	AccountName.Size = UDim2.new(0, 115, 0, 25)
	AccountName.ZIndex = 7
	AccountName.Font = Enum.Font.GothamBold
	AccountName.Text = LocalPlayer.DisplayName
	AccountName.TextColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.TextSize = 14.000
	AccountName.TextXAlignment = Enum.TextXAlignment.Left
	AccountName.TextTruncate = Enum.TextTruncate.AtEnd;
	ExpireLabel.Name = NeverloseUI.RandomString();
	ExpireLabel.Parent = BottomFrame
	ExpireLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.BackgroundTransparency = 1.000
	ExpireLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireLabel.BorderSizePixel = 0
	ExpireLabel.Position = UDim2.new(0, 55, 0, 25)
	ExpireLabel.Size = UDim2.new(0, 115, 0, 15)
	ExpireLabel.ZIndex = 7
	ExpireLabel.Font = Enum.Font.GothamBold
	ExpireLabel.Text = "@"..LocalPlayer.Name
	ExpireLabel.TextTruncate = Enum.TextTruncate.AtEnd
	ExpireLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.TextSize = 10.000
	ExpireLabel.TextTransparency = 0.650
	ExpireLabel.TextXAlignment = Enum.TextXAlignment.Left
	LineFrame_2.Name = NeverloseUI.RandomString();
	LineFrame_2.Parent = BottomFrame
	LineFrame_2.AnchorPoint = Vector2.new(0.5, 0)
	LineFrame_2.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_2.BackgroundTransparency = 0.650
	LineFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_2.BorderSizePixel = 0
	LineFrame_2.Position = UDim2.new(0.5, 0, 0, 0)
	LineFrame_2.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_2.ZIndex = 5
	UserSettingButton.Name = NeverloseUI.RandomString();
	UserSettingButton.Parent = BottomFrame
	UserSettingButton.AnchorPoint = Vector2.new(1, 0.5)
	UserSettingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.BackgroundTransparency = 1.000
	UserSettingButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserSettingButton.BorderSizePixel = 0
	UserSettingButton.Position = UDim2.new(1, -7, 0.5, 0)
	UserSettingButton.Size = UDim2.new(0, 25, 0, 25)
	UserSettingButton.ZIndex = 7
	UserSettingButton.Visible = false
	NeverloseUI:SetIconMode(UserSettingButton, "chevron-large-right")
	UserSettingButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.ImageTransparency = 0.5
	UserSettingButton.ScaleType = Enum.ScaleType.Fit
	NeverloseUI.Drag(BottomFrame , WindowFrame , 0.15 , function(hidden)
		TabContainer.Visible = not hidden;
		LeftScrollingFrame.Visible = not hidden;
	end);
	NeverloseUI:AddSignal(BottomFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		NeverloseUI.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.25
		})
	end)))
	NeverloseUI:AddSignal(BottomFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		NeverloseUI.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.5
		})
	end)))
	RightMenuFrame.Name = NeverloseUI.RandomString();
	RightMenuFrame.Parent = WindowFrame
	RightMenuFrame.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
	RightMenuFrame.BackgroundTransparency = 0.600
	RightMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightMenuFrame.BorderSizePixel = 0
	RightMenuFrame.ClipsDescendants = true
	RightMenuFrame.Position = UDim2.new(0, 176, 0, 0)
	RightMenuFrame.Size = UDim2.new(1, -176, 1, 0)
	RightMenuFrame.ZIndex = 8
	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = RightMenuFrame
	UICorner_4.CornerRadius = UDim.new(0, 6)
	UICorner_4.Parent = RightMenuFrame
	RightHeader.Name = NeverloseUI.RandomString();
	RightHeader.Parent = RightMenuFrame
	RightHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightHeader.BackgroundTransparency = 1.000
	RightHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightHeader.BorderSizePixel = 0
	RightHeader.Size = UDim2.new(1, 0, 0, 50)
	RightHeader.ZIndex = 9
	LineFrame_3.Name = NeverloseUI.RandomString();
	LineFrame_3.Parent = RightHeader
	LineFrame_3.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame_3.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_3.BackgroundTransparency = 0.650
	LineFrame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_3.BorderSizePixel = 0
	LineFrame_3.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame_3.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_3.ZIndex = 9
	ConfigFrame.Name = NeverloseUI.RandomString();
	ConfigFrame.Parent = RightHeader
	ConfigFrame.AnchorPoint = Vector2.new(0, 0.5)
	ConfigFrame.BackgroundColor3 = Color3.fromRGB(13, 17, 22)
	ConfigFrame.BackgroundTransparency = 0.750
	ConfigFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigFrame.BorderSizePixel = 0
	ConfigFrame.Position = UDim2.new(0, 10, 0.5, 0)
	ConfigFrame.Size = UDim2.new(0, 115, 0, 30)
	ConfigFrame.ZIndex = 9
	UIStroke_2.Transparency = 0.650
	UIStroke_2.Color = Color3.fromRGB(45, 48, 58)
	UIStroke_2.Parent = ConfigFrame
	UICorner_5.CornerRadius = UDim.new(0, 4)
	UICorner_5.Parent = ConfigFrame
	ConfigIcon.Name = NeverloseUI.RandomString();
	ConfigIcon.Parent = ConfigFrame
	ConfigIcon.AnchorPoint = Vector2.new(0, 0.5)
	ConfigIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigIcon.BackgroundTransparency = 1.000
	ConfigIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigIcon.BorderSizePixel = 0
	ConfigIcon.Position = UDim2.new(0, 2, 0.5, 0)
	ConfigIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigIcon.ZIndex = 9
	NeverloseUI:SetIconMode(ConfigIcon, "pencil-square")
	ConfigIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
	ConfigIcon.ImageTransparency = 0.250
	ConfigIcon.ScaleType = Enum.ScaleType.Fit
	LineFrame_4.Name = NeverloseUI.RandomString();
	LineFrame_4.Parent = ConfigFrame
	LineFrame_4.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_4.BackgroundTransparency = 0.650
	LineFrame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_4.BorderSizePixel = 0
	LineFrame_4.Position = UDim2.new(0, 30, 0, 0)
	LineFrame_4.Size = UDim2.new(0, 1, 1, 0)
	ConfigName.Name = NeverloseUI.RandomString();
	ConfigName.Parent = ConfigFrame
	ConfigName.AnchorPoint = Vector2.new(0, 0.5)
	ConfigName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.BackgroundTransparency = 1.000
	ConfigName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigName.BorderSizePixel = 0
	ConfigName.Position = UDim2.new(0, 40, 0.5, 0)
	ConfigName.Size = UDim2.new(1, -7, 0, 15)
	ConfigName.ZIndex = 9
	ConfigName.Font = Enum.Font.GothamMedium
	ConfigName.Text = Window.ConfigAutoSaveFile or "Default"
	ConfigName.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.TextSize = 12.000
	ConfigName.TextTransparency = 0.350
	ConfigName.TextXAlignment = Enum.TextXAlignment.Left
	ConfigBthIcon.Name = NeverloseUI.RandomString();
	ConfigBthIcon.Parent = ConfigFrame
	ConfigBthIcon.AnchorPoint = Vector2.new(1, 0.5)
	ConfigBthIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigBthIcon.BackgroundTransparency = 1.000
	ConfigBthIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigBthIcon.BorderSizePixel = 0
	ConfigBthIcon.Position = UDim2.new(1, -2, 0.5, 0)
	ConfigBthIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigBthIcon.ZIndex = 9
	NeverloseUI:SetIconMode(ConfigBthIcon, "chevron-small-down")
	ConfigBthIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
	ConfigBthIcon.ImageTransparency = 0.250
	ConfigBthIcon.ScaleType = Enum.ScaleType.Fit
	SearchFrame.Name = NeverloseUI.RandomString();
	SearchFrame.Parent = RightHeader
	SearchFrame.AnchorPoint = Vector2.new(1, 0.5)
	SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchFrame.BackgroundTransparency = 1.000
	SearchFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchFrame.BorderSizePixel = 0
	SearchFrame.ClipsDescendants = true
	SearchFrame.Position = UDim2.new(1, -80, 0.5, 0)
	SearchFrame.Size = UDim2.new(0, 30, 0, 30)
	SearchFrame.ZIndex = 12
	SearchIcon.Name = NeverloseUI.RandomString();
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchIcon.BackgroundTransparency = 1.000
	SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchIcon.BorderSizePixel = 0
	SearchIcon.Position = UDim2.new(0, 2, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 25, 0, 25)
	SearchIcon.ZIndex = 12
	NeverloseUI:SetIconMode(SearchIcon, "magnifying-glass")
	SearchIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
	SearchIcon.ImageTransparency = 0.45
	SearchIcon.ScaleType = Enum.ScaleType.Fit
	SearchBox.Name = NeverloseUI.RandomString();
	SearchBox.Parent = SearchFrame
	SearchBox.AnchorPoint = Vector2.new(0, 0.5)
	SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.BackgroundTransparency = 1.000
	SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderSizePixel = 0
	SearchBox.Position = UDim2.new(0, 35, 0.5, 0)
	SearchBox.Size = UDim2.new(1, -35, 0, 25)
	SearchBox.ZIndex = 12
	SearchBox.ClearTextOnFocus = false
	SearchBox.Font = Enum.Font.GothamMedium
	SearchBox.PlaceholderText = "Search"
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.TextSize = 13.000
	SearchBox.TextTransparency = 1
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left
	CloseButton.Name = NeverloseUI.RandomString();
	CloseButton.Parent = RightHeader
	CloseButton.AnchorPoint = Vector2.new(1, 0.5)
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 1.000
	CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
	CloseButton.Size = UDim2.new(0, 30, 0, 30)
	CloseButton.ZIndex = 12
	NeverloseUI:SetIconMode(CloseButton, "x")
	CloseButton.ImageColor3 = Color3.fromRGB(223, 223, 223)
	CloseButton.ImageTransparency = 0.45
	CloseButton.ScaleType = Enum.ScaleType.Fit
	MinimizeButton.Name = NeverloseUI.RandomString();
	MinimizeButton.Parent = RightHeader
	MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeButton.BackgroundTransparency = 1.000
	MinimizeButton.BorderSizePixel = 0
	MinimizeButton.Position = UDim2.new(1, -45, 0.5, 0)
	MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
	MinimizeButton.ZIndex = 12
	NeverloseUI:SetIconMode(MinimizeButton, "minus")
	MinimizeButton.ImageColor3 = Color3.fromRGB(223, 223, 223)
	MinimizeButton.ImageTransparency = 0.45
	MinimizeButton.ScaleType = Enum.ScaleType.Fit
	TabContainer.Name = NeverloseUI.RandomString();
	TabContainer.Parent = RightMenuFrame
	TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabContainer.BorderSizePixel = 0
	TabContainer.ClipsDescendants = true
	TabContainer.Position = UDim2.new(0, 0, 0, 50)
	TabContainer.Size = UDim2.new(1, 0, 1, -50)
	TabContainer.ZIndex = 5
	if Window.SearchEnabled then
		Window.Searching = false;
		local Input = NeverloseUI:CreateInput(SearchIcon , LPH_NO_VIRTUALIZE(function()
			Window.Searching = not Window.Searching;
			if Window.Searching then
				NeverloseUI.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 220, 0, 30)
				})
				NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})
				NeverloseUI.PlayAnimate(SearchBox , VSlowTween , {
					TextTransparency = 0.350
				})
			else
				NeverloseUI.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 30, 0, 30)
				})
				NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})
				NeverloseUI.PlayAnimate(SearchBox , SlowyTween , {
					TextTransparency = 1
				})
				SearchBox.Text = "";
			end;
		end));
		local wati_for_finish = tick();
		local last_thread;
		local max_time = 0.2;
		NeverloseUI:AddSignal(SearchBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			if not SearchBox.Text:byte() then
				for i,v in next , NeverloseUI.NameRegisitry do
					v.Root.Visible = true;
				end;
				return;
			end;
			wati_for_finish = tick();
			if last_thread then
				task.cancel(last_thread);
				last_thread = nil;
			end;
			last_thread = task.delay(max_time,function()
				if SearchBox.Text:byte() and (tick() - wati_for_finish) > max_time then
					local RevealedMatch = false;
					for i,v in next , NeverloseUI.NameRegisitry do
						if string.find(string.lower(v.Idx) , string.lower(SearchBox.Text), 1, true) then
							v.Root.Visible = true;
							if not RevealedMatch then
								RevealedMatch = true;
								NeverloseUI:RevealQueryItem(v);
							end;
						else
							v.Root.Visible = false;
						end;
					end;
				end;
			end);
		end)));
		NeverloseUI:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)))
		NeverloseUI:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Searching then
				NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})
			else
				NeverloseUI.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})
			end;
		end)));
	else
		SearchFrame.Visible = false;
	end;
	Window.Minimized = false;
	Window.Minimizing = false;
	function Window:GetCurrentSize()
		return Window.Size;
	end;
	function Window:Minimize()
		if Window.Destroyed or Window.Minimizing or not Window.Signal:GetValue() then
			return Window;
		end;
		local Screen = NeverloseUI.ScreenGui;
		local Icon = Window._MenuIcon and Window._MenuIcon.Root;
		local Target = UDim2.new(0, 40, 0.5, 0);
		if Window._MenuIcon and Window._MenuIcon.GetCenter then
			local Center = Window._MenuIcon:GetCenter();
			Target = UDim2.fromOffset(math.max(Center.X, 0), Center.Y);
		elseif Icon and Icon.Parent then
			local Center = Icon.AbsolutePosition + (Icon.AbsoluteSize / 2) - Screen.AbsolutePosition;
			Target = UDim2.fromOffset(math.max(Center.X, 0), Center.Y);
		end;
		Window.Minimizing = true;
		Window._PendingToggle = false;
		local MinimizeStamp = os.clock();
		Window._MinimizeStart = MinimizeStamp;
		Window.MinimizeRestore = WindowFrame.Position;
		local MinimizeTween = TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut);
		NeverloseUI.PlayAnimate(WindowFrame , MinimizeTween , {
			Position = Target,
			Rotation = 0,
		});
		local ScaleTween = NeverloseUI.PlayAnimate(WindowScale , MinimizeTween , {
			Value = 0.04,
		});
		task.delay(0.18, function()
			if Window.Destroyed or Window._MinimizeStart ~= MinimizeStamp or not Window.Minimizing then
				return;
			end;
			Window.Shadow:Render(false);
			NeverloseUI.PlayAnimate(BorderStroke , SlowyTween , {
				Transparency = 1,
			});
			NeverloseUI.PlayAnimate(WindowFrame , TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) , {
				GroupTransparency = 1,
			});
		end);
		task.delay(0.36, function()
			if Window.Destroyed or Window._MinimizeStart ~= MinimizeStamp or not Window.Minimizing then
				return;
			end;
			if Window._MenuIcon then
				Window._MenuIcon:SetVisible(true);
			end;
		end);
		local MinimizeFinished = false;
		local function FinishMinimize()
			if MinimizeFinished or Window._MinimizeStart ~= MinimizeStamp then
				return;
			end;
			MinimizeFinished = true;
			Window.Minimizing = false;
			if Window.Destroyed then
				return;
			end;
			Window.Minimized = true;
			Window._MinimizeEnd = os.clock();
			WindowScale.Value = 0.04;
			WindowFrame.GroupTransparency = 1;
			BorderStroke.Transparency = 1;
			Window.Signal:SetValue(false);
			if Window._MenuIcon then
				Window._MenuIcon:SetVisible(true);
			end;
			task.delay(0.3, function()
				if Window.Destroyed or not Window.Minimized or Window.Signal:GetValue() then
					return;
				end;
				WindowFrame.GroupTransparency = 1;
				BorderStroke.Transparency = 1;
				if not Window.__3DRender then
					WindowFrame.Visible = false;
				end;
			end);
			if Window._PendingToggle then
				Window._PendingToggle = false;
				task.defer(function()
					if not Window.Destroyed and Window.Minimized and not Window.Signal:GetValue() then
						Window:Restore();
					end;
				end);
			end;
		end;
		ScaleTween.Completed:Once(function(PlaybackState)
			if PlaybackState == Enum.PlaybackState.Completed then
				FinishMinimize();
			end;
		end);
		task.delay(0.9, FinishMinimize);
		return Window;
	end;
	function Window:Restore()
		if Window.Destroyed or Window.Minimizing or Window.Signal:GetValue() then
			return Window;
		end;
		Window.Minimized = false;
		Window:ToggleInterface();
		return Window;
	end;
	function Window:_IsShrunk()
		return WindowScale.Value < 0.5;
	end;
	function Window:_ForceRestore()
		if Window.Destroyed then
			return Window;
		end;
		Window.Minimizing = false;
		Window.Minimized = false;
		Window._PendingToggle = false;
		if not Window.Signal:GetValue() then
			Window.Signal:SetValue(true);
		end;
		Window:SetRender(true);
		if Window._MenuIcon then
			pcall(function()
				Window._MenuIcon:OnWindowToggle(true);
			end);
		end;
		return Window;
	end;
	function Window:_SyncMinimizeState()
		if Window.Destroyed or Window.Minimizing or Window.__3DRender or Window.KeyGateActive then
			return;
		end;
		local Now = os.clock();
		local Visible = Window.Signal:GetValue();
		if not Visible then
			local Shrunk = WindowScale.Value < 0.999;
			if Window.Minimized or Shrunk then
				if Now - (Window._MinimizeEnd or 0) < 0.45 then
					return;
				end;
				Window.Minimized = true;
				if WindowFrame.GroupTransparency < 1 then
					WindowFrame.GroupTransparency = 1;
				end;
				if BorderStroke.Transparency < 1 then
					BorderStroke.Transparency = 1;
				end;
				if WindowFrame.Visible then
					WindowFrame.Visible = false;
				end;
				if Window._MenuIcon and Window._MenuIcon.Visible == false then
					Window._MenuIcon:SetVisible(true);
				end;
			end;
		else
			if Window.Minimized then
				Window:_ForceRestore();
				return;
			end;
			if Now - (Window._RestoreStart or 0) > 1.3 and Now - (Window._CreatedAt or 0) > 2 then
				if WindowScale.Value < 0.999 then
					Window:_ForceRestore();
				elseif WindowFrame.GroupTransparency > 0.01 and WindowFrame.BackgroundTransparency <= 0.9 then
					WindowFrame.GroupTransparency = 0;
				end;
			end;
		end;
	end;
	task.spawn(function()
		while not Window.Destroyed do
			task.wait(0.25);
			pcall(function()
				Window:_SyncMinimizeState();
			end);
		end;
	end);
	function Window:ToggleMinimize()
		if Window.Signal:GetValue() then
			return Window:Minimize();
		end;
		return Window:Restore();
	end;
	do
		local Input = NeverloseUI:CreateInput(MinimizeButton , LPH_NO_VIRTUALIZE(function()
			Window:Minimize();
		end));
		NeverloseUI:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(MinimizeButton , SlowyTween , {
				TextTransparency = 0.150
			})
		end)))
		NeverloseUI:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(MinimizeButton , SlowyTween , {
				TextTransparency = Window.Signal:GetValue() and 0.450 or 1
			})
		end)))
	end;
	do
		local Input = NeverloseUI:CreateInput(CloseButton , LPH_NO_VIRTUALIZE(function()
			Window:Dialog({
				Title = "Destroy Window?",
				Content = "Are you sure you want to destroy this window?",
				Buttons = {
					{
						Text = "Cancel",
						ReturnValue = false,
					},
					{
						Text = "Yes",
						Primary = true,
						ReturnValue = true,
					},
				},
				Callback = function(result)
					if result == true then
						Window:Destroy();
					end;
				end,
			});
		end));
		NeverloseUI:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(CloseButton , SlowyTween , {
				TextTransparency = 0.150
			})
		end)))
		NeverloseUI:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(CloseButton , SlowyTween , {
				TextTransparency = Window.Signal:GetValue() and 0.450 or 1
			})
		end)))
	end;
	if Window.Enable3DRenderer then
		local Part = Instance.new('Part');
		Part.Name = NeverloseUI.RandomString();
		Part.Anchored = true;
		Part.Transparency = 1;
		Part.CanCollide = false;
		Part.CanTouch = false;
		Part.AudioCanCollide = false;
		Part.CollisionGroup = NeverloseUI.RandomString();
		Part.CFrame = CFrame.new(0,0,0);
		Part.Size = Vector3.zero;
		local SurfaceGui = Instance.new("SurfaceGui")
		SurfaceGui.Parent = NeverloseUI.ScreenGui;
		SurfaceGui.Adornee = Part;
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		SurfaceGui.AlwaysOnTop = true
		SurfaceGui.LightInfluence = 1.000
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
		SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
		SurfaceGui.PixelsPerStud = 40;
		Window.SurfaceGui = SurfaceGui;
		NeverloseUI.GlobalSurfaceGui = SurfaceGui;
		local PerfectScale = Vector2.new(1920 , 1080 + 300)
		Window.Load3DBlock = LPH_NO_VIRTUALIZE(function()
			if not Window.Signal:GetValue() then
				local _,OnScreen = CurrentCamera:WorldToViewportPoint(Part.Position);
				if OnScreen then
					NeverloseUI.PlayAnimate(Part,VSlowTween , {
						CFrame = CurrentCamera.CFrame * CFrame.new(0,0,-15) * CFrame.Angles(0,math.rad(180),0);
					});
				end;
				return
			end;
			local Dimensions = 50;
			local XY_Incom = Vector2.new(PerfectScale.X + 5, PerfectScale.Y * 1.35) / (Dimensions / 2);
			local PerfectDistance = XY_Incom.Magnitude;
			local SizeIndicator = PerfectDistance / 1.35;
			Part.Parent = NeverloseUI.BlurModuleParent or workspace;
			NeverloseUI.PlayAnimate(Part,VSlowTween , {
				CFrame = (CurrentCamera.CFrame * CFrame.new(0,0,-25)) * CFrame.Angles(0,math.rad(180),0);
			});
			Part.Size = Vector3.new(PerfectScale.X / SizeIndicator,PerfectScale.Y / SizeIndicator,0);
		end);
		function Window:Set3DRender(val)
			Window.__3DRender = val;
			NeverloseUI.Global3DRenderMode = val;
			if val then
				Window.Load3DBlock();
			else
				Part.Parent = nil;
			end;
			renderParentWindow();
		end;
	end;
	function Window:AddTabLabel(Name)
		local TabLabel = Instance.new("TextLabel")
		TabLabel.Name = NeverloseUI.RandomString()
		TabLabel.Parent = LeftScrollingFrame
		TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.BackgroundTransparency = 1.000
		TabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabLabel.BorderSizePixel = 0
		TabLabel.Size = UDim2.new(1, -7, 0, 15)
		TabLabel.ZIndex = 8
		TabLabel.Font = Enum.Font.GothamMedium
		TabLabel.Text = Name
		TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.TextSize = 11.000
		TabLabel.TextTransparency = 0.500
		TabLabel.TextXAlignment = Enum.TextXAlignment.Left
		local SetRender = LPH_NO_VIRTUALIZE(function(val)
			if val then
				NeverloseUI.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 0.500
				})
			else
				NeverloseUI.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 1
				})
			end
		end)
		SetRender(Window.Signal:GetValue());
		return Window.Signal:Connect(SetRender);
	end;
	function Window:AddCategory(Config)
		if typeof(Config) ~= "table" then
			Config = {
				Name = tostring(Config or "Category"),
			};
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Category",
			Icon = "",
			Open = true,
		});
		local Category = {
			Tabs = {},
			Open = Config.Open ~= false,
		};
		local CategoryRoot = Instance.new("Frame")
		local CategoryLayout = Instance.new("UIListLayout")
		local Header = Instance.new("Frame")
		local HeaderCorner = Instance.new("UICorner")
		local HeaderStroke = Instance.new("UIStroke")
		local HeaderIcon = Instance.new("ImageLabel")
		local HeaderLabel = Instance.new("TextLabel")
		local ChevronIcon = Instance.new("ImageLabel")
		local TabsHolder = Instance.new("Frame")
		local TabsLayout = Instance.new("UIListLayout")
		CategoryRoot.Name = NeverloseUI.RandomString();
		CategoryRoot.Parent = LeftScrollingFrame
		CategoryRoot.BackgroundTransparency = 1
		CategoryRoot.BorderSizePixel = 0
		CategoryRoot.ClipsDescendants = true
		CategoryRoot.Size = UDim2.new(1, -1, 0, 30)
		CategoryRoot.ZIndex = 8
		CategoryLayout.Parent = CategoryRoot
		CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
		CategoryLayout.Padding = UDim.new(0, 5)
		Header.Name = NeverloseUI.RandomString();
		Header.Parent = CategoryRoot
		Header.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		Header.BackgroundTransparency = 0.250
		Header.BorderSizePixel = 0
		Header.ClipsDescendants = true
		Header.Size = UDim2.new(1, 0, 0, 30)
		Header.ZIndex = 8
		HeaderCorner.CornerRadius = UDim.new(0, 6)
		HeaderCorner.Parent = Header
		HeaderStroke.Color = Color3.fromRGB(45, 48, 58)
		HeaderStroke.Transparency = 0.700
		HeaderStroke.Parent = Header
		HeaderIcon.Name = NeverloseUI.RandomString();
		HeaderIcon.Parent = Header
		HeaderIcon.AnchorPoint = Vector2.new(0, 0.5)
		HeaderIcon.BackgroundTransparency = 1
		HeaderIcon.BorderSizePixel = 0
		HeaderIcon.Position = UDim2.new(0, 8, 0.5, 0)
		HeaderIcon.Size = UDim2.new(0, 16, 0, 16)
		HeaderIcon.ZIndex = 9
		HeaderIcon.ImageColor3 = NeverloseUI.IconColor
		HeaderIcon.ScaleType = Enum.ScaleType.Fit
		NeverloseUI:SetIconMode(HeaderIcon, Config.Icon)
		HeaderIcon.Visible = tostring(Config.Icon or "") ~= ""
		HeaderLabel.Name = NeverloseUI.RandomString();
		HeaderLabel.Parent = Header
		HeaderLabel.AnchorPoint = Vector2.new(0, 0.5)
		HeaderLabel.BackgroundTransparency = 1
		HeaderLabel.BorderSizePixel = 0
		HeaderLabel.Position = HeaderIcon.Visible and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 10, 0.5, 0)
		HeaderLabel.Size = HeaderIcon.Visible and UDim2.new(1, -58, 0, 16) or UDim2.new(1, -38, 0, 16)
		HeaderLabel.ZIndex = 9
		HeaderLabel.Font = Enum.Font.GothamMedium
		HeaderLabel.Text = Config.Name
		HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		HeaderLabel.TextSize = 12.000
		HeaderLabel.TextTransparency = 0.080
		HeaderLabel.TextTruncate = Enum.TextTruncate.AtEnd
		HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
		ChevronIcon.Name = NeverloseUI.RandomString();
		ChevronIcon.Parent = Header
		ChevronIcon.AnchorPoint = Vector2.new(1, 0.5)
		ChevronIcon.BackgroundTransparency = 1
		ChevronIcon.BorderSizePixel = 0
		ChevronIcon.Position = UDim2.new(1, -7, 0.5, 0)
		ChevronIcon.Size = UDim2.new(0, 16, 0, 16)
		ChevronIcon.ZIndex = 9
		ChevronIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		ChevronIcon.ImageTransparency = 0.350
		ChevronIcon.ScaleType = Enum.ScaleType.Fit
		NeverloseUI:SetIconMode(ChevronIcon, "chevron-small-down")
		TabsHolder.Name = NeverloseUI.RandomString();
		TabsHolder.Parent = CategoryRoot
		TabsHolder.BackgroundTransparency = 1
		TabsHolder.BorderSizePixel = 0
		TabsHolder.ClipsDescendants = true
		TabsHolder.Size = UDim2.new(1, 0, 0, 0)
		TabsHolder.ZIndex = 8
		TabsLayout.Parent = TabsHolder
		TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TabsLayout.Padding = UDim.new(0, 5)
		local function UpdateSize()
			local tabsHeight = Category.Open and (TabsLayout.AbsoluteContentSize.Y + (#Category.Tabs > 0 and 1 or 0)) or 0;
			local rootHeight = 30 + (Category.Open and 5 or 0) + tabsHeight;
			if Category.Open then
				TabsHolder.Visible = true;
			end;
			NeverloseUI.PlayAnimate(TabsHolder, VSlowTween, {
				Size = UDim2.new(1, 0, 0, tabsHeight)
			});
			NeverloseUI.PlayAnimate(CategoryRoot, VSlowTween, {
				Size = UDim2.new(1, -1, 0, rootHeight)
			});
			NeverloseUI.PlayAnimate(ChevronIcon, SlowyTween, {
				Rotation = Category.Open and 0 or -90
			});
			if not Category.Open then
				task.delay(0.2, function()
					if not Category.Open then
						TabsHolder.Visible = false;
					end;
				end);
			end;
		end;
		function Category:SetOpen(value)
			Category.Open = value == true;
			UpdateSize();
			return Category;
		end;
		function Category:Toggle()
			return Category:SetOpen(not Category.Open);
		end;
		function Category:GetOpen()
			return Category.Open;
		end;
		function Category:SetName(name)
			Config.Name = tostring(name or "");
			HeaderLabel.Text = Config.Name;
			return Category;
		end;
		function Category:SetIcon(icon)
			Config.Icon = icon or "";
			NeverloseUI:SetIconMode(HeaderIcon, Config.Icon);
			HeaderIcon.Visible = tostring(Config.Icon or "") ~= "";
			HeaderLabel.Position = HeaderIcon.Visible and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 10, 0.5, 0);
			HeaderLabel.Size = HeaderIcon.Visible and UDim2.new(1, -58, 0, 16) or UDim2.new(1, -38, 0, 16);
			return Category;
		end;
		function Category:AddTab(TabConfig)
			local PreviousParent = Window.__NextTabParent;
			Window.__NextTabParent = TabsHolder;
			local Tab = Window:AddTab(TabConfig);
			Window.__NextTabParent = PreviousParent;
			table.insert(Category.Tabs, Tab);
			UpdateSize();
			return Tab;
		end;
		NeverloseUI:AddSignal(TabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSize))
		local Input = NeverloseUI:CreateInput(Header, function()
			Category:Toggle();
		end);
		NeverloseUI:AddSignal(Input.MouseEnter:Connect(function()
			NeverloseUI.PlayAnimate(Header, SlowyTween, {
				BackgroundTransparency = 0.150
			})
		end))
		NeverloseUI:AddSignal(Input.MouseLeave:Connect(function()
			NeverloseUI.PlayAnimate(Header, SlowyTween, {
				BackgroundTransparency = 0.250
			})
		end))
		NeverloseUI:AddSignal(Window.Signal:Connect(function(value)
			if value then
				NeverloseUI.PlayAnimate(Header, SlowyTween, {
					BackgroundTransparency = 0.250
				})
				NeverloseUI.PlayAnimate(HeaderStroke, SlowyTween, {
					Transparency = 0.700
				})
				NeverloseUI.PlayAnimate(HeaderIcon, SlowyTween, {
					TextTransparency = 0.250
				})
				NeverloseUI.PlayAnimate(HeaderLabel, SlowyTween, {
					TextTransparency = 0.080
				})
				NeverloseUI.PlayAnimate(ChevronIcon, SlowyTween, {
					TextTransparency = 0.350
				})
			else
				NeverloseUI.PlayAnimate(Header, SlowyTween, {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(HeaderStroke, SlowyTween, {
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(HeaderIcon, SlowyTween, {
					TextTransparency = 1
				})
				NeverloseUI.PlayAnimate(HeaderLabel, SlowyTween, {
					TextTransparency = 1
				})
				NeverloseUI.PlayAnimate(ChevronIcon, SlowyTween, {
					TextTransparency = 1
				})
			end;
		end))
		UpdateSize();
		return CaseInsensitive(Category);
	end;
	function Window:CreateHomeTab(Config)
		Config = NeverloseUI:ProcessParams(Config or {}, {
			Name = "Dashboard",
			Title = nil,
			Icon = "lucide:layout-dashboard",
			Content = "",
			SectionName = nil,
			Type = "Double",
			AutoSetup = true,
			DiscordInvite = "",
			SupportedExecutors = {},
			UnsupportedExecutors = {},
			Changelog = {},
			Segments = nil,
			Locked = false,
			TextLocked = "Locked",
		});
		local Tab = Window:AddTab({
			Name = Config.Title or Config.Name,
			Icon = Config.Icon,
			Type = Config.Type,
			Locked = Config.Locked,
			TextLocked = Config.TextLocked,
		});
		if Config.AutoSetup ~= false then
			if not Tab.CustomRoot and Tab.Root then
				Tab.CustomRoot = Instance.new("Frame");
				Tab.CustomRoot.Name = NeverloseUI.RandomString();
				Tab.CustomRoot.Parent = Tab.Root;
				Tab.CustomRoot.BackgroundTransparency = 1;
				Tab.CustomRoot.BorderSizePixel = 0;
				Tab.CustomRoot.Position = UDim2.fromOffset(0, 0);
				Tab.CustomRoot.Size = UDim2.fromScale(1, 1);
				Tab.CustomRoot.ZIndex = 10;
			end;
			if not Tab.CustomRoot then
				return CaseInsensitive(Tab);
			end;
			local Player = LocalPlayer;
			local ExecutorName = "Roblox Studio";
			local PlaceName = "Unknown Place";
			local Region = "Unknown";
			local TimeFunction = RunService:IsRunning() and time or os.clock;
			local FrameTimes = {};
			local StartedAt = TimeFunction();
			local ActivePage = "Details";
			pcall(function()
				if identifyexecutor then
					ExecutorName = tostring(select(1, identifyexecutor()));
				end;
			end);
			pcall(function()
				PlaceName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name;
			end);
			pcall(function()
				Region = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(Player);
			end);
			local function SetText(Object, Text)
				if Object and Object.Parent then
					Object.Text = tostring(Text or "");
				end;
			end;
			local function AddCorner(Object, Radius)
				local Corner = Instance.new("UICorner");
				Corner.CornerRadius = UDim.new(0, Radius or 8);
				Corner.Parent = Object;
				return Corner;
			end;
			local function AddStroke(Object, Color, Transparency)
				local Stroke = Instance.new("UIStroke");
				Stroke.Color = Color or Color3.fromRGB(45, 48, 58);
				Stroke.Transparency = Transparency or 0.650;
				Stroke.Parent = Object;
				return Stroke;
			end;
			local function MakeText(Parent, Text, Size, Bold, Transparency)
				local Label = Instance.new("TextLabel");
				Label.Name = NeverloseUI.RandomString();
				Label.Parent = Parent;
				Label.BackgroundTransparency = 1;
				Label.BorderSizePixel = 0;
				Label.Font = Bold and Enum.Font.GothamBold or Enum.Font.GothamMedium;
				Label.Text = tostring(Text or "");
				Label.TextColor3 = Color3.fromRGB(255, 255, 255);
				Label.TextSize = Size or 12;
				Label.TextTransparency = Transparency or 0;
				Label.TextXAlignment = Enum.TextXAlignment.Left;
				Label.TextYAlignment = Enum.TextYAlignment.Center;
				Label.TextTruncate = Enum.TextTruncate.AtEnd;
				Label.ZIndex = 14;
				return Label;
			end;
			local function FitTextToWidth(Label, BaseSize, MinSize, Wrapped)
				BaseSize = BaseSize or Label.TextSize;
				MinSize = MinSize or 8;
				Label.TextSize = BaseSize;
				task.defer(function()
					if not Label or not Label.Parent then
						return;
					end;
					local Width = math.max(1, Label.AbsoluteSize.X);
					local Height = math.max(1, Label.AbsoluteSize.Y);
					local Size = BaseSize;
					while Size > MinSize do
						local Bounds = TextService:GetTextSize(Label.Text, Size, Label.Font, Wrapped and Vector2.new(Width, math.huge) or Vector2.new(math.huge, Height));
						if Bounds.X <= Width and (not Wrapped or Bounds.Y <= Height) then
							break;
						end;
						Size -= 1;
					end;
					Label.TextSize = Size;
				end);
			end;
			local function MakePanel(Parent, Size, Position)
				local Panel = Instance.new("Frame");
				Panel.Name = NeverloseUI.RandomString();
				Panel.Parent = Parent;
				Panel.BackgroundColor3 = Color3.fromRGB(13, 17, 22);
				Panel.BackgroundTransparency = 0.100;
				Panel.BorderSizePixel = 0;
				Panel.ClipsDescendants = true;
				Panel.Size = Size;
				Panel.Position = Position or UDim2.fromOffset(0, 0);
				Panel.ZIndex = 12;
				AddCorner(Panel, 8);
				AddStroke(Panel, Color3.fromRGB(45, 48, 58), 0.680);
				return Panel;
			end;
			local function MakeIcon(Parent, Icon, Size, Color)
				local Image = Instance.new("ImageLabel");
				Image.Name = NeverloseUI.RandomString();
				Image.Parent = Parent;
				Image.BackgroundTransparency = 1;
				Image.BorderSizePixel = 0;
				Image.Size = UDim2.fromOffset(Size or 18, Size or 18);
				Image.ScaleType = Enum.ScaleType.Fit;
				Image.ImageColor3 = Color or Color3.fromRGB(255, 255, 255);
				Image.ZIndex = 15;
				NeverloseUI:SetIconMode(Image, Icon or "");
				return Image;
			end;
			local function MakeButton(Parent, Text, Icon, Callback)
				local Button = MakePanel(Parent, UDim2.fromOffset(0, 34));
				Button.BackgroundTransparency = 0.250;
				Button.Size = UDim2.new(1, 0, 0, 34);
				local IconImage = MakeIcon(Button, Icon, 16, NeverloseUI.AccentColor);
				IconImage.Position = UDim2.new(0, 12, 0.5, -8);
				local Label = MakeText(Button, Text, 12, true, 0.050);
				Label.Position = UDim2.new(0, 36, 0, 0);
				Label.Size = UDim2.new(1, -44, 1, 0);
				local Input = NeverloseUI:CreateInput(Button, Callback or EmptyFunction);
				NeverloseUI:AddSignal(Input.MouseEnter:Connect(function()
					NeverloseUI.PlayAnimate(Button, SlowyTween, { BackgroundTransparency = 0.080 });
				end));
				NeverloseUI:AddSignal(Input.MouseLeave:Connect(function()
					NeverloseUI.PlayAnimate(Button, SlowyTween, { BackgroundTransparency = 0.250 });
				end));
				return Button;
			end;
			local function GetGreeting()
				local Hour = os.date("*t").hour;
				if Hour >= 4 and Hour < 12 then
					return "Good Morning";
				elseif Hour >= 12 and Hour < 19 then
					return "How's Your Day Going?";
				elseif Hour >= 19 and Hour <= 23 then
					return "Sweet Dreams";
				end;
				return "You should be asleep";
			end;
			local function GetElapsed()
				local Elapsed = math.max(0, TimeFunction() - StartedAt);
				if Elapsed < 60 then
					return tostring(math.floor(Elapsed)).."s";
				elseif Elapsed < 3600 then
					return tostring(math.floor(Elapsed / 60)).."m";
				end;
				return tostring(math.floor(Elapsed / 3600)).."h";
			end;
			local Root = Instance.new("Frame");
			Root.Name = NeverloseUI.RandomString();
			Root.Parent = Tab.CustomRoot;
			Root.BackgroundTransparency = 1;
			Root.BorderSizePixel = 0;
			Root.Size = UDim2.new(1, -12, 0, 450);
			Root.ZIndex = 11;
			Tab.HomeRoot = Root;
			local Profile = MakePanel(Root, UDim2.new(1, 0, 0, 74), UDim2.fromOffset(0, 4));
			local AvatarBox = MakePanel(Profile, UDim2.fromOffset(58, 58), UDim2.fromOffset(10, 8));
			AvatarBox.BackgroundTransparency = 0.200;
			local Avatar = Instance.new("ImageLabel");
			Avatar.Name = NeverloseUI.RandomString();
			Avatar.Parent = AvatarBox;
			Avatar.BackgroundTransparency = 1;
			Avatar.BorderSizePixel = 0;
			Avatar.Size = UDim2.fromScale(1, 1);
			Avatar.Image = NeverloseUI.UserProfile or "";
			Avatar.ZIndex = 15;
			AddCorner(Avatar, 8);
			local Welcome = MakeText(Profile, "Hello, "..tostring(Player.DisplayName), 18, true, 0);
			Welcome.Position = UDim2.new(0, 82, 0, 17);
			Welcome.Size = UDim2.new(1, -98, 0, 24);
			NeverloseUI:AddTextGradient(Welcome);
			local Username = MakeText(Profile, "@"..tostring(Player.Name), 12, false, 0.350);
			Username.Position = UDim2.new(0, 82, 0, 41);
			Username.Size = UDim2.new(1, -98, 0, 18);
			local Segments = MakePanel(Root, UDim2.new(1, 0, 0, 48), UDim2.fromOffset(0, 86));
			local SegmentLayout = Instance.new("UIListLayout");
			SegmentLayout.Parent = Segments;
			SegmentLayout.FillDirection = Enum.FillDirection.Horizontal;
			SegmentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
			SegmentLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
			SegmentLayout.SortOrder = Enum.SortOrder.LayoutOrder;
			SegmentLayout.Padding = UDim.new(0, 8);
			local ContentHolder = Instance.new("Frame");
			ContentHolder.Name = NeverloseUI.RandomString();
			ContentHolder.Parent = Root;
			ContentHolder.BackgroundTransparency = 1;
			ContentHolder.BorderSizePixel = 0;
			ContentHolder.Position = UDim2.fromOffset(0, 144);
			ContentHolder.Size = UDim2.new(1, 0, 1, -144);
			ContentHolder.ZIndex = 11;
			local DetailsPage = Instance.new("Frame");
			DetailsPage.Name = NeverloseUI.RandomString();
			DetailsPage.Parent = ContentHolder;
			DetailsPage.BackgroundTransparency = 1;
			DetailsPage.BorderSizePixel = 0;
			DetailsPage.Size = UDim2.fromScale(1, 1);
			DetailsPage.ZIndex = 11;
			local ScriptPage = Instance.new("Frame");
			ScriptPage.Name = NeverloseUI.RandomString();
			ScriptPage.Parent = ContentHolder;
			ScriptPage.BackgroundTransparency = 1;
			ScriptPage.BorderSizePixel = 0;
			ScriptPage.Size = UDim2.fromScale(1, 1);
			ScriptPage.Visible = false;
			ScriptPage.ZIndex = 11;
			local UiPage = Instance.new("Frame");
			UiPage.Name = NeverloseUI.RandomString();
			UiPage.Parent = ContentHolder;
			UiPage.BackgroundTransparency = 1;
			UiPage.BorderSizePixel = 0;
			UiPage.Size = UDim2.fromScale(1, 1);
			UiPage.Visible = false;
			UiPage.ZIndex = 11;
			local SegmentButtons = {};
			local SegmentCount = 0;
			local Pages = {
				Details = DetailsPage,
				Script = ScriptPage,
				UI = UiPage,
			};
			local function SelectPage(PageName)
				ActivePage = PageName;
				for Name,Page in next, Pages do
					Page.Visible = Name == PageName;
				end;
				for Name,Button in next, SegmentButtons do
					NeverloseUI.PlayAnimate(Button.Root, SlowyTween, {
						BackgroundTransparency = Name == PageName and 0.080 or 0.550
					});
					Button.Icon.ImageColor3 = Name == PageName and NeverloseUI.AccentColor or Color3.fromRGB(210, 210, 220);
					Button.Label.TextTransparency = Name == PageName and 0 or 0.250;
				end;
			end;
			local VisibleSegmentCount = 3;
			local function MakeSegment(Name, Text, Icon)
				local WidthScale = 1 / math.max(VisibleSegmentCount, 1);
				local Button = MakePanel(Segments, UDim2.new(WidthScale, -10, 0, 34));
				Button.BackgroundTransparency = 0.550;
				SegmentCount += 1;
				Button.LayoutOrder = SegmentCount;
				local Inner = Instance.new("Frame");
				local InnerLayout = Instance.new("UIListLayout");
				Inner.Name = NeverloseUI.RandomString();
				Inner.Parent = Button;
				Inner.AnchorPoint = Vector2.new(0.5, 0.5);
				Inner.BackgroundTransparency = 1;
				Inner.BorderSizePixel = 0;
				Inner.Position = UDim2.fromScale(0.5, 0.5);
				Inner.Size = UDim2.new(1, -18, 1, 0);
				Inner.ZIndex = 14;
				InnerLayout.Parent = Inner;
				InnerLayout.FillDirection = Enum.FillDirection.Horizontal;
				InnerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
				InnerLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
				InnerLayout.SortOrder = Enum.SortOrder.LayoutOrder;
				InnerLayout.Padding = UDim.new(0, 7);
				local IconImage = MakeIcon(Button, Icon, 17, Color3.fromRGB(210, 210, 220));
				IconImage.Parent = Inner;
				IconImage.LayoutOrder = 1;
				local Label = MakeText(Button, Text, 13, true, 0.250);
				Label.Parent = Inner;
				Label.LayoutOrder = 2;
				Label.Size = UDim2.new(0, math.max(24, TextService:GetTextSize(tostring(Text), 13, Enum.Font.GothamBold, Vector2.new(math.huge, math.huge)).X + 2), 0, 18);
				Label.TextXAlignment = Enum.TextXAlignment.Left;
				Label.TextTruncate = Enum.TextTruncate.None;
				SegmentButtons[Name] = {
					Root = Button,
					Icon = IconImage,
					Label = Label,
				};
				NeverloseUI:CreateInput(Button, function()
					SelectPage(Name);
				end);
				local function FitSegmentText()
					local AvailableWidth = math.max(20, Inner.AbsoluteSize.X - IconImage.AbsoluteSize.X - InnerLayout.Padding.Offset);
					local TextWidth = TextService:GetTextSize(Label.Text, Label.TextSize, Label.Font, Vector2.new(math.huge, math.huge)).X + 4;
					Label.Size = UDim2.new(0, math.min(TextWidth, AvailableWidth), 0, 18);
					Label.TextTruncate = TextWidth > AvailableWidth and Enum.TextTruncate.AtEnd or Enum.TextTruncate.None;
				end;
				NeverloseUI:AddSignal(Inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(FitSegmentText))
				task.defer(FitSegmentText);
			end;
			local SegmentConfig = typeof(Config.Segments) == "table" and Config.Segments or {};
			local DetailsSegment = SegmentConfig.Details or SegmentConfig[1] or {};
			local ScriptSegment = SegmentConfig.Script or SegmentConfig[2] or {};
			local UISegment = SegmentConfig.UI or SegmentConfig.Ui or SegmentConfig[3] or {};
			local ShowDetailsSegment = DetailsSegment.Show ~= false and Config.ShowDetailsSegment ~= false;
			local ShowScriptSegment = ScriptSegment.Show ~= false and Config.ShowScriptSegment ~= false;
			local ShowUISegment = UISegment.Show ~= false and Config.ShowUISegment ~= false;
			VisibleSegmentCount = (ShowDetailsSegment and 1 or 0) + (ShowScriptSegment and 1 or 0) + (ShowUISegment and 1 or 0);
			if VisibleSegmentCount <= 0 then
				ShowDetailsSegment = true;
				VisibleSegmentCount = 1;
			end;
			if ShowDetailsSegment then
				MakeSegment("Details", DetailsSegment.Text or DetailsSegment.Name or Config.DetailsText or "Details And Info", DetailsSegment.Icon or Config.DetailsIcon or "lucide:layout-grid");
			end;
			if ShowScriptSegment then
				MakeSegment("Script", ScriptSegment.Text or ScriptSegment.Name or Config.ScriptText or "Script Changelog", ScriptSegment.Icon or Config.ScriptIcon or "lucide:code-2");
			end;
			if ShowUISegment then
				MakeSegment("UI", UISegment.Text or UISegment.Name or Config.UIText or Config.UiText or "UI Changelog", UISegment.Icon or Config.UIIcon or Config.UiIcon or "lucide:file-text");
			end;
			local LeftColumn = Instance.new("Frame");
			LeftColumn.Name = NeverloseUI.RandomString();
			LeftColumn.Parent = DetailsPage;
			LeftColumn.BackgroundTransparency = 1;
			LeftColumn.BorderSizePixel = 0;
			LeftColumn.Size = UDim2.new(0.52, -5, 1, 0);
			LeftColumn.ZIndex = 11;
			local RightColumn = Instance.new("Frame");
			RightColumn.Name = NeverloseUI.RandomString();
			RightColumn.Parent = DetailsPage;
			RightColumn.BackgroundTransparency = 1;
			RightColumn.BorderSizePixel = 0;
			RightColumn.Position = UDim2.new(0.52, 5, 0, 0);
			RightColumn.Size = UDim2.new(0.48, -5, 1, 0);
			RightColumn.ZIndex = 11;
			local ServerCard = MakePanel(LeftColumn, UDim2.new(1, 0, 0, 154), UDim2.fromOffset(0, 0));
			local ServerTitle = MakeText(ServerCard, "Server", 15, true, 0);
			ServerTitle.Position = UDim2.fromOffset(16, 14);
			ServerTitle.Size = UDim2.new(1, -32, 0, 18);
			local ServerSub = MakeText(ServerCard, "Information on the session you're currently in", 10, false, 0.480);
			ServerSub.Position = UDim2.fromOffset(16, 32);
			ServerSub.Size = UDim2.new(1, -32, 0, 14);
			local StatLabels = {};
			local function MakeStat(Parent, Title, Value, X, Y, W)
				local Stat = MakePanel(Parent, UDim2.new(W, -6, 0, 42), UDim2.new(X, 3, 0, Y));
				Stat.BackgroundTransparency = 0.250;
				local T = MakeText(Stat, Title, 10, true, 0.130);
				T.Position = UDim2.fromOffset(10, 7);
				T.Size = UDim2.new(1, -20, 0, 13);
				local V = MakeText(Stat, Value, 10, false, 0.350);
				V.Position = UDim2.fromOffset(10, 21);
				V.Size = UDim2.new(1, -20, 0, 13);
				return V;
			end;
			StatLabels.Players = MakeStat(ServerCard, "Players", "0 playing", 0, 58, 0.5);
			StatLabels.Capacity = MakeStat(ServerCard, "Maximum Players", tostring(Players.MaxPlayers).." can join", 0.5, 58, 0.5);
			StatLabels.Latency = MakeStat(ServerCard, "Latency", "...", 0, 104, 0.33);
			StatLabels.Region = MakeStat(ServerCard, "Server Region", tostring(Region), 0.33, 104, 0.34);
			StatLabels.Runtime = MakeStat(ServerCard, "In server for", "0s", 0.67, 104, 0.33);
			local DiscordCard = MakePanel(LeftColumn, UDim2.new(1, 0, 0, 68), UDim2.fromOffset(0, 164));
			DiscordCard.BackgroundColor3 = NeverloseUI.AccentColor;
			DiscordCard.BackgroundTransparency = 0.180;
			local DiscordGradient = Instance.new("UIGradient");
			DiscordGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, NeverloseUI.AccentColor),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 17, 22)),
			});
			DiscordGradient.Parent = DiscordCard;
			local DiscordTitle = MakeText(DiscordCard, "Discord", 20, true, 0);
			DiscordTitle.Position = UDim2.fromOffset(18, 12);
			DiscordTitle.Size = UDim2.new(1, -36, 0, 25);
			local DiscordSub = MakeText(DiscordCard, tostring(Config.DiscordInvite or "") ~= "" and "Tap to copy Discord invite" or "No Discord invite configured", 12, false, 0.250);
			DiscordSub.Position = UDim2.fromOffset(18, 38);
			DiscordSub.Size = UDim2.new(1, -36, 0, 18);
			NeverloseUI:CreateInput(DiscordCard, function()
				if tostring(Config.DiscordInvite or "") == "" then
					return;
				end;
				local Link = "https://discord.gg/"..tostring(Config.DiscordInvite);
				if setclipboard then setclipboard(Link); elseif toclipboard then toclipboard(Link); elseif set_clipboard then set_clipboard(Link); end;
				Window:Notify({ Title = "Copied", Content = Link, Duration = 2, Icon = "lucide:check" });
			end);
			local ExecutorCard = MakePanel(RightColumn, UDim2.new(1, 0, 0, 92), UDim2.fromOffset(0, 0));
			local ExecutorStatus = "Unknown";
			local ExecutorColor = NeverloseUI.AccentColor;
			if table.find(Config.SupportedExecutors, ExecutorName) then
				ExecutorStatus = "Your executor seems to support this script.";
				ExecutorColor = Color3.fromRGB(45, 180, 115);
			elseif table.find(Config.UnsupportedExecutors, ExecutorName) then
				ExecutorStatus = "Your executor may not support this script.";
				ExecutorColor = Color3.fromRGB(220, 70, 70);
			end;
			ExecutorCard.BackgroundColor3 = ExecutorColor;
			ExecutorCard.BackgroundTransparency = 0.180;
			local ExecutorGradient = Instance.new("UIGradient");
			ExecutorGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, ExecutorColor),
				ColorSequenceKeypoint.new(0.58, Color3.fromRGB(13, 17, 22)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
			});
			ExecutorGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.080),
				NumberSequenceKeypoint.new(0.55, 0),
				NumberSequenceKeypoint.new(1, 0),
			});
			ExecutorGradient.Parent = ExecutorCard;
			local ExecutorTitle = MakeText(ExecutorCard, ExecutorName, 17, true, 0);
			ExecutorTitle.Position = UDim2.fromOffset(18, 18);
			ExecutorTitle.Size = UDim2.new(1, -36, 0, 22);
			local ExecutorSub = MakeText(ExecutorCard, ExecutorStatus, 12, false, 0.150);
			ExecutorSub.Position = UDim2.fromOffset(18, 43);
			ExecutorSub.Size = UDim2.new(1, -36, 0, 34);
			ExecutorSub.TextWrapped = true;
			ExecutorSub.TextTruncate = Enum.TextTruncate.None;
			ExecutorSub.TextYAlignment = Enum.TextYAlignment.Top;
			FitTextToWidth(ExecutorSub, 12, 8, true);
			local FriendsCard = MakePanel(RightColumn, UDim2.new(1, 0, 0, 166), UDim2.fromOffset(0, 102));
			local FriendsTitle = MakeText(FriendsCard, "Friends", 16, true, 0);
			FriendsTitle.Position = UDim2.fromOffset(16, 12);
			FriendsTitle.Size = UDim2.new(1, -32, 0, 20);
			local FriendsSub = MakeText(FriendsCard, "Find out what your friends are currently doing", 10, false, 0.480);
			FriendsSub.Position = UDim2.fromOffset(16, 32);
			FriendsSub.Size = UDim2.new(1, -32, 0, 14);
			local FriendLabels = {};
			FriendLabels.InServer = MakeStat(FriendsCard, "In Server", "...", 0, 58, 0.5);
			FriendLabels.Offline = MakeStat(FriendsCard, "Offline", "...", 0.5, 58, 0.5);
			FriendLabels.Online = MakeStat(FriendsCard, "Online", "...", 0, 104, 0.5);
			FriendLabels.All = MakeStat(FriendsCard, "All", "...", 0.5, 104, 0.5);
			local function FillChangelog(Page, Entries, EmptyText)
				local Holder = MakePanel(Page, UDim2.new(1, 0, 1, 0), UDim2.fromOffset(0, 0));
				local Layout = Instance.new("UIListLayout");
				Layout.Parent = Holder;
				Layout.SortOrder = Enum.SortOrder.LayoutOrder;
				Layout.Padding = UDim.new(0, 8);
				local Padding = Instance.new("UIPadding");
				Padding.Parent = Holder;
				Padding.PaddingTop = UDim.new(0, 12);
				Padding.PaddingLeft = UDim.new(0, 12);
				Padding.PaddingRight = UDim.new(0, 12);
				if typeof(Entries) ~= "table" or #Entries <= 0 then
					local Empty = MakeText(Holder, EmptyText, 13, false, 0.250);
					Empty.Size = UDim2.new(1, 0, 0, 26);
					return;
				end;
				for Index,Entry in ipairs(Entries) do
					local Item = MakePanel(Holder, UDim2.new(1, 0, 0, 64));
					Item.LayoutOrder = Index;
					local Title = MakeText(Item, tostring(Entry.Title or Entry.Name or ("Update "..Index)), 14, true, 0);
					Title.Position = UDim2.fromOffset(14, 10);
					Title.Size = UDim2.new(1, -28, 0, 18);
					local Desc = MakeText(Item, tostring(Entry.Description or Entry.Content or Entry.Date or ""), 11, false, 0.300);
					Desc.Position = UDim2.fromOffset(14, 31);
					Desc.Size = UDim2.new(1, -28, 0, 20);
				end;
			end;
			FillChangelog(ScriptPage, Config.ScriptChangelog or Config.Changelog, "No script changelog.");
			FillChangelog(UiPage, Config.UIChangelog or Config.UiChangelog, "No UI changelog.");
			local FriendCache = {
				All = "...",
				Online = "...",
				Offline = "...",
				InServer = "...",
				Cooldown = 0,
			};
			local function UpdateFriends()
				if FriendCache.Cooldown > 0 then
					FriendCache.Cooldown -= 1;
					return;
				end;
				FriendCache.Cooldown = 30;
				task.spawn(function()
					local OnlineFriends = 0;
					local TotalFriends = 0;
					local InServer = 0;
					pcall(function()
						OnlineFriends = #Player:GetFriendsOnline();
					end);
					pcall(function()
						local Pages = Players:GetFriendsAsync(Player.UserId);
						while true do
							for _,Data in ipairs(Pages:GetCurrentPage()) do
								TotalFriends += 1;
								if Players:FindFirstChild(Data.Username) then
									InServer += 1;
								end;
							end;
							if Pages.IsFinished then
								break;
							end;
							Pages:AdvanceToNextPageAsync();
						end;
					end);
					FriendCache.All = tostring(TotalFriends).." friends";
					FriendCache.Online = tostring(OnlineFriends).." friends";
					FriendCache.Offline = tostring(math.max(TotalFriends - OnlineFriends, 0)).." friends";
					FriendCache.InServer = InServer > 0 and tostring(InServer).." friends" or "no friends";
				end);
			end;
			local Accumulator = 0;
			local function UpdateHome(dt)
				local Now = TimeFunction();
				for Index = #FrameTimes, 1, -1 do
					if FrameTimes[Index] < Now - 1 then
						table.remove(FrameTimes, Index);
					end;
				end;
				table.insert(FrameTimes, Now);
				Accumulator += dt or 0;
				if Accumulator < 0.5 then
					return;
				end;
				Accumulator = 0;
				local Ping = "...";
				pcall(function()
					Ping = tostring(math.floor((Player:GetNetworkPing() * 1000) + 0.5)).."ms";
				end);
				SetText(Welcome, "Hello, "..tostring(Player.DisplayName));
				SetText(Username, GetGreeting().." | @"..tostring(Player.Name));
				SetText(StatLabels.Players, tostring(#Players:GetPlayers()).." playing");
				SetText(StatLabels.Capacity, tostring(Players.MaxPlayers).." can join");
				SetText(StatLabels.Latency, Ping);
				SetText(StatLabels.Runtime, GetElapsed());
				SetText(FriendLabels.InServer, FriendCache.InServer);
				SetText(FriendLabels.Offline, FriendCache.Offline);
				SetText(FriendLabels.Online, FriendCache.Online);
				SetText(FriendLabels.All, FriendCache.All);
				UpdateFriends();
			end;
			SelectPage("Details");
			local HomeSignal = NeverloseUI:AddSignal(RunService.RenderStepped:Connect(UpdateHome));
			table.insert(Window.OnDestroyCallbacks, function()
				if HomeSignal then
					HomeSignal:Disconnect();
				end;
			end);
			function Tab:GetHomeSection()
				return Tab.HomeRoot;
			end;
			return CaseInsensitive(Tab);
		end;
		local Section = Tab:AddSection({
			Name = Config.SectionName or Config.Title or Config.Name,
			Position = Config.AutoSetup ~= false and "Left" or "Center",
			Collapsible = Config.Collapsible == true,
			Box = Config.Box == true,
			Icon = Config.SectionIcon,
		});
		Tab.HomeSection = Section;
		if Config.AutoSetup ~= false then
			local Player = LocalPlayer;
			local ExecutorName = "Roblox Studio";
			local PlaceName = "Unknown Place";
			local Region = "Unknown";
			local TimeFunction = RunService:IsRunning() and time or os.clock;
			local FrameTimes = {};
			local StartedAt = TimeFunction();
			pcall(function()
				if identifyexecutor then
					ExecutorName = tostring(select(1, identifyexecutor()));
				end;
			end);
			pcall(function()
				PlaceName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name;
			end);
			pcall(function()
				Region = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(Player);
			end);
			local function GetGreeting()
				local Hour = os.date("*t").hour;
				if Hour >= 4 and Hour < 12 then
					return "Good Morning";
				elseif Hour >= 12 and Hour < 19 then
					return "How's Your Day Going?";
				elseif Hour >= 19 and Hour <= 23 then
					return "Sweet Dreams";
				end;
				return "You should be asleep";
			end;
			local function GetElapsed()
				local Elapsed = math.max(0, TimeFunction() - StartedAt);
				if Elapsed < 60 then
					return tostring(math.floor(Elapsed)).."s";
				elseif Elapsed < 3600 then
					return tostring(math.floor(Elapsed / 60)).."m";
				end;
				return tostring(math.floor(Elapsed / 3600)).."h";
			end;
			Section:AddParagraph({
				Name = "Welcome, "..tostring(Player.DisplayName),
				Content = tostring(Config.Content ~= "" and Config.Content or (GetGreeting().." | @"..Player.Name)),
			});
			local StatusSection = Tab:AddSection({
				Name = "Status",
				Position = "Right",
				Icon = "lucide:activity",
			});
			local ServerSection = Tab:AddSection({
				Name = "Server",
				Position = "Left",
				Icon = "lucide:server",
			});
			local PlayerLabel = StatusSection:AddLabel({
				Text = "Players: "..tostring(#Players:GetPlayers()).."/"..tostring(Players.MaxPlayers),
			});
			local RuntimeLabel = StatusSection:AddLabel({
				Text = "Runtime: 0s",
			});
			local PerformanceLabel = StatusSection:AddLabel({
				Text = "FPS: ... | Ping: ...",
			});
			local ExecutorStatus = "Unknown";
			if table.find(Config.SupportedExecutors, ExecutorName) then
				ExecutorStatus = "Supported";
			elseif table.find(Config.UnsupportedExecutors, ExecutorName) then
				ExecutorStatus = "Unsupported";
			end;
			StatusSection:AddParagraph({
				Name = ExecutorName,
				Content = "Executor: "..ExecutorStatus,
			});
			ServerSection:AddParagraph({
				Name = PlaceName,
				Content = "PlaceId: "..tostring(game.PlaceId).."\nJobId: "..tostring(game.JobId).."\nRegion: "..tostring(Region),
			});
			ServerSection:AddButton({
				Name = "Copy Join Script",
				Icon = "lucide:copy",
				Callback = function()
					local JoinScript = ('game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s", game:GetService("Players").LocalPlayer)'):format(tostring(game.PlaceId), tostring(game.JobId));
					if setclipboard then
						setclipboard(JoinScript);
					elseif toclipboard then
						toclipboard(JoinScript);
					elseif set_clipboard then
						set_clipboard(JoinScript);
					end;
					Window:Notify({
						Title = "Copied",
						Content = "Join script copied.",
						Duration = 2,
						Icon = "lucide:check",
					});
				end,
			});
			if tostring(Config.DiscordInvite or "") ~= "" then
				ServerSection:AddButton({
					Name = "Copy Discord",
					Icon = "lucide:message-circle",
					Callback = function()
						local Link = "https://discord.gg/"..tostring(Config.DiscordInvite);
						if setclipboard then
							setclipboard(Link);
						elseif toclipboard then
							toclipboard(Link);
						elseif set_clipboard then
							set_clipboard(Link);
						end;
						Window:Notify({
							Title = "Copied",
							Content = Link,
							Duration = 2,
							Icon = "lucide:check",
						});
					end,
				});
			end;
			if typeof(Config.Changelog) == "table" and #Config.Changelog > 0 then
				local ChangelogSection = Tab:AddSection({
					Name = "Changelog",
					Position = "Right",
					Icon = "lucide:list-checks",
					Collapsible = true,
				});
				for Index,Entry in ipairs(Config.Changelog) do
					if Index > 4 then
						break;
					end;
					if typeof(Entry) == "table" then
						ChangelogSection:AddParagraph({
							Name = tostring(Entry.Title or Entry.Name or ("Update "..Index)),
							Content = tostring(Entry.Date and (Entry.Date.."\n") or "")..tostring(Entry.Description or Entry.Content or ""),
						});
					else
						ChangelogSection:AddLabel({
							Text = tostring(Entry),
						});
					end;
				end;
			end;
			local Accumulator = 0;
			local function UpdateHome(dt)
				Accumulator = Accumulator + (dt or 0);
				local Now = TimeFunction();
				for Index = #FrameTimes, 1, -1 do
					if FrameTimes[Index] < Now - 1 then
						table.remove(FrameTimes, Index);
					end;
				end;
				table.insert(FrameTimes, Now);
				if Accumulator < 0.5 then
					return;
				end;
				Accumulator = 0;
				local Ping = "...";
				pcall(function()
					Ping = tostring(math.floor((Player:GetNetworkPing() * 1000) + 0.5)).."ms";
				end);
				if PlayerLabel.SetText then
					PlayerLabel:SetText("Players: "..tostring(#Players:GetPlayers()).."/"..tostring(Players.MaxPlayers));
				end;
				if RuntimeLabel.SetText then
					RuntimeLabel:SetText("Runtime: "..GetElapsed());
				end;
				if PerformanceLabel.SetText then
					PerformanceLabel:SetText("FPS: "..tostring(#FrameTimes).." | Ping: "..Ping);
				end;
			end;
			local HomeSignal = NeverloseUI:AddSignal(RunService.RenderStepped:Connect(UpdateHome));
			table.insert(Window.OnDestroyCallbacks, function()
				if HomeSignal then
					HomeSignal:Disconnect();
				end;
			end);
		elseif tostring(Config.Content or "") ~= "" then
			Section:AddParagraph({
				Name = Config.ParagraphName or Config.Title or Config.Name,
				Content = Config.Content,
			});
		end;
		if typeof(Config.Buttons) == "table" then
			for _,ButtonConfig in ipairs(Config.Buttons) do
				Section:AddButton(ButtonConfig);
			end;
		end;
		function Tab:GetHomeSection()
			return Section;
		end;
		return CaseInsensitive(Tab);
	end;
	function Window:AddTab(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Icon = "crosshairs",
			Name = "Tab",
			Type = "Double",
			Locked = false,
			TextLocked = "Locked",
			Internal = false,
			LayoutOrder = 0,
		});
		local Tab = {
			Signal = NeverloseUI:CreateSignal(false);
			Internal = Config.Internal == true;
		};
		local TabButton = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TabIcon = Instance.new("ImageLabel")
		local TabContentLabel = Instance.new("TextLabel")
		Tab.Idx = TabButton;
		TabButton.Name = NeverloseUI.RandomString();
		TabButton.Parent = Window.__NextTabParent or LeftScrollingFrame
		TabButton.BackgroundColor3 = Color3.fromRGB(41, 45, 49)
		TabButton.BackgroundTransparency = 0.500
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -1, 0, 30)
		TabButton.ZIndex = 8
		TabButton.LayoutOrder = tonumber(Config.LayoutOrder) or 0
		NeverloseUI:AttachLockMethods(Tab, TabButton, Config);
		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = TabButton
		TabIcon.Name = NeverloseUI.RandomString();
		TabIcon.Parent = TabButton
		TabIcon.AnchorPoint = Vector2.new(0, 0.5)
		TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabIcon.BorderSizePixel = 0
		TabIcon.Position = UDim2.new(0, 2, 0.5, 0)
		TabIcon.Size = UDim2.new(0, 25, 0, 25)
		TabIcon.ZIndex = 9
		NeverloseUI:SetIconMode(TabIcon, Config.Icon);
		TabIcon.ImageColor3 = NeverloseUI.AccentColor
		TabIcon.ScaleType = Enum.ScaleType.Fit
		TabContentLabel.Name = NeverloseUI.RandomString();
		TabContentLabel.Parent = TabButton
		TabContentLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabContentLabel.BackgroundTransparency = 1.000
		TabContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabContentLabel.BorderSizePixel = 0
		TabContentLabel.Position = UDim2.new(0, 30, 0.5, 0)
		TabContentLabel.Size = UDim2.new(1, -7, 0, 15)
		TabContentLabel.ZIndex = 9
		TabContentLabel.Font = Enum.Font.GothamMedium
		TabContentLabel.Text = Config.Name
		TabContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabContentLabel.TextSize = 12.000
		TabContentLabel.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(TabContentLabel);
		local TabFrame = Instance.new("Frame")
		local LeftScroll = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local RightScroll = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local CenterScroll = Instance.new("ScrollingFrame")
		local UIListLayout_3 = Instance.new("UIListLayout")
		local FlowScroll = Instance.new("ScrollingFrame")
		local UIListLayout_4 = Instance.new("UIListLayout")
		TabFrame.Name = NeverloseUI.RandomString();
		TabFrame.Parent = TabContainer
		TabFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.BackgroundTransparency = 1.000
		TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabFrame.BorderSizePixel = 0
		TabFrame.ClipsDescendants = true
		TabFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.Visible = true;
		LeftScroll.Name = NeverloseUI.RandomString();
		LeftScroll.Parent = TabFrame
		LeftScroll.Active = true
		LeftScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		LeftScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LeftScroll.BackgroundTransparency = 1.000
		LeftScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LeftScroll.BorderSizePixel = 0
		LeftScroll.ClipsDescendants = false
		LeftScroll.Position = UDim2.new(0.25, 0, 0.5, 0)
		LeftScroll.Size = UDim2.new(0.5, 0, 1, -5)
		LeftScroll.ScrollBarThickness = 0
		UIListLayout.Parent = LeftScroll
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)
		NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			LeftScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 1)
		end)))
		RightScroll.Name = NeverloseUI.RandomString();
		RightScroll.Parent = TabFrame
		RightScroll.Active = true
		RightScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		RightScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		RightScroll.BackgroundTransparency = 1.000
		RightScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		RightScroll.BorderSizePixel = 0
		RightScroll.ClipsDescendants = false
		RightScroll.Position = UDim2.new(0.75, 0, 0.5, 0)
		RightScroll.Size = UDim2.new(0.5, 0, 1, -5)
		RightScroll.ScrollBarThickness = 0
		UIListLayout_2.Parent = RightScroll
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 5)
		CenterScroll.Name = NeverloseUI.RandomString();
		CenterScroll.Parent = TabFrame
		CenterScroll.Active = true
		CenterScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		CenterScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CenterScroll.BackgroundTransparency = 1.000
		CenterScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CenterScroll.BorderSizePixel = 0
		CenterScroll.ClipsDescendants = false
		CenterScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
		CenterScroll.Size = UDim2.new(1, 0, 1, -5)
		CenterScroll.ScrollBarThickness = 0
		CenterScroll.ZIndex = 6
		CenterScroll.Visible = false
		UIListLayout_3.Parent = CenterScroll
		UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_3.Padding = UDim.new(0, 5)
		local IsSingleTab = string.lower(tostring(Config.Type)) == "single";
		local UpdateTabColumnLayout;
		UpdateTabColumnLayout = LPH_NO_VIRTUALIZE(function()
			if not CenterScroll.Visible then
				CenterScroll.AnchorPoint = Vector2.new(0.5, 0.5)
				CenterScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
				CenterScroll.Size = UDim2.new(1, 0, 1, -5)
				LeftScroll.AnchorPoint = Vector2.new(0.5, 0.5)
				LeftScroll.Position = IsSingleTab and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
				LeftScroll.Size = IsSingleTab and UDim2.new(1, 0, 1, -5) or UDim2.new(0.5, 0, 1, -5)
				if RightScroll and RightScroll.Parent then
					RightScroll.AnchorPoint = Vector2.new(0.5, 0.5)
					RightScroll.Position = UDim2.new(0.75, 0, 0.5, 0)
					RightScroll.Size = UDim2.new(0.5, 0, 1, -5)
				end;
				return;
			end;
			local MaxCenterHeight = math.max(80, TabFrame.AbsoluteSize.Y * 0.45);
			local CenterHeight = math.clamp(UIListLayout_3.AbsoluteContentSize.Y + 1, 0, MaxCenterHeight);
			local ColumnOffset = CenterHeight + 5;
			CenterScroll.AnchorPoint = Vector2.new(0.5, 0)
			CenterScroll.Position = UDim2.new(0.5, 0, 0, 0)
			CenterScroll.Size = UDim2.new(1, 0, 0, CenterHeight)
			LeftScroll.AnchorPoint = Vector2.new(0.5, 0)
			LeftScroll.Position = IsSingleTab and UDim2.new(0.5, 0, 0, ColumnOffset) or UDim2.new(0.25, 0, 0, ColumnOffset)
			LeftScroll.Size = IsSingleTab and UDim2.new(1, 0, 1, -ColumnOffset - 5) or UDim2.new(0.5, 0, 1, -ColumnOffset - 5)
			if RightScroll and RightScroll.Parent then
				RightScroll.AnchorPoint = Vector2.new(0.5, 0)
				RightScroll.Position = UDim2.new(0.75, 0, 0, ColumnOffset)
				RightScroll.Size = UDim2.new(0.5, 0, 1, -ColumnOffset - 5)
			end;
		end);
		NeverloseUI:AddSignal(UIListLayout_3:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			CenterScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout_3.AbsoluteContentSize.Y + 1)
			UpdateTabColumnLayout();
		end)))
		NeverloseUI:AddSignal(TabFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(LPH_NO_VIRTUALIZE(function()
			UpdateTabColumnLayout();
		end)))
		FlowScroll.Name = NeverloseUI.RandomString();
		FlowScroll.Parent = TabFrame
		FlowScroll.Active = true
		FlowScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		FlowScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		FlowScroll.BackgroundTransparency = 1.000
		FlowScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		FlowScroll.BorderSizePixel = 0
		FlowScroll.ClipsDescendants = false
		FlowScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
		FlowScroll.Size = UDim2.new(1, 0, 1, -5)
		FlowScroll.ScrollBarThickness = 0
		FlowScroll.ZIndex = 7
		UIListLayout_4.Parent = FlowScroll
		UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_4.Padding = UDim.new(0, 5)
		Tab.Root = TabFrame;
		Tab.LeftScroll = LeftScroll;
		Tab.RightScroll = RightScroll;
		Tab.CenterScroll = CenterScroll;
		Tab.CustomRoot = FlowScroll;
		LeftScroll.Visible = false
		RightScroll.Visible = false
		CenterScroll.Visible = false
		NeverloseUI:AddSignal(UIListLayout_4:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			FlowScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout_4.AbsoluteContentSize.Y + 1)
		end)))
		local FlowOrder = 0;
		local PendingPairRow = nil;
		local function CreateFlowRow(kind)
			FlowOrder = FlowOrder + 1;
			local Row = Instance.new("Frame")
			local RowLayout = Instance.new("UIListLayout")
			Row.Name = NeverloseUI.RandomString();
			Row.Parent = FlowScroll
			Row.BackgroundTransparency = 1
			Row.BorderSizePixel = 0
			Row.ClipsDescendants = false
			Row.Size = UDim2.new(1, 0, 0, 0)
			Row.ZIndex = 8
			Row.LayoutOrder = FlowOrder
			RowLayout.Parent = Row
			RowLayout.FillDirection = Enum.FillDirection.Horizontal
			RowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			RowLayout.SortOrder = Enum.SortOrder.LayoutOrder
			RowLayout.Padding = UDim.new(0, 0)
			local LeftCell = Instance.new("Frame")
			local LeftLayout = Instance.new("UIListLayout")
			local RightCell = Instance.new("Frame")
			local RightLayout = Instance.new("UIListLayout")
			LeftCell.Name = NeverloseUI.RandomString();
			LeftCell.Parent = Row
			LeftCell.BackgroundTransparency = 1
			LeftCell.BorderSizePixel = 0
			LeftCell.ClipsDescendants = false
			LeftCell.LayoutOrder = 1
			LeftCell.Size = kind == "center" and UDim2.new(1, 0, 0, 0) or UDim2.new(0.5, 0, 0, 0)
			LeftCell.ZIndex = 8
			LeftLayout.Parent = LeftCell
			LeftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
			LeftLayout.Padding = UDim.new(0, 5)
			RightCell.Name = NeverloseUI.RandomString();
			RightCell.Parent = Row
			RightCell.BackgroundTransparency = 1
			RightCell.BorderSizePixel = 0
			RightCell.ClipsDescendants = false
			RightCell.LayoutOrder = 2
			RightCell.Size = UDim2.new(0.5, 0, 0, 0)
			RightCell.Visible = kind ~= "center"
			RightCell.ZIndex = 8
			RightLayout.Parent = RightCell
			RightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
			RightLayout.Padding = UDim.new(0, 5)
			local function UpdateRowSize()
				local leftHeight = LeftLayout.AbsoluteContentSize.Y;
				local rightHeight = RightCell.Visible and RightLayout.AbsoluteContentSize.Y or 0;
				local height = math.max(leftHeight, rightHeight);
				Row.Size = UDim2.new(1, 0, 0, height);
				LeftCell.Size = UDim2.new(LeftCell.Size.X.Scale, 0, 0, height);
				RightCell.Size = UDim2.new(RightCell.Size.X.Scale, 0, 0, height);
				FlowScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout_4.AbsoluteContentSize.Y + 1);
			end;
			NeverloseUI:AddSignal(LeftLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(UpdateRowSize))
			NeverloseUI:AddSignal(RightLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(UpdateRowSize))
			return {
				Root = Row,
				Left = LeftCell,
				Right = RightCell,
				Kind = kind,
				HasLeft = false,
				HasRight = false,
				Update = UpdateRowSize,
			};
		end;
		local function ResolveFlowParent(Position)
			local PositionName = string.lower(tostring(Position or "left"));
			if PositionName == "center" then
				PendingPairRow = nil;
				return CreateFlowRow("center").Left;
			end;
			if IsSingleTab then
				PendingPairRow = nil;
				return CreateFlowRow("center").Left;
			end;
			if PositionName ~= "right" then
				PositionName = "left";
			end;
			if PendingPairRow and PendingPairRow.Kind == "pair" then
				if PositionName == "right" then
					PendingPairRow.HasRight = true;
					return PendingPairRow.Right;
				end;
				PendingPairRow.HasLeft = true;
				return PendingPairRow.Left;
			end;
			local NewRow = CreateFlowRow("pair");
			PendingPairRow = NewRow;
			if PositionName == "right" then
				NewRow.HasRight = true;
				return NewRow.Right;
			end;
			NewRow.HasLeft = true;
			return NewRow.Left;
		end;
		if IsSingleTab then
			UIListLayout_2:Destroy();
			RightScroll:Destroy();
			RightScroll = LeftScroll;
			UIListLayout_2 = UIListLayout;
			LeftScroll.Size = UDim2.new(1, 0, 1, -5);
			LeftScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
		else
			NeverloseUI:AddSignal(UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				RightScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y + 1)
			end)))
		end;
		UpdateTabColumnLayout();
		NeverloseUI:AddSignal(TabIcon:GetPropertyChangedSignal('ImageTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if TabIcon.ImageTransparency > 0.4 then
				UIListLayout.Parent = nil;
				UIListLayout_2.Parent = nil;
				UIListLayout_3.Parent = nil;
				UIListLayout_4.Parent = nil;
				TabFrame.Visible = false;
				TabFrame.Parent = nil
			else
				UIListLayout.Parent = LeftScroll;
				UIListLayout_2.Parent = RightScroll;
				UIListLayout_3.Parent = CenterScroll;
				UIListLayout_4.Parent = FlowScroll;
				TabFrame.Visible = true;
				TabFrame.Parent = TabContainer;
			end;
		end)));
		Tab.SetValue = LPH_NO_VIRTUALIZE(function(value)
			if value and Tab.GetLocked and Tab:GetLocked() then
				value = false;
			end;
			Tab.Signal:SetValue(value);
			if value then
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
				NeverloseUI.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 0,
					TextColor3 = NeverloseUI.AccentColor
				})
				NeverloseUI.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 0
				})
			else
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 0.5,
					TextColor3 = Color3.fromRGB(252, 252, 252)
				})
				NeverloseUI.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 0.5
				})
			end;
		end);
		local BaseTabSetLocked = Tab.SetLocked;
		function Tab:SetLocked(value)
			if BaseTabSetLocked then
				BaseTabSetLocked(Tab, value);
			end;
			if value == true and Window.Tabs[Window.CurrentTab] == Tab then
				Tab.SetValue(false);
				for Index,OtherTab in ipairs(Window.Tabs) do
					if OtherTab ~= Tab and (not OtherTab.GetLocked or not OtherTab:GetLocked()) then
						Window.CurrentTab = Index;
						OtherTab.SetValue(true);
						break;
					end;
				end;
			end;
			return Tab;
		end;
		function Tab:Select()
			if Tab.GetLocked and Tab:GetLocked() then
				return Tab;
			end;
			for i,v in next , Window.Tabs do
				if v == Tab then
					v.SetValue(true);
					Window.CurrentTab = i;
				else
					v.SetValue(false);
				end;
			end;
			return Tab;
		end;
		table.insert(Window.Tabs,Tab);
		if Tab.Internal then
			if Window.Tabs[Window.CurrentTab] == Tab then
				Window.CurrentTab = 0;
			end;
		elseif not Window.Tabs[Window.CurrentTab] or Window.Tabs[Window.CurrentTab].Internal then
			Window.CurrentTab = #Window.Tabs;
		end;
		if Window.Tabs[Window.CurrentTab] and Window.Tabs[Window.CurrentTab].GetLocked and Window.Tabs[Window.CurrentTab]:GetLocked() and (not Tab.GetLocked or not Tab:GetLocked()) then
			Window.CurrentTab = #Window.Tabs;
		end;
		if Window.Tabs[Window.CurrentTab] == Tab then
			Tab.SetValue(true)
		else
			Tab.SetValue(false);
		end;
		local over = NeverloseUI:CreateInput(TabButton,LPH_NO_VIRTUALIZE(function()
			if Tab.GetLocked and Tab:GetLocked() then
				return;
			end;
			for i,v in next , Window.Tabs do
				if v.Idx == TabButton then
					v.SetValue(true);
					Window.CurrentTab = i;
				else
					v.SetValue(false);
				end;
			end;
		end));
		NeverloseUI:AddSignal(over.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Tabs[Window.CurrentTab] == Tab then
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
			else
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.8
				})
			end;
		end)))
		NeverloseUI:AddSignal(over.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Tabs[Window.CurrentTab] == Tab then
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
			else
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end)))
		Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(value)
			if value then
				if Window.Tabs[Window.CurrentTab] == Tab then
					Tab.SetValue(true)
				else
					Tab.SetValue(false);
				end;
			else
				Tab.SetValue(false);
				NeverloseUI.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 1,
				})
				NeverloseUI.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end));
		function Tab:AddSection(Config)
			Config = NeverloseUI:ProcessParams(Config , {
				Name = "SECTION",
				Position = 'left',
				Collapsible = false,
				Collapsed = false,
				Box = false,
				Icon = nil,
				IconColor = Color3.fromRGB(223, 223, 223),
				TextSize = 11,
				TextXAlignment = "Left",
				Locked = false,
				TextLocked = "Locked",
			});
			local SectionBoxed = Config.Collapsible == true and Config.Box == true;
			local function ResolveTextXAlignment(value)
				local Alignment = string.lower(tostring(value or "left"));
				if Alignment == "center" then
					return Enum.TextXAlignment.Center;
				elseif Alignment == "right" then
					return Enum.TextXAlignment.Right;
				end;
				return Enum.TextXAlignment.Left;
			end;
			local function GetSectionHeaderHeight()
				local TextHeight = (tonumber(Config.TextSize) or 11) + 9;
				local IconHeight = (Config.Icon and tostring(Config.Icon) ~= "") and 25 or 20;
				return math.max(20, TextHeight, IconHeight);
			end;
			local SectionFrame = Instance.new("Frame")
			local SectionIcon = Instance.new("ImageLabel")
			local SectionLabel = Instance.new("TextLabel")
			local SectionCollapseIcon = Instance.new("ImageLabel")
			local SectionHandler = Instance.new("Frame")
			local SectionHeaderSpacer = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local UIListLayout = Instance.new("UIListLayout")
			SectionFrame.Name = NeverloseUI.RandomString();
			local SectionPosition = string.lower(tostring(Config.Position));
			SectionFrame.Parent = ResolveFlowParent(SectionPosition)
			SectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionFrame.BackgroundTransparency = 1.000
			SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionFrame.BorderSizePixel = 0
			SectionFrame.ClipsDescendants = true
			SectionFrame.Size = UDim2.new(1, -5, 0, 0)
			SectionFrame.ZIndex = 9
			SectionIcon.Name = NeverloseUI.RandomString();
			SectionIcon.Parent = SectionFrame
			SectionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionIcon.BackgroundTransparency = 1.000
			SectionIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionIcon.BorderSizePixel = 0
			SectionIcon.Size = UDim2.new(0, 15, 0, 15)
			SectionIcon.ZIndex = 11
			SectionIcon.ImageColor3 = Config.IconColor
			SectionIcon.ImageTransparency = Config.Icon and 0.500 or 1
			SectionIcon.ScaleType = Enum.ScaleType.Fit
			if Config.Icon then
				NeverloseUI:SetIconMode(SectionIcon, Config.Icon);
			end;
			SectionLabel.Name = NeverloseUI.RandomString();
			SectionLabel.Parent = SectionFrame
			SectionLabel.AnchorPoint = Vector2.new(0, 0)
			SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionLabel.BackgroundTransparency = 1.000
			SectionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionLabel.BorderSizePixel = 0
			SectionLabel.Position = UDim2.new(0, 11, 0, 0)
			SectionLabel.Size = UDim2.new(1, -46, 0, 15)
			SectionLabel.ZIndex = 11
			SectionLabel.Font = Enum.Font.GothamMedium
			SectionLabel.Text = Config.Name
			SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionLabel.TextSize = tonumber(Config.TextSize) or 11
			SectionLabel.TextTransparency = 0.500
			SectionLabel.TextXAlignment = ResolveTextXAlignment(Config.TextXAlignment)
			NeverloseUI:AddTextGradient(SectionLabel);
			SectionCollapseIcon.Name = NeverloseUI.RandomString();
			SectionCollapseIcon.Parent = SectionFrame
			SectionCollapseIcon.AnchorPoint = Vector2.new(1, 0)
			SectionCollapseIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionCollapseIcon.BackgroundTransparency = 1.000
			SectionCollapseIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionCollapseIcon.BorderSizePixel = 0
			SectionCollapseIcon.Position = SectionBoxed and UDim2.new(1, -8, 0, 1) or UDim2.new(1, -8, 0, -4)
			SectionCollapseIcon.Size = UDim2.new(0, 24, 0, 24)
			SectionCollapseIcon.Visible = Config.Collapsible == true
			SectionCollapseIcon.ZIndex = 12
			NeverloseUI:SetIconMode(SectionCollapseIcon, "chevron-small-down")
			SectionCollapseIcon.ImageColor3 = Color3.fromRGB(223, 223, 223)
			SectionCollapseIcon.ImageTransparency = 0.500
			SectionCollapseIcon.ScaleType = Enum.ScaleType.Fit
			SectionHandler.Name = NeverloseUI.RandomString();
			SectionHandler.Parent = SectionFrame
			SectionHandler.AnchorPoint = Vector2.new(0.5, 0)
			SectionHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
			SectionHandler.BackgroundTransparency = 0.500
			SectionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionHandler.BorderSizePixel = 0
			SectionHandler.ClipsDescendants = true
			SectionHandler.Position = SectionBoxed and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, 0, GetSectionHeaderHeight())
			SectionHandler.Size = SectionBoxed and UDim2.new(1, -10, 1, 0) or UDim2.new(1, -10, 1, -GetSectionHeaderHeight() - 1)
			SectionHandler.ZIndex = 9
			SectionHeaderSpacer.Name = NeverloseUI.RandomString();
			SectionHeaderSpacer.Parent = SectionHandler
			SectionHeaderSpacer.BackgroundTransparency = 1.000
			SectionHeaderSpacer.BorderSizePixel = 0
			SectionHeaderSpacer.LayoutOrder = -100000
			SectionHeaderSpacer.Size = UDim2.new(1, 0, 0, GetSectionHeaderHeight() + 4)
			SectionHeaderSpacer.Visible = SectionBoxed
			SectionHeaderSpacer.ZIndex = 9
			UIStroke.Transparency = 0.650
			UIStroke.Color = Color3.fromRGB(45, 48, 58)
			UIStroke.Parent = SectionHandler
			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = SectionHandler
			UIListLayout.Parent = SectionHandler
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			local CollapseInput;
			local function UpdateSectionHeaderLayout()
				local HasIcon = Config.Icon ~= nil and tostring(Config.Icon) ~= "";
				local HeaderHeight = GetSectionHeaderHeight();
				local TextSize = tonumber(Config.TextSize) or 11;
				local LabelHeight = math.max(15, TextSize + 4);
				local IconSize = math.clamp(TextSize + 2, 14, 20);
				local HeaderY = math.max(0, math.floor((HeaderHeight - LabelHeight) / 2));
				local IconY = math.max(0, math.floor((HeaderHeight - IconSize) / 2));
				local ChevronY = math.floor((HeaderHeight - 24) / 2);
				local IconX = 11;
				local LabelX = HasIcon and 32 or 11;
				local RightPadding = Config.Collapsible == true and 38 or 11;
				SectionIcon.Visible = HasIcon;
				SectionIcon.Position = UDim2.new(0, IconX, 0, IconY);
				SectionIcon.Size = UDim2.new(0, IconSize, 0, IconSize);
				SectionIcon.ImageColor3 = Config.IconColor;
				SectionIcon.ImageTransparency = HasIcon and 0.500 or 1;
				SectionLabel.TextSize = TextSize;
				SectionLabel.Position = UDim2.new(0, LabelX, 0, HeaderY);
				SectionLabel.Size = UDim2.new(1, -(LabelX + RightPadding), 0, LabelHeight);
				SectionLabel.TextXAlignment = ResolveTextXAlignment(Config.TextXAlignment);
				SectionCollapseIcon.Position = UDim2.new(1, -8, 0, ChevronY);
				SectionHeaderSpacer.Size = UDim2.new(1, 0, 0, GetSectionHeaderHeight() + 4);
				SectionHandler.Position = SectionBoxed and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, 0, GetSectionHeaderHeight());
				SectionHandler.Size = SectionBoxed and UDim2.new(1, -10, 1, 0) or UDim2.new(1, -10, 1, -GetSectionHeaderHeight() - 1);
				if CollapseInput then
					CollapseInput.Size = UDim2.new(1, 0, 0, GetSectionHeaderHeight());
				end;
			end;
			UpdateSectionHeaderLayout();
			local Section = NeverloseUI:RegisiterItem(SectionHandler , Tab.Signal);
			Section.Collapsible = Config.Collapsible == true;
			Section.Collapsed = Config.Collapsed == true;
			Section.Root = SectionFrame;
			NeverloseUI:AttachLockMethods(Section, SectionFrame, Config);
			NeverloseUI.SectionOwners[SectionHandler] = Section;
			local IsSectionRendered = Tab.Signal:GetValue();
			local function UpdateSectionSize()
				if not IsSectionRendered then
					SectionFrame.Size = UDim2.new(1, -5, 0, 0);
					return;
				end;
				local ContentHeight = UIListLayout.AbsoluteContentSize.Y;
				local HeaderHeight = GetSectionHeaderHeight();
				local HeaderSpacerHeight = SectionBoxed and (HeaderHeight + 4) or 0;
				local BoxPadding = 0;
				local RealContentHeight = math.max(0, ContentHeight - HeaderSpacerHeight);
				local TargetHeight = SectionBoxed and (HeaderSpacerHeight + BoxPadding) or HeaderHeight;
				if not Section.Collapsed and RealContentHeight > 1 then
					TargetHeight = SectionBoxed and (HeaderSpacerHeight + RealContentHeight + BoxPadding) or (ContentHeight + HeaderHeight - 0.5);
				end;
				NeverloseUI.PlayAnimate(SectionFrame , VSlowTween , {
					Size = UDim2.new(1, -5, 0, TargetHeight)
				})
			end;
			local function RenderCollapsedState()
				local ShowContent = IsSectionRendered and not Section.Collapsed;
				SectionHandler.Visible = SectionBoxed and IsSectionRendered or ShowContent;
				UIListLayout.Parent = SectionHandler;
				if Section.Collapsible then
					NeverloseUI.PlayAnimate(SectionCollapseIcon,SlowyTween,{
						Rotation = Section.Collapsed and -90 or 0,
						ImageTransparency = IsSectionRendered and 0.500 or 1
					})
				end;
				UpdateSectionSize();
			end;
			NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(UpdateSectionSize)));
			function Section:SetCollapsed(value)
				if not Section.Collapsible then
					Section.Collapsible = true;
					Config.Collapsible = true;
					SectionCollapseIcon.Visible = true;
				end;
				Section.Collapsed = value == true;
				Config.Collapsed = Section.Collapsed;
				RenderCollapsedState();
				return Section;
			end;
			function Section:ToggleCollapsed()
				return Section:SetCollapsed(not Section.Collapsed);
			end;
			function Section:GetCollapsed()
				return Section.Collapsed;
			end;
			function Section:SetCollapsible(value)
				Section.Collapsible = value == true;
				Config.Collapsible = Section.Collapsible;
				SectionBoxed = Section.Collapsible and Config.Box == true;
				SectionCollapseIcon.Visible = Section.Collapsible;
				SectionHeaderSpacer.Visible = SectionBoxed;
				UpdateSectionHeaderLayout();
				if not Section.Collapsible then
					Section.Collapsed = false;
					Config.Collapsed = false;
				end;
				RenderCollapsedState();
				return Section;
			end;
			function Section:SetBox(value)
				Config.Box = value == true;
				SectionBoxed = Section.Collapsible and Config.Box == true;
				SectionHeaderSpacer.Visible = SectionBoxed;
				UpdateSectionHeaderLayout();
				RenderCollapsedState();
				return Section;
			end;
			function Section:GetBox()
				return SectionBoxed;
			end;
			function Section:SetIcon(icon)
				Config.Icon = icon;
				if Config.Icon and tostring(Config.Icon) ~= "" then
					NeverloseUI:SetIconMode(SectionIcon, Config.Icon);
				end;
				UpdateSectionHeaderLayout();
				RenderCollapsedState();
				return Section;
			end;
			function Section:SetIconColor(color)
				Config.IconColor = color or Config.IconColor;
				UpdateSectionHeaderLayout();
				return Section;
			end;
			function Section:SetTextSize(size)
				Config.TextSize = tonumber(size) or Config.TextSize;
				UpdateSectionHeaderLayout();
				RenderCollapsedState();
				return Section;
			end;
			function Section:SetTextXAlignment(alignment)
				Config.TextXAlignment = alignment or Config.TextXAlignment;
				UpdateSectionHeaderLayout();
				return Section;
			end;
			if Config.Collapsible then
				CollapseInput = NeverloseUI:CreateInput(SectionFrame , LPH_NO_VIRTUALIZE(function()
					Section:ToggleCollapsed();
				end));
				CollapseInput.ZIndex = 12;
				CollapseInput.Size = UDim2.new(1, 0, 0, GetSectionHeaderHeight());
			end;
			Section.SetRender = LPH_NO_VIRTUALIZE(function(value)
				IsSectionRendered = value == true;
				if value then
					NeverloseUI.PlayAnimate(SectionIcon,SlowyTween,{
						ImageTransparency = (Config.Icon and tostring(Config.Icon) ~= "") and 0.500 or 1
					})
					NeverloseUI.PlayAnimate(SectionLabel,SlowyTween,{
						TextTransparency = 0.500
					})
					NeverloseUI.PlayAnimate(SectionHandler,SlowyTween,{
						BackgroundTransparency = 0.500
					})
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.650
					})
				else
					NeverloseUI.PlayAnimate(SectionIcon,SlowyTween,{
						ImageTransparency = 1
					})
					NeverloseUI.PlayAnimate(SectionLabel,SlowyTween,{
						TextTransparency = 1
					})
					NeverloseUI.PlayAnimate(SectionHandler,SlowyTween,{
						BackgroundTransparency = 1
					})
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 1
					})
				end;
				RenderCollapsedState();
			end);
			Section.SetRender(Tab.Signal:GetValue());
			Tab.Signal:Connect(Section.SetRender);
			return CaseInsensitive(Section);
		end;
		function Tab:AddCustom(Config)
			if typeof(Config) == "function" then
				Config = {
					Build = Config,
				};
			end;
			Config = NeverloseUI:ProcessParams(Config , {
				Name = "Custom",
				Position = "center",
				Height = 120,
				Build = nil,
				Background = true,
				Title = true,
				Collapsible = false,
				FullPage = false,
				Scrolling = true,
				HideParentBackground = true,
				ScrollBarThickness = 3,
				Locked = false,
				TextLocked = "Locked",
				OnShow = nil,
				OnHide = nil,
			});
			if Config.FullPage == true then
				local Custom = {};
				local BaseZ = 10;
				local PageFrame = Instance.new("Frame");
				PageFrame.Name = NeverloseUI.RandomString();
				PageFrame.Parent = TabFrame;
				PageFrame.BackgroundTransparency = 1;
				PageFrame.BorderSizePixel = 0;
				PageFrame.ClipsDescendants = true;
				PageFrame.Position = UDim2.new(0, 0, 0, 0);
				PageFrame.Size = UDim2.new(1, 0, 1, 0);
				PageFrame.ZIndex = BaseZ - 1;
				local Container;
				if Config.Scrolling ~= false then
					Container = Instance.new("ScrollingFrame");
					Container.Active = true;
					Container.AutomaticCanvasSize = Enum.AutomaticSize.Y;
					Container.CanvasSize = UDim2.new(0, 0, 0, 0);
					Container.ScrollingDirection = Enum.ScrollingDirection.Y;
					Container.ScrollBarThickness = tonumber(Config.ScrollBarThickness) or 3;
					Container.ScrollBarImageColor3 = Color3.fromRGB(120, 125, 140);
					Container.ScrollBarImageTransparency = 0.4;
				else
					Container = Instance.new("Frame");
				end;
				Container.Name = NeverloseUI.RandomString();
				Container.Parent = PageFrame;
				Container.BackgroundTransparency = 1;
				Container.BorderSizePixel = 0;
				Container.ClipsDescendants = true;
				Container.Position = UDim2.new(0, 0, 0, 0);
				Container.Size = UDim2.new(1, 0, 1, 0);
				Container.ZIndex = BaseZ - 1;
				NeverloseUI:AttachLockMethods(Custom, PageFrame, Config);
				if FlowScroll then
					local HasSections = false;
					for _, Child in next, FlowScroll:GetChildren() do
						if Child:IsA("GuiObject") then
							HasSections = true;
							break;
						end;
					end;
					if not HasSections then
						FlowScroll.Visible = false;
					end;
				end;
				Tab.FullPage = Custom;
				Custom.FullPage = true;
				Custom.Root = PageFrame;
				Custom.Container = Container;
				Custom.Tab = Tab;
				Custom.ZIndex = BaseZ;
				local ZTrack = setmetatable({}, { __mode = "k" });
				local MaxRaw = math.max(1, tonumber(Config.MaxZIndex) or 20);
				local function TrackZ(Descendant)
					if not Descendant:IsA("GuiObject") or ZTrack[Descendant] then
						return;
					end;
					local Raw = Descendant.ZIndex;
					local Applying = false;
					local function Apply()
						Applying = true;
						Descendant.ZIndex = math.min(Raw, MaxRaw) + BaseZ - 1;
						Applying = false;
					end;
					local Conn = Descendant:GetPropertyChangedSignal("ZIndex"):Connect(function()
						if Applying then
							return;
						end;
						Raw = Descendant.ZIndex;
						Apply();
					end);
					ZTrack[Descendant] = { Conn = Conn, Raw = function() return Raw; end, Apply = Apply };
					Apply();
				end;
				NeverloseUI:AddSignal(Container.DescendantAdded:Connect(TrackZ));
				NeverloseUI:AddSignal(Container.DescendantRemoving:Connect(function(Descendant)
					local Info = ZTrack[Descendant];
					if Info then
						ZTrack[Descendant] = nil;
						Info.Conn:Disconnect();
						pcall(function()
							Descendant.ZIndex = Info.Raw();
						end);
					end;
				end));
				for _, Existing in next, Container:GetDescendants() do
					TrackZ(Existing);
				end;
				function Custom:GetTheme()
					return NeverloseUI:GetTheme();
				end;
				function Custom:BindTheme(Object, Map)
					return NeverloseUI:BindTheme(Object, Map);
				end;
				function Custom:SetMaxZIndex(Value)
					MaxRaw = math.max(1, tonumber(Value) or 20);
					for _, Info in next, ZTrack do
						pcall(Info.Apply);
					end;
					return Custom;
				end;
				function Custom:Create(ClassName, Properties, Parent)
					local Object = Instance.new(ClassName);
					for Key, Value in next, Properties or {} do
						Object[Key] = Value;
					end;
					Object.Parent = Parent or Container;
					return Object;
				end;
				function Custom:SetHeight()
					return Custom;
				end;
				function Custom:GetHeight()
					return Container.AbsoluteSize.Y;
				end;
				function Custom:Clear()
					for _, Child in next, Container:GetChildren() do
						Child:Destroy();
					end;
					return Custom;
				end;
				function Custom:SetVisible(value)
					PageFrame.Visible = value ~= false;
					return Custom;
				end;
				function Custom:ShowError(Message)
					local Old = Container:FindFirstChild("NeverloseCustomError");
					if Old then
						Old:Destroy();
					end;
					local ErrorLabel = Instance.new("TextLabel");
					ErrorLabel.Name = "NeverloseCustomError";
					ErrorLabel.BackgroundTransparency = 1;
					ErrorLabel.Position = UDim2.new(0, 6, 0, 6);
					ErrorLabel.Size = UDim2.new(1, -12, 1, -12);
					ErrorLabel.Font = Enum.Font.Code;
					ErrorLabel.TextSize = 11;
					ErrorLabel.TextColor3 = Color3.fromRGB(255, 90, 90);
					ErrorLabel.TextWrapped = true;
					ErrorLabel.TextXAlignment = Enum.TextXAlignment.Left;
					ErrorLabel.TextYAlignment = Enum.TextYAlignment.Top;
					ErrorLabel.Text = "Custom build error:\n" .. string.sub(tostring(Message), 1, 400);
					ErrorLabel.Parent = Container;
					return Custom;
				end;
				Custom.IsReady = false;
				local ReadyQueue = {};
				local function CheckReady()
					if Custom.IsReady then
						return;
					end;
					local Size = Container.AbsoluteSize;
					if Size.X > 0 and Size.Y > 0 then
						Custom.IsReady = true;
						local Queue = ReadyQueue;
						ReadyQueue = {};
						for _, Fn in ipairs(Queue) do
							task.spawn(Fn);
						end;
					end;
				end;
				NeverloseUI:AddSignal(Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(CheckReady));
				function Custom:OnReady(Fn)
					if Custom.IsReady then
						task.spawn(Fn, Container, Custom);
					else
						table.insert(ReadyQueue, function()
							Fn(Container, Custom);
						end);
					end;
					return Custom;
				end;
				CheckReady();
				local function RunBuild(Callback)
					local Ok, Result = NeverloseUI:FireCallback(Callback, Config.Name, Container, Custom);
					if Ok == false then
						Custom:ShowError(Result);
					end;
					return Ok;
				end;
				function Custom:Rebuild(Callback)
					Custom:Clear();
					RunBuild(Callback or Config.Build);
					return Custom;
				end;
				local function ApplyFullPageDecor()
					local Visible = Window.Signal:GetValue();
					local Hide = (Window.FullPageHideCount or 0) > 0 and Visible;
					local RightStroke = RightMenuFrame:FindFirstChildOfClass("UIStroke");
					NeverloseUI.PlayAnimate(RightMenuFrame , SlowyTween , {
						BackgroundTransparency = (Visible and not Hide) and 0.600 or 1
					});
					if RightStroke then
						NeverloseUI.PlayAnimate(RightStroke , SlowyTween , {
							Transparency = (Visible and not Hide) and 0.650 or 1
						});
					end;
				end;
				if not Window.FullPageDecorInit then
					Window.FullPageDecorInit = true;
					Window.FullPageHideCount = 0;
					Window.Signal:Connect(function()
						if Window.FullPageHideCount > 0 then
							task.defer(function()
								if Window.FullPageHideCount > 0 then
									local Visible = Window.Signal:GetValue();
									local RightStroke = RightMenuFrame:FindFirstChildOfClass("UIStroke");
									NeverloseUI.PlayAnimate(RightMenuFrame , SlowyTween , {
										BackgroundTransparency = 1
									});
									if RightStroke and Visible then
										NeverloseUI.PlayAnimate(RightStroke , SlowyTween , {
											Transparency = 1
										});
									end;
								end;
							end);
						end;
					end);
				end;
				local PageActive = false;
				local function OnTabToggle(value)
					value = value == true;
					if value == PageActive then
						return;
					end;
					PageActive = value;
					if Config.HideParentBackground ~= false then
						Window.FullPageHideCount = math.max(0, (Window.FullPageHideCount or 0) + (value and 1 or -1));
						ApplyFullPageDecor();
					end;
					if value then
						NeverloseUI:FireCallback(Config.OnShow, Config.Name, Container, Custom);
					else
						NeverloseUI:FireCallback(Config.OnHide, Config.Name, Container, Custom);
					end;
				end;
				Tab.Signal:Connect(OnTabToggle);
				OnTabToggle(Tab.Signal:GetValue());
				if type(Config.Build) == "function" then
					local Ok = RunBuild(Config.Build);
					if Ok == false and not Custom.IsReady then
						Custom:OnReady(function()
							Custom:Clear();
							RunBuild(Config.Build);
						end);
					end;
				end;
				return CaseInsensitive(Custom);
			end;
			local Section = Tab:AddSection({
				Name = Config.Title and tostring(Config.Name) or "",
				Position = Config.Position,
				Collapsible = Config.Collapsible,
			});
			return Section:AddCustom(Config);
		end;
		function Tab:AddTabbox(Config)
			if typeof(Config) ~= "table" then
				Config = {
					Name = Config,
				};
			end;
			Config = NeverloseUI:ProcessParams(Config , {
				Name = "TABBOX",
				Position = 'left',
				Side = nil,
				Locked = false,
				TextLocked = "Locked",
				Style = "Accordion",
				Open = false,
				OpenFirst = false,
			});
			local TabboxFrame = Instance.new("Frame")
			local TabboxLabel = Instance.new("TextLabel")
			local TabboxHolder = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local ButtonHolder = Instance.new("Frame")
			local ButtonLayout = Instance.new("UIListLayout")
			local Tabbox = {
				Tabs = {},
				ActiveTab = nil,
			};
			local Accordion = string.lower(tostring(Config.Style or "Accordion")) ~= "tabs";
			Tabbox.Accordion = Accordion;
			TabboxFrame.Name = NeverloseUI.RandomString();
			local TabboxPosition = (Config.Side == 1 and "left") or (Config.Side == 2 and "right") or string.lower(Config.Position);
			TabboxFrame.Parent = ResolveFlowParent(TabboxPosition)
			TabboxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabboxFrame.BackgroundTransparency = 1.000
			TabboxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabboxFrame.BorderSizePixel = 0
			TabboxFrame.ClipsDescendants = true
			TabboxFrame.Size = UDim2.new(1, -5, 0, 55)
			TabboxFrame.ZIndex = 9
			NeverloseUI:AttachLockMethods(Tabbox, TabboxFrame, Config);
			TabboxLabel.Name = NeverloseUI.RandomString();
			TabboxLabel.Parent = TabboxFrame
			TabboxLabel.AnchorPoint = Vector2.new(0.5, 0)
			TabboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabboxLabel.BackgroundTransparency = 1.000
			TabboxLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabboxLabel.BorderSizePixel = 0
			TabboxLabel.Position = UDim2.new(0.5, 0, 0, 0)
			TabboxLabel.Size = UDim2.new(1, -35, 0, 15)
			TabboxLabel.ZIndex = 9
			TabboxLabel.Font = Enum.Font.GothamMedium
			TabboxLabel.Text = Config.Name
			TabboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TabboxLabel.TextSize = 11.000
			TabboxLabel.TextTransparency = 0.500
			TabboxLabel.TextXAlignment = Enum.TextXAlignment.Left
			NeverloseUI:AddTextGradient(TabboxLabel);
			TabboxHolder.Name = NeverloseUI.RandomString();
			TabboxHolder.Parent = TabboxFrame
			TabboxHolder.AnchorPoint = Vector2.new(0.5, 0)
			TabboxHolder.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
			TabboxHolder.BackgroundTransparency = 0.500
			TabboxHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabboxHolder.BorderSizePixel = 0
			TabboxHolder.ClipsDescendants = true
			TabboxHolder.Position = UDim2.new(0.5, 0, 0, 20)
			TabboxHolder.Size = UDim2.new(1, -10, 1, -21)
			TabboxHolder.ZIndex = 9
			UIStroke.Transparency = 0.650
			UIStroke.Color = Color3.fromRGB(45, 48, 58)
			UIStroke.Parent = TabboxHolder
			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = TabboxHolder
			ButtonHolder.Name = NeverloseUI.RandomString();
			ButtonHolder.Parent = TabboxHolder
			ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonHolder.BackgroundTransparency = 1.000
			ButtonHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonHolder.BorderSizePixel = 0
			ButtonHolder.Position = UDim2.new(0, 5, 0, 5)
			ButtonHolder.Size = UDim2.new(1, -10, 0, 28)
			ButtonHolder.ZIndex = 10
			ButtonLayout.Parent = ButtonHolder
			ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
			ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ButtonLayout.Padding = UDim.new(0, 5)
			if Accordion then
				ButtonLayout.FillDirection = Enum.FillDirection.Vertical
				ButtonLayout.Padding = UDim.new(0, 4)
				ButtonHolder.Size = UDim2.new(1, -10, 1, -10)
				ButtonHolder.ClipsDescendants = true
			end
			local UpdateSize = LPH_NO_VIRTUALIZE(function()
				if Accordion then
					local total = 0;
					for i, T in ipairs(Tabbox.Tabs) do
						total += 32;
						if T.Expanded then
							total += T.Layout.AbsoluteContentSize.Y + 8;
						end;
						if i > 1 then
							total += 4;
						end;
					end;
					if total <= 0 then
						total = 32;
					end;
					NeverloseUI.PlayAnimate(TabboxFrame , VSlowTween , {
						Size = UDim2.new(1, -5, 0, total + 32)
					});
					return;
				end;
				local ActiveTab = Tabbox.ActiveTab;
				local height = 41;
				if ActiveTab and ActiveTab.Layout then
					height = ActiveTab.Layout.AbsoluteContentSize.Y + 41;
				end;
				if height <= 41 then
					height = 55;
				end;
				NeverloseUI.PlayAnimate(TabboxFrame , VSlowTween , {
					Size = UDim2.new(1, -5, 0, height + 19.5)
				})
			end);
			local UpdateParentRender = LPH_NO_VIRTUALIZE(function(value)
				if value then
					NeverloseUI.PlayAnimate(TabboxLabel,SlowyTween,{
						TextTransparency = 0.500
					})
					NeverloseUI.PlayAnimate(TabboxHolder,SlowyTween,{
						BackgroundTransparency = 0.500
					})
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.650
					})
				else
					NeverloseUI.PlayAnimate(TabboxLabel,SlowyTween,{
						TextTransparency = 1
					})
					NeverloseUI.PlayAnimate(TabboxHolder,SlowyTween,{
						BackgroundTransparency = 1
					})
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 1
					})
				end;
				for _,SubTab in ipairs(Tabbox.Tabs) do
					local Active = (Accordion and SubTab.Expanded == true) or (not Accordion and Tabbox.ActiveTab == SubTab);
					SubTab.Signal:SetValue(value and Active);
					SubTab.Root.Visible = Active;
					SubTab.RenderButton(value and Active);
				end;
			end);
			function Tabbox:AddTab(Name , IconName)
				local TabConfig = {};
				if typeof(Name) == "table" then
					TabConfig = Name;
					IconName = TabConfig.Icon or TabConfig.IconName or IconName;
					Name = TabConfig.Name or TabConfig.Title or "Tab";
				end;
				local SubTab = {
					Name = Name or "Tab",
					Icon = IconName or "folder",
					Signal = NeverloseUI:CreateSignal(false),
				};
				TabConfig.Locked = TabConfig.Locked == true;
				TabConfig.TextLocked = TabConfig.TextLocked or "Locked";
				local Button = Instance.new("Frame")
				local ButtonCorner = Instance.new("UICorner")
				local ButtonStroke = Instance.new("UIStroke")
				local Icon = Instance.new("ImageLabel")
				local Label = Instance.new("TextLabel")
				local Container = Instance.new("Frame")
				local Layout = Instance.new("UIListLayout")
				Button.Name = NeverloseUI.RandomString();
				Button.Parent = ButtonHolder
				Button.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
				Button.BackgroundTransparency = 1.000
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.ClipsDescendants = true
				Button.Size = UDim2.new(0, 0, 1, 0)
				Button.ZIndex = 11
				NeverloseUI:AttachLockMethods(SubTab, Button, TabConfig);
				ButtonCorner.CornerRadius = UDim.new(0, 5)
				ButtonCorner.Parent = Button
				ButtonStroke.Transparency = 1
				ButtonStroke.Color = Color3.fromRGB(45, 48, 58)
				ButtonStroke.Parent = Button
				Icon.Name = NeverloseUI.RandomString();
				Icon.Parent = Button
				Icon.AnchorPoint = Vector2.new(0, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(0, 7, 0.5, 0)
				Icon.Size = UDim2.new(0, 18, 0, 18)
				Icon.ZIndex = 12
				NeverloseUI:SetIconMode(Icon, SubTab.Icon)
				Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
				Icon.ImageTransparency = 0.500
				Icon.ScaleType = Enum.ScaleType.Fit
				Label.Name = NeverloseUI.RandomString();
				Label.Parent = Button
				Label.AnchorPoint = Vector2.new(0, 0.5)
				Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Label.BackgroundTransparency = 1.000
				Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label.BorderSizePixel = 0
				Label.Position = UDim2.new(0, 29, 0.5, 0)
				Label.Size = UDim2.new(1, -34, 0, 15)
				Label.ZIndex = 12
				Label.Font = Enum.Font.GothamMedium
				Label.Text = SubTab.Name
				Label.TextColor3 = Color3.fromRGB(255, 255, 255)
				Label.TextSize = 11.000
				Label.TextTransparency = 0.500
				Label.TextXAlignment = Enum.TextXAlignment.Left
				Label.TextTruncate = Enum.TextTruncate.AtEnd
				NeverloseUI:AddTextGradient(Label);
				Container.Name = NeverloseUI.RandomString();
				Container.Parent = TabboxHolder
				Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Container.BackgroundTransparency = 1.000
				Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Container.BorderSizePixel = 0
				Container.ClipsDescendants = true
				Container.Position = UDim2.new(0, 5, 0, 36)
				Container.Size = UDim2.new(1, -10, 1, -39)
				Container.Visible = false
				Container.ZIndex = 10
				Layout.Parent = Container
				Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				Layout.SortOrder = Enum.SortOrder.LayoutOrder
				SubTab.Root = Container;
				SubTab.Layout = Layout;
				SubTab.Button = Button;
				SubTab.Expanded = false;
				local Group = nil;
				local Arrow = nil;
				if Accordion then
					Group = Instance.new("Frame");
					Group.Name = NeverloseUI.RandomString();
					Group.Parent = ButtonHolder;
					Group.BackgroundTransparency = 1;
					Group.BorderSizePixel = 0;
					Group.ClipsDescendants = true;
					Group.Size = UDim2.new(1, 0, 0, 32);
					Group.ZIndex = 10;
					Group.LayoutOrder = #Tabbox.Tabs + 1;
					Button.Parent = Group;
					Button.Position = UDim2.new(0, 0, 0, 0);
					Button.Size = UDim2.new(1, 0, 0, 32);
					Button.BackgroundTransparency = 0.5;
					ButtonStroke.Transparency = 0.65;
					Container.Parent = Group;
					Container.Position = UDim2.new(0, 0, 0, 36);
					Container.Size = UDim2.new(1, 0, 0, 0);
					Label.Size = UDim2.new(1, -60, 0, 15);
					Arrow = Instance.new("ImageLabel");
					Arrow.Name = NeverloseUI.RandomString();
					Arrow.Parent = Button;
					Arrow.AnchorPoint = Vector2.new(1, 0.5);
					Arrow.BackgroundTransparency = 1;
					Arrow.BorderSizePixel = 0;
					Arrow.Position = UDim2.new(1, -9, 0.5, 0);
					Arrow.Size = UDim2.new(0, 14, 0, 14);
					Arrow.ZIndex = 12;
					Arrow.ImageColor3 = Color3.fromRGB(223, 223, 223);
					Arrow.ImageTransparency = 0.3;
					NeverloseUI:SetIconMode(Arrow, "chevron-large-right");
				else
					local widthScale = 1 / math.max(#Tabbox.Tabs + 1,1);
					for _,ExistingTab in ipairs(Tabbox.Tabs) do
						ExistingTab.Button.Size = UDim2.new(widthScale, -4, 1, 0);
					end;
					Button.Size = UDim2.new(widthScale, -4, 1, 0);
				end;
				local RenderButton = LPH_NO_VIRTUALIZE(function(active)
					if Accordion then
						local TabVisible = Tab.Signal:GetValue();
						local Open = SubTab.Expanded == true;
						NeverloseUI.PlayAnimate(Button,SlowyTween,{
							BackgroundTransparency = TabVisible and (Open and 0.15 or 0.5) or 1
						});
						NeverloseUI.PlayAnimate(ButtonStroke,SlowyTween,{
							Transparency = TabVisible and 0.65 or 1
						});
						NeverloseUI.PlayAnimate(Icon,SlowyTween,{
							ImageTransparency = TabVisible and (Open and 0 or 0.35) or 1,
							ImageColor3 = Open and NeverloseUI.AccentColor or Color3.fromRGB(223, 223, 223)
						});
						NeverloseUI.PlayAnimate(Label,SlowyTween,{
							TextTransparency = TabVisible and (Open and 0 or 0.2) or 1
						});
						if Arrow then
							NeverloseUI.PlayAnimate(Arrow,SlowyTween,{
								ImageTransparency = TabVisible and 0.3 or 1,
								Rotation = Open and 90 or 0
							});
						end;
						return;
					end;
					if active then
						NeverloseUI.PlayAnimate(Button,SlowyTween,{
							BackgroundTransparency = 0.150
						})
						NeverloseUI.PlayAnimate(ButtonStroke,SlowyTween,{
							Transparency = 0.650
						})
						NeverloseUI.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 0,
							TextColor3 = NeverloseUI.AccentColor
						})
						NeverloseUI.PlayAnimate(Label,SlowyTween,{
							TextTransparency = 0
						})
					else
						NeverloseUI.PlayAnimate(Button,SlowyTween,{
							BackgroundTransparency = 1
						})
						NeverloseUI.PlayAnimate(ButtonStroke,SlowyTween,{
							Transparency = 1
						})
						NeverloseUI.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = Tab.Signal:GetValue() and 0.500 or 1,
							TextColor3 = Color3.fromRGB(223, 223, 223)
						})
						NeverloseUI.PlayAnimate(Label,SlowyTween,{
							TextTransparency = Tab.Signal:GetValue() and 0.500 or 1
						})
					end;
				end);
				local ApplyGroupSize = function()
					if not Accordion then
						return;
					end;
					local Content = Layout.AbsoluteContentSize.Y;
					local Open = SubTab.Expanded == true;
					NeverloseUI.PlayAnimate(Container , VSlowTween , {
						Size = UDim2.new(1, 0, 0, Open and Content or 0)
					});
					NeverloseUI.PlayAnimate(Group , VSlowTween , {
						Size = UDim2.new(1, 0, 0, Open and (Content + 40) or 32)
					});
				end;
				function SubTab:Show()
					if Tabbox.GetLocked and Tabbox:GetLocked() then
						return SubTab;
					end;
					if SubTab.GetLocked and SubTab:GetLocked() then
						return SubTab;
					end;
					Tabbox.ActiveTab = SubTab;
					if Accordion then
						SubTab.Expanded = true;
						Container.Visible = true;
						SubTab.Signal:SetValue(Tab.Signal:GetValue());
						RenderButton(true);
						ApplyGroupSize();
						UpdateSize();
						return SubTab;
					end;
					for _,Item in ipairs(Tabbox.Tabs) do
						local isActive = Item == SubTab and Tab.Signal:GetValue();
						Item.Root.Visible = Item == SubTab;
						Item.Signal:SetValue(isActive);
						Item.RenderButton(Item == SubTab and Tab.Signal:GetValue());
					end;
					UpdateSize();
				end;
				function SubTab:Hide()
					if Accordion then
						SubTab.Expanded = false;
						if Tabbox.ActiveTab == SubTab then
							Tabbox.ActiveTab = nil;
						end;
						SubTab.Signal:SetValue(false);
						RenderButton(false);
						ApplyGroupSize();
						UpdateSize();
						task.delay(0.55, function()
							if not SubTab.Expanded then
								Container.Visible = false;
							end;
						end);
						return;
					end;
					Container.Visible = false;
					SubTab.Signal:SetValue(false);
					RenderButton(false);
				end;
				function SubTab:Toggle()
					if SubTab.Expanded then
						SubTab:Hide();
					else
						SubTab:Show();
					end;
					return SubTab;
				end;
				SubTab.RenderButton = RenderButton;
				NeverloseUI:AddSignal(Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
					if Accordion then
						if SubTab.Expanded then
							ApplyGroupSize();
							UpdateSize();
						end;
					elseif Tabbox.ActiveTab == SubTab then
						UpdateSize();
					end;
				end)))
				local Input = NeverloseUI:CreateInput(Button , LPH_NO_VIRTUALIZE(function()
					if Tabbox.GetLocked and Tabbox:GetLocked() then
						return;
					end;
					if SubTab.GetLocked and SubTab:GetLocked() then
						return;
					end;
					if Accordion then
						SubTab:Toggle();
					else
						SubTab:Show();
					end;
				end));
				NeverloseUI:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					if Accordion then
						if not SubTab.Expanded and Tab.Signal:GetValue() then
							NeverloseUI.PlayAnimate(Button,SlowyTween,{
								BackgroundTransparency = 0.3
							})
						end;
					elseif Tabbox.ActiveTab ~= SubTab and Tab.Signal:GetValue() then
						NeverloseUI.PlayAnimate(Button,SlowyTween,{
							BackgroundTransparency = 0.650
						})
					end;
				end)))
				NeverloseUI:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					if Accordion then
						RenderButton(SubTab.Expanded);
					elseif Tabbox.ActiveTab ~= SubTab then
						RenderButton(false);
					end;
				end)))
				local Handler = NeverloseUI:RegisiterItem(Container , SubTab.Signal);
				SubTab.Handler = Handler;
				function Handler:Select()
					if SubTab.GetLocked and SubTab:GetLocked() then
						return Handler;
					end;
					SubTab:Show();
					return Handler;
				end;
				function Handler:SetLocked(value)
					if SubTab.SetLocked then
						SubTab:SetLocked(value);
					end;
					if value == true and ((Accordion and SubTab.Expanded) or Tabbox.ActiveTab == SubTab) then
						SubTab:Hide();
						if not Accordion then
							for _,Item in ipairs(Tabbox.Tabs) do
								if Item ~= SubTab and (not Item.GetLocked or not Item:GetLocked()) then
									Item:Show();
									break;
								end;
							end;
						end;
					end;
					return Handler;
				end;
				function Handler:GetLocked()
					return SubTab.GetLocked and SubTab:GetLocked() or false;
				end;
				function Handler:SetTextLocked(text)
					if SubTab.SetTextLocked then
						SubTab:SetTextLocked(text);
					end;
					return Handler;
				end;
				function Handler:SetIcon(icon)
					SubTab.Icon = icon or SubTab.Icon;
					NeverloseUI:SetIconMode(Icon, SubTab.Icon);
					return Handler;
				end;
				function Handler:SetText(text)
					Tabbox.Tabs[SubTab.Name] = nil;
					SubTab.Name = text or SubTab.Name;
					Tabbox.Tabs[SubTab.Name] = SubTab;
					Label.Text = SubTab.Name;
					return Handler;
				end;
				table.insert(Tabbox.Tabs,SubTab);
				Tabbox.Tabs[SubTab.Name] = SubTab;
				if Accordion then
					if TabConfig.Open == true or Config.Open == true or (Config.OpenFirst == true and #Tabbox.Tabs == 1) then
						SubTab:Show();
					else
						SubTab:Hide();
					end;
				elseif not Tabbox.ActiveTab then
					SubTab:Show();
				else
					SubTab:Hide();
				end;
				UpdateSize();
				return CaseInsensitive(Handler);
			end;
			function Tabbox:Select(Name)
				local SubTab = Tabbox.Tabs[Name];
				if SubTab then
					SubTab:Show();
				end;
				return Tabbox;
			end;
			function Tabbox:SetVisible(value)
				TabboxFrame.Visible = value;
			end;
			UpdateParentRender(Tab.Signal:GetValue());
			Tab.Signal:Connect(UpdateParentRender);
			UpdateSize();
			return CaseInsensitive(Tabbox);
		end;
		function Tab:AddLeftTabbox(Name)
			return Tab:AddTabbox({
				Name = Name,
				Position = "left",
			});
		end;
		function Tab:AddRightTabbox(Name)
			return Tab:AddTabbox({
				Name = Name,
				Position = "right",
			});
		end;
		function Tab:AddCenterTabbox(Name)
			return Tab:AddTabbox({
				Name = Name,
				Position = "center",
			});
		end;
		return CaseInsensitive(Tab);
	end;
	function Window:_InitConfig()
		local ConfigSignal = NeverloseUI:CreateSignal(false);
		local ConfigLib = {
			Signals = {},
		};
		local ConfigMenu = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local UIStroke = Instance.new("UIStroke")
		local InputFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local TextInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")
		local LoadConfig = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local UICorner_3 = Instance.new("UICorner")
		local UICorner_4 = Instance.new("UICorner")
		local shadow = NeverloseUI:CreateShadow(ConfigMenu);
		ConfigLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ConfigMenu.Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)
				NeverloseUI.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 0.035,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 95)
				})
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				})
				NeverloseUI.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 0.65
				})
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})
				NeverloseUI.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 0
				})
				NeverloseUI.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 0.350
				})
				NeverloseUI.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.350
				})
				NeverloseUI.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 180
				})
				shadow:Render(true)
			else
				NeverloseUI.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 0
				})
				NeverloseUI.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)
				})
				NeverloseUI.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})
				NeverloseUI.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})
				NeverloseUI.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 1
				})
				NeverloseUI.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 1
				})
				NeverloseUI.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})
				shadow:Render(false)
			end;
		end);
		NeverloseUI:AddSignal(ConfigMenu:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigMenu.BackgroundTransparency > 0.9 then
				ConfigMenu.Visible = false;
				UIListLayout.Parent = nil;
				ConfigMenu.Parent = nil;
			else
				ConfigMenu.Visible = true;
				UIListLayout.Parent = ConfigMenu
				if NeverloseUI.Global3DRenderMode then
					ConfigMenu.Parent = NeverloseUI.GlobalSurfaceGui;
				else
					ConfigMenu.Parent = NeverloseUI.ScreenGui;
				end;
			end
		end)))
		ConfigMenu.Name = NeverloseUI.RandomString();
		ConfigMenu.Parent = NeverloseUI.ScreenGui;
		ConfigMenu.AnchorPoint = Vector2.new(0.5, 0)
		ConfigMenu.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		ConfigMenu.BackgroundTransparency = 0.035
		ConfigMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigMenu.BorderSizePixel = 0
		ConfigMenu.ClipsDescendants = true
		ConfigMenu.Position = UDim2.new(255,255,255,255)
		ConfigMenu.Size = UDim2.new(0, 220,0, 110)
		ConfigMenu.ZIndex = 151
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ConfigMenu
		UIListLayout.Parent = ConfigMenu
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ConfigMenu
		InputFrame.Name = NeverloseUI.RandomString();
		InputFrame.Parent = ConfigMenu
		InputFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		InputFrame.BackgroundTransparency = 1.000
		InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputFrame.BorderSizePixel = 0
		InputFrame.Size = UDim2.new(1, 0, 0, 30)
		InputFrame.ZIndex = 154
		BasedLabel.Name = NeverloseUI.RandomString();
		BasedLabel.Parent = InputFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = 154
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = "Config"
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
		LineFrame.Name = NeverloseUI.RandomString();
		LineFrame.Parent = InputFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = 154
		BasedHandler.Name = NeverloseUI.RandomString();
		BasedHandler.Parent = InputFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = 154
		UIListLayout_2.Parent = BasedHandler
		UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout_2.Padding = UDim.new(0, 5)
		NeverloseUI:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			if #ConfigLib.Signals <= 0 then
				NeverloseUI.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 0);
				})
			else
				NeverloseUI.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 5);
				})
			end;
		end)));
		TextInput.Name = NeverloseUI.RandomString();
		TextInput.Parent = BasedHandler
		TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, 100, 0, 18)
		TextInput.ZIndex = 154
		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = TextInput
		UIStroke_2.Transparency = 0.650
		UIStroke_2.Color = Color3.fromRGB(45, 48, 58)
		UIStroke_2.Parent = TextInput
		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = 154
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = "Config Name ..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 11.000
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		LoadConfig.Name = NeverloseUI.RandomString();
		LoadConfig.Parent = BasedHandler
		LoadConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
		LoadConfig.BackgroundTransparency = 1.000
		LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LoadConfig.BorderSizePixel = 0
		LoadConfig.ClipsDescendants = true
		LoadConfig.Size = UDim2.new(0, 20, 0, 18)
		LoadConfig.ZIndex = 153
		Icon.Name = NeverloseUI.RandomString();
		Icon.Parent = LoadConfig
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = 153
		NeverloseUI:SetIconMode(Icon, "plus-large")
		Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		Icon.ImageTransparency = 0.350
		Icon.ScaleType = Enum.ScaleType.Fit
		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = LoadConfig
		UICorner_4.CornerRadius = UDim.new(0, 10)
		UICorner_4.Parent = InputFrame
		local OpenButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		OpenButton.Name = NeverloseUI.RandomString();
		OpenButton.Parent = ConfigFrame
		OpenButton.AnchorPoint = Vector2.new(0, 0.5)
		OpenButton.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		OpenButton.BackgroundTransparency = 1.000
		OpenButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.BorderSizePixel = 0
		OpenButton.Position = UDim2.new(0, 31, 0.5, 0)
		OpenButton.Size = UDim2.new(1, -31, 1, 0)
		OpenButton.ZIndex = 10
		OpenButton.Font = Enum.Font.SourceSans
		OpenButton.Text = ""
		OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.TextSize = 14.000
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = OpenButton
		ConfigLib.SetRender(false);
		ConfigSignal:Connect(ConfigLib.SetRender);
		ConfigLib.UnsafeThread = nil;
		ConfigLib.SelectedConfig = Window.ConfigAutoSaveFile or "Default";
		ConfigName.Text = ConfigLib.SelectedConfig;
		local UpdateSize = LPH_NO_VIRTUALIZE(function()
			local size = TextService:GetTextSize(ConfigName.Text , ConfigName.TextSize,ConfigName.Font,Vector2.new(math.huge,math.huge));
			NeverloseUI.PlayAnimate(ConfigFrame,SlowyTween , {
				Size = UDim2.fromOffset(size.X + 75, 30)
			});
		end);
		UpdateSize();
		function ConfigLib:GetData(performance)
			local ikc = {};
			local cd = 0;
			for Flag,v in next , NeverloseUI.Flags do
				if v and v.GetValue then
					local data = v:GetValue();
					if typeof(data) == 'Color3' then
						table.insert(ikc,{
							Idx = Flag,
							Value = data:ToHex(),
						});
					else
						table.insert(ikc,{
							Idx = Flag,
							Value = data
						});
					end;
				end;
				if performance then
					if cd % 35 == 1 then
						task.wait()
					end
				end;
				cd += 1;
			end;
			local JsonData = HttpService:JSONEncode(ikc);
			if Window.ConfigEncrypted then
				return NeverloseUI.Base64Encode(Encryption.new(JsonData));
			end;
			return JsonData;
		end;
		function ConfigLib:WriteConfig(ConfigNameStr, Overwrite, performance)
			ConfigNameStr = tostring(ConfigNameStr or ConfigLib.SelectedConfig or Window.ConfigAutoSaveFile or "Default");
			ConfigNameStr = string.sub(ConfigNameStr, 1, 24);
			if not ConfigNameStr:byte() or ConfigNameStr:find('/',1,true) or ConfigNameStr:find('\\',1,true) then
				Logging.new("folder","Invalid config name!",3.5);
				return false;
			end;
			if not isfolder(Window.ConfigFolder) then
				makefolder(Window.ConfigFolder);
			end;
			local path = Window.ConfigFolder..'/'..ConfigNameStr;
			local Exists = isfile(path);
			local ShouldOverwrite = Overwrite;
			if ShouldOverwrite == nil then
				ShouldOverwrite = Window.ConfigOverwrite;
			end;
			if Exists and not ShouldOverwrite then
				Logging.new("folder","Config "..tostring(ConfigNameStr).." already exists!",3.5);
				return false;
			end;
			writefile(path,ConfigLib:GetData(performance));
			ConfigLib.SelectedConfig = ConfigNameStr;
			ConfigName.Text = ConfigNameStr;
			UpdateSize();
			Logging.new("folder",(Exists and "Overwritten " or "Created ")..tostring(ConfigNameStr),3.5);
			return true;
		end;
		function ConfigLib:RewriteSelectedAsJson()
			local WasEncrypted = Window.ConfigEncrypted;
			Window.ConfigEncrypted = false;
			local Saved = ConfigLib:WriteConfig(ConfigLib.SelectedConfig or Window.ConfigAutoSaveFile or "Default", true);
			Window.ConfigEncrypted = WasEncrypted;
			return Saved;
		end;
		function ConfigLib:DecodeData(data)
			local success, decoded = pcall(function()
				return HttpService:JSONDecode(data);
			end);
			if success and typeof(decoded) == "table" then
				return decoded;
			end;
			success, decoded = pcall(function()
				return HttpService:JSONDecode(Encryption.reverse(NeverloseUI.Base64Decode(data)));
			end);
			if success and typeof(decoded) == "table" then
				return decoded;
			end;
			return {};
		end;
		function ConfigLib:LoadData(data)
			local coded = ConfigLib:DecodeData(data);
			for i,v in next , coded do
				if v.Idx then
					if NeverloseUI.Flags[v.Idx] then
						task.spawn(function()
							NeverloseUI.Flags[v.Idx]:SetValue(v.Value)
						end)
					else
						NeverloseUI.PendingFlagValues[v.Idx] = v.Value;
					end;
				end;
			end;
		end;
		function ConfigLib:RefreshConfig()
			if not isfolder(Window.ConfigFolder) then
				makefolder(Window.ConfigFolder);
			end;
			if not isfile(Window.ConfigFolder..'/'..ConfigLib.SelectedConfig) then
				writefile(Window.ConfigFolder..'/'..ConfigLib.SelectedConfig,ConfigLib:GetData());
			end;
			for i,v in next,ConfigMenu:GetChildren() do
				if v:GetAttribute('ConfigItem') then
					v:Destroy();
				end;
			end;
			for i,v in next , ConfigLib.Signals do
				v:Disconnect();
			end
			table.clear(ConfigLib.Signals);
			local ConfigList = {};
			for i,v in next , listfiles(Window.ConfigFolder) do
				local name = string.sub(v , #Window.ConfigFolder + 2);
				table.insert(ConfigList , name)
			end;
			for i,ConfigNameStr in next , ConfigList do
				local ConfigItemFrame = Instance.new("Frame")
				local BasedHandler = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local DeleteConfig = Instance.new("Frame")
				local Icon = Instance.new("ImageLabel")
				local UICorner = Instance.new("UICorner")
				local OverwriteConfig = Instance.new("Frame")
				local Icon_3 = Instance.new("ImageLabel")
				local UICorner_4 = Instance.new("UICorner")
				local LoadConfig = Instance.new("Frame")
				local Icon_2 = Instance.new("ImageLabel")
				local UICorner_2 = Instance.new("UICorner")
				local UICorner_3 = Instance.new("UICorner")
				local BasedLabel = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")
				ConfigItemFrame.Name = NeverloseUI.RandomString();
				ConfigItemFrame.Parent = ConfigMenu
				ConfigItemFrame.BackgroundColor3 = Color3.fromRGB(21, 20, 27)
				ConfigItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ConfigItemFrame.BorderSizePixel = 0
				ConfigItemFrame.Size = UDim2.new(1, -10, 0, 30)
				ConfigItemFrame.ZIndex = 153
				ConfigItemFrame:SetAttribute('ConfigItem',true);
				BasedHandler.Name = NeverloseUI.RandomString();
				BasedHandler.Parent = ConfigItemFrame
				BasedHandler.AnchorPoint = Vector2.new(1, 0)
				BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedHandler.BackgroundTransparency = 1.000
				BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedHandler.BorderSizePixel = 0
				BasedHandler.Position = UDim2.new(1, -11, 0, 2)
				BasedHandler.Size = UDim2.new(1, -20, 0, 25)
				BasedHandler.ZIndex = 153
				UIListLayout.Parent = BasedHandler
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 5)
				DeleteConfig.Name = NeverloseUI.RandomString();
				DeleteConfig.Parent = BasedHandler
				DeleteConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				DeleteConfig.BackgroundTransparency = 1.000
				DeleteConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DeleteConfig.BorderSizePixel = 0
				DeleteConfig.ClipsDescendants = true
				DeleteConfig.Size = UDim2.new(0, 20, 0, 18)
				DeleteConfig.ZIndex = 153
				Icon.Name = NeverloseUI.RandomString();
				Icon.Parent = DeleteConfig
				Icon.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon.Size = UDim2.new(1, 0, 1, 0)
				Icon.ZIndex = 153
				NeverloseUI:SetIconMode(Icon, "trash-can")
				Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
				Icon.ImageTransparency = 0.400
				Icon.ScaleType = Enum.ScaleType.Fit
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = DeleteConfig
				OverwriteConfig.Name = NeverloseUI.RandomString();
				OverwriteConfig.Parent = BasedHandler
				OverwriteConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				OverwriteConfig.BackgroundTransparency = 1.000
				OverwriteConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				OverwriteConfig.BorderSizePixel = 0
				OverwriteConfig.ClipsDescendants = true
				OverwriteConfig.Size = UDim2.new(0, 20, 0, 18)
				OverwriteConfig.ZIndex = 153
				Icon_3.Name = NeverloseUI.RandomString();
				Icon_3.Parent = OverwriteConfig
				Icon_3.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_3.BackgroundTransparency = 1.000
				Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_3.BorderSizePixel = 0
				Icon_3.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon_3.Size = UDim2.new(1, 0, 1, 0)
				Icon_3.ZIndex = 153
				NeverloseUI:SetIconMode(Icon_3, "pencil-square")
				Icon_3.ImageColor3 = Color3.fromRGB(223, 223, 223)
				Icon_3.ImageTransparency = 0.400
				Icon_3.ScaleType = Enum.ScaleType.Fit
				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = OverwriteConfig
				LoadConfig.Name = NeverloseUI.RandomString();
				LoadConfig.Parent = BasedHandler
				LoadConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				LoadConfig.BackgroundTransparency = 1.000
				LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LoadConfig.BorderSizePixel = 0
				LoadConfig.ClipsDescendants = true
				LoadConfig.Size = UDim2.new(0, 20, 0, 18)
				LoadConfig.ZIndex = 153
				Icon_2.Name = NeverloseUI.RandomString();
				Icon_2.Parent = LoadConfig
				Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_2.BackgroundTransparency = 1.000
				Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_2.BorderSizePixel = 0
				Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon_2.Size = UDim2.new(1, 0, 1, 0)
				Icon_2.ZIndex = 153
				NeverloseUI:SetIconMode(Icon_2, "arrow-right-from-portrait-rectangle")
				Icon_2.ImageColor3 = Color3.fromRGB(223, 223, 223)
				Icon_2.ImageTransparency = 0.400
				Icon_2.ScaleType = Enum.ScaleType.Fit
				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = LoadConfig
				UICorner_3.CornerRadius = UDim.new(0, 5)
				UICorner_3.Parent = ConfigItemFrame
				BasedLabel.Name = NeverloseUI.RandomString();
				BasedLabel.Parent = ConfigItemFrame
				BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.BackgroundTransparency = 1.000
				BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedLabel.BorderSizePixel = 0
				BasedLabel.Position = UDim2.new(0, 11, 0, 7)
				BasedLabel.Size = UDim2.new(0, 1, 0, 15)
				BasedLabel.ZIndex = 153
				BasedLabel.Font = Enum.Font.GothamMedium
				BasedLabel.Text = ConfigNameStr
				BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.TextSize = 13.000
				BasedLabel.TextTransparency = 0.200
				BasedLabel.TextXAlignment = Enum.TextXAlignment.Left
				UIStroke.Transparency = 0.500
				UIStroke.Color = Color3.fromRGB(45, 48, 58)
				UIStroke.Parent = ConfigItemFrame
				local Render = LPH_NO_VIRTUALIZE(function(rst)
					if rst then
						NeverloseUI.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 0
						})
						NeverloseUI.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 0.400
						})
						NeverloseUI.PlayAnimate(Icon_3,SlowyTween,{
							TextTransparency = 0.400
						})
						NeverloseUI.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 0.400
						})
						NeverloseUI.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 0.200
						})
						NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 0.500
						})
					else
						NeverloseUI.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 1
						})
						NeverloseUI.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 1
						})
						NeverloseUI.PlayAnimate(Icon_3,SlowyTween,{
							TextTransparency = 1
						})
						NeverloseUI.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 1
						})
						NeverloseUI.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 1
						})
						NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 1
						})
					end;
				end)
				Render(ConfigSignal:GetValue());
				table.insert(ConfigLib.Signals , ConfigSignal:Connect(Render));
				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.25
					})
				end)));
				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.500
					})
				end)));
				local deleter,signal = NeverloseUI:CreateInput(DeleteConfig,function()
					if ConfigNameStr == "Default" or ConfigNameStr == Window.ConfigAutoSaveFile then
						Logging.new("trash-can","You can't delete default config!",3.5)
						return;
					end;
					delfile(Window.ConfigFolder..'/'..ConfigNameStr);
					UpdateSize();
					ConfigLib:RefreshConfig();
					Logging.new("trash-can",'Deleted '..tostring(ConfigNameStr),3.5)
				end);
				local _,overwrite_signal = NeverloseUI:CreateInput(OverwriteConfig,function()
					if ConfigLib:WriteConfig(ConfigNameStr, true) then
						ConfigLib.SelectedConfig = ConfigNameStr;
						ConfigName.Text = ConfigNameStr;
						UpdateSize();
						ConfigLib:RefreshConfig();
					end;
				end);
				local _,load_signal = NeverloseUI:CreateInput(LoadConfig,function()
					local path = Window.ConfigFolder..'/'..ConfigNameStr;
					if isfile(path) then
						local data = readfile(path);
						ConfigLib:LoadData(data);
						ConfigLib.SelectedConfig = ConfigNameStr;
						ConfigName.Text = ConfigNameStr;
						UpdateSize();
						ConfigLib:RefreshConfig();
						Logging.new("folder",'Loaded '..tostring(ConfigNameStr),3.5)
					end
				end);
				table.insert(ConfigLib.Signals , signal);
				table.insert(ConfigLib.Signals , overwrite_signal);
				table.insert(ConfigLib.Signals , load_signal);
				table.insert(ConfigLib.Signals , deleter.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = Color3.fromRGB(223, 125, 125)
					})
				end)))
				table.insert(ConfigLib.Signals , deleter.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))
				table.insert(ConfigLib.Signals , OverwriteConfig.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(Icon_3,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = NeverloseUI.AccentColor
					})
				end)))
				table.insert(ConfigLib.Signals , OverwriteConfig.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(Icon_3,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))
				table.insert(ConfigLib.Signals , LoadConfig.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = NeverloseUI.AccentColor
					})
				end)))
				table.insert(ConfigLib.Signals , LoadConfig.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverloseUI.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))
			end;
			table.clear(ConfigList);
		end;
		task.delay(1,function()
			local ConfigNameStr = ConfigLib.SelectedConfig or Window.ConfigAutoSaveFile or "Default";
			local path = Window.ConfigFolder..'/'..ConfigNameStr;
			if Window.ConfigAutoLoad then
				local Stored = NeverloseUI:ReadAutoSave(Window.AutoSaveKey);
				if Stored then
					ConfigLib:LoadData(Stored);
					Logging.new("folder","Auto loaded "..tostring(Window.AutoSaveKey),3.5);
				elseif isfile(path) then
					local data = readfile(path);
					ConfigLib:LoadData(data);
					ConfigLib.SelectedConfig = ConfigNameStr;
					ConfigName.Text = ConfigNameStr;
					UpdateSize();
					ConfigLib:RefreshConfig();
					Logging.new("folder","Loaded "..tostring(ConfigNameStr),3.5);
				end;
			end;
			if not Window.ConfigSaveWindowState and not Window.Destroyed and not Window.Minimizing and not Window.Minimized then
				Window.Signal:SetValue(true);
				Window:SetRender(true);
				if Window._MenuIcon then
					Window._MenuIcon:OnWindowToggle(true);
				end;
			end;
			task.spawn(function()
				local Last = nil;
				while not Window.Destroyed do
					task.wait(5.75);
					if Window.ConfigAutoSave then
						local Data = ConfigLib:GetData(true);
						if Data ~= Last and NeverloseUI:WriteAutoSave(Window.AutoSaveKey, Data) then
							Last = Data;
						end;
					end;
				end;
			end);
		end);
		local hover_write = NeverloseUI:CreateInput(ConfigIcon,function()
			if ConfigLib:WriteConfig(ConfigLib.SelectedConfig or Window.ConfigAutoSaveFile or "Default", true) then
				ConfigLib:RefreshConfig();
			end;
		end);
		NeverloseUI:AddSignal(hover_write.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.1
			})
		end)));
		NeverloseUI:AddSignal(hover_write.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.25
			})
		end)));
		local mv = NeverloseUI:CreateInput(LoadConfig , function()
			local cfg_name = TextBox.Text;
			if cfg_name and cfg_name:byte() and not cfg_name:find('/',1,true) and not cfg_name:find('\\',1,true) then
				cfg_name = string.sub(cfg_name , 1 , 24);
				if ConfigLib:WriteConfig(cfg_name, Window.ConfigOverwrite) then
					TextBox.Text = "";
					ConfigLib:RefreshConfig();
				end;
			end;
		end);
		NeverloseUI:AddSignal(mv.MouseEnter:Connect(function()
			NeverloseUI.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.1
			})
		end))
		NeverloseUI:AddSignal(mv.MouseLeave:Connect(function()
			NeverloseUI.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.35
			})
		end))
		ConfigLib:RefreshConfig();
		OpenButton.MouseButton1Click:Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigLib.UnsafeThread then
				ConfigLib.UnsafeThread:Disconnect();
				ConfigLib.UnsafeThread = nil;
			end;
			ConfigSignal:SetValue(true);
			ConfigLib.UnsafeThread = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverloseUI:IsMouseOverFrame(ConfigMenu) then
						if ConfigLib.UnsafeThread then
							ConfigLib.UnsafeThread:Disconnect();
							ConfigLib.UnsafeThread = nil;
						end;
						ConfigSignal:SetValue(false);
					end;
				end;
			end)
		end));
		return ConfigLib;
	end;
	if Window.ConfigEnabled then
		Window.ConfigManager = Window:_InitConfig();
	else
		ConfigFrame.Visible = false;
	end;
	local SettingsTab = Window:AddTab({
		Name = "Settings",
		Icon = "gear",
		Type = "Double",
		Internal = true,
		LayoutOrder = 10000,
	});
	Window.SettingsTab = SettingsTab;
	NeverloseUI:ApplyUISettings(Window);
	local InterfaceSection = SettingsTab:AddSection({
		Name = "Interface",
		Position = "Right",
		Icon = "paint-brush",
	});
	local WindowSection = SettingsTab:AddSection({
		Name = "Window",
		Position = "Left",
		Icon = "frame-corners",
	});
	local UserSettings = InterfaceSection;
	Window.UserSettings = UserSettings;
	if Window.ConfigEnabled then
		WindowSection:AddLabel("Auto Save"):AddToggle({
			Default = Window.ConfigAutoSave,
			Callback = function(value)
				Window.ConfigAutoSave = value;
				NeverloseUI:SetUISetting("AutoSave", value == true);
			end,
		});
	end;
	WindowSection:AddLabel("Menu Scale"):AddDropdown({
		Default = NeverloseUI:GetUISetting("MenuScale", "Mobile"),
		Values = { "Large", "Default", "Mobile", "Small", "Compact" },
		Callback = function(value)
			if NeverloseUI.Scales[value] then
				Window:SetSize(NeverloseUI.Scales[value]);
				NeverloseUI:SetUISetting("MenuScale", value);
				Logging.new("crop","Scale changed to "..tostring(value),5);
			end;
		end,
	});
	WindowSection:AddLabel("Notification Position");
	WindowSection:AddCustom({
		Name = "Notification Position",
		Height = 112,
		Background = true,
		Build = function(Container, Custom)
			NeverloseUI:BuildNotificationPicker(Container, Custom, Window);
		end,
	});
	WindowSection:AddLabel("Menu Keybind"):AddKeybind({
		Default = tostring(Window.Keybind or "RightControl"),
		Callback = EmptyFunction,
		ChangedCallback = function(_, key)
			Window.Keybind = tostring(key);
			NeverloseUI:SetUISetting("Keybind", tostring(key));
		end,
	});
	WindowSection:AddLabel("Background Image"):AddTextInput({
		Default = Window.BackgroundImage or "",
		Placeholder = "Roblox Asset ID",
		Callback = function(...)
			local Value = (select(select("#", ...), ...));
			Window:SetBackground(Value);
			NeverloseUI:SetUISetting("BackgroundImage", tostring(Value or ""));
		end,
	});
	WindowSection:AddLabel("Background Opacity"):AddSlider({
		Default = math.floor((Window.BackgroundImageOpacity or 0.5) * 100),
		Min = 5,
		Max = 100,
		Rounding = 0,
		Type = "%",
		Size = 100,
		Callback = function(...)
			local Value = (select(select("#", ...), ...)) / 100;
			Window:SetBackgroundOpacity(Value);
			NeverloseUI:SetUISetting("BackgroundOpacity", Value);
		end,
	});
	WindowSection:AddLabel("Drag Smoothness"):AddSlider({
		Default = math.floor(tonumber(NeverloseUI.DragSmoothness) or 0),
		Min = 0,
		Max = 100,
		Rounding = 0,
		Type = "%",
		Size = 100,
		Callback = function(...)
			local Value = (select(select("#", ...), ...));
			NeverloseUI.DragSmoothness = math.clamp(tonumber(Value) or 0, 0, 100);
			NeverloseUI:SetUISetting("DragSmoothness", NeverloseUI.DragSmoothness);
		end,
	});
	if NeverloseUI:IsSmallScreen() then
		WindowSection:AddLabel("Mobile UI Size"):AddSlider({
			Default = math.floor((tonumber(NeverloseUI.MobileScale) or 0.72) * 100),
			Min = 40,
			Max = 100,
			Rounding = 0,
			Type = "%",
			Size = 100,
			Callback = function(...)
				local Value = (select(select("#", ...), ...)) / 100;
				NeverloseUI.MobileScale = math.clamp(Value, 0.4, 1);
				NeverloseUI:SetUISetting("MobileScale", NeverloseUI.MobileScale);
				Window:UpdateFitScale(true);
			end,
		});
	end;
	WindowSection:AddButton({
		Name = "Minimize Window",
		Icon = "minus",
		Callback = function()
			Window:Minimize();
		end,
	});
	function Window:SetInterface(Settings)
		NeverloseUI:SetInterface(Settings);
		return Window;
	end;
	function Window:SetTilt(Settings)
		NeverloseUI:SetTilt(Settings);
		return Window;
	end;
	function Window:SetBorder(Settings)
		NeverloseUI:SetBorder(Settings);
		return Window;
	end;
	function Window:SetDragSmoothness(Value)
		NeverloseUI.DragSmoothness = math.clamp(tonumber(Value) or 0, 0, 100);
		NeverloseUI:SetUISetting("DragSmoothness", NeverloseUI.DragSmoothness);
		return Window;
	end;
	function Window:SetMobileScale(Value)
		NeverloseUI.MobileScale = math.clamp(tonumber(Value) or 0.72, 0.4, 1);
		NeverloseUI:SetUISetting("MobileScale", NeverloseUI.MobileScale);
		Window:UpdateFitScale(true);
		return Window;
	end;
	do
		local ScriptInterface = (type(Config.Interface) == "table" and Config.Interface) or {};
		if Config.AccentColor ~= nil and ScriptInterface.AccentColor == nil then
			ScriptInterface.AccentColor = Config.AccentColor;
		end;
		NeverloseUI:SetInterface(ScriptInterface);
		do
			local SavedPosition = NeverloseUI:GetUISetting("NotifyPosition");
			local ConfigPosition = Config.NotifyPosition or Config.NotificationPosition;
			if SavedPosition ~= nil then
				NeverloseUI.Notifier.SetPosition(SavedPosition, false);
			elseif ConfigPosition ~= nil then
				NeverloseUI.Notifier.SetPosition(ConfigPosition, false);
			end;
		end;
		if Config.Border ~= nil then
			NeverloseUI:SetBorder(type(Config.Border) == "table" and Config.Border or { Enabled = Config.Border == true });
		end;
		if Config.Tilt ~= nil then
			NeverloseUI:SetTilt(Config.Tilt);
		end;
		if Config.DragSmoothness ~= nil and NeverloseUI:GetUISetting("DragSmoothness") == nil then
			NeverloseUI.DragSmoothness = math.clamp(tonumber(Config.DragSmoothness) or 0, 0, 100);
		end;
		if Config.MobileScale ~= nil and NeverloseUI:GetUISetting("MobileScale") == nil then
			NeverloseUI.MobileScale = math.clamp(tonumber(Config.MobileScale) or 0.72, 0.4, 1);
			Window:UpdateFitScale(false);
		end;
	end;
	function Window:AddToggle(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Toggle",
			Default = false,
			Flag = nil,
			Callback = EmptyFunction,
		});
		return Window.UserSettings:AddLabel(Config.Name):AddToggle(Config);
	end;
	function Window:AddButton(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Button",
			Icon = "chevron-large-left",
			Callback = EmptyFunction,
			ToolTip = nil,
		});
		return Window.UserSettings:AddButton(Config);
	end;
	function Window:SetAccount(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Profile = NeverloseUI.UserProfile,
			Username = LocalPlayer.Name,
			DisplayName = LocalPlayer.DisplayName,
		});
		Window.Username = Config.Username;
		Window.DisplayName = Config.DisplayName;
		Window.Profile = Config.Profile;
		AccountName.Text = tostring(Config.DisplayName);
		ExpireLabel.Text = "@"..tostring(Config.Username);
		AccountProfile.Image = Config.Profile or "";
	end;
	function Window:SetSize(newsize)
		Window.Size = newsize;
		Window:UpdateFitScale(true);
		if Window.Signal:GetValue() then
			NeverloseUI.PlayAnimate(WindowFrame , VSlowTween , {
				Size = Window:GetCurrentSize()
			})
		end
	end;
	function Window:SetConfigOverwrite(value)
		Window.ConfigOverwrite = value == true;
		return Window;
	end;
	function Window:SaveConfig(ConfigNameStr, Overwrite)
		if not Window.ConfigManager or not Window.ConfigManager.WriteConfig then
			return false;
		end;
		return Window.ConfigManager:WriteConfig(ConfigNameStr or Window.ConfigManager.SelectedConfig or Window.ConfigAutoSaveFile or "Default", Overwrite);
	end;
	function Window:LoadConfig(ConfigNameStr)
		if not Window.ConfigManager then
			return false;
		end;
		ConfigNameStr = tostring(ConfigNameStr or Window.ConfigManager.SelectedConfig or Window.ConfigAutoSaveFile or "Default");
		local path = Window.ConfigFolder..'/'..ConfigNameStr;
		if not isfile(path) then
			return false;
		end;
		Window.ConfigManager:LoadData(readfile(path));
		Window.ConfigManager.SelectedConfig = ConfigNameStr;
		ConfigName.Text = ConfigNameStr;
		return true;
	end;
	function Window:RewriteConfigAsJson()
		if not Window.ConfigManager or not Window.ConfigManager.RewriteSelectedAsJson then
			return false;
		end;
		return Window.ConfigManager:RewriteSelectedAsJson();
	end;
	function Window:OnDestroy(fn)
		if type(fn) == "function" then
			table.insert(Window.OnDestroyCallbacks, fn);
		end;
		return Window;
	end;
	function Window:SafeCallback(fn, Context, ...)
		return NeverloseUI:FireCallback(fn, Context, ...);
	end;
	function Window:InputDialog(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Title = "Input",
			Content = "",
			Name = "Value",
			Placeholder = "",
			Default = "",
			Inputs = nil,
			ConfirmText = "Confirm",
			CancelText = "Cancel",
			Callback = EmptyFunction,
		});
		local Inputs = Config.Inputs;
		if typeof(Inputs) ~= "table" then
			Inputs = {
				{
					Name = Config.Name,
					Placeholder = Config.Placeholder,
					Default = Config.Default,
					Numeric = Config.Numeric,
				},
			};
		end;
		local Dialog = {
			Closed = false,
			Values = {},
			Boxes = {},
		};
		local Overlay = Instance.new("Frame")
		local Panel = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Title = Instance.new("TextLabel")
		local Content = Instance.new("TextLabel")
		local InputHolder = Instance.new("Frame")
		local InputLayout = Instance.new("UIListLayout")
		local ButtonHolder = Instance.new("Frame")
		local ButtonLayout = Instance.new("UIListLayout")
		local Shadow = NeverloseUI:CreateShadow(Panel);
		local PanelHeight = 148 + (#Inputs * 42);
		Overlay.Name = NeverloseUI.RandomString();
		Overlay.Parent = WindowFrame
		Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Overlay.BackgroundTransparency = 1
		Overlay.BorderSizePixel = 0
		Overlay.Size = UDim2.fromScale(1, 1)
		Overlay.ZIndex = 190
		Overlay.Active = true
		Panel.Name = NeverloseUI.RandomString();
		Panel.Parent = Overlay
		Panel.AnchorPoint = Vector2.new(0.5, 0.5)
		Panel.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		Panel.BackgroundTransparency = 1
		Panel.BorderSizePixel = 0
		Panel.ClipsDescendants = true
		Panel.Position = UDim2.fromScale(0.5, 0.5)
		Panel.Size = UDim2.new(0, 345, 0, PanelHeight - 15)
		Panel.ZIndex = 191
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = Panel
		UIStroke.Transparency = 1
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Panel
		Title.Name = NeverloseUI.RandomString();
		Title.Parent = Panel
		Title.BackgroundTransparency = 1
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 18, 0, 15)
		Title.Size = UDim2.new(1, -36, 0, 20)
		Title.ZIndex = 192
		Title.Font = Enum.Font.GothamBold
		Title.Text = Config.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 15
		Title.TextTransparency = 1
		Title.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(Title);
		Content.Name = NeverloseUI.RandomString();
		Content.Parent = Panel
		Content.BackgroundTransparency = 1
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 18, 0, 43)
		Content.Size = UDim2.new(1, -36, 0, Config.Content == "" and 0 or 34)
		Content.ZIndex = 192
		Content.Font = Enum.Font.GothamMedium
		Content.Text = Config.Content
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 13
		Content.TextTransparency = 1
		Content.TextWrapped = true
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Content.TextYAlignment = Enum.TextYAlignment.Top
		InputHolder.Name = NeverloseUI.RandomString();
		InputHolder.Parent = Panel
		InputHolder.BackgroundTransparency = 1
		InputHolder.BorderSizePixel = 0
		InputHolder.Position = UDim2.new(0, 18, 0, Config.Content == "" and 48 or 82)
		InputHolder.Size = UDim2.new(1, -36, 0, #Inputs * 42)
		InputHolder.ZIndex = 192
		InputLayout.Parent = InputHolder
		InputLayout.SortOrder = Enum.SortOrder.LayoutOrder
		InputLayout.Padding = UDim.new(0, 8)
		local function ReadValues()
			local Values = {};
			for Index,Box in ipairs(Dialog.Boxes) do
				local InputConfig = Inputs[Index] or {};
				local Key = InputConfig.Flag or InputConfig.Key or InputConfig.Name or tostring(Index);
				Values[Key] = Box.Text;
			end;
			Dialog.Values = Values;
			if #Dialog.Boxes == 1 then
				return Dialog.Boxes[1].Text, Values;
			end;
			return Values;
		end;
		for Index,InputConfig in ipairs(Inputs) do
			if typeof(InputConfig) ~= "table" then
				InputConfig = {
					Name = tostring(InputConfig or "Value"),
				};
				Inputs[Index] = InputConfig;
			end;
			InputConfig = NeverloseUI:ProcessParams(InputConfig , {
				Name = "Value",
				Placeholder = "",
				Default = "",
				Numeric = false,
			});
			local Row = Instance.new("Frame")
			local Label = Instance.new("TextLabel")
			local BoxFrame = Instance.new("Frame")
			local BoxCorner = Instance.new("UICorner")
			local BoxStroke = Instance.new("UIStroke")
			local Box = Instance.new("TextBox")
			Row.Name = NeverloseUI.RandomString();
			Row.Parent = InputHolder
			Row.BackgroundTransparency = 1
			Row.BorderSizePixel = 0
			Row.Size = UDim2.new(1, 0, 0, 34)
			Row.ZIndex = 192
			Row.LayoutOrder = Index
			Label.Name = NeverloseUI.RandomString();
			Label.Parent = Row
			Label.BackgroundTransparency = 1
			Label.BorderSizePixel = 0
			Label.Position = UDim2.new(0, 0, 0, 0)
			Label.Size = UDim2.new(0.42, -6, 1, 0)
			Label.ZIndex = 193
			Label.Font = Enum.Font.GothamMedium
			Label.Text = tostring(InputConfig.Name)
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextSize = 12
			Label.TextTransparency = 1
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.TextTruncate = Enum.TextTruncate.AtEnd
			BoxFrame.Name = NeverloseUI.RandomString();
			BoxFrame.Parent = Row
			BoxFrame.AnchorPoint = Vector2.new(1, 0.5)
			BoxFrame.BackgroundColor3 = Color3.fromRGB(13, 17, 22)
			BoxFrame.BackgroundTransparency = 1
			BoxFrame.BorderSizePixel = 0
			BoxFrame.Position = UDim2.new(1, 0, 0.5, 0)
			BoxFrame.Size = UDim2.new(0.58, 0, 0, 30)
			BoxFrame.ZIndex = 193
			BoxCorner.CornerRadius = UDim.new(0, 5)
			BoxCorner.Parent = BoxFrame
			BoxStroke.Color = Color3.fromRGB(45, 48, 58)
			BoxStroke.Transparency = 1
			BoxStroke.Parent = BoxFrame
			Box.Name = NeverloseUI.RandomString();
			Box.Parent = BoxFrame
			Box.BackgroundTransparency = 1
			Box.BorderSizePixel = 0
			Box.ClearTextOnFocus = false
			Box.Position = UDim2.new(0, 8, 0, 0)
			Box.Size = UDim2.new(1, -16, 1, 0)
			Box.ZIndex = 194
			Box.Font = Enum.Font.GothamMedium
			Box.Text = tostring(InputConfig.Default or "")
			Box.PlaceholderText = tostring(InputConfig.Placeholder or "")
			Box.TextColor3 = Color3.fromRGB(255, 255, 255)
			Box.PlaceholderColor3 = Color3.fromRGB(140, 140, 155)
			Box.TextSize = 12
			Box.TextTransparency = 1
			Box.TextXAlignment = Enum.TextXAlignment.Left
			if InputConfig.Numeric then
				NeverloseUI:AddSignal(Box:GetPropertyChangedSignal("Text"):Connect(function()
					Box.Text = Box.Text:gsub("[^%d%.%-]", "");
				end))
			end;
			table.insert(Dialog.Boxes, Box);
			NeverloseUI.PlayAnimate(Label, SlowyTween, { TextTransparency = 0.250 })
			NeverloseUI.PlayAnimate(BoxFrame, SlowyTween, { BackgroundTransparency = 0.150 })
			NeverloseUI.PlayAnimate(BoxStroke, SlowyTween, { Transparency = 0.700 })
			NeverloseUI.PlayAnimate(Box, SlowyTween, { TextTransparency = 0.150 })
		end;
		ButtonHolder.Name = NeverloseUI.RandomString();
		ButtonHolder.Parent = Panel
		ButtonHolder.AnchorPoint = Vector2.new(1, 1)
		ButtonHolder.BackgroundTransparency = 1
		ButtonHolder.BorderSizePixel = 0
		ButtonHolder.Position = UDim2.new(1, -14, 1, -14)
		ButtonHolder.Size = UDim2.new(1, -28, 0, 30)
		ButtonHolder.ZIndex = 192
		ButtonLayout.Parent = ButtonHolder
		ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
		ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ButtonLayout.Padding = UDim.new(0, 8)
		function Dialog:Close(Result)
			if Dialog.Closed then
				return Result;
			end;
			Dialog.Closed = true;
			NeverloseUI.PlayAnimate(Overlay, SlowyTween, { BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(Panel, SlowyTween, { BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(UIStroke, SlowyTween, { Transparency = 1 })
			NeverloseUI.PlayAnimate(Title, SlowyTween, { TextTransparency = 1 })
			NeverloseUI.PlayAnimate(Content, SlowyTween, { TextTransparency = 1 })
			Shadow:Render(false);
			task.delay(0.18, function()
				if Overlay.Parent then
					Overlay:Destroy();
				end;
			end);
			NeverloseUI:FireCallback(Config.Callback, Config.Title, Result, Dialog.Values);
			return Result;
		end;
		local function AddDialogButton(Text, Primary, Callback)
			local Button = Instance.new("Frame")
			local ButtonCorner = Instance.new("UICorner")
			local ButtonStroke = Instance.new("UIStroke")
			local ButtonLabel = Instance.new("TextLabel")
			Button.Name = NeverloseUI.RandomString();
			Button.Parent = ButtonHolder
			Button.BackgroundColor3 = Primary and NeverloseUI.AccentColor or Color3.fromRGB(26, 28, 36)
			Button.BackgroundTransparency = 1
			Button.BorderSizePixel = 0
			Button.ClipsDescendants = true
			Button.Size = UDim2.new(0, math.max(78, TextService:GetTextSize(tostring(Text), 12, Enum.Font.GothamMedium, Vector2.new(math.huge, math.huge)).X + 28), 0, 28)
			Button.ZIndex = 193
			ButtonCorner.CornerRadius = UDim.new(0, 5)
			ButtonCorner.Parent = Button
			ButtonStroke.Transparency = 1
			ButtonStroke.Color = Primary and NeverloseUI.AccentColor or Color3.fromRGB(45, 48, 58)
			ButtonStroke.Parent = Button
			ButtonLabel.Name = NeverloseUI.RandomString();
			ButtonLabel.Parent = Button
			ButtonLabel.BackgroundTransparency = 1
			ButtonLabel.BorderSizePixel = 0
			ButtonLabel.Size = UDim2.fromScale(1, 1)
			ButtonLabel.ZIndex = 194
			ButtonLabel.Font = Enum.Font.GothamMedium
			ButtonLabel.Text = Text
			ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonLabel.TextSize = 12
			ButtonLabel.TextTransparency = 1
			local Input = NeverloseUI:CreateInput(Button, Callback);
			NeverloseUI:AddSignal(Input.MouseEnter:Connect(function()
				NeverloseUI.PlayAnimate(Button, SlowyTween, { BackgroundTransparency = Primary and 0 or 0.100 })
			end))
			NeverloseUI:AddSignal(Input.MouseLeave:Connect(function()
				NeverloseUI.PlayAnimate(Button, SlowyTween, { BackgroundTransparency = Primary and 0.100 or 0.250 })
			end))
			NeverloseUI.PlayAnimate(Button, SlowyTween, { BackgroundTransparency = Primary and 0.100 or 0.250 })
			NeverloseUI.PlayAnimate(ButtonStroke, SlowyTween, { Transparency = Primary and 1 or 0.650 })
			NeverloseUI.PlayAnimate(ButtonLabel, SlowyTween, { TextTransparency = 0 })
		end;
		AddDialogButton(Config.CancelText, false, function()
			Dialog:Close(nil);
		end);
		AddDialogButton(Config.ConfirmText, true, function()
			Dialog:Close(ReadValues());
		end);
		NeverloseUI.PlayAnimate(Overlay, SlowyTween, { BackgroundTransparency = 0.350 })
		NeverloseUI.PlayAnimate(Panel, VSlowTween, { BackgroundTransparency = 0.035, Size = UDim2.new(0, 360, 0, PanelHeight) })
		NeverloseUI.PlayAnimate(UIStroke, SlowyTween, { Transparency = 0.650 })
		NeverloseUI.PlayAnimate(Title, SlowyTween, { TextTransparency = 0 })
		NeverloseUI.PlayAnimate(Content, SlowyTween, { TextTransparency = 0.250 })
		Shadow:Render(true);
		task.defer(function()
			if Dialog.Boxes[1] then
				Dialog.Boxes[1]:CaptureFocus();
			end;
		end);
		function Dialog:GetValue()
			return ReadValues();
		end;
		function Dialog:SetValue(Value, Key)
			if Key == nil and Dialog.Boxes[1] then
				Dialog.Boxes[1].Text = tostring(Value or "");
				return Dialog;
			end;
			for Index,InputConfig in ipairs(Inputs) do
				local Name = InputConfig.Flag or InputConfig.Key or InputConfig.Name or tostring(Index);
				if tostring(Name) == tostring(Key) and Dialog.Boxes[Index] then
					Dialog.Boxes[Index].Text = tostring(Value or "");
				end;
			end;
			return Dialog;
		end;
		return CaseInsensitive(Dialog);
	end;
	function Window:Dialog(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Title = "Dialog",
			Content = "",
			Icon = "lucide:message-square",
			Buttons = {},
			Callback = EmptyFunction,
		});
		local Dialog = {
			Closed = false,
		};
		local Overlay = Instance.new("Frame")
		local Panel = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local AccentBar = Instance.new("Frame")
		local AccentCorner = Instance.new("UICorner")
		local IconHolder = Instance.new("Frame")
		local IconCorner = Instance.new("UICorner")
		local IconStroke = Instance.new("UIStroke")
		local DialogIcon = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")
		local Content = Instance.new("TextLabel")
		local Divider = Instance.new("Frame")
		local ButtonHolder = Instance.new("Frame")
		local ButtonLayout = Instance.new("UIListLayout")
		local ContentHeight = math.clamp(TextService:GetTextSize(tostring(Config.Content or ""), 13, Enum.Font.GothamMedium, Vector2.new(310, math.huge)).Y + 4, 38, 76);
		local PanelHeight = math.max(188, 132 + ContentHeight);
		local PanelClosedSize = UDim2.new(0, 365, 0, PanelHeight - 18);
		local PanelOpenSize = UDim2.new(0, 392, 0, PanelHeight);
		Overlay.Name = NeverloseUI.RandomString();
		Overlay.Parent = WindowFrame
		Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Overlay.BackgroundTransparency = 1
		Overlay.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Overlay.BorderSizePixel = 0
		Overlay.Size = UDim2.fromScale(1, 1)
		Overlay.ZIndex = 180
		Overlay.Active = true
		Panel.Name = NeverloseUI.RandomString();
		Panel.Parent = Overlay
		Panel.AnchorPoint = Vector2.new(0.5, 0.5)
		Panel.BackgroundColor3 = Color3.fromRGB(13, 17, 22)
		Panel.BackgroundTransparency = 1
		Panel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Panel.BorderSizePixel = 0
		Panel.ClipsDescendants = true
		Panel.Position = UDim2.fromScale(0.5, 0.5)
		Panel.Size = PanelClosedSize
		Panel.ZIndex = 181
		UICorner.CornerRadius = UDim.new(0, 12)
		UICorner.Parent = Panel
		UIStroke.Transparency = 1
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Panel
		local Shadow = NeverloseUI:CreateShadow(Panel);
		AccentBar.Name = NeverloseUI.RandomString();
		AccentBar.Parent = Panel
		AccentBar.BackgroundColor3 = NeverloseUI.AccentColor
		AccentBar.BackgroundTransparency = 1
		AccentBar.BorderSizePixel = 0
		AccentBar.Position = UDim2.fromOffset(0, 0)
		AccentBar.Size = UDim2.new(1, 0, 0, 3)
		AccentBar.ZIndex = 182
		AccentCorner.CornerRadius = UDim.new(0, 12)
		AccentCorner.Parent = AccentBar
		IconHolder.Name = NeverloseUI.RandomString();
		IconHolder.Parent = Panel
		IconHolder.BackgroundColor3 = NeverloseUI.AccentColor
		IconHolder.BackgroundTransparency = 1
		IconHolder.BorderSizePixel = 0
		IconHolder.Position = UDim2.fromOffset(18, 18)
		IconHolder.Size = UDim2.fromOffset(34, 34)
		IconHolder.ZIndex = 182
		IconCorner.CornerRadius = UDim.new(0, 8)
		IconCorner.Parent = IconHolder
		IconStroke.Color = NeverloseUI.AccentColor
		IconStroke.Transparency = 1
		IconStroke.Parent = IconHolder
		DialogIcon.Name = NeverloseUI.RandomString();
		DialogIcon.Parent = IconHolder
		DialogIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		DialogIcon.BackgroundTransparency = 1
		DialogIcon.BorderSizePixel = 0
		DialogIcon.Position = UDim2.fromScale(0.5, 0.5)
		DialogIcon.Size = UDim2.fromOffset(18, 18)
		DialogIcon.ZIndex = 183
		DialogIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		DialogIcon.ImageTransparency = 1
		NeverloseUI:SetIconMode(DialogIcon, Config.Icon)
		Title.Name = NeverloseUI.RandomString();
		Title.Parent = Panel
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 64, 0, 18)
		Title.Size = UDim2.new(1, -82, 0, 21)
		Title.ZIndex = 183
		Title.Font = Enum.Font.GothamBold
		Title.Text = Config.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 16
		Title.TextTransparency = 1
		Title.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(Title);
		Content.Name = NeverloseUI.RandomString();
		Content.Parent = Panel
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 64, 0, 43)
		Content.Size = UDim2.new(1, -82, 0, ContentHeight)
		Content.ZIndex = 183
		Content.Font = Enum.Font.GothamMedium
		Content.Text = Config.Content
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 13
		Content.TextTransparency = 1
		Content.TextWrapped = true
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Content.TextYAlignment = Enum.TextYAlignment.Top
		Divider.Name = NeverloseUI.RandomString();
		Divider.Parent = Panel
		Divider.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		Divider.BackgroundTransparency = 1
		Divider.BorderSizePixel = 0
		Divider.Position = UDim2.new(0, 14, 1, -54)
		Divider.Size = UDim2.new(1, -28, 0, 1)
		Divider.ZIndex = 182
		ButtonHolder.Name = NeverloseUI.RandomString();
		ButtonHolder.Parent = Panel
		ButtonHolder.AnchorPoint = Vector2.new(1, 1)
		ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonHolder.BackgroundTransparency = 1
		ButtonHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonHolder.BorderSizePixel = 0
		ButtonHolder.Position = UDim2.new(1, -16, 1, -14)
		ButtonHolder.Size = UDim2.new(1, -32, 0, 32)
		ButtonHolder.ZIndex = 182
		ButtonLayout.Parent = ButtonHolder
		ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
		ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ButtonLayout.Padding = UDim.new(0, 8)
		function Dialog:Close(Result)
			if Dialog.Closed then
				return Result;
			end;
			Dialog.Closed = true;
			NeverloseUI.PlayAnimate(Overlay,SlowyTween,{
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(Panel,SlowyTween,{
				BackgroundTransparency = 1,
				Size = PanelClosedSize
			})
			NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(AccentBar,SlowyTween,{
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(IconHolder,SlowyTween,{
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(IconStroke,SlowyTween,{
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(DialogIcon,SlowyTween,{
				ImageTransparency = 1
			})
			NeverloseUI.PlayAnimate(Title,SlowyTween,{
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(Content,SlowyTween,{
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(Divider,SlowyTween,{
				BackgroundTransparency = 1
			})
			Shadow:Render(false);
			task.delay(0.18,function()
				Overlay:Destroy();
			end);
			NeverloseUI:FireCallback(Config.Callback, Config.Title, Result);
			return Result;
		end;
		if #Config.Buttons <= 0 then
			Config.Buttons = {
				{
					Text = "OK",
					Primary = true,
				},
			};
		end;
		for Index,ButtonConfig in ipairs(Config.Buttons) do
			ButtonConfig = NeverloseUI:ProcessParams(ButtonConfig , {
				Text = "Button",
				Primary = false,
				Callback = EmptyFunction,
			});
			local Button = Instance.new("Frame")
			local ButtonCorner = Instance.new("UICorner")
			local ButtonStroke = Instance.new("UIStroke")
			local ButtonLabel = Instance.new("TextLabel")
			Button.Name = NeverloseUI.RandomString();
			Button.Parent = ButtonHolder
			Button.BackgroundColor3 = ButtonConfig.Primary and NeverloseUI.AccentColor or Color3.fromRGB(26, 28, 36)
			Button.BackgroundTransparency = 1
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.ClipsDescendants = true
			Button.Size = UDim2.new(0, math.max(78, TextService:GetTextSize(tostring(ButtonConfig.Text), 12, Enum.Font.GothamBold, Vector2.new(math.huge, math.huge)).X + 32), 0, 32)
			Button.ZIndex = 183
			Button.LayoutOrder = Index
			ButtonCorner.CornerRadius = UDim.new(0, 7)
			ButtonCorner.Parent = Button
			ButtonStroke.Transparency = 1
			ButtonStroke.Color = ButtonConfig.Primary and NeverloseUI.AccentColor or Color3.fromRGB(45, 48, 58)
			ButtonStroke.Parent = Button
			ButtonLabel.Name = NeverloseUI.RandomString();
			ButtonLabel.Parent = Button
			ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonLabel.BackgroundTransparency = 1
			ButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonLabel.BorderSizePixel = 0
			ButtonLabel.Size = UDim2.fromScale(1, 1)
			ButtonLabel.ZIndex = 184
			ButtonLabel.Font = ButtonConfig.Primary and Enum.Font.GothamBold or Enum.Font.GothamMedium
			ButtonLabel.Text = ButtonConfig.Text
			ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonLabel.TextSize = 12
			ButtonLabel.TextTransparency = 1
			local Input = NeverloseUI:CreateInput(Button , LPH_NO_VIRTUALIZE(function()
				local Result = ButtonConfig.ReturnValue;
				if Result == nil then
					Result = ButtonConfig.Text;
				end;
				NeverloseUI:FireCallback(ButtonConfig.Callback, ButtonConfig.Text, Result);
				Dialog:Close(Result);
			end));
			NeverloseUI:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
				NeverloseUI.PlayAnimate(Button,SlowyTween,{
					BackgroundTransparency = ButtonConfig.Primary and 0 or 0.080
				})
			end)))
			NeverloseUI:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
				NeverloseUI.PlayAnimate(Button,SlowyTween,{
					BackgroundTransparency = ButtonConfig.Primary and 0.100 or 0.250
				})
			end)))
			NeverloseUI.PlayAnimate(Button,SlowyTween,{
				BackgroundTransparency = ButtonConfig.Primary and 0.100 or 0.250
			})
			NeverloseUI.PlayAnimate(ButtonStroke,SlowyTween,{
				Transparency = ButtonConfig.Primary and 1 or 0.650
			})
			NeverloseUI.PlayAnimate(ButtonLabel,SlowyTween,{
				TextTransparency = 0
			})
		end;
		NeverloseUI.PlayAnimate(Overlay,SlowyTween,{
			BackgroundTransparency = 0.280
		})
		NeverloseUI.PlayAnimate(Panel,VSlowTween,{
			BackgroundTransparency = 0.025,
			Size = PanelOpenSize
		})
		NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{
			Transparency = 0.650
		})
		NeverloseUI.PlayAnimate(AccentBar,SlowyTween,{
			BackgroundTransparency = 0
		})
		NeverloseUI.PlayAnimate(IconHolder,SlowyTween,{
			BackgroundTransparency = 0.820
		})
		NeverloseUI.PlayAnimate(IconStroke,SlowyTween,{
			Transparency = 0.350
		})
		NeverloseUI.PlayAnimate(DialogIcon,SlowyTween,{
			ImageTransparency = 0
		})
		NeverloseUI.PlayAnimate(Title,SlowyTween,{
			TextTransparency = 0
		})
		NeverloseUI.PlayAnimate(Content,SlowyTween,{
			TextTransparency = 0.250
		})
		NeverloseUI.PlayAnimate(Divider,SlowyTween,{
			BackgroundTransparency = 0.720
		})
		Shadow:Render(true);
		return CaseInsensitive(Dialog);
	end;
	function Window:ProgressDialog(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Title = "Progress",
			Content = "",
			Value = 0,
			Max = 100,
			Type = "%",
			Cancelable = false,
			CancelText = "Cancel",
			AutoClose = false,
			Callback = EmptyFunction,
		});
		local Dialog = {
			Closed = false,
		};
		local Overlay = Instance.new("Frame")
		local Panel = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Title = Instance.new("TextLabel")
		local Content = Instance.new("TextLabel")
		local ValueLabel = Instance.new("TextLabel")
		local BarBack = Instance.new("Frame")
		local BarBackCorner = Instance.new("UICorner")
		local BarFill = Instance.new("Frame")
		local BarFillCorner = Instance.new("UICorner")
		local CancelButton = Instance.new("Frame")
		local CancelCorner = Instance.new("UICorner")
		local CancelStroke = Instance.new("UIStroke")
		local CancelLabel = Instance.new("TextLabel")
		Overlay.Name = NeverloseUI.RandomString();
		Overlay.Parent = WindowFrame
		Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Overlay.BackgroundTransparency = 1
		Overlay.BorderSizePixel = 0
		Overlay.Size = UDim2.fromScale(1, 1)
		Overlay.ZIndex = 180
		Overlay.Active = true
		Panel.Name = NeverloseUI.RandomString();
		Panel.Parent = Overlay
		Panel.AnchorPoint = Vector2.new(0.5, 0.5)
		Panel.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		Panel.BackgroundTransparency = 1
		Panel.BorderSizePixel = 0
		Panel.ClipsDescendants = true
		Panel.Position = UDim2.fromScale(0.5, 0.5)
		Panel.Size = UDim2.new(0, 335, 0, Config.Cancelable and 150 or 125)
		Panel.ZIndex = 181
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = Panel
		UIStroke.Transparency = 1
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Panel
		local Shadow = NeverloseUI:CreateShadow(Panel);
		Title.Name = NeverloseUI.RandomString();
		Title.Parent = Panel
		Title.BackgroundTransparency = 1
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 18, 0, 15)
		Title.Size = UDim2.new(1, -36, 0, 20)
		Title.ZIndex = 182
		Title.Font = Enum.Font.GothamBold
		Title.Text = tostring(Config.Title)
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 15
		Title.TextTransparency = 1
		Title.TextXAlignment = Enum.TextXAlignment.Left
		NeverloseUI:AddTextGradient(Title);
		Content.Name = NeverloseUI.RandomString();
		Content.Parent = Panel
		Content.BackgroundTransparency = 1
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 18, 0, 43)
		Content.Size = UDim2.new(1, -36, 0, 32)
		Content.ZIndex = 182
		Content.Font = Enum.Font.GothamMedium
		Content.Text = tostring(Config.Content)
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 13
		Content.TextTransparency = 1
		Content.TextWrapped = true
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Content.TextYAlignment = Enum.TextYAlignment.Top
		ValueLabel.Name = NeverloseUI.RandomString();
		ValueLabel.Parent = Panel
		ValueLabel.BackgroundTransparency = 1
		ValueLabel.BorderSizePixel = 0
		ValueLabel.Position = UDim2.new(1, -88, 0, 80)
		ValueLabel.Size = UDim2.new(0, 70, 0, 16)
		ValueLabel.ZIndex = 182
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 12
		ValueLabel.TextTransparency = 1
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		BarBack.Name = NeverloseUI.RandomString();
		BarBack.Parent = Panel
		BarBack.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		BarBack.BackgroundTransparency = 1
		BarBack.BorderSizePixel = 0
		BarBack.Position = UDim2.new(0, 18, 0, 84)
		BarBack.Size = UDim2.new(1, -112, 0, 9)
		BarBack.ZIndex = 182
		BarBackCorner.CornerRadius = UDim.new(1, 0)
		BarBackCorner.Parent = BarBack
		BarFill.Name = NeverloseUI.RandomString();
		BarFill.Parent = BarBack
		BarFill.BackgroundColor3 = NeverloseUI.AccentColor
		BarFill.BackgroundTransparency = 1
		BarFill.BorderSizePixel = 0
		BarFill.Size = UDim2.fromScale(0, 1)
		BarFill.ZIndex = 183
		BarFillCorner.CornerRadius = UDim.new(1, 0)
		BarFillCorner.Parent = BarFill
		CancelButton.Name = NeverloseUI.RandomString();
		CancelButton.Parent = Panel
		CancelButton.AnchorPoint = Vector2.new(1, 1)
		CancelButton.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		CancelButton.BackgroundTransparency = 1
		CancelButton.BorderSizePixel = 0
		CancelButton.ClipsDescendants = true
		CancelButton.Position = UDim2.new(1, -14, 1, -14)
		CancelButton.Size = UDim2.new(0, 86, 0, 28)
		CancelButton.Visible = Config.Cancelable == true
		CancelButton.ZIndex = 182
		CancelCorner.CornerRadius = UDim.new(0, 5)
		CancelCorner.Parent = CancelButton
		CancelStroke.Transparency = 1
		CancelStroke.Color = Color3.fromRGB(45, 48, 58)
		CancelStroke.Parent = CancelButton
		CancelLabel.Name = NeverloseUI.RandomString();
		CancelLabel.Parent = CancelButton
		CancelLabel.BackgroundTransparency = 1
		CancelLabel.BorderSizePixel = 0
		CancelLabel.Size = UDim2.fromScale(1, 1)
		CancelLabel.ZIndex = 183
		CancelLabel.Font = Enum.Font.GothamMedium
		CancelLabel.Text = tostring(Config.CancelText)
		CancelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		CancelLabel.TextSize = 12
		CancelLabel.TextTransparency = 1
		local function UpdateProgress()
			local MaxValue = math.max(tonumber(Config.Max) or 1, 0.0001);
			local Value = math.clamp(tonumber(Config.Value) or 0, 0, MaxValue);
			local Percent = Value / MaxValue;
			if Config.Type == "%" then
				ValueLabel.Text = tostring(NeverloseUI.Rounding(Percent * 100, 0)).."%";
			else
				ValueLabel.Text = tostring(NeverloseUI.Rounding(Value, 2)).."/"..tostring(NeverloseUI.Rounding(MaxValue, 2))..tostring(Config.Type or "");
			end;
			NeverloseUI.PlayAnimate(BarFill, SlowyTween, {
				Size = UDim2.fromScale(Percent, 1),
				BackgroundColor3 = NeverloseUI.AccentColor
			});
		end;
		function Dialog:Close(Result)
			if Dialog.Closed then
				return Result;
			end;
			Dialog.Closed = true;
			NeverloseUI.PlayAnimate(Overlay,SlowyTween,{ BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(Panel,SlowyTween,{
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 335, 0, Config.Cancelable and 150 or 125)
			})
			NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{ Transparency = 1 })
			NeverloseUI.PlayAnimate(Title,SlowyTween,{ TextTransparency = 1 })
			NeverloseUI.PlayAnimate(Content,SlowyTween,{ TextTransparency = 1 })
			NeverloseUI.PlayAnimate(ValueLabel,SlowyTween,{ TextTransparency = 1 })
			NeverloseUI.PlayAnimate(BarBack,SlowyTween,{ BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(BarFill,SlowyTween,{ BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(CancelButton,SlowyTween,{ BackgroundTransparency = 1 })
			NeverloseUI.PlayAnimate(CancelStroke,SlowyTween,{ Transparency = 1 })
			NeverloseUI.PlayAnimate(CancelLabel,SlowyTween,{ TextTransparency = 1 })
			Shadow:Render(false);
			task.delay(0.18,function()
				Overlay:Destroy();
			end);
			NeverloseUI:FireCallback(Config.Callback, Config.Title, Result);
			return Result;
		end;
		function Dialog:SetValue(value)
			Config.Value = tonumber(value) or Config.Value;
			UpdateProgress();
			if Config.AutoClose == true and (tonumber(Config.Value) or 0) >= (tonumber(Config.Max) or 100) then
				Dialog:Close(true);
			end;
			return Dialog;
		end;
		function Dialog:SetMax(max)
			Config.Max = tonumber(max) or Config.Max;
			UpdateProgress();
			return Dialog;
		end;
		function Dialog:SetContent(text)
			Config.Content = tostring(text or "");
			Content.Text = Config.Content;
			return Dialog;
		end;
		function Dialog:SetTitle(text)
			Config.Title = tostring(text or "");
			Title.Text = Config.Title;
			return Dialog;
		end;
		function Dialog:SetType(text)
			Config.Type = tostring(text or "");
			UpdateProgress();
			return Dialog;
		end;
		function Dialog:GetValue()
			return Config.Value;
		end;
		if Config.Cancelable then
			local Input = NeverloseUI:CreateInput(CancelButton , LPH_NO_VIRTUALIZE(function()
				Dialog:Close(false);
			end));
			NeverloseUI:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
				NeverloseUI.PlayAnimate(CancelButton,SlowyTween,{ BackgroundTransparency = 0.100 })
			end)))
			NeverloseUI:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
				NeverloseUI.PlayAnimate(CancelButton,SlowyTween,{ BackgroundTransparency = 0.250 })
			end)))
		end;
		UpdateProgress();
		NeverloseUI.PlayAnimate(Overlay,SlowyTween,{ BackgroundTransparency = 0.350 })
		NeverloseUI.PlayAnimate(Panel,VSlowTween,{
			BackgroundTransparency = 0.035,
			Size = UDim2.new(0, 350, 0, Config.Cancelable and 165 or 140)
		})
		NeverloseUI.PlayAnimate(UIStroke,SlowyTween,{ Transparency = 0.650 })
		NeverloseUI.PlayAnimate(Title,SlowyTween,{ TextTransparency = 0 })
		NeverloseUI.PlayAnimate(Content,SlowyTween,{ TextTransparency = 0.250 })
		NeverloseUI.PlayAnimate(ValueLabel,SlowyTween,{ TextTransparency = 0.500 })
		NeverloseUI.PlayAnimate(BarBack,SlowyTween,{ BackgroundTransparency = 0 })
		NeverloseUI.PlayAnimate(BarFill,SlowyTween,{ BackgroundTransparency = 0 })
		if Config.Cancelable then
			NeverloseUI.PlayAnimate(CancelButton,SlowyTween,{ BackgroundTransparency = 0.250 })
			NeverloseUI.PlayAnimate(CancelStroke,SlowyTween,{ Transparency = 0.650 })
			NeverloseUI.PlayAnimate(CancelLabel,SlowyTween,{ TextTransparency = 0 })
		end;
		Shadow:Render(true);
		return CaseInsensitive(Dialog);
	end;
	Window:SetAccount();
	NeverloseUI:AddSignal(UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(value,ISTYPING)
		if value.KeyCode == Window.Keybind or value.KeyCode.Name == Window.Keybind then
			if not ISTYPING then
				Window:ToggleInterface()
			end
		end;
	end)));
	function Window:ToggleInterface()
		if Window.Destroyed or Window.Minimizing then
			return;
		end;
		Window.Signal:SetValue(not Window.Signal:GetValue());
		if Window.__3DRender then
			Window.Load3DBlock();
		end;
	end;
	function Window:SetFont(FontConfig)
		Window.Font = FontConfig;
		return NeverloseUI:SetFont(FontConfig);
	end;
	function Window:Destroy()
		if Window.Destroyed then
			return;
		end;
		Window.Destroyed = true;
		Window.Signal:SetValue(false);
		for _,Callback in ipairs(Window.OnDestroyCallbacks) do
			NeverloseUI:FireCallback(Callback, "OnDestroy", Window);
		end;
		if NeverloseUI.ActiveWindow == Window then
			NeverloseUI.ActiveWindow = nil;
		end;
		task.delay(0.2,function()
			if Window._MenuIcon and Window._MenuIcon.Root then
				Window._MenuIcon.Root:Destroy();
			end;
			if Window.SurfaceGui then
				Window.SurfaceGui:Destroy();
			end;
			WindowFrame:Destroy();
		end);
	end;
	NeverloseUI.ActiveWindow = Window;
	function Window:Watermark(Config)
		if typeof(Config) == "table" then
			local WatermarkLib = NeverloseUI.__WatermarkCache or Window:Watermark();
			return WatermarkLib:AddBlock(Config.Icon or Config.IconName or "", Config.Name or Config.Title or "Watermark");
		end;
		if NeverloseUI.__WatermarkCache then
			return NeverloseUI.__WatermarkCache;
		end;
		local Watermark_lb = {};
		local Watermark = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local Shadow = NeverloseUI:CreateShadow(Watermark);
		Watermark.Name = NeverloseUI.RandomString();
		Watermark.Parent = NeverloseUI.ScreenGui
		Watermark.AnchorPoint = Vector2.new(1, 0)
		Watermark.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
		Watermark.BackgroundTransparency = 0.200
		Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Watermark.BorderSizePixel = 0
		Watermark.ClipsDescendants = true
		Watermark.Active = true
		Watermark.Position = UDim2.new(1, -10, 0, 10)
		Watermark.Size = UDim2.new(0, 120, 0, 30)
		Watermark.ZIndex = 16
		UICorner.CornerRadius = UDim.new(0, 25)
		UICorner.Parent = Watermark
		UIListLayout.Parent = Watermark
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		local empty_space = Instance.new('Frame');
		empty_space.Size = UDim2.fromOffset(15,0);
		empty_space.BackgroundTransparency = 1;
		empty_space.Parent = Watermark;
		empty_space.LayoutOrder = 5;
		Watermark:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if Watermark.BackgroundTransparency > 0.9 then
				Watermark.Visible = false;
				Watermark.Parent = nil;
			else
				Watermark.Parent = NeverloseUI.ScreenGui
				Watermark.Visible = true;
			end;
		end));
		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			NeverloseUI.PlayAnimate(Watermark , SlowyTween , {
				Size = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + 5, 0, 30)
			})
		end));
		NeverloseUI.__WatermarkCache = Watermark_lb;
		Shadow:Render(true);
		Watermark_lb.Renders = {};
		Watermark_lb.Status = true;
		function Watermark_lb:SetRender(value)
			Watermark_lb.Status = value;
			if value then
				NeverloseUI.PlayAnimate(Watermark,SlowyTween , {
					BackgroundTransparency = 0.200
				})
				Shadow:Render(true);
				for i,v in next , Watermark_lb.Renders do
					pcall(v,true);
				end;
			else
				NeverloseUI.PlayAnimate(Watermark,SlowyTween , {
					BackgroundTransparency = 1
				})
				Shadow:Render(false);
				for i,v in next , Watermark_lb.Renders do
					pcall(v,false);
				end;
			end
		end;
		function Watermark_lb:AddBlock(IconStr , Name)
			local InnerBlock = {};
			local Frame = Instance.new("Frame")
			local Content = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			Frame.Parent = Watermark
			Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame.BackgroundTransparency = 1.000
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Active = true
			Frame.Size = UDim2.new(0, 50, 0, 30)
			Frame.ZIndex = 17
			Content.Name = NeverloseUI.RandomString();
			Content.Parent = Frame
			Content.AnchorPoint = Vector2.new(0, 0.5)
			Content.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
			Content.BackgroundTransparency = 1.000
			Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Content.BorderSizePixel = 0
			Content.Position = UDim2.new(0, 35, 0.5, 0)
			Content.Size = UDim2.new(0, 1, 0, 25)
			Content.ZIndex = 17
			Content.Font = Enum.Font.GothamBold
			Content.Text = Name
			Content.TextColor3 = Color3.fromRGB(186, 186, 186)
			Content.TextSize = 15.000
			Content.TextTransparency = 0.200
			Content.TextXAlignment = Enum.TextXAlignment.Left
			NeverloseUI:AddTextGradient(Content);
			Icon.Name = NeverloseUI.RandomString();
			Icon.Parent = Frame
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 10, 0.5, 0)
			Icon.Size = UDim2.new(0, 20, 0, 20)
			Icon.ZIndex = 17
			NeverloseUI:SetIconMode(Icon, IconStr)
			Icon.ImageColor3 = NeverloseUI.AccentColor
			Icon.ImageTransparency = 0.250
			Icon.ScaleType = Enum.ScaleType.Fit
			InnerBlock.Update = LPH_NO_VIRTUALIZE(function(value)
				local size = TextService:GetTextSize(Content.Text , Content.TextSize,Content.Font,Vector2.new(math.huge,math.huge))
				if InnerBlock.Visible then
					NeverloseUI.PlayAnimate(Frame,VSlowTween,{
						Size = UDim2.new(0, size.X + 35, 0, 30)
					})
				else
					NeverloseUI.PlayAnimate(Frame,VSlowTween,{
						Size = UDim2.new(0, 0, 0, 30)
					})
				end;
			end);
			InnerBlock.Visible = true;
			InnerBlock.Update();
			function InnerBlock:SetVisible(v)
				InnerBlock.Visible = v;
				if Watermark_lb.Status then
					InnerBlock.SetRender(v);
				end;
				InnerBlock.Update();
			end;
			InnerBlock.SetRender = LPH_NO_VIRTUALIZE(function(value)
				if value and InnerBlock.Visible then
					NeverloseUI.PlayAnimate(Content,SlowyTween , {
						TextTransparency = 0.200
					})
					NeverloseUI.PlayAnimate(Icon,SlowyTween , {
						TextTransparency = 0.250
					})
				else
					NeverloseUI.PlayAnimate(Content,SlowyTween , {
						TextTransparency = 1
					})
					NeverloseUI.PlayAnimate(Icon,SlowyTween , {
						TextTransparency = 1
					})
				end;
			end);
			table.insert(Watermark_lb.Renders,InnerBlock.SetRender);
			function InnerBlock:SetText(t)
				Content.Text = t;
				InnerBlock.Update();
			end;
			function InnerBlock:Input(func)
				local handler = func or function()
					NeverloseUI:FireKeybind();
				end;
				local btn, signal = NeverloseUI:CreateInput(Frame, handler);
				btn.Active = true;
				btn.ZIndex = Frame.ZIndex + 10;
				return signal;
			end;
			return CaseInsensitive(InnerBlock);
		end;
		return CaseInsensitive(Watermark_lb);
	end;
	Window:SetRender(false);
	function Window:_RegisterMenuIconSettings(MenuIcon)
		if not MenuIcon or Window._MenuIconSettingsRegistered then return; end;
		Window._MenuIconSettingsRegistered = true;
		Window.UserSettings:AddLabel('Icon Size'):AddSlider({
			Min      = 32,
			Max      = 96,
			Default  = MenuIcon._size,
			Rounding = 0,
			Type     = "px",
			Size     = 100,
			Callback = function(v)
				if Window._MenuIcon then
					Window._MenuIcon:SetSize(v);
				end;
			end,
		});
		Window.UserSettings:AddLabel('Icon Draggable'):AddToggle({
			Default  = MenuIcon._draggable,
			Callback = function(v)
				if Window._MenuIcon then
					Window._MenuIcon:SetDraggable(v);
				end;
			end,
		});
	end;
	local _orig_Toggle = Window.ToggleInterface;
	function Window:ToggleInterface()
		if Window.Destroyed or Window.KeyGateActive then
			return;
		end;
		if Window.Minimizing then
			if os.clock() - (Window._MinimizeStart or 0) < 1.2 then
				Window._PendingToggle = true;
				return;
			end;
			Window.Minimizing = false;
		end;
		pcall(function()
			Window:_SyncMinimizeState();
		end);
		if Window.Signal:GetValue() and Window:_IsShrunk() then
			Window:_ForceRestore();
			return;
		end;
		if Window.Signal:GetValue() and Window._MenuIcon and Window._MenuIcon.Root and Window._MenuIcon.Root.Parent and not Window.__3DRender then
			Window:Minimize();
			return;
		end;
		if not Window.Signal:GetValue() then
			Window.Minimized = false;
		end;
		_orig_Toggle(self);
		if Window.Signal:GetValue() then
			Window.Minimized = false;
			task.delay(0.15, function()
				if not Window.Destroyed and Window.Signal:GetValue() and not Window.__3DRender and not Window.Minimizing and Window.Root and Window.Root.BackgroundTransparency > 0.9 then
					Window:SetRender(true);
				end;
			end);
		end;
		if Window._MenuIcon then
			Window._MenuIcon:OnWindowToggle(Window.Signal:GetValue());
		end;
	end;
	function Window:AttachMenuIcon(MenuIcon)
		if Window._AutoMenuIcon and Window._AutoMenuIcon ~= MenuIcon then
			local Old = Window._AutoMenuIcon;
			Window._AutoMenuIcon = nil;
			pcall(function()
				Old:Destroy();
			end);
		end;
		Window._MenuIcon = MenuIcon;
		MenuIcon._Owner = Window;
		Window:_RegisterMenuIconSettings(MenuIcon);
		if Window._MenuIconSignal then
			pcall(function()
				Window._MenuIconSignal:Disconnect();
			end);
			Window._MenuIconSignal = nil;
		end;
		if MenuIcon.AutoHide then
			local Opening = Window.Signal:GetValue() or (not Window.KeyGateActive and not Window.ConfigSaveWindowState and (os.clock() - (Window._CreatedAt or 0)) < 3);
			MenuIcon:SetVisible(not Opening);
			Window._MenuIconSignal = Window.Signal:Connect(function(value)
				if Window.Destroyed or not Window._MenuIcon then
					return;
				end;
				Window._MenuIcon:SetVisible(not value);
			end);
		else
			MenuIcon:SetVisible(true);
		end;
	end;
	function Window:Notify(Config)
		Config = Config or {};
		if Config.Window == nil then
			Config.Window = Window;
		end;
		return NeverloseUI.Notifier.new(Config);
	end;
	function Window:SetNotificationPosition(Value)
		return NeverloseUI.Notifier.SetPosition(Value);
	end;
	function Window:GetNotificationPosition()
		return NeverloseUI.Notifier.GetPosition();
	end;
	function Window:Request(Config, Callback)
		return NeverloseUI.Http.Request(Config, Callback);
	end;
	function Window:Webhook(Url, Payload, Callback)
		return NeverloseUI.Http.Webhook(Url, Payload, Callback);
	end;
	Window.Indicators = LPH_NO_VIRTUALIZE(function(Config)
		local Indicator = NeverloseUI.Indicators.new(Config);
		Indicator:SetRender(true);
		return Indicator;
	end);
	function Window:Indicator(Config)
		return Window.Indicators(Config);
	end;
	if Config.ToggleButton ~= false and not Window._MenuIcon then
		local Options = {};
		if type(Config.ToggleButton) == "table" then
			for Key, Value in next, Config.ToggleButton do
				Options[Key] = Value;
			end;
		end;
		if Options.Image == nil then
			Options.Image = Config.ToggleIcon or Window.Icon or Window.Logo;
		end;
		Options.Auto = true;
		local Ok, AutoIcon = pcall(function()
			return NeverloseUI:CreateMenuIcon(Options);
		end);
		if Ok and AutoIcon then
			Window._AutoMenuIcon = AutoIcon;
			local Attached, AttachError = pcall(function()
				Window:AttachMenuIcon(AutoIcon);
			end);
			if not Attached then
				Window._MenuIcon = AutoIcon;
				warn("[NeverloseUI] Toggle button attach failed: " .. tostring(AttachError));
			end;
		end;
	end;
	function Window:SetKeySystem(KeyConfig)
		NeverloseUI:SetKeySystem(KeyConfig);
		return Window;
	end;
	function Window:VerifyKey(Value)
		return NeverloseUI:VerifyKey(Value);
	end;
	function Window:IsKeyVerified()
		return NeverloseUI:IsKeyVerified();
	end;
	function Window:ResetKey()
		NeverloseUI:ResetKey();
		return Window;
	end;
	if Window.KeyGateActive then
		if Window._MenuIcon then
			pcall(function()
				Window._MenuIcon:SetVisible(false);
			end);
		end;
		Window.KeyGate = NeverloseUI:RunKeyGate(Window, KeyGateConfig);
	end;
	return CaseInsensitive(Window);
end;
function NeverloseUI:CreateNotification()
	if NeverloseUI.__Notification_Cache then
		return NeverloseUI.__Notification_Cache;
	end;
	local Notifier = {};
	local Layouts = {
		TopRight = {
			Anchor = Vector2.new(1, 0),
			Position = UDim2.new(1, -25, 0, 25),
			Horizontal = Enum.HorizontalAlignment.Right,
			Vertical = Enum.VerticalAlignment.Top,
			FrameAnchor = 1,
			Start = UDim2.new(0, 750, 0, 0),
		},
		TopLeft = {
			Anchor = Vector2.new(0, 0),
			Position = UDim2.new(0, 25, 0, 25),
			Horizontal = Enum.HorizontalAlignment.Left,
			Vertical = Enum.VerticalAlignment.Top,
			FrameAnchor = 0,
			Start = UDim2.new(0, -750, 0, 0),
		},
		BottomRight = {
			Anchor = Vector2.new(1, 1),
			Position = UDim2.new(1, -25, 1, -25),
			Horizontal = Enum.HorizontalAlignment.Right,
			Vertical = Enum.VerticalAlignment.Bottom,
			FrameAnchor = 1,
			Start = UDim2.new(0, 750, 0, 0),
		},
		BottomLeft = {
			Anchor = Vector2.new(0, 1),
			Position = UDim2.new(0, 25, 1, -25),
			Horizontal = Enum.HorizontalAlignment.Left,
			Vertical = Enum.VerticalAlignment.Bottom,
			FrameAnchor = 0,
			Start = UDim2.new(0, -750, 0, 0),
		},
		TopCenter = {
			Anchor = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 25),
			Horizontal = Enum.HorizontalAlignment.Center,
			Vertical = Enum.VerticalAlignment.Top,
			FrameAnchor = 0.5,
			Start = UDim2.new(0, 0, 0, -140),
		},
	};
	local PositionAliases = {
		topright = "TopRight", righttop = "TopRight",
		topleft = "TopLeft", lefttop = "TopLeft",
		bottomright = "BottomRight", rightbottom = "BottomRight",
		bottomleft = "BottomLeft", leftbottom = "BottomLeft",
		topcenter = "TopCenter", top = "TopCenter", topmiddle = "TopCenter",
		topmid = "TopCenter", centertop = "TopCenter", middletop = "TopCenter",
	};
	local function NormalizePosition(Value)
		if type(Value) ~= "string" then
			return nil;
		end;
		local Key = string.lower((string.gsub(Value, "[^%a]", "")));
		return PositionAliases[Key];
	end;
	Notifier.Positions = { "TopLeft", "TopCenter", "TopRight", "BottomLeft", "BottomRight" };
	Notifier.NormalizePosition = NormalizePosition;
	Notifier.Position = NormalizePosition(NeverloseUI:GetUISetting("NotifyPosition")) or "TopRight";
	local PositionCallbacks = {};
	local Roots = {};
	local function GetRoot(PositionName)
		local Existing = Roots[PositionName];
		if Existing and Existing.Parent then
			return Existing;
		end;
		local Layout = Layouts[PositionName];
		local Root = Instance.new("Frame");
		local List = Instance.new("UIListLayout");
		Root.Name = NeverloseUI.RandomString();
		Root.Parent = NeverloseUI.ScreenGui;
		Root.AnchorPoint = Layout.Anchor;
		Root.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Root.BackgroundTransparency = 1.000;
		Root.BorderColor3 = Color3.fromRGB(0, 0, 0);
		Root.BorderSizePixel = 0;
		Root.Position = Layout.Position;
		Root.Size = UDim2.new(0, 25, 0, 25);
		List.Parent = Root;
		List.HorizontalAlignment = Layout.Horizontal;
		List.VerticalAlignment = Layout.Vertical;
		List.SortOrder = Enum.SortOrder.LayoutOrder;
		List.Padding = UDim.new(0, 0);
		Roots[PositionName] = Root;
		return Root;
	end;
	function Notifier.GetPosition()
		return Notifier.Position;
	end;
	function Notifier.SetPosition(Value, Save)
		local Name = NormalizePosition(Value);
		if not Name then
			return false;
		end;
		Notifier.Position = Name;
		if Save ~= false then
			NeverloseUI:SetUISetting("NotifyPosition", Name);
		end;
		for _, Callback in next, PositionCallbacks do
			pcall(Callback, Name);
		end;
		return true;
	end;
	function Notifier.OnPositionChanged(Callback)
		if type(Callback) == "function" then
			table.insert(PositionCallbacks, Callback);
		end;
	end;
	NeverloseUI.__Notification_Cache = Notifier;
	function Notifier.new(Config)
		Config = Config or {};
		local CustomIcon = Config.Icon;
		do
			local Owner = Config.Window or NeverloseUI.ActiveWindow;
			if Config.Logo == nil and Config.Image ~= nil then
				Config.Logo = Config.Image;
			end;
			if CustomIcon == nil and Config.Logo == nil and type(Owner) == "table" then
				local OwnerIcon = rawget(Owner, "Icon");
				local OwnerLogo = rawget(Owner, "Logo");
				if OwnerIcon ~= nil and tostring(OwnerIcon) ~= "" then
					CustomIcon = OwnerIcon;
				elseif OwnerLogo ~= nil and tostring(OwnerLogo) ~= "" then
					Config.Logo = OwnerLogo;
				end;
			end;
		end;
		Config = NeverloseUI:ProcessParams(Config , {
			Title = "Notification",
			Content = "Hello World!",
			Logo = NeverloseUI.GlobalLogo or "rbxasset://textures/ui/VerifiedBadgeNameIcon.png",
			Icon = CustomIcon,
			Duration = 5,
		});
		local IconSource = Config.Icon or Config.Logo;
		local IconId = NeverloseUI:GetIconId(IconSource);
		local IsImageIcon = IconId ~= "";
		local PositionName = NormalizePosition(Config.Position) or Notifier.Position;
		local Layout = Layouts[PositionName];
		local Root = GetRoot(PositionName);
		if NeverloseUI.__WatermarkCache and PositionName == "TopRight" then
			NeverloseUI.PlayAnimate(Root,SlowyTween , {
				Position = UDim2.new(1, -25, 0, 55)
			});
		end;
		local ContainerFrame = Instance.new("Frame")
		local NotifyFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogoImage = Instance.new("ImageLabel")
		local LogoIcon = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local NotifyName = Instance.new("TextLabel")
		local NotifyContent = Instance.new("TextLabel");
		local shadow = NeverloseUI:CreateShadow(NotifyFrame , true);
		ContainerFrame.Name = NeverloseUI.RandomString();
		ContainerFrame.Parent = Root
		ContainerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContainerFrame.BackgroundTransparency = 1.000
		ContainerFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContainerFrame.BorderSizePixel = 0
		ContainerFrame.Size = UDim2.new(0, 0, 0, 100)
		NotifyFrame.Name = NeverloseUI.RandomString();
		NotifyFrame.Parent = ContainerFrame
		NotifyFrame.AnchorPoint = Vector2.new(Layout.FrameAnchor, 0)
		NotifyFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		NotifyFrame.BackgroundTransparency = 0.075
		NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyFrame.BorderSizePixel = 0
		NotifyFrame.ClipsDescendants = true
		NotifyFrame.Position = Layout.Start
		NotifyFrame.Size = UDim2.new(0, 220, 0, 55)
		NotifyFrame.ZIndex = 130
		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = NotifyFrame
		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = NotifyFrame
		LogoImage.Name = NeverloseUI.RandomString();
		LogoImage.Parent = NotifyFrame
		LogoImage.AnchorPoint = Vector2.new(0, 0.5)
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
		LogoImage.Size = UDim2.new(0, 35, 0, 35)
		LogoImage.ZIndex = 131
		LogoImage.Image = IsImageIcon and IconId or ""
		LogoImage.ImageColor3 = NeverloseUI.IconColor;
		LogoImage.ImageTransparency = IsImageIcon and 0 or 1
		UICorner_2.CornerRadius = UDim.new(0, 7)
		UICorner_2.Parent = LogoImage
		LogoIcon.Name = NeverloseUI.RandomString();
		LogoIcon.Parent = NotifyFrame
		LogoIcon.AnchorPoint = Vector2.new(0, 0.5)
		LogoIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoIcon.BackgroundTransparency = 1.000
		LogoIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoIcon.BorderSizePixel = 0
		LogoIcon.Position = UDim2.new(0, 10, 0.5, 0)
		LogoIcon.Size = UDim2.new(0, 35, 0, 35)
		LogoIcon.ZIndex = 131
		NeverloseUI:SetIconMode(LogoIcon, IsImageIcon and "" or tostring(IconSource or "bell"))
		LogoIcon.ImageColor3 = NeverloseUI.IconColor
		LogoIcon.ImageTransparency = IsImageIcon and 1 or 0.150
		LogoIcon.ScaleType = Enum.ScaleType.Fit
		NotifyName.Name = NeverloseUI.RandomString();
		NotifyName.Parent = NotifyFrame
		NotifyName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyName.BackgroundTransparency = 1.000
		NotifyName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyName.BorderSizePixel = 0
		NotifyName.Position = UDim2.new(0, 50, 0, 7)
		NotifyName.Size = UDim2.new(0, 200, 0, 20)
		NotifyName.ZIndex = 132
		NotifyName.Font = Enum.Font.GothamBold
		NotifyName.Text = Config.Title
		NotifyName.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotifyName.TextSize = 17.000
		NotifyName.TextXAlignment = Enum.TextXAlignment.Left
		NotifyContent.Name = NeverloseUI.RandomString();
		NotifyContent.Parent = NotifyFrame
		NotifyContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyContent.BackgroundTransparency = 1.000
		NotifyContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyContent.BorderSizePixel = 0
		NotifyContent.Position = UDim2.new(0, 50, 0, 28)
		NotifyContent.Size = UDim2.new(0, 200, 0, 15)
		NotifyContent.ZIndex = 132
		NotifyContent.Font = Enum.Font.GothamBold
		NotifyContent.Text = Config.Content
		NotifyContent.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotifyContent.TextSize = 12.000
		NotifyContent.TextTransparency = 0.650
		NotifyContent.TextXAlignment = Enum.TextXAlignment.Left
		local Size1 = TextService:GetTextSize(NotifyName.Text,NotifyName.TextSize,NotifyName.Font,Vector2.new(math.huge,math.huge));
		local Size2 = TextService:GetTextSize(NotifyContent.Text,NotifyContent.TextSize,NotifyContent.Font,Vector2.new(math.huge,math.huge));
		local MainSize = math.max(Size1.X , Size2.X);
		NotifyFrame.Size = UDim2.new(0, MainSize + 65, 0, 55);
		shadow:Render(true)
		NeverloseUI.PlayAnimate(NotifyFrame , VSlowTween , {
			Position = UDim2.new(0, 0, 0, 0)
		})
		ContainerFrame.Size = UDim2.new(0, 0, 0, 65)
		task.delay(Config.Duration or 5 , LPH_NO_VIRTUALIZE(function()
			if NeverloseUI.__WatermarkCache and PositionName == "TopRight" then
				NeverloseUI.PlayAnimate(Root,SlowyTween , {
					Position = UDim2.new(1, -25, 0, 55)
				});
			end;
			shadow:Render(false)
			NeverloseUI.PlayAnimate(NotifyFrame , SlowyTween , {
				BackgroundTransparency = 1
			})
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})
			NeverloseUI.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})
			NeverloseUI.PlayAnimate(LogoIcon , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(NotifyName , SlowyTween , {
				TextTransparency = 1
			})
			NeverloseUI.PlayAnimate(NotifyContent , SlowyTween , {
				TextTransparency = 1
			})
			task.wait(0.125);
			NeverloseUI.PlayAnimate(ContainerFrame , SlowyTween , {
				Size = UDim2.new(0, 0, 0, 0)
			})
			task.wait(0.125);
			ContainerFrame:Destroy();
		end))
	end;
	return Notifier;
end;
function NeverloseUI:BuildNotificationPicker(Container, Custom, Window)
	local Notifier = NeverloseUI.Notifier;
	local Spots = {
		{ Name = "TopLeft",     Label = "Top Left",     X = 0.10, Y = 0.20 },
		{ Name = "TopCenter",   Label = "Top Center",   X = 0.50, Y = 0.20 },
		{ Name = "TopRight",    Label = "Top Right",    X = 0.90, Y = 0.20 },
		{ Name = "BottomLeft",  Label = "Bottom Left",  X = 0.10, Y = 0.80 },
		{ Name = "BottomRight", Label = "Bottom Right", X = 0.90, Y = 0.80 },
	};
	local Screen = Instance.new("Frame");
	Screen.Name = "NotificationTarget";
	Screen.AnchorPoint = Vector2.new(0.5, 0);
	Screen.Position = UDim2.new(0.5, 0, 0, 8);
	Screen.Size = UDim2.new(0, 176, 0, 78);
	Screen.BackgroundColor3 = Color3.fromRGB(8, 10, 14);
	Screen.BorderSizePixel = 0;
	Screen.ZIndex = 2;
	Screen.Parent = Container;
	local ScreenCorner = Instance.new("UICorner");
	ScreenCorner.CornerRadius = UDim.new(0, 6);
	ScreenCorner.Parent = Screen;
	local ScreenStroke = Instance.new("UIStroke");
	ScreenStroke.Color = Color3.fromRGB(45, 48, 58);
	ScreenStroke.Transparency = 0.4;
	ScreenStroke.Parent = Screen;
	local Silhouette = Instance.new("Frame");
	Silhouette.Name = "WindowShape";
	Silhouette.AnchorPoint = Vector2.new(0.5, 0.5);
	Silhouette.Position = UDim2.new(0.5, 0, 0.5, 0);
	Silhouette.Size = UDim2.new(0.34, 0, 0.46, 0);
	Silhouette.BackgroundColor3 = Color3.fromRGB(24, 27, 34);
	Silhouette.BorderSizePixel = 0;
	Silhouette.ZIndex = 3;
	Silhouette.Parent = Screen;
	local SilhouetteCorner = Instance.new("UICorner");
	SilhouetteCorner.CornerRadius = UDim.new(0, 4);
	SilhouetteCorner.Parent = Silhouette;
	local NameLabel = Instance.new("TextLabel");
	NameLabel.Name = "PositionName";
	NameLabel.AnchorPoint = Vector2.new(0.5, 0);
	NameLabel.Position = UDim2.new(0.5, 0, 0, 90);
	NameLabel.Size = UDim2.new(1, -20, 0, 16);
	NameLabel.BackgroundTransparency = 1;
	NameLabel.Font = Enum.Font.GothamBold;
	NameLabel.TextSize = 12;
	NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
	NameLabel.TextTransparency = 0.25;
	NameLabel.ZIndex = 2;
	NameLabel.Parent = Container;
	local Dots = {};
	local function Refresh()
		if not Screen.Parent then
			return;
		end;
		local Current = Notifier.GetPosition();
		local Accent = NeverloseUI.AccentColor;
		for _, Spot in ipairs(Spots) do
			local Dot = Dots[Spot.Name];
			local Selected = Spot.Name == Current;
			Dot.BackgroundColor3 = Selected and Accent or Color3.fromRGB(45, 48, 58);
			Dot.Size = Selected and UDim2.fromOffset(20, 20) or UDim2.fromOffset(16, 16);
			Dot.UIStroke.Color = Selected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(90, 94, 108);
			Dot.UIStroke.Transparency = Selected and 0.1 or 0.5;
			if Selected then
				NameLabel.Text = Spot.Label;
			end;
		end;
	end;
	for _, Spot in ipairs(Spots) do
		local Dot = Instance.new("TextButton");
		Dot.Name = Spot.Name;
		Dot.AnchorPoint = Vector2.new(0.5, 0.5);
		Dot.Position = UDim2.new(Spot.X, 0, Spot.Y, 0);
		Dot.Size = UDim2.fromOffset(16, 16);
		Dot.Text = "";
		Dot.AutoButtonColor = false;
		Dot.BorderSizePixel = 0;
		Dot.ZIndex = 5;
		Dot.Parent = Screen;
		local DotCorner = Instance.new("UICorner");
		DotCorner.CornerRadius = UDim.new(1, 0);
		DotCorner.Parent = Dot;
		local DotStroke = Instance.new("UIStroke");
		DotStroke.Thickness = 2;
		DotStroke.Parent = Dot;
		Dots[Spot.Name] = Dot;
		Dot.MouseButton1Click:Connect(function()
			Notifier.SetPosition(Spot.Name);
			Refresh();
			Notifier.new({
				Title = "Notifications",
				Content = Spot.Label,
				Duration = 2.5,
				Window = Window,
				Position = Spot.Name,
			});
		end);
	end;
	Notifier.OnPositionChanged(Refresh);
	NeverloseUI:OnThemeChanged(Refresh);
	Refresh();
end;
function NeverloseUI:CreateLogger()
	if NeverloseUI.__LogSystem then
		return 	NeverloseUI.__LogSystem;
	end;
	local Logging = {};
	local Log = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	Log.Name = NeverloseUI.RandomString();
	Log.Parent = NeverloseUI.ScreenGui
	Log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Log.BackgroundTransparency = 1.000
	Log.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Log.BorderSizePixel = 0
	Log.Position = UDim2.new(0, 25, 0, 5 + math.abs(NeverloseUI.ScreenGui.AbsolutePosition.Y))
	Log.Size = UDim2.new(0, 25, 0, 25)
	UIListLayout.Parent = Log
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 12)
	NeverloseUI.__LogSystem = Logging;
	function Logging.new(IconStr , Message , Duration)
		Duration = Duration or 3;
		Message = Message or "Log";
		IconStr = IconStr or "crosshairs";
		local LogFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogContent = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Icon = Instance.new("ImageLabel")
		local Shadow = NeverloseUI:CreateShadow(LogFrame , true);
		LogFrame.Name = NeverloseUI.RandomString();
		LogFrame.Parent = Log
		LogFrame.AnchorPoint = Vector2.new(0.5, 0)
		LogFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		LogFrame.BackgroundTransparency =  1
		LogFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogFrame.BorderSizePixel = 0
		LogFrame.ClipsDescendants = true
		LogFrame.Position = UDim2.new(0,0,0,0)
		LogFrame.Size = UDim2.new(0, 0, 0, 20)
		LogFrame.ZIndex = 130
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = LogFrame
		UIStroke.Transparency = 1
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = LogFrame
		LogContent.Name = NeverloseUI.RandomString();
		LogContent.Parent = LogFrame
		LogContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.BackgroundTransparency = 1.000
		LogContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogContent.BorderSizePixel = 0
		LogContent.Position = UDim2.new(0, 25, 0, 2)
		LogContent.Size = UDim2.new(0, 200, 0, 15)
		LogContent.ZIndex = 132
		LogContent.Font = Enum.Font.GothamBold
		LogContent.Text = Message
		LogContent.TextColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.TextSize = 12.000
		LogContent.TextTransparency = 1
		LogContent.TextXAlignment = Enum.TextXAlignment.Left
		Line.Name = NeverloseUI.RandomString();
		Line.Parent = LogFrame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = NeverloseUI.AccentColor
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BackgroundTransparency = 1
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, -2, 0.5, 0)
		Line.Size = UDim2.new(0, 5, 1, 0)
		Line.ZIndex = 131
		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = Line
		Icon.Name = NeverloseUI.RandomString();
		Icon.Parent = LogFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 7, 0, 3)
		Icon.Size = UDim2.new(0, 15, 0, 15)
		Icon.ZIndex = 133
		NeverloseUI:SetIconMode(Icon, IconStr)
		Icon.ImageColor3 = Color3.fromRGB(223, 223, 223)
		Icon.ImageTransparency = 1
		Icon.ScaleType = Enum.ScaleType.Fit
		local size = TextService:GetTextSize(LogContent.Text,LogContent.TextSize,LogContent.Font,Vector2.new(math.huge,math.huge));
		NeverloseUI.PlayAnimate(LogFrame , SlowyTween , {
			Size = UDim2.new(0, size.X + 35, 0, 20),
			BackgroundTransparency =  0.075
		});
		task.delay(0.15,LPH_NO_VIRTUALIZE(function()
			Shadow:Render(true);
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			});
			NeverloseUI.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 0.25
			});
			NeverloseUI.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 0
			});
			NeverloseUI.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			});
			task.wait(Duration + 0.1);
			Shadow:Render(false);
			NeverloseUI.PlayAnimate(LogFrame , SlowyTween , {
				BackgroundTransparency =  1
			});
			NeverloseUI.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			});
			NeverloseUI.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 1
			});
			NeverloseUI.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 1
			});
			NeverloseUI.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 1
			});
			task.wait(0.25);
			LogFrame:Destroy();
		end))
	end;
	return CaseInsensitive(Logging)
end;
function NeverloseUI:CreateIndicator()
	local IndicatorFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	IndicatorFrame.Name = NeverloseUI.RandomString();
	IndicatorFrame.Parent = NeverloseUI.ScreenGui;
	IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
	IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IndicatorFrame.BackgroundTransparency = 1.000
	IndicatorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IndicatorFrame.BorderSizePixel = 0
	IndicatorFrame.Position = UDim2.new(0, 15, 0.5, 0)
	IndicatorFrame.Size = UDim2.new(0, 100, 0, 100)
	IndicatorFrame.ZIndex = 15
	UIListLayout.Parent = IndicatorFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)
	local Indicators = {};
	Indicators.Color = {
		Red = Color3.fromRGB(255, 102, 105),
		Green = Color3.fromRGB(135, 255, 143),
		White = Color3.fromRGB(186, 186, 186),
	};
	Indicators.Root = IndicatorFrame;
	function Indicators.new(Config)
		Config = NeverloseUI:ProcessParams(Config , {
			Name = "Indicator",
			Icon = 'crosshairs',
			Color = 'Red',
		});
		local Indicator = {
			CurrentColor = Config.Color,
			Visible = false,
		};
		local IndicatorItem = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		local Icon = Instance.new("ImageLabel")
		local Content = Instance.new("TextLabel")
		local Shadow = NeverloseUI:CreateShadow(IndicatorItem);
		IndicatorItem.Name = NeverloseUI.RandomString();
		IndicatorItem.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
		IndicatorItem.BackgroundTransparency = 1
		IndicatorItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		IndicatorItem.BorderSizePixel = 0
		IndicatorItem.ClipsDescendants = true
		IndicatorItem.Size = UDim2.new(0, 85, 0, 40)
		IndicatorItem.ZIndex = 16
		IndicatorItem.Visible = false;
		IndicatorItem:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if IndicatorItem.BackgroundTransparency > 0.9 then
				IndicatorItem.Parent = nil;
				IndicatorItem.Visible = false;
			else
				IndicatorItem.Parent = IndicatorFrame;
				IndicatorItem.Visible = true;
			end;
		end))
		UICorner.CornerRadius = UDim.new(0, 25)
		UICorner.Parent = IndicatorItem
		Line.Name = NeverloseUI.RandomString();
		Line.Parent = IndicatorItem
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, 2, 0.5, 0)
		Line.BackgroundTransparency = 1;
		Line.Size = UDim2.new(0, 3, 0.649999976, 0)
		Line.ZIndex = 17
		UICorner_2.CornerRadius = UDim.new(0, 25)
		UICorner_2.Parent = Line
		UIGradient.Rotation = 90
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Line
		Icon.Name = NeverloseUI.RandomString();
		Icon.Parent = IndicatorItem
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 10, 0.5, 0)
		Icon.Size = UDim2.new(0, 25, 0, 25)
		Icon.ZIndex = 17
		NeverloseUI:SetIconMode(Icon, Config.Icon)
		Icon.ImageColor3 = Color3.fromRGB(186, 186, 186)
		Icon.ImageTransparency = 1
		Icon.ScaleType = Enum.ScaleType.Fit
		Content.Name = NeverloseUI.RandomString();
		Content.Parent = IndicatorItem
		Content.AnchorPoint = Vector2.new(0, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 40, 0.5, 0)
		Content.Size = UDim2.new(1, -40, 0, 25)
		Content.ZIndex = 17
		Content.Font = Enum.Font.GothamBold
		Content.Text = Config.Name
		Content.TextColor3 = Color3.fromRGB(186, 186, 186)
		Content.TextSize = 20.000
		Content.TextTransparency = 1
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Indicator.Update = LPH_NO_VIRTUALIZE(function()
			local text = TextService:GetTextSize(Content.Text,Content.TextSize , Content.Font , Vector2.new(math.huge,math.huge));
			NeverloseUI.PlayAnimate(IndicatorItem , SlowyTween , {
				Size = UDim2.new(0, text.X + 60, 0, 40);
			})
		end);
		Indicator.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
			Indicator.Visible = value;
			if value then
				NeverloseUI.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 0.200
				});
				NeverloseUI.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 0,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});
				NeverloseUI.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 0.250,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});
				NeverloseUI.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 0.2,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});
				Shadow:Render(true);
			else
				NeverloseUI.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 1
				});
				NeverloseUI.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 1,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});
				NeverloseUI.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});
				NeverloseUI.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});
				Shadow:Render(false);
			end;
			Indicator.Update();
		end);
		Indicator.Update();
		Indicator:SetRender(false);
		function Indicator:SetColor(new_color)
			Indicator.CurrentColor = new_color;
			if Indicator.Visible then
				Indicator:SetRender(true);
			end;
		end;
		function Indicator:SetText(name)
			Config.Name = name;
			Content.Text = Config.Name;
			Indicator.Update();
		end;
		return CaseInsensitive(Indicator);
	end;
	return CaseInsensitive(Indicators);
end;
NeverloseUI.Logging = NeverloseUI:CreateLogger();
NeverloseUI.Notifier = NeverloseUI:CreateNotification();
NeverloseUI.Indicators = NeverloseUI:CreateIndicator();
function NeverloseUI:Unload()
	if not NeverloseUI.UnloadEnabled then
		return;
	end;
	NeverloseUI.ScreenGui:Destroy();
	for i,v in next , NeverloseUI.GlobalSignals do
		pcall(v.Disconnect,v)
	end;
end;
function NeverloseUI:Window(Config)
	return NeverloseUI:CreateWindow(Config);
end;
return CaseInsensitive(NeverloseUI);
