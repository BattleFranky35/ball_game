_G.love = require 'love'
local Enemy = require 'Enemy'
local Button = require 'Button'

math.randomseed(os.time())

local player = {
    radius = 20,
    x = 0,
    y = 0
}

local game = {
    difficulty = 1,
    state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    }
}

local buttons = {
    menuState = {}
}

local enemies = {}

function love.load()
    love.mouse.setVisible(false)

    buttons.menuState.play = button('Play Game', nil, nil, 50, 50)

    table.insert(enemies, 1, enemy())
end

function love.update(dt)
    player.x, player.y = love.mouse.getPosition()

    for i = 1, #enemies do
        enemies[i]:move(player.x, player.y)
    end
end

function love.draw()
    love.graphics.print('FPS: ' .. love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30)

    if game.state['running'] then
        love.graphics.circle('fill', player.x, player.y, player.radius)
    elseif game.state['menu'] then
        buttons.menuState.play:draw(10, 20, 10, 20)
    end

    if not game.state['running'] then
        love.graphics.circle('fill', player.x, player.y, player.radius / 2)
        
        for i = 1, #enemies do
            enemies[i]:draw()
        end
    end
end