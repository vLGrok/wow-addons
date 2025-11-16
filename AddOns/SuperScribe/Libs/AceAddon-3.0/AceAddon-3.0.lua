-- AceAddon-3.0 stub
-- This is a stub - download the real AceAddon from Ace3

local AceAddon = LibStub:NewLibrary("AceAddon-3.0", 1)
if not AceAddon then return end

function AceAddon:NewAddon(name, ...)
    local addon = {
        name = name,
        modules = {},
        defaults = {}
    }
    
    addon.OnInitialize = function() end
    addon.OnEnable = function() end
    addon.OnDisable = function() end
    
    -- Mix in other Ace libraries
    for i = 1, select('#', ...) do
        local lib = select(i, ...)
        if type(lib) == "string" then
            local realLib = LibStub(lib, true)
            if realLib then
                for k, v in pairs(realLib) do
                    addon[k] = v
                end
            end
        end
    end
    
    return addon
end

-- Register as a global for backward compatibility
if not AceAddon then
    AceAddon = AceAddon
end