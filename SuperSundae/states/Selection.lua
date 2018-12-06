Selection = Class{}

function Selection:enter() end

function Selection:init()
    self.background = love.graphics.newImage('images/title.png')
end

function Selection:update(dt)
    if love.keyboard.wasPressed('1') or love.keyboard.wasPressed('kp1') then
        sounds['scoop']:play()
        gStateMachine:change('levelone', {difficulty = 1})
    elseif love.keyboard.wasPressed('2') or love.keyboard.wasPressed('kp2') then
        sounds['scoop']:play()
        gStateMachine:change('levelone', {difficulty = 3})
    elseif love.keyboard.wasPressed('3') or love.keyboard.wasPressed('kp3') then
        sounds['scoop']:play()
        gStateMachine:change('levelone', {difficulty = 5})
    end
end

function Selection:render(dt)
    love.graphics.draw(self.background, 0, 0)

    love.graphics.setColor(1, 0.2, 0.6)

    love.graphics.setFont(scoreFont)
    love.graphics.printf("Type a number to select your difficulty level:", 0, VIRTUAL_HEIGHT/3, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(titleFont)
    love.graphics.print("1", VIRTUAL_WIDTH/4 - 20, VIRTUAL_HEIGHT/3 + 30)

    love.graphics.setFont(titleFont)
    love.graphics.print("2", VIRTUAL_WIDTH/2 - 20, VIRTUAL_HEIGHT/3 + 30)

    love.graphics.setFont(titleFont)
    love.graphics.print("3", VIRTUAL_WIDTH * (3/4) - 20, VIRTUAL_HEIGHT/3 + 30)
end

function Selection:exit() end