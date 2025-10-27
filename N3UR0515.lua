-- C00lKid Brookhaven Exploit V26 - Special Edition
local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- СОЗДАЕМ ПРЕМИУМ GUI С ВКЛАДКАМИ
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "C00lKidBrookhavenGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 550)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- ЗАГОЛОВОК
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚗 C00lKid Brookhaven V26 🚗"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- ВКЛАДКИ
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TabsFrame.Parent = MainFrame

local Tabs = {
    "🚀 Основные",
    "🎮 Brookhaven", 
    "🔥 Троллинг",
    "🌈 Визуал",
    "⚙️ Другое"
}

local CurrentTab = "🚀 Основные"
local TabButtons = {}

-- СОЗДАЕМ КНОПКИ ВКЛАДОК
for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1/#Tabs, 0, 1, 0)
    TabButton.Position = UDim2.new((i-1)/#Tabs, 0, 0, 0)
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(25, 25, 25)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 12
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabsFrame
    
    TabButton.MouseButton1Click:Connect(function()
        CurrentTab = tabName
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        UpdateContent()
    end)
    
    table.insert(TabButtons, TabButton)
end

-- ОБЛАСТЬ КОНТЕНТА
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -10)
ScrollFrame.Position = UDim2.new(0, 5, 0, 5)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = ContentFrame

-- ПЕРЕТАСКИВАНИЕ
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ФУНКЦИИ ДЛЯ GUI
local function CreateButton(text, callback, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = color or Color3.fromRGB(35, 35, 35)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.Font = Enum.Font.Gotham
    Button.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
end

local function CreateSection(title)
    local Section = Instance.new("TextLabel")
    Section.Size = UDim2.new(1, 0, 0, 25)
    Section.BackgroundTransparency = 1
    Section.Text = " " .. title
    Section.TextColor3 = Color3.fromRGB(200, 200, 200)
    Section.TextSize = 14
    Section.Font = Enum.Font.GothamBold
    Section.TextXAlignment = Enum.TextXAlignment.Left
    Section.Parent = ScrollFrame
end

-- ПЕРЕМЕННЫЕ
local currentWalkSpeed = 16
local currentJumpPower = 50

-- ОСНОВНЫЕ ФУНКЦИИ
local function BasicFunctions()
    ScrollFrame:ClearAllChildren()
    local y = 0
    
    CreateSection("Персонаж")
    
    local function AddButton(text, callback, color)
        local btn = CreateButton(text, callback, color)
        btn.Position = UDim2.new(0, 0, 0, y)
        y = y + 45
    end
    
    AddButton("🚀 Скорость 100", function()
        currentWalkSpeed = 100
        if Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = 100 end
        end
    end, Color3.fromRGB(255, 100, 0))
    
    AddButton("🦘 Прыжок 150", function()
        currentJumpPower = 150
        if Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.JumpPower = 150 end
        end
    end, Color3.fromRGB(0, 150, 255))
    
    AddButton("💀 Бессмертие", function()
        if Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if humanoid.Health < 100 then
                        humanoid.Health = 100
                    end
                end)
            end
        end
    end, Color3.fromRGB(255, 50, 50))
    
    AddButton("🔄 Сброс настроек", function()
        currentWalkSpeed = 16
        currentJumpPower = 50
        if Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
        end
    end, Color3.fromRGB(100, 100, 100))
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- СПЕЦИАЛЬНЫЕ ФУНКЦИИ ДЛЯ BROOKHAVEN
local function BrookhavenFunctions()
    ScrollFrame:ClearAllChildren()
    local y = 0
    
    CreateSection("Специально для Brookhaven")
    
    local function AddButton(text, callback, color)
        local btn = CreateButton(text, callback, color)
        btn.Position = UDim2.new(0, 0, 0, y)
        y = y + 45
    end
    
    -- 5 НОВЫХ ФУНКЦИЙ ДЛЯ ВСЕХ ИГРОКОВ
    AddButton("🚗 МАССОВЫЙ ТЮНИНГ", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.Character then
                -- Добавляем неоновые огни к машинам
                local car = target.Character:FindFirstChild("VehicleSeat")
                if car then
                    local neon = Instance.new("PointLight")
                    neon.Name = "MassNeon"
                    neon.Color = Color3.new(math.random(), math.random(), math.random())
                    neon.Range = 15
                    neon.Brightness = 5
                    neon.Parent = car
                end
            end
        end
    end, Color3.fromRGB(255, 0, 255))
    
    AddButton("🏠 ГИГАНТСКИЕ ДОМА", function()
        for _, house in ipairs(workspace:GetChildren()) do
            if house.Name:find("House") or house.Name:find("Build") then
                house.Size = house.Size * 2
            end
        end
    end, Color3.fromRGB(0, 255, 255))
    
    AddButton("🌌 КОСМИЧЕСКОЕ НЕБО", function()
        local sky = Instance.new("Sky")
        sky.Name = "BrookhavenSky"
        sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxDn = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxFt = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxLf = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxRt = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxUp = "http://www.roblox.com/asset/?id=159454299"
        sky.Parent = game:GetService("Lighting")
    end, Color3.fromRGB(0, 100, 255))
    
    AddButton("💥 ВЗРЫВ АВТОМОБИЛЕЙ", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.Character then
                local car = target.Character:FindFirstChild("VehicleSeat")
                if car then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = car.Position
                    explosion.BlastPressure = 0
                    explosion.BlastRadius = 10
                    explosion.Visible = true
                    explosion.Parent = workspace
                end
            end
        end
    end, Color3.fromRGB(255, 100, 0))
    
    AddButton("🎵 МАССОВАЯ МУЗЫКА", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.Character then
                local sound = Instance.new("Sound")
                sound.Name = "MassMusic"
                sound.SoundId = "rbxassetid://9111268331" -- Популярная музыка
                sound.Volume = 1
                sound.Looped = true
                sound.Parent = target.Character:FindFirstChild("HumanoidRootPart")
                sound:Play()
            end
        end
    end, Color3.fromRGB(255, 200, 0))
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- ТРОЛЛИНГ ФУНКЦИИ
local function TrollingFunctions()
    ScrollFrame:ClearAllChildren()
    local y = 0
    
    CreateSection("Троллинг для всех")
    
    local function AddButton(text, callback, color)
        local btn = CreateButton(text, callback, color)
        btn.Position = UDim2.new(0, 0, 0, y)
        y = y + 45
    end
    
    AddButton("🔥 МАССОВЫЙ ПОЖАР", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target ~= Player and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local fire = Instance.new("Fire")
                    fire.Name = "MassFire"
                    fire.Size = 25
                    fire.Heat = 20
                    fire.Parent = hrp
                end
            end
        end
    end, Color3.fromRGB(255, 50, 50))
    
    AddButton("🌀 ТЕЛЕПОРТ В НЕБО", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target ~= Player and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 300, 0)
                end
            end
        end
    end, Color3.fromRGB(0, 200, 200))
    
    AddButton("🎭 НЕВИДИМЫЙ ДИСКО", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.PlayerGui then
                local gui = Instance.new("ScreenGui")
                gui.Name = "InvisibleDisco"
                gui.ResetOnSpawn = false
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
                frame.BackgroundTransparency = 0.95 -- Почти невидимый
                frame.BorderSizePixel = 0
                frame.Parent = gui
                
                gui.Parent = target.PlayerGui
            end
        end
    end, Color3.fromRGB(255, 0, 255))
    
    AddButton("❄️ ЛЕДЯНОЙ ПОЛ", function()
        local icePart = Instance.new("Part")
        icePart.Name = "MassIceFloor"
        icePart.Size = Vector3.new(500, 1, 500)
        icePart.Position = Vector3.new(0, 0, 0)
        icePart.Anchored = true
        icePart.CanCollide = true
        icePart.BrickColor = BrickColor.new("Light blue")
        icePart.Material = Enum.Material.Ice
        icePart.Parent = workspace
    end, Color3.fromRGB(0, 150, 255))
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- ВИЗУАЛЬНЫЕ ФУНКЦИИ
local function VisualFunctions()
    ScrollFrame:ClearAllChildren()
    local y = 0
    
    CreateSection("Визуальные эффекты")
    
    local function AddButton(text, callback, color)
        local btn = CreateButton(text, callback, color)
        btn.Position = UDim2.new(0, 0, 0, y)
        y = y + 45
    end
    
    AddButton("🌫️ РЕАЛЬНЫЙ ТУМАН", function()
        local fog = Instance.new("Fog")
        fog.Name = "RealFog"
        fog.Color = Color3.new(0.7, 0.7, 0.8)
        fog.Density = 0.1
        fog.Parent = game:GetService("Lighting")
    end, Color3.fromRGB(150, 150, 200))
    
    AddButton("🌈 РАДУЖНОЕ ОСВЕЩЕНИЕ", function()
        local lighting = game:GetService("Lighting")
        lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
        lighting.OutdoorAmbient = Color3.new(math.random(), math.random(), math.random())
    end, Color3.fromRGB(255, 100, 255))
    
    AddButton("⭐ СИЯНИЕ ИГРОКОВ", function()
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.Character then
                local glow = Instance.new("PointLight")
                glow.Name = "PlayerGlow"
                glow.Color = Color3.new(math.random(), math.random(), math.random())
                glow.Range = 10
                glow.Brightness = 2
                glow.Parent = target.Character:FindFirstChild("HumanoidRootPart")
            end
        end
    end, Color3.fromRGB(255, 255, 0))
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- ДРУГИЕ ФУНКЦИИ
local function OtherFunctions()
    ScrollFrame:ClearAllChildren()
    local y = 0
    
    CreateSection("Дополнительные функции")
    
    local function AddButton(text, callback, color)
        local btn = CreateButton(text, callback, color)
        btn.Position = UDim2.new(0, 0, 0, y)
        y = y + 45
    end
    
    AddButton("🧹 ОЧИСТИТЬ ЭФФЕКТЫ", function()
        -- Очищаем все созданные эффекты
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            local gui = target.PlayerGui:FindFirstChild("InvisibleDisco")
            if gui then gui:Destroy() end
            
            if target.Character then
                local glow = target.Character:FindFirstChild("PlayerGlow")
                if glow then glow:Destroy() end
                
                local sound = target.Character:FindFirstChild("MassMusic")
                if sound then sound:Destroy() end
            end
        end
        
        local fog = game:GetService("Lighting"):FindFirstChild("RealFog")
        if fog then fog:Destroy() end
        
        local sky = game:GetService("Lighting"):FindFirstChild("BrookhavenSky")
        if sky then sky:Destroy() end
        
        local ice = workspace:FindFirstChild("MassIceFloor")
        if ice then ice:Destroy() end
    end, Color3.fromRGB(100, 100, 100))
    
    AddButton("📊 ИНФОРМАЦИЯ О СЕРВЕРЕ", function()
        print("=== ИНФОРМАЦИЯ О СЕРВЕРЕ ===")
        print("Игроков онлайн: " .. #game:GetService("Players"):GetPlayers())
        print("Место: " .. game.PlaceId)
        print("Название игры: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
    end, Color3.fromRGB(0, 150, 150))
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- ОБНОВЛЕНИЕ КОНТЕНТА
function UpdateContent()
    if CurrentTab == "🚀 Основные" then
        BasicFunctions()
    elseif CurrentTab == "🎮 Brookhaven" then
        BrookhavenFunctions()
    elseif CurrentTab == "🔥 Троллинг" then
        TrollingFunctions()
    elseif CurrentTab == "🌈 Визуал" then
        VisualFunctions()
    elseif CurrentTab == "⚙️ Другое" then
        OtherFunctions()
    end
end

-- АВТОМАТИЧЕСКОЕ ПРИМЕНЕНИЕ СКОРОСТИ
Player.CharacterAdded:Connect(function(character)
    wait(1)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = currentWalkSpeed
        humanoid.JumpPower = currentJumpPower
    end
end)

-- ЗАПУСК
UpdateContent()
print("✅ C00lKid Brookhaven Exploit V26 загружен!")
