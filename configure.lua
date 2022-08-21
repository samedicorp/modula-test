local useLocal = true --export: Use require() to load local scripts if present. Useful during development.
local logging = true --export: Enable controller debug output.
local logElements = true --export: Log all discovered elements.

modulaSettings = { 
    name = "Test Construct",
    version = "1.0",
    logging = logging, 
    logElements = logElements, 
    useLocal = useLocal,
    modules = {
        ["samedicorp.modula-test.module"] = {},
        ["samedicorp.modula.modules.panels"] = {},
        ["samedicorp.modula.modules.screen"] = {}
    },
    actions = {
        brake = {
            target = "test",
            start = "startTest",
            stop = "stopTest"
        },


        option1 = {
            target = "test",
            onoff = "startStopTest",
        },

        option2 = {
            target = "test",
            loop = "loopTest"
        },

        gear = {
            target = "test",
            stop = "normalPressTest",
            long = "longPressTest"
        },
    }
}
