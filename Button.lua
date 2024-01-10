function button(text, func, param, width, height)
    return {
        width = width,
        height = height,
        func = func,
        param = param,
        text = text,
        bottonX = 0,
        bottonY = 0,
        textX = 0,
        textY = 0,

        pressed = function(self, mouseX, mouseY, cursorRadius)
            if (mouseX + cursorRadius >= self.buttonX) and (mouseX + cursorRadius <= self.buttonX + self.width) then
                if (mouseY + cursorRadius >= self.buttonY) and (mouseY + cursorRadius <= self.buttonY + self.height) then
                    if self.param then
                        self.func(self.param)
                    else
                        self.func()
                    end
                end
            end
        end,

        draw = function(self, buttonX, buttonY, textX, textY)
            self.buttonX = buttonX
            self.buttonY = buttonY

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