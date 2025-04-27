audio = {}

function audio.load()
    audio.bonus = love.audio.newSource("assets/audio/bonus.mp3", "static")
    audio.dead = love.audio.newSource("assets/audio/dead.mp3", "static")
    audio.hurt = love.audio.newSource("assets/audio/hurt.mp3", "static")
    audio.shoot = love.audio.newSource("assets/audio/shoot.mp3", "static")
    audio.dash = love.audio.newSource("assets/audio/dash.wav", "static")
    audio.reload = love.audio.newSource("assets/audio/reload.wav", "static")
    audio.walk = love.audio.newSource("assets/audio/walk.mp3", "stream")
    audio.musicLoop = love.audio.newSource("assets/audio/musicLoop.mp3", "stream")

    --------------------------------

    audio.musicLoop:setLooping(true)
    audio.walk:setLooping(true)

    -----------------------------------

    audio.shoot:setVolume(0.2)
    audio.walk:setVolume(0.1)
    audio.hurt:setVolume(0.6)
    audio.dash:setVolume(0.7)
    audio.reload:setVolume(0.8)
end

function audio.update()
    if Screen_Mode == "game" then
        audio.musicLoop:play()
        if love.keyboard.isDown("z") or love.keyboard.isDown("q") or love.keyboard.isDown("s") or love.keyboard.isDown("d") then
            audio.walk:play()
        else
            audio.walk:pause()
        end
    elseif Screen_Mode == "pause" then
        audio.musicLoop:pause()
        audio.walk:stop()
    else
        audio.musicLoop:stop()
        audio.walk:stop()
    end

end



return audio