local RunService = game:GetService("RunService");
local range = 200
local closest

local objectVal = script:WaitForChild("whatever")
local owner = objectVal.Value
local check = 0
local times = 0
local sign = 1
local createNew = false
local distanceVector = script.savedVector.Value
local vf = nil
local wantedForce = nil
local previousTime = 0
local greenlight = false
--local tweenValue = Vector3.new(0,0,0)
RunService.Heartbeat:Connect(function() 
	
	if tick() - previousTime > .1 then
		for _, part in ipairs(game.Workspace.enemies:GetDescendants()) do
			if part:IsA("Folder") then
				do continue end
			end
			local distance = (owner.Position - part.Position).Magnitude

			if distance < range then
				--print(distance .. " " .. range)
				range = distance
				closest = part
				
			end
			
		end
		
		previousTime = tick()
		
	end
	if closest then 

		local desiredCFrame = CFrame.lookAt(owner.Position,closest.Position)
		local lookVector = desiredCFrame.LookVector
		
		--[[
		local raycastDirection = closest.Position - owner.Position
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Include
		raycastParams:AddToFilter(workspace.player.playerHitbox.body)
		raycastParams:AddToFilter(closest)
		local raycastResult = workspace:Raycast(owner.Position, raycastDirection, raycastParams)
		--print(raycastResult)
		if raycastResult and raycastResult.Instance then 
			if raycastResult.Instance == closest then
				greenlight = true
			else if raycastResult.Instance == workspace.player.playerHitbox.body then
					greenlight = false
				end
			end
		end
		]]--
		
		--[[
		if createNew == false then
			
			
			local att = Instance.new("Attachment", owner)
			local vf = Instance.new("VectorForce", owner)
			vf.ApplyAtCenterOfMass = true
			vf.Attachment0 = att
			--local wantedForce = lookVector.Unit * 300
			vf.Force = lookVector * 300
			vf.RelativeTo = Enum.ActuatorRelativeTo.World
			
			
			createNew = true
			
		end
		]]--
		--if createNew == true and greenlight == true then
		--if createNew == true then
			
			
			local wantedForce = lookVector * 2
			
			local vectorAdded = (wantedForce + distanceVector)
			local vectorAddedClamped = Vector3.new(0,vectorAdded.Y,vectorAdded.Z)
			local vectorAddedFixed = vectorAddedClamped / vectorAddedClamped.Magnitude
			owner.CFrame = CFrame.lookAt(owner.Position , owner.Position + vectorAddedFixed)
			owner.Velocity = vectorAddedFixed * 75
			
			--vf.Force = lookVector.Unit * 100
			
			--owner.Velocity = math.clamp(vf.Force + owner.Velocity, )
			--local velocityClamped = Vector3.new(0,math.clamp((distanceVector.Y * 75 ),math.clamp((distanceVector.Z * 75)))
			
			--local lastVectorCFrame = CFrame.lookAt(owner.Position,owner.Position + savedVectorValue)
			--owner.CFrame = lastVectorCFrame
			--owner.Velocity = owner.CFrame.LookVector * 100
			
		--end
		--[[
		if createNew == true and greenlight == false then

			local wantedForce = lookVector * 2

			local vectorAdded = (wantedForce + distanceVector)
			local vectorAddedClamped = Vector3.new(0,vectorAdded.Y,vectorAdded.Z)
			local vectorAddedFixed = vectorAddedClamped / vectorAddedClamped.Magnitude
			owner.CFrame = CFrame.lookAt(owner.Position , owner.Position + vectorAddedFixed)
			owner.Velocity = vectorAddedFixed * 75
			
			
		end
		]]--
		
	end
	--print(owner.Velocity)
	
end)
