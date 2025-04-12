droppedHealth = {}

function droppedHealth.load(pEx, pEy)
    local dh = {}
    dh.sprite = love.graphics.newImage("sprites/droppedhealth.png")
    dh.x = pEx - 10
    dh.y = pEy + 10
    dh.hitbox = 16
    dh.isFree = false

    function dh:update(dt)
        dh:stayAtTheRightPosition()
        if checkCollision(dh, hero) then
            if hero.life < 5 then
                hero.life = hero.life + 1
                dh.isFree = true
            end
        end
    end 



    function dh:stayAtTheRightPosition()
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            local dX = 0
            local dY = 0
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
        dh.x = dh.x + dX * hero.speed
        dh.y = dh.y + dY * hero.speed
    end


    function dh:draw()
        love.graphics.draw(dh.sprite, dh.x, dh.y, 0, .5, .5, 8, 8)
    end


    return dh

end

return droppedHealth