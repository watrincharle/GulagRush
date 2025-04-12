droppedBullets = {}

function droppedBullets.load(pEx, pEy)
    local db = {}
    db.sprite = love.graphics.newImage("sprites/droppedBullets.png")
    db.x = pEx + 10
    db.y = pEy - 10
    db.hitbox = 16
    db.value = math.random(3, 9)
    db.isFree = false

    function db:update(dt)
        db:stayAtTheRightPosition()
        if checkCollision(db, hero) then
            if a.ammoInPocket <= 149 then
                a.ammoInPocket = a.ammoInPocket + db.value
                db.isFree = true
                if a.ammoInPocket >= 150 then
                    a.ammoInPocket = 150
                end
            elseif a.ammoInPocket >= 150 then
                a.ammoInPocket = 150
            end
        end
    end 



    function db:stayAtTheRightPosition()
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            local dX = 0
            local dY = 0
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
        db.x = db.x + dX * hero.speed
        db.y = db.y + dY * hero.speed
    end


    function db:draw()
        love.graphics.draw(db.sprite, db.x, db.y, 0, .5, .5, 8, 8)
    end


    return db

end

return droppedBullets