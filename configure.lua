local useLocal = false --export: Use locally installed scripts if present.
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
