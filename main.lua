local map0 = require("level0/map_0")
local hero = require("player/hero")
local enemyModule = require("objects/enemyModule")
local shoot = require("utilities/shoot")
local colision = require("utilities/collision")
local ammoManager = require("player/ammoManager")
local menu = require("scenes/menu")
local pause = require("scenes/pause")
local gameOver = require("scenes/gameOver")
local game = require("scenes/game")
local init = require("utilities/init")
local droppedBullets = require("objects/droppedBullets")
local droppedHealth = require("objects/droppedHealth")
local level0 = require("level0/level0")
local win = require("scenes/win")
local sceneManager = require("utilities/sceneManager")
local audio = require("utilities/audio")

ennemies = {}
bullets = {}
bulletDrop = {}
healthDrop = {}

Screen_Mode = "menu"


function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(1600, 900)
    menu.load()
    map0.load()
    hero.load()
    ammoManager.load()
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    level0.load()
    audio.load()
end

function love.update(dt)
    audio.update()
    if not hero.isAlive then
        Screen_Mode = "gameOver"
        hero.isAlive = true
    end 
    sceneManager.update(dt)
end

function love.draw()
    sceneManager.draw()
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
function love.keypressed(key)
    if Screen_Mode == "menu" then

    elseif Screen_Mode == "game" then
        if key == "lshift" and not hero.dash and hero.isMooving then
            audio.dash:play()
            hero.speed = 1000
            hero.dash = true
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
    elseif Screen_Mode == "win" then
        if key == "space" then
            Screen_Mode = "menu"
        end
    end

end