push = require 'push'

Class = require 'class'

require 'states/StateMachine'
require 'states/NewLevel'
require 'states/PlayState'
require 'states/Retry'
require 'states/Success'
require 'states/LevelOne'
require 'states/TitleScreen'
require 'states/Instructions'
require 'states/Selection'

require 'Dish'
require 'Scoop'
require 'waitress'
require 'speech'
require 'scooprecipe'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    math.randomseed(os.time())

    love.window.setTitle('Super Sundae Scooper')

    speechFont = love.graphics.newFont('fonts/chunky.ttf', 8)
    scoreFont = love.graphics.newFont('fonts/chunky.ttf', 14)
    titleFont = love.graphics.newFont('fonts/billo.TTF', 40)
    love.graphics.setFont(speechFont)

    sounds = {
        ['scoop'] = love.audio.newSource('sounds/floop.wav', 'static'),
        ['levelup'] = love.audio.newSource('sounds/chime.wav', 'static'),
        ['oops'] = love.audio.newSource('sounds/womp.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/music.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })


    gStateMachine = StateMachine {
        ['newlevel'] = function() return NewLevel() end,
        ['playstate'] = function() return PlayState() end,
        ['retry'] = function() return Retry() end,
        ['success'] = function() return Success() end,
        ['levelone'] = function() return LevelOne() end,
        ['title'] = function() return TitleScreen() end,
        ['instructions'] = function() return Instructions() end,
        ['selection'] = function() return Selection() end,
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    gStateMachine:render()

    push:finish()
end