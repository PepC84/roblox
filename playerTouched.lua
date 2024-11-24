
workspace.player.playerHitbox.Touched:Connect(function(part)
	if  part.Parent == workspace.bullets then 
		print(part.Name)
	end
	if part.Parent == workspace.enemies then
		print(part.Name)
	end
end)
