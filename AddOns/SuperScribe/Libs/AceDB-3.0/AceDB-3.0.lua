-- AceDB-3.0 stub
local AceDB = LibStub:NewLibrary("AceDB-3.0", 1)
if not AceDB then return end

function AceDB:New(savedVariables, defaults, defaultProfile)
    local db = {
        profile = {},
        char = {},
        realm = {},
        global = {}
    }
    
    -- Copy defaults
    if defaults then
        for k, v in pairs(defaults) do
            db[k] = db[k] or {}
            for dk, dv in pairs(v) do
                db[k][dk] = dv
            end
        end
    end
    
    db.RegisterDefaults = function() end
    db.ResetProfile = function() end
    
    return db
end