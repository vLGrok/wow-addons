-- LibDBIcon-1.0 stub
-- This provides minimap button functionality

local LibDBIcon = LibStub:NewLibrary("LibDBIcon-1.0", 1)
if not LibDBIcon then return end

LibDBIcon.objects = {}
LibDBIcon.callbacks = {}

function LibDBIcon:Register(name, object, db)
    self.objects[name] = {
        object = object,
        db = db
    }
end

function LibDBIcon:Show(name)
    if self.objects[name] then
        print("Showing minimap button for " .. name)
    end
end

function LibDBIcon:Hide(name)
    if self.objects[name] then
        print("Hiding minimap button for " .. name)
    end
end

function LibDBIcon:IsRegistered(name)
    return self.objects[name] ~= nil
end