-- LibStub is a simple library for addon developers
-- This is a stub - download the real LibStub from https://www.curseforge.com/wow/addons/libstub

if not LibStub then
    local LIBSTUB_MAJOR, LIBSTUB_MINOR = "LibStub", 2
    local lib = {}
    local libs = {}
    
    function lib:GetLibrary(major, silent)
        if not libs[major] and not silent then
            error(("Cannot find a library instance of %q."):format(tostring(major)), 2)
        end
        return libs[major]
    end
    
    function lib:NewLibrary(major, minor)
        if not major or not minor then return end
        libs[major] = libs[major] or {}
        return libs[major]
    end
    
    -- Store the library in the global namespace
    LibStub = lib
end