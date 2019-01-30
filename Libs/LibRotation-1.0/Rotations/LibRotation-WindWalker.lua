local Spec, Version = 269, 10
local LibRotation = LibStub and LibStub("LibRotation-1.0", true)

if not LibRotation then return end

--[[-----------------------------------------------------------------------------
Rotation
-------------------------------------------------------------------------------]]
LibRotation:RegisterRotation(Spec, function()
    return actions {
        -- Cast Whirling Dragon Punch
        cast 152175 {
            when = function(env)
                return true
            end
        },

        -- Cast Rising Sun Kick if Chi is greater than or equal to 5
        cast 107428 {
            when = function(env)
                return env.player.power[2] >= 5
            end
        },

        -- Cast Fists of Fury if time to max Energy is greater than 3
        cast 113656 {
            when = function(env)
                return env.player.power[1].ttm > 3
            end
        },

        -- Cast Rising Sun Kick
        cast 152175 {
            when = function(env)
                return true
            end
        },

        -- Cast Spinning Crane Kick if previous GCD is not Spinning Crane Kick and player has buff Dance of Chi-Ji
        cast 101546 {
            when = function(env)
                return env.player.buffs[286587] == true and env.gcd.previous ~= 101546
            end
        },

        -- Cast Fist of the White Tiger if Chi is less than or equal to 2
        cast 261947 {
            when = function(env)
                return env.player.power[2] <= 2
            end
        },

        -- Cast Blackout Kick! if previous GCD is not Blackout Kick! and
        --- remaining cooldown on Sunrise Kick is greater than 3 seconds or Chi is greater than or equal to 3
        -- and
        --- remaining cooldown on Fists of Fury is greater than 4 or Chi is greater than or equal to 4
        --- or
        ---- Chi is equal to 2 and previous GCD is Tiger Palm
        -- and count of Swift Roundhouse is less than 2: TODO!
        cast 100784 {
            when = function(env)
                if env.gcd.previous ~= 100784 then
                    print("Previous GCD is not Blackout Kick!")
                    if env.spell[152175].cooldown.remaining > 3 or env.player.power[2].current >= 3 then
                        print("Check on Sunrise Kick passed")
                        if env.spell[113656].cooldown.remaining > 4 or env.player.power[2].current >= 4 then
                            print("Check on Fists of Fury passed")
                            return true
                        else if env.gcd.previous == 100780 and env.player.power[2].current == 2 then
                            print("Check on Chi equals 2 passed")
                            return true
                        end
                    end
                end

                return false
            end
        },

        -- Cast Chi Burst if Chi deficit is greater than or equal to 1 and
        --- enemies in range equals 1 or Chi deficit is greater than or equal to 2
        cast 123986 {
            when = function(env)
                if env.player.power[2].deficit >= 1 then
                    if env.enemies.count == 1 or env.player.power[2].deficit >= 2 then
                        return true
                    end
                end

                return false
            end
        },

        -- Cast Tiger Palm if previous GCD is not Tiger palm and Chi deficit is greater than or equal to 2
        cast 100780 {
            when = function(env)
                return env.gcd.previous ~= 100780 and env.player.power[2].deficit >= 2
            end
        }
    }
end)