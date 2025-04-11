local map = require("map")
local hero = require("hero")
local enemyModule = require("enemyModule")
local shoot = require("shoot")
colision = require("collision")

ennemies = {}
bullets = {}


function love.load()
    print("loading ...")
    love.window.setMode(1280, 720, {fullscreen = false, fullscreentype = "exclusive"})
    print("Screen size loaded .")
    love.graphics.setDefaultFilter("nearest", "nearest")
    print("filter loaded .")
    love.window.setMode(1280, 720)
    print("screen mode loaded .")
    map.load()
    print("map loaded .")
    hero.load()
    print("hero loaded .")
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
end

function love.update(dt)
    mX, mY = love.mouse.getPosition()
    map.update()
    hero.update()
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
    
end

function love.draw()
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
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local newShoot = shoot.load(hero, "hero")
        table.insert(bullets, newShoot)
    end
end

function love.keypressed(key)
    if key == "e" then
        local newEnemy = enemyModule.load() 
        table.insert(ennemies, newEnemy) 
    end

    if key == "r" and shoot.mag >= 1 and shoot.ammo >= 1 and not shoot.volountaryReload and shoot.mag < 30 then
        shoot.volountaryReload = true
        shoot.usingAmmo()
    end

    if key == "f" and love.window.setMode(1280, 720, {fullscreen = true, fullscreentype = "exclusive"}) then
        love.window.setMode(1280, 720, {fullscreen = false, fullscreentype = "exclusive"})
    elseif key =="f" and not love.window.setMode(1280, 720, {fullscreen = true, fullscreentype = "exclusive"}) then
        love.window.setMode(1280, 720, {fullscreen = true, fullscreentype = "exclusive"})
    end
end