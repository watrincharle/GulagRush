pause = {}

function pause.draw()
    map.draw()
    hero.draw()
    if #ennemies > 0 then
        for _, e in ipairs(ennemies) do
            e:draw()
        end
    end
    if #bullets > 0 then
        for _, s in ipairs(bullets) do
            s:draw() 
        end
    end
    ammoManager.draw()
    love.graphics.print("PAUSE", 300, 300, 0, 25, 25)
    love.graphics.draw(resumeButton, 640, 150, 0, 8, 8)
    love.graphics.draw(exitButton, 640, 700, 0, 8, 8)
end

return pause