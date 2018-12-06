Retry = Class{}

function Retry:enter(params)
    self.recipe = params.recipe
    self.level = params.level
    self.difficulty = params.difficulty
end

function Retry:init()
    self.background = love.graphics.newImage('images/background.png')

    self.waitress = waitress()
    self.waitress:render()
    self.speech = speech()

    self.timer = 0

    self.speaking = false
    self.message = nil
end

function Retry:render()
    love.graphics.draw(self.background, 0, 0)

    self.waitress:render()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(scoreFont)
    love.graphics.print('Level: '..tostring(self.level), 8, 8)
    
    if self.speaking then
        self.speech:render()
    end

    if self.message then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(speechFont)
        love.graphics.printf(self.message, 50, 25, 70, "center")
    end
end

function Retry:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > 1 and self.timer < 3 then
        self.speaking = true
        self.message = "Aw, that's too bad!"
    elseif self.timer > 4 and self.timer < 6 then
        self.speaking = true
        self.message = "Let's try again! Once again,"
    elseif self.timer > 6 then
        gStateMachine:change('newlevel', {recipe = self.recipe, level = self.level, difficulty = self.difficulty})
    else
        self.speaking = false
        self.message = nil
    end
       
end

function Retry:exit() end