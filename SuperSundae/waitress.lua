waitress = Class{}

function waitress:init()
    self.image = love.graphics.newImage('images/waitress.png')

    self.width = 84
    self.height = 200

    self.x = 40
    self.y = VIRTUAL_HEIGHT - self.height - 10
end

function waitress:render()
    love.graphics.draw(self.image, self.x, self.y)
end