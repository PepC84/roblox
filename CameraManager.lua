local cameraPosition = Vector3.new(40, 200, 0)
local cameraPointsAt = Vector3.new(80, 200, 0)
local camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer 
local char = player.Character
local function updateCamera()
	camera.CFrame = CFrame.lookAt(cameraPosition,cameraPointsAt)
	camera.FieldOfView = 20
end

RunService:BindToRenderStep("SidescrollingCamera", Enum.RenderPriority.Camera.Value + 1, updateCamera)
