gameOver = {}


function gameOver.draw()
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
    love.graphics.print("GAME OVER", 200, 300, 0, 15, 15)
    love.graphics.draw(exitButton, 640, 700, 0, 8, 8)
end

return gameOver