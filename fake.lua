local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 300)
Main.Position = UDim2.new(0.5, -250, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0
Main.Parent = gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,120,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,18)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,12)

-- Toggle Sidebar Button
local ToggleSidebar = Instance.new("TextButton")
ToggleSidebar.Size = UDim2.new(0,30,0,30)
ToggleSidebar.Position = UDim2.new(0,130,0,10)
ToggleSidebar.Text = "≡"
ToggleSidebar.Parent = Main

local sidebarOpen = true

ToggleSidebar.MouseButton1Click:Connect(function()
	sidebarOpen = not sidebarOpen

	if sidebarOpen then
		Sidebar:TweenSize(
			UDim2.new(0,120,1,0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.25,
			true
		)
	else
		Sidebar:TweenSize(
			UDim2.new(0,0,1,0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.25,
			true
		)
	end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Premium Hub"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Main

-- Key System Frame
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0,300,0,160)
KeyFrame.Position = UDim2.new(0.5,-120,0.5,-60)
KeyFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyFrame.Parent = Main

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,10)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "Key System"
KeyTitle.TextColor3 = Color3.new(1,1,1)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 20
KeyTitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8,0,0,40)
KeyBox.Position = UDim2.new(0.1,0,0.35,0)
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Text = ""
KeyBox.Parent = KeyFrame

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local Check = Instance.new("TextButton")
Check.Size = UDim2.new(0.8,0,0,40)
Check.Position = UDim2.new(0.1,0,0.68,0)
Check.Text = "Check Key"
Check.Parent = KeyFrame

Instance.new("UICorner", Check).CornerRadius = UDim.new(0,8)

local VALID_KEY = "PREMIUM2026"

Check.MouseButton1Click:Connect(function()
	if KeyBox.Text == VALID_KEY then
		Check.Text = "Success ✓"
		Check.BackgroundColor3 = Color3.fromRGB(0,170,0)
	else
		Check.Text = "Wrong Key ✗"
		Check.BackgroundColor3 = Color3.fromRGB(170,0,0)
	end
end)

-- Drag System
local dragging = false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
