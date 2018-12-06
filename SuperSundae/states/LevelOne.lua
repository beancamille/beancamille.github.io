LevelOne = Class{}

function LevelOne:enter(params) 
    self.difficulty = params.difficulty
end

function LevelOne:init()
    self.background = love.graphics.newImage('images/background.png')

    self.waitress = waitress()
    self.speech = speech()

    self.timer = 0
    self.level = 1

    self.speaking = false
    self.message = nil
end

function LevelOne:render()
    love.graphics.draw(self.background, 0, 0)

    self.recipe = {}
        for i = 0, self.difficulty do
            self.recipe[i] = math.random(4)
        end
        
    self.waitress:render()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(scoreFont)
    love.graphics.print('Level: '..tostring(self.level), 8, 8)

    if self.speaking then
        self.speech:render()
    end

    if self.message then
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(speechFont)
        love.graphics.printf(self.message, 50, 25, 70, "center")
    end
end

function LevelOne:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > 1 and self.timer < 3 then
        self.speaking = true
        self.message = "Ready for your first order?"
    elseif self.timer >4 and self.timer < 6 then
        self.speaking = true
        self.message ="Here we go!"
    elseif self.timer > 6 then
        gStateMachine:change('newlevel',{recipe = self.recipe, level = self.level, difficulty = self.difficulty})
    else
        self.speaking = false
        self.message = nil
    end
       
end

function LevelOne:exit() end