-- Auto Buy All for Grow a Garden with UI
-- Compatible with Delta, Ronix, and other executors

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoBuyGUI"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Grow a Garden Auto Buy"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = Frame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local OptionsFrame = Instance.new("Frame")
OptionsFrame.Size = UDim2.new(1, -20, 1, -60)
OptionsFrame.Position = UDim2.new(0, 10, 0, 50)
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.Parent = Frame

-- Create checkboxes
local checkboxes = {
    Seeds = true,
    Gear = true,
    Eggs = true,
    Event = true
}

local yPosition = 0
local checkboxHeight = 30

for option, default in pairs(checkboxes) do
    local Checkbox = Instance.new("TextButton")
    Checkbox.Name = option
    Checkbox.Text = ""
    Checkbox.Size = UDim2.new(0, 30, 0, 30)
    Checkbox.Position = UDim2.new(0, 0, 0, yPosition)
    Checkbox.BackgroundColor3 = default and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    Checkbox.BorderSizePixel = 0
    Checkbox.Parent = OptionsFrame
    
    local Label = Instance.new("TextLabel")
    Label.Text = "Buy All "..option
    Label.Size = UDim2.new(0, 200, 0, 30)
    Label.Position = UDim2.new(0, 40, 0, yPosition)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = OptionsFrame
    
    Checkbox.MouseButton1Click:Connect(function()
        checkboxes[option] = not checkboxes[option]
        Checkbox.BackgroundColor3 = checkboxes[option] and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    end)
    
    yPosition = yPosition + checkboxHeight + 5
end

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Status: Ready"
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 1, -40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.Parent = Frame

local StartButton = Instance.new("TextButton")
StartButton.Text = "START AUTO BUY"
StartButton.Size = UDim2.new(1, -20, 0, 40)
StartButton.Position = UDim2.new(0, 10, 1, -90)
StartButton.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Font = Enum.Font.GothamBold
StartButton.TextSize = 16
StartButton.Parent = Frame

-- Main function
local function autoBuyAll()
    StatusLabel.Text = "Status: Opening shop..."
    wait(0.5)
    
    local shopOpen = false
    local maxAttempts = 10
    local attempts = 0
    
    -- Try to open shop
    repeat
        attempts = attempts + 1
        for _, v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "OpenShop") then
                v.OpenShop()
                shopOpen = true
                break
            end
        end
        wait(1)
    until shopOpen or attempts >= maxAttempts
    
    if not shopOpen then
        StatusLabel.Text = "Status: Failed to open shop"
        return
    end
    
    StatusLabel.Text = "Status: Shop opened, buying items..."
    wait(1)
    
    -- Function to buy all in category
    local function buyAllInCategory(categoryName)
        local shopItems = PlayerGui.Shop.Frame.MainFrame.ItemsFrame.ScrollingFrame:FindFirstChild(categoryName)
        
        if shopItems then
            for _, itemFrame in pairs(shopItems:GetChildren()) do
                if itemFrame:IsA("Frame") and itemFrame:FindFirstChild("BuyButton") then
                    local buyButton = itemFrame.BuyButton
                    local clickDetector = buyButton:FindFirstChildOfClass("TextButton")
                    
                    if clickDetector then
                        for i = 1, 5 do
                            fireclickdetector(clickDetector)
                            wait(0.1)
                        end
                    end
                end
            end
        end
    end
    
    -- Buy items in selected categories
    for category, shouldBuy in pairs(checkboxes) do
        if shouldBuy then
            StatusLabel.Text = "Status: Buying "..category.."..."
            buyAllInCategory(category)
            wait(0.5)
        end
    end
    
    StatusLabel.Text = "Status: Auto buy complete!"
end

StartButton.MouseButton1Click:Connect(function()
    spawn(autoBuyAll)
end)

-- Make the UI visible
ScreenGui.Enabled = true
