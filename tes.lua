local player = game.Players.LocalPlayer
local gui = script.Parent -- ScreenGui
local frame = gui.Frame

-- Ambil komponen UI
local walkSpeedBox = frame.WalkSpeedBox -- TextBox untuk WalkSpeed
local jumpPowerBox = frame.JumpPowerBox -- TextBox untuk JumpPower
local applyButton = frame.ApplyButton -- TextButton untuk menerapkan
local resetButton = frame.ResetButton -- TextButton untuk reset

-- Nilai default
local defaultWalkSpeed = 16
local defaultJumpPower = 50

-- Fungsi update speed & jump
local function updateStats()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Ambil nilai dari TextBox (pastikan angka)
    local newSpeed = tonumber(walkSpeedBox.Text) or defaultWalkSpeed
    local newJump = tonumber(jumpPowerBox.Text) or defaultJumpPower
    
    -- Terapkan perubahan
    humanoid.WalkSpeed = newSpeed
    humanoid.JumpPower = newJump
    
    print("WalkSpeed:", humanoid.WalkSpeed, "| JumpPower:", humanoid.JumpPower)
end

-- Fungsi reset ke default
local function resetStats()
    walkSpeedBox.Text = tostring(defaultWalkSpeed)
    jumpPowerBox.Text = tostring(defaultJumpPower)
    updateStats() -- Panggil fungsi update
end

-- Event listeners
applyButton.MouseButton1Click:Connect(updateStats)
resetButton.MouseButton1Click:Connect(resetStats)

-- Set nilai default di UI saat pertama kali
walkSpeedBox.Text = tostring(defaultWalkSpeed)
jumpPowerBox.Text = tostring(defaultJumpPower)
