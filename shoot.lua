shoot = {}

function shoot.load(pShooter, pIndex)
    local sprite = love.graphics.newImage("sprites/bullet.png")
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
        s.x = s.x + s.speed * dt * math.cos(s.rotation)
        s.y = s.y + s.speed * dt * math.sin(s.rotation)
        if pIndex == "hero" then
            if #ennemies > 0 then
                for _, e in ipairs(ennemies) do
                    if checkShootCollision(e, s) then
                        e.life = e.life - 1
                        s.isFree = true
                    end
                end
            end
        elseif pIndex == "ennemy" then
            if checkShootCollision(hero, s) then
                hero.life = hero.life - 1
                s.isFree = true
            end
        end
        if bulletOutOfRange(s) then
            s.isFree = true
        end
    end

    function s:draw()
        love.graphics.draw(s.sprite, s.x, s.y, s.rotation, .5, .5, s.width / 2, s.height / 2)
    end

    return s 
end

return shoot