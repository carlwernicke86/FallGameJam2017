--rectangle component: handles drawing rectangles to the screen.

local renderable = require "comp/render/renderable"
local rectangle = class("rectangle", renderable)

function rectangle:initialize(args)
	renderable.initialize(self, args)
	self.type = "rectangle"
	
	self.w = args.w
	self.h = args.h
end

function rectangle:draw()
	renderable.draw(self)
	love.graphics.rectangle("fill", self.x+self.ox, self.y+self.oy, self.w, self.h)
end

function rectangle:getW()
	return self.w
end

function rectangle:getH()
	return self.h
end

return rectangle