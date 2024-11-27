
ReplicatedStorage = game:GetService('ReplicatedStorage')
TweenService = game:GetService('TweenService')
RunService = game:GetService('RunService')
yLimit = 231.5
fairyVectorsTable = require(ReplicatedStorage.paths.firstStage.blueFairy.nolerpreq17)
fairiesToClone = ReplicatedStorage.Assets.enemyAssets.firstBlueFairies --fairies to clone from replicated storage to workplace so clients can see it
whereToClone = workspace.enemies.miniEnemies.blueFairies

local tweenArray = {}
local initialPos = {}
local fairiesDone = {}
local totalFairies = 0
local previousTime = 0
local clockArray = {}

--[[
local function tweeningINNIT(part,vecter)
	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Linear)
	local tween = TweenService:Create(part,tweenInfo, { Position = vecter })
	tween:Play()
end]]--

fairiesToClone:Clone().Parent = whereToClone
subfolder = whereToClone.firstBlueFairies
for k,v in pairs(subfolder:GetChildren()) do
	v:SetAttribute('id', k)
	clockArray[k] = os.clock()
	totalFairies = totalFairies + 1
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
	for _,v in pairs(subfolder:GetChildren()) do
		
		if v.Position.Y <= 165 then 
			local i = v:GetAttribute('id')
			fairiesDone[i] = true
			v:Destroy()
			if #fairiesDone == totalFairies then
				script:Destroy()
			end
			
			do continue end
		end
		
		if v.Position.Y >= 231.5 then
			if v:GetAttribute('step') == 0 then 
				v.Position = v.Position + (Vector3.new(0,-.25 * 60,0) * ( os.clock() - clockArray[v:GetAttribute('id')] ))
				clockArray[v:GetAttribute('id')] = os.clock()
				do continue end
			end

		end
		local i = v:GetAttribute('id')
		if initialPos[i] == nil then 
			initialPos[i] = v.Position
		end 
		 
		
		local step = v:GetAttribute('step')
		if fairyVectorsTable[step + 1] == nil then
			v:Destroy()
			fairiesDone[i] = true
			do continue end
		end
		
		v.Position = initialPos[i] + fairyVectorsTable[step + 1]
		v:SetAttribute('step',step + 1)
		clockArray[i] = os.clock()
	end

end


RunService.Heartbeat:Connect(main)
