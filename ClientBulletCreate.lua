local RunService = game:GetService("RunService")
local serverStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local newBulletTemplate = ReplicatedStorage.Assets.bulletAssets:WaitForChild(script:GetAttribute("bulletType"))
local propertyOf = script:GetAttribute("propertyOf")

local  debounce = false

local function shootFakeBullet() 
	if not debounce then 
		debounce = true 
		
		local newBullet = newBulletTemplate:Clone()
		
		
		newBullet.Orientation = Vector3.new(0,0,script:GetAttribute("rotation"))
		local directionVector = Vector3.new(0,math.sin(math.rad(newBullet.Orientation.Z)),math.cos(math.rad(newBullet.Orientation.Z)))
		
		for i,v in pairs(game.Workspace.enemies:GetChildren()) do
			if  v:IsA("Part") and v.Name == propertyOf then 
				newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)
			end
		end
		newBullet.CFrame = CFrame.lookAt(newBullet.Position, newBullet.Position + directionVector)
		newBullet.Velocity = directionVector * script:GetAttribute("bulletSpeed")
		
		newBullet.Parent = game.Workspace.fakeBullets
		
		for i,v in pairs(game.Players:GetChildren()) do
			if  v.Name and v.Name == script:GetAttribute("clientOwner") then 
				newBullet:SetNetworkOwner(v)

			end
		end
		
		newBullet.CollisionGroup = "ignore"
				
		task.wait(script:GetAttribute("sps"))
		debounce = false
	end
end
RunService.Heartbeat:Connect(shootFakeBullet)
