game = {}

function game:update(dt)
    mX, mY = love.mouse.getPosition()
        map.update()
        hero:update(dt)
        if #ennemies > 0 then
            for _, e in ipairs(ennemies) do
                e:update(dt)  
            end
            for i = #ennemies, 1, -1 do
                if ennemies[i].isFree == true then
                    table.remove(ennemies, i)
                end
            end
        end
        if #bullets > 0 then
            for _, s in ipairs(bullets) do
                s:update(dt) 
            end
            for i = #bullets, 1, -1 do
                if bullets[i].isFree == true then
                    table.remove(bullets, i)
                end
            end
        end
        if #bulletDrop > 0 then
            for _, db in ipairs(bulletDrop) do
                db:update(dt)
            end
            for i = #bulletDrop, 1, -1 do
                if bulletDrop[i].isFree == true then
                    table.remove(bulletDrop, i)
                end
            end
        end
        ammoManager.update(dt)
end

function game.draw()
    map.draw()

    if #bullets > 0 then
        for _, s in ipairs(bullets) do
            s:draw() 
        end
    end
    ammoManager.draw()
    if #bulletDrop > 0 then
        for _, db in ipairs(bulletDrop) do
            db:draw()
        end
    end
    hero.draw()
    if #ennemies > 0 then
        for _, e in ipairs(ennemies) do
            e:draw()
        end
    end
end

return game