-- SuperScribe Main File
-- A powerful scribing and note-taking addon for World of Warcraft Classic (Mists of Pandaria)

local SuperScribe = LibStub("AceAddon-3.0"):NewAddon("SuperScribe", "AceConsole-3.0", "AceEvent-3.0")
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("SuperScribe")

-- Version info
SuperScribe.version = "1.0.0"
SuperScribe.build = "001"

function SuperScribe:OnInitialize()
    -- Initialize the database
    self:InitializeDatabase()
    
    -- Setup configuration
    self:SetupConfig()
    
    -- Register chat commands
    self:RegisterChatCommand("superscribe", "SlashCommand")
    self:RegisterChatCommand("ss", "SlashCommand")
    
    -- Print load message
    self:Print(L["SuperScribe loaded successfully!"])
end

function SuperScribe:OnEnable()
    -- Initialize minimap button
    self:InitializeMinimapButton()
    
    -- Register any events we need
    self:RegisterEvent("ADDON_LOADED")
end

-- Minimap button functionality
function SuperScribe:InitializeMinimapButton()
    local LibDBIcon = LibStub("LibDBIcon-1.0", true)
    if not LibDBIcon then return end
    
    -- Create minimap button data object
    local minimapButton = {
        type = "data source",
        text = "SuperScribe",
        icon = "Interface\\Icons\\INV_Misc_Note_01", -- Classic note icon
        OnClick = function(self, button)
            if button == "LeftButton" then
                SuperScribe:ToggleMainWindow()
            elseif button == "RightButton" then
                SuperScribe:OpenConfig()
            end
        end,
        OnTooltipShow = function(tooltip)
            if not tooltip or not tooltip.AddLine then return end
            tooltip:AddLine("SuperScribe")
            tooltip:AddLine(L["A powerful scribing and note-taking addon for World of Warcraft"], 1, 1, 1)
            tooltip:AddLine(" ")
            tooltip:AddLine("|cffffff00Left-click:|r " .. L["Open SuperScribe"], 0.8, 0.8, 0.8)
            tooltip:AddLine("|cffffff00Right-click:|r " .. L["config - Open configuration"], 0.8, 0.8, 0.8)
        end,
    }
    
    -- Register with LibDBIcon
    LibDBIcon:Register("SuperScribe", minimapButton, self.db.profile.minimap)
    
    -- Store reference
    self.minimapButton = minimapButton
    
    -- Set initial visibility
    self:UpdateMinimapButton()
end

function SuperScribe:UpdateMinimapButton()
    local LibDBIcon = LibStub("LibDBIcon-1.0", true)
    if not LibDBIcon then return end
    
    if self.db.profile.minimap.hide then
        LibDBIcon:Hide("SuperScribe")
    else
        LibDBIcon:Show("SuperScribe")
    end
end

function SuperScribe:OnDisable()
    -- Clean up when addon is disabled
    if self.GUI then
        self.GUI:HideMainWindow()
    end
end

-- Event handlers
function SuperScribe:ADDON_LOADED(event, addonName)
    if addonName == "SuperScribe" then
        -- Addon fully loaded, perform any post-load setup
        self:PerformPostLoadSetup()
    end
end

function SuperScribe:PerformPostLoadSetup()
    -- Any setup that needs to happen after all addons are loaded
    -- This is where you'd initialize things that depend on other addons
end

-- Chat command handler
function SuperScribe:SlashCommand(input)
    if not input or input:trim() == "" then
        self.GUI:ToggleMainWindow()
    else
        local cmd = input:lower():trim()
        if cmd == "show" then
            self.GUI:ShowMainWindow()
        elseif cmd == "hide" then
            self.GUI:HideMainWindow()
        elseif cmd == "config" then
            self:OpenConfig()
        elseif cmd == "help" then
            self:ShowHelp()
        else
            self.GUI:ToggleMainWindow()
        end
    end
end

function SuperScribe:ShowHelp()
    self:Print(L["SuperScribe Commands:"])
    self:Print("  /ss " .. L["show - Show the main window"])
    self:Print("  /ss " .. L["hide - Hide the main window"]) 
    self:Print("  /ss " .. L["config - Open configuration"])
end

-- Public API functions
function SuperScribe:ShowMainWindow()
    if self.GUI then
        self.GUI:ShowMainWindow()
    end
end

function SuperScribe:HideMainWindow()
    if self.GUI then
        self.GUI:HideMainWindow()
    end
end

function SuperScribe:ToggleMainWindow()
    if self.GUI then
        self.GUI:ToggleMainWindow()
    end
end

-- Utility functions
function SuperScribe:Print(...)
    -- Use AceConsole's print function with addon name prefix
    self:Printf("|cff00ff00SuperScribe:|r %s", table.concat({...}, " "))
end

function SuperScribe:Printf(...)
    -- Print with formatting
    DEFAULT_CHAT_FRAME:AddMessage(string.format(...))
end

-- Debug function (can be removed in release)
function SuperScribe:Debug(...)
    if self.db and self.db.profile.debug then
        self:Printf("|cffff0000[DEBUG]|r %s", table.concat({...}, " "))
    end
end