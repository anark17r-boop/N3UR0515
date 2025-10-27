-- [C00lKid Exploit V14 - Venus UI Full Version]
print("🔄 Загрузка Venus UI...")

local Venus = loadstring(game:HttpGet('https://raw.githubusercontent.com/fatesc/fates-venus-ui/main/source.lua'))()

print("✅ Venus UI загружен")

local Window = Venus:New({
    Name = "C00lKid Exploit V14", 
    Position = UDim2.new(0.5, 0, 0.5, 0)
})

print("✅ Окно создано")

-- МЕГА БАЙПАС
print("🛡️ Активация байпаса...")

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

-- СОЗДАЕМ ВКЛАДКИ
local MainTab = Window:Tab("Основные функции")
local TrollingTab = Window:Tab("Троллинг функции")
local VisualTab = Window:Tab("Визуальные эффекты")

print("✅ Вкладки созданы")

-- 1. ФУНКЦИИ СКОРОСТИ И ПРЫЖКА
MainTab:Slider("Скорость передвижения", 16, 500, 16, function(Value)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = Value
        print("🎯 Скорость установлена: " .. Value)
    end
end)

MainTab:Slider("Сила прыжка", 50, 500, 50, function(Value)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = Value
        print("🎯 Сила прыжка установлена: " .. Value)
    end
end)

-- 2. БЕССМЕРТИЕ
local godMode = false
MainTab:Toggle("Режим бессмертия", false, function(Value)
    godMode = Value
    if godMode then
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
                if godMode and humanoid.Health < 100 then
                    humanoid.Health = 100
                end
            end)
        end
    else
        print("🛡️ Бессмертие деактивировано")
    end
end)

-- 3. ПОДЖОГ ВСЕХ ИГРОКОВ
TrollingTab:Button("Поджечь всех игроков", function()
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
    
    print("✅ Все игроки подожжены")
end)

-- 4. ЗАМЕНА НЕБА НА СКИН
VisualTab:Button("Заменить небо на мой скин", function()
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
            
            print("✅ Небо заменено на скин")
        else
            print("❌ Скин не найден")
        end
    end
end)

-- 5. ДИСКО-РЕЖИМ
local discoMode = false
VisualTab:Toggle("Диско-режим для всех", false, function(Value)
    discoMode = Value
    
    if discoMode then
        print("🎭 Диско-режим активирован")
        
        spawn(function()
            while discoMode do
                wait(0.3)
                
                for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                    if targetPlayer.PlayerGui then
                        -- Удаляем старый GUI
                        local oldGui = targetPlayer.PlayerGui:FindFirstChild("DiscoScreen")
                        if oldGui then
                            oldGui:Destroy()
                        end
                        
                        -- Создаем новый диско-экран
                        local discoGui = Instance.new("ScreenGui")
                        discoGui.Name = "DiscoScreen"
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
                local discoGui = targetPlayer.PlayerGui:FindFirstChild("DiscoScreen")
                if discoGui then
                    discoGui:Destroy()
                end
            end
        end
    end
end)

-- 6. СВЕРХСИЛА
MainTab:Button("Активировать сверхсилу", function()
    print("💪 Активация сверхсилы...")
    
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 100
        humanoid.JumpPower = 150
        print("✅ Сверхсила активирована")
    end
end)

-- 7. РЕСЕТ ФУНКЦИЙ
MainTab:Button("Сбросить настройки", function()
    print("🔄 Сброс настроек...")
    
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        print("✅ Настройки сброшены")
    end
end)

print("🎯 C00lKid Exploit V14 полностью загружен и готов к использованию!")
