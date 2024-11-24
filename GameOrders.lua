local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local serverTime = ReplicatedStorage:WaitForChild('timeSinceStart')
local RunService = game:GetService('RunService')
local lastAttack = 0
local lastPhase = 0
local previousTime = 0
local previousBlueFairy = 0
local step = 0
local enemy = workspace.enemies.mainEnemyHitbox
local enemyStartPosition = enemy.Position
local partStartPosition = workspace.enemies.Part.Position
local bulletGenerator = ReplicatedStorage:WaitForChild('bulletGeneratorCreate')
local n = 1
local fairyStep = 1

--tweeningINNIT(enemyStartPosition + Vector3.new(0,-28,14)) use squares of 7x7
--bulletGenerator:Fire(enemy, numberOfNewArrays, offsetRotation,rotationOfArraysPerSecond,shotsPerSecond,speedOfBullets,bulletType)
local function tweeningINNIT(part,vecter)
	local tweenInfo = TweenInfo.new(2,Enum.EasingStyle.Quint)
	local tween = TweenService:Create(part,tweenInfo, { Position = vecter })
	tween:Play()
end


local function gameOrders() 
	if serverTime.Value > 0 then 
		if serverTime.Value > 1 and fairyStep == 1 then
			
			ServerScriptService.tempScripts.firstBlueFairies.Disabled = false
			--[[
			for i,v in pairs(ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:GetChildren()) do
				if  v:IsA("Part") and v.Name == propertyOf then 
					newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				end
				
			end
			
			]]--
			fairyStep = 2
		end 
		if serverTime.Value > 4 and fairyStep == 2 then
			
			ServerScriptService.tempScripts.secondBlueFairies.Disabled = false
			--[[
			for i,v in pairs(ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:GetChildren()) do
				if  v:IsA("Part") and v.Name == propertyOf then 
					newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				end
				
			end
			
			]]--
			fairyStep = 3
		end 
		if serverTime.Value > 7 and fairyStep == 3 then
			ServerScriptService.tempScripts.fourthBlueFairies.Disabled = false
			ServerScriptService.tempScripts.thirdBlueFairies.Disabled = false
			--[[
			for i,v in pairs(ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:GetChildren()) do
				if  v:IsA("Part") and v.Name == propertyOf then 
					newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				end
				
			end
			
			]]--
			fairyStep = 4
		end 
		if serverTime.Value > 9 and fairyStep == 4 then
			ServerScriptService.tempScripts.firstRedFairies.Disabled = false
			--[[
			for i,v in pairs(ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:GetChildren()) do
				if  v:IsA("Part") and v.Name == propertyOf then 
					newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				end
				
			end
			
			]]--
			fairyStep = 5
		end 
		
		if serverTime.Value > 20 and fairyStep == 5 then
			ServerScriptService.tempScripts.fifthBlueFairies.Disabled = false
			--[[
			for i,v in pairs(ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:GetChildren()) do
				if  v:IsA("Part") and v.Name == propertyOf then 
					newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				end
				
			end
			
			]]--
			fairyStep = 6
		end 
		
		if serverTime.Value > 26 and fairyStep == 6 then
			ServerScriptService.tempScripts.sixthBlueFairies.Disabled = false
			--[[
			for i,v in pairs(ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:GetChildren()) do
				if  v:IsA("Part") and v.Name == propertyOf then 
					newBullet.Position = Vector3.new(224,v.Position.Y,v.Position.Z)

				end
				
			end
			
			]]--
			fairyStep = 7
		end 

		if step == 0 and serverTime.Value - previousTime >= 10 then
			tweeningINNIT(enemy, enemyStartPosition + Vector3.new(0,-7,14))
			bulletGenerator:Fire(enemy, 3, 180, 2,.2,30,"knifeHitbox")
			previousTime = serverTime.Value
			step = 1
		end
		if step == 1 and serverTime.Value - previousTime >= 3 then
			
			tweeningINNIT(workspace.enemies.Part, partStartPosition + Vector3.new(0,0,n * 28))
			n = n * -1
			previousTime = serverTime.Value
			
		end
			
		
		
		
		
		
	end
end

RunService.Stepped:Connect(gameOrders)
