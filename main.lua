local map = require("map")
local hero = require("hero")
local enemyModule = require("enemyModule")
local shoot = require("shoot")
colision = require("collision")
local ammoManager = require("ammoManager")
local menu = require("screens/menu")
local pause = require("screens/pause")
local gameOver = require("screens/gameOver")

ennemies = {}
bullets = {}
Screen_Mode = "menu"


function love.load()
    print("loading ...")
    love.graphics.setDefaultFilter("nearest", "nearest")
    print("filter loaded .")
    love.window.setMode(1600, 900)
    print("screen mode loaded .")
    menu.load()
    map.load()
    print("map loaded .")
    hero.load()
    print("hero loaded .")
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
        ammoManager.update(dt)
    elseif Screen_Mode == "pause" then

    elseif Screen_Mode == "gameOver" then

    end
    
end

function love.draw()
    if Screen_Mode == "menu" then
        menu.draw()
    elseif Screen_Mode == "game" then
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
    elseif Screen_Mode == "pause" then
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
        pause.draw()
    elseif Screen_Mode == "gameOver" then
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
        gameOver.draw()
    end
end

function love.mousepressed(x, y, button)
    if Screen_Mode == "menu" then
        if button == 1 and x >= 150 and x <= 470 and y >= 400 and y <= 520 then
            Screen_Mode = "game"
            ammoManager.init()
            hero.init()
            map.init()
            ennemies = {}
            bullets = {}
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