-- C00lKid 99 Nights ESP V1 - Mob & Player Tracker
local Players = game:GetService("Players")
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ПЕРЕМЕННЫЕ ДЛЯ 99 НОЧЕЙ
local ESPEnabled = false
local ESPObjects = {}
local ESPLoop

-- КОНФИГ ДЛЯ 99 НОЧЕЙ
local ESPConfig = {
    MaxDistance = 10000, -- 10к дистанция
    PlayerColor = Color3.fromRGB(0, 255, 0),
    MobColor = Color3.fromRGB(255, 0, 0),
    BossColor = Color3.fromRGB(255, 0, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    ShowNames = true,
    ShowDistance = true,
    ShowHealth = true,
    ShowTracers = true
}

-- ПРОСТОЙ GUI ДЛЯ УПРАВЛЕНИЯ
local ESPGui = Instance.new("ScreenGui")
ESPGui.Name = "C00lKid99NightsESP"
ESPGui.Parent = game:GetService("CoreGui")

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 200, 0, 40)
StatusLabel.Position = UDim2.new(0, 10, 0, 10)
StatusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatusLabel.BackgroundTransparency = 0.5
StatusLabel.Text = "99 Nights ESP: OFF (Press K)"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Visible = true
StatusLabel.Parent = ESPGui

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusLabel

-- ФУНКЦИЯ ОПРЕДЕЛЕНИЯ ТИПА ОБЪЕКТА
local function GetObjectType(obj)
    if obj:IsA("Model") then
        local humanoid = obj:FindFirstChildOfClass("Humanoid")
        if humanoid then
            -- ПРОВЕРЯЕМ ИГРОКА
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character == obj then
                    return "Player"
                end
            end
            
            -- ПРОВЕРЯЕМ МОБОВ И БОССОВ
            local name = obj.Name:lower()
            if name:find("boss") or name:find("mini") or name:find("giant") then
                return "Boss"
            elseif name:find("zombie") or name:find("skeleton") or name:find("monster") or name:find("enemy") then
                return "Mob"
            end
        end
    end
    return nil
end

-- ФУНКЦИЯ СОЗДАНИЯ ESP
local function CreateESP(obj)
    if ESPObjects[obj] then return end
    
    local objType = GetObjectType(obj)
    if not objType then return end
    
    local esp = {
        Object = obj,
        Type = objType,
        Box = nil,
        NameLabel = nil,
        HealthLabel = nil,
        DistanceLabel = nil,
        Tracer = nil
    }
    
    -- BOX ESP
    esp.Box = Instance.new("Frame")
    esp.Box.Name = "ESPBox_" .. obj.Name
    esp.Box.BackgroundTransparency = 0.7
    esp.Box.BorderSizePixel = 2
    esp.Box.BorderColor3 = Color3.fromRGB(255, 255, 255)
    esp.Box.ZIndex = 10
    esp.Box.Visible = false
    esp.Box.Parent = ESPGui
    
    -- NAME LABEL
    esp.NameLabel = Instance.new("TextLabel")
    esp.NameLabel.Name = "ESPName_" .. obj.Name
    esp.NameLabel.Text = obj.Name
    esp.NameLabel.TextColor3 = ESPConfig.TextColor
    esp.NameLabel.TextSize = 12
    esp.NameLabel.Font = Enum.Font.GothamBold
    esp.NameLabel.BackgroundTransparency = 1
    esp.NameLabel.ZIndex = 11
    esp.NameLabel.Visible = false
    esp.NameLabel.Parent = ESPGui
    
    -- HEALTH LABEL
    esp.HealthLabel = Instance.new("TextLabel")
    esp.HealthLabel.Name = "ESPHealth_" .. obj.Name
    esp.HealthLabel.Text = "HP: 100"
    esp.HealthLabel.TextColor3 = ESPConfig.TextColor
    esp.HealthLabel.TextSize = 11
    esp.HealthLabel.Font = Enum.Font.Gotham
    esp.HealthLabel.BackgroundTransparency = 1
    esp.HealthLabel.ZIndex = 11
    esp.HealthLabel.Visible = false
    esp.HealthLabel.Parent = ESPGui
    
    -- DISTANCE LABEL
    esp.DistanceLabel = Instance.new("TextLabel")
    esp.DistanceLabel.Name = "ESPDistance_" .. obj.Name
    esp.DistanceLabel.Text = "0m"
    esp.DistanceLabel.TextColor3 = ESPConfig.TextColor
    esp.DistanceLabel.TextSize = 11
    esp.DistanceLabel.Font = Enum.Font.Gotham
    esp.DistanceLabel.BackgroundTransparency = 1
    esp.DistanceLabel.ZIndex = 11
    esp.DistanceLabel.Visible = false
    esp.DistanceLabel.Parent = ESPGui
    
    -- TRACER
    esp.Tracer = Instance.new("Frame")
    esp.Tracer.Name = "ESPTracer_" .. obj.Name
    esp.Tracer.BackgroundColor3 = ESPConfig.TextColor
    esp.Tracer.BorderSizePixel = 0
    esp.Tracer.Size = UDim2.new(0, 1, 0, 1)
    esp.Tracer.ZIndex = 9
    esp.Tracer.Visible = false
    esp.Tracer.Parent = ESPGui
    
    ESPObjects[obj] = esp
end

-- ФУНКЦИЯ ОБНОВЛЕНИЯ ESP
local function UpdateESP(obj)
    local esp = ESPObjects[obj]
    if not esp or not obj.PrimaryPart then return end
    
    local humanoid = obj:FindFirstChildOfClass("Humanoid")
    local rootPart = obj.PrimaryPart
    
    if not rootPart then return end
    
    -- ВЫЧИСЛЯЕМ ДИСТАНЦИЮ
    local distance = (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) and 
                    (rootPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude or 0
    
    if distance > ESPConfig.MaxDistance then
        if esp.Box then esp.Box.Visible = false end
        if esp.NameLabel then esp.NameLabel.Visible = false end
        if esp.HealthLabel then esp.HealthLabel.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
        return
    end
    
    -- WORLD TO SCREEN SPACE
    local vector, onScreen = CurrentCamera:WorldToViewportPoint(rootPart.Position)
    
    if onScreen then
        local scale = 1 / (vector.Z * math.tan(math.rad(CurrentCamera.FieldOfView * 0.5)) * 2) * 100
        local size = Vector3.new(4 * scale, 6 * scale, 0)
        
        -- ЦВЕТ В ЗАВИСИМОСТИ ОТ ТИПА
        local color
        if esp.Type == "Player" then
            color = ESPConfig.PlayerColor
        elseif esp.Type == "Boss" then
            color = ESPConfig.BossColor
        else
            color = ESPConfig.MobColor
        end
        
        -- ОБНОВЛЯЕМ BOX
        if esp.Box then
            esp.Box.Size = UDim2.new(0, size.X, 0, size.Y)
            esp.Box.Position = UDim2.new(0, vector.X - size.X / 2, 0, vector.Y - size.Y / 2)
            esp.Box.BackgroundColor3 = color
            esp.Box.Visible = true
        end
        
        -- ОБНОВЛЯЕМ ИМЯ
        if esp.NameLabel and ESPConfig.ShowNames then
            esp.NameLabel.Position = UDim2.new(0, vector.X, 0, vector.Y - size.Y / 2 - 15)
            esp.NameLabel.Visible = true
        else
            esp.NameLabel.Visible = false
        end
        
        -- ОБНОВЛЯЕМ ЗДОРОВЬЕ
        if esp.HealthLabel and ESPConfig.ShowHealth and humanoid then
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
        
        -- ОБНОВЛЯЕМ ДИСТАНЦИЮ
        if esp.DistanceLabel and ESPConfig.ShowDistance then
            esp.DistanceLabel.Text = math.floor(distance).."m"
            esp.DistanceLabel.Position = UDim2.new(0, vector.X, 0, vector.Y + size.Y / 2 + 20)
            esp.DistanceLabel.Visible = true
        else
            esp.DistanceLabel.Visible = false
        end
        
        -- ОБНОВЛЯЕМ TRACER
        if esp.Tracer and ESPConfig.ShowTracers then
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
        if esp.HealthLabel then esp.HealthLabel.Visible = false end
        if esp.DistanceLabel then esp.DistanceLabel.Visible = false end
        if esp.Tracer then esp.Tracer.Visible = false end
    end
end

-- ФУНКЦИЯ УДАЛЕНИЯ ESP
local function RemoveESP(obj)
    local esp = ESPObjects[obj]
    if esp then
        if esp.Box then esp.Box:Destroy() end
        if esp.NameLabel then esp.NameLabel:Destroy() end
        if esp.HealthLabel then esp.HealthLabel:Destroy() end
        if esp.DistanceLabel then esp.DistanceLabel:Destroy() end
        if esp.Tracer then esp.Tracer:Destroy() end
        ESPObjects[obj] = nil
    end
end

-- ФУНКЦИЯ ПОИСКА ОБЪЕКТОВ
local function FindObjects()
    local objects = {}
    
    -- ИЩЕМ ИГРОКОВ
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player ~= LocalPlayer then
            table.insert(objects, player.Character)
        end
    end
    
    -- ИЩЕМ МОБОВ И БОССОВ В WORKSPACE
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.PrimaryPart then
            local objType = GetObjectType(obj)
            if objType and (objType == "Mob" or objType == "Boss") then
                table.insert(objects, obj)
            end
        end
    end
    
    return objects
end

-- ФУНКЦИЯ ПЕРЕКЛЮЧЕНИЯ ESP
local function ToggleESP()
    ESPEnabled = not ESPEnabled
    
    if ESPEnabled then
        StatusLabel.Text = "99 Nights ESP: ON (Press K)"
        StatusLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        
        -- ЗАПУСКАЕМ ОСНОВНОЙ ЦИКЛ
        ESPLoop = RunService.RenderStepped:Connect(function()
            -- НАХОДИМ ВСЕ ОБЪЕКТЫ
            local objects = FindObjects()
            
            -- СОЗДАЕМ ESP ДЛЯ НОВЫХ ОБЪЕКТОВ
            for _, obj in ipairs(objects) do
                if not ESPObjects[obj] then
                    CreateESP(obj)
                end
            end
            
            -- ОБНОВЛЯЕМ И УДАЛЯЕМ СТАРЫЕ
            for obj, esp in pairs(ESPObjects) do
                if obj and obj.Parent then
                    UpdateESP(obj)
                else
                    RemoveESP(obj)
                end
            end
        end)
        
    else
        StatusLabel.Text = "99 Nights ESP: OFF (Press K)"
        StatusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        
        -- ОСТАНАВЛИВАЕМ ЦИКЛ И ОЧИЩАЕМ
        if ESPLoop then
            ESPLoop:Disconnect()
        end
        
        for obj, esp in pairs(ESPObjects) do
            RemoveESP(obj)
        end
    end
end

-- КЛАВИША K ДЛЯ ПЕРЕКЛЮЧЕНИЯ
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        ToggleESP()
    end
end)

-- АВТОМАТИЧЕСКОЕ ОБНОВЛЕНИЕ ПРИ ИЗМЕНЕНИЯХ В ИГРЕ
workspace.DescendantAdded:Connect(function(descendant)
    if ESPEnabled then
        wait(0.5) -- ЖДЕМ ЧУТЬ ДЛЯ ЗАГРУЗКИ МОДЕЛИ
        local objType = GetObjectType(descendant)
        if objType and (objType == "Mob" or objType == "Boss") then
            CreateESP(descendant)
        end
    end
end)

workspace.DescendantRemoving:Connect(function(descendant)
    if ESPObjects[descendant] then
        RemoveESP(descendant)
    end
end)

print("✅ C00lKid 99 Nights ESP V1 loaded!")
print("🎯 Press K to toggle ESP")
print("📏 Max distance: 10,000 studs")
print("👥 Tracking players and mobs")

-- ИНФОРМАЦИОННОЕ СООБЩЕНИЕ
StatusLabel.Text = "99 Nights ESP: OFF (Press K)\nTracking: Players, Mobs, Bosses"
StatusLabel.Size = UDim2.new(0, 250, 0, 50)
