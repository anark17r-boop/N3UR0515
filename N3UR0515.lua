-- [C00lKid Exploit V8 - Orion UI]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "C00lKid Exploit V8", HidePremium = false, SaveConfig = false, IntroEnabled = true, IntroText = "ULTIMATE EXPLOIT"})

-- БАЙПАС
hookfunction(game:GetService("Players").LocalPlayer.Kick, function()
    return wait(9e9)
end)

-- ВКЛАДКИ
local MainTab = Window:MakeTab({Name = "Основные", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local VisualTab = Window:MakeTab({Name = "Визуал", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local TrollingTab = Window:MakeTab({Name = "Троллинг", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- 1. СКОРОСТЬ И ПРЫЖОК
MainTab:AddSlider({Name = "Скорость", Min = 16, Max = 500, Default = 16, Color = Color3.fromRGB(255,0,0), Increment = 1, ValueName = "studs", Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end})

MainTab:AddSlider({Name = "Сила прыжка", Min = 50, Max = 500, Default = 50, Color = Color3.fromRGB(0,255,0), Increment = 1, ValueName = "power", Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end})

-- 2. ФИКСИРОВАННЫЙ ПОДЖОГ
TrollingTab:AddButton({Name = "Поджечь всех", Callback = function()
    for i, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local fire = Instance.new("Fire")
                fire.Size = 20
                fire.Heat = 15
                fire.Parent = hrp
                
                -- Репликация
                fire:SetNetworkOwner(nil)
            end
        end
    end
    OrionLib:MakeNotification({Name = "Успех!", Content = "Все игроки горят!", Image = "rbxassetid://4483345998", Time = 5})
end})

-- 3. ФИКСИРОВАННОЕ НЕБО
VisualTab:AddButton({Name = "Заменить небо на скин", Callback = function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        local shirt = character:FindFirstChildOfClass("Shirt")
        local pants = character:FindFirstChildOfClass("Pants")
        
        if shirt or pants then
            local decalId = shirt and shirt.ShirtTemplate or pants and pants.PantsTemplate
            if decalId then
                local sky = Instance.new("Sky")
                sky.SkyboxBk = decalId
                sky.SkyboxDn = decalId
                sky.SkyboxFt = decalId
                sky.SkyboxLf = decalId
                sky.SkyboxRt = decalId
                sky.SkyboxUp = decalId
                sky.Parent = game.Lighting
                
                game.Lighting:SetNetworkOwner(nil)
                OrionLib:MakeNotification({Name = "Успех!", Content = "Небо заменено!", Image = "rbxassetid://4483345998", Time = 5})
            end
        end
    end
end})

-- 4. ФИКСИРОВАННЫЙ ДИСКО-РЕЖИМ
local discoEnabled = false
TrollingTab:AddToggle({Name = "Диско-режим", Default = false, Callback = function(Value)
    discoEnabled = Value
    while discoEnabled do
        wait(0.3)
        for i, player in ipairs(game.Players:GetPlayers()) do
            if player.PlayerGui then
                local gui = player.PlayerGui:FindFirstChild("DiscoGui") or Instance.new("ScreenGui")
                gui.Name = "DiscoGui"
                gui.ResetOnSpawn = false
                
                local frame = gui:FindFirstChild("DiscoFrame") or Instance.new("Frame")
                frame.Name = "DiscoFrame"
                frame.Size = UDim2.new(1,0,1,0)
                frame.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                frame.Parent = gui
                gui.Parent = player.PlayerGui
                
                gui:SetNetworkOwner(nil)
            end
        end
    end
    
    if not Value then
        for i, player in ipairs(game.Players:GetPlayers()) do
            local gui = player.PlayerGui:FindFirstChild("DiscoGui")
            if gui then gui:Destroy() end
        end
    end
end})

OrionLib:Init()
