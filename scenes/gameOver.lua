gameOver = {}

function gameOver.draw()
    love.graphics.print("GAME OVER", 200, 300, 0, 15, 15)
    love.graphics.draw(exitButton, 640, 700, 0, 8, 8)
end

return gameOver