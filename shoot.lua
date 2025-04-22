shoot = {}

function shoot.load(pShooter, pIndex)
    local sprite = love.graphics.newImage("assets/bullet.png")
    local s = {}
        s.index = pIndex
        s.x = pShooter.x or 100
        s.y = pShooter.y or 100
        s.rotation = pShooter.rotation or 0
        s.speed = 1000
        s.sprite = sprite
        s.width = s.sprite:getWidth()
        s.height = s.sprite:getHeight()
        s.hitbox = 8
        s.isFree = false
    

    function s:update(dt)
        if isNextSideWall(s, 0, 0) then
            s.isFree = true
        end
        s.x = s.x + s.speed * dt * math.cos(s.rotation)
        s.y = s.y + s.speed * dt * math.sin(s.rotation)
        if pIndex == "hero" then
            if #ennemies > 0 then
                for _, e in ipairs(ennemies) do
                    if checkCollision(e, s) then
                        e.life = e.life - 1
                        s.isFree = true
                    end
                end
            end
        elseif pIndex == "ennemy" then
            if checkCollision(hero, s) then
                
                if not hero.isInvincible then
                    hero.life = hero.life - 1
                    hero.isInvincible = true
                end
                s.isFree = true
            end
        end
        if bulletOutOfRange(s) then
            s.isFree = true
        end
        s:stayAtTheRightPosition()
    end

    function s:stayAtTheRightPosition()
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            local dX = 0
            local dY = 0
        end
        if love.keyboard.isDown("z") and map0.posY <= hero.y then
            dY = dY + 1
        end
        if love.keyboard.isDown("s") and hero.y + 32 <= (map0.posY + map0.height) then
            dY = dY - 1
        end
        if love.keyboard.isDown("q") and map0.posX <= hero.x then
            dX = dX + 1
        end
        if love.keyboard.isDown("d") and hero.x + 32 <= (map0.posX + map0.width) then
            dX = dX - 1
        end
        local magnitude = math.sqrt(dX * dX + dY * dY)
        if magnitude > 0 then
            dX = dX / magnitude
            dY = dY / magnitude
        end
        s.x = s.x + dX * hero.speed
        s.y = s.y + dY * hero.speed
    end

    function s:draw()
        love.graphics.draw(s.sprite, s.x, s.y, s.rotation, 1, 1, s.width / 2, s.height / 2)
    end

    return s 
end

return shoot