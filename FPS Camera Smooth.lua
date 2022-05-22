--// CharacterHandler V1.3

--// Services

local Character = game:GetService("Players").LocalPlayer.Character
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

--// Core 

local CharacterHandler = {}

function CharacterHandler:Init()

	local CharacterParts = Character:GetChildren()
	local CurrentCamera = workspace.CurrentCamera
	local DegreeX, DegreeY = 0, 0
	
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
		
		DegreeY -= Delta.Y * MouseSensitivity
		DegreeX -= Delta.X * MouseSensitivity

		CharacterHandler:UpdateCamera()
		
	end)

	function CharacterHandler:UpdateCamera()
		
		CurrentCamera.CFrame = CurrentCamera.CFrame:lerp(
			CFrame.new(Character.Head.CFrame.Position)
				* CFrame.fromOrientation(math.rad(DegreeY),
					math.rad(DegreeX),0),.2)
	end	
end

return CharacterHandler

--// By MrHardswell
--// 5/22/2022
