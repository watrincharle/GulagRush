ammoManager = {}

function ammoManager.load()
    a = {}
    a.ammoInPocket = 100
    a.ammoInMag = 30
    a.reloadTimer = 2
    a.isReloading = false
    a.isEmpty = false
end

function ammoManager.update(dt)
    if a.isReloading then
        ammoManager.reload(dt)
    end

end

function ammoManager.fire()
    if a.ammoInMag == 0 and a.ammoInPocket == 0 then
        a.isEmpty = true
    elseif a.ammoInMag == 0 and a.ammoInPocket >= 1 then
        a.isReloading = true
    else
        a.ammoInMag = a.ammoInMag - 1
        local newShoot = shoot.load(hero, "hero")
        table.insert(bullets, newShoot)
    end
end

function ammoManager.reload(dt)
    a.reloadTimer = a.reloadTimer - dt
    if a.reloadTimer <= 0 then
        a.isReloading = false
        local residus = 30 - a.ammoInMag
        if a.ammoInPocket >= residus then
            a.ammoInMag = a.ammoInMag + residus
            a.ammoInPocket = a.ammoInPocket - residus
        elseif a.ammoInPocket < residus then
            a.ammoInMag = a.ammoInMag + a.ammoInPocket
            a.ammoInPocket = 0
        end
        a.reloadTimer = 2
    end
end

function ammoManager.draw()
    love.graphics.print(a.ammoInMag.." / "..a.ammoInPocket, 950, 100, 0, 3, 3)
    if a.isReloading then
        love.graphics.print("RELOAD !", 950, 140, 0, 3, 3)
    end
    if a.isEmpty then
        love.graphics.print("EMPTY !", 950, 140, 0, 3, 3)
    end

end

function ammoManager.init()
    a.ammoInPocket = 100
    a.ammoInMag = 30
    a.reloadTimer = 2
    a.isReloading = false
    a.isEmpty = false
end

return ammoManager