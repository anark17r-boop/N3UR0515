-- c00lkid Reborn RCT Blue Version by xbx
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/anark17r-boop/N3UR0515/refs/heads/main/N3UR0515.lua"))()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание GUI
local GUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabFolder = Instance.new("Folder")
local ExploitingTab = Instance.new("Frame")
local BlueFireBtn = Instance.new("TextButton")
local BlueDesksBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

GUI.Name = "c00lkid_GUI"
GUI.Parent = game.CoreGui
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = GUI
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 300)

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 0, 0.02, 0)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.SciFi
Title.Text = "c00lkid Reborn RCT BLUE EDITION"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

TabFolder.Name = "TabFolder"
TabFolder.Parent = MainFrame

ExploitingTab.Name = "ExploitingTab"
ExploitingTab.Parent = TabFolder
ExploitingTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ExploitingTab.BorderSizePixel = 0
ExploitingTab.Position = UDim2.new(0.02, 0, 0.1, 0)
ExploitingTab.Size = UDim2.new(0.96, 0, 0.88, 0)
ExploitingTab.Visible = true

BlueFireBtn.Name = "BlueFireBtn"
BlueFireBtn.Parent = ExploitingTab
BlueFireBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
BlueFireBtn.BorderSizePixel = 0
BlueFireBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
BlueFireBtn.Size = UDim2.new(0.4, 0, 0.2, 0)
BlueFireBtn.Font = Enum.Font.SciFi
BlueFireBtn.Text = "Blue Fire Sky"
BlueFireBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BlueFireBtn.TextSize = 16.000
BlueFireBtn.TextWrapped = true

BlueDesksBtn.Name = "BlueDesksBtn"
BlueDesksBtn.Parent = ExploitingTab
BlueDesksBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
BlueDesksBtn.BorderSizePixel = 0
BlueDesksBtn.Position = UDim2.new(0.55, 0, 0.1, 0)
BlueDesksBtn.Size = UDim2.new(0.4, 0, 0.2, 0)
BlueDesksBtn.Font = Enum.Font.SciFi
BlueDesksBtn.Text = "Blue Burning Desks"
BlueDesksBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BlueDesksBtn.TextSize = 16.000
BlueDesksBtn.TextWrapped = true

-- Функция синего неба для всех
local function BlueFireSky()
    local sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
    sky.Parent = Lighting
    
    -- Синее огненное небо
    sky.SkyboxBk = "rbxassetid://9851144466"
    sky.SkyboxDn = "rbxassetid://9851144466"
    sky.SkyboxFt = "rbxassetid://9851144466"
    sky.SkyboxLf = "rbxassetid://9851144466"
    sky.SkyboxRt = "rbxassetid://9851144466"
    sky.SkyboxUp = "rbxassetid://9851144466"
    
    -- Синхронизация для всех игроков
    local remote = ReplicatedStorage:FindFirstChild("SkyChange") or Instance.new("RemoteEvent")
    remote.Name = "SkyChange"
    remote.Parent = ReplicatedStorage
    
    remote.OnServerEvent:Connect(function(player, skyData)
        for _, plr in pairs(Players:GetPlayers()) do
            remote:FireClient(plr, skyData)
        end
    end)
end

-- Функция горящих синих парт для всех
local function BlueBurningDesks()
    local remote = ReplicatedStorage:FindFirstChild("DeskChange") or Instance.new("RemoteEvent")
    remote.Name = "DeskChange"
    remote.Parent = ReplicatedStorage
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("desk") or obj.Name:lower():find("part")) then
            -- Изменение цвета на синий
            obj.BrickColor = BrickColor.new("Bright blue")
            obj.Material = Enum.Material.Neon
            
            -- Создание синего огня
            local fire = Instance.new("Fire")
            fire.Color = Color3.new(0, 0.3, 1)
            fire.SecondaryColor = Color3.new(0, 0.1, 0.6)
            fire.Size = 5
            fire.Heat = 10
            fire.Parent = obj
        end
    end
    
    -- Синхронизация для всех игроков
    remote.OnServerEvent:Connect(function(player, deskData)
        for _, plr in pairs(Players:GetPlayers()) do
            remote:FireClient(plr, deskData)
        end
    end)
end

-- Обработчики кнопок
BlueFireBtn.MouseButton1Click:Connect(BlueFireSky)
BlueDesksBtn.MouseButton1Click:Connect(BlueBurningDesks)

print("c00lkid Reborn RCT BLUE EDITION loaded successfully!")
