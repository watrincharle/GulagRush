local map = require ("map")

hero = {}
dX = 0
dY = 0
newPosX = 0
newPosY = 0

hero.moove = function()


    if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
        dX = 0
        dY = 0
        hero.isMooving = false
    end
    if love.keyboard.isDown("z") and map.posY + map.tileSize + hero.sizeY <= hero.y then
        hero.isMooving = true
        if not isNextSideWall(hero, 0, -1) then
            dY = dY + 1
        else
            dY = 0
        end
    end
    if love.keyboard.isDown("s") and hero.y + 32 <= (map.posY + map.height + map.tileSize) then
        hero.isMooving = true
        if not isNextSideWall(hero, 0, 1) then
            dY = dY - 1
        else
            dY = 0
        end
    end
    if love.keyboard.isDown("q") and map.posX + map.tileSize + hero.sizeX <= hero.x then
        hero.isMooving = true
        if not isNextSideWall(hero, -1, 0) then
            dX = dX + 1
        else
            dX = 0
        end
    end
    if love.keyboard.isDown("d") and hero.x + 32 <= (map.posX + map.width + map.tileSize) then
        hero.isMooving = true
        if not isNextSideWall(hero, 1, 0) then
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
    newPosX = map.posX + dX * hero.speed
    newPosY = map.posY + dY * hero.speed

        map.posX = newPosX
        map.posY = newPosY



end

function hero.load()
    hero.sprite = love.graphics.newImage("sprites/hero.png")
    hero.x = love.graphics.getWidth()/2 - 32
    hero.y = love.graphics.getHeight()/2 - 32
    hero.sizeX = 32
    hero.sizeY = 32
    hero.width = hero.sprite:getWidth()
    hero.height = hero.sprite:getHeight()
    hero.rotation = 0
    hero.speed = 3
    hero.radius = 32
    hero.life = 5
    hero.hitbox = hero.radius
    hero.invinsibilityTimer = 1.2
    hero.isInvincible = false
    hero.isAlive = true
    hero.dash = false
    hero.isMooving = false
    hero.dashTimer = 3
    hero.dashSprite = love.graphics.newImage("sprites/dash.png")
    hero.dashSpriteWidth = hero.dashSprite:getWidth()
    hero.dashSpriteHeight = hero.dashSprite:getHeight()
end


function hero:update(dt)
    hero:doTheDash(dt)
    hero.rotation = math.atan2(mY - hero.y, mX - hero.x)
    hero.moove()
    if hero.isInvincible then
        hero:invisibilityFrame(dt)
    end
    if hero.life <= 0 then
        hero.isAlive = false
    end
end

function hero:doTheDash(dt)
    if hero.speed > 3 then
        hero.speed = hero.speed - 0.5
    end
    if hero.dash then
        hero.dashTimer = hero.dashTimer - dt
    end
    if hero.dashTimer <= 0 then
        hero.dash = false
        hero.dashTimer = 3
    end

end

function hero:invisibilityFrame(dt)
    hero.invinsibilityTimer = hero.invinsibilityTimer - dt
    if hero.invinsibilityTimer <= 0 then
        hero.isInvincible = false
        hero.invinsibilityTimer = 1.2
    end
end


function hero:draw()
    if hero.dash then
        love.graphics.setColor(0, 0, 0, .3)
        love.graphics.draw(hero.dashSprite, 100, screenHeight - 100, 0, 1, 1)
        love.graphics.setColor(1, 1, 1, 1)

    elseif not hero.dash then
        love.graphics.draw(hero.dashSprite, 100, screenHeight - 100, 0, 1, 1)
    end
    if hero.isInvincible then
        love.graphics.setColor(1, 0, 0, 0.5)
    end
    love.graphics.draw(hero.sprite, hero.x, hero.y, hero.rotation, 1 , 1 , hero.width/2, hero.height/2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(hero.life, 100, 100, 0, 3, 3)
end

function hero.init()
    hero.x = love.graphics.getWidth()/2 - 32
    hero.y = love.graphics.getHeight()/2 - 32
    hero.rotation = 0
    hero.radius = 32
    hero.life = 5
    hero.hitbox = hero.radius
    hero.invinsibilityTimer = 1.2
    hero.isInvincible = false
    hero.isAlive = true
end


return hero