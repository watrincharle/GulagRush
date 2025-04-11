enemyModule = {}

function enemyModule.load()
    local e = {}
    e.x = 200
    e.y = 200
    e.sprite = love.graphics.newImage("sprites/ennemy.png")
    e.heart = love.graphics.newImage("sprites/heart.png")
    e.speed = 80
    e.life = 3
    e.rotation = math.random(0, 2 * math.pi)
    e.dx = nil
    e.timerSearching = math.random(0.5, 2)
    e.timerLoading = 1.5
    e.STATE = "isSearching"
    e.radius = 300
    e.hitbox = 32
    e.width = e.sprite:getWidth()
    e.height = e.sprite:getHeight()

    function e:update(dt)
        if e.STATE == "isSearching" then
            e:isSearching(dt)
        elseif e.STATE == "idle" then
            e.idle()
        elseif e.STATE == "chaseTarget" then
            e:chaseTarget(dt)
        elseif e.STATE == "getBack" then
            e:getBack(dt)
        elseif e.STATE == "shoot" then
            e:shoot(dt)
        end
        e:stayAtTheRightPosition()
    end



    function e:isSearching(dt)
        
        local speedPatrol = e.speed / 2
        e.x = e.x + speedPatrol * dt * math.cos(e.rotation)
        e.y = e.y + speedPatrol * dt * math.sin(e.rotation)
        e.timerSearching = e.timerSearching - dt
        if checkCircleCollision(e, hero, e.STATE) then
            e.STATE = "chaseTarget"
        elseif e.timerSearching <= 0 then
            e.STATE = "idle"
            e.timerSearching = math.random(0.5, 2)
        end
    end
    
    function e:idle()
        local delta = love.timer.getDelta()
        e.timerSearching = e.timerSearching - delta
        if checkCircleCollision(e, hero, e.STATE) then
            e.STATE = "chaseTarget"
        elseif e.timerSearching <= 0 then
            e.STATE = "isSearching"
            e.angle = math.random(0, 2 * math.pi)
            e.timerSearching = math.random(0.5, 2)
        end
    end

    function e:stayAtTheRightPosition()
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            dX = 0
            dY = 0
        end
        if love.keyboard.isDown("z") and map.posY <= hero.y then
            dY = dY + 1
        end
        if love.keyboard.isDown("s") and hero.y + 32 <= (map.posY + map.height) then
            dY = dY - 1
        end
        if love.keyboard.isDown("q") and map.posX <= hero.x then
            dX = dX + 1
        end
        if love.keyboard.isDown("d") and hero.x + 32 <= (map.posX + map.width) then
            dX = dX - 1
        end
        local magnitude = math.sqrt(dX * dX + dY * dY)
        if magnitude > 0 then
            dX = dX / magnitude
            dY = dY / magnitude
        end
        e.x = e.x + dX * hero.speed
        e.y = e.y + dY * hero.speed
    end

    function e:chaseTarget(dt)
        e.rotation = math.atan2(hero.y - e.y, hero.x - e.x)
        e.x = e.x + e.speed * dt * math.cos(e.rotation)
        e.y = e.y + e.speed * dt * math.sin(e.rotation)
        if  not checkCircleCollision(e, hero, "idle") then
            e.STATE = "idle"
        elseif checkCircleCollision(e, hero, e.STATE) then
            e.STATE = "shoot"
        elseif checkCircleCollision(e, hero, "getBack") then
            e.STATE = "getBack"   
        end
    end



    function e:getBack(dt)
        local angleAway = math.atan2(e.y - hero.y, e.x - hero.x)
        e.x = e.x + e.speed * dt * math.cos(angleAway)
        e.y = e.y + e.speed * dt * math.sin(angleAway)
        if not checkCircleCollision(e, hero, "getBack") then
            e.STATE = "shoot"
        end
    end


    function e:shoot(dt)
        e.rotation = math.atan2(hero.y - e.y, hero.x - e.x)
        e.timerLoading = e.timerLoading - dt
        if e.timerLoading <= 0 then
            --shoot:bullets(e)
            e.timerLoading = 1.5
        end
        if not checkCircleCollision(e, hero, "chaseTarget") then
            e.STATE = "chaseTarget"
        elseif checkCircleCollision(e, hero, "getBack") then
            e.STATE = "getBack"
        end
    end
    
    function e:draw()
        love.graphics.draw(e.sprite, e.x, e.y, e.rotation, .5, .5, e.width * .5 , e.height * .5)
        if e.life >= 1 then
            love.graphics.draw(e.heart, e.x - 16, e.y - 32, 0, .5, .5, e.heart:getWidth() * .5 , e.heart:getHeight() * .5)
            if e.life >= 2 then
                love.graphics.draw(e.heart, e.x, e.y - 32, 0, .5, .5, e.heart:getWidth() * .5 , e.heart:getHeight() * .5)
                if e.life >=3 then
                    love.graphics.draw(e.heart, e.x + 16, e.y - 32, 0, .5, .5, e.heart:getWidth() * .5 , e.heart:getHeight() * .5)
                end
            end
        end
    end



    return e
end

return enemyModule