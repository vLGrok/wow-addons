-- AceEvent-3.0 stub
local AceEvent = LibStub:NewLibrary("AceEvent-3.0", 1)
if not AceEvent then return end

function AceEvent:RegisterEvent(event, handler) end
function AceEvent:UnregisterEvent(event) end
function AceEvent:RegisterMessage(message, handler) end
function AceEvent:UnregisterMessage(message) end
function AceEvent:SendMessage(message, ...) end