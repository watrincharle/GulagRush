
map = {}

function map:load()
    map.road = love.graphics.newImage("sprites/road.png")
    map.wall = love.graphics.newImage("sprites/wall.png")
    map.tileSize = 64
    map.col = 10
    map.row = 15
    map.width = (map.tileSize * map.row) 
    map.height = (map.tileSize * map.col) 
    map.posX = love.graphics.getWidth()/2 - map.width/2 
    map.posY = love.graphics.getHeight()/2 - map.height/2
end



function map:update()

end

function map:draw()
    local r, c = 0, 0

    for i = 1, map.col do
        for j = 1, map.row do
            love.graphics.draw(map.road, r+map.posX, c+map.posY,0,1,1)
            r = r + map.tileSize
        end
        r = 0
        c = c + map.tileSize
    end

end

return map
