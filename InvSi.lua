-- C00lKid Premium ESP V3 - Luxury Edition
local Players = game:GetService("Players")
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Inbutton = Instance.new("InvButton")
Inbutton.Name = "InvButton"
InvButton.Parent = game:GetService("CoreGui")
InvButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
