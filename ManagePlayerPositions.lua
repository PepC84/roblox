local ReplicatedStorage = game:GetService('ReplicatedStorage')
local remoteEvent = ReplicatedStorage:WaitForChild('SendPos2Server')
local playerHitbox = workspace.player.playerHitbox

local function validatePosition(Player, position)
	playerHitbox.Position = _G.PlayerPosition
end

remoteEvent.OnServerEvent:Connect(validatePosition)
