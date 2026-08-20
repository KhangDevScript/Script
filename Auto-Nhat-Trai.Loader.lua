repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")

local function tpToFruit()
    pcall(function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                if string.find(obj.Name, "Fruit") or obj.Name:match(".*Fruit.*") then
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
end

tpToFruit()

print("Fruit Spawner Loaded!")