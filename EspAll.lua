-- C00lKid Universal Premium ESP V1 - All Games
local Players = game:GetService("Players")
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ПЕРЕМЕННЫЕ
local ESPEnabled = false
local MenuEnabled = false
local ESPObjects = {}
local ESPLoop

-- КОНФИГУРАЦИЯ ESP
local ESPConfig = {
    MaxDistance = 2000,
    Box = true,
    Name = true,
    Health = true,
    Distance = true,
    Tracers = true,
    TeamCheck = false,
    
    -- ЦВЕТА С ГРАДИЕНТАМИ
    PlayerColor = Color3.fromRGB(0, 255, 150),
    EnemyColor = Color3.fromRGB(255, 50, 50),
    TeamColor = Color3.fromRGB(0, 150, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    
    -- СТИЛИ
    BoxStyle = "Rounded", -- Rounded, Square, Gradient
    TracerStyle = "Line", -- Line, Arrow, Beam
    Font = "Gotham" -- Gotham, Arial, SciFi
}

-- СОЗДАЕМ ПРЕМИУМ МЕНЮ
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "C00lKidPremiumESPMenu"
MenuGui.Parent = game:GetService("CoreGui")
MenuGui.Enabled = false

-- ОСНОВНОЙ КОНТЕЙНЕР
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 400, 0, 500)
MainContainer.Position = UDim2.new(0.5, -200, 0.5, -250)
MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Parent = MenuGui

-- GLOW EFFECT
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1, 20, 1, 20)
Glow.Position = UDim2.new(0, -10, 0, -10)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://8992230671"
Glow.ImageColor3 = Color3.fromRGB(0, 100, 255)
Glow.ImageTransparency = 0.7
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(23, 23, 277, 277)
Glow.Parent = MainContainer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainContainer

-- GLASS EFFECT
local GlassFrame = Instance.new("Frame")
GlassFrame.Size = UDim2.new(1, 0, 1, 0)
GlassFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlassFrame.BackgroundTransparency = 0.95
GlassFrame.BorderSizePixel = 0
GlassFrame.Parent = MainContainer

local GlassCorner = Instance.new("UICorner")
GlassCorner.CornerRadius = UDim.new(0, 15)
GlassCorner.Parent = GlassFrame

-- HEADER С ГРАДИЕНТОМ
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Header.BorderSizePixel = 0
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
HeaderGradient.Rotation = 45
HeaderGradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 0.6, 0)
Title.Position = UDim2.new(0.05, 0, 0.1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎯 UNIVERSAL PREMIUM ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0.8, 0, 0.3, 0)
SubTitle.Position = UDim2.new(0.05, 0, 0.6, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "All Games • Gradient Edition"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- СТАТУС БАР
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 30)
StatusBar.Position = UDim2.new(0, 0, 0, 70)
StatusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
StatusBar.Parent = MainContainer

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "ESP: OFF | Press K to toggle menu"
StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusBar

-- ОБЛАСТЬ НАСТРОЕК
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainContainer

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = ContentFrame

-- ПЕРЕТАСКИВАНИЕ МЕНЮ
local dragging = false
local dragInput, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ФУНКЦИЯ СОЗДАНИЯ ПРЕМИУМ ПЕРЕКЛЮЧАТЕЛЯ
local yOffset = 0
local function CreatePremiumToggle(text, configKey, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ScrollFrame
    
    local ToggleBackground = Instance.new("Frame")
    ToggleBackground.Size = UDim2.new(1, 0, 0, 40)
    ToggleBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ToggleBackground.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleBackground
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 60, 0, 25)
    ToggleButton.Position = UDim2.new(0.03, 0, 0.18, 0)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleBackground
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
    ToggleButtonCorner.Parent = ToggleButton
    
    local ToggleKnob = Instance.new("Frame")
    ToggleKnob.Size = UDim2.new(0, 19, 0, 19)
    ToggleKnob.Position = UDim2.new(default and 0.55 or 0.05, 0, 0.26, 0)
    ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleKnob.Parent = ToggleBackground
    
    local ToggleKnobCorner = Instance.new("UICorner")
    ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
    ToggleKnobCorner.Parent = ToggleKnob
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0.2, 0, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleBackground
    
    -- АНИМАЦИЯ ПЕРЕКЛЮЧАТЕЛЯ
    ToggleButton.MouseButton1Click:Connect(function()
        ESPConfig[configKey] = not ESPConfig[configKey]
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if ESPConfig[configKey] then
            TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.55, 0, 0.26, 0)}):Play()
        else
            TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.05, 0, 0.26, 0)}):Play()
        end
    end)
    
    ToggleFrame.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + 55
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    
    return ToggleFrame
end

-- ФУНКЦИЯ СОЗДАНИЯ ПРЕМИУМ СЛАЙДЕРА
local function CreatePremiumSlider(text, configKey, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 65)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = ScrollFrame
    
    local SliderBackground = Instance.new("Frame")
    SliderBackground.Size = UDim2.new(1, 0, 0, 50)
    SliderBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    SliderBackground.Parent = SliderFrame
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 10)
    SliderCorner.Parent = SliderBackground
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderBackground
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -30, 0, 8)
    Track.Position = UDim2.new(0, 15, 0, 30)
    Track.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Track.Parent = SliderBackground
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill
    
    -- ГРАДИЕНТ ДЛЯ ЗАПОЛНЕНИЯ
    local FillGradient = Instance.new("UIGradient")
    FillGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
    })
    FillGradient.Parent = Fill
    
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
                ESPConfig[configKey] = value
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    SliderFrame.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + 70
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    
    return SliderFrame
end

-- ДОБАВЛЯЕМ НАСТРОЙКИ В МЕНЮ
CreatePremiumToggle("📦 Box ESP", "Box", true)
CreatePremiumToggle("🏷️ Player Names", "Name", true)
CreatePremiumToggle("❤️ Health Display", "Health", true)
CreatePremiumToggle("📏 Distance", "Distance", true)
CreatePremiumToggle("🎯 Tracers", "Tracers", true)
CreatePremiumToggle("🎨 Team Colors", "TeamCheck", false)
CreatePremiumSlider("🔭 Max Distance", "MaxDistance", 0, 5000, 2000)

-- ФУНКЦИИ ESP
local function CreateESP(player)
    if ESPObjects[player] or player == LocalPlayer then return end
    
    local esp = {
        Player = player,
        Box = nil,
        NameLabel = nil,
        HealthLabel = nil,
        DistanceLabel = nil,
        Tracer = nil
    }
    
    -- PREMIUM BOX С ГРАДИЕНТОМ
    esp.Box = Instance.new("Frame")
    esp.Box.Name = "PremiumBox_" .. player.Name
    esp.Box.BackgroundTransparency = 0.3
    esp.Box.BorderSizePixel = 0
    esp.Box.ZIndex = 10
    esp.Box.Visible = false
    esp.Box.Parent = MenuGui
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = esp.Box
    
    -- ГРАДИЕНТ ДЛЯ BOX
    local BoxGradient = Instance.new("UIGradient")
    BoxGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ESPConfig.PlayerColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    BoxGradient.Rotation = 45
    BoxGradient.Parent = esp.Box
    
    -- GLOW EFFECT
    local BoxGlow = Instance.new("ImageLabel")
    BoxGlow.Size = UDim2.new(1, 8, 1, 8)
    BoxGlow.Position = UDim2.new(0, -4, 0, -4)
    BoxGlow.BackgroundTransparency = 1
    BoxGlow.Image = "rbxassetid://8992230671"
    BoxGlow.ImageColor3 = ESPConfig.PlayerColor
    BoxGlow.ImageTransparency = 0.6
    BoxGlow.ScaleType = Enum.ScaleType.Slice
    BoxGlow.SliceCenter = Rect.new(23, 23, 277, 277)
    BoxGlow.Parent = esp.Box
    
    -- PREMIUM NAME LABEL
    esp.NameLabel = Instance.new("TextLabel")
    esp.NameLabel.Name = "PremiumName_" .. player.Name
    esp.NameLabel.Text = player.Name
    esp.NameLabel.TextColor3 = ESPConfig.TextColor
    esp.NameLabel.TextSize = 14
    esp.NameLabel.Font = Enum.Font.GothamBold
    esp.NameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    esp.NameLabel.BackgroundTransparency = 0.7
    esp.NameLabel.ZIndex = 11
    esp.NameLabel.Visible = false
    esp.NameLabel.Parent = MenuGui
    
    local NameCorner = Instance.new("UICorner")
    NameCorner.CornerRadius = UDim.new(0, 6)
    NameCorner.Parent = esp.NameLabel
    
    -- PREMIUM HEALTH BAR
    esp.HealthLabel = Instance.new("Frame")
    esp.HealthLabel.Name = "PremiumHealth_" .. player.Name
    esp.HealthLabel.Size = UDim2.new(0, 80, 0, 18)
    esp.HealthLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    esp.HealthLabel.ZIndex = 11
    esp.HealthLabel.Visible = false
    esp.HealthLabel.Parent = MenuGui
    
    local HealthCorner = Instance.new("UICorner")
    HealthCorner.CornerRadius = UDim.new(0, 4)
    HealthCorner.Parent = esp.HealthLabel
    
    esp.HealthBar = Instance.new("Frame")
    esp.HealthBar.Size = UDim2.new(1, 0, 1, 0)
    esp.HealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    esp.HealthBar.Parent = esp.HealthLabel
    
    local HealthBarCorner = Instance.new("UICorner")
    HealthBarCorner.CornerRadius = UDim.new(0, 4)
    HealthBarCorner.Parent = esp.HealthBar
    
    -- ГРАДИЕНТ ДЛЯ HEALTH BAR
    local HealthGradient = Instance.new("UIGradient")
    HealthGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 100))
    })
    HealthGradient.Parent = esp.HealthBar
    
    esp.HealthText = Instance.new("TextLabel")
    esp.HealthText.Size = UDim2.new(1, 0, 1, 0)
    esp.HealthText.BackgroundTransparency = 1
    esp.HealthText.Text = "100%"
    esp.HealthText.TextColor3 = Color3.fromRGB(255, 255, 255)
    esp.HealthText.TextSize = 10
    esp.HealthText.Font = Enum.Font.GothamBold
    esp.HealthText.Parent = esp.HealthLabel
    
    -- PREMIUM DISTANCE
    esp.DistanceLabel = Instance.new("TextLabel")
    esp.DistanceLabel.Name = "PremiumDistance_" .. player.Name
    esp.DistanceLabel.Text = "0m"
    esp.DistanceLabel.TextColor3 = ESPConfig.TextColor
    esp.DistanceLabel.TextSize = 12
    esp.DistanceLabel.Font = Enum.Font.Gotham
    esp.DistanceLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    esp.DistanceLabel.BackgroundTransparency = 0.7
    esp.DistanceLabel.ZIndex = 11
    esp.DistanceLabel.Visible = false
    esp.DistanceLabel.Parent = MenuGui
    
    local DistanceCorner = Instance.new("UICorner")
    DistanceCorner.CornerRadius = UDim.new(0, 6)
    DistanceCorner.Parent = esp.DistanceLabel
    
    -- PREMIUM TRACER С ГРАДИЕНТОМ
    esp.Tracer = Instance.new("Frame")
    esp.Tracer.Name = "PremiumTracer_" .. player.Name
    esp.Tracer.BackgroundColor3 = ESPConfig.PlayerColor
    esp.Tracer.BorderSizePixel = 0
    esp.Tracer.Size = UDim2.new(0, 3, 0, 1)
    esp.Tracer.ZIndex = 9
    esp.Tracer.Visible = false
    esp.Tracer.Parent = MenuGui
    
    local TracerGradient = Instance.new("UIGradient")
    TracerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ESPConfig.PlayerColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    TracerGradient.Parent = esp.Tracer
    
    ESPObjects[player] = esp
end

local function UpdateESP(player)
    local esp = ESPObjects[player]
    if not esp or not player.Character then return end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and 
                    (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0
    
    if distance > ESPConfig.MaxDistance then
        if esp.Box then esp.Box.Visible = false end
        if esp.NameLabel then esp.NameLabel.Visible = false end
        if esp.HealthLabel then esp.HealthLabel.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
        return
    end
    
    local vector, onScreen = CurrentCamera:WorldToViewportPoint(rootPart.Position)
    
    if onScreen then
        local scale = 1 / (vector.Z * math.tan(math.rad(CurrentCamera.FieldOfView * 0.5)) * 2) * 100
        local size = Vector3.new(4 * scale, 6 * scale, 0)
        
        -- ОПРЕДЕЛЯЕМ ЦВЕТ
        local color = ESPConfig.PlayerColor
        if ESPConfig.TeamCheck and player.Team then
            color = ESPConfig.TeamColor
        end
        
        -- ОБНОВЛЯЕМ BOX
        if esp.Box and ESPConfig.Box then
            esp.Box.Size = UDim2.new(0, size.X, 0, size.Y)
            esp.Box.Position = UDim2.new(0, vector.X - size.X / 2, 0, vector.Y - size.Y / 2)
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
        end
        
        -- ОБНОВЛЯЕМ ИМЯ
        if esp.NameLabel and ESPConfig.Name then
            esp.NameLabel.Position = UDim2.new(0, vector.X, 0, vector.Y - size.Y / 2 - 20)
            esp.NameLabel.Visible = true
        else
            esp.NameLabel.Visible = false
        end
        
        -- ОБНОВЛЯЕМ ЗДОРОВЬЕ
        if esp.HealthLabel and ESPConfig.Health and humanoid then
            local health = math.floor(humanoid.Health)
            local maxHealth = math.floor(humanoid.MaxHealth)
            local healthPercent = health / maxHealth
            
            esp.HealthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
            esp.HealthText.Text = math.floor(healthPercent * 100) .. "%"
            esp.HealthLabel.Position = UDim2.new(0, vector.X - 40, 0, vector.Y + size.Y / 2 + 5)
            esp.HealthLabel.Visible = true
        else
            esp.HealthLabel.Visible = false
        end
        
        -- ОБНОВЛЯЕМ ДИСТАНЦИЮ
        if esp.DistanceLabel and ESPConfig.Distance then
            esp.DistanceLabel.Text = math.floor(distance) .. "m"
            esp.DistanceLabel.Position = UDim2.new(0, vector.X, 0, vector.Y + size.Y / 2 + 25)
            esp.DistanceLabel.Visible = true
        else
            esp.DistanceLabel.Visible = false
        end
        
        -- ОБНОВЛЯЕМ TRACER
        if esp.Tracer and ESPConfig.Tracers then
            local tracerLength = math.sqrt((vector.X - CurrentCamera.ViewportSize.X/2)^2 + (vector.Y - CurrentCamera.ViewportSize.Y)^2)
            esp.Tracer.Size = UDim2.new(0, 3, 0, tracerLength)
            esp.Tracer.Position = UDim2.new(0, CurrentCamera.ViewportSize.X/2, 0, CurrentCamera.ViewportSize.Y)
            esp.Tracer.Rotation = math.deg(math.atan2(vector.Y - CurrentCamera.ViewportSize.Y, vector.X - CurrentCamera.ViewportSize.X/2))
            esp.Tracer.Visible = true
        else
            esp.Tracer.Visible = false
        end
        
    else
        -- СКРЫВАЕМ ЕСЛИ ВНЕ ЭКРАНА
        if esp.Box then esp.Box.Visible = false end
        if esp.NameLabel then esp.NameLabel.Visible = false end
        if esp.HealthLabel then esp.HealthLabel.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
    end
end

local function RemoveESP(player)
    local esp = ESPObjects[player]
    if esp then
        if esp.Box then esp.Box:Destroy() end
        if esp.NameLabel then esp.NameLabel:Destroy() end
        if esp.HealthLabel then esp.HealthLabel:Destroy() end
        if esp.DistanceLabel then esp.DistanceLabel:Destroy() end
        if esp.Tracer then esp.Tracer:Destroy() end
        ESPObjects[player] = nil
    end
end

-- ФУНКЦИЯ ПЕРЕКЛЮЧЕНИЯ ESP
local function ToggleESP()
    ESPEnabled = not ESPEnabled
    
    if ESPEnabled then
        StatusText.Text = "ESP: ON | Press K to toggle menu"
        StatusText.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        -- СОЗДАЕМ ESP ДЛЯ ВСЕХ ИГРОКОВ
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                CreateESP(player)
            end
        end
        
        -- ЗАПУСКАЕМ ЦИКЛ ОБНОВЛЕНИЯ
        ESPLoop = RunService.RenderStepped:Connect(function()
            for player, esp in pairs(ESPObjects) do
                if player and player.Character then
                    UpdateESP(player)
                else
                    RemoveESP(player)
                end
            end
        end)
        
        -- ОБРАБОТЧИКИ СОБЫТИЙ
        Players.PlayerAdded:Connect(function(player)
            wait(1)
            CreateESP(player)
        end)
        
        Players.PlayerRemoving:Connect(function(player)
            RemoveESP(player)
        end)
        
    else
        StatusText.Text = "ESP: OFF | Press K to toggle menu"
        StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        -- ОСТАНАВЛИВАЕМ ЦИКЛ И ОЧИЩАЕМ
        if ESPLoop then
            ESPLoop:Disconnect()
        end
        
        for player, esp in pairs(ESPObjects) do
            RemoveESP(player)
        end
    end
end

-- ФУНКЦИЯ ПЕРЕКЛЮЧЕНИЯ МЕНЮ
local function ToggleMenu()
    MenuEnabled = not MenuEnabled
    MenuGui.Enabled = MenuEnabled
    
    if MenuEnabled then
        -- АНИМАЦИЯ ПОЯВЛЕНИЯ
        MainContainer.Position = UDim2.new(0.5, -200, 0.5, -250)
        MainContainer.Size = UDim2.new(0, 0, 0, 0)
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        TweenService:Create(MainContainer, tweenInfo, {Size = UDim2.new(0, 400, 0, 500)}):Play()
    end
end

-- КЛАВИША K ДЛЯ УПРАВЛЕНИЯ
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        ToggleMenu()
    elseif input.KeyCode == Enum.KeyCode.L then
        ToggleESP()
    end
end)

print("✅ C00lKid Universal Premium ESP V1 loaded!")
print("🎯 Press K to open/close menu")
print("🎯 Press L to toggle ESP")
print("🎨 Premium gradients and animations activated")

-- ИНИЦИАЛИЗАЦИЯ
StatusText.Text = "ESP: OFF | Press K for menu | L for ESP"
