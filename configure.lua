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
    },
    actions = {
        speeddown = {
            target = "throttle",
            loop = "decreaseThrottle"
        },

        speedup = {
            target = "throttle",
            loop = "increaseThrottle"
        },

        stopengines = {
            target = "throttle",
            start = "stopEngines"
        },

        brake = {
            target = "braking",
            start = "activateBrake",
            stop = "deactivateBrake"
        },

        yawleft = {
            target = "impulse",
            onoff = "yawLeft",
        },

        yawright = {
            target = "impulse",
            onoff = "yawRight"
        },

        strafeleft = {
            target = "impulse",
            onoff = "strafeLeft"
        },

        straferight = {
            target = "impulse",
            onoff = "strafeRight"
        },

        right = {
            target = "impulse",
            onoff = "rollRight",
        },

        left = {
            target = "impulse",
            onoff = "rollLeft",
        },

        forward = {
            target = "impulse",
            onoff = "pitchDown",
        },

        backward = {
            target = "impulse",
            onoff = "pitchUp",
        },

        up = {
            target = "impulse",
            onoff = "up"
        },

        down = {
            target = "impulse",
            onoff = "down"
        },

        groundaltitudeup = {
            target = "stabilisation",
            loop = "raiseTarget"
        },

        groundaltitudedown = {
            target = "stabilisation",
            loop = "lowerTarget"
        },

        gear = {
            target = "parking",
            stop = "toggleLanding",
            long = "forceLanding"
        },

        warp = {
            target = "warp",
            start = "activate"
        },
        
        option1 = {
            target = "display",
            start = "menuPrevious"
        },

        option2 = {
            target = "display",
            start = "menuNext"
        },

        option3 = {
            target = "display",
            start = "menuSelect"
        },

        option4 = {
            target = "display",
            start = "menuBack"
        },

        option5 = {
            target = "bookmarks",
            stop = "nextWaypoint",
            long = "storeWaypoint"

        }
    }
}
