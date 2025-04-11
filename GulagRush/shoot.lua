local hero = require("hero")
local map = require("map")
local enemyModule = require("enemyModule")

shoot = {}

function shoot:bullets(pA)
    local bullet = {}
    bullet.img = love.graphics.newImage("sprites/bullet.png")
    bullet.x = pA.x
    bullet.y = pA.y 
    bullet.vx = nil
    bullet.vy = nil
    bullet.angle = pA.rotation
    bullet.speed = 20
    table.insert(shoot, bullet)
    print(bullet.x.." - "..pA.x)
    print(bullet.y.." - "..pA.y)
end

function shoot:load()
    shoot.ammo = 100
    shoot.mag = 30
    shoot.outOfAmmo = false
    shoot.reload = false
    shoot.timer = 1
    shoot.volountaryReload = false
end

shoot.stayAtTheRightPosition = function()
    for i = #shoot, 1, -1 do
        local s = shoot[i]
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            dX = 0
            dY = 0
        end
        if love.keyboard.isDown("z") and map.posY <= hero.y then
            dY = dY + 1
        end
        if love.keyboard.isDown("s") and hero.y + 32 <= (map.posY + map.height) then
            dY = dY - 1
        end
        if love.keyboard.isDown("q") and map.posX <= hero.x then
            dX = dX + 1
        end
        if love.keyboard.isDown("d") and hero.x + 32 <= (map.posX + map.width) then
            dX = dX - 1
        end
        local magnitude = math.sqrt(dX * dX + dY * dY)
        if magnitude > 0 then
            dX = dX / magnitude
            dY = dY / magnitude
        end
        s.x = s.x + dX * hero.speed
        s.y = s.y + dY * hero.speed
    end
end

shoot.collisionDetected = function(ennemiesList)
    for i = #shoot, 1, -1 do
        local s = shoot[i]
        s.vx = s.speed * math.cos(s.angle) 
        s.vy = s.speed * math.sin(s.angle) 
        s.x = s.x + s.vx
        s.y = s.y + s.vy
        if s.x >= love.graphics.getWidth() or s.x <= 0 or s.y >= love.graphics.getHeight() or s.y <= 0 then
            table.remove(shoot, i)
        end
        local mX, mY = love.mouse.getPosition()
        for enn = #ennemiesList, 1, -1 do
            local enemi = ennemiesList[enn]
            if s.x + 8 >= enemi.x - 16 and s.x <= enemi.x + 16 and s.y + 8 >= enemi.y - 16 and s.y <= enemi.y + 16 then
                table.remove(shoot, i)
                if enemi.life >= 2 then
                    enemi.life = enemi.life - 1
                else
                    table.remove(ennemiesList, enn)
                end
            end
        end
    end
end

shoot.usingAmmo = function()
    if shoot.volountaryReload then 
        shoot.reload = true
        shoot.timer = 1
    elseif shoot.mag >= 1 then
        shoot.mag = shoot.mag - 1
        if shoot.mag == 0 then
            shoot.reload = true
            shoot.timer = 1
        end
    end
end

shoot.reloadManually = function()
    local ammoInTheMag = 30 - shoot.mag
    if shoot.ammo >= ammoInTheMag then
        shoot.mag = shoot.mag + ammoInTheMag
        shoot.ammo = shoot.ammo - ammoInTheMag
    elseif shoot.ammo < ammoInTheMag then
        shoot.mag = shoot.mag + shoot.ammo
        shoot.ammo = 0
    end  
     
end

shoot.reloadAmmo = function()
    if shoot.volountaryReload then
        shoot.volountaryReload = false
        shoot.reloadManually()
    elseif shoot.mag == 0 and shoot.ammo >= 30 then
            shoot.ammo = shoot.ammo - 30
            shoot.mag = shoot.mag + 30
    elseif shoot.mag == 0 and shoot.ammo <=29 and shoot.ammo >=1 then
        shoot.mag = shoot.mag + shoot.ammo
        shoot.ammo = shoot.ammo - shoot.mag
    elseif shoot.ammo == 0 and shoot.mag == 0 then
        shoot.outOfAmmo = true
    else 
        shoot.outOfAmmo = false
    end
end

shoot.reloadTimer = function()
    if shoot.reload then
        shoot.timer = shoot.timer - shoot.dt
        if shoot.timer <= 0 then
            shoot.reload = false
            shoot.reloadAmmo()
        end
    end
end

function shoot:update(ennemiesList)
    shoot.dt = love.timer.getDelta()
    shoot.stayAtTheRightPosition()
    shoot.collisionDetected(ennemiesList)
    shoot.reloadTimer()
end

function shoot:draw()
    for _, b in ipairs(shoot) do
        love.graphics.draw(b.img, b.x, b.y, b.angle, 0.5, 0.5, b.img:getWidth()/2, b.img:getHeight()/2)
    end
    love.graphics.print(shoot.mag.."/"..shoot.ammo, love.graphics.getWidth() - 50, 50)
    if shoot.outOfAmmo then
        love.graphics.print("OUT OF AMMO !", love.graphics.getWidth() - 100, 100)
    end
    if shoot.reload then
        love.graphics.print("RELOADING ! ", love.graphics.getWidth() - 100, 150)
    end
end

return shoot