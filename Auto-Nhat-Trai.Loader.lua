repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local httpservice = game:GetService("HttpService")
local teleportservice = game:GetService("TeleportService")

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
StatusLabel.Text = "Checking server for fruits..."
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

local function hopServer()
    StatusLabel.Text = "No fruit, Load new server"
    task.wait(1.5)
    
    local servers = {}
    local success, req = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    end)
    
    if success and req then
        local body = httpservice:JSONDecode(req)
        if body and body.data then
            for _, s in ipairs(body.data) do
                if type(s) == "table" and s.maxPlayers and s.playing and s.id then
                    if s.playing < s.maxPlayers and s.id ~= game.JobId then
                        table.insert(servers, s.id)
                    end
                end
            end
        end
    end
    
    if #servers > 0 then
        local targetServer = servers[math.random(1, #servers)]
        teleportservice:TeleportToPlaceInstance(game.PlaceId, targetServer, player)
    else
        StatusLabel.Text = "Failed to hop, retrying..."
        task.wait(2)
        hopServer()
    end
end

local function checkAndCollectFruit()
    local foundFruit = false
    pcall(function()
        -- Quét cả workspace và thư mục con để bắt trái cây chuẩn hơn
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                if string.find(obj.Name, "Fruit") or obj.Name:match(".*Fruit.*") then
                    foundFruit = true
                    StatusLabel.Text = "Found Fruit: " .. obj.Name
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = obj.Handle.CFrame
                        task.wait(0.5)
                        firetouchinterest(player.Character.HumanoidRootPart, obj.Handle, 0)
                        firetouchinterest(player.Character.HumanoidRootPart, obj.Handle, 1)
                    end
                end
            end
        end
    end)
    return foundFruit
end

task.spawn(function()
    task.wait(3)
    local fruitFound = checkAndCollectFruit()
    
    if not fruitFound then
        hopServer()
    end
end)
