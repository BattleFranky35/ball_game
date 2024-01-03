function button(text, func, param, width, height)
    return {
        width = width or 100,
        height = height or 100,
        func = func or function() print("empty function") end,
        param = param,
        text = text or 'no text',
        bottonX = 0,
        bottonY = 0,
        textX = 0,
        textY = 0,

        draw = function(self, bottonX, bottonY, textX, textY)
            self.buttonX = buttonX or self.buttonX
            self.buttonY = buttonY or self.buttonY

            if textX then
                self.textX = textX + self.buttonX
            else
                self.textX =  self.buttonX
            end


            if textY then
                self.textY = textY + self.buttonY
            else
                self.textY = self.buttonY
            end


            love.graphics.setColor(235/255, 52/255, 222/255)
            love.graphics.rectangle('fill', self.buttonX, self.buttonY, self.width, self.height)

            love.graphics.setColor(0, 0, 0)
            love.graphics.print(self.text, self.textX, self.textY)

            love.graphics.setColor(1, 1, 1)
        end
    }
end

return Button