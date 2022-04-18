# payyAsakin
payyAsakin is a lua executor module for multibot-asakin applications, where this module is 
free open source and you can experiment making a new feature with it.

# Feature:
---------------------------------------------------------------

- `Drop-item`
- `Trash-item`
- `Warp`
- `Auto place 5 tile`
- `Retrieve gaia`
- `Auto break 5 tile`
- `Put and Break 5 tile`
- `Add stock to vending`
- `Auto spam` rejoin world and coordinate
- `Auto farm flour`
- `Auto cook berry` maybe have some bug

---------------------------------------------------------------

Example Usage
=============

Config bot
--------------------------
```lua
function main()
    Bot = bot()
    bot1()  --> login into bot1
    bot2()  --> login into bot2
end

function bot1()
    Bot:setUsername('username_bot')
    Bot:setPassword('password_bot')
    Bot:setWorld('payyAsakin|idDoor')
    Bot:login(10) --> 10 is mean warp into world every 10 second
end

function bot2()
    Bot:setUsername('username_bot')
    Bot:setPassword('password_bot')
    Bot:setWorld('payyAsakin|idDoor')
    Bot:login(10)
end
-- more command:
-- Bot.reconnecting()
-- Bot.remove()
-- Getting information of object Bot
-- Bot.getUsername() 
-- Bot.getPassword()
-- Bot.getWorld()
```

Droping item
--------------------------
```lua
function main()
    payy.dropItem{ 
        itemID = 340   --> type(number)
    }
end
```

Trashing item
--------------------------
```lua
function main()
    payy.trashItem{
        itemID = 3    --> type(number)
    }
end
```

Warp
--------------------------

If you want enter world with id door, you can set `world = payyasakin|idDoor`
```lua
function main()
    payy.warp{
        world = "payyasakin" --> type(string)
    }
end
```

Auto Place 5 tile
--------------------------

You can set x and y depend ur needs
```lua
function main()
    payy.autoPlace{
        itemID = 5666,              --> type(number)
        x = -2,                     --> type(number)
        y = -2,                     --> type(number)
    }
end
```

Auto Break 5 tile
--------------------------
```lua
function main()
    payy.autoBreak{
        hit = 5,   --> type(number)
        x = -2,    --> type(number)
        y = -2     --> type(number)
    }
end
```

Put and Break 5 tile
--------------------------
```lua
function main()
    payy.placeBreakItem{
        itemID = 340,                 --> type(number)
        hit = 6,                      --> type(number)
        x = -2,                       --> type(number)
        y = -2,                       --> type(number)
        bool_fullautofarm = false
    }
end
```

Auto spam
--------------------------
```lua
function main()
    payy.autoSpam{
        text_1 = "`2Donate some wl at payyAsakin",      --> type(string)
        text_2 = "`2Donate some wl at payyAsakin",      --> type(string)
        text_3 = "/love",                               --> type(string)
        text_4 = "/love",                               --> type(string)
        delay = 4000                                    --> type(number)
    }
end
```

Add stock into vending machine
--------------------------
```lua
function main()
    payy.addStockToVendingMachine()
end
```

Retrieve-gaia
--------------------------
```lua
function main()
    payy.retrieveGaia{
        itemID = 5667,
        x = 0,
        y = -1,
        minute = 15,
        count = 100
    }
    -- 5667 = lgrid seed
    -- 15 = take seed every 15 minute
    -- 100 = total seed taking from gaia
end
```

Auto-farm-flour
--------------------------

You need place food grinder ,40 platform , vending machine and bot on right

```lua
function main()
    payy.fullAutoFarmFlour()
end
```

Teleport to tile
--------------------------
```lua
function main()
    payy.goToTile{
        x = 0,      --> type(number)
        y = 0       --> type(number)
    }
end
```

Auto cook berry crepes
--------------------------

`YOU CAN IMPROVE THIS FUNCTION`<br>
How it works? you need to drop all ingredient and then set `takeItemX` 
and `takeItemY` to it. On variable `stackBuffer` it means how many times 
cook for use gemonade. And on variable `stackStop` it means how many 
times cook and then stop. 

```lua
function main()
    payy.autoCookBerry{
        bool_gemonade = true,   --> type(boolean)
        stackBuffer = 16,       --> type(number)
        stackStop = 41,         --> type(number)
        takeItemX = 38,         --> type(number)
        takeItemY = 18          --> type(number)
    }
end
```

Support
-------
If you find this module helpful and would like to support its development. <br>You can donate me some wl at `world: payyAsakin`<br>
join discord: [https://discord.gg/WT4cBNNJKW]