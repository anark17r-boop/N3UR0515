-- C00lKid Universal ESP V2 - Custom GUI Version
local Players = game:GetService("Players")
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАЕМ КАСТОМНЫЙ GUI ДЛЯ ESP
local ESPGui = Instance.new("ScreenGui")
ESPGui.Name = "C00lKidESPGui"
ESPGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ESPGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- ЗАГОЛОВОК
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎯 C00lKid Universal ESP V2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 80, 0, 25)
ToggleButton.Position = UDim2.new(1, -85, 0.5, -12)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.Text = "OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 12
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = TitleBar

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

-- ОБЛАСТЬ НАСТРОЕК
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(1, -20, 1, -60)
SettingsFrame.Position = UDim2.new(0, 10, 0, 50)
SettingsFrame.BackgroundTransparency = 1
SettingsFrame.Parent = MainFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = SettingsFrame

-- ПЕРЕТАСКИВАНИЕ ОКНА
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

-- НАСТРОЙКИ ESP
local ESPConfig = {
    Enabled = false,
    Box = true,
    Name = true,
    Health = true,
    Distance = true,
    Tracers = true,
    Avatar = true,
    TeamCheck = false,
    MaxDistance = 1000,
    BoxColor = Color3.fromRGB(0, 255, 0),
    TextColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(255, 255, 255),
    TeamColor = true
}

-- ПЕРЕМЕННЫЕ ESP
local ESPObjects = {}
local ESPLoop

-- ФУНКЦИЯ СОЗДАНИЯ КНОПКИ НАСТРОЙКИ
local yOffset = 0
local function CreateToggle(text, configKey, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    ToggleFrame.Position = UDim2.new(0, 0, 0, yOffset)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ScrollFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 60, 0, 25)
    ToggleButton.Position = UDim2.new(0, 0, 0, 5)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    ToggleButton.Text = default and "ON" or "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 11
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 70, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 13
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleButton
    
    ToggleButton.MouseButton1Click:Connect(function()
        ESPConfig[configKey] = not ESPConfig[configKey]
        ToggleButton.BackgroundColor3 = ESPConfig[configKey] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        ToggleButton.Text = ESPConfig[configKey] and "ON" or "OFF"
    end)
    
    yOffset = yOffset + 40
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ФУНКЦИЯ СОЗДАНИЯ СЛАЙДЕРА
local function CreateSlider(text, configKey, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.Position = UDim2.new(0, 0, 0, yOffset)
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
    Track.Size = UDim2.new(1, 0, 0, 8)
    Track.Position = UDim2.new(0, 0, 0, 30)
    Track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Track.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    Fill.Parent = Track
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 4)
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
                ESPConfig[configKey] = value
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    yOffset = yOffset + 60
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ДОБАВЛЯЕМ НАСТРОЙКИ
CreateToggle("Box ESP", "Box", true)
CreateToggle("Show Names", "Name", true)
CreateToggle("Show Health", "Health", true)
CreateToggle("Show Distance", "Distance", true)
CreateToggle("Show Tracers", "Tracers", true)
CreateToggle("Show Avatar", "Avatar", true)
CreateToggle("Team Colors", "TeamColor", true)
CreateSlider("Max Distance", "MaxDistance", 0, 2000, 1000)

-- ФУНКЦИИ ESP
local function CreateESP(player)
    if ESPObjects[player] or player == LocalPlayer then return end
    
    local esp = {
        Player = player,
        Box = nil,
        NameLabel = nil,
        HealthLabel = nil,
        DistanceLabel = nil,
        Tracer = nil,
        Avatar = nil
    }
    
    -- BOX
    esp.Box = Instance.new("Frame")
    esp.Box.Name = "ESPBox_" .. player.Name
    esp.Box.BackgroundTransparency = 0.8
    esp.Box.BackgroundColor3 = ESPConfig.BoxColor
    esp.Box.BorderSizePixel = 2
    esp.Box.BorderColor3 = Color3.fromRGB(255, 255, 255)
    esp.Box.ZIndex = 10
    esp.Box.Visible = false
    esp.Box.Parent = ESPGui
    
    -- NAME
    esp.NameLabel = Instance.new("TextLabel")
    esp.NameLabel.Name = "ESPName_" .. player.Name
    esp.NameLabel.Text = player.Name
    esp.NameLabel.TextColor3 = ESPConfig.TextColor
    esp.NameLabel.TextSize = 14
    esp.NameLabel.Font = Enum.Font.GothamBold
    esp.NameLabel.BackgroundTransparency = 1
    esp.NameLabel.ZIndex = 11
    esp.NameLabel.Visible = false
    esp.NameLabel.Parent = ESPGui
    
    -- HEALTH
    esp.HealthLabel = Instance.new("TextLabel")
    esp.HealthLabel.Name = "ESPHealth_" .. player.Name
    esp.HealthLabel.Text = "HP: 100"
    esp.HealthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    esp.HealthLabel.TextSize = 12
    esp.HealthLabel.Font = Enum.Font.Gotham
    esp.HealthLabel.BackgroundTransparency = 1
    esp.HealthLabel.ZIndex = 11
    esp.HealthLabel.Visible = false
    esp.HealthLabel.Parent = ESPGui
    
    -- DISTANCE
    esp.DistanceLabel = Instance.new("TextLabel")
    esp.DistanceLabel.Name = "ESPDistance_" .. player.Name
    esp.DistanceLabel.Text = "0m"
    esp.DistanceLabel.TextColor3 = ESPConfig.TextColor
    esp.DistanceLabel.TextSize = 12
    esp.DistanceLabel.Font = Enum.Font.Gotham
    esp.DistanceLabel.BackgroundTransparency = 1
    esp.DistanceLabel.ZIndex = 11
    esp.DistanceLabel.Visible = false
    esp.DistanceLabel.Parent = ESPGui
    
    -- TRACER
    esp.Tracer = Instance.new("Frame")
    esp.Tracer.Name = "ESPTracer_" .. player.Name
    esp.Tracer.BackgroundColor3 = ESPConfig.TracerColor
    esp.Tracer.BorderSizePixel = 0
    esp.Tracer.Size = UDim2.new(0, 2, 0, 1)
    esp.Tracer.ZIndex = 9
    esp.Tracer.Visible = false
    esp.Tracer.Parent = ESPGui
    
    -- AVATAR
    esp.Avatar = Instance.new("ImageLabel")
    esp.Avatar.Name = "ESPAvatar_" .. player.Name
    esp.Avatar.BackgroundTransparency = 1
    esp.Avatar.Size = UDim2.new(0, 25, 0, 25)
    esp.Avatar.ZIndex = 12
    esp.Avatar.Visible = false
    esp.Avatar.Parent = ESPGui
    
    pcall(function()
        esp.Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
    end)
    
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
        if esp.Avatar then esp.Avatar.Visible = false end
        return
    end
    
    local vector, onScreen = CurrentCamera:WorldToViewportPoint(rootPart.Position)
    
    if onScreen then
        local scale = 1 / (vector.Z * math.tan(math.rad(CurrentCamera.FieldOfView * 0.5)) * 2) * 100
        local size = Vector3.new(4 * scale, 6 * scale, 0)
        
        -- BOX
        if esp.Box and ESPConfig.Box then
            esp.Box.Size = UDim2.new(0, size.X, 0, size.Y)
            esp.Box.Position = UDim2.new(0, vector.X - size.X / 2, 0, vector.Y - size.Y / 2)
            esp.Box.Visible = true
            
            if ESPConfig.TeamColor and player.Team then
                esp.Box.BackgroundColor3 = player.TeamColor.Color
            else
                esp.Box.BackgroundColor3 = ESPConfig.BoxColor
            end
        else
            esp.Box.Visible = false
        end
        
        -- NAME
        if esp.NameLabel and ESPConfig.Name then
            esp.NameLabel.Position = UDim2.new(0, vector.X, 0, vector.Y - size.Y / 2 - 20)
            esp.NameLabel.Visible = true
        else
            esp.NameLabel.Visible = false
        end
        
        -- HEALTH
        if esp.HealthLabel and ESPConfig.Health then
            local health = math.floor(humanoid.Health)
            local maxHealth = math.floor(humanoid.MaxHealth)
            esp.HealthLabel.Text = "HP: "..health.."/"..maxHealth
            esp.HealthLabel.TextColor3 = Color3.fromRGB(
                255 - (health / maxHealth * 255),
                health / maxHealth * 255,
                0
            )
            esp.HealthLabel.Position = UDim2.new(0, vector.X, 0, vector.Y + size.Y / 2 + 5)
            esp.HealthLabel.Visible = true
        else
            esp.HealthLabel.Visible = false
        end
        
        -- DISTANCE
        if esp.DistanceLabel and ESPConfig.Distance then
            esp.DistanceLabel.Text = math.floor(distance).."m"
            esp.DistanceLabel.Position = UDim2.new(0, vector.X, 0, vector.Y + size.Y / 2 + 20)
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
            esp.Tracer.Visible = true
        else
            esp.Tracer.Visible = false
        end
        
        -- AVATAR
        if esp.Avatar and ESPConfig.Avatar then
            esp.Avatar.Position = UDim2.new(0, vector.X - 30, 0, vector.Y - size.Y / 2 - 30)
            esp.Avatar.Visible = true
        else
            esp.Avatar.Visible = false
        end
        
    else
        -- HIDE IF OFF SCREEN
        if esp.Box then esp.Box.Visible = false end
        if esp.NameLabel then esp.NameLabel.Visible = false end
        if esp.HealthLabel then esp.HealthLabel.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
        if esp.Avatar then esp.Avatar.Visible = false end
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
        if esp.Avatar then esp.Avatar:Destroy() end
        ESPObjects[player] = nil
    end
end

-- TOGGLE ESP SYSTEM
ToggleButton.MouseButton1Click:Connect(function()
    ESPConfig.Enabled = not ESPConfig.Enabled
    
    if ESPConfig.Enabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        ToggleButton.Text = "ON"
        
        -- CREATE ESP FOR ALL PLAYERS
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                CreateESP(player)
            end
        end
        
        -- START UPDATE LOOP
        ESPLoop = RunService.RenderStepped:Connect(function()
            for player, esp in pairs(ESPObjects) do
                if player and player.Character then
                    UpdateESP(player)
                else
                    RemoveESP(player)
                end
            end
        end)
        
        -- CONNECT EVENTS
        Players.PlayerAdded:Connect(function(player)
            wait(1)
            CreateESP(player)
        end)
        
        Players.PlayerRemoving:Connect(function(player)
            RemoveESP(player)
        end)
        
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ToggleButton.Text = "OFF"
        
        -- STOP LOOP AND REMOVE ESP
        if ESPLoop then
            ESPLoop:Disconnect()
        end
        
        for player, esp in pairs(ESPObjects) do
            RemoveESP(player)
        end
    end
end)

print("✅ C00lKid Universal ESP V2 loaded!")
print("🎯 Custom GUI created")
print("📊 ESP system ready for any game")
