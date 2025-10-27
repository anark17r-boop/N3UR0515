-- Sky & Texture Exploit by Colin
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local BlueFireBtn = Instance.new("TextButton")
    local BlueDesksBtn = Instance.new("TextButton")
    
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "ExploitSuite"
    
    Frame.Parent = ScreenGui
    Frame.Size = UDim2.new(0, 200, 0, 150)
    Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    BlueFireBtn.Parent = Frame
    BlueFireBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
    BlueFireBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
    BlueFireBtn.Text = "Синее огненное небо"
    BlueFireBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    
    BlueDesksBtn.Parent = Frame
    BlueDesksBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
    BlueDesksBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
    BlueDesksBtn.Text = "Горящие синие парты"
    BlueDesksBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
    
    BlueFireBtn.MouseButton1Click:Connect(function()
        -- Функция синего огненного неба
        Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=9851144466"
        Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=9851144466"
        Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=9851144466"
        Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=9851144466"
        Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=9851144466"
        Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=9851144466"
        
        local fire = Instance.new("Fire")
        fire.Color = Color3.new(0, 0.5, 1)
        fire.SecondaryColor = Color3.new(0, 0.2, 0.8)
        fire.Parent = workspace.Terrain
    end)
    
    BlueDesksBtn.MouseButton1Click:Connect(function()
        -- Функция горящих синих парт
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("desk") or obj.Name:lower():find("part") then
                obj.BrickColor = BrickColor.new("Bright blue")
                
                local fire = Instance.new("Fire")
                fire.Color = Color3.new(0, 0.3, 1)
                fire.SecondaryColor = Color3.new(0, 0.1, 0.6)
                fire.Parent = obj
            end
        end
    end)
end

CreateGUI()
