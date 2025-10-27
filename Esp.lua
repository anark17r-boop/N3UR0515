-- C00lKid Premium ESP V3 - Luxury Edition
local Players = game:GetService("Players")
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАЕМ LUXURY GUI
local ESPGui = Instance.new("ScreenGui")
ESPGui.Name = "C00lKidLuxuryESP"
ESPGui.Parent = game:GetService("CoreGui")
ESPGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 400, 0, 550)
MainContainer.Position = UDim2.new(0.02, 0, 0.3, 0)
MainContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Parent = ESPGui

-- GLOW EFFECT
local Glow = Instance.new("ImageLabel")
Glow.Name = "GlowEffect"
Glow.Size = UDim2.new(1, 20, 1, 20)
Glow.Position = UDim2.new(0, -10, 0, -10)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://8992230671"
Glow.ImageColor3 = Color3.fromRGB(0, 100, 255)
Glow.ImageTransparency = 0.8
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

-- HEADER WITH GRADIENT
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Header.BorderSizePixel = 0
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

-- GRADIENT EFFECT
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 255))
})
Gradient.Rotation = 45
Gradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎯 PREMIUM ESP V3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 0, 20)
Title.Position = UDim2.new(0.05, 0, 0.5, 0)
Title.BackgroundTransparency = 1
Title.Text = "Luxury Edition"
Title.TextColor3 = Color3.fromRGB(200, 200, 255)
Title.TextSize = 12
Title.Font = Enum.Font.Gotham
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- PREMIUM TOGGLE BUTTON
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(0, 100, 0, 35)
ToggleContainer.Position = UDim2.new(0.7, 0, 0.2, 0)
ToggleContainer.BackgroundTransparency = 1
ToggleContainer.Parent = Header

local ToggleBackground = Instance.new("Frame")
ToggleBackground.Size = UDim2.new(1, 0, 1, 0)
ToggleBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ToggleBackground.Parent = ToggleContainer

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBackground

local ToggleKnob = Instance.new("Frame")
ToggleKnob.Size = UDim2.new(0, 25, 0, 25)
ToggleKnob.Position = UDim2.new(0.05, 0, 0.14, 0)
ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleKnob.Parent = ToggleContainer

local ToggleKnobCorner = Instance.new("UICorner")
ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
ToggleKnobCorner.Parent = ToggleKnob

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "OFF"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.TextSize = 12
ToggleLabel.Font = Enum.Font.GothamBold
ToggleLabel.Parent = ToggleContainer

-- CONTENT AREA
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -80)
ContentFrame.Position = UDim2.new(0, 10, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainContainer

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = ContentFrame

-- DRAGGING
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

-- ESP CONFIG
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
    BoxColor = Color3.fromRGB(0, 255, 150),
    TextColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(255, 255, 255),
    TeamColor = true
}

-- ESP VARIABLES
local ESPObjects = {}
local ESPLoop

-- PREMIUM TOGGLE FUNCTION
local function CreatePremiumToggle(text, configKey, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ScrollFrame
    
    local ToggleBackground = Instance.new("Frame")
    ToggleBackground.Size = UDim2.new(1, 0, 0, 35)
    ToggleBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ToggleBackground.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleBackground
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(0.03, 0, 0.14, 0)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleBackground
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
    ToggleButtonCorner.Parent = ToggleButton
    
    local ToggleKnob = Instance.new("Frame")
    ToggleKnob.Size = UDim2.new(0, 19, 0, 19)
    ToggleKnob.Position = UDim2.new(default and 0.55 or 0.05, 0, 0.12, 0)
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
    
    -- ANIMATION
    ToggleButton.MouseButton1Click:Connect(function()
        ESPConfig[configKey] = not ESPConfig[configKey]
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if ESPConfig[configKey] then
            TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.55, 0, 0.12, 0)}):Play()
        else
            TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.05, 0, 0.12, 0)}):Play()
        end
    end)
    
    return ToggleFrame
end

-- PREMIUM SLIDER FUNCTION
local function CreatePremiumSlider(text, configKey, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = ScrollFrame
    
    local SliderBackground = Instance.new("Frame")
    SliderBackground.Size = UDim2.new(1, 0, 0, 45)
    SliderBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
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
    Track.Size = UDim2.new(1, -30, 0, 6)
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
    
    return SliderFrame
end

-- ADD SETTINGS TO SCROLL FRAME
local yOffset = 0
local function AddElement(element)
    element.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + element.Size.Y.Offset + 5
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- ESP SETTINGS
AddElement(CreatePremiumToggle("📦 Box ESP", "Box", true))
AddElement(CreatePremiumToggle("🏷️ Player Names", "Name", true))
AddElement(CreatePremiumToggle("❤️ Health Display", "Health", true))
AddElement(CreatePremiumToggle("📏 Distance", "Distance", true))
AddElement(CreatePremiumToggle("🎯 Tracers", "Tracers", true))
AddElement(CreatePremiumToggle("👤 Player Avatar", "Avatar", true))
AddElement(CreatePremiumToggle("🎨 Team Colors", "TeamColor", true))
AddElement(CreatePremiumSlider("🔭 Max Distance", "MaxDistance", 0, 2000, 1000))

-- ESP FUNCTIONS (остаются такими же как в предыдущей версии)
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
    
    -- PREMIUM BOX WITH GLOW
    esp.Box = Instance.new("Frame")
    esp.Box.Name = "ESPBox_" .. player.Name
    esp.Box.BackgroundTransparency = 0.7
    esp.Box.BackgroundColor3 = ESPConfig.BoxColor
    esp.Box.BorderSizePixel = 0
    esp.Box.ZIndex = 10
    esp.Box.Visible = false
    esp.Box.Parent = ESPGui
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = esp.Box
    
    -- GLOW EFFECT FOR BOX
    local BoxGlow = Instance.new("ImageLabel")
    BoxGlow.Size = UDim2.new(1, 6, 1, 6)
    BoxGlow.Position = UDim2.new(0, -3, 0, -3)
    BoxGlow.BackgroundTransparency = 1
    BoxGlow.Image = "rbxassetid://8992230671"
    BoxGlow.ImageColor3 = ESPConfig.BoxColor
    BoxGlow.ImageTransparency = 0.7
    BoxGlow.ScaleType = Enum.ScaleType.Slice
    BoxGlow.SliceCenter = Rect.new(23, 23, 277, 277)
    BoxGlow.Parent = esp.Box
    
    -- PREMIUM NAME LABEL
    esp.NameLabel = Instance.new("TextLabel")
    esp.NameLabel.Name = "ESPName_" .. player.Name
    esp.NameLabel.Text = player.Name
    esp.NameLabel.TextColor3 = ESPConfig.TextColor
    esp.NameLabel.TextSize = 14
    esp.NameLabel.Font = Enum.Font.GothamBold
    esp.NameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    esp.NameLabel.BackgroundTransparency = 0.5
    esp.NameLabel.ZIndex = 11
    esp.NameLabel.Visible = false
    esp.NameLabel.Parent = ESPGui
    
    local NameCorner = Instance.new("UICorner")
    NameCorner.CornerRadius = UDim.new(0, 4)
    NameCorner.Parent = esp.NameLabel
    
    -- PREMIUM HEALTH BAR
    esp.HealthLabel = Instance.new("Frame")
    esp.HealthLabel.Name = "ESPHealth_" .. player.Name
    esp.HealthLabel.Size = UDim2.new(0, 60, 0, 15)
    esp.HealthLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    esp.HealthLabel.ZIndex = 11
    esp.HealthLabel.Visible = false
    esp.HealthLabel.Parent = ESPGui
    
    local HealthCorner = Instance.new("UICorner")
    HealthCorner.CornerRadius = UDim.new(0, 4)
    HealthCorner.Parent = esp.HealthLabel
    
    esp.HealthBar = Instance.new("Frame")
    esp.HealthBar.Size = UDim2.new(1, 0, 1, 0)
    esp.HealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    esp.HealthBar.Parent = esp.HealthLabel
    
    local HealthBarCorner = Instance.new("UICorner")
    HealthBarCorner.CornerRadius = UDim.new(0, 4)
    HealthBarCorner.Parent = esp.HealthBar
    
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
    esp.DistanceLabel.Name = "ESPDistance_" .. player.Name
    esp.DistanceLabel.Text = "0m"
    esp.DistanceLabel.TextColor3 = ESPConfig.TextColor
    esp.DistanceLabel.TextSize = 12
    esp.DistanceLabel.Font = Enum.Font.Gotham
    esp.DistanceLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    esp.DistanceLabel.BackgroundTransparency = 0.5
    esp.DistanceLabel.ZIndex = 11
    esp.DistanceLabel.Visible = false
    esp.DistanceLabel.Parent = ESPGui
    
    local DistanceCorner = Instance.new("UICorner")
    DistanceCorner.CornerRadius = UDim.new(0, 4)
    DistanceCorner.Parent = esp.DistanceLabel
    
    -- PREMIUM TRACER
    esp.Tracer = Instance.new("Frame")
    esp.Tracer.Name = "ESPTracer_" .. player.Name
    esp.Tracer.BackgroundColor3 = ESPConfig.TracerColor
    esp.Tracer.BorderSizePixel = 0
    esp.Tracer.Size = UDim2.new(0, 2, 0, 1)
    esp.Tracer.ZIndex = 9
    esp.Tracer.Visible = false
    esp.Tracer.Parent = ESPGui
    
    -- PREMIUM AVATAR WITH BORDER
    esp.Avatar = Instance.new("ImageLabel")
    esp.Avatar.Name = "ESPAvatar_" .. player.Name
    esp.Avatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    esp.Avatar.Size = UDim2.new(0, 30, 0, 30)
    esp.Avatar.ZIndex = 12
    esp.Avatar.Visible = false
    esp.Avatar.Parent = ESPGui
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = esp.Avatar
    
    pcall(function()
        esp.Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
    end)
    
    ESPObjects[player] = esp
end

-- Остальные функции (UpdateESP, RemoveESP) остаются такими же как в предыдущей версии
-- ... (код функций UpdateESP и RemoveESP)

-- PREMIUM TOGGLE ANIMATION
ToggleContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        ESPConfig.Enabled = not ESPConfig.Enabled
        
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if ESPConfig.Enabled then
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.55, 0, 0.14, 0)}):Play()
            TweenService:Create(ToggleBackground, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 100, 200)}):Play()
            TweenLabel.Text = "ON"
            
            -- ВКЛЮЧАЕМ ESP СИСТЕМУ
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    CreateESP(player)
                end
            end
            
            ESPLoop = RunService.RenderStepped:Connect(function()
                for player, esp in pairs(ESPObjects) do
                    if player and player.Character then
                        UpdateESP(player)
                    else
                        RemoveESP(player)
                    end
                end
            end)
            
        else
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.05, 0, 0.14, 0)}):Play()
            TweenService:Create(ToggleBackground, tweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
            ToggleLabel.Text = "OFF"
            
            -- ВЫКЛЮЧАЕМ ESP СИСТЕМУ
            if ESPLoop then
                ESPLoop:Disconnect()
            end
            
            for player, esp in pairs(ESPObjects) do
                RemoveESP(player)
            end
        end
    end
end)

print("✅ C00lKid Premium ESP V3 - Luxury Edition loaded!")
print("🎨 Ultra beautiful interface activated")
print("🎯 Premium ESP system ready")
