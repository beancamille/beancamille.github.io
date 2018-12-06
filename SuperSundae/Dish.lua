Dish = Class{}

function Dish:init()
    self.image = love.graphics.newImage('images/bowl.png')

    self.x = VIRTUAL_WIDTH/2
    self.y = VIRTUAL_HEIGHT - (DISH_HEIGHT + 5)

    self.width = DISH_WIDTH
    self.height = DISH_HEIGHT

    self.dx = 0
end

function Dish:collides(scoop, count)
    if (self.x + self.width - 15) >= scoop.x and (self.x + 15) <= (scoop.x + SCOOP_WIDTH) then
        if (self.y + self.height - 5) >= scoop.y and (self.y + 25) <= (scoop.y + SCOOP_HEIGHT * (count + 1) - (50 * (count))) then
             return true
        end 
    end
    return false
end

function Dish:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.x > 0 then
            self.dx = -17
        end
    elseif love.keyboard.wasPressed('right') then
        if self.x < (VIRTUAL_WIDTH - DISH_WIDTH) then
            self.dx = 17
        end
    else
        self.dx = 0
    end
    self.x = self.x + self.dx
end

function Dish:render()
    love.graphics.draw(self.image, self.x, self.y)
end