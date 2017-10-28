--renderable: a base class for things that can be drawn to the screen.

local component = require "comp/component"
local renderable = class("renderable", component)

function renderable:initialize(args)
	component.initialize(self, args)
	self.type = "renderable"
	
	self.color = args.color or {r=255, g=255, b=255, a=255}
	
	self.x = args.x or 0; self.y = args.y or 0
	self.ox = args.ox or 0; self.oy = args.oy or 0 --offset
	
	if args.posParent then --a parent component to follow
		self:setPosParent(args.posParent, self.ox, self.oy)
	end
	
	self.drawLayer = args.drawLayer or "default"
end

function renderable:update(dt)
	if self.posParent then
		self.x = self.posParent.x; self.y = self.posParent.y
	end
end

function renderable:draw()
	if self.posParent then
		self.x = self.posParent.x; self.y = self.posParent.y
	end
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
end

function renderable:setPos(x, y)
	self.x = x; self.y = y
end

function renderable:getX()
	return self.x+self.ox
end

function renderable:getY()
	return self.y+self.oy
end

function renderable:setOffset(x, y)
	self.ox = x; self.oy = y
end

--set another component as this renderable's parent, so that it'll automatically match its position onscreen
function renderable:setPosParent(parent, ox, oy)
	self.posParent = parent
	self.ox = ox; self.oy = oy
end

function renderable:setDrawLayer(layer)
	self.drawLayer = layer
end

--set the color to draw with
function renderable:setColor(r, g, b)
	self.color = {r=r, g=g, b=b, a=self.color.a}
end

return renderable