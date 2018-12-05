TitleScreen = Class{}

function TitleScreen:enter() end

function TitleScreen:init()
    self.background = love.graphics.newImage('images/title.png')
end

function TitleScreen:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('instructions')
    end
end

function TitleScreen:render()
    love.graphics.draw(self.background, 0, 0)

    love.graphics.setColor(1, 0.2, 0.6)
    love.graphics.setFont(titleFont)
    love.graphics.printf("Super Sundae Scooper", 0, VIRTUAL_HEIGHT/3, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(scoreFont)
    love.graphics.printf("Press enter to begin!", 0, VIRTUAL_HEIGHT/3 + 50, VIRTUAL_WIDTH, "center")
end

function TitleScreen:exit() end