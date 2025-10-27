-- Flux UI Version
local Flux = loadstring(game:HttpGet('https://raw.githubusercontent.com/ImagineProUser/Flux-UI-Library/main/Library.lua'))()

local Window = Flux:Window("C00lKid Exploit", "V11", "by Colin")

Flux:Button("Тест скорости", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

Flux:Slider("Скорость", 16, 500, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

Flux:Slider("Прыжок", 50, 500, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)
