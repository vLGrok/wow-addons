-- AceGUI-3.0 stub
local AceGUI = LibStub:NewLibrary("AceGUI-3.0", 1)
if not AceGUI then return end

function AceGUI:Create(widgetType)
    local widget = {
        type = widgetType,
        SetText = function() end,
        GetText = function() return "" end,
        SetCallback = function() end,
        AddChild = function() end,
        SetLayout = function() end,
        Show = function() end,
        Hide = function() end,
        Release = function() end
    }
    return widget
end