speech = Class{}

function speech:init()
    self.image = love.graphics.newImage('images/bubble.png')
    self.x = 45
    self.y = 15
    self.width = 100
    self.height = 74 
end

function speech:render()
    love.graphics.draw(self.image, self.x, self.y)
end