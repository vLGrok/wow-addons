-- AceConfig-3.0 stub
local AceConfig = LibStub:NewLibrary("AceConfig-3.0", 1)
if not AceConfig then return end

function AceConfig:RegisterOptionsTable(name, options)
    -- Stub implementation
end

AceConfigRegistry = LibStub:NewLibrary("AceConfigRegistry-3.0", 1)
AceConfigDialog = LibStub:NewLibrary("AceConfigDialog-3.0", 1)

AceConfigDialog.OpenFrames = {}
function AceConfigDialog:Open(name) end
function AceConfigDialog:Close(name) end
function AceConfigDialog:AddToBlizOptions(name, displayName) end