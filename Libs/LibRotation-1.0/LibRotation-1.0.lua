local Lib, oldminor = LibStub:NewLibrary("LibRotation-1.0", 10)

Lib.Registry = Lib.Registry or {}

local insert, sort = table.insert, table.sort

local newRotation
do
    local env = {}

    env.actions = function(t)
        local ks = {}
        local vs = {}

        for k in pairs(t) do
            insert(ks, k)
        end

        sort(ks)

        for _, k in ipairs(ks) do
            vs[k] = t[k]
        end

        return vs
    end

    env.cast = function(s)
        return function(c)
            assert(type(c.when) == "function")

            return { spell = s, condition = c.when }
        end
    end

    env.use = env.cast

    --[[
        Sets the functions environment to our
        custom DSL environment
    ]]--
    function newRotation(fn)
        setfenv(fn, setmetatable({}, {
            __index = function(self, m)

            end
        }))

        return fn
    end
end

function Lib:RegisterRotation(Spec, Fn)
    assert(type(Fn) == "function")

    Rotation = newRotation(Fn)

    Lib.Registry[Spec] = Rotation
end

function Lib:Create(Spec)
    return Lib.Registry[Spec]
end