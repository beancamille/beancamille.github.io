scooprecipe = Class{}


function scooprecipe:init(num)
    if num == 1 then
        self.image = love.graphics.newImage('images/bubblegum.png')
    elseif num == 2 then
        self.image = love.graphics.newImage('images/pistachio.png')
    elseif num == 3 then
        self.image = love.graphics.newImage('images/strawberry.png')
    elseif num == 4 then
        self.image = love.graphics.newImage('images/vanilla.png')
    end
    self.x = 64
    self.y = 6

    self.width = SCOOP_WIDTH
    self.height = SCOOP_HEIGHT
end

function scooprecipe:render()
    love.graphics.draw(self.image, self.x, self.y)
end