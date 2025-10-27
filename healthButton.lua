local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local function healPlayer()
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local healButton = Instance.new("TextButton")
healButton.Size = UDim2.new(0, 140, 0, 50)
healButton.Position = UDim2.new(0, 20, 0, 20)
healButton.Text = "💖 Лечение"
healButton.TextColor3 = Color3.fromRGB(255, 255, 255)
healButton.TextSize = 16
healButton.Font = Enum.Font.GothamBold
healButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)

-- Закругленные углы
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = healButton

-- Подсветка
local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(255, 255, 255)
glow.Thickness = 2
glow.Parent = healButton

healButton.Parent = screenGui

-- Звук нажатия
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3578203219" -- Звук клика
sound.Volume = 0.5
sound.Parent = healButton

-- Анимация наведения
healButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(healButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 200, 255),
        Size = UDim2.new(0, 150, 0, 55)
    })
    tween:Play()
end)

healButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(healButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
        Size = UDim2.new(0, 140, 0, 50)
    })
    tween:Play()
end)

-- Перетаскивание кнопки
local dragging = false
local dragInput, dragStart, startPos

healButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = healButton.Position
    end
end)

healButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        healButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Анимация нажатия с звуком
healButton.MouseButton1Click:Connect(function()
    sound:Play()
    
    local tween = TweenService:Create(healButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(0, 255, 100),
        Size = UDim2.new(0, 130, 0, 45)
    })
    tween:Play()
    
    wait(0.1)
    
    local tween2 = TweenService:Create(healButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
        Size = UDim2.new(0, 140, 0, 50)
    })
    tween2:Play()
    
    healPlayer()
end)

print("🎯 Улучшенная кнопка лечения загружена!")
