local Lib, oldminor = LibStub:NewLibrary("LibAura-1.0", 10)

-- WoW APIs
local CreateFrame = CreateFrame
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo

-- Aura Cache
Lib.Auras = Lib.Auras or {}

-- Event Frame
Lib.EventFrame = Lib.EventFrame or CreateFrame("Frame", "LibAura10Frame")

-- Event Handlers
function Handle_SpellAuraApplied(sourceGUID, destGUID, ...)
    local spellId, spellName, _, auraType, amount = select(12, ...)

    local aura = {
        name = spellName,
        source = sourceGUID,
        destination = destGUID,
        type = auraType,
        stacks = amount,
    }

    -- DEBUG
    DEFAULT_CHAT_FRAME:AddMessage(spellName .. " was applied!")

    Lib.Auras[spellId] = aura
end

function Handle_SpellAuraRemoved(sourceGUID, destGUID, ...)
    local spellId = select(12, ...)

    -- DEBUG
    DEFAULT_CHAT_FRAME:AddMessage(spellId .. " was removed")

    Lib.Auras[spellId] = nil
end

-- Scripts
function EventFrame_OnCombatLogEvent(...)
    local _, msg, _, sourceGUID, _, _, _, destGUID, _, _, _ = select(1, ...)

    if msg == "SPELL_AURA_APPLIED" then
        Handle_SpellAuraApplied(sourceGUID, destGUID, ...)
    elseif msg == "SPELL_AURA_REMOVED" then
        Handle_SpellAuraRemoved(sourceGUID, destGUID, ...)
    end
end

function EventFrame_OnUnitAuraEvent(unit)
    if unit == "player" then
        for idx=1, 40 do
            local aura = UnitAura("player", idx, "HELPFUL|PLAYER|RAID")
        end
    end
end

-- WoW Events
local EventFrame = Lib.EventFrame

EventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        EventFrame_OnCombatLogEvent(CombatLogGetCurrentEventInfo())        
    elseif event == "UNIT_AURA" then
        EventFrame_OnUnitAuraEvent(...)
    end
end)

-- LibAura Events
Lib.Registry = { events = setmetatable({}, {
    __index = function(t, k) t[k] = {} return t[k] end
})}

local events = Lib.Registry.events

function Lib.Registry:Fire(event, ...)
    if not rawget(events, event) or not next(events[event]) then return end

    -- Safely dispatch event with xpcall
end
