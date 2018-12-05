PlayState = Class{}

SCOOP_WIDTH = 60
SCOOP_HEIGHT = 78

DISH_WIDTH = 65
DISH_HEIGHT = 34

function PlayState:enter(params)
    self.recipe = params.recipe
    self.level = params.level
    self.difficulty = params.difficulty
end

function PlayState:init()
    self.background = love.graphics.newImage('images/background.png')

    self.dish = Dish()
    self.scoops = {}
    self.timer = 0
    self.scoopcount = 0
end

function PlayState:update(dt)
    self.timer = self.timer + dt

    if self.timer > 3 then
        local x = math.random(0, VIRTUAL_WIDTH - SCOOP_WIDTH)
        table.insert(self.scoops, Scoop(x))
        self.timer = 0
    end

    for k, scoop in pairs(self.scoops) do
        if not scoop.scooped then
            if self.dish:collides(scoop, self.scoopcount) then
                if scoop.flavor == self.recipe[self.scoopcount] then
                    self.scoopcount = self.scoopcount + 1
                    scoop.scooped = true
                    scoop.scoopedid = self.scoopcount
                    if self.scoopcount == self.difficulty + 1 then
                        self.level = self.level + 1
                        sounds['levelup']:play()
                        gStateMachine:change('success',{level = self.level, scoops = self.scoops, dish = self.dish, difficulty = self.difficulty})
                    else
                        sounds['scoop']:play()
                    end
                else
                    sounds['oops']:play()
                    gStateMachine:change('retry', {recipe = self.recipe, level = self.level, difficulty = self.difficulty})
                end
            end
            scoop:update(dt, scoop.scoopedid, self.dish.x)
        else
            scoop:update(dt, scoop.scoopedid, self.dish.x)
        end
        if scoop.remove then
            table.remove(self.scoops, k)
        end
    end
    self.dish:update(dt, self.scoopcount)
end


function PlayState:render()
    love.graphics.draw(self.background, 0, 0)

    for k, scoop in pairs(self.scoops) do
        scoop:render()
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(scoreFont)
    love.graphics.print('Level: '..tostring(self.level), 8, 8)

    self.dish:render()
end

function PlayState:exit() end
