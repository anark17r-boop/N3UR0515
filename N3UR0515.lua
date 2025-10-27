-- [C00lKid Exploit V10 - FIXED LOAD]
print("🔄 Загрузка эксплойта...")

-- ПРОВЕРКА ЗАГРУЗКИ
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
end)

if not success then
    print("❌ Ошибка загрузки Orion UI")
    -- Пробуем альтернативный источник
    OrionLib = loadstring(game:HttpGet('https://pastebin.com/raw/jDd8p0bY'))()
end

print("✅ Orion UI загружен")

local Window = OrionLib:MakeWindow({
    Name = "C00lKid Exploit V10",
    HidePremium = false,
    SaveConfig = false,
    IntroEnabled = true,
    IntroText = "EXPLOIT LOADED"
})

print("✅ Окно создано")

-- БАЙПАС
hookfunction(game.Players.LocalPlayer.Kick, function()
    return wait(9e9)
end)

-- ПРОСТЫЕ РАБОЧИЕ ФУНКЦИИ
local MainTab = Window:MakeTab({Name = "Главные"})

MainTab:AddSlider({
    Name = "Скорость",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

MainTab:AddSlider({
    Name = "Прыжок", 
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

MainTab:AddButton({
    Name = "Тест кнопки",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Тест",
            Content = "Скрипт работает!",
            Time = 5
        })
    end
})

OrionLib:Init()
print("🎯 Эксплойт готов к использованию!")
