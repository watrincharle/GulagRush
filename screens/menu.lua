menu = {}

function menu.load()
    mainScreen = love.graphics.newImage("sprites/MainScreen.png")
    playButton = love.graphics.newImage("sprites/playButton.png")
    resumeButton = love.graphics.newImage("sprites/resumeButton.png")
    exitButton = love.graphics.newImage("sprites/exitButton.png")
end

function menu:update(dt)

end

function menu:draw()
    love.graphics.draw(mainScreen, 0, 0, 0, 10, 10)
    love.graphics.draw(playButton, 150, 400, 0, 8, 8)
    love.graphics.draw(exitButton, 150, 600, 0, 8, 8)
end

return menu