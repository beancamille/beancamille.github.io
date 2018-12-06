NewLevel = Class{}

function NewLevel:enter(params)
    self.recipe = params.recipe
    self.level = params.level
    self.difficulty = params.difficulty
end

function NewLevel:init()
    self.background = love.graphics.newImage('images/background.png')

    self.waitress = waitress()
    self.scoop = scooprecipe()
    self.speech = speech()

    self.timer = 0

    self.speaking = false
    self.message = nil
    self.scoopflash = nil

    self.flashcount = 0
end

function NewLevel:render()
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

    if self.scoopflash then
        self.scoop:init(self.recipe[self.scoopflash])
        self.scoop:render()
    end

    self.length = table.getn(self.recipe)
end

function NewLevel:update(dt)
    self.timer = self.timer + dt
    
    if self.flashcount <= self.length then
        if self.timer > 1 and self.timer < 2 then
            self.speaking = true
            self.message = "The order is..."
            self.scoopflash = nil
        elseif self.timer > (2 * self.flashcount + 3) and self.timer < (2 * self.flashcount + 5) then
            self.speaking = true
            self.message = nil
            self.scoopflash = self.flashcount
        elseif self.timer > (2 * self.flashcount + 5) and self.timer > (2 * self.flashcount + 5.5) then
            self.flashcount = self.flashcount + 1
        else
            self.speaking = false
            self.message = nil
            self.scoopflash = nil
        end
    elseif self.timer > (self.length * 2 + 4) and self.timer < (self.length * 2 + 7) then
        self.speaking = true
        self.message = "Ready, Go!"
        self.scoopflash = nil
    elseif self.timer > (self.length * 2 + 7) then
        gStateMachine:change('playstate', {recipe = self.recipe, level = self.level, difficulty = self.difficulty})
    else
        self.speaking = false
        self.message = nil
        self.scoopflash = nil
    end
       
end

function NewLevel:exit() end