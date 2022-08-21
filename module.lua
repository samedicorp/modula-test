-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Created by Samedi on 20/08/2022.
--  All code (c) 2022, The Samedi Corporation.
-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

local Module = { }

function Module:register(modula, parameters)
    self.called = {}

    modula:registerForEvents({"onStart", "onStop", "onCommand", "onFlush", "onUpdate", "onSlowUpdate", "onFastUpdate"}, self)
    modula:registerService("test", self)
end

-- ---------------------------------------------------------------------
-- Example event handlers
-- ---------------------------------------------------------------------

function Module:onStart()
    debug("Test module was started")

    local panels = self.modula:getService("panels")
    if panels then
        print("found panels service")
        panels:addPanel("test", "Test")
        panels:addWidgets("test", "text", { 
            "velocity", "acceleration", "altitude", "target", "braking", "stall", "fuel"
        })
    end

    player.freeze(1)
end

function Module:onStop()
    debug("Test module was stopped")
end

function Module:onCommand(command, arguments)
    if command == "test" then
        print("Hello from the test module")
    end
end

function Module:onFastUpdate()
    self:reportCalled("onFastUpdate")
end

function Module:onSlowUpdate()
    self:reportCalled("onSlowUpdate")
end

function Module:onFlush()
    self:reportCalled("onFlush")
end

function Module:onUpdate()
    self:reportCalled("onUpdate")
end


-- ---------------------------------------------------------------------
-- Example action handlers
-- ---------------------------------------------------------------------

function Module:startTest()
    print("test action started")
end

function Module:stopTest()
    print("test action stopped")
end

function Module:startStopTest(action)
    print("test action %s", action)
end

function Module:loopTest()
    print("test looping")
end

function Module:normalPressTest()
    print("normal press")
end

function Module:longPressTest()
    print("long press")
end

-- ---------------------------------------------------------------------

function Module:reportCalled(handler)
    if not self.called[handler] then
        self.called[handler] = true
        print("%s called", handler)
    end
end

return Module