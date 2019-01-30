Helix = LibStub("AceAddon-3.0"):NewAddon("Helix")

--[[
    {
        player = {
            spec = {
                id = 269,
                talents = {
                    [154678] = true,
                    ...
                },
            },
            buffs = {
                [154678] = {
                    up = true,
                    down = false,
                    count = 3
                }
            },
            spells = {
                [154678] = {
                    cooldown = {
                        remaining = 3
                    }
                }
            }
        },
    }
]]

--[[
    Schedule a timer that runs every ? ms.
]]--
--[[
    Run the APL every tick of the timer
]]--