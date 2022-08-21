local devMode = true --export: Use locally installed scripts if present.
local logging = true --export: Enable controller debug output.
local logElements = true --export: Log all discovered elements.

modulaSettings = { 
    logging = logging, 
    logElements = logElements, 
    devMode = devMode,
    modules = {
        ["samedicorp.modula-test.module"] = {}
    }
}
