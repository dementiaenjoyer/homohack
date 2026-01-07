local Namespaces = {
    ["Players"] = "490487.7366353023",
    ["Caster"] = "252710.30883593226"
};

local Events = {
    ["Players"] = {
        ["ShotFired"] = "468681.9235070626",
        ["InflictHit"] = "133758.26977966932",
        ["CycleRound"] = "251884.5282889347",
        ["EjectShell"] = "775912.8979508103",
        ["SingleShotReload"] = "421323.67325234675"
    },
    
    ["Caster"] = {
        ["RegisterHit"] = "389225.4325676357"
    }
};

return Namespaces, Events;
