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
    

    function s.update(dt)
        if isNextSideWall(s, 0, 0, dt) then
            s.isFree = true
        end
        s.x = s.x + s.speed * dt * math.cos(s.rotation)
        s.y = s.y + s.speed * dt * math.sin(s.rotation)
        if pIndex == "hero" then
            if #ennemies > 0 then
                for _, e in ipairs(ennemies) do
                    if checkCollision(e, s) then
                        audio.hurt:stop()
                        audio.hurt:play()
                        e.life = e.life - 1
                        s.isFree = true
                    end
                end
            end
        elseif pIndex == "ennemy" then
            if checkCollision(hero, s) then
                
                if not hero.isInvincible then
                    audio.hurt:stop()
                    audio.hurt:play()
                    hero.life = hero.life - 1
                    hero.isInvincible = true
                end
                s.isFree = true
            end
        end
        if bulletOutOfRange(s) then
            s.isFree = true
        end
        s.stayAtTheRightPosition(dt)
    end

    function s.stayAtTheRightPosition(dt)
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            dX = 0
            dY = 0
            hero.isMooving = false
        end
        if love.keyboard.isDown("z") and map0.posY + map0.tileSize + hero.sizeY <= hero.y then
            hero.isMooving = true
            if not isNextSideWall(hero, 0, -1, dt) then
                dY = dY + 1
            else
                dY = 0
            end
        end
        if love.keyboard.isDown("s") and hero.y + 32 <= (map0.posY + map0.height + map0.tileSize) then
            hero.isMooving = true
            if not isNextSideWall(hero, 0, 1, dt) then
                dY = dY - 1
            else
                dY = 0
            end
        end
        if love.keyboard.isDown("q") and map0.posX + map0.tileSize + hero.sizeX <= hero.x then
            hero.isMooving = true
            if not isNextSideWall(hero, -1, 0, dt) then
                dX = dX + 1
            else
                dX = 0
            end
        end
        if love.keyboard.isDown("d") and hero.x + 32 <= (map0.posX + map0.width + map0.tileSize) then
            hero.isMooving = true
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
        newPosX = s.x + dX * hero.speed * dt
        newPosY = s.y + dY * hero.speed * dt
    
            s.x = newPosX
            s.y = newPosY
    end

    function s.draw()
        love.graphics.draw(s.sprite, s.x, s.y, s.rotation, 1, 1, s.width / 2, s.height / 2)
    end

    return s 
end

return shoot