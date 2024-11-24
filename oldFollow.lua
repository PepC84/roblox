local RunService = game:GetService("RunService");
local range = 200
local closest
local previousTime = 0
local objectVal = script:WaitForChild("whatever")
local owner = objectVal.Value
local check = 0
local times = 0
local sign = 1

--local tweenValue = Vector3.new(0,0,0)
RunService.Heartbeat:Connect(function() 
	
	if tick() - previousTime > .1 then
		for _, part in ipairs(game.Workspace.enemies:GetChildren()) do
			local distance = (owner.Position - part.Position).Magnitude
			
			if not closest or closest ~= part then
				
			end

			if distance < range then
				--print(distance .. " " .. range)
				range = distance
				closest = part
				
			end
			
		end
		
		previousTime = tick()


		--local j,k,l = lastVectorCFrame:ToOrientation()
		--local x,y,z = desiredCFrame:ToOrientation()
		
		--print(j,k,l)
		--print(x,y,z)
		
		--print(lastVectorCFrame:ToOrientation())
		
		--print(math.deg(x))
		--print(math.deg(j))
		--local testVector = Vector3.new(0,math.sin(),math.cos())
		
		--local testDistance = math.acos(math.clamp(lookVector.Unit:Dot(testVector.Unit), -1, 1))
		
		--print(math.deg(distance))
		--print(math.deg(testDistance))
		
	end
	if closest then 
		
		--local amountToAdd = (owner.Position - closest.Position).Magnitude / (2^times)
	
		local desiredCFrame = CFrame.lookAt(owner.Position,closest.Position)
		local lookVector = desiredCFrame.LookVector
		local lookVectoratan2 = math.atan2(lookVector.Y,lookVector.X)
	--local lookVectorASinDeg = math.deg(math.asin(lookVector.Y))
	--local lookVectorACosDeg = math.deg(math.acos(lookVector.Z))
	--print(lookVectorASinDeg .. " ".. lookVectorACosDeg)


		local savedVectorValue = script.savedVector.Value
		local savedVectorValueatan2 = math.atan2(savedVectorValue.Y,savedVectorValue.X)

	--local savedlookVectorASinDeg = math.deg(math.asin(savedVectorValue.Y))
	--local savedlookVectorACosDeg = math.deg(math.acos(savedVectorValue.Z))
	--local savedlookVectorASin = math.asin(savedVectorValue.Y)
	--local savedlookVectorACos = math.acos(savedVectorValue.Z)
	--print(savedlookVectorASinDeg .. " ".. savedlookVectorACosDeg)

	--print(math.deg(math.atan2(lookVector.Y,lookVector.Z)) .. " " .. lookVectorACosDeg .. " " .. lookVectorASinDeg)
		local difference = math.acos(math.clamp(lookVector.Unit:Dot(savedVectorValue.Unit), -1, 1))

		local newVector = Vector3.new(0,math.sin(savedVectorValueatan2 + (sign * difference/2)),math.cos(savedVectorValueatan2 +(difference/2 * sign)))
		
		--print(math.deg(savedVectorValueatan2) .. 1)
		--print(math.deg(savedVectorValueatan2 + (sign * difference/2)) .. 2)
		--print(math.deg(lookVectoratan2) .. 3)
		--print(difference)
		print(newVector)
		
		
		local newDifference = math.acos(math.clamp(lookVector.Unit:Dot(newVector.Unit),-1,1))
		
		
		if (difference) > (newDifference) then
			savedVectorValue = newVector
	
		else 
			sign = sign * -1
			--print(difference .. " ".. newDifference .. " " .. difference - newDifference)
			
		end
		local lastVectorCFrame = CFrame.lookAt(owner.Position,owner.Position + savedVectorValue)
		owner.CFrame = lastVectorCFrame
		owner.Velocity = owner.CFrame.LookVector * 100
		
	
	--owner.CFrame = CFrame.lookAt(owner.Position, owner.Position + tweenValue)
	--owner.Velocity = owner.CFrame.LookVector * 100
		times = times + 1
		--print(times)
	
	end
	
end)
--[[
local TweenService = game:GetService("TweenService")
local vectorOffsetLeft = Vector3.new(0,0,3)
local desiredVectorOffset = Vector3.new(0,3,1)
local tweenValue = workspace.player.playerHitbox.tweenValue
local tweenInfo = TweenInfo.new(.10,Enum.EasingStyle.Linear)
local lastFrameTween = Vector3.new(0,0,0)
local tweenForward = TweenService:Create(tweenValue,tweenInfo, { Value = desiredVectorOffset })
local tweenBack = TweenService:Create(tweenValue,tweenInfo, {Value = vectorOffsetLeft})


function shiftTween()
	if shiftPressedBoolean == true  then
		tweenForward:Play()
	else 
		tweenBack:Play()
	end
end

]]--
