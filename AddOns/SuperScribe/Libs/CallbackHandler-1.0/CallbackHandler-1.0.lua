-- CallbackHandler-1.0 stub
-- This is a stub - download the real CallbackHandler from Ace3

local lib = LibStub:NewLibrary("CallbackHandler-1.0", 1)
if not lib then return end

-- Stub implementation
lib.callbacks = {}

function lib:New()
    return {
        RegisterCallback = function() end,
        UnregisterCallback = function() end,
        FireCallback = function() end
    }
end