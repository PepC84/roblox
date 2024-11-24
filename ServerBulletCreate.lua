local RunService = game:GetService("RunService")
local serverStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local newBulletTemplate = ReplicatedStorage.Assets.bulletAssets:WaitForChild(script:GetAttribute("bulletType"))


local  debounce = false

local function shootBullet() 
	if not debounce then 
		debounce = true 
		
		local newBullet = newBulletTemplate:Clone()
		
		newBullet.Orientation = Vector3.new(0,0,script:GetAttribute("rotation"))
		local directionVector = Vector3.new(0,math.sin(math.rad(newBullet.Orientation.Z)),math.cos(math.rad(newBullet.Orientation.Z)))
		
		for i,v in pairs(game.Workspace.enemies:GetChildren()) do
			if  v:IsA("Part") and v.Name == script:GetAttribute("propertyOf") then 
				newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)
			end
		end
		newBullet.CFrame = CFrame.lookAt(newBullet.Position, newBullet.Position + directionVector)
		newBullet.Velocity = directionVector * script:GetAttribute("bulletSpeed")
		
		newBullet.Parent = game.Workspace.bullets
		newBullet:SetNetworkOwner(nil)
		newBullet.CollisionGroup = "bullets"
		

		--newBullet.CFrame = CFrame.lookAt(newBullet.Position, newBullet.Position + directionVector)
		--[[
		local waitScript = ReplicatedStorage.bulletWait:Clone()
		waitScript:SetAttribute("propertyOf",script:GetAttribute("propertyOf"))
		waitScript.Parent = newBullet
		waitScript.Enabled = true
		]]--
		
		--[[
		for j,v in pairs(game.Players:GetChildren()) do
			
			local fakeBullet = newBullet:Clone()
			fakeBullet.bulletShape.Transparency = 0
			fakeBullet.Parent = game.Workspace.fakeBullets
			fakeBullet.CollisionGroup = "ignore"
			fakeBullet:SetNetworkOwner(v)
			--fakeBullet.Position = newBullet.Position
			--fakeBullet.Velocity = newBullet.Velocity
		end
		]]--
		--[[
		newBullet.Touched:Connect(function(hit)
			print(hit.Parent.Name)
			if hit.Parent.Name == workspace.enemies.Name or hit.Parent.Name == workspace.bullets.Name then 
				hit = nil
			else 
				newBullet:Destroy()
				if hit.Parent.Name == workspace.player.Name then
					
				end
				
			end
		end)
		
		]]--
		--[[
		for i,v in pairs(game.Workspace.enemies:GetChildren()) do
			if  v:IsA("Part") and v.Name == propertyOf then 
				newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				break
			end
		end
		]]--
		
		task.wait(script:GetAttribute("sps"))
		
		debounce = false
	end
end
RunService.Heartbeat:Connect(shootBullet)
