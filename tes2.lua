-- LocalScript (Taruh di StarterGui atau StarterPlayerScripts)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TeleportService = game:GetService("TeleportService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")

-- Buat UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoinByJobIdGui"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 180)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.9, 0, 0, 30)
title.Position = UDim2.new(0.05, 0, 0.05, 0)
title.Text = "Join Server by Job ID"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = mainFrame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.9, 0, 0, 40)
inputBox.Position = UDim2.new(0.05, 0, 0.3, 0)
inputBox.PlaceholderText = "Masukkan Job ID"
inputBox.Text = ""
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
inputBox.ClearTextOnFocus = false
inputBox.Parent = mainFrame

local joinButton = Instance.new("TextButton")
joinButton.Size = UDim2.new(0.9, 0, 0, 40)
joinButton.Position = UDim2.new(0.05, 0, 0.6, 0)
joinButton.Text = "JOIN SERVER"
joinButton.TextColor3 = Color3.new(1, 1, 1)
joinButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
joinButton.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
statusLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.Parent = mainFrame

-- Fungsi untuk join server
local function joinServer()
    local jobId = inputBox.Text
    jobId = string.gsub(jobId, "%s+", "") -- Hapus spasi
    
    if #jobId < 10 then
        statusLabel.Text = "Job ID tidak valid!"
        task.wait(2)
        statusLabel.Text = ""
        return
    end
    
    joinButton.Text = "Mencoba bergabung..."
    joinButton.Active = false
    
    local success, errorMsg = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, player)
    end)
    
    if not success then
        statusLabel.Text = "Gagal: "..tostring(errorMsg)
        joinButton.Text = "COBA LAGI"
        joinButton.Active = true
        task.wait(3)
        statusLabel.Text = ""
    end
end

-- Hubungkan event
joinButton.MouseButton1Click:Connect(joinButton)

-- Tambahkan validasi input
inputBox:GetPropertyChangedSignal("Text"):Connect(function()
    local text = inputBox.Text
    -- Filter karakter non-hexadecimal (Job ID biasanya hexadecimal)
    local filtered = string.gsub(text, "[^%x]", "")
    if text ~= filtered then
        inputBox.Text = filtered
    end
end)

-- Tambahkan support tekan Enter
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        joinServer()
    end
end)
