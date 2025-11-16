local SuperScribe = LibStub("AceAddon-3.0"):GetAddon("SuperScribe")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("SuperScribe")

-- Configuration options table
local options = {
    name = "SuperScribe",
    handler = SuperScribe,
    type = "group",
    args = {
        general = {
            type = "group",
            name = L["General"],
            order = 1,
            args = {
                desc = {
                    type = "description",
                    name = L["A powerful scribing and note-taking addon for World of Warcraft"],
                    order = 1,
                },
                header1 = {
                    type = "header",
                    name = L["Minimap Button"],
                    order = 10,
                },
                minimapHide = {
                    type = "toggle",
                    name = L["Show minimap button"],
                    desc = L["Show minimap button"],
                    order = 11,
                    get = function() return not SuperScribe.db.profile.minimap.hide end,
                    set = function(info, value) 
                        SuperScribe.db.profile.minimap.hide = not value
                        SuperScribe:UpdateMinimapButton()
                    end,
                },
                minimapLock = {
                    type = "toggle",
                    name = L["Lock minimap button"],
                    desc = L["Lock minimap button"],
                    order = 12,
                    get = function() return SuperScribe.db.profile.minimap.lock end,
                    set = function(info, value) 
                        SuperScribe.db.profile.minimap.lock = value
                        SuperScribe:UpdateMinimapButton()
                    end,
                },
                header2 = {
                    type = "header",
                    name = "Interface",
                    order = 20,
                },
                fontSize = {
                    type = "range",
                    name = L["Font Size"],
                    desc = L["Font Size"],
                    order = 21,
                    min = 8,
                    max = 24,
                    step = 1,
                    get = function() return SuperScribe.db.profile.ui.fontSize end,
                    set = function(info, value) 
                        SuperScribe.db.profile.ui.fontSize = value
                        SuperScribe:UpdateFontSize()
                    end,
                },
                windowScale = {
                    type = "range",
                    name = L["Window Scale"],
                    desc = L["Window Scale"],
                    order = 22,
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function() return SuperScribe.db.profile.ui.windowScale end,
                    set = function(info, value) 
                        SuperScribe.db.profile.ui.windowScale = value
                        SuperScribe:UpdateWindowScale()
                    end,
                },
            },
        },
    },
}

function SuperScribe:SetupConfig()
    -- Register the options table
    AceConfig:RegisterOptionsTable("SuperScribe", options, {"superscribe", "ss"})
    
    -- Add to Blizzard Interface Options
    self.optionsFrame = AceConfigDialog:AddToBlizOptions("SuperScribe", "SuperScribe")
end

function SuperScribe:OpenConfig()
    -- Open the configuration panel
    AceConfigDialog:Open("SuperScribe")
end

-- Callback functions for configuration changes
function SuperScribe:UpdateMinimapButton()
    -- This will be implemented when we create the minimap button
    if self.minimapButton then
        if self.db.profile.minimap.hide then
            self.minimapButton:Hide()
        else
            self.minimapButton:Show()
        end
    end
end

function SuperScribe:UpdateFontSize()
    -- This will be implemented when we create the GUI
    if self.mainFrame and self.mainFrame.noteContent then
        local font, _, flags = self.mainFrame.noteContent:GetFont()
        self.mainFrame.noteContent:SetFont(font, self.db.profile.ui.fontSize, flags)
    end
end

function SuperScribe:UpdateWindowScale()
    -- This will be implemented when we create the GUI
    if self.mainFrame then
        self.mainFrame:SetScale(self.db.profile.ui.windowScale)
    end
end