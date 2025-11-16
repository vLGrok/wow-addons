local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:NewLocale("SuperScribe", "enUS", true)
if not L then return end

-- Main Interface
L["SuperScribe"] = "SuperScribe"
L["A powerful scribing and note-taking addon for World of Warcraft"] = "A powerful scribing and note-taking addon for World of Warcraft"

-- Menu and Buttons
L["Open SuperScribe"] = "Open SuperScribe"
L["Close"] = "Close"
L["Save"] = "Save" 
L["Clear"] = "Clear"
L["New Note"] = "New Note"
L["Delete Note"] = "Delete Note"

-- Configuration
L["General"] = "General"
L["Minimap Button"] = "Minimap Button"
L["Show minimap button"] = "Show minimap button"
L["Lock minimap button"] = "Lock minimap button"
L["Font Size"] = "Font Size"
L["Window Scale"] = "Window Scale"

-- Notes
L["Notes"] = "Notes"
L["Note Title"] = "Note Title"
L["Note Content"] = "Note Content"
L["Enter note title..."] = "Enter note title..."
L["Enter your note content here..."] = "Enter your note content here..."
L["No notes created yet"] = "No notes created yet"

-- Messages
L["Note saved!"] = "Note saved!"
L["Note deleted!"] = "Note deleted!"
L["Cannot delete note: Please select a note first"] = "Cannot delete note: Please select a note first"
L["SuperScribe loaded successfully!"] = "SuperScribe loaded successfully!"

-- Chat Commands
L["SuperScribe Commands:"] = "SuperScribe Commands:"
L["show - Show the main window"] = "show - Show the main window"
L["hide - Hide the main window"] = "hide - Hide the main window"
L["config - Open configuration"] = "config - Open configuration"