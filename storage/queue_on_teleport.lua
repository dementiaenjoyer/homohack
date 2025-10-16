local Players = cloneref(game:GetService("Players"));
local QueueOnTeleport = queue_on_teleport or queueonteleport;

while (not Players.LocalPlayer) do
    task.wait();
end;

writefile("homohack_script.lua", string.match(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/pf_main.lua"), "%[%=%=%=%[(.-)%]%=%=%=%]"));

(QueueOnTeleport or function() end)([==[
    if (game.GameId ~= 113491250) then
        return;
    end;
    
    loadstring(readfile("homohack_script.lua"))();
]==]);

return loadstring(readfile("homohack_script.lua"))();
