local camera = require "libs/hump/camera"

local cameraManager = class("cameraManager")

function cameraManager:initialize(parent)
	self.cam = camera(100,100)
	self.target = nil
	
	self.x = self.cam.x; self.y = self.cam.y
	self.followSpeed = 3
	
	self.targetScale = 1
	self.cam.scale = self.targetScale
	self.scaleSpeed = 1
end

function cameraManager:update(dt)
	if self.target then
		self.x = self.x - (self.x - (self.target.x+self.targetOffset.x))*self.followSpeed*dt
		self.y = self.y - (self.y - (self.target.y+self.targetOffset.y))*self.followSpeed*dt
	end
	
	self.cam.scale = self.cam.scale - (self.cam.scale - self.targetScale)*self.scaleSpeed*dt
	
	self.cam:lookAt(math.floor(self.x), math.floor(self.y))
end

function cameraManager:setTarget(target, ox, oy)
	self.target = target
	self.targetOffset = {x=ox or 0, y=oy or 0}
end

function cameraManager:setTargetPos(x, y)
	self.target = {x=x, y=y}
end

function cameraManager:setPos(x, y)
	self.x = x; self.y = y
	self.cam:lookAt(self.x, self.y)
end

function cameraManager:setDimensions(w, h)
	--w and h are the new screen dimensions
end

function cameraManager:getDimensions()
	return {x=self.cam.x - love.graphics.getWidth()/2, y = self.cam.y - love.graphics.getHeight()/2,
		w = love.graphics.getWidth(), h = love.graphics.getHeight()}
end

function cameraManager:setFollowSpeed(speed)
	self.followSpeed = speed
end

function cameraManager:setTargetScale(scale)
	self.targetScale = scale
end

function cameraManager:setScale(scale)
	self.targetScale = scale
	self.cam.scale = scale
end

function cameraManager:getScale()
	return self.cam.scale
end

function cameraManager:worldPos(x, y)
	return self.cam:worldCoords(x, y)
end

return cameraManager