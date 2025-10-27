-- C00lKid Exploit V22 - Custom GUI for Xeno
local Player = game:GetService("Players").LocalPlayer

-- СОЗДАЕМ КАСТОМНЫЙ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "C00lKidXenoGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Title.Text = "C00lKid Exploit V22"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- ФУНКЦИЯ СОЗДАНИЯ КНОПКИ
local yOffset = 70
local function CreateButton(text, callback, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 45)
    Button.Position = UDim2.new(0.05, 0, 0, yOffset)
    Button.BackgroundColor3 = color or Color3.fromRGB(50, 50, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Parent = MainFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    yOffset = yOffset + 55
end

-- ФУНКЦИЯ СОЗДАНИЯ СЛАЙДЕРА
local function CreateSlider(text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0.9, 0, 0, 70)
    SliderFrame.Position = UDim2.new(0.05, 0, 0, yOffset)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = MainFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 15)
    Track.Position = UDim2.new(0, 0, 0, 35)
    Track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Track.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    Fill.Parent = Track
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 7)
    TrackCorner.Parent = Track
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = Track
    
    SliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local percent = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percent)
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                Label.Text = text .. ": " .. value
                callback(value)
            end
        end)
        
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    yOffset = yOffset + 80
end

-- ФУНКЦИЯ СОЗДАНИЯ ТОГГЛА
local function CreateToggle(text, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleFrame.Position = UDim2.new(0.05, 0, 0, yOffset)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = MainFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    ToggleButton.Position = UDim2.new(0, 0, 0, 0)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    ToggleButton.Text = default and "ON" or "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12
    ToggleButton.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 50, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleButton
    
    ToggleButton.MouseButton1Click:Connect(function()
        default = not default
        ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        ToggleButton.Text = default and "ON" or "OFF"
        callback(default)
    end)
    
    yOffset = yOffset + 50
end

-- ОСНОВНЫЕ ФУНКЦИИ
CreateSlider("Скорость", 16, 500, 16, function(v)
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = v
        end
    end
end)

CreateSlider("Прыжок", 50, 500, 50, function(v)
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = v
        end
    end
end)

local godMode = false
CreateToggle("Бессмертие", false, function(value)
    godMode = value
    if godMode then
        Player.CharacterAdded:Connect(function(character)
            wait(1)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 100
            end
        end)
        
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
end)

-- ТРОЛЛИНГ ФУНКЦИИ
CreateButton("🔥 Поджечь всех игроков", function()
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        if target ~= Player and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local fire = Instance.new("Fire")
                fire.Size = 25
                fire.Heat = 15
                fire.Parent = hrp
                
                spawn(function()
                    while fire and fire.Parent do
                        wait(0.5)
                        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:TakeDamage(8)
                        end
                    end
                end)
            end
        end
    end
end, Color3.fromRGB(200, 50, 0))

CreateButton("💥 Сбросить всех с карты", function()
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        if target ~= Player and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame + Vector3.new(0, 500, 0)
            end
        end
    end
end, Color3.fromRGB(200, 100, 0))

-- ВИЗУАЛЬНЫЕ ФУНКЦИИ
CreateButton("🌌 Заменить небо на скин", function()
    if Player.Character then
        local shirt = Player.Character:FindFirstChildOfClass("Shirt")
        local pants = Player.Character:FindFirstChildOfClass("Pants")
        local textureId = nil
        
        if shirt then
            textureId = shirt.ShirtTemplate
        elseif pants then
            textureId = pants.PantsTemplate
        end
        
        if textureId then
            for _, obj in ipairs(game:GetService("Lighting"):GetChildren()) do
                if obj:IsA("Sky") then
                    obj:Destroy()
                end
            end
            
            local newSky = Instance.new("Sky")
            newSky.SkyboxBk = textureId
            newSky.SkyboxDn = textureId
            newSky.SkyboxFt = textureId
            newSky.SkyboxLf = textureId
            newSky.SkyboxRt = textureId
            newSky.SkyboxUp = textureId
            newSky.Parent = game:GetService("Lighting")
        end
    end
end, Color3.fromRGB(0, 100, 200))

local discoMode = false
CreateToggle("🎭 Диско-режим для всех", false, function(value)
    discoMode = value
    
    if discoMode then
        spawn(function()
            while discoMode do
                wait(0.3)
                for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
                    if target.PlayerGui then
                        local oldGui = target.PlayerGui:FindFirstChild("DiscoGUI")
                        if oldGui then
                            oldGui:Destroy()
                        end
                        
                        local gui = Instance.new("ScreenGui")
                        gui.Name = "DiscoGUI"
                        gui.ResetOnSpawn = false
                        
                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(
                            math.random(50, 255),
                            math.random(50, 255),
                            math.random(50, 255)
                        )
                        frame.BackgroundTransparency = 0.3
                        frame.BorderSizePixel = 0
                        frame.Parent = gui
                        
                        gui.Parent = target.PlayerGui
                    end
                end
            end
        end)
    else
        for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            if target.PlayerGui then
                local gui = target.PlayerGui:FindFirstChild("DiscoGUI")
                if gui then
                    gui:Destroy()
                end
            end
        end
    end
end)

-- УТИЛИТЫ
CreateButton("💪 Сверхсила (Скор. 100 + Прыж. 150)", function()
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
        end
    end
end, Color3.fromRGB(0, 150, 0))

CreateButton("🔄 Сбросить настройки", function()
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
end, Color3.fromRGB(100, 100, 100))

print("✅ C00lKid Exploit V22 загружен!")
print("🎯 Кастомный GUI создан для Xeno")
