function checkCircleCollision(a, b, c)
    if c == "idle" or c == "isSearching" then
        local dx = a.x - b.x
        local dy = a.y - b.y
        local distance = math.sqrt(dx * dx + dy * dy)
        return distance < (a.radius + b.radius)
    elseif c == "chaseTarget" then
        local dx = a.x - b.x
        local dy = a.y - b.y
        local distance = math.sqrt(dx * dx + dy * dy)
        return distance < (a.radius * .75 + b.radius)
    elseif c == "getBack" then
        local dx = a.x - b.x
        local dy = a.y - b.y
        local distance = math.sqrt(dx * dx + dy * dy)
        return distance < (a.radius * .4 + b.radius)
    elseif c == "shoot" then
        local dx = a.x - b.x
        local dy = a.y - b.y
        local distance = math.sqrt(dx * dx + dy * dy)
        return distance < (a.radius * .5 + b.radius)
    end
end

function checkCollision(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    local distance = math.sqrt(dx * dx + dy * dy)
    return distance < (a.hitbox + b.hitbox)
end

function checkWallCollision()
    hero.isCollided = isWallCollided(hero)
end

function getTileIndexes(x, y)
    local tileX = math.floor((map0.posX - x) / map0.tileSize) + 1
    local tileY = math.floor((map0.posY - y) / map0.tileSize) + 1
    return math.abs(tileX), math.abs(tileY)
end


function isNextSideWall(pObject, vx, vy)
    local sideX = pObject.x + vx * (pObject.width * .5 + 2)
    local sideY =  pObject.y + vy * (pObject.height * .5 + 2)
    local corner1 = { -- vx = 1 | vy = 0
        x = sideX + vy * pObject.width * .5, -- x = sideX
        y = sideY + vx * pObject.height * .5 -- y = sideY + height/2
    }
    local corner2 = {
        x = sideX - vy * pObject.width * .5, -- x = sideX
        y = sideY - vx * pObject.height * .5 -- y = sideY - height/2
    }
    local tX1, tY1 = getTileIndexes(corner1.x, corner1.y)
    local tX2, tY2 = getTileIndexes(corner2.x, corner2.y)
    if map0Data[tY1] and map0Data[tY1][tX1] ~= 2 and map0Data[tY1] and map0Data[tY1][tX1] ~= 3 and map0Data[tY1] and map0Data[tY1][tX1] ~= 12 then
        return true
    end
    if map0Data[tY1] and map0Data[tY1][tX1] ~= 2 and map0Data[tY1] and map0Data[tY1][tX1] ~= 3 and map0Data[tY1] and map0Data[tY1][tX1] ~= 12 then
        return true
    end
    return false
end

function bulletOutOfRange(a)
    if a.x >= screenWidth or a.x <= 0 or a.y >= screenHeight or a.y <= 0 then
        return true
    end
end