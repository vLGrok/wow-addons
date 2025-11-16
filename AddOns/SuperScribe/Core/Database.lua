local SuperScribe = LibStub("AceAddon-3.0"):GetAddon("SuperScribe")
local AceDB = LibStub("AceDB-3.0")

-- Default database structure
local defaults = {
    profile = {
        minimap = {
            hide = false,
            lock = false,
            minimapPos = 220,
        },
        ui = {
            fontSize = 12,
            windowScale = 1.0,
            windowPosition = {
                point = "CENTER",
                x = 0,
                y = 0
            }
        },
        notes = {}
    }
}

function SuperScribe:InitializeDatabase()
    self.db = AceDB:New("SuperScribeDB", defaults, true)
    
    -- Migration functions can be added here if needed
    self:MigrateSettings()
end

function SuperScribe:MigrateSettings()
    -- Handle any database migrations between versions
    if not self.db.profile.version then
        self.db.profile.version = "1.0.0"
    end
end

function SuperScribe:GetNote(noteId)
    return self.db.profile.notes[noteId]
end

function SuperScribe:SaveNote(noteId, title, content)
    if not noteId then
        noteId = "note_" .. time() .. "_" .. math.random(1000, 9999)
    end
    
    self.db.profile.notes[noteId] = {
        id = noteId,
        title = title or "Untitled",
        content = content or "",
        created = time(),
        modified = time()
    }
    
    return noteId
end

function SuperScribe:DeleteNote(noteId)
    if self.db.profile.notes[noteId] then
        self.db.profile.notes[noteId] = nil
        return true
    end
    return false
end

function SuperScribe:GetAllNotes()
    local notes = {}
    for id, note in pairs(self.db.profile.notes) do
        table.insert(notes, note)
    end
    
    -- Sort by creation date
    table.sort(notes, function(a, b) 
        return a.created > b.created 
    end)
    
    return notes
end

function SuperScribe:GetProfile()
    return self.db.profile
end