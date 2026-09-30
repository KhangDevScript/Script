-- LuckyMenu.client.lua
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- This creates a visual menu matching the supplied reference image.
-- Connect the callbacks to your own server-authoritative game systems.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local COLORS = {
	background = Color3.fromRGB(10, 10, 25),
	panel = Color3.fromRGB(22, 23, 42),
	row = Color3.fromRGB(27, 29, 49),
	rowStroke = Color3.fromRGB(32, 34, 57),
	text = Color3.fromRGB(226, 225, 233),
	subtleText = Color3.fromRGB(184, 184, 198),
	gold = Color3.fromRGB(255, 216, 86),
	toggleOff = Color3.fromRGB(55, 64, 87),
	toggleOn = Color3.fromRGB(101, 174, 107),
	knob = Color3.fromRGB(220, 220, 220),
}

local function create(className, properties, parent)
	local object = Instance.new(className)
	for property, value in pairs(properties) do
		object[property] = value
	end
	object.Parent = parent
	return object
end

local function addCorner(parent, radius)
	return create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function addStroke(parent, color, thickness, transparency)
	return create("UIStroke", {
		Color = color,
		Thickness = thickness or 1,
		Transparency = transparency or 0,
	}, parent)
end

local screenGui = create("ScreenGui", {
	Name = "LuckyMenu",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 20,
}, playerGui)

local panel = create("Frame", {
	Name = "Menu",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(364, 309),
	BackgroundColor3 = COLORS.background,
	BorderSizePixel = 0,
}, screenGui)
addCorner(panel, 16)
addStroke(panel, Color3.fromRGB(49, 51, 79), 1, 0.2)

local scale = create("UIScale", { Scale = 1 }, panel)
local camera = workspace.CurrentCamera
local function resizeForViewport()
	if not camera then return end
	local viewport = camera.ViewportSize
	local widthScale = math.min(1, (viewport.X - 32) / 364)
	local heightScale = math.min(1, (viewport.Y - 32) / 309)
	scale.Scale = math.min(widthScale, heightScale)
end
resizeForViewport()
if camera then
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(resizeForViewport)
end

local titleBar = create("Frame", {
	Name = "TitleBar",
	Size = UDim2.new(1, 0, 0, 62),
	BackgroundTransparency = 1,
}, panel)

create("TextLabel", {
	Name = "Title",
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(24, 0),
	Size = UDim2.new(1, -48, 1, 0),
	Font = Enum.Font.GothamBold,
	Text = "✨  X100 Lucky Script",
	TextColor3 = COLORS.gold,
	TextSize = 21,
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Center,
}, titleBar)

local content = create("Frame", {
	Name = "Options",
	Position = UDim2.fromOffset(6, 68),
	Size = UDim2.new(1, -12, 1, -74),
	BackgroundTransparency = 1,
}, panel)

local list = create("UIListLayout", {
	Padding = UDim.new(0, 10),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, content)

local callbacks = {}
local states = {}

local function makeToggle(optionName, labelText, iconText, callback)
	states[optionName] = false
	callbacks[optionName] = callback

	local row = create("Frame", {
		Name = optionName,
		LayoutOrder = #content:GetChildren(),
		Size = UDim2.new(1, 0, 0, 56),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	}, content)
	addCorner(row, 9)
	addStroke(row, COLORS.rowStroke, 1, 0.25)

	create("TextLabel", {
		Name = "Label",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(17, 0),
		Size = UDim2.new(1, -105, 1, 0),
		Font = Enum.Font.Gotham,
		Text = iconText .. " " .. labelText,
		TextColor3 = COLORS.subtleText,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	}, row)

	local toggle = create("TextButton", {
		Name = "Toggle",
		AutoButtonColor = false,
		BackgroundColor3 = COLORS.toggleOff,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -91, 0.5, -18),
		Size = UDim2.fromOffset(76, 36),
		Text = "",
	}, row)
	addCorner(toggle, 20)

	local knob = create("Frame", {
		Name = "Knob",
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.fromOffset(30, 30),
		BackgroundColor3 = COLORS.knob,
		BorderSizePixel = 0,
	}, toggle)
	addCorner(knob, 15)

	local function setEnabled(enabled, instant)
		states[optionName] = enabled
		local targetColor = enabled and COLORS.toggleOn or COLORS.toggleOff
		local targetPosition = enabled
			and UDim2.new(1, -35, 0.5, 0)
			or UDim2.new(0, 5, 0.5, 0)
		local duration = instant and 0 or 0.16
		TweenService:Create(toggle, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
			BackgroundColor3 = targetColor,
		}):Play()
		TweenService:Create(knob, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
			Position = targetPosition,
		}):Play()
		if callbacks[optionName] then
			callbacks[optionName](enabled)
		end
	end

	toggle.Activated:Connect(function()
		setEnabled(not states[optionName])
	end)

	return {
		Set = setEnabled,
		Get = function() return states[optionName] end,
	}
end

-- Replace the print statements with calls to your own RemoteEvents or game logic.
-- Keep validation and rewards on the server; never trust a client toggle for currency.
local toggles = {}
toggles.BoostLuck = makeToggle("BoostLuck", "Boost Luck", "🍀", function(enabled)
	print("Boost Luck:", enabled)
	-- Example: ReplicatedStorage.Remotes.SetLuckyBoost:FireServer(enabled)
end)

toggles.BypassWaitingTime = makeToggle("BypassWaitingTime", "Bypass Waiting Time", "⏰", function(enabled)
	print("Bypass Waiting Time:", enabled)
	-- Example: ReplicatedStorage.Remotes.SetWaitPreference:FireServer(enabled)
end)

toggles.BypassCash = makeToggle("BypassCash", "Bypass Cash", "💰", function(enabled)
	print("Bypass Cash:", enabled)
	-- Example: ReplicatedStorage.Remotes.SetCashPreference:FireServer(enabled)
end)

-- Optional API for other client scripts:
_G.LuckyMenu = {
	SetVisible = function(visible)
		panel.Visible = visible
	end,
	SetOption = function(optionName, enabled)
		if toggles[optionName] then
			toggles[optionName].Set(enabled)
		end
	end,
	GetOption = function(optionName)
		return toggles[optionName] and toggles[optionName].Get() or nil
	end,
}
