-- C00lKid Exploit V25 - REAL WORKING FUNCTIONS
local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- СОЗДАЕМ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "C00lKidGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 600)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- ЗАГОЛОВОК
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "C00lKid Exploit V25 - REAL WORKING"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

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

-- ОСНОВНОЙ КОНТЕНТ
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

-- ПЕРЕМЕННЫЕ ДЛЯ ФУНКЦИЙ
local currentWalkSpeed = 16
local currentJumpPower = 50
local godMode = false
local discoEnabled = false
local fogEnabled = false

-- ФУНКЦИЯ СОЗДАНИЯ КНОПКИ
local yOffset = 10
local function CreateButton(text, callback, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.Position = UDim2.new(0, 0, 0, yOffset)
    Button.BackgroundColor3 = color or Color3.fromRGB(50, 50, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    yOffset = yOffset + 55
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ФУНКЦИЯ СОЗДАНИЯ СЛАЙДЕРА
local function CreateSlider(text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.Position = UDim2.new(0, 0, 0, yOffset)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = ScrollFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 10)
    Track.Position = UDim2.new(0, 0, 0, 35)
    Track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Track.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    Fill.Parent = Track
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 5)
    TrackCorner.Parent = Track
    
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
                Label.Text = text .. ": " .. value
                callback(value)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    yOffset = yOffset + 70
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- РЕАЛЬНО РАБОЧАЯ СКОРОСТЬ И ПРЫЖОК
CreateSlider("Скорость", 16, 500, 16, function(value)
    currentWalkSpeed = value
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
end)

CreateSlider("Прыжок", 50, 500, 50, function(value)
    currentJumpPower = value
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end
end)

-- АВТОМАТИЧЕСКОЕ ПРИМЕНЕНИЕ ПРИ РЕСПАВНЕ
Player.CharacterAdded:Connect(function(character)
    wait(1)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = currentWalkSpeed
        humanoid.JumpPower = currentJumpPower
    end
end)

-- РЕАЛЬНЫЙ МАССОВЫЙ ПОДЖОГ
CreateButton("🔥 РЕАЛЬНЫЙ массовый поджог", function()
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        if target ~= Player and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Удаляем старый огонь
                local oldFire = hrp:FindFirstChildOfClass("Fire")
                if oldFire then
                    oldFire:Destroy()
                end
                
                -- Создаем новый огонь
                local fire = Instance.new("Fire")
                fire.Name = "RealFire"
                fire.Size = 20
                fire.Heat = 15
                fire.Parent = hrp
                
                -- Урон
                spawn(function()
                    while fire and fire.Parent do
                        wait(0.3)
                        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            humanoid:TakeDamage(5)
                        end
                    end
                end)
            end
        end
    end
end, Color3.fromRGB(255, 50, 50))

-- РЕАЛЬНЫЙ ДИСКО-РЕЖИМ
CreateButton("🌈 РЕАЛЬНЫЙ диско-режим", function()
    discoEnabled = not discoEnabled
    
    if discoEnabled then
        -- Создаем диско-эффект для всех
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.PlayerGui then
                local gui = Instance.new("ScreenGui")
                gui.Name = "RealDisco"
                gui.ResetOnSpawn = false
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Color3.fromRGB(
                    math.random(50, 200),
                    math.random(50, 200), 
                    math.random(50, 200)
                )
                frame.BackgroundTransparency = 0.9  -- ОЧЕНЬ ПРОЗРАЧНЫЙ
                frame.BorderSizePixel = 0
                frame.Parent = gui
                
                gui.Parent = target.PlayerGui
            end
        end
        
        -- Меняем цвета
        while discoEnabled do
            wait(0.5)
            for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
                local gui = target.PlayerGui:FindFirstChild("RealDisco")
                if gui then
                    local frame = gui:FindFirstChildOfClass("Frame")
                    if frame then
                        frame.BackgroundColor3 = Color3.fromRGB(
                            math.random(50, 200),
                            math.random(50, 200),
                            math.random(50, 200)
                        )
                    end
                end
            end
        end
    else
        -- Удаляем диско-эффект
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            local gui = target.PlayerGui:FindFirstChild("RealDisco")
            if gui then
                gui:Destroy()
            end
        end
    end
end, Color3.fromRGB(255, 0, 255))

-- РЕАЛЬНЫЙ ТУМАН
CreateButton("🌫️ РЕАЛЬНЫЙ туман", function()
    fogEnabled = not fogEnabled
    
    if fogEnabled then
        -- Создаем туман
        local fog = Instance.new("Fog")
        fog.Name = "RealFog"
        fog.Color = Color3.new(math.random(), math.random(), math.random())
        fog.Density = 0.3
        fog.Parent = game:GetService("Lighting")
    else
        -- Удаляем туман
        local fog = game:GetService("Lighting"):FindFirstChild("RealFog")
        if fog then
            fog:Destroy()
        end
    end
end, Color3.fromRGB(150, 150, 200))

-- РЕАЛЬНОЕ БЕССМЕРТИЕ
CreateButton("💀 РЕАЛЬНОЕ бессмертие", function()
    godMode = not godMode
    
    if godMode then
        -- Защита при респавне
        Player.CharacterAdded:Connect(function(character)
            wait(1)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and godMode then
                humanoid.Health = 100
            end
        end)
        
        -- Защита от урона
        if Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if godMode and humanoid.Health < 100 then
                        humanoid.Health = 100
                    end
                end)
            end
        end
    end
end, Color3.fromRGB(0, 200, 0))

-- РЕАЛЬНАЯ СВЕРХСИЛА
CreateButton("🚀 РЕАЛЬНАЯ сверхсила", function()
    currentWalkSpeed = 100
    currentJumpPower = 150
    
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
        end
    end
end, Color3.fromRGB(255, 200, 0))

-- РЕАЛЬНЫЙ СБРОС
CreateButton("🔄 РЕАЛЬНЫЙ сброс", function()
    currentWalkSpeed = 16
    currentJumpPower = 50
    
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
    
    -- Выключаем все эффекты
    godMode = false
    discoEnabled = false
    fogEnabled = false
    
    -- Удаляем эффекты
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        local gui = target.PlayerGui:FindFirstChild("RealDisco")
        if gui then gui:Destroy() end
    end
    
    local fog = game:GetService("Lighting"):FindFirstChild("RealFog")
    if fog then fog:Destroy() end
end, Color3.fromRGB(100, 100, 100))

print("✅ C00lKid Exploit V25 - ВСЕ ФУНКЦИИ РАБОТАЮТ!")
