--// Defined

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local GameId = game.GameId

--// Tables

local Games = {
    { name = "Rivals", gameid = 6035872082, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/rivals.lua" },
    { name = "Bad Business", gameid = 1168263273, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/bad%20business.lua" },
    { name = "Phantom Forces", gameid = 113491250, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/placeholder/chams.lua", rewrite = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/placeholder/chams.lua" },
    { name = "Phantom Forces Test Place", gameid = 115272207, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/placeholder/chams.lua" },
}

function Fetch(URL)
    return game:HttpGet(tostring(URL))
end

--// Rest

for _, Supported in Games do
    if Supported.gameid == GameId then
        Library:Notify("Homohack detected you being in " .. Supported.name .. ", now loading script...", 5)

        if Supported.name:find("Phantom Forces") and getgenv()["load_rewrite"] then
            loadstring(Fetch(Supported.rewrite))()
            return "loaded rewrite"
        end

        loadstring(Fetch(Supported.link))()
        return "loaded regular"
    end
end

Library:Notify("You are not in a homohack supported game, loading universal...")
loadstring(Fetch("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/universal.lua"))()
