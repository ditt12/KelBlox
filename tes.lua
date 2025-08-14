local HttpService = game:GetService("HttpService")

local webhookURL = "https://discord.com/api/webhooks/1381242557459075212/KNYM0-8i6pQgQyqbYFcY318HrKKuhuWYwlBS4gUTTEukozLJPL2adEhBM86QRJwJX2G9"  -- Ganti dengan URL webhookmu!

local data = {
    ["content"] = "Ada player baru nih!",
    ["embeds"] = {{
        ["title"] = "Info Player",
        ["description"] = "Nama: " .. player.Name,
        ["color"] = 65280  -- Warna hijau
    }}
}

local headers = {
    ["Content-Type"] = "application/json"
}

HttpService:PostAsync(webhookURL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson, false, headers)
