-- Chreate: a game by Flederossi (9h)

function love.load()
    main_load()
    state1_load()
    state2_load()
    state3_load()
end

function love.update(dt)
    if state == 1 then
        state1_update()
    elseif state == 2 then
        state2_update()
    elseif state == 3 then
        state3_update()
    end
end

function love.draw()
    if state == 1 then
        state1_draw()
    elseif state == 2 then
        state2_draw()
    elseif state == 3 then
        state3_draw()
    end
end

function main_load()
    love.window.setTitle("Chreate")

    cursor = love.mouse.newCursor("assets/cursor.png", 0, 0)
    cursorp = love.mouse.newCursor("assets/cursorp.png", 0, 0)
    love.mouse.setCursor(cursor)

    icon = love.image.newImageData("assets/c.png")
    love.window.setIcon(icon)

    love.graphics.setBackgroundColor(1, 1, 1)

    --Vars
    state = 1
    level = 1

    bool_sound = "ON"
    bool_music = "ON"

    music = love.audio.newSource("sounds/music_game.wav", "stream")
    music:setLooping(true)
    music:play()
end

function state1_load()
    starticon = love.graphics.newImage("assets/c.png")

    animation_title = 0
    animation_logo = 0

    animation_start = 0
    animation_settings = 0
    animation_exit = 0

    switch_start = 0.4
    switch_settings = 0.4
    switch_exit = 0.4

    play_sound = true

    title_font = love.graphics.newFont("fonts/NationalPark-Regular.otf", 80)
    select_font = love.graphics.newFont("fonts/NationalPark-Regular.otf", 40)

    click_sound = love.audio.newSource("sounds/sound_click.wav", "stream")
    click_sound:setVolume(0.6)

    hover_sound = love.audio.newSource("sounds/sound_hover.wav", "stream")
    hover_sound:setVolume(0.2)

    exit_vol = 1
end

function state1_update()
    if animation_logo < 1 then
        animation_logo = animation_logo + 0.02
    end
    if animation_logo > 0.3 and animation_title < 1 then
        animation_title = animation_title + 0.02
    end
    if animation_title > 0.5 and animation_start < 1 then
        animation_start = animation_start + 0.02
    end
    if animation_title > 0.5 and animation_settings < 1 then
        animation_settings = animation_settings + 0.02
    end
    if animation_title > 0.5 and animation_exit < 1 then
        animation_exit = animation_exit + 0.02
    end

    if exit_vol < 1 then
        if exit_vol <= 0 then
            love.event.quit(0)
        else
            exit_vol = exit_vol - 0.04
            if control_volume > 0 then
                music:setVolume(exit_vol)
            end
        end
    end

    if love.mouse.getX() > 320 and love.mouse.getX() < 480 then
        if love.mouse.getY() > 300 and love.mouse.getY() < 340 then
            if switch_start == 0.4 then
                if animation_start <= 0.4 then
                    switch_start = 1
                else
                    animation_start = animation_start - 0.04
                end
            elseif switch_start == 1 then
                if animation_start >= 1 then
                    switch_start = 0.4
                end
            end
            if play_sound then
                if animation_start > 0.9 then
                    playHoverSound()
                    play_sound = false
                end
            end
        elseif love.mouse.getY() > 370 and love.mouse.getY() < 410 then
            if switch_settings == 0.4 then
                if animation_settings <= 0.4 then
                    switch_settings = 1
                else
                    animation_settings = animation_settings - 0.04
                end
            elseif switch_settings == 1 then
                if animation_settings >= 1 then
                    switch_settings = 0.4
                end
            end
            if play_sound then
                if animation_settings > 0.9 then
                    playHoverSound()
                    play_sound = false
                end
            end
        elseif love.mouse.getY() > 440 and love.mouse.getY() < 480 then
            if switch_exit == 0.4 then
                if animation_exit <= 0.4 then
                    switch_exit = 1
                else
                    animation_exit = animation_exit - 0.04
                end
            elseif switch_exit == 1 then
                if animation_exit >= 1 then
                    switch_exit = 0.4
                end
            end
            if play_sound then
                if animation_exit > 0.9 then
                    playHoverSound()
                    play_sound = false
                end
            end
        else
            play_sound = true
        end
    else
        play_sound = true
    end
end

function state1_draw()
    love.graphics.setColor(80/255, 80/255, 80/255, animation_title)
    love.graphics.setFont(title_font)
    love.graphics.printf("hreate", 60, 90, love.graphics.getWidth(), "center")
    love.graphics.setColor(1, 1, 1, animation_logo)
    love.graphics.draw(starticon, 215, 85, 0, 0.4, 0.4)
    love.graphics.setFont(select_font)
    love.graphics.setColor(80/255, 80/255, 80/255, animation_start)
    love.graphics.printf("Start", 0, 300, love.graphics.getWidth(), "center")
    love.graphics.setColor(80/255, 80/255, 80/255, animation_settings)
    love.graphics.printf("Settings", 0, 370, love.graphics.getWidth(), "center")
    love.graphics.setColor(80/255, 80/255, 80/255, animation_exit)
    love.graphics.printf("Exit", 0, 440, love.graphics.getWidth(), "center")
end

function state2_load()
    w = 100
    h = 100
    animation_level = 0
    animation_ui = 0
end

function state2_update()
    if animation_level < 1 then
        animation_level = animation_level + 0.01
    end
    if animation_level > 0.3 and animation_ui < 1 then
        animation_ui = animation_ui + 0.02
    end
end

function state2_draw()
    love.graphics.setColor(80/255, 80/255, 80/255, animation_level)
    love.graphics.rectangle("line", 250, 20, 300, 110, 10, 10)
    love.graphics.printf("Level: " .. level, 0, 45, 800, "center")
    love.graphics.setColor(80/255, 80/255, 80/255, animation_ui)
    love.graphics.rectangle("line", 20, 20, 210, 560, 10, 10)
    for y = 1, 3 do
        for x = 1, 3 do
            love.graphics.rectangle("line", (x - 1) * w + 250, (y - 1) * h + 150, w, h, 10, 10)
        end
    end
    love.graphics.rectangle("line", 570, 20, 210, 430, 10, 10)
    love.graphics.rectangle("line", 250, 470, 530, 110, 10, 10)
end

function state3_load()
    full_settings_animation = 0
    control_volume = 1
    small_font = love.graphics.newFont("fonts/NationalPark-Regular.otf", 30)
end

function state3_update()
    if full_settings_animation < 1 then
        full_settings_animation = full_settings_animation + 0.02
    end
    if control_volume < 1 and control_volume > 0 then
        control_volume = control_volume - 0.04
        music:setVolume(control_volume)
    elseif control_volume <= 0 then
        music:setVolume(0)
    end
end

function state3_draw()
    love.graphics.setFont(select_font)
    love.graphics.setColor(80/255, 80/255, 80/255, full_settings_animation)
    love.graphics.printf("Settings", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Music: " .. bool_music, 0, 230, love.graphics.getWidth(), "center")
    love.graphics.printf("Sound: " .. bool_sound, 0, 280, love.graphics.getWidth(), "center")
    love.graphics.setColor(170/255, 170/255, 170/255, full_settings_animation)
    love.graphics.setFont(small_font)
    love.graphics.printf("A game by Flederossi", 0, 530, love.graphics.getWidth(), "center")
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        love.mouse.setCursor(cursorp)
        if state == 1 then
            if x > 320 and x < 480 then
                if y > 300 and y < 340 then
                    playClickSound()
                    state2_load()
                    state = 2
                elseif y > 370 and y < 410 then
                    playClickSound()
                    state3_load()
                    state = 3
                elseif y > 440 and y < 480 then
                    playClickSound()
                    exit_vol = 0.99
                end
            end
        elseif state == 3 then
            if x > 300 and x < 480 then
                if y > 230 and y < 270 then
                    if bool_music == "ON" then
                        bool_music = "OFF"
                        control_volume = 0.99
                    elseif bool_music == "OFF" then
                        bool_music = "ON"
                        control_volume = 1
                        music:setVolume(control_volume)
                    end
                    playClickSound()
                elseif y > 280 and y < 320 then
                    if bool_sound == "ON" then
                        bool_sound = "OFF"
                    elseif bool_sound == "OFF" then
                        bool_sound = "ON"
                    end
                    playClickSound()
                end
            end
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        love.mouse.setCursor(cursor)
    end
end

function love.keypressed(key)
    if key == "escape" then
        if state == 1 then
            playClickSound()
            exit_vol = 0.99
        elseif state == 2 or state == 3 then
            playClickSound()
            state1_load()
            state = 1
        end
    end
end

function playHoverSound()
    if bool_sound == "ON" then
        hover_sound:stop()
        hover_sound:play()
    end
end

function playClickSound()
    if bool_sound == "ON" then
        click_sound:stop()
        click_sound:play()
    end
end