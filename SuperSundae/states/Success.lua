Success = Class{}


function Success:enter(params)
    self.level = params.level
    self.dish = params.dish
    self.scoops = params.scoops
    self.difficulty = params.difficulty
end

function Success:init()
    self.background = love.graphics.newImage('images/background.png')

    self.waitress = waitress()
    self.speech = speech()

    self.timer = 0 

    self.speaking = false
    self.message = nil
end

function Success:render()
    love.graphics.draw(self.background, 0, 0)

    self.waitress:render()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(scoreFont)
    love.graphics.print('Level: '..tostring(self.level), 8, 8)

    for k, scoop in pairs(self.scoops) do
        scoop:render()
    end

    self.dish:render()

    self.recipe = {}
    for i = 0, self.difficulty do
        self.recipe[i] = math.random(4)
    end

    if self.speaking then
        self.speech:render()
    end

    if self.message then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(speechFont)
        love.graphics.printf(self.message, 50, 25, 70, "center")
    end
end

function Success:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > 1 and self.timer < 3 then
        self.speaking = true
        self.message = "Yum, looks great!"
    elseif self.timer > 4 and self.timer < 6 then
        self.speaking = true
        self.message = "Let's do another!"
    elseif self.timer > 6 then
        gStateMachine:change('newlevel', {recipe = self.recipe, level = self.level, difficulty = self.difficulty})
    else
        self.speaking = false
        self.message = nil
    end
       
end

function Success:exit() end
