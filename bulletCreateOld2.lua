local RunService = game:GetService('RunService')
local serverStorage = game:GetService('ServerStorage')
local  debounce = false

local function shootBullet() 
	if not debounce then 
		debounce = true 
		
		local newBullet = serverStorage.mostBasicBullet:Clone()
		newBullet.Parent = game.Workspace.bullets
		local speed = script:GetAttribute("bulletSpeed")
		--local position
		local rotation = script:GetAttribute("rotation")
		local propertyOf = script:GetAttribute("propertyOf")
		
		newBullet.CanCollide = true
		


		for i,v in pairs(game.Workspace.enemies:GetChildren()) do
			if  v:IsA("Part") and v.Name == propertyOf then 
				newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

			end
			--print(v.Name)	
			--print(script.Parent:GetAttribute("propertyOf"))
		end
		
		--newBullet.CFrame = CFrame.new(position) * CFrame.Angles(0,0,math.rad(rotation)) 
		--newBullet.Position = position
		newBullet.Orientation = Vector3.new(0,0,rotation)
		
		--local vector1Away = Vector3.new(224,(newBullet.Position.Y + math.sin(math.rad(newBullet.Orientation.Z))), newBullet.Position.Z + (math.cos(math.rad(newBullet.Orientation.Z))))
		local directionVector = Vector3.new(0,math.sin(math.rad(newBullet.Orientation.Z)),math.cos(math.rad(newBullet.Orientation.Z)))
		newBullet.VectorForce.Force = directionVector * speed
		--newBullet.Orientation
		wait(script:GetAttribute("sps"))
		debounce = false
	end
end
RunService.Stepped:Connect(shootBullet)

--[[


remoteEvent.OnServerEvent:Connect(function(player, gunPos, enemyPos, directionPos)
	
	local bullet = Instance.new('Part')
	bullet.Name = 'Bullet'
	bullet.Parent = game.Workspace
	bullet.Shape = Enum.PartType.Ball
	bullet.Size = Vector3.new(1,1,1)
	bullet.BrickColor = BrickColor.new('Really black')
	
	local speed = 50
	bullet.CFrame = CFrame.new(gunPos , enemyPos)
	bullet.Velocity = bullet.CFrame.lookVector * speed
	print("bruh")
	game:GetService('Debris'):AddItem(bullet, 3)
end)

local function managePartMovement(step)
	local directions = getDirectionsToProcess();
	local targetPosition = movingPart.Position;

	for _, direction in ipairs(directions) do
		
		local offset = (targetVelocity * _G.shiftMultiplier * diagonalFix * step) * direction;
		targetPosition = targetPosition + offset;
	end
	movingPart.Position = Vector3.new(targetPosition.X,math.clamp(targetPosition.Y,borderDownCap+hitboxSize,borderUpCap-hitboxSize),math.clamp(targetPosition.Z,borderLeftCap+hitboxSize,borderRightCap-hitboxSize))
	if targetPosition.Magnitude ~= movingPart.Position.Magnitude then 
		imAtTheEdge = true else
		imAtTheEdge = false
	end
end
]]--
