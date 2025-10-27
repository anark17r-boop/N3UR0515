-- C00lKid Universal ESP V1
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎯 C00lKid Universal ESP V1",
   LoadingTitle = "Universal ESP System",
   LoadingSubtitle = "Loading player tracking...",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "C00lKidESP",
      FileName = "ESPConfig"
   },
   KeySystem = false,
})

local ESPTab = Window:CreateTab("🎯 ESP Settings", "rbxassetid://4483345998")
local VisualTab = Window:CreateTab("🎨 Visual", "rbxassetid://4483345998")

local Players = game:GetService("Players")
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ESP VARIABLES
local ESPObjects = {}
local ESPEnabled = false
local ESPLoop

-- ESP CONFIG
local ESPConfig = {
   Box = true,
   Name = true,
   Health = true,
   Distance = true,
   Tracers = true,
   Avatar = true,
   Chams = false,
   TeamCheck = false,
   MaxDistance = 1000,
   BoxColor = Color3.fromRGB(0, 255, 0),
   TextColor = Color3.fromRGB(255, 255, 255),
   TracerColor = Color3.fromRGB(255, 255, 255),
   TeamColor = true
}

-- CREATE ESP FOR PLAYER
local function CreateESP(player)
   if ESPObjects[player] or player == LocalPlayer then return end
   
   local esp = {
      Player = player,
      Box = nil,
      NameLabel = nil,
      HealthLabel = nil,
      DistanceLabel = nil,
      Tracer = nil,
      Avatar = nil,
      Cham = nil
   }
   
   -- BOX ESP
   if ESPConfig.Box then
      esp.Box = Instance.new("Frame")
      esp.Box.Name = "ESPBox"
      esp.Box.BackgroundTransparency = 0.8
      esp.Box.BackgroundColor3 = ESPConfig.BoxColor
      esp.Box.BorderSizePixel = 2
      esp.Box.BorderColor3 = Color3.fromRGB(255, 255, 255)
      esp.Box.ZIndex = 10
      esp.Box.Visible = false
      esp.Box.Parent = game:GetService("CoreGui")
   end
   
   -- NAME LABEL
   if ESPConfig.Name then
      esp.NameLabel = Instance.new("TextLabel")
      esp.NameLabel.Name = "ESPName"
      esp.NameLabel.Text = player.Name
      esp.NameLabel.TextColor3 = ESPConfig.TextColor
      esp.NameLabel.TextSize = 14
      esp.NameLabel.Font = Enum.Font.GothamBold
      esp.NameLabel.BackgroundTransparency = 1
      esp.NameLabel.ZIndex = 11
      esp.NameLabel.Visible = false
      esp.NameLabel.Parent = game:GetService("CoreGui")
   end
   
   -- HEALTH LABEL
   if ESPConfig.Health then
      esp.HealthLabel = Instance.new("TextLabel")
      esp.HealthLabel.Name = "ESPHealth"
      esp.HealthLabel.Text = "HP: 100"
      esp.HealthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
      esp.HealthLabel.TextSize = 12
      esp.HealthLabel.Font = Enum.Font.Gotham
      esp.HealthLabel.BackgroundTransparency = 1
      esp.HealthLabel.ZIndex = 11
      esp.HealthLabel.Visible = false
      esp.HealthLabel.Parent = game:GetService("CoreGui")
   end
   
   -- DISTANCE LABEL
   if ESPConfig.Distance then
      esp.DistanceLabel = Instance.new("TextLabel")
      esp.DistanceLabel.Name = "ESPDistance"
      esp.DistanceLabel.Text = "0m"
      esp.DistanceLabel.TextColor3 = ESPConfig.TextColor
      esp.DistanceLabel.TextSize = 12
      esp.DistanceLabel.Font = Enum.Font.Gotham
      esp.DistanceLabel.BackgroundTransparency = 1
      esp.DistanceLabel.ZIndex = 11
      esp.DistanceLabel.Visible = false
      esp.DistanceLabel.Parent = game:GetService("CoreGui")
   end
   
   -- TRACER
   if ESPConfig.Tracers then
      esp.Tracer = Instance.new("Frame")
      esp.Tracer.Name = "ESPTracer"
      esp.Tracer.BackgroundColor3 = ESPConfig.TracerColor
      esp.Tracer.BorderSizePixel = 0
      esp.Tracer.Size = UDim2.new(0, 1, 0, 1)
      esp.Tracer.ZIndex = 9
      esp.Tracer.Visible = false
      esp.Tracer.Parent = game:GetService("CoreGui")
   end
   
   -- AVATAR
   if ESPConfig.Avatar then
      esp.Avatar = Instance.new("ImageLabel")
      esp.Avatar.Name = "ESPAvatar"
      esp.Avatar.BackgroundTransparency = 1
      esp.Avatar.Size = UDim2.new(0, 30, 0, 30)
      esp.Avatar.ZIndex = 12
      esp.Avatar.Visible = false
      esp.Avatar.Parent = game:GetService("CoreGui")
      
      -- LOAD AVATAR
      pcall(function()
         esp.Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
      end)
   end
   
   ESPObjects[player] = esp
end

-- UPDATE ESP POSITION
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
   
   -- WORLD TO SCREEN SPACE
   local vector, onScreen = CurrentCamera:WorldToViewportPoint(rootPart.Position)
   
   if onScreen then
      local scale = 1 / (vector.Z * math.tan(math.rad(CurrentCamera.FieldOfView * 0.5)) * 2) * 100
      local size = Vector3.new(4 * scale, 6 * scale, 0)
      
      -- UPDATE BOX
      if esp.Box then
         esp.Box.Size = UDim2.new(0, size.X, 0, size.Y)
         esp.Box.Position = UDim2.new(0, vector.X - size.X / 2, 0, vector.Y - size.Y / 2)
         esp.Box.Visible = true
         
         -- TEAM COLOR
         if ESPConfig.TeamColor and player.Team then
            esp.Box.BackgroundColor3 = player.TeamColor.Color
         else
            esp.Box.BackgroundColor3 = ESPConfig.BoxColor
         end
      end
      
      -- UPDATE NAME
      if esp.NameLabel then
         esp.NameLabel.Position = UDim2.new(0, vector.X, 0, vector.Y - size.Y / 2 - 20)
         esp.NameLabel.Visible = true
      end
      
      -- UPDATE HEALTH
      if esp.HealthLabel then
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
      end
      
      -- UPDATE DISTANCE
      if esp.DistanceLabel then
         esp.DistanceLabel.Text = math.floor(distance).."m"
         esp.DistanceLabel.Position = UDim2.new(0, vector.X, 0, vector.Y + size.Y / 2 + 20)
         esp.DistanceLabel.Visible = true
      end
      
      -- UPDATE TRACER
      if esp.Tracer then
         esp.Tracer.Size = UDim2.new(0, 2, 0, math.sqrt((vector.X - CurrentCamera.ViewportSize.X/2)^2 + (vector.Y - CurrentCamera.ViewportSize.Y)^2))
         esp.Tracer.Position = UDim2.new(0, CurrentCamera.ViewportSize.X/2, 0, CurrentCamera.ViewportSize.Y)
         esp.Tracer.Rotation = math.deg(math.atan2(vector.Y - CurrentCamera.ViewportSize.Y, vector.X - CurrentCamera.ViewportSize.X/2))
         esp.Tracer.Visible = true
      end
      
      -- UPDATE AVATAR
      if esp.Avatar then
         esp.Avatar.Position = UDim2.new(0, vector.X - 35, 0, vector.Y - size.Y / 2 - 35)
         esp.Avatar.Visible = true
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

-- REMOVE ESP
local function RemoveESP(player)
   local esp = ESPObjects[player]
   if esp then
      if esp.Box then esp.Box:Destroy() end
      if esp.NameLabel then esp.NameLabel:Destroy() end
      if esp.HealthLabel then esp.HealthLabel:Destroy() end
      if esp.DistanceLabel then esp.DistanceLabel:Destroy() end
      if esp.Tracer then esp.Tracer:Destroy() end
      if esp.Avatar then esp.Avatar:Destroy() end
      if esp.Cham then esp.Cham:Destroy() end
      ESPObjects[player] = nil
   end
end

-- ESP TOGGLE
local function ToggleESP(value)
   ESPEnabled = value
   
   if ESPEnabled then
      -- CREATE ESP FOR EXISTING PLAYERS
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
      
      -- CONNECT PLAYER ADDED
      Players.PlayerAdded:Connect(function(player)
         CreateESP(player)
      end)
      
      -- CONNECT PLAYER REMOVING
      Players.PlayerRemoving:Connect(function(player)
         RemoveESP(player)
      end)
      
   else
      -- STOP LOOP AND REMOVE ALL ESP
      if ESPLoop then
         ESPLoop:Disconnect()
      end
      
      for player, esp in pairs(ESPObjects) do
         RemoveESP(player)
      end
   end
end

-- ESP SETTINGS TAB
local ESPToggle = ESPTab:CreateSection("ESP Controls")

ESPToggle:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Flag = "ESPEnabled",
   Callback = function(Value)
      ToggleESP(Value)
   end,
})

ESPToggle:CreateSlider({
   Name = "Max Distance",
   Range = {0, 2000},
   Increment = 50,
   Suffix = "studs",
   CurrentValue = 1000,
   Flag = "ESPMaxDistance",
   Callback = function(Value)
      ESPConfig.MaxDistance = Value
   end,
})

-- VISUAL SETTINGS
local VisualSection = ESPTab:CreateSection("Visual Settings")

VisualSection:CreateToggle({
   Name = "Show Box",
   CurrentValue = true,
   Flag = "ESPBox",
   Callback = function(Value)
      ESPConfig.Box = Value
      for player, esp in pairs(ESPObjects) do
         if esp.Box then
            esp.Box.Visible = Value and ESPEnabled
         end
      end
   end,
})

VisualSection:CreateToggle({
   Name = "Show Name",
   CurrentValue = true,
   Flag = "ESPName",
   Callback = function(Value)
      ESPConfig.Name = Value
      for player, esp in pairs(ESPObjects) do
         if esp.NameLabel then
            esp.NameLabel.Visible = Value and ESPEnabled
         end
      end
   end,
})

VisualSection:CreateToggle({
   Name = "Show Health",
   CurrentValue = true,
   Flag = "ESPHealth",
   Callback = function(Value)
      ESPConfig.Health = Value
      for player, esp in pairs(ESPObjects) do
         if esp.HealthLabel then
            esp.HealthLabel.Visible = Value and ESPEnabled
         end
      end
   end,
})

VisualSection:CreateToggle({
   Name = "Show Distance",
   CurrentValue = true,
   Flag = "ESPDistance",
   Callback = function(Value)
      ESPConfig.Distance = Value
      for player, esp in pairs(ESPObjects) do
         if esp.DistanceLabel then
            esp.DistanceLabel.Visible = Value and ESPEnabled
         end
      end
   end,
})

VisualSection:CreateToggle({
   Name = "Show Tracers",
   CurrentValue = true,
   Flag = "ESPTracers",
   Callback = function(Value)
      ESPConfig.Tracers = Value
      for player, esp in pairs(ESPObjects) do
         if esp.Tracer then
            esp.Tracer.Visible = Value and ESPEnabled
         end
      end
   end,
})

VisualSection:CreateToggle({
   Name = "Show Avatar",
   CurrentValue = true,
   Flag = "ESPAvatar",
   Callback = function(Value)
      ESPConfig.Avatar = Value
      for player, esp in pairs(ESPObjects) do
         if esp.Avatar then
            esp.Avatar.Visible = Value and ESPEnabled
         end
      end
   end,
})

VisualSection:CreateToggle({
   Name = "Team Color",
   CurrentValue = true,
   Flag = "ESPTeamColor",
   Callback = function(Value)
      ESPConfig.TeamColor = Value
   end,
})

-- COLOR SETTINGS
local ColorSection = VisualTab:CreateSection("Color Settings")

ColorSection:CreateColorpicker({
   Name = "Box Color",
   Color = Color3.fromRGB(0, 255, 0),
   Flag = "ESPBoxColor",
   Callback = function(Value)
      ESPConfig.BoxColor = Value
      for player, esp in pairs(ESPObjects) do
         if esp.Box and not (ESPConfig.TeamColor and player.Team) then
            esp.Box.BackgroundColor3 = Value
         end
      end
   end
})

ColorSection:CreateColorpicker({
   Name = "Text Color",
   Color = Color3.fromRGB(255, 255, 255),
   Flag = "ESPTextColor",
   Callback = function(Value)
      ESPConfig.TextColor = Value
      for player, esp in pairs(ESPObjects) do
         if esp.NameLabel then esp.NameLabel.TextColor3 = Value end
         if esp.DistanceLabel then esp.DistanceLabel.TextColor3 = Value end
      end
   end
})

ColorSection:CreateColorpicker({
   Name = "Tracer Color",
   Color = Color3.fromRGB(255, 255, 255),
   Flag = "ESPTracerColor",
   Callback = function(Value)
      ESPConfig.TracerColor = Value
      for player, esp in pairs(ESPObjects) do
         if esp.Tracer then esp.Tracer.BackgroundColor3 = Value end
      end
   end
})

-- INFO SECTION
local InfoSection = VisualTab:CreateSection("Information")

InfoSection:CreateButton({
   Name = "Refresh All ESP",
   Callback = function()
      for player, esp in pairs(ESPObjects) do
         RemoveESP(player)
      end
      if ESPEnabled then
         for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
               CreateESP(player)
            end
         end
      end
   end,
})

InfoSection:CreateButton({
   Name = "Clear All ESP",
   Callback = function()
      for player, esp in pairs(ESPObjects) do
         RemoveESP(player)
      end
   end,
})

Rayfield:Notify({
   Title = "C00lKid Universal ESP",
   Content = "ESP system loaded successfully!",
   Duration = 6,
   Image = 4483362458,
})

Rayfield:LoadConfiguration()
print("✅ C00lKid Universal ESP V1 loaded!")
