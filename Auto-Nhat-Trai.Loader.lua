repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local httpservice = game:GetService("HttpService")
local teleportservice = game:GetService("TeleportService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local TitleLabel = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Name = "KhangDevFruitGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 110)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

UIStroke.Name = "RainbowStroke"
UIStroke.Parent = MainFrame
UIStroke.Thickness = 3

TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "KHANG DEV SCRIPT"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 10, 0, 50)
StatusLabel.Size = UDim2.new(1, -20, 0, 45)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Text = "Checking..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
StatusLabel.TextWrapped = true

task.spawn(function()
    while task.wait() do
        for i = 0, 1, 0.005 do
            UIStroke.Color = Color3.fromHSV(i, 1, 1)
            task.wait(0.05)
        end
    end
end)

local function autoJoinPirates()
    pcall(function()
        if player.PlayerGui:FindFirstChild("Main") and player.PlayerGui.Main:FindFirstChild("ChooseTeam") then
            replicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
        end
    end)
end

local function storeFruits()
    pcall(function()
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and string.find(item.Name, "Fruit") then
                replicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name)
            end
        end
    end)
end

local function hopServer()
    StatusLabel.Text = "No fruit, hopping..."
    while task.wait(1) do
        local success, req = pcall(function() return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100") end)
        if success and req then
            local body = httpservice:JSONDecode(req)
            for _, s in ipairs(body.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    StatusLabel.Text = "Found server, teleporting..."
                    teleportservice:TeleportToPlaceInstance(game.PlaceId, s.id, player)
                    task.wait(10)
                end
            end
        end
        StatusLabel.Text = "Server full, searching again..."
    end
end

local function checkAndCollectFruit()
    local found = false
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") and string.find(obj.Name, "Fruit") then
                found = true
                StatusLabel.Text = "Found: " + obj.Name
                player.Character.HumanoidRootPart.CFrame = obj.Handle.CFrame
                task.wait(0.5)
                firetouchinterest(player.Character.HumanoidRootPart, obj.Handle, 0)
                firetouchinterest(player.Character.HumanoidRootPart, obj.Handle, 1)
                task.wait(1)
                storeFruits()
            end
        end
    end)
    return found
end

task.spawn(function()
    task.wait(3)
    autoJoinPirates()
    task.wait(2)
    if not checkAndCollectFruit() then
        hopServer()
    end
end)
