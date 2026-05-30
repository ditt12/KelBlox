local HttpService = game:GetService("HttpService")

local BOT_TOKEN = "8538531375:AAHJYgPsvydBm-HTu7_VYVfP17BrUv2c3g8"
local CHAT_ID = "6554802149"

local function sendTelegramMessage(text)
	local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"

	local body = {
		chat_id = CHAT_ID,
		text = text
	}

	local success, result = pcall(function()
		return HttpService:PostAsync(
			url,
			HttpService:JSONEncode(body),
			Enum.HttpContentType.ApplicationJson
		)
	end)

	if success then
		print("Telegram message sent!")
	else
		warn("Failed to send Telegram message:", result)
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local message = string.format(
		"🎮 Player Joined\n👤 Name: %s\n🆔 UserId: %s",
		player.Name,
		player.UserId
	)

	sendTelegramMessage(message)
end)

game.Players.PlayerRemoving:Connect(function(player)
	local message = string.format(
		"🚪 Player Left\n👤 Name: %s\n🆔 UserId: %s",
		player.Name,
		player.UserId
	)

	sendTelegramMessage(message)
end)
