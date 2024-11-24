local remoteFunction = game.ReplicatedStorage:WaitForChild("deltaFunction")

if game:IsLoaded() == false then game.Loaded:Wait() end

game:GetService("RunService").Heartbeat:Connect(function(deltatime)
	--workspace.ClientPart.SurfaceGui.TextLabel.Text = string.format("%.1f",os.clock() + game.ReplicatedStorage.DeltaTime.Value)
	
	workspace.ClientPart.SurfaceGui.TextLabel.Text = os.clock() + game.ReplicatedStorage.DeltaTime.Value
	workspace.ServerMinusClient.SurfaceGui.TextLabel.Text = os.clock() + game.ReplicatedStorage.DeltaTime.Value - remoteFunction:InvokeServer()
	workspace.ClientSidedServer.SurfaceGui.TextLabel.Text = remoteFunction:InvokeServer() + game.Players.LocalPlayer:GetNetworkPing()/2
	workspace.Ping.SurfaceGui.TextLabel.Text = game.Players.LocalPlayer:GetNetworkPing()
	
	--workspace.ClientPart.SurfaceGui.TextLabel.Text = workspace:GetServerTimeNow()
end)
