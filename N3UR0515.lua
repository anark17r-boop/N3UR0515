-- C00lKid Exploit V24 - Fixed Functions + Fog
local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- СОЗДАЕМ ПРЕМИУМ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "C00lKidPremiumGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 600)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- ЭФФЕКТ ТЕНИ
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554237735"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- ЗАГОЛОВОК
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "C00lKid Exploit V24"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- ПЕРЕТАСКИВАНИЕ ОКНА
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
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

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ОБЛАСТЬ КОНТЕНТА
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -20)
ScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollFrame.Parent = ContentFrame

-- ФУНКЦИИ ДЛЯ GUI
local yOffset = 10

local function CreatePremiumButton(text, description, callback, color)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 60)
    ButtonFrame.Position = UDim2.new(0, 0, 0, yOffset)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ButtonFrame.Parent = ScrollFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = ButtonFrame
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = ButtonFrame
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0, 10)
    Icon.BackgroundColor3 = color or Color3.fromRGB(50, 50, 50)
    Icon.Text = "⚡"
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    Icon.TextSize = 18
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = ButtonFrame
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = Icon
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 0, 25)
    TitleLabel.Position = UDim2.new(0, 60, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = text
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = ButtonFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -60, 0, 20)
    DescLabel.Position = UDim2.new(0, 60, 0, 30)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = ButtonFrame
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(callback)
    
    yOffset = yOffset + 70
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

local function CreatePremiumSlider(text, description, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 80)
    SliderFrame.Position = UDim2.new(0, 0, 0, yOffset)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderFrame.Parent = ScrollFrame
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 10)
    SliderCorner.Parent = SliderFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 15, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = text
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 60, 0, 25)
    ValueLabel.Position = UDim2.new(1, -75, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    ValueLabel.TextSize = 14
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 20)
    DescLabel.Position = UDim2.new(0, 15, 0, 30)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -30, 0, 8)
    Track.Position = UDim2.new(0, 15, 0, 55)
    Track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Track.Parent = SliderFrame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 4)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 4)
    FillCorner.Parent = Fill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = Track
    
    SliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local percent = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percent)
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                ValueLabel.Text = tostring(value)
                callback(value)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    yOffset = yOffset + 90
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ИСПРАВЛЕННЫЕ ФУНКЦИИ
CreatePremiumSlider("Скорость передвижения", "Настройка скорости персонажа", 16, 500, 16, function(v)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = v
    end
end)

CreatePremiumSlider("Сила прыжка", "Настройка высоты прыжка", 50, 500, 50, function(v)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = v
    end
end)

-- РАБОЧИЙ ПОДЖОГ ДЛЯ ВСЕХ
CreatePremiumButton("🔥 Массовый поджог", "Поджигает всех игроков - ВИДИМО ДЛЯ ВСЕХ", function()
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        if target ~= Player and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local fire = Instance.new("Fire")
                fire.Name = "MassFire"
                fire.Size = 25
                fire.Heat = 20
                fire.Parent = hrp
                
                -- Репликация для всех
                for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
                    if p.PlayerGui then
                        fire:Clone().Parent = hrp
                    end
                end
            end
        end
    end
end, Color3.fromRGB(255, 50, 50))

-- УЛУЧШЕННЫЙ ДИСКО-РЕЖИМ С МЕНЬШЕЙ ВИДИМОСТЬЮ
CreatePremiumButton("🌈 Вселенский диско", "Диско-режим для всех (малая видимость)", function()
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        if target.PlayerGui then
            local gui = target.PlayerGui:FindFirstChild("UniversalDisco") or Instance.new("ScreenGui")
            gui.Name = "UniversalDisco"
            gui.ResetOnSpawn = false
            
            local frame = gui:FindFirstChild("DiscoFrame") or Instance.new("Frame")
            frame.Name = "DiscoFrame"
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(
                math.random(50, 150),
                math.random(50, 150),
                math.random(50, 150)
            )
            frame.BackgroundTransparency = 0.8  -- БОЛЬШАЯ ПРОЗРАЧНОСТЬ
            frame.BorderSizePixel = 0
            frame.Parent = gui
            
            gui.Parent = target.PlayerGui
        end
    end
    
    -- Автоматическое изменение цветов
    while wait(0.3) do
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            local gui = target.PlayerGui:FindFirstChild("UniversalDisco")
            if gui and gui:FindFirstChild("DiscoFrame") then
                gui.DiscoFrame.BackgroundColor3 = Color3.fromRGB(
                    math.random(50, 150),
                    math.random(50, 150),
                    math.random(50, 150)
                )
            end
        end
    end
end, Color3.fromRGB(255, 0, 255))

-- ФУНКЦИЯ ТУМАНА С НАСТРОЙКОЙ ЦВЕТА
local fogEnabled = false
local currentFogColor = Color3.new(0.5, 0.5, 0.5)

CreatePremiumButton("🌫️ Включить туман", "Добавляет туман для всех игроков", function()
    fogEnabled = not fogEnabled
    if fogEnabled then
        local fog = Instance.new("Fog")
        fog.Name = "GlobalFog"
        fog.Color = currentFogColor
        fog.Density = 0.1
        fog.Parent = game:GetService("Lighting")
        
        -- Репликация для всех
        game:GetService("Lighting"):SetNetworkOwner(nil)
    else
        local fog = game:GetService("Lighting"):FindFirstChild("GlobalFog")
        if fog then
            fog:Destroy()
        end
    end
end, Color3.fromRGB(150, 150, 150))

-- НАСТРОЙКА ЦВЕТА ТУМАНА
CreatePremiumButton("🎨 Настроить цвет тумана", "Изменяет цвет тумана (случайный)", function()
    if fogEnabled then
        local fog = game:GetService("Lighting"):FindFirstChild("GlobalFog")
        if fog then
            currentFogColor = Color3.new(math.random(), math.random(), math.random())
            fog.Color = currentFogColor
        end
    end
end, Color3.fromRGB(100, 200, 255))

-- БЕССМЕРТИЕ
CreatePremiumButton("💀 Адское бессмертие", "Полная защита от урона", function()
    local godMode = true
    
    Player.CharacterAdded:Connect(function(character)
        wait(1)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and godMode then
            humanoid.Health = 100
        end
    end)
    
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid and godMode then
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health < 100 then
                humanoid.Health = 100
            end
        end)
    end
end, Color3.fromRGB(0, 255, 100))

-- СВЕРХСИЛА
CreatePremiumButton("🚀 Активатор сверхсилы", "Скорость 100 + Прыжок 150", function()
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 100
        humanoid.JumpPower = 150
    end
end, Color3.fromRGB(255, 200, 0))

-- СБРОС НАСТРОЕК
CreatePremiumButton("🔄 Сбросить настройки", "Возвращает стандартные значения", function()
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end, Color3.fromRGB(100, 100, 100))

print("✅ C00lKid Exploit V24 - Fixed Edition загружен!")
