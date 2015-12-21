require("IceDice/IceDice")

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    print("IceDice: onTextMessageEvent: " .. serverConnectionHandlerID .. " " .. targetMode .. " " .. toID .. " " .. fromID .. " " .. fromName .. " " .. fromUniqueIdentifier .. " " .. message .. " " .. ffIgnored)

    local rollCheck = string.sub(message,1,4)
    local rollingCheck = string.sub(message,1,7)
    if rollCheck == "roll" and rollingCheck ~="rolling" then
        --Get clientID
        local clientID, error = ts3.getClientID(serverConnectionHandlerID)
        print("ICEDICE: clientID = "..clientID..", fromID = "..fromID)
        if error ~= ts3errors.ERROR_ok then
            print("Error getting own client ID: " .. error)
            return
        end
        if myClientID == 0 then
            ts3.printMessageToCurrentTab("Not connected")
            return
        end
--IF YOU DON'T WANT OTHER PEOPLE TO ROLL REMOVE THE -- ON THE NEXT LINE ONLY
        --if clientID == fromID then 
            --Get channelID
            local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
            print(channelID)
            if error ~= ts3errors.ERROR_ok then
                print("Error getting channelID: " .. error)
                return
            end

            local returnMsg = IceDice.diceRoller(message, fromName, clientID, fromID)

            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, returnMsg, channelID)
--IF YOU DON'T WANT OTHER PEOPLE TO ROLL REMOVE THE -- ON THE NEXT LINE ONLY
        --end
    end
    return 0
end

IceDice_events = {
    onTextMessageEvent = onTextMessageEvent
}
