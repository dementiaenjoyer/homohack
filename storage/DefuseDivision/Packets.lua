return {["Hit"] = {
    Weapon,
    Workspace:GetServerTimeNow(),
    { Origin },
    {
        {
            nil,
            {
                {
                    HitPart,
                    Destination
                }
            }
        }
    }, {
        false, RegistrationCount, { 1 }, false -- i am pretty sure the '1' represents the pelletcount, but i am not entirely sure.
    },
    {
        {Y = Destination.Y, X = Destination.X, Z = Destination.Z}
    }
}};
