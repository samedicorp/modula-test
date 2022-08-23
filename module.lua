-- -=module.lua-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Created by Samedi on 20/08/2022.
--  All code (c) 2022, The Samedi Corporation.
-- -=module.lua-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

local Module = { }

function Module:register(modula, parameters)
    self.called = {}
    self.elapsed = 1

    modula:registerForEvents({"onStart", "onStop", "onCommand", "onFlush", "onUpdate", "onSlowUpdate", "onFastUpdate"}, self)
    modula:registerService("test", self)
end

-- ---------------------------------------------------------------------
-- Example event handlers
-- ---------------------------------------------------------------------

function Module:onStart()
    debugf("Test module was started")

    local panels = self.modula:getService("panels")
    if panels then
        self.panel = panels:addPanel("test", "Test")
        self.widgets = self.panel:addWidgets({
            foo = { value = "This is some text" },
            bar = { label = "Speed", units = "m/s" },
            elapsed = { label = "Time" }
        })

        self.widgets.bar:update(1.23)
    end

    local screen = self.modula:getService("screen")
    if screen then
        local window = self._window
        window.width = window.width or "4vw"
        window.height = window.height or "12vw"
        window.position = window.position or "absolute"
        window.content = ""
        window.name = "airspeed"
    
        screen:addWindow(window)
    end

    player.freeze(1)
end

function Module:onStop()
    debugf("Test module was stopped")
end

function Module:onCommand(command, arguments)
    if command == "test" then
        printf("Hello from the test module")
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
    printf("test action started")
end

function Module:stopTest()
    printf("test action stopped")
end

function Module:startStopTest(action)
    printf("test action %s", action)
end

function Module:loopTest()
    printf("test looping")
end

function Module:normalPressTest()
    printf("normal press")
end

function Module:longPressTest()
    printf("long press")
end

-- ---------------------------------------------------------------------

function Module:reportCalled(handler)
    -- if not self.called[handler] then
    --     self.called[handler] = true
    --     printf("%s called", handler)
    -- end
end

return Module