Instructions = Class{}

function Instructions:enter() end

function Instructions:init()
    self.background = love.graphics.newImage('images/title.png')
end

function Instructions:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('selection')
    end
end

function Instructions:render()
    love.graphics.draw(self.background, 0, 0)

    love.graphics.setColor(1, 0.2, 0.6)
    love.graphics.setFont(scoreFont)

    love.graphics.printf("Use the left and right arrows to move the dish", 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, "center")
    love.graphics.printf("Collect the ice cream to create the order that the waitress tells you!", 0, VIRTUAL_HEIGHT/4 + 40, VIRTUAL_WIDTH, "center")
    love.graphics.printf("Press enter to continue!", 0, VIRTUAL_HEIGHT/4 + 100, VIRTUAL_WIDTH, "center")
end

function Instructions:exit() end