local payy =  {}
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
--
-- see docs --> www.github.com/p4yy/payyAsakin
--
--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

function main()
    --put your logic here
end

-- #configuration-bot
function bot()
    return {
        username = '';
        password = '';
        world = '';
        coordinate = {};
        setUsername = function(self,name)
            self.username = name;
        end;
        setPassword = function(self,name)
            self.password = name;
        end;
        setWorld = function(self,name)
            self.world = name;
        end;
        setCoordinate = function(self,x,y)
            self.coordinate = {x,y}
        end;
        getUsername = function(self)
            return self.username
        end;
        getPassword = function(self)
            return self.password
        end;
        getWorld = function(self)
            return self.world
        end;
        getCoordinateX = function(self)
            return self.coordinate[1]
        end;
        getCoordinateY = function(self)
            return self.coordinate[2]
        end;
        login = function(self,delay)
            if delay == nil then
                delay = 2
            end
            addBot(self.username,self.password)
            sleep(7000)
            payy.warp(self.world)
            sleep(3000)
            while true do
                if string.find(string.upper(self.world), string.upper(getworld())) ~= nil then
                    if coordinate ~= nil then
                        payy.goToTile{
                            x = self.coordinate[1],
                            y = self.coordinate[2]
                        }
                    end
                    break;
                else
                    payy.warp{
                        world = self.world
                    }
                    sleep(delay*1000)
                end
            end
        end;
        reconnecting = function(self,delay)
            self.coordinate[1] = math.floor(getposx()/32+1)
            self.coordinate[2] = math.floor(getposy()/32+1)
            self.world = getworld()
            removeBot(self.username)
            sleep(3000)
            addBot(self.username,self.password)
            sleep(2000)
            payy.warp(self.world)
            sleep(1000)
            while true do
                if string.find(string.upper(self.world), string.upper(getworld())) ~= nil then
                    payy.goToTile{
                        x = self.coordinate[1],
                        y = self.coordinate[2]
                    }
                    break;
                else
                    payy.warp{
                        world = self.world
                    }
                    sleep(delay*1000)
                end
            end
        end;
        remove = function(self)
            return removeBot(self.username)
        end;
    }
end

-- #drop-item
function payy.dropItem(args)
    if type(args.itemID) ~= "number" then
        return
    end
    local count = findItem(args.itemID)
    sendPacket(2,"action|drop\n|itemID|"..tostring(args.itemID))
    sleep(1000)
    sendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|"..
    tostring(args.itemID).."|\ncount|"..tostring(count))
end

-- #trash-item
function payy.trashItem(args)
    if type(args.itemID) ~= "number" then
        return
    end
    local count = findItem(args.itemID)
    sendPacket(2,"action|trash\n|itemID|"..tostring(args.itemID))
    sleep(1000)
    sendPacket(2,"action|dialog_return\ndialog_name|trash_item\nitemID|"..
    tostring(args.itemID).."|\ncount|"..tostring(count))
end

-- #warp
function payy.warp(args)
    if type(args.world) ~= "string" then
        return
    end
    sendPacket(3,"action|join_request\nname|"..args.world)
end

-- #auto-place
function payy.autoPlace(args)
    if type(args.itemID) ~= "number" or type(args.x) ~= "number" or type(args.y) ~= "number" then
        return
    end
    while true do
        local stockItem = math.floor(findItem(args.itemID))
        if stockItem > 5 then
            for i=1,5 do
                place(args.itemID,args.x,args.y)
                args.x = args.x + 1
                if args.x == 3 then
                    args.x = -2
                end
                sleep(200)
            end
        else
            collect(3)
            sleep(100)
        end
    end
end

-- #auto-break
function payy.autoBreak(args)
    if type(args.hit) ~= "number" or type(args.x) ~= "number" or type(args.y) ~= "number" then
        return
    end
    while true do
        for i=1,5 do
            for x=1,hit do
                place(18,args.x,args.y)
                sleep(200)
            end
            args.x = args.x + 1
            if args.x == 3 then
                args.x = -2
            end
        end
    end
end

-- #place-break-item
function payy.placeBreakItem(args)
    if type(args.itemID) ~= "number" or type(args.hit) ~= "number" or type(args.x) ~= "number" 
            or type(args.y) ~= "number" or type(args.bool_fullautofarm) ~= "boolean" then
        return
    end
    while true do
    	local stockItem = math.floor(findItem(args.itemID))
    	if stockItem > 5 then
    	    for i=1,5 do
    		    place(args.itemID,args.x,args.y)
    		    args.x = args.x + 1
    		    if args.x == 3 then
    		        args.x = -2
    		    end
    		    sleep(200)
    	    end
    	    for i=1,5 do
    		    for x=1,args.hit do
    		        place(18,args.x,args.y)
    		        sleep(200)
    		    end
    		    args.x = args.x + 1
    		    if args.x == 3 then
    		        args.x = -2
    		    end
    	    end
        elseif stockItem < 5 and args.bool_fullautofarm == false then
            collect(3)
            sleep(100)
        elseif stockItem < 5 and args.bool_fullautofarm then
            break
        end
    end
end

-- #add-stock-to-vending-machine
function payy.addStockToVendingMachine()
    local tileX = math.floor(getposx()/32)
    local tileY = math.floor(getposy()/32)
    place(32,0,0)
    sleep(1000)
    sendPacket(2,"action|dialog_return\ndialog_name|vending\ntilex|"..tostring(tileX).."|tiley|"..
    tostring(tileY).."|buttonClicked|addstock\n\nsetprice|0\nchk_peritem|0\nchk_perlock|1")
end

-- #auto-spam
function payy.autoSpam(args)
    if type(args.text_1) ~= "string" or type(args.text_2) ~= "string" or type(args.text_3) ~= "string"
            or type(args.text_4) ~= "string" or type(args.delay) ~= "number" then
        return
    end
    local currentWorld = getworld()
    local currentPositionX = math.floor(getposx()/32+1)
    local currentPositionY = math.floor(getposy()/32+1)
    local x = 1
    arrayText = {args.text_1,args.text_2,args.text_3,args.text_4}
    while true do
        if string.find(string.upper(currentWorld),string.upper(getworld())) == nil then
            payy.warp{
                world = currentWorld
            }
            sleep(5000)
        elseif math.floor(getposx()/32+1) ~= currentPositionX or math.floor(getposy()/32+1) ~= currentPositionY then
            payy.goToTile{
                x = currentPositionX,
                y = currentPositionY
            }
        else
            say(arrayText[x])
            sleep(args.delay)
            x=x+1
            if x == 5 then
                x = 1
            end
        end
        sleep(10)
    end
end

-- #take-seed-gaia
function payy.takeSeedGaia(args)
    if type(args.x) ~="number" or type(args.y) ~= "number" or type(args.count) ~= "number" then
        return
    end
    local tileX = math.floor(getposx()/32+args.x)
    local tileY = math.floor(getposy()/32+args.y)
    place(32,args.x,args.y)
    sleep(1000)
    sendPacket(2,"action|dialog_return\ndialog_name|itemsucker_seed\ntilex|"..tostring(tileX)..
    "|\ntiley|"..tostring(tileY).."|\nbuttonClicked|retrieveitem\n\nchk_enablesucking|1")
    sleep(1000)
    sendPacket(2,"action|dialog_return\ndialog_name|itemremovedfromsucker\ntilex|"..tostring(tileX)..
    "|\ntiley|"..tostring(tileY).."|\nitemtoremove|"..tostring(args.count).."|\nchk_enablesucking|1")
end

-- #go-to-tile
function payy.goToTile(args)
    if type(args.x) ~= "number" or type(args.y) ~= "number" then
        return
    end
    while true do
        local valueGetPosX = math.floor(getposx()/32)
        local valueGetPosY = math.floor(getposy()/32)
        if args.x-1 > valueGetPosX then
           move(1,0)
           sleep(50)
        elseif args.x-1 < valueGetPosX then
            move(-1,0)
            sleep(50)
        elseif args.y-1 > valueGetPosY then
            move(0,1)
            sleep(50)
        elseif args.y-1 < valueGetPosY then 
            move(0,-1)
            sleep(50)
        elseif args.x-1 == valueGetPosX and args.y-1 == valueGetPosY then 
            break 
        end
    end
end

-- #retrieve-gaia
function payy.retrieveGaia(args)
    if type(args.itemID) ~= "number" or type(args.count) ~= "number" or type(args.minute) ~= "number"
            or type(args.x) ~= "number" or type(args.y) ~= "number" then
        return
    end
    local checkDrop = 0
    while true do
        payy.takeSeedGaia{
            x = args.x,
            y = args.y,
            count = args.count
        }
        sleep(1000)
        if math.floor(findItem(args.itemID)) > 0 then
            if checkDrop == 1 then
                move(1,0)
                sleep(100)
            elseif checkDrop == 2 then
                for x=1,2 do
                    move(1,0)
                    sleep(100)
                end
            elseif checkDrop == 3 then
                for x=1,3 do
                    move(1,0)
                    sleep(100)
                end
            elseif checkDrop == 4 then
                for x=1,4 do
                    move(1,0)
                    sleep(100)
                end
            elseif checkDrop == 5 then
                for x=1,5 do
                    move(1,0)
                    sleep(100)
                end
            end
            payy.drop{itemID = args.itemID}
            sleep(2000)
            if checkDrop == 0 then
                checkDrop = checkDrop+1
            elseif checkDrop == 1 then
                move(-1,0)
                sleep(100)
                checkDrop = checkDrop+1
            elseif checkDrop == 2 then
                for x=1,2 do
                    move(-1,0)
                    sleep(100)
                end
                checkDrop = checkDrop+1
            elseif checkDrop == 3 then
                for x=1,3 do
                    move(-1,0)
                    sleep(100)
                end
                checkDrop = checkDrop+1
            elseif checkDrop == 4 then
                for x=1,4 do
                    move(-1,0)
                    sleep(100)
                end
                checkDrop = checkDrop+1
            elseif checkDrop == 5 then
                for x=1,5 do
                    move(-1,0)
                    sleep(100)
                end
                checkDrop = 0
            end
        end
        for x=1,10 do
            sleep(args.minute*6000)
        end
    end
end

--#auto-farm-flour
function payy.fullAutoFarmFlour()
    local grinderX, grinderY
    for _, tile in pairs(getTiles()) do
        if tile.fg == 4582 then
            grinderX = math.floor(tile.x) + 1
            grinderY = math.floor(tile.y) + 1
            say("`6Found food grinder at X:"..tostring(grinderX).." Y:"..tostring(grinderY))
            sleep(2500)
        end
    end
    if grinderX == nil or grinderY == nil then
        return
    end
    while true do
        local stockWheatBlock = math.floor(findItem(880))
        local stockWheatSeed = math.floor(findItem(881))
        if stockWheatSeed >= 40 and stockWheatBlock >= 50 then
            collectSet(false,3)
            local valueToGrind
            local firstPosX = math.floor(getposx()/32+1)
            local firstPosY = math.floor(getposy()/32+1)
            if stockWheatBlock >= 150 then
                valueToGrind = 3
            elseif stockWheatBlock >= 100 then
                valueToGrind = 2
            elseif stockWheatBlock >= 50 then
                valueToGrind = 1
            end
            payy.goToTile{
                x = grinderX,
                y = grinderY+1
            }
            sleep(400)
            place(880,0,-1)
            sleep(1000)
            sendPacket(2,"action|dialog_return\ndialog_name|grinder\ntilex|"..tostring(math.floor(getposx()/32))..
            "|\ntiley|"..tostring(math.floor(getposy()/32-1)).."|\nitemID|880|\ncount|"..tostring(valueToGrind))
            sleep(500)
            payy.goToTile{
                x = firstPosX,
                y = firstPosY
            }
            sleep(300)
            payy.addStockToVendingMachine()
            sleep(1000)
        elseif stockWheatSeed >=30 and stockWheatBlock <= 5 then
            for i=1,8 do
                move(-5,0)
                sleep(200)
            end 
            for i=1,40 do
                place(881,0,0)
                sleep(200)
                move(1,0)
                sleep(200)
            end
            for i=1,8 do
                move(-5,0)
                sleep(200)
            end
            payy.wait(107)
            collectSet(true,3)
            sleep(2000)
            for i=1,40 do
                place(18,0,0)
                sleep(200)
                move(1,0)
                sleep(200)
            end
            if math.floor(findItem(881)) < 40 then
                payy.placeBreakItem{
                    itemID = 880,
                    hit = 3,
                    x = -2,
                    y = -1,
                    bool_fullautofarm = true
                }
            end
        elseif stockWheatBlock > 5 then
            payy.placeBreakItem{
                itemID = 880,
                hit = 3,
                x = -2,
                y = -1,
                bool_fullautofarm = true
            }
        elseif stockWheatSeed < 30 and stockWheatBlock < 5 then
            say("You must have wheat seed atleast 30 seed")
            break
        end
        sleep(100)
    end
end

function payy.wait(second)
    local duration = os.time() + second
    while os.time() < duration do 
        sleep(1)
    end
end

-- #auto-cook-berry oven-> 15
function payy.autoCookBerry(args)
    if type(args.bool_gemonade) ~= "boolean" or type(args.stackBuffer) ~= "number" or type(args.stackStop) ~= "number" 
            or type(args.takeItemX) ~= "number" or type(args.takeItemY) ~= "number" then
        return
    end
    --bool_gemonade,stackBuffer,stackStop,takeItemX,takeItemY
    local counterStack = args.bool_gemonade
    local needleStack = 1
    local needleStop = 1
    local tileX = -2
    local tileY = -2
    while true do
        if args.bool_gemonade == nil or args.stackBuffer == nil or args.stackStop == nil or args.takeItemX == nil or args.takeItemY == nil then
            break
        end
        local stockGemonade = math.floor(findItem(6914))
        local stockFlour = math.floor(findItem(4562))
        local stockEgg = math.floor(findItem(874))
        local stockMilk = math.floor(findItem(868))
        local stockBlueberry = math.floor(findItem(196))
        if args.bool_gemonade == true and stockGemonade == 0 then
            sendPacket(2,"action|input\ntext|gemonade is empty")
            break
        end
        if needleStop == args.stackStop then
            break
        end
        if needleStack > args.stackBuffer and counterStack == true and stockGemonade ~= 0 then
            args.bool_gemonade = true
            needleStack = 0
        end
        if stockFlour < 15 or stockEgg < 15 or stockMilk < 15 or stockBlueberry < 15 then
            local selfX = math.floor(getposx()/32)
            local selfY = math.floor(getposy()/32)
            payy.goToTile{x=args.takeItemX,y=args.takeItemY}
            sleep(500)
            collectSet(true,5)
            sleep(2000)
            collectSet(false,5)
            sleep(300)
            payy.goToTile{x=selfX,y=selfY}
        elseif stockFlour >= 15 and stockEgg >= 15 and stockMilk >= 15 and stockBlueberry >= 15 then
            -- flour-> 4562
            for i=1,3 do
                for x=1,5 do
                    place(4562,tileX,tileY)
                    sleep(500)
                    sendPacket(2,"action|dialog_return\ndialog_name|oven\ntilex|"..tostring(math.floor(getposx()/32+tileX))..
                    "|\ntiley|"..tostring(math.floor(getposy()/32+tileY)).."|\ncookthis|4562|\nbuttonClicked|low\n\ndisplay_timer|0")
                    sleep(200)
                    tileX = tileX+1
                    if tileX == 3 then
                        tileX = -2
                    end
                end
                tileY = tileY+1
                if tileY == 1 then
                    tileY = -2
                end
            end
            sleep(1000)
            -- egg-> 874
            for i=1,3 do
                for x=1,5 do
                    local counter_lag_flour = math.floor(findItem(874))
                    place(874,tileX,tileY)
                    sleep(500)
                    if math.floor(findItem(874)) == counter_lag_flour then
                        sendPacket(2,"action|dialog_return\ndialog_name|oven\ntilex|"..tostring(math.floor(getposx()/32+tileX))..
                        "|\ntiley|"..tostring(math.floor(getposy()/32+tileY)).."|\ncookthis|874|\nbuttonClicked|low\n\ndisplay_timer|0")
                    end
                    sleep(500)
                    tileX = tileX+1
                    if tileX == 3 then
                        tileX = -2
                    end
                end
                tileY = tileY+1
                if tileY== 1 then
                    tileY = -2
                end
            end
            sleep(11500)
            -- milk -> 868
            for i=1,3 do
                for x=1,5 do
                    place(868,tileX,tileY)
                    sleep(1000)
                    tileX = tileX+1
                    if tileX == 3 then
                        tileX = -2
                    end
                end
                tileY = tileY+1
                if tileY == 1 then
                    tileY = -2
                end
            end
            sleep(200)
            -- blueberry -> 196
            for i=1,3 do
                for x=1,5 do
                    place(196,tileX,tileY)
                    sleep(1000)
                    tileX = tileX+1
                    if tileX == 3 then
                        tileX = -2
                    end
                end
                tileY = tileY+1
                if tileY == 1 then
                    tileY = -2
                end
            end
            if args.bool_gemonade == true and stockGemonade > 0 then
                sleep(300)
                place(6914,0,0)
                sleep(500)
                args.bool_gemonade = false
            end
            sleep(4500)
            -- punch -> 18
            for i=1,3 do
                for x=1,5 do
                    place(18,tileX,tileY)
                    sleep(1000)
                    tileX = tileX+1
                    if tileX == 3 then
                        tileX = -2
                    end
                end
                tileY = tileY+1
                if tileY == 1 then
                    tileY = -2
                end
            end
            sleep(500)
        end
        needleStack = needleStack+1
        needleStop = needleStop+1
    end
end

main()