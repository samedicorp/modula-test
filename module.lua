-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Created by Samedi on 20/08/2022.
--  All code (c) 2022, The Samedi Corporation.
-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

local Module = { }

function Module:register(modula, parameters)
    modula:registerForEvents({"onStart", "onStop", "onCommand"}, self)
    modula:registerService("test", self)
end

function Module:onStart()
    debug("Test module was started")
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


return Module