level0 = {}

function level0.load()
    numberOfEnnemies = 30
    numberOfKilled = 0

end

function level0.update()
    stairPositionX = 13 * map0.tileSize + map0.posX
    stairPositionY = 11 * map0.tileSize + map0.posY
    canChangeFloor = true
    if map0Data == map01 then
        if hero.x >= stairPositionX and hero.x  <= stairPositionX + 192 and hero.y >= stairPositionY and hero.y  <= stairPositionY + 192 and canChangeFloor and #ennemies == 0 then
            if canChangeFloor then
                map0Data = map02
                level0.init2()
                bullets = {}
                bulletDrop = {}
                healthDrop = {}
                canChangeFloor = false
            end
        end
    end
    if numberOfKilled == numberOfEnnemies then
        Screen_Mode = "win"
    end


end

function level0.draw()

end

function level0.init1()
    numberOfKilled = 0
    map0Data = map01
    bullets = {}
    bulletDrop = {}
    healthDrop = {}
    canChangeFloor = true
    table.insert(ennemies, enemyModule.load(7, 9))
    table.insert(ennemies, enemyModule.load(12, 8))
    table.insert(ennemies, enemyModule.load(16, 8))
    table.insert(ennemies, enemyModule.load(21, 7))
    table.insert(ennemies, enemyModule.load(30, 7))
    table.insert(ennemies, enemyModule.load(30, 10))
    table.insert(ennemies, enemyModule.load(34, 7))
    table.insert(ennemies, enemyModule.load(31, 3))
    table.insert(ennemies, enemyModule.load(18, 12))
    table.insert(ennemies, enemyModule.load(6, 16))
end

function level0.init2()
    table.insert(ennemies, enemyModule.load(28, 12))
    table.insert(ennemies, enemyModule.load(32, 12))
    table.insert(ennemies, enemyModule.load(36, 12))
    table.insert(ennemies, enemyModule.load(36, 7))
    table.insert(ennemies, enemyModule.load(36, 4))
    table.insert(ennemies, enemyModule.load(31, 3))
    table.insert(ennemies, enemyModule.load(24, 4))
    table.insert(ennemies, enemyModule.load(29, 7))
    table.insert(ennemies, enemyModule.load(25, 9))
    table.insert(ennemies, enemyModule.load(20, 8))
    table.insert(ennemies, enemyModule.load(19, 4))
    table.insert(ennemies, enemyModule.load(15, 3))
    table.insert(ennemies, enemyModule.load(12, 6))
    table.insert(ennemies, enemyModule.load(11, 8))
    table.insert(ennemies, enemyModule.load(8, 8))
    table.insert(ennemies, enemyModule.load(3, 8))
    table.insert(ennemies, enemyModule.load(11, 16))
    table.insert(ennemies, enemyModule.load(16, 16))
    table.insert(ennemies, enemyModule.load(22, 16))
    table.insert(ennemies, enemyModule.load(29, 16))

end

return level0