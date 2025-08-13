-- Script Lokal (LocalScript) untuk UI
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Buat ScreenGui jika belum ada
local screenGui = playerGui:FindFirstChild("CopyJobIdGui") or Instance.new("ScreenGui")
screenGui.Name = "CopyJobIdGui"
screenGui.Parent = playerGui

-- Buat Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0, 10)
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = screenGui

-- Buat TextButton
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.9, 0, 0.8, 0)
button.Position = UDim2.new(0.05, 0, 0.1, 0)
button.Text = "Salin Job ID"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
button.Parent = frame

-- Fungsi untuk menyalin Job ID
local function copyJobId()
    local jobId = game.JobId
    
    if jobId == "" then
        button.Text = "Server Pribadi"
        task.wait(2)
        button.Text = "Salin Job ID"
        return
    end
    
    -- Untuk Roblox Studio (tidak bisa benar-benar copy)
    if not game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows then
        button.Text = "Job ID: "..jobId
        task.wait(2)
        button.Text = "Salin Job ID"
        return
    end
    
    -- Untuk game Roblox asli (menggunakan Clipboard)
    pcall(function()
        setclipboard(jobId)
        button.Text = "Tersalin!"
        task.wait(2)
        button.Text = "Salin Job ID"
    end)
end

button.MouseButton1Click:Connect(copyJobId)
