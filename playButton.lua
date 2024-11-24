local ReplicatedStorage = game:GetService('ReplicatedStorage')
local remoteEvent = ReplicatedStorage:WaitForChild('gameBegin')

local button = script.Parent
local playGui = game.Players.LocalPlayer.PlayerGui.playGui


local function onButtonActivated()
	remoteEvent:FireServer()
	playGui:Destroy()
end
button.Activated:Connect(onButtonActivated)
