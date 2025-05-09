droppedHealth = {}

function droppedHealth.load(pEx, pEy)
    local dh = {}
    dh.sprite = love.graphics.newImage("assets/droppedhealth.png")
    dh.x = pEx - 10
    dh.y = pEy + 10
    dh.hitbox = 16
    dh.isFree = false
    dh.width = dh.sprite:getWidth()
    dh.height = dh.sprite:getHeight()

    function dh.update(dt)
        dh.stayAtTheRightPosition(dt)
        if checkCollision(dh, hero) then
            if hero.life < 5 then
                audio.bonus:stop()
                audio.bonus:play()
                hero.life = hero.life + 1
                dh.isFree = true
            end
        end
        dh.isOnTheWall(dt)
    end 

    function dh.isOnTheWall(dt)
        if isNextSideWall(dh, 1, 0, dt) then
            dh.x = dh.x - hero.speed * dt
        elseif isNextSideWall(dh, -1, 0, dt) then
            dh.x = dh.x + hero.speed * dt
        elseif isNextSideWall(dh, 0, 1, dt) then
            dh.y = dh.y - hero.speed * dt
        elseif isNextSideWall(dh, 0, -1, dt) then
            dh.y = dh.y + hero.speed * dt
        end
    end


    function dh.stayAtTheRightPosition(dt)
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            dX = 0
            dY = 0
        end
        if love.keyboard.isDown("z") and map0.posY + map0.tileSize + hero.sizeY <= hero.y then
            if not isNextSideWall(hero, 0, -1, dt) then
                dY = dY + 1
            else
                dY = 0
            end
        end
        if love.keyboard.isDown("s") and hero.y + 32 <= (map0.posY + map0.height + map0.tileSize) then
            if not isNextSideWall(hero, 0, 1, dt) then
                dY = dY - 1
            else
                dY = 0
            end
        end
        if love.keyboard.isDown("q") and map0.posX + map0.tileSize + hero.sizeX <= hero.x then
            if not isNextSideWall(hero, -1, 0, dt) then
                dX = dX + 1
            else
                dX = 0
            end
        end
        if love.keyboard.isDown("d") and hero.x + 32 <= (map0.posX + map0.width + map0.tileSize) then
            if not isNextSideWall(hero, 1, 0, dt) then
                dX = dX - 1
            else
                dX = 0
            end
        end
        local magnitude = math.sqrt(dX * dX + dY * dY)
        if magnitude > 0 then
            dX = dX / magnitude
            dY = dY / magnitude
        end
        newPosX = dh.x + dX * hero.speed * dt
        newPosY = dh.y + dY * hero.speed * dt
   
            dh.x = newPosX
            dh.y = newPosY
   
    end


    function dh.draw()
        love.graphics.draw(dh.sprite, dh.x, dh.y, 0, 1, 1, 8, 8)
    end


    return dh

end

return droppedHealth