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
        return distance < (a.radius * .5 + b.radius)
    elseif c == "getBack" then
        local dx = a.x - b.x
        local dy = a.y - b.y
        local distance = math.sqrt(dx * dx + dy * dy)
        return distance < (a.radius * .25 + b.radius)
    elseif c == "shoot" then
        local dx = a.x - b.x
        local dy = a.y - b.y
        local distance = math.sqrt(dx * dx + dy * dy)
        return distance < (a.radius * .33 + b.radius)
    end
end