droppedBullets = {}

function droppedBullets.load(pEx, pEy)
    local db = {}
    db.sprite = love.graphics.newImage("assets/droppedBullets.png")
    db.x = pEx + 10
    db.y = pEy - 10
    db.hitbox = 16
    db.value = math.random(3, 9)
    db.isFree = false
    db.width = db.sprite:getWidth()
    db.height = db.sprite:getHeight()

    function db.update(dt)
        db.stayAtTheRightPosition(dt)
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
        db.isOnTheWall(dt)
    end 

    function db.isOnTheWall(dt)
        if isNextSideWall(db, 1, 0, dt) then
            db.x = db.x - hero.speed * dt
        elseif isNextSideWall(db, -1, 0, dt) then
            db.x = db.x + hero.speed * dt
        elseif isNextSideWall(db, 0, 1, dt) then
            db.y = db.y - hero.speed * dt
        elseif isNextSideWall(db, 0, -1, dt) then
            db.y = db.y + hero.speed * dt
        end
    end



    function db.stayAtTheRightPosition(dt)
        if not love.keyboard.isDown("z") or not love.keyboard.isDown("q") or not love.keyboard.isDown("s") or not love.keyboard.isDown("d") then
            dX = 0
            dY = 0
        end
        if love.keyboard.isDown("z") and map0.posY + map0.tileSize + hero.sizeY <= hero.y then
            if not isNextSideWall(hero, 0, -1, dt) then
                dY = dY + 1
            else
                dY = 0
            end
        end
        if love.keyboard.isDown("s") and hero.y + 32 <= (map0.posY + map0.height + map0.tileSize) then
            if not isNextSideWall(hero, 0, 1, dt) then
                dY = dY - 1
            else
                dY = 0
            end
        end
        if love.keyboard.isDown("q") and map0.posX + map0.tileSize + hero.sizeX <= hero.x then
            if not isNextSideWall(hero, -1, 0, dt) then
                dX = dX + 1
            else
                dX = 0
            end
        end
        if love.keyboard.isDown("d") and hero.x + 32 <= (map0.posX + map0.width + map0.tileSize) then
            if not isNextSideWall(hero, 1, 0, dt) then
                dX = dX - 1
            else
                dX = 0
            end
        end
        local magnitude = math.sqrt(dX * dX + dY * dY)
        if magnitude > 0 then
            dX = dX / magnitude
            dY = dY / magnitude
        end
        newPosX = db.x + dX * hero.speed * dt
        newPosY = db.y + dY * hero.speed * dt

            db.x = newPosX
            db.y = newPosY

    end


    function db.draw()
        love.graphics.draw(db.sprite, db.x, db.y, 0, 1, 1, 8, 8)
    end


    return db

end

return droppedBullets