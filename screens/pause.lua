pause = {}

function pause.draw()
    love.graphics.print("PAUSE", 300, 300, 0, 25, 25)
    love.graphics.draw(resumeButton, 640, 150, 0, 8, 8)
    love.graphics.draw(exitButton, 640, 700, 0, 8, 8)
end

return pause