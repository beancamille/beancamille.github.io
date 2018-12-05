Scoop = Class{}

function Scoop:init(x)
    self.flavor = math.random(4)
    if self.flavor == 1 then
        self.image = love.graphics.newImage('images/bubblegum.png')
    elseif self.flavor == 2 then
        self.image = love.graphics.newImage('images/pistachio.png')
    elseif self.flavor == 3 then
        self.image = love.graphics.newImage('images/strawberry.png')
    elseif self.flavor == 4 then
        self.image = love.graphics.newImage('images/vanilla.png')
    end

    self.x = x
    self.y = - (SCOOP_HEIGHT + 20)

    self.width = SCOOP_WIDTH
    self.height = SCOOP_HEIGHT

    self.remove = false
    self.scooped = false

    self.dx = 0

    self.speed = math.random(40,60)

    self.scoopedid = 0
end

function Scoop:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Scoop:update(dt, count, position)
    if self.scooped == false then
        if self.y < VIRTUAL_HEIGHT then
            self.y = self.y + self.speed * dt
        else
            self.remove = true
        end
    else
        self.x = position + 3
        self.y = VIRTUAL_HEIGHT - DISH_HEIGHT - ((count) * SCOOP_HEIGHT) - 20 + (50 * (count))
    end
end
