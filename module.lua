-- -=module.lua-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Created by Samedi on 20/08/2022.
--  All code (c) 2022, The Samedi Corporation.
-- -=module.lua-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

local Module = { }

function Module:register(modula, parameters)
    self.called = {}
    self.elapsed = 1
    self.altitude = 1234

    self.window = {
        left = parameters.left or "2vw",
        top = parameters.top or "9vh",
        width = parameters.width or "4vw",
        height = parameters.height or "12vw",
        position = parameters.position or "absolute",
        name = "Test Window",
    }

    modula:registerForEvents(self, "onStart", "onStop", "onCommand", "onFlush", "onUpdate", "onSlowUpdate", "onFastUpdate", "onUpdateWindows")
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

    local windows = self.modula:getService("windows")
    if windows then
        windows:addWindow(self.window)
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

function Module:onUpdateWindows(windows)
    local html = [[
        <style>
        .altimeter .label  { text-anchor: start; }
        .altimeter .value { text-anchor: end; }
        </style>

        <svg class="altimeter" width='%s' height='%s' viewbox='0 0 220 1000'>
            %s
            <line class="margin" x1="0" y1="0" x2="0" y2="1000" />
            <path class="box" d="M20 500 L70 530 L220 530 L220 470 L70 470 L20 500" />
            <text class="value" x="200" y="500">%s</text>
        </svg> 
    ]]

    local altitude = 199

    local step
    local altAbs = math.abs(altitude)
    if altAbs < 1000 then
        step = 10
    elseif altAbs < 10000 then
        step = 100
    else
        step = 1000
    end
    local altFloor = math.floor(altitude/step)*step
    local altMin = altFloor - (step * 5)
    local offset = ((altitude - altFloor) * 100) / step

    local lines = {}
    local label = altMin
    for n = 0, 1000, 100 do
        local line = string.format('<line class="mark" x1="0" y1="%s" x2="30" y2="%s" /><text class="label" x="40" y="%s">%s</text>', n + offset, n + offset, (1000 - n) + 8 + offset, label)
        label = label + step
        table.insert(lines, line)
    end
    local linesHTML = table.concat(lines, "\n")

    local window = self.window
    local content = html:format(window.width, window.height, linesHTML, math.floor(altitude))
    window:update(content)
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