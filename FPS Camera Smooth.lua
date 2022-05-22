--// CharacterHandler V1.5

--// Services

local Character = game:GetService("Players").LocalPlayer.Character
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

--// Core 

local CharacterHandler = {}

function CharacterHandler:Init()
	
	local DegreeX = 0
	local DegreeY = Instance.new("DoubleConstrainedValue")
	
	DegreeY.Parent = Player.Character

	
	DegreeY.MinValue = -85
	DegreeY.MaxValue = 85
	
	
	local CharacterParts = Character:GetChildren()
	local CurrentCamera = workspace.CurrentCamera
	
	local MouseSensitivity = 0.1 --// Max 0.1, Min 0.05

	--// Make Character Invisible

	for _, Item in pairs (CharacterParts) do
		if Item:IsA("BasePart") then
			Item.Transparency = 1
		elseif Item:IsA("Accessory") then
			Item.Handle.Transparency = 1 
		end
	end

	--// Commands

	RunService.RenderStepped:Connect(function()

		local Delta = UIS:GetMouseDelta()

		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

		DegreeY.Value -= Delta.Y * MouseSensitivity
		DegreeX -= Delta.X * MouseSensitivity

		CharacterHandler:UpdateCamera(DegreeY)

	end)

	function CharacterHandler:UpdateCamera(DegreeY)

		
	warn(DegreeY.Value)
		CurrentCamera.CFrame = CurrentCamera.CFrame:lerp(
			CFrame.new(Character.Head.CFrame.Position)
				* CFrame.fromOrientation(math.rad(DegreeY.Value),
					math.rad(DegreeX),0),.2)
	end
end

return CharacterHandler

--// By MrHardswell
--// 5/22/2022


