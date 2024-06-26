--// Defined

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local GameId = game.GameId

--// Tables

local Cfg = {
    Loaded = false,
}
local Games = {
    { name = "Bad Business", gameid = 1168263273, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/bad%20business.lua" },
    { name = "Phantom Forces", gameid = 113491250, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/homohack.lua" },
    { name = "Phantom Forces Test Place", gameid = 115272207, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/homohack.lua" },
}

function Fetch(URL)
    return game:HttpGet(tostring(URL))
end

--// Rest

for i, Supported in Games do
    if Supported.gameid == GameId then
        Library:Notify("Homohack detected you being in " .. Supported.name .. ", now loading script...", 5)
        loadstring(Fetch(Supported.link))()
        Cfg["Loaded"] = true
    end
end
if not Cfg["Loaded"] then
    Library:Notify("You are not in a homohack supported game, loading universal...")
    loadstring(Fetch("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/universal.lua"))()
end
