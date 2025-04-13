

function manathan(a, b)
    return math.abs(a.x - b.x) + math.abs(a.y - b.y)
end


function neighbors(node, map)
    local result = {}
    local directions = {
        {x=1, y=0}, {x=-1, y=0}, {x=0, y=1}, {x=0, y=-1}
    }
    for _, dir in ipairs(directions) do
        local nx, ny = node.x + dir.x, node.y + dir.y
        if map[ny] and map[ny][nx] and map[ny][nx] == 0 then
            table.insert(result, {x=nx, y=ny})
        end
    end
    return result
end

function a_star(start, goal, map)
    local openSet = {start}
    local cameFrom = {}

    local gScore = {}
    local fScore = {}

    local function key(node) return node.x..","..node.y end

    gScore[key(start)] = 0
    fScore[key(start)] = manathan(start, goal)

    while #openSet > 0 do
        table.sort(openSet, function(a, b)
            return (fScore[key(a)] or math.huge) < (fScore[key(b)] or math.huge)
        end)

        local current = table.remove(openSet, 1)

        if current.x == goal.x and current.y == goal.y then
            local path = {current}
            while cameFrom[key(current)] do
                current = cameFrom[key(current)]
                table.insert(path, 1, current)
            end
            return path
        end

        for _, neighbor in ipairs(neighbors(current, map)) do
            local tentative_gScore = gScore[key(current)] + 1

            if tentative_gScore < (gScore[key(neighbor)] or math.huge) then
                cameFrom[key(neighbor)] = current
                gScore[key(neighbor)] = tentative_gScore
                fScore[key(neighbor)] = tentative_gScore + manathan(neighbor, goal)
                local inOpenSet = false
                for _, n in ipairs(openSet) do
                    if n.x == neighbor.x and n.y == neighbor.y then
                        inOpenSet = true
                        break
                    end
                end
                if not inOpenSet then
                    table.insert(openSet, neighbor)
                end
            end
        end
    end

    return nil
end