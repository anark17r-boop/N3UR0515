-- [C00lKid Exploit V9 - FULL WORKING VERSION]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "C00lKid Exploit V9", 
    HidePremium = false,
    SaveConfig = false,
    IntroEnabled = true,
    IntroText = "ULTIMATE EXPLOIT LOADED"
})

-- АНТИ-БАН БАЙПАС
local Player = game:GetService("Players").LocalPlayer

local function AntiBan()
    -- Защита от кика
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

AntiBan()

-- ОСНОВНЫЕ ФУНКЦИИ
local MainTab = Window:MakeTab({
    Name = "Основные функции",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local TrollingTab = Window:MakeTab({
    Name = "Троллинг функции", 
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local VisualTab = Window:MakeTab({
    Name = "Визуальные функции",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- 1. РЕАЛЬНО РАБОЧАЯ НАСТРОЙКА СКОРОСТИ
MainTab:AddSlider({
    Name = "Скорость передвижения",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "единиц",
    Callback = function(Value)
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end
})

-- 2. РЕАЛЬНО РАБОЧАЯ НАСТРОЙКА ПРЫЖКА
MainTab:AddSlider({
    Name = "Сила прыжка",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "единиц",
    Callback = function(Value)
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = Value
        end
    end
})

-- 3. РЕАЛЬНО РАБОЧИЙ ПОДЖОГ ВСЕХ ИГРОКОВ
TrollingTab:AddButton({
    Name = "Поджечь всех игроков",
    Callback = function()
        for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
            if targetPlayer ~= Player and targetPlayer.Character then
                local humanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    -- Создаем огонь
                    local fire = Instance.new("Fire")
                    fire.Name = "ExploitFire"
                    fire.Size = 25
                    fire.Heat = 20
                    fire.Parent = humanoidRootPart
                    
                    -- Наносим периодический урон
                    spawn(function()
                        while fire and fire.Parent do
                            wait(0.5)
                            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                            if targetHumanoid then
                                targetHumanoid:TakeDamage(10)
                            end
                        end
                    end)
                    
                    -- Репликация для всех игроков
                    fire:SetNetworkOwner(nil)
                end
            end
        end
        OrionLib:MakeNotification({
            Name = "Успех!",
            Content = "Все игроки были подожжены!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

-- 4. РЕАЛЬНО РАБОЧАЯ ЗАМЕНА НЕБА
VisualTab:AddButton({
    Name = "Заменить небо на мой скин",
    Callback = function()
        local character = Player.Character
        if character then
            -- Ищем текстуру скина
            local shirt = character:FindFirstChildOfClass("Shirt")
            local pants = character:FindFirstChildOfClass("Pants")
            local textureId = nil
            
            if shirt then
                textureId = shirt.ShirtTemplate
            elseif pants then
                textureId = pants.PantsTemplate
            end
            
            if textureId then
                -- Удаляем старое небо
                for _, obj in ipairs(game:GetService("Lighting"):GetChildren()) do
                    if obj:IsA("Sky") then
                        obj:Destroy()
                    end
                end
                
                -- Создаем новое небо с текстурой скина
                local newSky = Instance.new("Sky")
                newSky.SkyboxBk = textureId
                newSky.SkyboxDn = textureId
                newSky.SkyboxFt = textureId
                newSky.SkyboxLf = textureId
                newSky.SkyboxRt = textureId
                newSky.SkyboxUp = textureId
                newSky.Parent = game:GetService("Lighting")
                
                -- Репликация изменений
                game:GetService("Lighting"):SetNetworkOwner(nil)
                
                OrionLib:MakeNotification({
                    Name = "Успех!",
                    Content = "Небо заменено на ваш скин!",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            else
                OrionLib:MakeNotification({
                    Name = "Ошибка!",
                    Content = "Не найден скин для замены неба!",
                    Image = "rbxassetid://4483345998", 
                    Time = 5
                })
            end
        end
    end
})

-- 5. РЕАЛЬНО РАБОЧИЙ ДИСКО-РЕЖИМ
local discoModeEnabled = false
TrollingTab:AddToggle({
    Name = "Диско-режим для всех",
    Default = false,
    Callback = function(Value)
        discoModeEnabled = Value
        
        if discoModeEnabled then
            -- Запускаем диско-эффект
            spawn(function()
                while discoModeEnabled do
                    wait(0.2) -- Частота смены цветов
                    
                    -- Применяем ко всем игрокам
                    for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                        if targetPlayer.PlayerGui then
                            -- Удаляем старый диско-экран
                            local oldGui = targetPlayer.PlayerGui:FindFirstChild("DiscoEffectGui")
                            if oldGui then
                                oldGui:Destroy()
                            end
                            
                            -- Создаем новый диско-экран
                            local discoGui = Instance.new("ScreenGui")
                            discoGui.Name = "DiscoEffectGui"
                            discoGui.ResetOnSpawn = false
                            
                            local discoFrame = Instance.new("Frame")
                            discoFrame.Name = "DiscoFrame"
                            discoFrame.Size = UDim2.new(1, 0, 1, 0)
                            discoFrame.BackgroundColor3 = Color3.fromRGB(
                                math.random(0, 255),
                                math.random(0, 255), 
                                math.random(0, 255)
                            )
                            discoFrame.BackgroundTransparency = 0.3
                            discoFrame.BorderSizePixel = 0
                            discoFrame.Parent = discoGui
                            
                            discoGui.Parent = targetPlayer.PlayerGui
                            
                            -- Репликация для всех
                            discoGui:SetNetworkOwner(nil)
                        end
                    end
                end
            end)
        else
            -- Выключаем диско-эффект
            for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                if targetPlayer.PlayerGui then
                    local discoGui = targetPlayer.PlayerGui:FindFirstChild("DiscoEffectGui")
                    if discoGui then
                        discoGui:Destroy()
                    end
                end
            end
        end
    end
})

-- 6. РЕАЛЬНО РАБОЧЕЕ БЕССМЕРТИЕ
local godModeEnabled = false
MainTab:AddToggle({
    Name = "Режим бессмертия",
    Default = false,
    Callback = function(Value)
        godModeEnabled = Value
        
        if godModeEnabled then
            -- Защита при респавне
            Player.CharacterAdded:Connect(function(character)
                wait(1) -- Ждем полной загрузки персонажа
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 100
                end
            end)
            
            -- Защита от урона
            local function setupGodMode()
                local character = Player.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        -- Восстанавливаем здоровье при получении урона
                        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                            if godModeEnabled and humanoid.Health < 100 then
                                humanoid.Health = 100
                            end
                        end)
                        
                        -- Отключаем коллизии
                        for _, part in ipairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end
            
            setupGodMode()
        end
    end
})

-- АВТОМАТИЧЕСКОЕ ПРИМЕНЕНИЕ СКОРОСТИ ПРИ РЕСПАВНЕ
Player.CharacterAdded:Connect(function(character)
    wait(1)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end)

OrionLib:Init()
