-- =====================================================
-- PART 1: LOADING SCREEN (Mochii Scripts)
-- =====================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local plr = Players.LocalPlayer

-- Auto copy YouTube link
pcall(function()
    if setclipboard then
        setclipboard("https://www.youtube.com/@MochiiScripts")
    end
end)

local function rnd(n)
    local s = ""
    for i = 1, n do
        s = s .. string.char(math.random(97, 122))
    end
    return s
end

-- Cleanup old UIs safely
pcall(function()
    for _, v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:len() == 12 then
            v:Destroy()
        end
    end
end)

local gui = Instance.new("ScreenGui")
gui.Name = rnd(12)
gui.Parent = CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.DisplayOrder = 999

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Sine), { Size = 6 }):Play()

local card = Instance.new("Frame", gui)
card.Name = "LoadCard"
card.Size = UDim2.new(0, 280, 0, 310)
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Dark Background
card.BorderSizePixel = 0
card.ZIndex = 20
card.BackgroundTransparency = 1
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 20)

local cg = Instance.new("UIGradient", card)
cg.Rotation = 135
cg.Color = ColorSequence.new {
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
}

local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = Color3.fromRGB(255, 255, 255) -- White Border
cardStroke.Thickness = 1.5
cardStroke.Transparency = 0.3

local cScale = Instance.new("UIScale", card)
cScale.Scale = 0.82
TweenService:Create(cScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
TweenService:Create(card, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()

local avatarGlow = Instance.new("Frame", card)
avatarGlow.Size = UDim2.new(0, 78, 0, 78)
avatarGlow.AnchorPoint = Vector2.new(0.5, 0)
avatarGlow.Position = UDim2.new(0.5, 0, 0, 16)
avatarGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White Glow
avatarGlow.BackgroundTransparency = 0.85
avatarGlow.BorderSizePixel = 0
avatarGlow.ZIndex = 21
Instance.new("UICorner", avatarGlow).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    while card and card.Parent do
        TweenService:Create(avatarGlow, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { BackgroundTransparency = 0.7, Size = UDim2.new(0, 84, 0, 84) }):Play()
        task.wait(1.3)
        if not (card and card.Parent) then break end
        TweenService:Create(avatarGlow, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { BackgroundTransparency = 0.88, Size = UDim2.new(0, 74, 0, 74) }):Play()
        task.wait(1.3)
    end
end)

local avatarFrame = Instance.new("Frame", card)
avatarFrame.Size = UDim2.new(0, 60, 0, 60)
avatarFrame.AnchorPoint = Vector2.new(0.5, 0)
avatarFrame.Position = UDim2.new(0.5, 0, 0, 25)
avatarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
avatarFrame.BorderSizePixel = 0
avatarFrame.ZIndex = 22
Instance.new("UICorner", avatarFrame).CornerRadius = UDim.new(1, 0)

local avatarRing2 = Instance.new("UIStroke", avatarFrame)
avatarRing2.Color = Color3.fromRGB(255, 255, 255) -- White Ring
avatarRing2.Thickness = 2
avatarRing2.Transparency = 0.2

local introAvatarImg = Instance.new("ImageLabel", avatarFrame)
introAvatarImg.Size = UDim2.fromScale(1, 1)
introAvatarImg.BackgroundTransparency = 1
introAvatarImg.Image = "rbxassetid://133730800876845"
introAvatarImg.ScaleType = Enum.ScaleType.Crop
introAvatarImg.ZIndex = 23
Instance.new("UICorner", introAvatarImg).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    local s = Instance.new("UIScale", avatarFrame)
    while card and card.Parent do
        TweenService:Create(s, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Scale = 1.06 }):Play()
        task.wait(1.2)
        if not (card and card.Parent) then break end
        TweenService:Create(s, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Scale = 1.0 }):Play()
        task.wait(1.2)
    end
end)

local chanName = Instance.new("TextLabel", card)
chanName.Size = UDim2.new(1, -16, 0, 24)
chanName.AnchorPoint = Vector2.new(0.5, 0)
chanName.Position = UDim2.new(0.5, 0, 0, 92)
chanName.BackgroundTransparency = 1
chanName.Text = "Mochii Scripts"
chanName.Font = Enum.Font.GothamBlack
chanName.TextSize = 19
chanName.TextColor3 = Color3.fromRGB(255, 255, 255) -- Pure White Text
chanName.ZIndex = 22

local chanHandle = Instance.new("TextLabel", card)
chanHandle.Size = UDim2.new(1, -20, 0, 28)
chanHandle.AnchorPoint = Vector2.new(0.5, 0)
chanHandle.Position = UDim2.new(0.5, 0, 0, 115)
chanHandle.BackgroundTransparency = 1
chanHandle.Text = "📺 Subscribe first to unlock script\nafter loading finishes!"
chanHandle.Font = Enum.Font.GothamBold
chanHandle.TextSize = 11
chanHandle.TextColor3 = Color3.fromRGB(210, 210, 210) -- Light Gray
chanHandle.ZIndex = 22

local sep = Instance.new("Frame", card)
sep.Size = UDim2.new(0.78, 0, 0, 1)
sep.AnchorPoint = Vector2.new(0.5, 0)
sep.Position = UDim2.new(0.5, 0, 0, 146)
sep.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White Line
sep.BackgroundTransparency = 0.7
sep.BorderSizePixel = 0
sep.ZIndex = 22

local sepG = Instance.new("UIGradient", sep)
sepG.Transparency = NumberSequence.new {
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.15, 0),
    NumberSequenceKeypoint.new(0.85, 0),
    NumberSequenceKeypoint.new(1, 1)
}

local scriptTag = Instance.new("TextLabel", card)
scriptTag.Size = UDim2.new(1, -20, 0, 20)
scriptTag.AnchorPoint = Vector2.new(0.5, 0)
scriptTag.Position = UDim2.new(0.5, 0, 0, 152)
scriptTag.BackgroundTransparency = 1
scriptTag.Text = "⚡ SCRIPT LOADING ⚡"
scriptTag.Font = Enum.Font.GothamBold
scriptTag.TextSize = 13
scriptTag.TextColor3 = Color3.fromRGB(255, 255, 255) -- White Text
scriptTag.ZIndex = 22

task.spawn(function()
    while card and card.Parent do
        TweenService:Create(scriptTag, TweenInfo.new(0.65, Enum.EasingStyle.Sine), { TextTransparency = 0.45 }):Play()
        task.wait(0.65)
        if not (card and card.Parent) then break end
        TweenService:Create(scriptTag, TweenInfo.new(0.65, Enum.EasingStyle.Sine), { TextTransparency = 0 }):Play()
        task.wait(0.65)
    end
end)

-- MODIFIED: Ginawang KULAY RED ang status text sa taas ng loading bar
local statusLabel = Instance.new("TextLabel", card)
statusLabel.Size = UDim2.new(1, -20, 0, 16)
statusLabel.AnchorPoint = Vector2.new(0.5, 0)
statusLabel.Position = UDim2.new(0.5, 0, 0, 174)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "⚙️ Initializing modules..."
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 11
statusLabel.TextColor3 = Color3.fromRGB(255, 75, 75) -- Red Text
statusLabel.ZIndex = 22

local msgs = {
    "⚙️ Initializing modules...",
    "📡 Loading remote functions...",
    "🛡️ Bypassing detection layers...",
    "🔄 Fetching latest patches...",
    "🌐 Connecting to servers...",
    "💉 Injecting exploit hooks...",
    "🔍 Verifying script integrity...",
    "🔥 Warming up features...",
    "🚀 Almost ready..."
}

task.spawn(function()
    local mi = 1
    while card and card.Parent do
        TweenService:Create(statusLabel, TweenInfo.new(0.18), { TextTransparency = 1 }):Play()
        task.wait(0.18)
        if not (card and card.Parent) then break end
        mi = (mi % #msgs) + 1
        statusLabel.Text = msgs[mi]
        TweenService:Create(statusLabel, TweenInfo.new(0.18), { TextTransparency = 0 }):Play()
        task.wait(2.5)
    end
end)

local barBG = Instance.new("Frame", card)
barBG.Size = UDim2.new(0.84, 0, 0, 7)
barBG.AnchorPoint = Vector2.new(0.5, 0)
barBG.Position = UDim2.new(0.5, 0, 0, 198)
barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark Track
barBG.BorderSizePixel = 0
barBG.ZIndex = 22
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 7)

-- MODIFIED: Ginawang GREEN ang Loading Bar
local iBar2 = Instance.new("Frame", barBG)
iBar2.Size = UDim2.fromScale(0, 1)
iBar2.BackgroundColor3 = Color3.fromRGB(50, 220, 100) -- Green Progress Bar
iBar2.BorderSizePixel = 0
iBar2.ZIndex = 23
Instance.new("UICorner", iBar2).CornerRadius = UDim.new(0, 7)

local barGrad = Instance.new("UIGradient", iBar2)
barGrad.Color = ColorSequence.new {
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 180, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 255, 120))
}

local shim = Instance.new("Frame", iBar2)
shim.Size = UDim2.new(0, 20, 1, 0)
shim.Position = UDim2.fromScale(-0.5, 0)
shim.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shim.BackgroundTransparency = 0.5
shim.BorderSizePixel = 0
shim.ZIndex = 24
Instance.new("UICorner", shim).CornerRadius = UDim.new(0, 7)

local shimG = Instance.new("UIGradient", shim)
shimG.Rotation = 90
shimG.Transparency = NumberSequence.new {
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.3),
    NumberSequenceKeypoint.new(1, 1)
}

task.spawn(function()
    while card and card.Parent do
        TweenService:Create(shim, TweenInfo.new(0.9, Enum.EasingStyle.Sine), { Position = UDim2.fromScale(1.4, 0) }):Play()
        task.wait(0.9)
        if not (card and card.Parent) then break end
        shim.Position = UDim2.fromScale(-0.5, 0)
        task.wait(0.05)
    end
end)

local tip = Instance.new("Frame", barBG)
tip.Size = UDim2.new(0, 4, 0, 13)
tip.AnchorPoint = Vector2.new(0.5, 0.5)
tip.Position = UDim2.fromScale(0.01, 0.5)
tip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tip.BackgroundTransparency = 0.05
tip.BorderSizePixel = 0
tip.ZIndex = 25
Instance.new("UICorner", tip).CornerRadius = UDim.new(1, 0)

local tRow = Instance.new("Frame", card)
tRow.Size = UDim2.new(0.84, 0, 0, 18)
tRow.AnchorPoint = Vector2.new(0.5, 0)
tRow.Position = UDim2.new(0.5, 0, 0, 209)
tRow.BackgroundTransparency = 1
tRow.ZIndex = 22

local timerL = Instance.new("TextLabel", tRow)
timerL.Size = UDim2.fromScale(0.5, 1)
timerL.BackgroundTransparency = 1
timerL.Text = "⏳ 02:00"
timerL.Font = Enum.Font.GothamBold
timerL.TextSize = 11
timerL.TextColor3 = Color3.fromRGB(255, 255, 255) -- White Timer
timerL.TextXAlignment = Enum.TextXAlignment.Left
timerL.ZIndex = 22

local pctL = Instance.new("TextLabel", tRow)
pctL.Size = UDim2.fromScale(0.5, 1)
pctL.Position = UDim2.fromScale(0.5, 0)
pctL.BackgroundTransparency = 1
pctL.Text = "0%"
pctL.Font = Enum.Font.GothamBold
pctL.TextSize = 11
pctL.TextColor3 = Color3.fromRGB(200, 200, 200) -- Light Gray Percentage
pctL.TextXAlignment = Enum.TextXAlignment.Right
pctL.ZIndex = 22

local dotsF = Instance.new("Frame", card)
dotsF.Size = UDim2.new(0, 48, 0, 10)
dotsF.AnchorPoint = Vector2.new(0.5, 0)
dotsF.Position = UDim2.new(0.5, 0, 0, 234)
dotsF.BackgroundTransparency = 1
dotsF.ZIndex = 22

-- MODIFIED: Ginawang RED ang Animated Loading Dots
local dots = {}
for i = 1, 4 do
    local d = Instance.new("Frame", dotsF)
    d.Size = UDim2.new(0, 6, 0, 6)
    d.Position = UDim2.new(0, (i - 1) * 14, 0.5, -3)
    d.BackgroundColor3 = Color3.fromRGB(255, 75, 75) -- Red Dots
    d.BackgroundTransparency = 0.5
    d.BorderSizePixel = 0
    d.ZIndex = 23
    Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
    dots[i] = d
end

task.spawn(function()
    local idx = 1
    while card and card.Parent do
        for i, d in ipairs(dots) do
            local a = (i == idx)
            TweenService:Create(d, TweenInfo.new(0.13), {
                BackgroundTransparency = a and 0 or 0.6,
                Size = a and UDim2.new(0, 9, 0, 9) or UDim2.new(0, 5, 0, 5)
            }):Play()
        end
        idx = (idx % #dots) + 1
        task.wait(0.13)
    end
end)

local ver = Instance.new("TextLabel", card)
ver.Size = UDim2.new(1, -16, 0, 14)
ver.AnchorPoint = Vector2.new(0.5, 0)
ver.Position = UDim2.new(0.5, 0, 0, 252)
ver.BackgroundTransparency = 1
ver.Text = "🔓 unlocking script..."
ver.Font = Enum.Font.Gotham
ver.TextSize = 10
ver.TextColor3 = Color3.fromRGB(160, 160, 160) -- Light Gray
ver.ZIndex = 22

-- Floating particles effect
task.spawn(function()
    while card and card.Parent do
        local p = Instance.new("Frame", gui)
        local sz = math.random(2, 4)
        p.Size = UDim2.new(0, sz, 0, sz)
        p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        p.BackgroundTransparency = math.random(40, 70) / 100
        p.BorderSizePixel = 0
        p.ZIndex = 18
        local cx = 0.5 + (math.random(-16, 16) / 100)
        local cy = 0.5 + (math.random(-22, 22) / 100)
        p.Position = UDim2.fromScale(cx, cy + 0.25)
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        local dur = math.random(28, 55) / 10
        TweenService:Create(p, TweenInfo.new(dur, Enum.EasingStyle.Sine), {
            Position = UDim2.fromScale(cx + (math.random(-6, 6) / 100), cy - 0.22),
            BackgroundTransparency = 1
        }):Play()
        task.delay(dur, function()
            if p and p.Parent then
                p:Destroy()
            end
        end)
        task.wait(0.3)
    end
end)

-- SMOOTH MAIN LOADING
local LOAD_TIME = 120 -- Seconds
TweenService:Create(iBar2, TweenInfo.new(LOAD_TIME, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(1, 1) }):Play()
TweenService:Create(tip, TweenInfo.new(LOAD_TIME, Enum.EasingStyle.Linear), { Position = UDim2.fromScale(0.99, 0.5) }):Play()

local startTick = tick()
while (tick() - startTick) < LOAD_TIME do
    local elapsed = tick() - startTick
    local p = math.clamp(elapsed / LOAD_TIME, 0, 1)
    local rem = math.max(0, LOAD_TIME - elapsed)
    
    timerL.Text = string.format("⏳ %02d:%02d", math.floor(rem / 60), math.floor(rem % 60))
    pctL.Text = math.floor(p * 100) .. "%"
    task.wait(0.1)
end

-- CLEANUP LOADING SCREEN
pcall(function() blur:Destroy() end)
pcall(function() gui:Destroy() end)


-- =====================================================
-- PART 2: KEY SYSTEM UI (Lalabas pagkatapos mag-load)
-- =====================================================

-- Settings
local CORRECT_KEY = "MochiiScriptsKey" -- Palitan mo ng tamang key mo
local GET_KEY_LINK = "https://discord.gg/mozil" -- Link na mako-copy sa Get Key

-- Parent UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystemUI"
ScreenGui.ResetOnSpawn = false

-- Fallback UI parent (Studio / Executor support)
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Card Frame (460x225)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 225)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -112) -- Gitnang-gitna
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 65)
MainStroke.Thickness = 1.5
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

-- Top Section (Header)
local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Size = UDim2.new(0, 10, 0, 10)
StatusDot.Position = UDim2.new(0, 24, 0, 26)
StatusDot.BackgroundColor3 = Color3.fromRGB(72, 230, 138)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = MainFrame

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -60, 0, 22)
TitleLabel.Position = UDim2.new(0, 42, 0, 20)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Key System"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Name = "SubtitleLabel"
SubtitleLabel.Size = UDim2.new(1, -60, 0, 18)
SubtitleLabel.Position = UDim2.new(0, 42, 0, 42)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Enter key to unlock."
SubtitleLabel.TextColor3 = Color3.fromRGB(120, 120, 145)
SubtitleLabel.TextSize = 13
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Parent = MainFrame

-- Key Input TextBox
local InputBox = Instance.new("TextBox")
InputBox.Name = "KeyInput"
InputBox.Size = UDim2.new(1, -48, 0, 46)
InputBox.Position = UDim2.new(0, 24, 0, 78)
InputBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
InputBox.BorderSizePixel = 0
InputBox.Text = ""
InputBox.PlaceholderText = "Enter key..."
InputBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 105)
InputBox.TextColor3 = Color3.fromRGB(220, 220, 235)
InputBox.TextSize = 14
InputBox.Font = Enum.Font.Gotham
InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.ClearTextOnFocus = false
InputBox.Parent = MainFrame

local InputPadding = Instance.new("UIPadding")
InputPadding.PaddingLeft = UDim.new(0, 16)
InputPadding.PaddingRight = UDim.new(0, 16)
InputPadding.Parent = InputBox

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = InputBox

-- Buttons
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Name = "GetKeyBtn"
GetKeyBtn.Size = UDim2.new(0.5, -30, 0, 42)
GetKeyBtn.Position = UDim2.new(0, 24, 0, 136)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 55)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(140, 140, 180)
GetKeyBtn.TextSize = 14
GetKeyBtn.Font = Enum.Font.GothamMedium
GetKeyBtn.Parent = MainFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 12)
GetKeyCorner.Parent = GetKeyBtn

local ContinueBtn = Instance.new("TextButton")
ContinueBtn.Name = "ContinueBtn"
ContinueBtn.Size = UDim2.new(0.5, -30, 0, 42)
ContinueBtn.Position = UDim2.new(0.5, 6, 0, 136)
ContinueBtn.BackgroundColor3 = Color3.fromRGB(75, 70, 255)
ContinueBtn.BorderSizePixel = 0
ContinueBtn.Text = "Continue"
ContinueBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
ContinueBtn.TextSize = 14
ContinueBtn.Font = Enum.Font.GothamMedium
ContinueBtn.Parent = MainFrame

local ContinueCorner = Instance.new("UICorner")
ContinueCorner.CornerRadius = UDim.new(0, 12)
ContinueCorner.Parent = ContinueBtn

-- Subtext Link sa KALIWA sa pinakababa
local KeyLinkSubtext = Instance.new("TextLabel")
KeyLinkSubtext.Name = "KeyLinkSubtext"
KeyLinkSubtext.Size = UDim2.new(1, -48, 0, 16)
KeyLinkSubtext.Position = UDim2.new(0, 24, 0, 190)
KeyLinkSubtext.BackgroundTransparency = 1
KeyLinkSubtext.Text = GET_KEY_LINK
KeyLinkSubtext.TextColor3 = Color3.fromRGB(100, 100, 135)
KeyLinkSubtext.TextSize = 11
KeyLinkSubtext.Font = Enum.Font.Gotham
KeyLinkSubtext.TextXAlignment = Enum.TextXAlignment.Left
KeyLinkSubtext.Parent = MainFrame

-- Key System Functionalities
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GET_KEY_LINK)
        GetKeyBtn.Text = "Copied!"
        task.wait(1.5)
        GetKeyBtn.Text = "Get Key"
    else
        GetKeyBtn.Text = "Copied Link"
        task.wait(1.5)
        GetKeyBtn.Text = "Get Key"
    end
end)

ContinueBtn.MouseButton1Click:Connect(function()
    if InputBox.Text == CORRECT_KEY then
        ContinueBtn.Text = "Success!"
        ContinueBtn.BackgroundColor3 = Color3.fromRGB(45, 180, 90)
        task.wait(1)
        
        ScreenGui:Destroy()
        
        -- Dito ilagay ang totoong script mo
        print("Key system passed!")
    else
        ContinueBtn.Text = "Invalid Key!"
        ContinueBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        task.wait(1.5)
        ContinueBtn.Text = "Continue"
        ContinueBtn.BackgroundColor3 = Color3.fromRGB(75, 70, 255)
    end
end)