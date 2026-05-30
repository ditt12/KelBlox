local character = script.Parent

local head = character:WaitForChild("Head")

head.Transparency = 1

for _, obj in ipairs(head:GetDescendants()) do
	if obj:IsA("Decal") then
		obj.Transparency = 1
	end
end
