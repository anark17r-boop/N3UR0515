-- [C00lKid Exploit V6 - Full Menu Version]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "C00lKid Exploit V6",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Enhanced Bypass Active",
    ConfigurationSaving = { Enabled = false }
})

-- A. УЛУЧШЕННЫЙ БАЙПАС
hookfunction(game:GetService("Players").LocalPlayer.Kick, function()
    return wait(9e9)
end)

if hookmetatable then
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if tostring(self) == "LocalPlayer" and method == "Kick" then
            return wait(9e9)
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end

-- B. ОСНОВНЫЕ ТАБЫ
local MainTab = Window:CreateTab("Основные функции")
local VisualTab = Window:CreateTab("Визуал")
local TrollingTab = Window:CreateTab("Троллинг")

-- 1. ФУНКЦИЯ БЕССМЕРТИЯ
MainTab:CreateToggle({
    Name = "📛 Бессмертие",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value)
        if Value then
            -- A. Защита от урона
            game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 100
            end)
            
            -- B. Отключение коллизий
            for _, part in ipairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            
            -- C. Защита при респавне
            game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
                wait(1)
                game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 100
            end)
        end
    end,
})

-- 2. ЗАМЕНА НЕБА НА СКИН
VisualTab:CreateButton({
    Name = "🌌 Заменить небо на мой скин",
    Callback = function()
        -- A. Поиск скина
        local skin = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Shirt") 
        if not skin then
            skin = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Pants")
        end
        
        if skin then
            -- B. Создание нового неба
            local sky = Instance.new("Sky")
            sky.SkyboxBk = skin.Decale
            sky.SkyboxDn = skin.Decale  
            sky.SkyboxFt = skin.Decale
            sky.SkyboxLf = skin.Decale
            sky.SkyboxRt = skin.Decale
            sky.SkyboxUp = skin.Decale
            sky.Parent = game:GetService("Lighting")
            
            -- C. Репликация для всех игроков
            game:GetService("Lighting"):SetNetworkOwner(nil)
        end
    end,
})

-- 3. ПОДЖОГ ВСЕХ ИГРОКОВ
TrollingTab:CreateButton({
    Name = "🔥 Поджечь всех игроков",
    Callback = function()
        for i, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer then
                -- A. Создание огня
                local fire = Instance.new("Fire")
                fire.Size = 15
                fire.Parent = player.Character:FindFirstChild("HumanoidRootPart")
                
                -- B. Нанесение периодического урона
                spawn(function()
                    while fire.Parent do
                        wait(0.3)
                        player.Character.Humanoid:TakeDamage(15)
                    end
                end)
                
                -- C. Репликация эффекта
                fire:SetNetworkOwner(nil)
            end
        end
    end,
})

-- 4. ДИСКО-РЕЖИМ
TrollingTab:CreateToggle({
    Name = "🎭 Диско-режим для всех",
    CurrentValue = false,
    Flag = "DiscoMode",
    Callback = function(Value)
        if Value then
            -- A. Запуск цветового цикла
            while Rayfield.Flags["DiscoMode"] do
                wait(0.2)
                -- B. Применение ко всем игрокам
                for i, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    -- Очистка старых GUI
                    if player.PlayerGui:FindFirstChild("DiscoScreen") then
                        player.PlayerGui.DiscoScreen:Destroy()
                    end
                    
                    -- Создание нового GUI
                    local gui = Instance.new("ScreenGui")
                    gui.Name = "DiscoScreen"
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
                    frame.Parent = gui
                    gui.Parent = player.PlayerGui
                    
                    -- C. Репликация эффекта
                    gui:SetNetworkOwner(nil)
                end
            end
        else
            -- D. Очистка при выключении
            for i, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.PlayerGui:FindFirstChild("DiscoScreen") then
                    player.PlayerGui.DiscoScreen:Destroy()
                end
            end
        end
    end,
})

-- 5. ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ
MainTab:CreateButton({
    Name = "⚡ Сверхскорость",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
})

MainTab:CreateButton({
    Name = "🦘 Супер-прыжок", 
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = 150
    end
})

-- АКТИВАЦИЯ ИНТЕРФЕЙСА
Rayfield:LoadConfiguration()
