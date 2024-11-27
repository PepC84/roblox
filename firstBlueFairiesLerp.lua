
ReplicatedStorage = game:GetService('ReplicatedStorage')
TweenService = game:GetService('TweenService')
RunService = game:GetService('RunService')
yLimit = 231.5
fairyVectorsTable = require(ReplicatedStorage.paths.firstStage.blueFairy.downnegativesinedown["better quality"])
local tweenArray = {}
local initialPos = {}
local fairiesDone = {}
local tweenInfo = TweenInfo.new(.1,Enum.EasingStyle.Linear)
local totalFairies = 5

--[[
local function tweeningINNIT(part,vecter)
	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Linear)
	local tween = TweenService:Create(part,tweenInfo, { Position = vecter })
	tween:Play()
end]]--

ReplicatedStorage.Assets.enemyAssets.firstBlueFairies:Clone().Parent = workspace.enemies.miniEnemies.blueFairies

for k,v in pairs(workspace.enemies.miniEnemies.blueFairies.firstBlueFairies:GetChildren()) do
	v:SetAttribute('id', k)
	
end


--[[
function main() 
	for i,v in pairs(workspace.miniEnemies.blueFairies.firstBlueFairies:GetChildren()) do
		if tweenArray[i].PlaybackState == Enum.TweenStatus.Completed then
			if v.Position.Y >=231.5 then 
				v.Position = v.Position - Vector3.new(0,1,0)
			else 
				local step = v.GetAttribute('step')
				tweenArray[i] = TweenService:Create(v,tweenInfo ,{Position =  v.Position + fairyVectorsTable[step + 1]})
				tweenArray[i]:Play()
				v.SetAttribute('step',step + 1)
			end
		end
		
	end
]]--
function main() 
	for _,v in pairs(workspace.enemies.miniEnemies.blueFairies.firstBlueFairies:GetChildren()) do
		
		if v.Position.Y <= 165 then 
			local i = v:GetAttribute('id')
			fairiesDone[i] = true
				v:Destroy()
			do continue end
		end
		
		if v.Position.Y >= 231.5 then
			v.Position = v.Position + Vector3.new(0,-.25,0)
			--print("a" .. i)
			do continue end
		end
		
		local i = v:GetAttribute('id')
		if  tweenArray[i] ~= nil and tweenArray[i].PlaybackState ~= Enum.PlaybackState.Completed then
			--print("b" .. i)
			do continue end
		end
		
		if tweenArray[i] == nil then 
			initialPos[i] = v.Position
			
		end
		

		local step = v:GetAttribute('step')
		tweenArray[i] = TweenService:Create(v,tweenInfo ,{Position =  initialPos[i] + fairyVectorsTable[step + 1]})
		tweenArray[i]:Play()
		v:SetAttribute('step',step + 1)
		--print( "c" .. i)
		
		
	end
	if #fairiesDone == totalFairies then
		script:Destroy()
		
	end
	--[[
	for _,v in pairs(workspace.miniEnemies.blueFairies.firstBlueFairies:GetChildren()) do
		tweeningINNIT(v,v.Position + fairyVectorsTable[j])
	end
	]]--
	--print(tweenArray)
end


RunService.Heartbeat:Connect(main)
