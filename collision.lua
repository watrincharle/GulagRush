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

function bulletOutOfRange(a)
    if a.x >= screenWidth or a.x <= 0 or a.y >= screenHeight or a.y <= 0 then
        return true
    end
end