-- UShaders Premium - Custom Beautiful UI
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- СОЗДАЕМ ПРЕМИУМ GUI
local ShadersGui = Instance.new("ScreenGui")
ShadersGui.Name = "UShadersPremiumGUI"
ShadersGui.Parent = game:GetService("CoreGui")

-- ОСНОВНОЙ КОНТЕЙНЕР
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 450, 0, 600)
MainContainer.Position = UDim2.new(0.5, -225, 0.5, -300)
MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Parent = ShadersGui

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
Title.Text = "🎨 UShaders Premium"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0.8, 0, 0.3, 0)
SubTitle.Position = UDim2.new(0.05, 0, 0.6, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Shaders • Atmosphere • Visuals"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- КНОПКА ЗАКРЫТИЯ
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(0.92, 0, 0.1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- ВКЛАДКИ
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 70)
TabsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TabsFrame.Parent = MainContainer

local Tabs = {"🔮 Shaders", "🌌 Sky", "🎨 Visual"}
local CurrentTab = "🔮 Shaders"
local TabButtons = {}

-- СОЗДАЕМ КНОПКИ ВКЛАДОК
for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1/#Tabs, 0, 1, 0)
    TabButton.Position = UDim2.new((i-1)/#Tabs, 0, 0, 0)
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(30, 30, 40)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 12
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabsFrame
    
    TabButton.MouseButton1Click:Connect(function()
        CurrentTab = tabName
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        UpdateContent()
    end)
    
    table.insert(TabButtons, TabButton)
end

-- ОБЛАСТЬ КОНТЕНТА
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -110)
ContentFrame.Position = UDim2.new(0, 0, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainContainer

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -10)
ScrollFrame.Position = UDim2.new(0, 5, 0, 5)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
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

-- ЗАКРЫТИЕ ОКНА
CloseButton.MouseButton1Click:Connect(function()
    ShadersGui.Enabled = false
end)

-- ФУНКЦИЯ СОЗДАНИЯ ПРЕМИУМ КНОПКИ
local yOffset = 0
local function CreatePremiumButton(text, description, callback, color)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 60)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = ScrollFrame
    
    local ButtonBackground = Instance.new("Frame")
    ButtonBackground.Size = UDim2.new(1, 0, 0, 50)
    ButtonBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ButtonBackground.Parent = ButtonFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = ButtonBackground
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = ButtonBackground
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0, 5)
    Icon.BackgroundColor3 = color or Color3.fromRGB(50, 50, 60)
    Icon.Text = "✨"
    Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    Icon.TextSize = 18
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = ButtonBackground
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = Icon
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 0, 25)
    TitleLabel.Position = UDim2.new(0, 60, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = text
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = ButtonBackground
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -60, 0, 20)
    DescLabel.Position = UDim2.new(0, 60, 0, 25)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = ButtonBackground
    
    -- АНИМАЦИИ
    Button.MouseEnter:Connect(function()
        TweenService:Create(ButtonBackground, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(ButtonBackground, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        }):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(ButtonBackground, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        }):Play()
        wait(0.1)
        TweenService:Create(ButtonBackground, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        }):Play()
        
        callback()
    end)
    
    ButtonFrame.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + 65
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    
    return ButtonFrame
end

-- ФУНКЦИЯ СОЗДАНИЯ ПЕРЕКЛЮЧАТЕЛЯ
local function CreatePremiumToggle(text, configKey, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ScrollFrame
    
    local ToggleBackground = Instance.new("Frame")
    ToggleBackground.Size = UDim2.new(1, 0, 0, 35)
    ToggleBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ToggleBackground.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleBackground
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 20)
    ToggleButton.Position = UDim2.new(0.03, 0, 0.2, 0)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleBackground
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
    ToggleButtonCorner.Parent = ToggleButton
    
    local ToggleKnob = Instance.new("Frame")
    ToggleKnob.Size = UDim2.new(0, 16, 0, 16)
    ToggleKnob.Position = UDim2.new(default and 0.55 or 0.05, 0, 0.1, 0)
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
    ToggleLabel.TextSize = 13
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleBackground
    
    local toggleState = default
    
    ToggleButton.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if toggleState then
            TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.55, 0, 0.1, 0)}):Play()
        else
            TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
            TweenService:Create(ToggleKnob, tweenInfo, {Position = UDim2.new(0.05, 0, 0.1, 0)}):Play()
        end
        
        callback(toggleState)
    end)
    
    ToggleFrame.Position = UDim2.new(0, 0, 0, yOffset)
    yOffset = yOffset + 45
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    
    return ToggleFrame
end

-- ФУНКЦИИ ШЕЙДЕРОВ
local function CreateBloomEffect()
    local bloom = Instance.new("BloomEffect")
    bloom.Name = "UShadersBloom"
    bloom.Intensity = 0.5
    bloom.Threshold = 1
    bloom.Size = 24
    bloom.Parent = Lighting
end

local function CreateBlurEffect()
    local blur = Instance.new("BlurEffect")
    blur.Name = "UShadersBlur"
    blur.Size = 5
    blur.Parent = Lighting
end

local function CreatePinkSky()
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    
    local sky = Instance.new("Sky")
    sky.Name = "UShadersPinkSky"
    sky.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
    sky.SkyboxDn = "http://www.roblox.com/asset/?id=271042516"
    sky.SkyboxFt = "http://www.roblox.com/asset/?id=271042516"
    sky.SkyboxLf = "http://www.roblox.com/asset/?id=271042516"
    sky.SkyboxRt = "http://www.roblox.com/asset/?id=271042516"
    sky.SkyboxUp = "http://www.roblox.com/asset/?id=271042516"
    sky.Parent = Lighting
    
    Lighting.Ambient = Color3.fromRGB(255, 200, 200)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 150, 150)
end

local function CreateRedSky()
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    
    local sky = Instance.new("Sky")
    sky.Name = "UShadersRedSky"
    sky.SkyboxBk = "http://www.roblox.com/asset/?id=271042517"
    sky.SkyboxDn = "http://www.roblox.com/asset/?id=271042517"
    sky.SkyboxFt = "http://www.roblox.com/asset/?id=271042517"
    sky.SkyboxLf = "http://www.roblox.com/asset/?id=271042517"
    sky.SkyboxRt = "http://www.roblox.com/asset/?id=271042517"
    sky.SkyboxUp = "http://www.roblox.com/asset/?id=271042517"
    sky.Parent = Lighting
    
    Lighting.Ambient = Color3.fromRGB(255, 100, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 50, 50)
end

local function CreateBlackSky()
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    
    local sky = Instance.new("Sky")
    sky.Name = "UShadersBlackSky"
    sky.SkyboxBk = "http://www.roblox.com/asset/?id=271042518"
    sky.SkyboxDn = "http://www.roblox.com/asset/?id=271042518"
    sky.SkyboxFt = "http://www.roblox.com/asset/?id=271042518"
    sky.SkyboxLf = "http://www.roblox.com/asset/?id=271042518"
    sky.SkyboxRt = "http://www.roblox.com/asset/?id=271042518"
    sky.SkyboxUp = "http://www.roblox.com/asset/?id=271042518"
    sky.Parent = Lighting
    
    Lighting.Ambient = Color3.fromRGB(50, 50, 50)
    Lighting.OutdoorAmbient = Color3.fromRGB(30, 30, 30)
end

-- ФУНКЦИЯ ОБНОВЛЕНИЯ КОНТЕНТА
function UpdateContent()
    ScrollFrame:ClearAllChildren()
    yOffset = 0
    
    if CurrentTab == "🔮 Shaders" then
        CreatePremiumToggle("Bloom Effect", "Bloom", false, function(state)
            if state then
                CreateBloomEffect()
            else
                local bloom = Lighting:FindFirstChild("UShadersBloom")
                if bloom then bloom:Destroy() end
            end
        end)
        
        CreatePremiumToggle("Blur Effect", "Blur", false, function(state)
            if state then
                CreateBlurEffect()
            else
                local blur = Lighting:FindFirstChild("UShadersBlur")
                if blur then blur:Destroy() end
            end
        end)
        
    elseif CurrentTab == "🌌 Sky" then
        CreatePremiumButton("🌸 Pink Sky", "Розовая атмосфера с нежным небом", CreatePinkSky, Color3.fromRGB(255, 150, 200))
        
        CreatePremiumButton("🔴 Red Sky", "Красная драматичная атмосфера", CreateRedSky, Color3.fromRGB(255, 50, 50))
        
        CreatePremiumButton("⚫ Black Sky", "Темная мистическая атмосфера", CreateBlackSky, Color3.fromRGB(50, 50, 50))
        
    elseif CurrentTab == "🎨 Visual" then
        CreatePremiumButton("🖼️ Stretch Screen", "Растянуть экран с эффектом", function()
            local stretchGui = Instance.new("ScreenGui")
            stretchGui.Name = "UShadersStretch"
            stretchGui.ResetOnSpawn = false
            
            local stretchFrame = Instance.new("Frame")
            stretchFrame.Size = UDim2.new(1, 0, 1, 0)
            stretchFrame.BackgroundColor3 = Color3.new(0, 0, 0)
            stretchFrame.BackgroundTransparency = 1
            stretchFrame.Parent = stretchGui
            
            stretchGui.Parent = LocalPlayer.PlayerGui
            
            for i = 1, 0, -0.1 do
                stretchFrame.BackgroundTransparency = i
                wait(0.05)
            end
        end, Color3.fromRGB(0, 150, 255))
        
        CreatePremiumButton("🔄 Reset Screen", "Вернуть обычный экран", function()
            local stretchGui = LocalPlayer.PlayerGui:FindFirstChild("UShadersStretch")
            if stretchGui then stretchGui:Destroy() end
        end, Color3.fromRGB(100, 100, 100))
        
        CreatePremiumButton("🗑️ Reset All", "Сбросить все эффекты", function()
            local effects = {
                "UShadersBloom", "UShadersBlur", "UShadersPinkSky", 
                "UShadersRedSky", "UShadersBlackSky", "UShadersStretch"
            }
            
            for _, effectName in ipairs(effects) do
                local effect = Lighting:FindFirstChild(effectName) or LocalPlayer.PlayerGui:FindFirstChild(effectName)
                if effect then effect:Destroy() end
            end
            
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end, Color3.fromRGB(255, 50, 50))
    end
end

-- КЛАВИША ДЛЯ ОТКРЫТИЯ МЕНЮ
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.U then
        ShadersGui.Enabled = not ShadersGui.Enabled
    end
end)

-- ИНИЦИАЛИЗАЦИЯ
UpdateContent()
print("✅ UShaders Premium loaded! Press U to open/close")
