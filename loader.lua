--// Defined

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local GameId = game.GameId

--// Tables

local Games = {
    { name = "Rivals", gameid = 6035872082, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/rivals.lua" },
    { name = "Phantom Forces", gameid = 113491250, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/homohack.lua"},
    { name = "Phantom Forces Test Place", gameid = 115272207, link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/homohack.lua" },
}

function Fetch(URL)
    return game:HttpGet(tostring(URL))
end

--// Rest

for _, Supported in Games do
    if Supported.gameid == GameId then

        Library:Notify(`homohack has detected you being in {Supported.name}.`, 5)

        if Supported.name:find("Phantom") then

            if run_on_actor then

                run_on_actor(game:GetService("ReplicatedFirst")["lol"], [[
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/pf.lua"))()
                ]])

            else

                loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/pf_lite.lua"))()
                
            end

        else
            loadstring(Fetch(Supported.link))()
        end

        return "loaded regular"

    end
end

Library:Notify("You are not in a homohack supported game, loading universal..")
loadstring(Fetch("https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/universal.lua"))()
