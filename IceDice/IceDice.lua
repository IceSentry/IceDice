local printIceDice = function(message)
    print("\n[-] IceDice: "..message.."\n")
end

local setResult = function(numberOfDiceFace,result,valueToAdd,resultMod,total)
    result = math.random(numberOfDiceFace)
    --printIceDice("result = "..result)
    resultMod = result
    total = total + resultMod
    --printIceDice("resultMod = "..resultMod)
    if tonumber(result) == tonumber(numberOfDiceFace) then
        resultMod = "[color=green]"..resultMod.."[/color]"
    elseif tonumber(result) == 1 then
        resultMod = "[color=red]"..resultMod.."[/color]"
    end
    --printIceDice("total = "..total)
    return resultMod, total, result
end
-->roll xxdxxxx
--max 75d if x face
--max 70d if xx face
local function diceRoller(message, fromName, clientID, fromID)

    printIceDice("IceDice.diceRoller("..message..", "..fromName..")")

    -- Initialize the pseudo random number generator
    math.randomseed( os.time() )
    math.random(); math.random(); math.random()

    --finds the position of the d to calculate the numberOfDice and numberOfDiceFace
    local dPosition = string.find(message, "d")

    local modPosition = 0
    local valueToAdd = 0
    if string.find(message,"+") ~= nil then
        modPosition = string.find(message,'+',dPosition) --finds the position of the + or - sign after the d
        if modPosition == 0 then
            modPosition = string.find(message,'-',dPosition)
        end
        printIceDice("modPosition = "..modPosition)
        valueToAdd = string.sub(message, modPosition+1) --finds the vaLue that will be added at the end after the + or -
        for i=1,string.len("valueToAdd") do
            if string.sub(valueToAdd,1,1) == "+" or string.sub(valueToAdd,1,1) == "-" then
                valueToAdd = string.sub(valueToAdd,2)
                printIceDice("valueToAdd"..i.." = "..valueToAdd)
            end
        end
        printIceDice("valueToAdd = "..valueToAdd)
    end

    local rollStartPos, rollEndPos = string.find(message, "roll")

    local numberOfDicePosEnd = dPosition-1 --numberOfDice is just before d
    local numberOfDice = string.sub(message, rollEndPos+2, numberOfDicePosEnd) --finds the numberOfDice after roll .If there is anything other than a number it will not work
    for i=1,string.len("numberOfDice") do
        if string.sub(numberOfDice,1,1) == "+" or string.sub(numberOfDice,1,1) == "-" then
            numberOfDice = string.sub(numberOfDice,2)
            --printIceDice("numberOfDice"..i.." = "..numberOfDice)
        end
    end
    numberOfDice = string.sub(numberOfDice,1)

    if tonumber(numberOfDice) > 100 or tonumber(numberOfDice) < 0 then
        return "ERROR: too many dice to roll"
    end

    printIceDice("numberOfDice = "..numberOfDice)

    local numberOfDiceFacePos = dPosition+1 --numberOfDiceFace is after d
    local numberOfDiceFace
    if modPosition == 0 then
        numberOfDiceFace = string.sub(message, numberOfDiceFacePos,numberOfDiceFacePos+4)
    else
        numberOfDiceFace = string.sub(message, numberOfDiceFacePos, modPosition-1)
    end
    printIceDice("numberOfDiceFace = "..numberOfDiceFace)

    local returnMsg = "rolling "..numberOfDice.."d"..numberOfDiceFace
    if valueToAdd ~= 0 then
        returnMsg = returnMsg.." + "..valueToAdd
    end

    local total = 0
    local result = 0

    returnMsg = returnMsg.."\n("

    if tonumber(numberOfDice) > 1 then
        printIceDice("numberOfDice > 1")
        for i=1,numberOfDice do
            resultMod, total, result = setResult(numberOfDiceFace,result,valueToAdd,resultMod,total)
            if i == 1 then
                returnMsg = returnMsg.."[b]"..resultMod.."[/b]"
            else
                returnMsg = returnMsg.." + ".."[b]"..resultMod.."[/b]"
            end
            --printIceDice("returnMsg = "..returnMsg)
        end
        printIceDice("total = "..total)
        returnMsg = returnMsg..")"
        if valueToAdd ~= 0 then
            returnMsg = returnMsg.." + "..valueToAdd
        end
        returnMsg = returnMsg.."\n = "..total + valueToAdd
        --printIceDice("returnMsgEnd = "..returnMsg)
    else
        resultMod, total, result = setResult(numberOfDiceFace,result,valueToAdd,resultMod,total)
        returnMsg = returnMsg..total..")"
        if valueToAdd ~= 0 then
            returnMsg = returnMsg.." + "..valueToAdd
        end
        returnMsg = returnMsg.."\n = "..total + valueToAdd
    end

    if clientID ~= fromID then
        returnMsg = "[b]"..fromName.."[/b] "..returnMsg
    end

    printIceDice("returnMsg = "..returnMsg)

    return returnMsg
end

IceDice = {
    diceRoller = diceRoller
}
