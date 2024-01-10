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
    },
    points = 0,
    levels = {15, 30, 60, 120}
}

local fonts = {
    small = {
        font = love.graphics.newFont(16),
        size = 16
    },

    medium = {
        font = love.graphics.newFont(24),
        size = 24
    },

    large = {
        font = love.graphics.newFont(60),
        size = 60
    }
}

local buttons = {
    menuState = {},
    endedState = {}
}

local enemies = {}

local function changeState(state)
    game.state['menu'] = state == 'menu'
    game.state['paused'] = state == 'paused'
    game.state['running'] = state == 'running'
    game.state['ended'] = state == 'ended'
end

local function newGame()
    changeState('running')
    game.points = 0
    enemies = {
        enemy(1)
    }
end

function love.mousepressed(x, y, button, istouch, presses)
    if not game.state['running'] then
        if button == 1 then
            if game.state['menu'] then
                for index in pairs(buttons.menuState) do
                    buttons.menuState[index]:pressed(x, y, player.radius)
                end
            elseif game.state['ended'] then
                for index in pairs(buttons.endedState) do
                    buttons.endedState[index]:pressed(x, y, player.radius)
                end
            end
        end
    end
end

function love.load()
    love.mouse.setVisible(false)

    buttons.menuState.playGame = button('Play Game', newGame, nil, 120, 40)
    buttons.menuState.quitGame = button('Quit', love.event.quit, nil, 120, 40)

    buttons.endedState.replayGame = button('Play Again', newGame, nil, 120, 40)
    buttons.endedState.menu = button('Menu', changeState, menu, 120, 40)
    buttons.endedState.quitGame = button('Quit', love.event.quit, nil, 120, 40)
end

function love.update(dt)
    player.x, player.y = love.mouse.getPosition()

    if game.state['running'] then
        for i = 1, #enemies do
            if not enemies[i]:checkTouched(player.x, player.y, player.radius) then
                enemies[i]:move(player.x, player.y)

                for j = 1, #game.levels do
                    if math.floor(game.points) == game.levels[i] then
                        table.insert(enemies, 1, enemy(game.difficulty * (i + 1)))

                        game.points = game.points + 1
                    end
                end
            else
                changeState('ended')
            end
        end
        game.points = game.points + dt
    end
end

function love.draw()
    love.graphics.setFont(fonts.small.font)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), fonts.small.font, 10, love.graphics.getHeight() - 30)

    if game.state['running'] then
        love.graphics.printf(math.floor(game.points), fonts.medium.font, 0, 10, love.graphics.getWidth(), 'center')
        love.graphics.circle('fill', player.x, player.y, player.radius)

        for i = 1, #enemies do
            enemies[i]:draw()
        end

    elseif game.state['menu'] then
        buttons.menuState.playGame:draw(10, 20, 17, 10)
        buttons.menuState.quitGame:draw(10, 70, 17, 10)
    elseif game.state['ended'] then
        buttons.endedState.replayGame:draw(10, 20, 17, 10)
        buttons.endedState.menu:draw(10, 70, 17, 10)
        buttons.endedState.quitGame:draw(10, 120, 17, 10)

        love.graphics.printf(math.floor(game.points), fonts.large.font, 0, love.graphics.getHeight() / 2 - fonts.large.size, love.graphics.getWidth(), 'center')
    end

    if not game.state['running'] then
        love.graphics.circle('fill', player.x, player.y, player.radius / 2)
    end
end