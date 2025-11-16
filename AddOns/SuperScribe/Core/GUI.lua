local SuperScribe = LibStub("AceAddon-3.0"):GetAddon("SuperScribe")
local AceGUI = LibStub("AceGUI-3.0")
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("SuperScribe")

local GUI = {}
SuperScribe.GUI = GUI

-- Main window reference
local mainFrame = nil
local notesList = nil
local noteTitle = nil
local noteContent = nil
local currentNoteId = nil

function GUI:CreateMainWindow()
    if mainFrame then
        mainFrame:Show()
        return
    end
    
    -- Create the main frame
    mainFrame = AceGUI:Create("Frame")
    mainFrame:SetTitle(L["SuperScribe"])
    mainFrame:SetWidth(600)
    mainFrame:SetHeight(450)
    mainFrame:SetLayout("Fill")
    
    -- Position the window
    local profile = SuperScribe:GetProfile()
    if profile.ui.windowPosition then
        mainFrame:SetPoint(
            profile.ui.windowPosition.point or "CENTER",
            UIParent,
            profile.ui.windowPosition.point or "CENTER",
            profile.ui.windowPosition.x or 0,
            profile.ui.windowPosition.y or 0
        )
    end
    
    -- Apply window scale
    mainFrame:SetScale(profile.ui.windowScale or 1.0)
    
    -- Create content container
    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Border")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    mainFrame:AddChild(container)
    
    -- Create left panel for notes list
    local leftPanel = AceGUI:Create("SimpleGroup")
    leftPanel:SetWidth(200)
    leftPanel:SetLayout("Flow")
    container:AddChild(leftPanel)
    container:SetUserData("left", leftPanel)
    
    -- Notes list header
    local notesHeader = AceGUI:Create("Heading")
    notesHeader:SetText(L["Notes"])
    notesHeader:SetFullWidth(true)
    leftPanel:AddChild(notesHeader)
    
    -- New note button
    local newNoteBtn = AceGUI:Create("Button")
    newNoteBtn:SetText(L["New Note"])
    newNoteBtn:SetFullWidth(true)
    newNoteBtn:SetCallback("OnClick", function() GUI:CreateNewNote() end)
    leftPanel:AddChild(newNoteBtn)
    
    -- Delete note button
    local deleteNoteBtn = AceGUI:Create("Button")
    deleteNoteBtn:SetText(L["Delete Note"])
    deleteNoteBtn:SetFullWidth(true)
    deleteNoteBtn:SetCallback("OnClick", function() GUI:DeleteSelectedNote() end)
    leftPanel:AddChild(deleteNoteBtn)
    
    -- Notes list
    notesList = AceGUI:Create("ScrollFrame")
    notesList:SetFullWidth(true)
    notesList:SetFullHeight(true)
    notesList:SetLayout("Flow")
    leftPanel:AddChild(notesList)
    
    -- Create right panel for note editing
    local rightPanel = AceGUI:Create("SimpleGroup")
    rightPanel:SetLayout("Flow")
    rightPanel:SetFullWidth(true)
    rightPanel:SetFullHeight(true)
    container:AddChild(rightPanel)
    container:SetUserData("right", rightPanel)
    
    -- Note title input
    noteTitle = AceGUI:Create("EditBox")
    noteTitle:SetLabel(L["Note Title"])
    noteTitle:SetFullWidth(true)
    noteTitle:SetText("")
    noteTitle:SetCallback("OnTextChanged", function() GUI:OnNoteChanged() end)
    rightPanel:AddChild(noteTitle)
    
    -- Note content
    noteContent = AceGUI:Create("MultiLineEditBox")
    noteContent:SetLabel(L["Note Content"])
    noteContent:SetFullWidth(true)
    noteContent:SetFullHeight(true)
    noteContent:SetText("")
    noteContent:SetCallback("OnTextChanged", function() GUI:OnNoteChanged() end)
    rightPanel:AddChild(noteContent)
    
    -- Save button
    local saveBtn = AceGUI:Create("Button")
    saveBtn:SetText(L["Save"])
    saveBtn:SetWidth(100)
    saveBtn:SetCallback("OnClick", function() GUI:SaveCurrentNote() end)
    rightPanel:AddChild(saveBtn)
    
    -- Store reference
    SuperScribe.mainFrame = mainFrame
    
    -- Load notes list
    GUI:RefreshNotesList()
    
    -- Show empty note initially
    GUI:ShowNote(nil)
end

function GUI:ShowMainWindow()
    if not mainFrame then
        GUI:CreateMainWindow()
    else
        mainFrame:Show()
    end
end

function GUI:HideMainWindow()
    if mainFrame then
        mainFrame:Hide()
    end
end

function GUI:ToggleMainWindow()
    if mainFrame and mainFrame.frame:IsShown() then
        GUI:HideMainWindow()
    else
        GUI:ShowMainWindow()
    end
end

function GUI:RefreshNotesList()
    if not notesList then return end
    
    -- Clear existing list
    notesList:ReleaseChildren()
    
    local notes = SuperScribe:GetAllNotes()
    
    if #notes == 0 then
        local noNotesLabel = AceGUI:Create("Label")
        noNotesLabel:SetText(L["No notes created yet"])
        noNotesLabel:SetFullWidth(true)
        notesList:AddChild(noNotesLabel)
        return
    end
    
    for _, note in ipairs(notes) do
        local noteButton = AceGUI:Create("Button")
        noteButton:SetText(note.title or L["Untitled"])
        noteButton:SetFullWidth(true)
        noteButton:SetCallback("OnClick", function() GUI:ShowNote(note.id) end)
        notesList:AddChild(noteButton)
    end
end

function GUI:ShowNote(noteId)
    currentNoteId = noteId
    
    if noteId then
        local note = SuperScribe:GetNote(noteId)
        if note then
            noteTitle:SetText(note.title or "")
            noteContent:SetText(note.content or "")
        end
    else
        -- Show empty note
        noteTitle:SetText("")
        noteContent:SetText("")
    end
end

function GUI:CreateNewNote()
    currentNoteId = nil
    noteTitle:SetText("")
    noteContent:SetText("")
    noteTitle:SetFocus()
end

function GUI:SaveCurrentNote()
    local title = noteTitle:GetText() or ""
    local content = noteContent:GetText() or ""
    
    if title == "" and content == "" then
        return
    end
    
    if title == "" then
        title = L["Untitled"]
    end
    
    currentNoteId = SuperScribe:SaveNote(currentNoteId, title, content)
    GUI:RefreshNotesList()
    SuperScribe:Print(L["Note saved!"])
end

function GUI:DeleteSelectedNote()
    if not currentNoteId then
        SuperScribe:Print(L["Cannot delete note: Please select a note first"])
        return
    end
    
    SuperScribe:DeleteNote(currentNoteId)
    GUI:RefreshNotesList()
    GUI:CreateNewNote()
    SuperScribe:Print(L["Note deleted!"])
end

function GUI:OnNoteChanged()
    -- Auto-save could be implemented here
    -- For now, we'll just mark that changes exist
end