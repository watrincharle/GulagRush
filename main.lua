local map0 = require("level0/map_0")
local hero = require("hero")
local enemyModule = require("enemyModule")
local shoot = require("shoot")
colision = require("collision")
local ammoManager = require("ammoManager")
local menu = require("scenes/menu")
local pause = require("scenes/pause")
local gameOver = require("scenes/gameOver")
local game = require("scenes/game")
local init = require("init")
local droppedBullets = require("droppedBullets")
local droppedHealth = require("droppedHealth")

ennemies = {}
bullets = {}
bulletDrop = {}
healthDrop = {}

Screen_Mode = "menu"


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(1600, 900)
    menu.load()
    map0.load()
    hero.load()
    ammoManager.load()
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
end

function love.update(dt)
    

    if not hero.isAlive then
        Screen_Mode = "gameOver"
        hero.isAlive = true
    end 
    if Screen_Mode == "menu" then

    elseif Screen_Mode == "game" then
        game:update(dt)
    elseif Screen_Mode == "pause" then

    elseif Screen_Mode == "gameOver" then

    end
    
end

function love.draw()
    if Screen_Mode == "menu" then
        menu.draw()
    elseif Screen_Mode == "game" then
        game.draw()
    elseif Screen_Mode == "pause" then
       pause.draw()
    elseif Screen_Mode == "gameOver" then
        gameOver.draw()
    end
end

function love.mousepressed(x, y, button)
    if Screen_Mode == "menu" then
        if button == 1 and x >= 150 and x <= 470 and y >= 400 and y <= 520 then
            Screen_Mode = "game"
            init.init()
        elseif button == 1 and x >= 150 and x <= 470 and y >= 600 and y <= 720 then
            love.event.quit()
        end
    elseif Screen_Mode == "game" then
        if button == 1 and not a.isReloading and not a.isEmpty then
            ammoManager.fire()
        end
    elseif Screen_Mode == "pause" then
        if button == 1 and x >= 640 and x <= 960 and y >= 150 and y <= 270 then
            Screen_Mode = "game"
        elseif button == 1 and x >= 640 and x <= 960 and y >= 700 and y <= 820 then
            Screen_Mode = "menu"
        end
    elseif Screen_Mode == "gameOver" then
        if button == 1 and x >= 640 and x <= 960 and y >= 700 and y <= 820 then
            Screen_Mode = "menu"
        end
    end
end
-- 320x 120
function love.keypressed(key)
    if Screen_Mode == "menu" then

    elseif Screen_Mode == "game" then
        if key == "lshift" and not hero.dash and hero.isMooving then
            hero.speed = 15
            hero.dash = true
        end
        if key == "e" then
            local newEnemy = enemyModule.load() 
            table.insert(ennemies, newEnemy) 
        end

        if key == "r" and not a.isReloading and not a.isEmpty and a.ammoInMag <= 29 then
            a.isReloading = true
        end
        if key == "escape" then
            Screen_Mode = "pause"
        end
    elseif Screen_Mode == "pause" then
        if key == "escape" then
            Screen_Mode = "game"
        end
    end

end