local player = game.Players.LocalPlayer

local function healPlayer()
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
        end  -- Закрываем второй if
    end  -- Закрываем первый if
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local healButton = Instance.new("TextButton")
healButton.Size = UDim2.new(0, 100, 0, 50)  
healButton.Position = UDim2.new(0, 20, 0, 20) 
healButton.Text = "Лечение 🏥"  
healButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

healButton.Parent = screenGui

healButton.MouseButton1Click:Connect(healPlayer)

print("🎯 Скрипт лечения загружен! Нажми кнопку 'Лечение 🏥'")
