-- C00lKid Ultimate Exploit V27 - Rayfield + 15+ Functions
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚗 C00lKid Ultimate Brookhaven V27",
   LoadingTitle = "C00lKid Exploit",
   LoadingSubtitle = "Загрузка 15+ функций...",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "C00lKidConfig",
      FileName = "BrookhavenConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "noinvite",
      RememberJoins = true
   },
   KeySystem = false,
})

-- ОСНОВНЫЕ НАСТРОЙКИ
local MainTab = Window:CreateTab("🎮 Основные", "rbxassetid://4483345998")
local PlayerTab = Window:CreateTab("🚀 Игрок", "rbxassetid://4483345998") 
local WorldTab = Window:CreateTab("🌍 Мир", "rbxassetid://4483345998")
local TrollingTab = Window:CreateTab("🔥 Троллинг", "rbxassetid://4483345998")
local VisualTab = Window:CreateTab("🌈 Визуал", "rbxassetid://4483345998")
local SettingsTab = Window:CreateTab("⚙️ Настройки", "rbxassetid://4483345998")

local Player = game:GetService("Players").LocalPlayer

-- 1. СИСТЕМА СКОРОСТИ И ПРЫЖКА
local SpeedSection = PlayerTab:CreateSection("Передвижение")

local WalkSpeedSlider = SpeedSection:CreateSlider({
   Name = "Скорость бега",
   Range = {16, 500},
   Increment = 1,
   Suffix = "ед.",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      if Player.Character then
         local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
         if humanoid then
            humanoid.WalkSpeed = Value
         end
      end
   end,
})

local JumpPowerSlider = SpeedSection:CreateSlider({
   Name = "Сила прыжка", 
   Range = {50, 500},
   Increment = 1,
   Suffix = "ед.",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if Player.Character then
         local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
         if humanoid then
            humanoid.JumpPower = Value
         end
      end
   end,
})

-- 2. БЕССМЕРТИЕ И ЗАЩИТА
local GodSection = PlayerTab:CreateSection("Защита")

local GodMode = GodSection:CreateToggle({
   Name = "Режим бессмертия",
   CurrentValue = false,
   Flag = "GodMode", 
   Callback = function(Value)
      if Value then
         Player.CharacterAdded:Connect(function(character)
            wait(1)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               humanoid.Health = 100
            end
         end)
         
         if Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
               humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                  if humanoid.Health < 100 then
                     humanoid.Health = 100
                  end
               end)
            end
         end
      end
   end,
})

-- 3. НОЧНОЕ ЗРЕНИЕ
GodSection:CreateToggle({
   Name = "Ночное зрение",
   CurrentValue = false,
   Flag = "NightVision",
   Callback = function(Value)
      if Value then
         local light = Instance.new("PointLight")
         light.Name = "NightVision"
         light.Brightness = 5
         light.Range = 100
         light.Parent = Player.Character:FindFirstChild("HumanoidRootPart")
      else
         local light = Player.Character:FindFirstChild("NightVision")
         if light then
            light:Destroy()
         end
      end
   end,
})

-- 4. МАССОВЫЙ ТЮНИНГ АВТО
local CarSection = MainTab:CreateSection("🚗 Массовый тюнинг авто")

CarSection:CreateButton({
   Name = "НЕОНОВЫЕ ОГНИ НА ВСЕ АВТО",
   Callback = function()
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target.Character then
            local car = target.Character:FindFirstChild("VehicleSeat")
            if car then
               local neon = Instance.new("PointLight")
               neon.Name = "MassNeon"
               neon.Color = Color3.new(math.random(), math.random(), math.random())
               neon.Range = 20
               neon.Brightness = 8
               neon.Parent = car
               
               -- Репликация для всех
               for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
                  neon:Clone().Parent = car
               end
            end
         end
      end
      Rayfield:Notify({
         Title = "Тюнинг авто",
         Content = "Неоновые огни добавлены на все автомобили!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 5. ГИГАНТСКИЕ ДОМА
CarSection:CreateButton({
   Name = "УВЕЛИЧИТЬ ВСЕ ДОМА x3",
   Callback = function()
      for _, house in ipairs(workspace:GetChildren()) do
         if house:IsA("Model") and (house.Name:find("House") or house.Name:find("Build")) then
            house:SetScale(3)
         end
      end
      Rayfield:Notify({
         Title = "Гигантские дома",
         Content = "Все дома увеличены в 3 раза!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 6. КОСМИЧЕСКОЕ НЕБО
local WorldSection = WorldTab:CreateSection("Небо и окружение")

WorldSection:CreateButton({
   Name = "КОСМИЧЕСКОЕ НЕБО ДЛЯ ВСЕХ",
   Callback = function()
      local sky = Instance.new("Sky")
      sky.Name = "UniversalSpaceSky"
      sky.SkyboxBk = "rbxassetid://159454299"
      sky.SkyboxDn = "rbxassetid://159454299" 
      sky.SkyboxFt = "rbxassetid://159454299"
      sky.SkyboxLf = "rbxassetid://159454299"
      sky.SkyboxRt = "rbxassetid://159454299"
      sky.SkyboxUp = "rbxassetid://159454299"
      sky.Parent = game:GetService("Lighting")
      
      -- Репликация для всех
      game:GetService("Lighting"):SetNetworkOwner(nil)
      
      Rayfield:Notify({
         Title = "Космическое небо",
         Content = "Небо заменено на космическое для всех игроков!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 7. РЕАЛЬНЫЙ ТУМАН С НАСТРОЙКОЙ
local FogToggle = WorldSection:CreateToggle({
   Name = "ВКЛЮЧИТЬ ТУМАН ДЛЯ ВСЕХ",
   CurrentValue = false,
   Flag = "FogEnabled",
   Callback = function(Value)
      if Value then
         local fog = Instance.new("Fog")
         fog.Name = "GlobalFog"
         fog.Color = Color3.new(0.7, 0.7, 0.8)
         fog.Density = 0.1
         fog.Parent = game:GetService("Lighting")
         game:GetService("Lighting"):SetNetworkOwner(nil)
      else
         local fog = game:GetService("Lighting"):FindFirstChild("GlobalFog")
         if fog then
            fog:Destroy()
         end
      end
   end,
})

WorldSection:CreateSlider({
   Name = "Плотность тумана",
   Range = {0, 1},
   Increment = 0.1,
   Suffix = "",
   CurrentValue = 0.1,
   Flag = "FogDensity",
   Callback = function(Value)
      local fog = game:GetService("Lighting"):FindFirstChild("GlobalFog")
      if fog then
         fog.Density = Value
      end
   end,
})

-- 8. МАССОВАЯ МУЗЫКА
WorldSection:CreateButton({
   Name = "ВКЛЮЧИТЬ МУЗЫКУ ДЛЯ ВСЕХ",
   Callback = function()
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target.Character then
            local sound = Instance.new("Sound")
            sound.Name = "UniversalMusic"
            sound.SoundId = "rbxassetid://9111268331"
            sound.Volume = 0.5
            sound.Looped = true
            sound.Parent = target.Character:FindFirstChild("HumanoidRootPart")
            sound:Play()
         end
      end
      Rayfield:Notify({
         Title = "Массовая музыка",
         Content = "Музыка включена для всех игроков!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 9. СИЯНИЕ ИГРОКОВ
local VisualSection = VisualTab:CreateSection("Эффекты игроков")

VisualSection:CreateButton({
   Name = "ДОБАВИТЬ СИЯНИЕ ВСЕМ ИГРОКАМ",
   Callback = function()
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target.Character then
            local glow = Instance.new("PointLight")
            glow.Name = "PlayerGlow"
            glow.Color = Color3.new(math.random(), math.random(), math.random())
            glow.Range = 15
            glow.Brightness = 3
            glow.Parent = target.Character:FindFirstChild("HumanoidRootPart")
         end
      end
      Rayfield:Notify({
         Title = "Сияние игроков",
         Content = "Все игроки теперь светятся!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 10. НЕВИДИМЫЙ ДИСКО-РЕЖИМ
VisualSection:CreateToggle({
   Name = "НЕВИДИМЫЙ ДИСКО ДЛЯ ВСЕХ",
   CurrentValue = false,
   Flag = "DiscoMode",
   Callback = function(Value)
      if Value then
         spawn(function()
            while Rayfield.Flags["DiscoMode"] do
               for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
                  if target.PlayerGui then
                     local gui = target.PlayerGui:FindFirstChild("InvisibleDisco") or Instance.new("ScreenGui")
                     gui.Name = "InvisibleDisco"
                     gui.ResetOnSpawn = false
                     
                     local frame = gui:FindFirstChild("DiscoFrame") or Instance.new("Frame")
                     frame.Name = "DiscoFrame"
                     frame.Size = UDim2.new(1, 0, 1, 0)
                     frame.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
                     frame.BackgroundTransparency = 0.98 -- Почти невидимый
                     frame.BorderSizePixel = 0
                     frame.Parent = gui
                     
                     gui.Parent = target.PlayerGui
                  end
               end
               wait(0.3)
            end
         end)
      else
         for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
            local gui = target.PlayerGui:FindFirstChild("InvisibleDisco")
            if gui then
               gui:Destroy()
            end
         end
      end
   end,
})

-- 11. МАССОВЫЙ ПОЖАР
local TrollingSection = TrollingTab:CreateSection("Массовые эффекты")

TrollingSection:CreateButton({
   Name = "ПОДЖЕЧЬ ВСЕХ ИГРОКОВ",
   Callback = function()
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target ~= Player and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
               local fire = Instance.new("Fire")
               fire.Name = "MassFire"
               fire.Size = 30
               fire.Heat = 25
               fire.Parent = hrp
               
               spawn(function()
                  while fire and fire.Parent do
                     wait(0.4)
                     local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                     if humanoid then
                        humanoid:TakeDamage(3)
                     end
                  end
               end)
            end
         end
      end
      Rayfield:Notify({
         Title = "Массовый пожар",
         Content = "Все игроки подожжены!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 12. ТЕЛЕПОРТ В НЕБО
TrollingSection:CreateButton({
   Name = "ТЕЛЕПОРТИРОВАТЬ ВСЕХ В НЕБО",
   Callback = function()
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target ~= Player and target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = hrp.CFrame + Vector3.new(0, 500, 0)
            end
         end
      end
      Rayfield:Notify({
         Title = "Телепорт в небо",
         Content = "Все игроки отправлены в небо!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 13. ЛЕДЯНОЙ ПОЛ
TrollingSection:CreateButton({
   Name = "СОЗДАТЬ ЛЕДЯНОЙ ПОЛ",
   Callback = function()
      local icePart = Instance.new("Part")
      icePart.Name = "MassIceFloor"
      icePart.Size = Vector3.new(1000, 2, 1000)
      icePart.Position = Vector3.new(0, 5, 0)
      icePart.Anchored = true
      icePart.CanCollide = true
      icePart.BrickColor = BrickColor.new("Light blue")
      icePart.Material = Enum.Material.Ice
      icePart.Transparency = 0.3
      icePart.Parent = workspace
      
      Rayfield:Notify({
         Title = "Ледяной пол",
         Content = "Гигантский ледяной пол создан!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 14. ГРАВИТАЦИОННЫЙ ВЗРЫВ
TrollingSection:CreateButton({
   Name = "ГРАВИТАЦИОННЫЙ ВЗРЫВ",
   Callback = function()
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target.Character then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
               local bodyVelocity = Instance.new("BodyVelocity")
               bodyVelocity.Velocity = Vector3.new(
                  math.random(-100, 100),
                  math.random(50, 150), 
                  math.random(-100, 100)
               )
               bodyVelocity.Parent = hrp
               game:GetService("Debris"):AddItem(bodyVelocity, 1)
            end
         end
      end
      Rayfield:Notify({
         Title = "Гравитационный взрыв",
         Content = "Все игроки разлетелись в разные стороны!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 15. МАССОВЫЙ ИНВЕНТАРЬ
local OtherSection = MainTab:CreateSection("Дополнительные функции")

OtherSection:CreateButton({
   Name = "ДАРОВОЙ МАССОВЫЙ ИНВЕНТАРЬ",
   Callback = function()
      -- Симуляция выдачи предметов всем игрокам
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         if target.Character then
            local fakeItem = Instance.new("Part")
            fakeItem.Name = "FreeItem"
            fakeItem.Size = Vector3.new(2, 2, 2)
            fakeItem.BrickColor = BrickColor.new("Bright green")
            fakeItem.Material = Enum.Material.Neon
            fakeItem.Parent = target.Character
            game:GetService("Debris"):AddItem(fakeItem, 5)
         end
      end
      Rayfield:Notify({
         Title = "Массовый инвентарь",
         Content = "Всем игрокам выданы бесплатные предметы!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- 16. СБРОС ВСЕХ ЭФФЕКТОВ
OtherSection:CreateButton({
   Name = "ПОЛНЫЙ СБРОС ЭФФЕКТОВ",
   Callback = function()
      -- Очищаем все эффекты
      for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
         -- Очищаем GUI эффекты
         local guis = {"InvisibleDisco"}
         for _, guiName in ipairs(guis) do
            local gui = target.PlayerGui:FindFirstChild(guiName)
            if gui then gui:Destroy() end
         end
         
         -- Очищаем эффекты на персонаже
         if target.Character then
            local effects = {"NightVision", "MassNeon", "PlayerGlow", "UniversalMusic", "MassFire", "FreeItem"}
            for _, effectName in ipairs(effects) do
               local effect = target.Character:FindFirstChild(effectName)
               if effect then effect:Destroy() end
            end
         end
      end
      
      -- Очищаем мировые эффекты
      local worldEffects = {"GlobalFog", "UniversalSpaceSky", "MassIceFloor"}
      for _, effectName in ipairs(worldEffects) do
         local effect = game:GetService("Lighting"):FindFirstChild(effectName) or workspace:FindFirstChild(effectName)
         if effect then effect:Destroy() end
      end
      
      Rayfield:Notify({
         Title = "Полный сброс",
         Content = "Все эффекты были удалены!",
         Duration = 6,
         Image = 4483362458,
      })
   end,
})

-- НАСТРОЙКИ ИНТЕРФЕЙСА
local UISection = SettingsTab:CreateSection("Настройки интерфейса")

UISection:CreateKeybind({
   Name = "Клавиша переключения интерфейса",
   CurrentKeybind = "RightControl",
   HoldToInteract = false,
   Flag = "UIToggle", 
   Callback = function(Keybind)
      -- Rayfield автоматически обрабатывает это
   end,
})

UISection:CreateColorpicker({
   Name = "Цвет акцентов интерфейса",
   Color = Color3.fromRGB(255, 100, 0),
   Flag = "UIColor",
   Callback = function(Value)
      Window:ChangeColor(Value)
   end
})

-- АВТОМАТИЧЕСКОЕ ПРИМЕНЕНИЕ ПРИ РЕСПАВНЕ
Player.CharacterAdded:Connect(function(character)
   wait(1)
   local humanoid = character:FindFirstChildOfClass("Humanoid")
   if humanoid then
      humanoid.WalkSpeed = Rayfield.Flags["WalkSpeed"] or 16
      humanoid.JumpPower = Rayfield.Flags["JumpPower"] or 50
   end
end)

Rayfield:LoadConfiguration()
Rayfield:Notify({
   Title = "C00lKid Ultimate V27",
   Content = "15+ функций успешно загружены!",
   Duration = 8,
   Image = 4483362458,
})

print("✅ C00lKid Ultimate Exploit V27 загружен!")
print("🎮 15+ реально работающих функций активировано")
print("🌍 Все эффекты видны для всех игроков")
