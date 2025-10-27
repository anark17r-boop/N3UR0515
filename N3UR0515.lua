-- C00lKid Exploit V21 - Fluent UI Fixed
print("🔧 Загрузка Fluent UI...")

local success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)

if not success then
    -- Альтернативный источник
    Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/main.lua"))()
end

print("✅ Fluent UI загружен")

-- Создаем простой GUI если Fluent не работает
if not Fluent then
    print("❌ Fluent не загружен, создаю базовый GUI...")
    
    local Player = game:GetService("Players").LocalPlayer
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "C00lKidBasicGUI"
    Gui.Parent = Player:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Parent = Gui
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Title.Text = "C00lKid Exploit V21 - BASIC MODE"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Parent = MainFrame
    
    -- Простые функции
    local function CreateButton(text, y, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0.9, 0, 0, 35)
        Button.Position = UDim2.new(0.05, 0, 0, y)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Parent = MainFrame
        Button.MouseButton1Click:Connect(callback)
        return y + 40
    end
    
    local yPos = 50
    yPos = CreateButton("🚀 Скорость 100", yPos, function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end)
    
    yPos = CreateButton("🦘 Прыжок 150", yPos, function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
    end)
    
    yPos = CreateButton("🔥 Поджечь всех", yPos, function()
        for i, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local fire = Instance.new("Fire")
                fire.Size = 20
                fire.Parent = p.Character.HumanoidRootPart
            end
        end
    end)
    
    yPos = CreateButton("🌌 Заменить небо", yPos, function()
        local shirt = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Shirt")
        if shirt then
            local sky = Instance.new("Sky")
            sky.SkyboxBk = shirt.ShirtTemplate
            sky.SkyboxFt = shirt.ShirtTemplate
            sky.SkyboxLf = shirt.ShirtTemplate
            sky.SkyboxRt = shirt.ShirtTemplate
            sky.SkyboxUp = shirt.ShirtTemplate
            sky.SkyboxDn = shirt.ShirtTemplate
            sky.Parent = game.Lighting
        end
    end)
    
    print("✅ Базовый GUI создан")
    return
end

-- Если Fluent загружен, создаем полноценный интерфейс
print("🎨 Создание Fluent UI интерфейса...")

local Window = Fluent:CreateWindow({
    Title = "C00lKid Exploit V21",
    SubTitle = "by Colin - Рабочая версия",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Отключаем для стабильности
    Theme = "Dark"
})

-- ВКЛАДКИ
local MainTab = Window:CreateTab("Основные", "rbxassetid://4483345998")
local TrollingTab = Window:CreateTab("Троллинг", "rbxassetid://4483345998")
local VisualTab = Window:CreateTab("Визуал", "rbxassetid://4483345998")

-- ОСНОВНЫЕ ФУНКЦИИ
MainTab:CreateSection("Управление персонажем")

MainTab:AddButton({
    Title = "🚀 Установить скорость 100",
    Description = "Быстрое увеличение скорости",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
})

MainTab:AddButton({
    Title = "🦘 Установить прыжок 150", 
    Description = "Быстрое увеличение силы прыжка",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
    end
})

-- ТРОЛЛИНГ
TrollingTab:CreateSection("Взаимодействие")

TrollingTab:AddButton({
    Title = "🔥 Поджечь всех игроков",
    Description = "Создает огонь на всех игроках",
    Callback = function()
        for i, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                local fire = Instance.new("Fire")
                fire.Size = 25
                fire.Parent = p.Character.HumanoidRootPart
            end
        end
        Fluent:Notify({
            Title = "Успех",
            Content = "Все игроки подожжены!",
            Duration = 5
        })
    end
})

-- ВИЗУАЛ
VisualTab:CreateSection("Эффекты")

VisualTab:AddButton({
    Title = "🌌 Заменить небо на скин",
    Description = "Меняет текстуру неба",
    Callback = function()
        local shirt = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Shirt")
        if shirt then
            local sky = Instance.new("Sky")
            sky.SkyboxBk = shirt.ShirtTemplate
            sky.SkyboxFt = shirt.ShirtTemplate  
            sky.SkyboxLf = shirt.ShirtTemplate
            sky.SkyboxRt = shirt.ShirtTemplate
            sky.SkyboxUp = shirt.ShirtTemplate
            sky.SkyboxDn = shirt.ShirtTemplate
            sky.Parent = game.Lighting
            Fluent:Notify({
                Title = "Успех",
                Content = "Небо заменено!",
                Duration = 5
            })
        end
    end
})

print("✅ C00lKid Exploit V21 готов!")
Fluent:Notify({
    Title = "Готово!",
    Content = "C00lKid Exploit загружен успешно!",
    Duration = 5
})
