sceneManager = {}

function sceneManager.update(dt)
    if Screen_Mode == "menu" then

    elseif Screen_Mode == "game" then
        game.update(dt)
    elseif Screen_Mode == "pause" then

    elseif Screen_Mode == "gameOver" then

    elseif Screen_Mode == "win" then

    end
end

function sceneManager.draw()
    if Screen_Mode == "menu" then
        menu.draw()
    elseif Screen_Mode == "game" then
        game.draw()
    elseif Screen_Mode == "pause" then
       pause.draw()
    elseif Screen_Mode == "gameOver" then
        gameOver.draw()
    elseif Screen_Mode == "win" then
        win.draw()
    end
end

return sceneManager