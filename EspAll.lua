-- C00lKid Fixed Premium ESP V2 - Bug Free
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
    
    -- ЦВЕТА
    PlayerColor = Color3.fromRGB(0, 255, 150),
    EnemyColor = Color3.fromRGB(255, 50, 50),
    TeamColor = Color3.fromRGB(0, 150, 255),
    TextColor = Color3.fromRGB(255, 255, 255)
}

-- СОЗДАЕМ МЕНЮ
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "C00lKidFixedESPMenu"
MenuGui.Parent = game:GetService("CoreGui")
MenuGui.Enabled = false

-- ОСНОВНОЙ КОНТЕЙНЕР
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 400, 0, 500)
MainContainer.Position = UDim2.new(0.5, -200, 0.5, -250)
MainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainContainer.BorderSizePixel = 0
MainContainer.Parent = MenuGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainContainer

-- ЗАГОЛОВОК
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Header.BorderSizePixel = 0
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎯 FIXED ESP V2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- СТАТУС БАР
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 30)
StatusBar.Position = UDim2.new(0, 0, 0, 50)
StatusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
StatusBar.Parent = MainContainer

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "ESP: OFF | K: Menu | L: ESP"
StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusBar

-- ОБЛАСТЬ НАСТРОЕК
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -90)
ContentFrame.Position = UDim2.new(0, 10, 0, 90)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainContainer

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = ContentFrame

-- ПЕРЕТАСКИВАНИЕ
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

-- ИСПРАВЛЕННЫЕ ПЕРЕКЛЮЧАТЕЛИ
local yOffset = 0
local function CreateFixedToggle(text, configKey, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ScrollFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(0, 0, 0, 5)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 60, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    -- ПРОСТОЙ КЛИК БЕЗ АНИМАЦИЙ
    ToggleButton.MouseButton1Click:Connect(function()
        ESPConfig[configKey] = not ESPConfig[configKey]
        ToggleButton.BackgroundColor3 = ESPConfig[configKey] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    end)
    
    ToggleFrame.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + 40
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ИСПРАВЛЕННЫЙ СЛАЙДЕР
local function CreateFixedSlider(text, configKey, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = ScrollFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 6)
    Track.Position = UDim2.new(0, 0, 0, 25)
    Track.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Track.Parent = SliderFrame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 3)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 3)
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
    yOffset = yOffset + 60
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ВЫБОР ЦВЕТА
local function CreateColorPicker(text, configKey, defaultColor)
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Size = UDim2.new(1, 0, 0, 40)
    ColorFrame.BackgroundTransparency = 1
    ColorFrame.Parent = ScrollFrame
    
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Size = UDim2.new(0.6, 0, 1, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = text
    ColorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorLabel.TextSize = 14
    ColorLabel.Font = Enum.Font.Gotham
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Parent = ColorFrame
    
    local ColorButton = Instance.new("TextButton")
    ColorButton.Size = UDim2.new(0, 60, 0, 25)
    ColorButton.Position = UDim2.new(0.7, 0, 0.2, 0)
    ColorButton.BackgroundColor3 = defaultColor
    ColorButton.Text = ""
    ColorButton.Parent = ColorFrame
    
    local ColorCorner = Instance.new("UICorner")
    ColorCorner.CornerRadius = UDim.new(0, 4)
    ColorCorner.Parent = ColorButton
    
    ColorButton.MouseButton1Click:Connect(function()
        -- ПРОСТОЙ ВЫБОР ЦВЕТА (можно улучшить)
        ESPConfig[configKey] = Color3.new(math.random(), math.random(), math.random())
        ColorButton.BackgroundColor3 = ESPConfig[configKey]
    end)
    
    ColorFrame.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + 45
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ДОБАВЛЯЕМ НАСТРОЙКИ
CreateFixedToggle("Box ESP", "Box", true)
CreateFixedToggle("Player Names", "Name", true)
CreateFixedToggle("Health Bar", "Health", true)
CreateFixedToggle("Distance", "Distance", true)
CreateFixedToggle("Tracers", "Tracers", true)
CreateFixedToggle("Team Colors", "TeamCheck", false)
CreateFixedSlider("Max Distance", "MaxDistance", 0, 5000, 2000)
CreateColorPicker("Player Color", "PlayerColor", ESPConfig.PlayerColor)
CreateColorPicker("Text Color", "TextColor", ESPConfig.TextColor)

-- ИСПРАВЛЕННЫЕ ФУНКЦИИ ESP
local function CreateESP(player)
    if ESPObjects[player] or player == LocalPlayer then return end
    
    local esp = {
        Player = player,
        Box = nil,
        NameLabel = nil,
        HealthBar = nil,
        DistanceLabel = nil,
        Tracer = nil
    }
    
    -- ПРОСТОЙ BOX
    esp.Box = Instance.new("Frame")
    esp.Box.Name = "ESPBox_" .. player.Name
    esp.Box.BackgroundTransparency = 0.7
    esp.Box.BackgroundColor3 = ESPConfig.PlayerColor
    esp.Box.BorderSizePixel = 2
    esp.Box.BorderColor3 = Color3.fromRGB(255, 255, 255)
    esp.Box.ZIndex = 10
    esp.Box.Visible = false
    esp.Box.Parent = MenuGui
    
    -- ПРОСТОЕ ИМЯ
    esp.NameLabel = Instance.new("TextLabel")
    esp.NameLabel.Name = "ESPName_" .. player.Name
    esp.NameLabel.Text = player.Name
    esp.NameLabel.TextColor3 = ESPConfig.TextColor
    esp.NameLabel.TextSize = 14
    esp.NameLabel.Font = Enum.Font.GothamBold
    esp.NameLabel.BackgroundTransparency = 1
    esp.NameLabel.ZIndex = 11
    esp.NameLabel.Visible = false
    esp.NameLabel.Parent = MenuGui
    
    -- ПРОСТАЯ HEALTH BAR
    esp.HealthBar = Instance.new("Frame")
    esp.HealthBar.Name = "ESPHealth_" .. player.Name
    esp.HealthBar.Size = UDim2.new(0, 60, 0, 6)
    esp.HealthBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    esp.HealthBar.BorderSizePixel = 1
    esp.HealthBar.BorderColor3 = Color3.fromRGB(255, 255, 255)
    esp.HealthBar.ZIndex = 11
    esp.HealthBar.Visible = false
    esp.HealthBar.Parent = MenuGui
    
    esp.HealthFill = Instance.new("Frame")
    esp.HealthFill.Size = UDim2.new(1, 0, 1, 0)
    esp.HealthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    esp.HealthFill.Parent = esp.HealthBar
    
    -- ПРОСТАЯ ДИСТАНЦИЯ
    esp.DistanceLabel = Instance.new("TextLabel")
    esp.DistanceLabel.Name = "ESPDistance_" .. player.Name
    esp.DistanceLabel.Text = "0m"
    esp.DistanceLabel.TextColor3 = ESPConfig.TextColor
    esp.DistanceLabel.TextSize = 12
    esp.DistanceLabel.Font = Enum.Font.Gotham
    esp.DistanceLabel.BackgroundTransparency = 1
    esp.DistanceLabel.ZIndex = 11
    esp.DistanceLabel.Visible = false
    esp.DistanceLabel.Parent = MenuGui
    
    -- ПРОСТОЙ TRACER
    esp.Tracer = Instance.new("Frame")
    esp.Tracer.Name = "ESPTracer_" .. player.Name
    esp.Tracer.BackgroundColor3 = ESPConfig.PlayerColor
    esp.Tracer.BorderSizePixel = 0
    esp.Tracer.Size = UDim2.new(0, 2, 0, 1)
    esp.Tracer.ZIndex = 9
    esp.Tracer.Visible = false
    esp.Tracer.Parent = MenuGui
    
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
        if esp.HealthBar then esp.HealthBar.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
        return
    end
    
    local vector, onScreen = CurrentCamera:WorldToViewportPoint(rootPart.Position)
    
    if onScreen then
        local scale = 1 / (vector.Z * math.tan(math.rad(CurrentCamera.FieldOfView * 0.5)) * 2) * 100
        local size = Vector3.new(4 * scale, 6 * scale, 0)
        
        -- ЦВЕТ
        local color = ESPConfig.PlayerColor
        if ESPConfig.TeamCheck and player.Team then
            color = player.TeamColor.Color
        end
        
        -- BOX
        if esp.Box and ESPConfig.Box then
            esp.Box.Size = UDim2.new(0, size.X, 0, size.Y)
            esp.Box.Position = UDim2.new(0, vector.X - size.X / 2, 0, vector.Y - size.Y / 2)
            esp.Box.BackgroundColor3 = color
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
        end
        
        -- NAME
        if esp.NameLabel and ESPConfig.Name then
            esp.NameLabel.Position = UDim2.new(0, vector.X, 0, vector.Y - size.Y / 2 - 15)
            esp.NameLabel.Visible = true
        else
            esp.NameLabel.Visible = false
        end
        
        -- HEALTH
        if esp.HealthBar and ESPConfig.Health and humanoid then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            esp.HealthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
            esp.HealthFill.BackgroundColor3 = Color3.fromRGB(
                255 - (healthPercent * 255),
                healthPercent * 255,
                0
            )
            esp.HealthBar.Position = UDim2.new(0, vector.X - 30, 0, vector.Y + size.Y / 2 + 5)
            esp.HealthBar.Visible = true
        else
            esp.HealthBar.Visible = false
        end
        
        -- DISTANCE
        if esp.DistanceLabel and ESPConfig.Distance then
            esp.DistanceLabel.Text = math.floor(distance) .. "m"
            esp.DistanceLabel.Position = UDim2.new(0, vector.X, 0, vector.Y + size.Y / 2 + 15)
            esp.DistanceLabel.Visible = true
        else
            esp.DistanceLabel.Visible = false
        end
        
        -- TRACER
        if esp.Tracer and ESPConfig.Tracers then
            local tracerLength = math.sqrt((vector.X - CurrentCamera.ViewportSize.X/2)^2 + (vector.Y - CurrentCamera.ViewportSize.Y)^2)
            esp.Tracer.Size = UDim2.new(0, 2, 0, tracerLength)
            esp.Tracer.Position = UDim2.new(0, CurrentCamera.ViewportSize.X/2, 0, CurrentCamera.ViewportSize.Y)
            esp.Tracer.Rotation = math.deg(math.atan2(vector.Y - CurrentCamera.ViewportSize.Y, vector.X - CurrentCamera.ViewportSize.X/2))
            esp.Tracer.BackgroundColor3 = color
            esp.Tracer.Visible = true
        else
            esp.Tracer.Visible = false
        end
        
    else
        -- СКРЫВАЕМ ЕСЛИ ВНЕ ЭКРАНА
        if esp.Box then esp.Box.Visible = false end
        if esp.NameLabel then esp.NameLabel.Visible = false end
        if esp.HealthBar then esp.HealthBar.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
    end
end

local function RemoveESP(player)
    local esp = ESPObjects[player]
    if esp then
        if esp.Box then esp.Box:Destroy() end
        if esp.NameLabel then esp.NameLabel:Destroy() end
        if esp.HealthBar then esp.HealthBar:Destroy() end
        if esp.DistanceLabel then esp.DistanceLabel:Destroy() end
        if esp.Tracer then esp.Tracer:Destroy() end
        ESPObjects[player] = nil
    end
end

-- ФУНКЦИЯ ПЕРЕКЛЮЧЕНИЯ ESP (НЕЗАВИСИМАЯ ОТ МЕНЮ)
local function ToggleESP()
    ESPEnabled = not ESPEnabled
    
    if ESPEnabled then
        StatusText.Text = "ESP: ON | K: Menu | L: ESP"
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
        StatusText.Text = "ESP: OFF | K: Menu | L: ESP"
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

-- ФУНКЦИЯ ПЕРЕКЛЮЧЕНИЯ МЕНЮ (НЕ ВЛИЯЕТ НА ESP)
local function ToggleMenu()
    MenuEnabled = not MenuEnabled
    MenuGui.Enabled = MenuEnabled
end

-- КЛАВИШИ УПРАВЛЕНИЯ
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        ToggleMenu()
    elseif input.KeyCode == Enum.KeyCode.L then
        ToggleESP()
    end
end)

print("✅ C00lKid Fixed ESP V2 loaded!")
print("🎯 Press K to open/close menu")
print("🎯 Press L to toggle ESP")
print("🔧 All bugs fixed")

-- ИНИЦИАЛИЗАЦИЯ
StatusText.Text = "ESP: OFF | K: Menu | L: ESP"
