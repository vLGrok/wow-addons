-- AceLocale-3.0 stub
local AceLocale = LibStub:NewLibrary("AceLocale-3.0", 1)
if not AceLocale then return end

function AceLocale:NewLocale(application, locale, isDefault)
    return setmetatable({}, {
        __newindex = function(t, k, v) rawset(t, k, v) end,
        __index = function(t, k) return k end
    })
end

function AceLocale:GetLocale(application)
    return setmetatable({}, {
        __index = function(t, k) return k end
    })
end