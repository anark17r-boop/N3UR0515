-- Создаем GUI напрямую без библиотек
local Player = game:GetService("Players").LocalPlayer
local Gui = Instance.new("ScreenGui")
Gui.Name = "MainExploitGUI"
Gui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = Gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Title.Text = "C00lKid Exploit V15"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Функция создания кнопок
local yOffset = 60
local function CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, 0, yOffset)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Parent = MainFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    yOffset = yOffset + 50
end

-- Функция создания слайдера
local function CreateSlider(text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0.9, 0, 0, 60)
    SliderFrame.Position = UDim2.new(0.05, 0, 0, yOffset)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = MainFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 10)
    Track.Position = UDim2.new(0, 0, 0, 30)
    Track.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Track.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
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
    
    yOffset = yOffset + 70
end

-- Добавляем функции
CreateSlider("Скорость", 16, 500, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

CreateSlider("Прыжок", 50, 500, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

CreateButton("🔥 Поджечь всех", function()
    for i, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local fire = Instance.new("Fire")
            fire.Size = 20
            fire.Parent = p.Character.HumanoidRootPart
        end
    end
end)

CreateButton("💀 Бессмертие", function()
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        humanoid.Health = 100
    end)
end)

print("🎉 C00lKid Exploit V15 загружен!")
