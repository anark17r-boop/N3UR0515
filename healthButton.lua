local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Функция лечения
local function healPlayer()
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
            print("💖 Здоровье восстановлено!")
        end
    end
end

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HealButtonGUI"
screenGui.Parent = game.CoreGui  -- Используем CoreGui вместо PlayerGui

-- Создаем кнопку
local healButton = Instance.new("TextButton")
healButton.Name = "HealButton"
healButton.Size = UDim2.new(0, 140, 0, 50)
healButton.Position = UDim2.new(0, 20, 0, 20)
healButton.Text = "💖 Лечение"
healButton.TextColor3 = Color3.fromRGB(255, 255, 255)
healButton.TextSize = 16
healButton.Font = Enum.Font.GothamBold
healButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
healButton.BorderSizePixel = 0
healButton.ZIndex = 10

-- Закругленные углы
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = healButton

-- Подсветка
local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(255, 255, 255)
glow.Thickness = 2
glow.Parent = healButton

-- Помещаем кнопку в GUI
healButton.Parent = screenGui

print("🔧 Кнопка создана, проверяем...")

-- Анимация наведения
healButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(healButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    })
    tween:Play()
end)

healButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(healButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255)
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
        print("🖱️ Начало перетаскивания")
    end
end)

healButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        healButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Обработчик клика
healButton.MouseButton1Click:Connect(function()
    print("🎯 Кнопка нажата!")
    
    -- Анимация нажатия
    local tween1 = TweenService:Create(healButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(0, 255, 100),
        Size = UDim2.new(0, 130, 0, 45)
    })
    tween1:Play()
    
    wait(0.1)
    
    local tween2 = TweenService:Create(healButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255),
        Size = UDim2.new(0, 140, 0, 50)
    })
    tween2:Play()
    
    -- Вызываем лечение
    healPlayer()
end)

print("✅ Улучшенная кнопка лечения загружена!")
print("📍 Должна быть в левом верхнем углу")
