local Venus = loadstring(game:HttpGet('https://raw.githubusercontent.com/hacker6060/venus-ui-library/main/source.lua'))()

local Window = Venus:New({
    Name = "C00lKid Exploit V12",
    Position = UDim2.new(0.5, 0, 0.5, 0)
})

local Main = Window:Tab("Главные")
Main:Slider("Скорость", 16, 500, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
