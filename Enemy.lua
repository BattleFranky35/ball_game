function enemy()
    local dice = math.random(1, 4)
    local x
    local y
    local radius = 20

    if dice == 1 then
        x = math.random(radius, love.graphics.getWidth())
        y = -radius * 4
    elseif dice == 2 then
        x = -radius * 4
        y = math.random(radius, love.graphics.getHeight())
    elseif dice == 3 then
        x = math.random(radius, love.graphics.getWidth())
        y = (radius * 4) + love.graphics.getHeight()
    elseif dice == 4 then
        x = (radius * 4) + love.graphics.getWidth()
        y = math.random(radius, love.graphics.getHeight())
    end

    return {
        level = 1,
        radius = radius,
        x = x,
        y = y,

        move = function(self, playerX, playerY)
            if playerX - self.x > 0 then
                self.x = self.x + self.level
            elseif playerX - self.x < 0 then
                self.x = self.x - self.level
            end

            if playerY - self.y > 0 then
                self.y = self.y + self.level
            elseif playerY - self.y < 0 then
                self.y = self.y - self.level
            end
        end,

        draw = function(self)
            love.graphics.setColor(1, 0, 0)
            love.graphics.circle('fill', self.x, self.y, self.radius)
            love.graphics.setColor(1, 1, 1)
        end
    }
end

return Enemy