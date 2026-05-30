local character = script.Parent
local head = character:WaitForChild("Head")

head.Transparency = 1
head.CanCollide = false

for _, v in ipairs(head:GetChildren()) do
	if v:IsA("Decal") then
		v.Transparency = 1
	end
end
