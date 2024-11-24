local remoteFunction = game.ReplicatedStorage:WaitForChild("deltaFunction")
local deltaTime = game.ReplicatedStorage:WaitForChild("DeltaTime")

deltaTime.Value = remoteFunction:InvokeServer() - os.clock() + game.Players.LocalPlayer:GetNetworkPing()/2
