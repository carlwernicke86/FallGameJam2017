--image component: handles drawing images to the screen.

local renderable = require "comp/render/renderable"

local image = class("image", renderable)

function image:initialize(args)
	renderable.initialize(self, args)
	self.type = "image"
	
	self.imgName = args.img
	self.img = getImg(args.img)
	
	self.w, self.h = self.img:getDimensions()
	
	--what we need to set quad:
	--xPos, yPos
	--width, height
	--tileWidth, tileHeight
	if args.quad ~= nil then
		local quad = args.quad
		self:setQuad(quad.xPos, quad.yPos, quad.w, quad.h, quad.tileWidth, quad.tileHeight)
	end

	self.animation = args.animation
	
end

function image:update(dt)
	renderable.update(self, dt)
	if self.animation then self.animation:update(dt) end
end

function image:setQuad(xPos, yPos, w, h, tileWidth, tileHeight)
	self.quad = love.graphics.newQuad((xPos-1)*tileWidth, (yPos-1)*tileHeight, w, h, self.img:getDimensions())
end

--draw the image
function image:draw()
	renderable.draw(self)
	local sx = 1; local sy = 1

	if self.animation then
		self.animation:draw(self.img, self.x+self.ox, self.y+self.oy, 0, sx, sy)
	else
		if self.quad ~= nil then
			love.graphics.draw(self.img, self.quad, math.floor(self.x+self.ox), math.floor(self.y+self.oy), 0, sx, sy)
		else
			love.graphics.draw(self.img, self.x+self.ox, self.y+self.oy, 0, sx, sy)
		end
	end
end

function image:getW()
	return self.w
end

function image:getH()
	return self.h
end

return image