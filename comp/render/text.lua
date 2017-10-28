--text component: handles drawing text to the screen.

require "comp/render/renderable"

local text = class("text", renderable)

function text:initialize(args)
	renderable.initialize(self, args)
	self.type = "text"
	
	self.text = args.text or "undefined"
	
	self.font = love.graphics.getFont() or args.font
end

function text:draw()
	renderable.draw(self)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, self.x+self.ox, self.y+self.oy)
end

function text:getW()
	return self.font:getWidth(self.text)
end

function text:getH()
	return self.font:getHeight()
end

return text