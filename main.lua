local map = require("map")
local hero = require("hero")
local enemyModule = require("enemyModule")
local shoot = require("shoot")
colision = require("collision")

local ennemies = {}
local bullets = {}


function love.load()
    love.window.setMode(1280, 720, {fullscreen = false, fullscreentype = "exclusive"})
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(1280, 720)
    map.load()
    hero.load()
    shoot.load()
end

function love.update(dt)
    mX, mY = love.mouse.getPosition()
    map.update()
    hero.update()
    shoot:update(ennemies)
    if #ennemies > 0 then
        for _, e in ipairs(ennemies) do
            e:update(dt)  -- Appel de la méthode update de l'ennemi
        end
    end
    if #bullets > 0 then
        for _, e in ipairs(bullets) do
            e:update(dt)  -- Appel de la méthode update de l'ennemi
        end
    end
end

function love.draw()
    map.draw()
    hero.draw()
    if #ennemies > 0 then
        for _, e in ipairs(ennemies) do
            e:draw()  -- Appel de la méthode draw de l'ennemi
        end
    end
    if #bullets > 0 then
        for _, e in ipairs(bullets) do
            e:draw()  -- Appel de la méthode draw de l'ennemi
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        shoot.load()
    end
end

function love.keypressed(key)
    if key == "e" then
        local newEnemy = enemyModule.load()  -- Appel au nouveau module
        table.insert(ennemies, newEnemy)  -- Ajout de l'ennemi à la liste
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