local useLocal = false --export: Use require() to load local scripts if present. Useful during development.
local logging = false --export: Enable controller debug output.
local logElements = false --export: Log all discovered elements.

modulaSettings = { 
    name = "Test Construct",
    logging = logging, 
    logElements = logElements, 
    useLocal = useLocal,
    modules = {
        ["samedicorp.modula-test.module"] = {}
    }
}
