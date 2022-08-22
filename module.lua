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

    self.elapsed = 1

    local panels = self.modula:getService("panels")
    if panels then
        print("found panels service")
        self.panel = panels:addPanel("test", "Test")
        self.widgets = self.panel:addWidgets({
            foo = { value = "This is some text" },
            bar = { label = "Speed", units = "m/s" },
            elapsed = { label = "Time" }
        })

        self.widgets.bar:update(1.23)
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
    self.elapsed = self.elapsed + 1
    self.widgets.elapsed:updateTime(self.elapsed)
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