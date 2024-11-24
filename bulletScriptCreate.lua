local ReplicatedStorage = game:GetService('ReplicatedStorage')
local bulletGeneratorCreate = ReplicatedStorage:WaitForChild('bulletGeneratorCreate')

bulletGeneratorCreate.Event:Connect(function(enemy, newArrays, offsetRotation, rotationPerSecond,shotsPerSecond,bulletSpeed,bulletType)
	local rotationOfArrays = 360/newArrays
	local rotation = rotationOfArrays + offsetRotation


	for i = 1, newArrays,1 do
		local scriptToCopy = ReplicatedStorage.ServerBulletCreate:Clone()
		
		scriptToCopy:SetAttribute("rotation", offsetRotation + i*rotationOfArrays)
		scriptToCopy:SetAttribute("propertyOf",enemy.Name)
		scriptToCopy:SetAttribute("rps",rotationPerSecond)
		scriptToCopy:SetAttribute("sps",shotsPerSecond)
		scriptToCopy:SetAttribute("bulletSpeed",bulletSpeed)
		scriptToCopy:SetAttribute("bulletType",bulletType)
		scriptToCopy.Parent = game:GetService('ServerScriptService').newScripts
		scriptToCopy.Disabled = false
		
		
		--[[
		for j,v in pairs(game.Players:GetChildren()) do
			local ClientScriptToCopy = ReplicatedStorage.ClientBulletCreate:Clone()

			ClientScriptToCopy:SetAttribute("rotation", offsetRotation + i*rotationOfArrays)
			ClientScriptToCopy:SetAttribute("propertyOf",enemy.Name)
			ClientScriptToCopy:SetAttribute("rps",rotationPerSecond)
			ClientScriptToCopy:SetAttribute("sps",shotsPerSecond)
			ClientScriptToCopy:SetAttribute("bulletSpeed",bulletSpeed)
			ClientScriptToCopy:SetAttribute("bulletType",bulletType)
			ClientScriptToCopy:SetAttribute("clientOwner",v.Name)
			ClientScriptToCopy.Parent = game:GetService('ServerScriptService').newScripts
			ClientScriptToCopy.Disabled = false
		end
		]]--
	end

end)
