-- MoP Helper - A simple addon for Mists of Pandaria Classic
local addonName, addon = ...

-- Create addon frame
local frame = CreateFrame("Frame")
addon.frame = frame

-- Default settings
local defaults = {
    welcomeMessage = true,
    showCoordinates = false,
}

-- Initialize saved variables
function addon:InitializeDB()
    if not MoPHelperDB then
        MoPHelperDB = {}
    end
    
    for key, value in pairs(defaults) do
        if MoPHelperDB[key] == nil then
            MoPHelperDB[key] = value
        end
    end
end

-- Event handler
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        addon:InitializeDB()
    elseif event == "PLAYER_LOGIN" then
        addon:OnPlayerLogin()
    end
end)

-- Player login handler
function addon:OnPlayerLogin()
    if MoPHelperDB.welcomeMessage then
        print("|cff00ff00MoP Helper|r: Welcome to Mists of Pandaria Classic!")
        print("|cff00ff00MoP Helper|r: Type /mophelper for available commands")
    end
end

-- Slash command handler
SLASH_MOPHELPER1 = "/mophelper"
SLASH_MOPHELPER2 = "/moph"
SlashCmdList["MOPHELPER"] = function(msg)
    msg = msg:lower():trim()
    
    if msg == "" or msg == "help" then
        print("|cff00ff00MoP Helper Commands:|r")
        print("  /mophelper help - Show this help message")
        print("  /mophelper welcome - Toggle welcome message")
        print("  /mophelper coords - Toggle coordinate display")
        print("  /mophelper version - Show addon version")
    elseif msg == "welcome" then
        MoPHelperDB.welcomeMessage = not MoPHelperDB.welcomeMessage
        if MoPHelperDB.welcomeMessage then
            print("|cff00ff00MoP Helper|r: Welcome message enabled")
        else
            print("|cff00ff00MoP Helper|r: Welcome message disabled")
        end
    elseif msg == "coords" then
        MoPHelperDB.showCoordinates = not MoPHelperDB.showCoordinates
        if MoPHelperDB.showCoordinates then
            print("|cff00ff00MoP Helper|r: Coordinate display enabled")
            addon:EnableCoordinates()
        else
            print("|cff00ff00MoP Helper|r: Coordinate display disabled")
            addon:DisableCoordinates()
        end
    elseif msg == "version" then
        print("|cff00ff00MoP Helper|r: Version 1.0.0")
    else
        print("|cff00ff00MoP Helper|r: Unknown command. Type /mophelper help for available commands")
    end
end

-- Coordinate display
local coordFrame
function addon:EnableCoordinates()
    if not coordFrame then
        coordFrame = CreateFrame("Frame", "MoPHelperCoordFrame", UIParent)
        coordFrame:SetSize(120, 20)
        coordFrame:SetPoint("TOP", UIParent, "TOP", 0, -5)
        
        coordFrame.text = coordFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        coordFrame.text:SetPoint("CENTER")
        coordFrame.text:SetTextColor(1, 1, 1)
        
        coordFrame:SetScript("OnUpdate", function(self, elapsed)
            self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
            if self.timeSinceLastUpdate >= 0.1 then
                local x, y = GetPlayerMapPosition("player")
                if x and y then
                    self.text:SetText(string.format("%.1f, %.1f", x * 100, y * 100))
                else
                    self.text:SetText("---, ---")
                end
                self.timeSinceLastUpdate = 0
            end
        end)
    end
    coordFrame:Show()
end

function addon:DisableCoordinates()
    if coordFrame then
        coordFrame:Hide()
    end
end

-- Initialize coordinates if enabled
if MoPHelperDB and MoPHelperDB.showCoordinates then
    addon:EnableCoordinates()
end
