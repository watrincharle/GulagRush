shoot = {}

function shoot.load(pShooter, pIndex)
    local s = {
        index = pIndex,
        x = pShooter.x,
        y = pShooter.y,
        rotation = pShooter.rotation,
        speed = 100,
        sprite = love.graphics.newImage("sprites/bullet.png"),
        width = s.sprite:getWidth(),
        height = s.sprite:getHeight()
    }

    function s:update(dt)
        s.x = s.x + s.speed * dt * math.cos(s.rotation)
        s.y = s.y + s.speed * dt * math.sin(s.rotation)
    end

    function s:draw()
        love.graphics.draw(s.sprite, s.x, s.y, s.rotation)
    end

end

return shoot