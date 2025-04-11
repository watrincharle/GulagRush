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

hero.loadTable = function()
    hero.sprite = love.graphics.newImage("sprites/hero.png")
    hero.x = love.graphics.getWidth()/2 - 32
    hero.y = love.graphics.getHeight()/2 - 32
    hero.sizeX = 32
    hero.sizeY = 32
    hero.width = hero.sprite:getWidth()
    hero.height = hero.sprite:getHeight()
    hero.rotation = nil
    hero.speed = 3
    hero.radius = 32
end

function hero:load()
    hero.loadTable()
end

function hero:update()
    hero.rotation = math.atan2(mY - hero.y, mX - hero.x)
    hero.moove()
end



function hero:draw()
    love.graphics.draw(hero.sprite, hero.x, hero.y, hero.rotation, .5 ,.5 , hero.width/2, hero.height/2)
end



return hero