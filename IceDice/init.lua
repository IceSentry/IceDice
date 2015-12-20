--
-- IceSentry's dice init file
--

require("ts3init")
require("IceDice/events")
require("IceDice/IceDice")

local MODULE_NAME = "IceDice"

local registeredEvents = {
    onTextMessageEvent = IceDice_events.onTextMessageEvent
}

ts3RegisterModule("IceDice", registeredEvents)
