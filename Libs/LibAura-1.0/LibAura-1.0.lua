local Lib, oldminor = LibStub:NewLibrary("LibAura-1.0", 10)

Lib.Cache = Lib.Cache or {}
--[[
    {
        [spellId] = {
            
        }
    }
]]--

Lib.EventFrame = Lib.EventFrame or CreateFrame("Frame", "LibAura10Frame")

local EventFrame = Lib.EventFrame

-- Scripts
function EventFrame_OnCombatLogEvent(...)
    local source = select(5, ...)

    -- Filter events not originating from the player 
    if source == "player" then
        local msg = select(2, ...)

        if msg == "SPELL_AURA_APPLIED" then
            local type = select(13, ...)

            if type == "BUFF" then
                local spell = select(10, ...)

                if not Lib.Cache[spell] then
                    Lib.Cache[spell] = {}
                end
            end
        end
    end
end

function EventFrame_OnUnitAuraEvent(unit)
    if unit == "player" then
        for idx=1, 40 do
            local aura = UnitAura("player", idx, "HELPFUL|PLAYER|RAID")
        end
    end
end

EventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        EventFrame_OnCombatLogEvent(CombatLogGetCurrentEventInfo())        
    else if event == "UNIT_AURA" then
        EventFrame_OnUnitAuraEvent(...)
    end
end)