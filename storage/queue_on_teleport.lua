local Players = cloneref(game:GetService("Players"));
local QueueOnTeleport = queue_on_teleport or queueonteleport;

while (not Players.LocalPlayer) do
    task.wait();
end;

(QueueOnTeleport or function() end)([==[
    local Players = cloneref(game:GetService("Players"));

    if (game.GameId ~= 113491250) then
        return;
    end;

    while (not Players.LocalPlayer) do
        task.wait();
    end;
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/storage/queue_on_teleport.lua"))();
]==]);

return loadstring(string.match(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/pf_main.lua"), "%[%=%=%=%[(.-)%]%=%=%=%]"))();
