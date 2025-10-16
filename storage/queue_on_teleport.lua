local Players = cloneref(game:GetService("Players"));

while (not Players.LocalPlayer) do
    task.wait();
end;

loadstring(string.match(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/pf_main.lua"), "%[%=%=%=%[(.-)%]%=%=%=%]"))();
