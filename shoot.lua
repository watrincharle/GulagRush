shoot = {}

function shoot.load(pShooter, pIndex)
    local sprite = love.graphics.newImage("sprites/bullet.png")
    local s = {}
        s.index = pIndex
        s.x = pShooter.x or 100
        s.y = pShooter.y or 100
        s.rotation = pShooter.rotation or 0
        s.speed = 100
        s.sprite = sprite
        s.width = s.sprite:getWidth()
        s.height = s.sprite:getHeight()
    

    function s:update(dt)
        s.x = s.x + s.speed * dt * math.cos(s.rotation)
        s.y = s.y + s.speed * dt * math.sin(s.rotation)
    end

    function s:draw()
        love.graphics.draw(s.sprite, s.x, s.y, s.rotation)
    end

    return s 
end

return shoot