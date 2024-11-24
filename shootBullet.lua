local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local movingPart = workspace.player.playerHitbox;
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local bindables = ReplicatedStorage.LocalBindables
local shiftPressed = bindables:WaitForChild('shiftPressed')
local shiftReleased = bindables:WaitForChild('shiftReleased')
local backspacePressed = bindables:WaitForChild('backspacePressed')
local backspaceReleased = bindables:WaitForChild('backspaceReleased')
local spacePressed = bindables:WaitForChild('spacePressed')
local spaceReleased = bindables:WaitForChild('spaceReleased')
local xPressed = bindables:WaitForChild('xPressed')
local xReleased = bindables:WaitForChild('xReleased')
local spacePressedBoolean = false
local shiftPressedBoolean = false
local playerHitbox = workspace.player.playerHitbox
local previousNormalShot = 0
local previousSpecialShot = 0
local bulletArrays = 5
local extraTimes = 10
local amplitude = .20



 local newSpecialBulletTemplate = ReplicatedStorage.Assets.bulletAssets:WaitForChild("smallCircleHitbox")
-- poopy knife (unused) newSpecialBulletTemplate = ReplicatedStorage.Assets.bulletAssets:WaitForChild("knifeHitbox")
local newBulletTemplate = ReplicatedStorage.Assets.bulletAssets:WaitForChild("knifeHitbox")


spacePressed.Event:Connect(function()
	spacePressed = true
end)
spaceReleased.Event:Connect(function()
	spacePressed = false
	extraTimes = 1
end)
shiftPressed.Event:Connect(function()
	shiftPressed = true
end)
shiftReleased.Event:Connect(function()
	shiftPressed = false
end)

function calculateNearestEven(numberToRound)
	if numberToRound %2 == 0 then
		return numberToRound	
	end
	return numberToRound - 1
end 
	
function makeBullet(pos,rot,singleBullet)
	
	local newBullet = newBulletTemplate:Clone()
	newBullet.Name = "normalShot"
	newBullet.Position = playerHitbox.Position + Vector3.new(0,0,pos)
	local directionVector = Vector3.new(0,math.sin(math.rad( (rot) + 90 )),math.cos(math.rad( (rot) + 90))).Unit
	newBullet.CFrame = CFrame.lookAt(newBullet.Position,newBullet.Position + directionVector)
	if singleBullet == true then 
		newBullet.Orientation  += Vector3.new(0,90,0)
	end
	newBullet.Velocity = 100 * directionVector
	newBullet.Parent = workspace.fakeBullets
	newBullet.CollisionGroup = "ignore"
	newBullet.bulletShape.Transparency = .5

	newBullet.Touched:Connect(function(hit)
		local function destroyBullet() 
			if  workspace.bulletDespawners.Model.Name == hit.Parent.Name or
				workspace.enemies.Name == hit.Parent.Name or 
				workspace.enemies.Name == hit.Parent.Parent.Parent.Parent.Name or 
				workspace.enemies.Name == hit.Parent.Parent.Parent.Name then 
				newBullet:Destroy()
			end
		end	
		pcall(destroyBullet)
	end)
end

function timeBullet() 
	if spacePressed == true or extraTimes < 3 then 
		if tick() - previousNormalShot >= .075 then 
			if bulletArrays %2 ~= 0 then
				makeBullet(0,0,true)
				amplitude = amplitude + .35
			end  
			for i = 1, calculateNearestEven(bulletArrays), 1 do
				local sign = math.pow(-1,i)
				if sign == -1 then
					amplitude = amplitude * 3
				end
				makeBullet(sign * .5, (amplitude * -sign) +  (-sign * .10),false)
				

			end 
			amplitude = .20
			extraTimes = extraTimes + 1 --bruh i cant extratimes++;
			previousNormalShot = tick()
		end
		
		if tick() - previousSpecialShot >= .5 then
			
			local function makeSpecialBullets(part,cosine)
				local newSpecialBullet = newSpecialBulletTemplate:Clone()
				newSpecialBullet.Name = "specialShot"
				newSpecialBullet.Position = part.Position
				local directionVector = Vector3.new(0,0.70710678118,cosine) --sin and cos of 45 degrees 
				
				newSpecialBullet.CFrame = CFrame.lookAt(newSpecialBullet.Position,newSpecialBullet.Position + directionVector)
				
				--[[
				local lv = Instance.new("LinearVelocity", newSpecialBullet)
				local att = Instance.new("Attachment", newSpecialBullet)
				lv.VelocityConstraintMode = 2
				lv.Attachment0 = att
				lv.VectorVelocity = 75 * directionVector
				lv.RelativeTo = Enum.ActuatorRelativeTo.World
				--newSpecialBullet.Velocity = 75 * directionVector
				]]--
				
				newSpecialBullet.Velocity = 75 * directionVector
				
				newSpecialBullet.Parent = workspace.fakeBullets.special
				newSpecialBullet.CollisionGroup = "ignore"
				newSpecialBullet.bulletShape.Transparency = .25
				
				local scriptToCopy = ReplicatedStorage.followNearestEnemy:Clone()
				scriptToCopy.Parent = script.Parent.instanceScripts
				scriptToCopy.whatever.Value = newSpecialBullet
				scriptToCopy.savedVector.Value = directionVector
			
				scriptToCopy.Disabled = false
				
				newSpecialBullet.Touched:Connect(function(hit)
					local function destroySpecialBullet() 
						
					
						if workspace.bulletDespawners.Model.Name == hit.Parent.Name or
							workspace.enemies.Name == hit.Parent.Name or 
							workspace.enemies.Name == hit.Parent.Parent.Parent.Parent.Name or 
							workspace.enemies.Name == hit.Parent.Parent.Parent.Name then 
							newSpecialBullet:Destroy()
							scriptToCopy:Destroy()
						end
						
						
					end	
					pcall(destroySpecialBullet)
				end)
			end
			makeSpecialBullets(playerHitbox.leftBall,0.70710678118)
			makeSpecialBullets(playerHitbox.rightBall,-0.70710678118)
			previousSpecialShot = tick()
			
		end
	end
end


RunService.Heartbeat:Connect(timeBullet)

--[[
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local bulletGeneratorCreate = ReplicatedStorage:WaitForChild('bulletGeneratorCreate')

bulletGeneratorCreate.Event:Connect(function(enemy, newArrays, offsetRotation, rotationPerSecond,shotsPerSecond,bulletSpeed,bulletType)
	local rotationOfArrays = 360/newArrays
	local rotation = rotationOfArrays + offsetRotation


	for i = 1, newArrays,1 do
		local scriptToCopy = ReplicatedStorage.bulletCreate:Clone()

		scriptToCopy:SetAttribute("rotation", offsetRotation + i*rotationOfArrays)
		scriptToCopy:SetAttribute("propertyOf",enemy.Name)
		scriptToCopy:SetAttribute("rps",rotationPerSecond)
		scriptToCopy:SetAttribute("sps",shotsPerSecond)
		scriptToCopy:SetAttribute("bulletSpeed",bulletSpeed)
		scriptToCopy:SetAttribute("bulletType",bulletType)
		scriptToCopy.Parent = game:GetService('ServerScriptService').newScripts
		scriptToCopy.Disabled = false

	end
	return

end)


]]--
--	local directionVector = Vector3.new(0,math.sin(math.rad( (sign * .5) + 90 )),math.cos(math.rad( (sign * .5) + 90)))
--[[
local RunService = game:GetService("RunService")
local serverStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local newBulletTemplate = ReplicatedStorage.Assets.bulletAssets:WaitForChild(script:GetAttribute("bulletType"))
local propertyOf = script:GetAttribute("propertyOf")

local  debounce = false

local function shootBullet() 
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

		newBullet.Parent = game.Workspace.bullets
		newBullet:SetNetworkOwner(game.Players.PepC84)
		newBullet.CollisionGroup = "bullets"
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
		wait(script:GetAttribute("sps"))
		debounce = false
	end
end
RunService.Stepped:Connect(shootBullet) ]]--
