local map = require ("map")

hero = {}
dX = 0
dY = 0

hero.moove = function()
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
    map.posX = map.posX + dX * hero.speed
    map.posY = map.posY + dY * hero.speed
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
end


function hero:update(dt)
    hero.rotation = math.atan2(mY - hero.y, mX - hero.x)
    hero.moove()
    if hero.isInvincible then
        hero:invisibilityFrame(dt)
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
    if hero.isInvincible then
        love.graphics.setColor(1, 0, 0, 0.5)
    end
    love.graphics.draw(hero.sprite, hero.x, hero.y, hero.rotation, .5 ,.5 , hero.width/2, hero.height/2)
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
end


return hero