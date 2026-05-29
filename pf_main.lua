-- getgenv().run_on_thread = nil;
-- getgenv().getactorthreads = nil;

if (setfflag) then
    setfflag("LuauStacklessPcall", "False");
end

local Services = setmetatable({}, {
    __index = function(Self, Index)
        return cloneref(game.GetService(game, Index));
    end
});

local TeleportService = Services.TeleportService;
local Players = Services.Players;

local LocalPlayer = Players.LocalPlayer;
local PlaceId, JobId = game.PlaceId, game.JobId;

local QueueOnTeleport = queue_on_teleport or queueonteleport;

local RunOnThread = run_on_thread or runonthread;
local RunOnActor = run_on_actor or runonactor;

local GetActorThreads = getactorthreads or get_actor_threads;
local GetDeletedActors = getdeletedactors or get_deleted_actors;

local PrioritizedFunction = (RunOnThread or RunOnActor);
local GetNeeded = { };

local function TPHandler()
    if (QueueOnTeleport) then
        (setfflag or function() end)("DebugRunParallelLuaOnMainThread", "True");

        QueueOnTeleport([[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/storage/queue_on_teleport.lua"))();
        ]]);

        return TeleportService:Teleport(PlaceId, LocalPlayer);
    end;

    (setclipboard or function() end)("https://www.youtube.com/watch?v=wr__SjSUjAU");
    return LocalPlayer:Kick("Couldn't find an actor or thread to run script on. Here's a youtube video on how to fix / get around this: https://www.youtube.com/watch?v=wr__SjSUjAU (REMOVE THE FFLAG AFTER YOU'RE DONE PLAYING, SOME GAMES BAN YOU FOR IT)");
end;

if (not RunOnThread) then
    return TPHandler();
end;

if (RunOnThread) then
    GetNeeded = GetActorThreads or (function()
        return { };
    end);
elseif (RunOnActor) then
    if (GetDeletedActors) then
        GetNeeded = GetDeletedActors;
    else
        return TPHandler();
    end;
end

local Actor = GetNeeded()[1];

if (not Actor) then
    return;
end;

local Success, Error = pcall(PrioritizedFunction, Actor, string.gsub( [==[
local CurrentKey = "yo";

if ( #CurrentKey == 2 ) then
    return game:GetService( "Players" ).LocalPlayer:Kick( "couldn't find a proper key to use, please join the discord server! (https://discord.gg/etUTmS3US5)" );
end

getgenv( ).script_key = CurrentKey;
loadstring( game:HttpGet( "https://api.luarmor.net/files/v4/loaders/ea77de328f41d48ad5385698897988b1.lua" ) )( );
]==], '"yo"', `"{script_key or 'no'}"`));

if (not Success) then
    return LocalPlayer:Kick(`Could not load script. I'd recommend you get an executor which supports run_on_thread, It'll work, trust me. [{Error}]`);
end
