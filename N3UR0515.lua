-- [C00lKid Exploit V18 - Rayfield Working Version]
print("🎯 Загрузка Rayfield UI...")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

print("✅ Rayfield загружен")

local Window = Rayfield:CreateWindow({
    Name = "C00lKid Exploit V18",
    LoadingTitle = "C00lKid Exploit",
    LoadingSubtitle = "by Colin",
    ConfigurationSaving = { Enabled = false }
})

print("✅ Окно создано")

-- МЕГА БАЙПАС
local Player = game:GetService("Players").LocalPlayer

-- Защита от кика
hookfunction(Player.Kick, function()
    print("🚫 Кик заблокирован")
    return wait(9e9)
end)

-- Защита через метатаблицы
if hookmetatable then
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if tostring(self) == "LocalPlayer" and method == "Kick" then
            print("🚫 Кик через namecall заблокирован")
            return wait(9e9)
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end

print("✅ Байпас активирован")

-- ОСНОВНЫЕ ФУНКЦИИ
local MainTab = Window:CreateTab("Основные функции")
local TrollingTab = Window:CreateTab("Троллинг функции")
local VisualTab = Window:CreateTab("Визуальные эффекты")

print("✅ Вкладки созданы")

-- 1. СКОРОСТЬ И ПРЫЖОК
MainTab:CreateSlider({
    Name = "Скорость передвижения",
    Range = {16, 500},
    Increment = 1,
    Suffix = "ед.",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Value
            print("🎯 Скорость установлена: " .. Value)
        end
    end,
})

MainTab:CreateSlider({
    Name = "Сила прыжка",
    Range = {50, 500},
    Increment = 1,
    Suffix = "ед.",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = Value
            print("🎯 Сила прыжка установлена: " .. Value)
        end
    end,
})

-- 2. БЕССМЕРТИЕ
MainTab:CreateToggle({
    Name = "Режим бессмертия",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value)
        if Value then
            print("🛡️ Бессмертие активировано")
            
            -- Защита при респавне
            Player.CharacterAdded:Connect(function(character)
                wait(1)
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 100
                end
            end)
            
            -- Защита от урона
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if humanoid.Health < 100 then
                        humanoid.Health = 100
                    end
                end)
            end
        else
            print("🛡️ Бессмертие деактивировано")
        end
    end,
})

-- 3. ПОДЖОГ ВСЕХ ИГРОКОВ
TrollingTab:CreateButton({
    Name = "Поджечь всех игроков",
    Callback = function()
        print("🔥 Активация поджога...")
        
        for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
            if targetPlayer ~= Player and targetPlayer.Character then
                local humanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    -- Создаем огонь
                    local fire = Instance.new("Fire")
                    fire.Name = "C00lKidFire"
                    fire.Size = 25
                    fire.Heat = 15
                    fire.Parent = humanoidRootPart
                    
                    -- Наносим урон
                    spawn(function()
                        while fire and fire.Parent do
                            wait(0.5)
                            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                            if targetHumanoid then
                                targetHumanoid:TakeDamage(8)
                            end
                        end
                    end)
                    
                    -- Репликация
                    fire:SetNetworkOwner(nil)
                end
            end
        end
        
        Rayfield:Notify({
            Title = "Успех!",
            Content = "Все игроки подожжены!",
            Duration = 5,
            Image = 4483362458
        })
        
        print("✅ Все игроки подожжены")
    end,
})

-- 4. ЗАМЕНА НЕБА НА СКИН
VisualTab:CreateButton({
    Name = "Заменить небо на мой скин",
    Callback = function()
        print("🌌 Замена неба...")
        
        local character = Player.Character
        if character then
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
                
                -- Создаем новое небо
                local newSky = Instance.new("Sky")
                newSky.SkyboxBk = textureId
                newSky.SkyboxDn = textureId
                newSky.SkyboxFt = textureId
                newSky.SkyboxLf = textureId
                newSky.SkyboxRt = textureId
                newSky.SkyboxUp = textureId
                newSky.Parent = game:GetService("Lighting")
                
                -- Репликация
                game:GetService("Lighting"):SetNetworkOwner(nil)
                
                Rayfield:Notify({
                    Title = "Успех!",
                    Content = "Небо заменено на ваш скин!",
                    Duration = 5,
                    Image = 4483362458
                })
                
                print("✅ Небо заменено на скин")
            else
                Rayfield:Notify({
                    Title = "Ошибка!",
                    Content = "Скин не найден!",
                    Duration = 5,
                    Image = 4483362458
                })
                
                print("❌ Скин не найден")
            end
        end
    end,
})

-- 5. ДИСКО-РЕЖИМ
VisualTab:CreateToggle({
    Name = "Диско-режим для всех",
    CurrentValue = false,
    Flag = "DiscoMode",
    Callback = function(Value)
        if Value then
            print("🎭 Диско-режим активирован")
            
            spawn(function()
                while Rayfield.Flags["DiscoMode"] do
                    wait(0.3)
                    
                    for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                        if targetPlayer.PlayerGui then
                            -- Удаляем старый GUI
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
                            discoFrame.BackgroundTransparency = 0.2
                            discoFrame.BorderSizePixel = 0
                            discoFrame.Parent = discoGui
                            
                            discoGui.Parent = targetPlayer.PlayerGui
                            
                            -- Репликация
                            discoGui:SetNetworkOwner(nil)
                        end
                    end
                end
            end)
        else
            print("🎭 Диско-режим деактивирован")
            
            for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                if targetPlayer.PlayerGui then
                    local discoGui = targetPlayer.PlayerGui:FindFirstChild("DiscoEffectGui")
                    if discoGui then
                        discoGui:Destroy()
                    end
                end
            end
        end
    end,
})

-- 6. ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ
MainTab:CreateButton({
    Name = "Активировать сверхсилу",
    Callback = function()
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
            Rayfield:Notify({
                Title = "Успех!",
                Content = "Сверхсила активирована!",
                Duration = 5,
                Image = 4483362458
            })
            print("💪 Сверхсила активирована")
        end
    end,
})

MainTab:CreateButton({
    Name = "Сбросить настройки",
    Callback = function()
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            Rayfield:Notify({
                Title = "Успех!",
                Content = "Настройки сброшены!",
                Duration = 5,
                Image = 4483362458
            })
            print("🔄 Настройки сброшены")
        end
    end,
})

Rayfield:LoadConfiguration()
print("🎯 C00lKid Exploit V18 полностью загружен и готов к использованию!")
